package com.dneero.answerspanel
{
  import flash.events.Event;	
	
  public interface QuestionType {
    function getQuestionid():int;
	function resize (maxWidth:Number, maxHeight:Number):void;
  }
}