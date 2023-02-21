package com.example.banner_example

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import com.example.banner_example.databinding.FragmentSingleViewBinding
import com.example.banner_example.AppConstants
import net.nativo.sdk.NativoSDK
import net.nativo.sdk.NtvAdData
import net.nativo.sdk.NtvSectionAdapter
import net.nativo.sdk.injectable.NtvInjectable
import net.nativo.sdk.injectable.NtvInjectableType

class SingleViewFragment : Fragment(), NtvSectionAdapter {

    private val singleViewSectionUrl = AppConstants.SECTION_URL+"?singleview"
    private lateinit var binding: FragmentSingleViewBinding
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentSingleViewBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        // This initializes the NativoSDK and starts prefetching ads for your section URL
        NativoSDK.initSectionWithAdapter(this, singleViewSectionUrl, this.requireContext())

        // To load a new ad we simply clear ads and then make a prefetch request
        binding.loadAd.setOnClickListener {
            NativoSDK.clearAds(singleViewSectionUrl, binding.root)
            NativoSDK.prefetchAdForSection(singleViewSectionUrl)
        }
    }

    /**
     * Nativo Section Adapter Interface
     */

    override fun didReceiveAd(didGetFill: Boolean, inSection: String) {
        if (didGetFill) {
            NativoSDK.placeAdInView(binding.articleContainer, binding.root, singleViewSectionUrl, 0)
        }
    }

    override fun didAssignAdToLocation(location: Int, adData: NtvAdData, inSection: String, container: ViewGroup) {
    }

    override fun didFailAd(inSection: String, atLocation: Int?, inView: View?, container: ViewGroup?, error: Throwable?) {
        Log.d(AppConstants.NtvTAG, "onFail at location: $atLocation Error: $error")
        binding.articleContainer.visibility = View.INVISIBLE
    }

    override fun didPlaceAdInView(view: View, adData: NtvAdData, injectable: NtvInjectable, atLocation: Int, inSection: String, container: ViewGroup) {
    }

    override fun needsDisplayClickOutURL(url: String, inSection: String, container: ViewGroup) {
        this.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)))
    }

    override fun needsDisplayLandingPage(landingPageIntent: Intent, inSection: String, container: ViewGroup) {
        this.startActivity(landingPageIntent)
    }

    override fun <T : NtvInjectable> registerInjectableClassForTemplateType(
        injectableType: NtvInjectableType,
        atLocation: Int?,
        inSection: String?
    ): Class<T>? {
        return null
    }
}