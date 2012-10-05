package com.dneero.answerspanel
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


	
	public class QTOption extends MovieClip {
		
		public var option_txt;
		private var option:String;
		private var isOn:Boolean = false;
		private var selectedIndicator;
		
		public function QTOption(option:String, isOn:Boolean){
			//trace("QTOption instanciated");
			if (stage) {initListener(null);} else {addEventListener(Event.ADDED_TO_STAGE, initListener);}
			this.option = option;
			this.isOn = isOn;
		}
		
		function initListener (e:Event):void {
			//trace("QTOption.initListener() called");
			removeEventListener(Event.ADDED_TO_STAGE, initListener);
			option_txt.wordWrap = true;
			option_txt.autoSize = TextFieldAutoSize.LEFT;
			option_txt.htmlText = option;
			addChild(option_txt);
			if (isOn){
				selectedIndicator = new QTOptionOn();
			} else {
				selectedIndicator = new QTOptionOff();
			}
			addChild(selectedIndicator);
			selectedIndicator.x = 0;
			selectedIndicator.y = 0;
		}
		
		

		public function resize (maxWidth:Number, maxHeight:Number):void {
			//trace("QTOption -- RESIZE -- maxWidth="+maxWidth+" maxHeight="+maxHeight);
			option_txt.width = maxWidth - 30;
//			trace("QTOption -- answer_txt.text="+answer_txt.text);
//			trace("QTOption -- answer_txt.width="+answer_txt.width);
//			trace("QTOption -- answer_txt.height="+answer_txt.height);
//			trace("QTOption -- answer_txt.x="+answer_txt.x);
//			trace("QTOption -- answer_txt.y="+answer_txt.y);
		}
		
		
	
		
	}
	
	
}