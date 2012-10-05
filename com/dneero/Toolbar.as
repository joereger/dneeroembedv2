package com.dneero
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.dneero.ToolbarBg;
	import flash.events.MouseEvent;
	import flash.display.StageDisplayState;
	import flash.net.URLRequest;
	import flash.net.navigateToURL; 
	import com.dneero.UrlParams;
	
	public class Toolbar extends MovieClip {
		
		public var toolbarBg:ToolbarBg;
		public var windowButton_btn:WindowButton;
		private var joinButton:JoinButton;
		private var seeOthersButton:SeeOthersButton;
		
		
		public function Toolbar(){
			trace("Toolbar instanciated");
			if (stage) {initListener(null);} else {addEventListener(Event.ADDED_TO_STAGE, initListener);}
		}
		
		function initListener (e:Event):void {
			trace("Toolbar.initListener() called");
			removeEventListener(Event.ADDED_TO_STAGE, initListener);
			windowButton_btn.addEventListener(MouseEvent.CLICK, windowButtonClick);
			
			joinButton = new JoinButton();
			addChild(joinButton);
			joinButton.addEventListener(MouseEvent.CLICK, joinButtonClick);
			
			seeOthersButton = new SeeOthersButton();
			addChild(seeOthersButton);
			seeOthersButton.addEventListener(MouseEvent.CLICK, seeOthersButtonClick);
			
			resize(this.width, this.height);
		}
		
		

		public function resize(maxWidth:Number, maxHeight:Number):void {
			//trace("Toolbar -- RESIZE -- maxWidth="+maxWidth+" maxHeight="+maxHeight);
			toolbarBg.width = maxWidth;
			this.x = 0;
			this.y = maxHeight - 35;
			windowButton_btn.x = maxWidth - 30;
			
			if (maxWidth < 350) {
				joinButton.x = 20;
				joinButton.y = -46;
				seeOthersButton.x = 20;
				seeOthersButton.y = -23;
			} else {
				joinButton.x = 100;
				joinButton.y = 10;
				seeOthersButton.x = 225;
				seeOthersButton.y = 10;
			}
		}
		

		
		public function windowButtonClick(event:MouseEvent):void{
			trace("stage.displayState=" + stage.displayState);
			try{
				if (stage.displayState!=StageDisplayState.FULL_SCREEN){
					trace("Going StageDisplayState.FULL_SCREEN");
					stage.displayState = StageDisplayState.FULL_SCREEN;
				} else {
					trace("Going StageDisplayState.NORMAL");
					stage.displayState = StageDisplayState.NORMAL;
				}
			} catch (error:Error) {
				trace(error.toString());
			}
		}
		
		public function joinButtonClick(event:MouseEvent):void{
			trace("joinButtonClick()");
			var url:String = UrlParams.getBaseurl()+"survey.jsp?s="+UrlParams.getSurveyid()+"&u="+UrlParams.getUserid();
			var request:URLRequest = new URLRequest(url);
			try {
			  navigateToURL(request, '_blank');
			} catch (e:Error) {
			  trace(e);
			}
		}
		
		public function seeOthersButtonClick(event:MouseEvent):void{
			trace("seeOthersButtonClick()");
			var url:String = UrlParams.getBaseurl()+"surveyresults.jsp?s="+UrlParams.getSurveyid()+"&u="+UrlParams.getUserid();
			var request:URLRequest = new URLRequest(url);
			try {
			  navigateToURL(request, '_blank');
			} catch (e:Error) {
			  trace(e);
			}
		}
	
		
	}
	
	
}