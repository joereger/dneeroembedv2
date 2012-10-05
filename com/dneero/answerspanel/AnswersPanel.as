package com.dneero.answerspanel
{
	
	import flash.display.MovieClip;
	import fl.containers.ScrollPane;
	import flash.events.Event;
	import flash.display.Stage;
	import com.dneero.UrlParams;
	import com.dneero.SponsoredConvo;
	
	//This class wraps a list of questions and answers with a scroll bar.
	
	public class AnswersPanel extends MovieClip {
		
		private var scrollPane:ScrollPane;
		private var answer:QuestionType;
		private var questionAndAnswer:QuestionAndAnswer;
		private var answer2:QuestionType;
		private var questionAndAnswer2:QuestionAndAnswer;
		private var answersPanelListOfQuestionsAndAnswers:AnswersPanelListOfQuestionsAndAnswers;
		//private var urlParams:UrlParams;
		private var xmlData:XML = new XML();
		private var maxWidth:Number = 425;
		private var maxHeight:Number = 250;
		private var sponsoredConvo_mc:SponsoredConvo;
		private var answersPanelTopShadow:AnswersPanelTopShadow;
		
		 
		
		
		public function AnswersPanel(xmlData:XML, maxWidth:Number, maxHeight:Number){
			//trace("AnswerPanel instanciated");
			if (stage) {initListener(null);} else {addEventListener(Event.ADDED_TO_STAGE, initListener);}
			//this.urlParams = urlParams;
			this.xmlData = xmlData;
			this.maxWidth = maxWidth;
			this.maxHeight = maxHeight;
			//trace("AnswersPanel.as - end of constructor - this.width="+this.width+" this.height="+this.height);
		}
		
		
		
		function initListener (e:Event):void {
			//trace("AnswersPanel.initListener() called");
			//trace("AnswersPanel.as - initlistener start - this.width="+this.width+" this.height="+this.height);
			removeEventListener(Event.ADDED_TO_STAGE, initListener);
			answersPanelListOfQuestionsAndAnswers = new AnswersPanelListOfQuestionsAndAnswers(xmlData); 
			scrollPane = new ScrollPane();
			scrollPane.move(0,0);
			scrollPane.setSize(maxWidth, maxHeight);
			scrollPane.source = answersPanelListOfQuestionsAndAnswers;
			scrollPane.setStyle("skin", "disabledSkin");
			addChild(scrollPane);
			//Add Sponsored Conversation badge
			sponsoredConvo_mc = new SponsoredConvo();
			sponsoredConvo_mc.alpha = .75;
			addChild(sponsoredConvo_mc);
			if (UrlParams.getIsfree()) {
				sponsoredConvo_mc.sponsoredConvo_txt.htmlText = "";
			} else {
				if (UrlParams.getIsresponseforcharity()){
					sponsoredConvo_mc.sponsoredConvo_txt.htmlText = "This Conversation is for Charity";
				} else if (UrlParams.getIscharityonly()) {
					sponsoredConvo_mc.sponsoredConvo_txt.htmlText = "This Conversation is for Charity";
				} else {
					sponsoredConvo_mc.sponsoredConvo_txt.htmlText = "This is a Sponsored Conversation";	
				}
			}
			answersPanelTopShadow = new AnswersPanelTopShadow();
			addChild(answersPanelTopShadow);
			//trace("AnswersPanel.as - initlistener before resize() - this.width="+this.width+" this.height="+this.height);
			resize(maxWidth, maxHeight);
			//trace("AnswersPanel.as - initlistener after resize() - this.width="+this.width+" this.height="+this.height);
		}
		

		public function resize (maxWidth:Number, maxHeight:Number):void {
			//trace("AnswerPanel -- RESIZE -- maxWidth=" + maxWidth + " maxHeight=" + maxHeight);
			//trace("AnswersPanel.as - resize() start - this.width="+this.width+" this.height="+this.height);
			this.maxWidth = maxWidth;
			this.maxHeight = maxHeight;
			//trace("AnswerPanel -- stageWidth: " + parent.stage.stageWidth + " stageHeight: " + parent.stage.stageHeight);
			scrollPane.setSize(maxWidth, maxHeight);
			trace("AnswersPanel.as - resize() after scrollPane.setSize() - this.width="+this.width+" this.height="+this.height);
			//this.width = scrollPane.width;
			//this.height = scrollPane.height;
			answersPanelListOfQuestionsAndAnswers.resize(maxWidth, 999999);
			//trace("AnswersPanel.as - resize() after answersPanelListOfQuestionsAndAnswers resize - this.width="+this.width+" this.height="+this.height);
			sponsoredConvo_mc.resize(maxWidth, maxHeight);
			sponsoredConvo_mc.x = maxWidth - 30;
			sponsoredConvo_mc.y = 0;
			answersPanelTopShadow.width = maxWidth;
			//trace("AnswersPanel.as - resize() after answersPanelTopShadow.width - this.width="+this.width+" this.height="+this.height);
			scrollPane.update();
			//trace("AnswersPanel.as - resize() end - this.width="+this.width+" this.height="+this.height);
		}
		
	}
	
	
}