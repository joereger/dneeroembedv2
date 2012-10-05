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


	
	public class QTTextbox extends MovieClip implements QuestionType {
		
		private var questionid:int;
		public var answer_txt;
		private var questionXML:XML;

		
		public function QTTextbox(questionXML:XML){
			//trace("QTTextbox instanciated");
			if (stage) {initListener(null);} else {addEventListener(Event.ADDED_TO_STAGE, initListener);}
		    this.questionXML = questionXML;
			//this.questionid = questionXML.attribute("questionid");
			
		}
		
		function initListener (e:Event):void {
			//trace("QTTextbox.initListener() called");
			removeEventListener(Event.ADDED_TO_STAGE, initListener);
			answer_txt.wordWrap = true;
			answer_txt.autoSize = TextFieldAutoSize.LEFT;
			answer_txt.htmlText = questionXML.answer.text();
			addChild(answer_txt);
		}
		
		

		public function resize (maxWidth:Number, maxHeight:Number):void {
			//trace("QTTextbox -- RESIZE -- maxWidth="+maxWidth+" maxHeight="+maxHeight);
			answer_txt.width = maxWidth;
//			trace("QTTextbox -- answer_txt.text="+answer_txt.text);
//			trace("QTTextbox -- answer_txt.width="+answer_txt.width);
//			trace("QTTextbox -- answer_txt.height="+answer_txt.height);
//			trace("QTTextbox -- answer_txt.x="+answer_txt.x);
//			trace("QTTextbox -- answer_txt.y="+answer_txt.y);
		}
		
		
		
		public function getQuestionid():int{
			return questionid;
		}
		
	}
	
	
}