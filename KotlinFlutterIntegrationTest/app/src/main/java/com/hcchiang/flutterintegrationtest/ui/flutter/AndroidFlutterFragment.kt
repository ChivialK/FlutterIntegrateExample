package com.hcchiang.flutterintegrationtest.ui.flutter

import android.os.Bundle
import android.os.CountDownTimer
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.*
import androidx.fragment.app.Fragment
import com.hcchiang.flutterintegrationtest.FlutterIntegrateApp
import com.hcchiang.flutterintegrationtest.R
import io.flutter.embedding.android.FlutterFragment

/**
 * Android page for Flutter Module [FlutterIntegrateActivity] and test Flutter channel
 * [FlutterIntegrateMethodChannel]. Cache Engine and channel were initialized in [FlutterIntegrateApp].
 *
 * Click btn_flutter to start FlutterActivity.
 * [FlutterFragment] is shown in flutter_fragment_container.
 */
class AndroidFlutterFragment : Fragment(), IFlutterChannelListener {

    private var tvMessage: TextView? = null
    private var editMessage: EditText? = null
    private var btnSend: ImageButton? = null

    private var cdTimer: CountDownTimer? = null

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_flutter_screen, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        tvMessage = view.findViewById(R.id.tv_message)
        editMessage = view.findViewById(R.id.edit_message)
        btnSend = view.findViewById(R.id.btn_send)
        btnSend?.setOnClickListener {
            val msg = editMessage?.text?.toString()
            if (msg != null) FlutterIntegrateMethodChannel.instance?.send(msg)
        }

        /**
         * Code for Flutter Activity
         */
        view.findViewById<Button>(R.id.btn_flutter).setOnClickListener {
            // Start up with new engine
//            FlutterIntegrateActivity.start(requireContext())

            // Start with cached engine
            FlutterIntegrateActivity.start(requireContext(), FlutterIntegrateApp.FLUTTER_ENGINE_ID)
        }
    }

    /**
     * Code below is for Flutter Fragment
     */
    private var flutterFragment: FlutterFragment? = null

    override fun onViewStateRestored(savedInstanceState: Bundle?) {
        super.onViewStateRestored(savedInstanceState)
        // Try to recover fragment if still exists
        flutterFragment =
            childFragmentManager.findFragmentByTag(FLUTTER_FRAGMENT_TAG) as FlutterFragment?

        if (flutterFragment == null) {
            // Create Fragment with new engine (need to setup FlutterIntegrateChannel)
//            val newFlutterFragment = FlutterFragment.createDefault()

            // Create Fragment with cached engine
            val newFlutterFragment = FlutterFragment
                .withCachedEngine(FlutterIntegrateApp.FLUTTER_ENGINE_ID)
                .shouldAttachEngineToActivity(true)
                .build() as FlutterFragment

            flutterFragment = newFlutterFragment
            childFragmentManager.beginTransaction()
                .add(R.id.flutter_fragment_container, newFlutterFragment, FLUTTER_FRAGMENT_TAG)
                .commit()
        }

        FlutterIntegrateMethodChannel.instance?.setChannelListener(this)
        FlutterIntegrateBasicChannel.instance?.setChannelListener(this)
        FlutterIntegrateEventChannel.instance?.setChannelListener(this)

        tvMessage?.setOnClickListener{
            FlutterIntegrateBasicChannel.instance?.send("Hi, Basic!", null)
        }

        countdown()
    }

    override fun onPause() {
        FlutterIntegrateMethodChannel.instance?.removeChannelListener()
        FlutterIntegrateBasicChannel.instance?.removeChannelListener()
        FlutterIntegrateEventChannel.instance?.removeChannelListener()
        super.onPause()
    }

    override fun fromFlutterMethod(message: String) {
        println("AndroidFlutterFragment fromFlutterMethod: $message")

        val msg = "method: $message"
        tvMessage?.text = msg
    }

    override fun fromFlutterBasic(message: String): String {
        println("AndroidFlutterFragment fromFlutterBasic: $message")

        val msg = "basic: $message"
        tvMessage?.text = msg

        if (message == "reset")
            return countdown().toString()

        return ""
    }

    private fun countdown(): Boolean {
        return try {
            cdTimer?.cancel()
            cdTimer = null
            cdTimer = object : CountDownTimer(15000, 1000) {
                override fun onFinish() {
                    FlutterIntegrateEventChannel.instance?.cancel()
                }
                override fun onTick(millisUntilFinished: Long) {
                    FlutterIntegrateEventChannel.instance?.sink("${millisUntilFinished/1000}")
                }
            }.start()
            true
        } catch (e: Exception) {
            false
        }
    }

    companion object {
        // Define a tag String to represent the FlutterFragment within this
        // Activity's FragmentManager. This value can be whatever you'd like.
        private const val FLUTTER_FRAGMENT_TAG = "newIntegrateFragment"
    }
}
