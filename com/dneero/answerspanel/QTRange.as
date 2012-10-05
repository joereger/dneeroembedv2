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


	
	public class QTRange extends MovieClip implements QuestionType {
		
		private var questionid:int;
		private var questionXML:XML;
		public var mintitle_txt;
		public var maxtitle_txt;
		private var minVal:Number;
		public var min_txt;
		private var maxVal:Number;
		public var max_txt;
		private var val:Number;
		public var val_txt;
		public var qtRangeBar:QTRangeBar;
		public var qtRangeIndicator:QTRangeIndicator;

		
		public function QTRange(questionXML:XML){
			//trace("QTRange instanciated");
			if (stage) {initListener(null);} else {addEventListener(Event.ADDED_TO_STAGE, initListener);}
		    this.questionXML = questionXML;
			this.questionid = questionXML.attribute("questionid");
			this.minVal = questionXML.attribute("min");
			this.maxVal = questionXML.attribute("max");
			this.val = questionXML.answer.text();
		}
		
		function initListener (e:Event):void {
			//trace("QTRange.initListener() called");
			removeEventListener(Event.ADDED_TO_STAGE, initListener);
			mintitle_txt.wordWrap = true;
			mintitle_txt.autoSize = TextFieldAutoSize.LEFT;
			mintitle_txt.htmlText = questionXML.attribute("mintitle");
			//addChild(mintitle_txt);
			maxtitle_txt.wordWrap = true;
			maxtitle_txt.autoSize = TextFieldAutoSize.LEFT;
			maxtitle_txt.htmlText = questionXML.attribute("maxtitle");
			//addChild(maxtitle_txt);
			min_txt.wordWrap = true;
			min_txt.autoSize = TextFieldAutoSize.LEFT;
			min_txt.htmlText = minVal;
			//addChild(min_txt);
			max_txt.wordWrap = true;
			max_txt.autoSize = TextFieldAutoSize.LEFT;
			max_txt.htmlText = maxVal;
			//addChild(max_txt);
			qtRangeIndicator.val_txt.wordWrap = true;
			qtRangeIndicator.val_txt.autoSize = TextFieldAutoSize.LEFT;
			qtRangeIndicator.val_txt.htmlText = val;
			//addChild(qtRangeIndicator.val_txt);
		}
		
		

		public function resize (maxWidth:Number, maxHeight:Number):void {
			//trace("QTRange -- RESIZE -- maxWidth=" + maxWidth + " maxHeight=" + maxHeight);
			//trace("QTRange -- resize start - this.width="+this.width+" this.height="+this.height);
			var RIGHTPADDING:Number = 20;
			var SPACING:Number = 5;
			var widthOfMinTitle:Number = mintitle_txt.textWidth;
			//trace("QTRange -- widthOfMinTitle="+widthOfMinTitle);
			var widthOfMaxTitle:Number = maxtitle_txt.textWidth;
			if (widthOfMaxTitle<50){
				widthOfMaxTitle = 50;
			}
			//trace("QTRange -- widthOfMaxTitle="+widthOfMaxTitle);
			var widthOfBar = maxWidth - widthOfMaxTitle - widthOfMinTitle - SPACING - SPACING - RIGHTPADDING;
			//trace("QTRange -- widthOfBar="+widthOfBar);
			qtRangeBar.x = widthOfMinTitle + SPACING;
			//trace("QTRange -- qtRangeBar.x="+qtRangeBar.x + " this.width="+this.width+" this.height="+this.height);
			qtRangeBar.width = widthOfBar;
			//trace("QTRange -- qtRangeBar.width="+qtRangeBar.width + " this.width="+this.width+" this.height="+this.height);
			min_txt.x = widthOfMinTitle + SPACING;
			//trace("QTRange -- min_txt.x="+min_txt.x + " this.width="+this.width+" this.height="+this.height);
			max_txt.x = maxWidth - widthOfMaxTitle - SPACING - RIGHTPADDING - max_txt.textWidth;
			//trace("QTRange -- max_txt.x="+max_txt.x + " this.width="+this.width+" this.height="+this.height);
			maxtitle_txt.width = widthOfMaxTitle;
			maxtitle_txt.x = maxWidth - widthOfMaxTitle - RIGHTPADDING;
			var percentOfTotal:Number =  (val - minVal) / (maxVal - minVal);
			if (isNaN(percentOfTotal)) { percentOfTotal = .0001; } 
			//trace("QTRange -- percentOfTotal=" + percentOfTotal + " this.width=" + this.width + " this.height=" + this.height);
			var pixelsAlongBar:Number = percentOfTotal * widthOfBar;
			if (isNaN(pixelsAlongBar)) { pixelsAlongBar = 0; } 
			//trace("QTRange -- pixelsAlongBar=" + pixelsAlongBar + " this.width="+this.width+" this.height="+this.height);
			qtRangeIndicator.x = widthOfMinTitle + SPACING + pixelsAlongBar;
			//trace("QTRange -- qtRangeIndicator.x=" + qtRangeIndicator.x + " this.width="+this.width+" this.height="+this.height);
			//trace("QTRange -- resize end - this.width="+this.width+" this.height="+this.height);
		}
		
		
		
		public function getQuestionid():int{
			return questionid;
		}
		
	}
	
	
}