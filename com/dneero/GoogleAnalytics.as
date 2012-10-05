package com.dneero {
	
	import com.google.analytics.AnalyticsTracker; 
	import com.google.analytics.GATracker; 
	import flash.display.MovieClip;

	
	public class GoogleAnalytics extends MovieClip {
		
		private var googleanalyticsidflash:String;
		private var virtualpagename:String;
		
		public function GoogleAnalytics(googleanalyticsidflash:String="UA-208946-15", virtualpagename:String="NA"):void {
			this.googleanalyticsidflash = googleanalyticsidflash;
			this.virtualpagename = virtualpagename;
		}
		
		public function track():void {
			try {
				trace("GoogleAnalytics.track() googleanalyticsidflash=" + googleanalyticsidflash + " virtualpagename=" + virtualpagename);
				if (googleanalyticsidflash == null) { googleanalyticsidflash = "UA-208946-15"; }
				if (virtualpagename == null) { virtualpagename = "NA"; }
				var tracker:AnalyticsTracker = new GATracker( this, googleanalyticsidflash, "AS3", false ); 
				tracker.trackPageview(virtualpagename);
			} catch (error:Error) {
				trace("GoogleAnalytics.trace() error="+error.toString());
			}
		}
		
	}

}