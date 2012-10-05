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
	import com.dneero.answerspanel.QTOption;


	
	public class QTInfotext extends MovieClip implements QuestionType {
		
		private var questionid:int;
		private var questionXML:XML;
		public var infotext_txt;
		

		
		public function QTInfotext(questionXML:XML){
			trace("QTInfotext instanciated");
			if (stage) {initListener(null);} else {addEventListener(Event.ADDED_TO_STAGE, initListener);}
		    this.questionXML = questionXML;
			this.questionid = questionXML.attribute("questionid");
		}
		
		function initListener (e:Event):void {
			trace("QTInfotext.initListener() called");
			trace("QTInfotext questionXML.infotext.text()="+questionXML.infotext.text());
			removeEventListener(Event.ADDED_TO_STAGE, initListener);
			infotext_txt.wordWrap = true;
			infotext_txt.autoSize = TextFieldAutoSize.LEFT;
			infotext_txt.htmlText = questionXML.infotext.text();
			addChild(infotext_txt);
		}
		
		

		public function resize (maxWidth:Number, maxHeight:Number):void {
			trace("QTInfotext -- RESIZE -- maxWidth="+maxWidth+" maxHeight="+maxHeight);
			infotext_txt.width = maxWidth;
		}
		
		
		
		public function getQuestionid():int{
			return questionid;
		}
		
		
		
	}
	
	
}