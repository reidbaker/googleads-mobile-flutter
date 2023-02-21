package com.example.banner_example

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

import android.content.SharedPreferences
import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentActivity
import androidx.preference.PreferenceManager
// import androidx.viewpager2.adapter.FragmentStateAdapter
import com.example.banner_example.StandardDisplayAd
import com.example.banner_example.R
// import com.example.banner_example.ViewFragment.*
// import com.example.banner_example.databinding.ActivityMainBinding
import com.example.banner_example.AppConstants
import net.nativo.sdk.NativoSDK
import dev.flutter.example.NativeViewFactory

class MainActivity: FlutterActivity() {

    // private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Nativo Setup
        NativoSDK.enableDevLogs()
        // NativoSDK.registerClassForNativeAd(NativeAd::class.java)
        // NativoSDK.registerClassForVideoAd(NativeVideoAd::class.java)
        NativoSDK.registerClassForStandardDisplayAd(StandardDisplayAd::class.java)

        // binding = ActivityMainBinding.inflate(layoutInflater)
        // setContentView(binding.root)
        // binding.pager.apply {
        //     adapter = FragmentViewAdapter(this@MainActivity)
        //     isUserInputEnabled = false
        // }

        // TabLayoutMediator(binding.tabs, binding.pager) { tab, _ ->
        //     tab.setText(R.string.single_view,)
        // }.attach()
        setPrivacyAndTransparencyKeys();
    }
    // private inner class FragmentViewAdapter(activity: FragmentActivity) : FragmentStateAdapter(activity) {

    //     override fun getItemCount(): Int {
    //         return 1
    //     }

    //     override fun createFragment(position: Int): Fragment {
    //         return SingleViewFragment()
    //     }

    // }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngine
                .platformViewsController
                .registry
                .registerViewFactory("<platform-view-type>", NativeViewFactory())
    }

    private val editor: SharedPreferences.Editor
    get() {
        val preferenceManager = PreferenceManager.getDefaultSharedPreferences(this)
        return preferenceManager.edit()
    }

    private fun setPrivacyAndTransparencyKeys() {
        val editor = editor
        editor.putString(AppConstants.GDPR_SHARED_PREFERENCE_STRING, AppConstants.SAMPLE_GDPR_CONSENT)
        editor.putString(AppConstants.CCPA_SHARED_PREFERENCE_STRING, AppConstants.SAMPLE_CCPA_VALID_CONSENT)
        editor.apply()
    }

}
