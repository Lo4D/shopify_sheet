package com.checkoutsheetshopify.shopify_sheet

import android.app.Activity
import com.shopify.checkoutsheetkit.ShopifyCheckoutSheetKit
import com.shopify.checkoutsheetkit.DefaultCheckoutEventProcessor
import com.shopify.checkoutsheetkit.lifecycleevents.CheckoutCompletedEvent
import com.shopify.checkoutsheetkit.CheckoutException
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.EventChannel
import com.shopify.checkoutsheetkit.CheckoutSheetKitDialog
import com.shopify.checkoutsheetkit.ColorScheme
import kotlinx.serialization.json.*

/** ShopifySheetPlugin */
class ShopifySheetPlugin : FlutterPlugin, MethodChannel.MethodCallHandler, ActivityAware {

    private lateinit var methodChannel: MethodChannel
    private lateinit var eventChannel: EventChannel
    private var activity: Activity? = null
    private var eventSink: EventChannel.EventSink? = null
    private var checkoutSheet: CheckoutSheetKitDialog? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        methodChannel = MethodChannel(flutterPluginBinding.binaryMessenger, "shopify_sheet")
        methodChannel.setMethodCallHandler(this)

        eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "shopify_sheet_events")
        eventChannel.setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                eventSink = events
            }

            override fun onCancel(arguments: Any?) {
                eventSink = null
            }
        })
    }

    override fun onDetachedFromEngine( binding: FlutterPlugin.FlutterPluginBinding) {
        methodChannel.setMethodCallHandler(null)
        eventChannel.setStreamHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "launchCheckout" -> {
                val checkoutUrl = call.argument<String>("checkoutUrl")
                val colorScheme = call.argument<String>("colorScheme")
                if (checkoutUrl != null) {
                    ShopifyCheckoutSheetKit.configure {
                        when(colorScheme) {
                            "automatic" -> {
                                it.colorScheme = ColorScheme.Automatic()
                            }
                            "light" -> {
                                it.colorScheme = ColorScheme.Light()
                            }
                            "dark" -> {
                                it.colorScheme = ColorScheme.Dark()
                            }
                            "web" -> {
                                it.colorScheme = ColorScheme.Web()
                            }
                        }
                    }
                    launchCheckout(checkoutUrl, result)
                } else {
                    result.error("INVALID_ARGUMENTS", "Checkout URL is null", null)
                }
            }

            "closeCheckout" -> {
                closeCheckout(result)
            }

            else -> result.notImplemented()
        }
    }

    private fun launchCheckout(checkoutUrl: String, result: MethodChannel.Result) {
        val currentActivity = activity
        if (currentActivity is androidx.activity.ComponentActivity) {
            try {
                checkoutSheet = ShopifyCheckoutSheetKit.present(checkoutUrl,
                    currentActivity,
                    object : DefaultCheckoutEventProcessor(currentActivity) {
                        override fun onCheckoutCanceled() {
                            eventSink?.success(
                                mapOf(
                                    "event" to "canceled", "error" to null // No error for canceled
                                )
                            )
                        }

                        override fun onCheckoutCompleted(checkoutCompletedEvent: CheckoutCompletedEvent) {
                            val eventJson = Json.encodeToJsonElement(checkoutCompletedEvent) as JsonObject?
                            val eventJsonMap = eventJson?.toPrimitiveMap()
                            eventSink?.success(
                                mapOf(
                                    "event" to "completed",
                                    "data" to eventJsonMap,
                                    "error" to null // No error for successful completion
                                )
                            )
                        }

                        override fun onCheckoutFailed(error: CheckoutException) {
                            eventSink?.success(
                                mapOf(
                                    "event" to "failed",
                                    "error" to error.message // Pass error message
                                )
                            )
                        }
                    })
                result.success("Checkout Launched")
            } catch (e: Exception) {
                result.error("CHECKOUT_ERROR", "Error launching checkout", e.message)
            }
        } else {
            result.error(
                "INVALID_CONTEXT",
                "Activity is not a ComponentActivity. Actual: ${currentActivity?.javaClass?.name}",
                null
            )
        }
    }

    private fun closeCheckout(result: MethodChannel.Result) {
        checkoutSheet?.dismiss()
        checkoutSheet = null
        result.success("Checkout Closed")
    }

    // Handle activity lifecycle
    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        activity = null
    }
}

// Helper extension function to convert a JsonElement tree into platform channel compatible types
fun JsonElement.toPrimitiveMap(): Map<String, Any?> {
    return this.jsonObject.entries.associate { (key, value) ->
        key to value.toAny()
    }
}

@Suppress("UNCHECKED_CAST")
fun JsonElement.toAny(): Any? {
    return when (this) {
        is JsonPrimitive -> {
            if (this.isString) this.content
            else this.content.toBooleanStrictOrNull() ?: this.content.toIntOrNull() ?: this.content.toLongOrNull() ?: this.content.toDoubleOrNull() ?: this.content
        }
        is JsonObject -> this.toPrimitiveMap()
        is JsonArray -> this.map { it.toAny() }
    }
}