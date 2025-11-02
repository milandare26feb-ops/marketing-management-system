package com.confidencefeed.markettrack

import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage

class MyFirebaseMessagingService : FirebaseMessagingService() {

    override fun onMessageReceived(remoteMessage: RemoteMessage) {
        // Handle FCM messages here.
        // Not getting messages here? See why this may be: https://goo.gl/39bRNJ
        println("From: ${remoteMessage.from}")

        // Check if message contains a data payload.
        if (remoteMessage.data.isNotEmpty()) {
            println("Message data payload: " + remoteMessage.data)
        }

        // Check if message contains a notification payload.
        remoteMessage.notification?.let {
            println("Message Notification Body: ${it.body}")
        }
    }

    override fun onNewToken(token: String) {
        println("Refreshed token: $token")
        // If you want to send messages to this application instance or
        // manage this apps subscriptions on the server side, send the
        // FCM registration token to your app server.
    }
}
