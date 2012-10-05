package com.dneero.answerspanel
{
	
	import flash.display.MovieClip;
	import fl.containers.ScrollPane;
	import flash.events.Event;
	import flash.display.Stage;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import com.dneero.UrlParams;
	
	//This class loads questions and answer objects onto the stage
	
	public class AnswersPanelListOfQuestionsAndAnswers extends MovieClip {
		
		private var maxWidth:Number = 0;
		private var maxHeight:Number = 0;
		private var scrollPane:ScrollPane;
		private var spacingBetweenQuestions:Number = 5;
		private var questionsAndAnswers_array:Array;
		//private var urlParams:UrlParams;
		private var xmlData:XML = new XML();
		
		
		public function AnswersPanelListOfQuestionsAndAnswers(xmlData:XML){
			//trace("AnswersPanelListOfQuestionsAndAnswers instanciated");
			if (stage) {initListener(null);} else {addEventListener(Event.ADDED_TO_STAGE, initListener);}
			//this.urlParams = urlParams;
			this.xmlData = xmlData;
			
		}
		
		function initListener (e:Event):void {
			//trace("AnswersPanelListOfQuestionsAndAnswers.initListener() called");
			removeEventListener(Event.ADDED_TO_STAGE, initListener);
			
//			var questionid = 1;
//			var question = "Why is the sky blue?";
//			var options:Array = new Array("a", "b", "c");
//			var checkedoptions:Array = new Array("b");
//			questionsAndAnswers_array = new Array();
//			var currentHeight:Number = 0;
//			for (var i:Number = 0; i < 11; i++) {
//				var answer:QuestionType = new QTCheckboxes(null);
//				var questionAndAnswer:QuestionAndAnswer = questionAndAnswer = new QuestionAndAnswer(null, answer);
//				addChild(questionAndAnswer);
//				questionAndAnswer.x = 0;
//				questionAndAnswer.y = currentHeight;
//				questionsAndAnswers_array.push(questionAndAnswer);
//				currentHeight = currentHeight + questionAndAnswer.height + spacingBetweenQuestions;
//			}
			
			

			questionsAndAnswers_array = new Array();
			var currentHeight:Number = 0;
			var questionList:XMLList  = xmlData.question;
			for each (var question:XML in questionList) {
				//trace(question);
				//trace("question.attribute(type)="+question.attribute("type"));
				//trace("question.question.text()="+question.question.text());
				var type:String = question.attribute("type");
				//Here's where factory goes
				var answer:QuestionType;
				if (type=="checkboxes"){
					answer = new QTCheckboxes(question);
				} else if (type=="essay"){
					answer = new QTEssay(question);
				} else if (type=="dropdown"){
					answer = new QTDropdown(question);
				} else if (type=="matrix"){
					answer = new QTMatrix(question);
				} else if (type=="range"){
					answer = new QTRange(question);
				} else if (type=="textbox"){
					answer = new QTTextbox(question);
				} else if (type=="infotext"){
					answer = new QTInfotext(question);
				} else if (type=="testquestion"){
					answer = null;
				} else {
					answer = null;
					trace("AnswersPanelListOfQuestionsAndAnswers.as - question.attribute(type) is unknown: "+type);
				}
				if (answer!=null){
					var questionAndAnswer:QuestionAndAnswer = questionAndAnswer = new QuestionAndAnswer(question, answer);
					addChild(questionAndAnswer);
					questionAndAnswer.x = 0;
					questionAndAnswer.y = currentHeight;
					//trace("questionAndAnswer.y="+questionAndAnswer.y);
					questionsAndAnswers_array.push(questionAndAnswer);
					currentHeight = currentHeight + questionAndAnswer.height + spacingBetweenQuestions;
				} else {
					trace("AnswersPanelListOfQuestionsAndAnswers.as - answer==null");
				}
			}
			
			
			
		}
	
		
		public function resizeUsingPrevious():void {
			trace("AnswersPanelListOfQuestionsAndAnswers -- RESIZEUSINGPREVIOUS()");
			resize(maxWidth, maxHeight);
		}
		

		public function resize (maxWidth:Number, maxHeight:Number):void {
			//trace("AnswersPanelListOfQuestionsAndAnswers -- RESIZE -- maxWidth=" + maxWidth + " maxHeight=" + maxHeight);
			//trace("AnswersPanelListOfQuestionsAndAnswers -- resize() start -- this.width=" + this.width + " this.height=" + this.height);
			this.maxWidth = maxWidth;
			this.maxHeight = maxHeight;
			var currentHeight:Number = 0;
			var maxwidthseen = 0;
			for each(var questionAndAnswer:QuestionAndAnswer in questionsAndAnswers_array) {
				//trace("AnswersPanelListOfQuestionsAndAnswers -- resize() start of question -- this.width=" + this.width + " this.height=" + this.height);
      			questionAndAnswer.x = 0;
				questionAndAnswer.y = currentHeight;
				questionAndAnswer.resize(maxWidth, 999999);
				//trace("AnswersPanelListOfQuestionsAndAnswers -- resize() middle of question -- questionAndAnswer.question_txt="+questionAndAnswer.getQuestionXML().question.text()+" questionAndAnswer.width="+questionAndAnswer.width+" questionAndAnswer.x="+questionAndAnswer.x+" questionAndAnswer.y="+questionAndAnswer.y+" questionAndAnswer.width="+questionAndAnswer.width+" questionAndAnswer.height="+questionAndAnswer.height);
				currentHeight = currentHeight + questionAndAnswer.height + spacingBetweenQuestions;
				if (questionAndAnswer.width>0 && questionAndAnswer.width>maxwidthseen){
					maxwidthseen = questionAndAnswer.width;
					//trace("AnswersPanelListOfQuestionsAndAnswers -- resize() questionAndAnswer.width>maxwidthseen setting maxwidthseen="+maxwidthseen+" -- this.width=" + this.width + " this.height=" + this.height);
				} else {
					//trace("AnswersPanelListOfQuestionsAndAnswers -- resize() questionAndAnswer.width<=maxwidthseen -- this.width=" + this.width + " this.height=" + this.height);
				}
				//trace("AnswersPanelListOfQuestionsAndAnswers -- resize() end of question -- this.width=" + this.width + " this.height=" + this.height);
      		}
			//trace("AnswersPanelListOfQuestionsAndAnswers -- resize() bottom -- maxwidthseen="+maxwidthseen+" this.width=" + this.width + " this.height=" + this.height + " maxwidthseen="+maxwidthseen);
			this.height = currentHeight;
			this.width = maxwidthseen;
			if (this.width<=0){
				this.width = (-1)* maxWidth;
				//trace("AnswersPanelListOfQuestionsAndAnswers -- resize() this.width<=0 so setting this.width="+maxWidth+" -- this.width=" + this.width + " this.height=" + this.height);
			}
			//trace("AnswersPanelListOfQuestionsAndAnswers -- resize() end -- this.width=" + this.width + " this.height=" + this.height);
		}
		
	
		
	}
	
	
}