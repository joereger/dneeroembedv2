package com.dneero
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.display.Shape;
	import flash.display.LineScaleMode;
	import flash.display.JointStyle;
	import com.dneero.answerspanel.AnswersPanel;
	import com.dneero.UrlParams;
	import com.dneero.XmlCaller;
	import com.dneero.Toolbar;
	import com.dneero.TitleBar;
	import gs.TweenLite;
	import com.dneero.GoogleAnalytics;

	
	public class Main extends MovieClip {
	
		//private var urlParams:UrlParams;
		private var titleBar:TitleBar;
		private var toolbar:Toolbar;
		private var answersPanel:AnswersPanel;
		private var xmlCaller:XmlCaller;
		private var maxWidth:Number=425;
		private var maxHeight:Number=250;
		
		
		public function Main(maxWidth:Number, maxHeight:Number){
			trace("Main instanciated");
			if (stage) {initListener(null);} else {addEventListener(Event.ADDED_TO_STAGE, initListener);}
			//this.urlParams = urlParams;
			this.maxWidth = maxWidth;
			this.maxHeight = maxHeight;
		}
		
		function initListener (e:Event):void {
			trace("Main.initListener() called");
			removeEventListener(Event.ADDED_TO_STAGE, initListener);
			
			//Go get xml
			xmlCaller = new XmlCaller();
			xmlCaller.addEventListener(XmlCaller.XML_LOADED, addAnswersPanelToStage);
			
			//Listen for mouse over stage and leaving stage
			stage.addEventListener(MouseEvent.MOUSE_OVER, mouseOverStage);
			stage.addEventListener(MouseEvent.MOUSE_OUT, mouseLeavingStage);
		}
		
		

		public function resize(maxWidth:Number, maxHeight:Number):void {
			trace("Main -- RESIZE -- maxWidth="+maxWidth+" maxHeight="+maxHeight);
			this.maxWidth = maxWidth;
			this.maxHeight = maxHeight;
			if (titleBar!=null){titleBar.resize(maxWidth, maxWidth);}
			if (toolbar!=null){toolbar.resize(maxWidth, maxHeight);}
			if (toolbar!=null){toolbar.y = maxHeight;}
			if (answersPanel!=null){answersPanel.resize(maxWidth, toolbar.y-titleBar.height);}
			if (answersPanel != null) { if (titleBar != null) { answersPanel.y = titleBar.height; } else { answersPanel.y = 0; } }
			if (answersPanel != null) { trace("Main.as - resize() done. answersPanel.width=" + answersPanel.width + " answersPanel.height=" + answersPanel.height); } else { trace("Main.as - resize() done. answersPanel is null."); };
		}
		
		function mouseOverStage (e:Event):void {
			//trace("mouseOverStage (e:Event) called");
			TweenLite.to(toolbar, .5, { y:maxHeight - 35 } );
			//TweenLite.to(answersPanel, 1, { height:maxHeight - 35 } );
			answersPanel.resize(maxWidth, maxHeight-titleBar.height-35);
		}
		
		function mouseLeavingStage (e:Event):void {
			//trace("mouseLeavingStage (e:Event) called");
			TweenLite.to(toolbar, 1, { y:maxHeight + 50, delay:5 } );
			answersPanel.resize(maxWidth, maxHeight-titleBar.height);
		}
			
		
		function addAnswersPanelToStage(e:Event):void {
			//Need to read the xml data to set some UrlParams
			try {
				trace("xmlCaller.getXmlData().survey[0].attribute(\"ischarityonly\")="+xmlCaller.getXmlData().survey[0].attribute("ischarityonly"));
				if (xmlCaller.getXmlData().survey[0].attribute("ischarityonly")=="1" ) {
					UrlParams.setIscharityonly(true);
				} else {
					UrlParams.setIscharityonly(false);
				}
				trace("xmlCaller.getXmlData().attribute(\"isforcharity\")="+xmlCaller.getXmlData().attribute("isforcharity"));
				if (xmlCaller.getXmlData().attribute("isforcharity")=="1" ) {
					UrlParams.setIsresponseforcharity(true);
				} else {
					UrlParams.setIsresponseforcharity(false);
				}
				trace("xmlCaller.getXmlData().attribute(\"isfree\")="+xmlCaller.getXmlData().attribute("isfree"));
				if (xmlCaller.getXmlData().attribute("isfree")=="1" ) {
					UrlParams.setIsfree(true);
				} else {
					UrlParams.setIsfree(false);
				}
			} catch (error:Error) {
				trace(error.toString());
			}
			
			
			//trace("addAnswersPanelToStage(e:Event) called");
			//Scrolling questions/answers
			answersPanel = new AnswersPanel(xmlCaller.getXmlData(), maxWidth, maxHeight-35);
			//answersPanel.mask = mainMask2;
			addChild(answersPanel);
			trace("Main.as - addChild(answersPanel) done. answersPanel.width="+answersPanel.width+" answersPanel.height="+answersPanel.height);
			answersPanel.x = 0;
			answersPanel.y = 35;
			
			//Title
			titleBar = new TitleBar(null);
			var surveyList:XMLList  = xmlCaller.getXmlData().survey;
			for each (var survey:XML in surveyList) {
				titleBar = new TitleBar(survey);
				//titleBar.mask = mainMask;
				addChild(titleBar);
			}
			
			//Add Toolbar
			toolbar = new Toolbar();
			//toolbar.mask = mainMask;
			addChild(toolbar);
			toolbar.x = 0;
			toolbar.y = maxHeight;
			
			//Do initial resize
			resize(maxWidth, maxHeight);
			
			//Track GoogleAnalytics
			try {
				var googleanalyticsidflash:String;
				trace("xmlCaller.getXmlData().attribute(\"googleanalyticsidflash\")="+xmlCaller.getXmlData().attribute("googleanalyticsidflash"));
				if (xmlCaller.getXmlData().attribute("googleanalyticsidflash")!=null &&  xmlCaller.getXmlData().attribute("googleanalyticsidflash")!="") {
					googleanalyticsidflash = xmlCaller.getXmlData().attribute("googleanalyticsidflash");
				} 
				trace("googleanalyticsidflash="+googleanalyticsidflash);
				var googleAnalytics:GoogleAnalytics = new GoogleAnalytics(googleanalyticsidflash, "WidgetLoadResponse");
				addChild(googleAnalytics);
				googleAnalytics.track();
			} catch (error:Error) {
				trace(error.toString());
			}
		}
		
	}
	
	
}