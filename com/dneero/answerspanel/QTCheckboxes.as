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


	
	public class QTCheckboxes extends MovieClip implements QuestionType {
		
		private var questionid:int;
		private var questionXML:XML;
		private var qtOptions:Array;
		

		
		public function QTCheckboxes(questionXML:XML){
			//trace("QTCheckboxes instanciated");
			if (stage) {initListener(null);} else {addEventListener(Event.ADDED_TO_STAGE, initListener);}
		    this.questionXML = questionXML;
			this.questionid = questionXML.attribute("questionid");
		}
		
		function initListener (e:Event):void {
			//trace("QTCheckboxes.initListener() called");
			removeEventListener(Event.ADDED_TO_STAGE, initListener);
			qtOptions = new Array();
			var optionList:XMLList  = questionXML.option;
			for each (var option:XML in optionList) {
				var isOn:Boolean = false;
				if (option.attribute("isselected")=="true"){
					isOn = true;
				} 
				var qtOption:QTOption = new QTOption(option.text(), isOn);
				addChild(qtOption);
				qtOptions.push(qtOption);
			}
		}
		
		

		public function resize (maxWidth:Number, maxHeight:Number):void {
			//trace("QTCheckboxes -- RESIZE -- maxWidth="+maxWidth+" maxHeight="+maxHeight);
			var currentHeight = 5;
			for each (var qtOption:QTOption in qtOptions) {
				qtOption.x = 0;
				qtOption.y = currentHeight;
				qtOption.resize(maxWidth, maxHeight);
				currentHeight = currentHeight + qtOption.height + 5;
			}
		}
		
		
		
		public function getQuestionid():int{
			return questionid;
		}
		
		private function isSelected(option:String):Boolean{
			for each (var optionselected:String in checkedoptions) {
				if (optionselected==option){
					return true;
				}
			}
			return false;
		}
		
	}
	
	
}