package com.dneero
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.StageDisplayState;
	import flash.text.TextFieldAutoSize;
	
	public class TitleBar extends MovieClip {
		
		public var titleBarBg_mc:TitleBarBg;
		public var title_txt;
		private var surveyXML:XML;
		
		
		public function TitleBar(surveyXML:XML){
			trace("TitleBar instanciated");
			if (stage) {initListener(null);} else {addEventListener(Event.ADDED_TO_STAGE, initListener);}
			this.surveyXML = surveyXML;
		}
		
		function initListener (e:Event):void {
			trace("TitleBar.initListener() called");
			removeEventListener(Event.ADDED_TO_STAGE, initListener);
			if (surveyXML!=null){
				title_txt.htmlText = surveyXML.title.text();
				title_txt.wordWrap = true;
				title_txt.autoSize = TextFieldAutoSize.LEFT;
			}
		}
		
		

		public function resize(maxWidth:Number, maxHeight:Number):void {
			//trace("TitleBar -- RESIZE -- maxWidth="+maxWidth+" maxHeight="+maxHeight);
			title_txt.width = maxWidth - 5;
			titleBarBg_mc.width = maxWidth;
			titleBarBg_mc.height = title_txt.textHeight + 5;
			if (titleBarBg_mc.height<35){
				titleBarBg_mc.height = 35;
			}
			//this.x = 0;
			//this.y = 0;
		}
		

	
		
	}
	
	
}