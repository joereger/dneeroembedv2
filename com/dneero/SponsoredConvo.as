package com.dneero
{
	
	import flash.display.MovieClip;
	import fl.containers.ScrollPane;
	import flash.events.Event;
	import flash.display.Stage;
	import fl.controls.CheckBox;
    import fl.controls.ScrollPolicy;
    import fl.controls.TextArea;
	import flash.text.TextFieldAutoSize;
	import flash.display.StageScaleMode;


	
	public class SponsoredConvo extends MovieClip {
		
		public var sponsoredConvo_txt;
		public var sponsoredConvoBg;
		
		public function SponsoredConvo(){
			//trace("SponsoredConvo instanciated");
			if (stage) {initListener(null);} else {addEventListener(Event.ADDED_TO_STAGE, initListener);}
		}
		
		function initListener (e:Event):void {
			//trace("SponsoredConvo.initListener() called");
			removeEventListener(Event.ADDED_TO_STAGE, initListener);
			sponsoredConvo_txt.wordWrap = true;
			sponsoredConvo_txt.autoSize = TextFieldAutoSize.LEFT;
			sponsoredConvo_txt.text = "This is a Sponsored Conversation";
		}
		
		

		public function resize(maxWidth:Number, maxHeight:Number):void {
			//trace("SponsoredConvo -- RESIZE -- maxWidth="+maxWidth+" maxHeight="+maxHeight);
			sponsoredConvo_txt.width = maxHeight;
			sponsoredConvoBg.height = maxHeight;
		}
		
		
	
		
	}
	
	
}