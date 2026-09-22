package com.example.autoclickmobileapp.accessibility

import android.accessibilityservice.AccessibilityService
import android.accessibilityservice.AccessibilityServiceInfo
import android.content.Intent
import android.util.Log
import android.view.accessibility.AccessibilityEvent
import android.view.accessibility.AccessibilityNodeInfo

class AutoClickAccessibilityService : AccessibilityService() {
    companion object {
        private const val TAG = "AutoClickAccessibilityService"
        private var instance: AutoClickAccessibilityService? = null

        fun isRunning(): Boolean = instance != null
    }

    override fun onServiceConnected() {
        super.onServiceConnected()
        instance = this
        Log.d(TAG, "Accessibility service connected")
    }

    override fun onInterrupt() {
        Log.w(TAG, "Accessibility service interrupted")
        instance = null
    }

    override fun onUnbind(intent: Intent?): Boolean {
        Log.w(TAG, "Accessibility service unbound")
        instance = null
        return super.onUnbind(intent)
    }

    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        if (event == null) return
        when (event.eventType) {
            AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED,
            AccessibilityEvent.TYPE_VIEW_CLICKED,
            AccessibilityEvent.TYPE_VIEW_TEXT_CHANGED -> {
                // Only light event handling is intentionally kept here.
            }
            else -> Unit
        }
    }

    fun dispatchTap(x: Int, y: Int): Boolean {
        val rootNode = rootInActiveWindow ?: return false
        val target = findClickableNodeAt(rootNode, x, y)
        return if (target != null) {
            target.performAction(AccessibilityNodeInfo.ACTION_CLICK)
        } else {
            false
        }
    }

    private fun findClickableNodeAt(root: AccessibilityNodeInfo, x: Int, y: Int): AccessibilityNodeInfo? {
        val queue = ArrayDeque<AccessibilityNodeInfo>()
        queue.add(root)

        while (queue.isNotEmpty()) {
            val node = queue.removeFirst()
            if (node.isClickable && node.boundsInScreen != null) {
                val bounds = node.boundsInScreen
                if (bounds.left <= x && x <= bounds.right && bounds.top <= y && y <= bounds.bottom) {
                    return node
                }
            }
            for (i in 0 until node.childCount) {
                val child = node.getChild(i) ?: continue
                queue.add(child)
            }
        }
        return null
    }

    override fun onDestroy() {
        instance = null
        super.onDestroy()
    }

    fun serviceInfo(): AccessibilityServiceInfo {
        return AccessibilityServiceInfo().apply {
            eventTypes = AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED or AccessibilityEvent.TYPE_VIEW_CLICKED
            feedbackType = AccessibilityServiceInfo.FEEDBACK_GENERIC
            flags = AccessibilityServiceInfo.FLAG_RETRIEVE_INTERACTIVE_WINDOWS
            packageNames = null
        }
    }
}
