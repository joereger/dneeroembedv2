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


	
	public class QTEssay extends MovieClip implements QuestionType {
		
		private var questionid:int;
		public var answer_txt;
		private var questionXML:XML;

		
		public function QTEssay(questionXML:XML){
			//trace("QTEssay instanciated");
			if (stage) {initListener(null);} else {addEventListener(Event.ADDED_TO_STAGE, initListener);}
		    this.questionXML = questionXML;
			//this.questionid = questionXML.attribute("questionid");
			
		}
		
		function initListener (e:Event):void {
			//trace("QTEssay.initListener() called");
			removeEventListener(Event.ADDED_TO_STAGE, initListener);
			answer_txt.wordWrap = true;
			answer_txt.autoSize = TextFieldAutoSize.LEFT;
			answer_txt.htmlText = questionXML.answer.text();
			addChild(answer_txt);
		}
		
		

		public function resize (maxWidth:Number, maxHeight:Number):void {
			//trace("QTEssay -- RESIZE -- maxWidth="+maxWidth+" maxHeight="+maxHeight);
			answer_txt.width = maxWidth;
//			trace("QTEssay -- answer_txt.text="+answer_txt.text);
//			trace("QTEssay -- answer_txt.width="+answer_txt.width);
//			trace("QTEssay -- answer_txt.height="+answer_txt.height);
//			trace("QTEssay -- answer_txt.x="+answer_txt.x);
//			trace("QTEssay -- answer_txt.y="+answer_txt.y);
		}
		
		
		
		public function getQuestionid():int{
			return questionid;
		}
		
	}
	
	
}