package com.dneero {
	
	import flash.display.MovieClip;
	import com.dneero.answerspanel.AnswersPanel;
	import com.dneero.UrlParams;
	import com.dneero.XmlCaller;
	import com.dneero.SponsoredConvo;
	import com.dneero.Toolbar;
	import com.dneero.TitleBar;
	import com.dneero.Main;
	import com.dneero.Shadow;
	import flash.system.Security;
	import flash.events.Event;
	import flash.display.*;

	public class ConvoEmbed extends MovieClip {
		
		//var urlParams:UrlParams;
		var bottomshadow:Shape;
		var main:Main;
		var mainBorder:Shape;
		var thinborder:Shape;
		var mask1:Shape;
		var mask2:Shape;
		
		
		public function ConvoEmbed() {
			//Security
			Security.allowDomain("localhost");
			Security.allowInsecureDomain("localhost");

			//Set Stage Scaling
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			//Get incoming url parameters
			//urlParams = new UrlParams();
			///UrlParams.setSurveyid(330);
			//UrlParams.setUserid(1);
			//UrlParams.setResponseid(43762);
			
			//UrlParams.setSurveyid(333);
			//UrlParams.setUserid(1);
			//UrlParams.setResponseid(43762);
			
			UrlParams.setSurveyid(333);
			UrlParams.setUserid(1);
			UrlParams.setResponseid(0);
			
			UrlParams.setPlid(1);
			UrlParams.setIscached(false);
			UrlParams.setIspreview(false);
			UrlParams.setBaseurl("http://localhost/");
			try{
				var fv:String = "";
				
				fv = getVar("s");
				if (fv!=null && fv.length>0 && isInt(fv)) { UrlParams.setSurveyid(int(fv)); }
				trace(" -- surveyid="+UrlParams.getSurveyid());

				fv = getVar("u");
				if (fv!=null && fv.length>0 && isInt(fv)) { UrlParams.setUserid(int(fv)); }
				//trace(" -- userid="+UrlParams.getUserid());

				fv = getVar("r");
				if (fv!=null && fv.length>0 && isInt(fv)) { UrlParams.setResponseid(int(fv)); }
				//trace(" -- responseid="+responseid);

				fv = getVar("p");
				if (fv!=null && fv.length>0 && isInt(fv)) { UrlParams.setPlid(int(fv)); }
				//trace(" -- plid="+plid);

				fv = getVar("hdl");
				if (fv == "1" || fv == "yes") { UrlParams.setIspreview(true); } else { UrlParams.setIspreview(false); }
				//trace(" -- ispreview="+ispreview);

				fv = getVar("c");
				if (fv == "1" || fv == "yes") { UrlParams.setIscached(true); } else { UrlParams.setIscached(false); }
				//trace(" -- iscached="+iscached);

				fv = getVar("baseurl");
				if (fv.length > 0) { UrlParams.setBaseurl(fv); }
				//trace(" -- baseurl="+baseurl);
				
			} catch (error:Error) {
				trace(error.toString());
				
			}
			
			//Bottom Shadow
			bottomshadow = new Shape();
			addChild(bottomshadow);

			//Main
			mask1 = new Shape();
			main = new Main(stage.stageWidth, stage.stageHeight);
			addChild(main);
			main.mask = mask1;

			//Border
			mask2 = new Shape();
			mainBorder = new Shape();
			addChild(mainBorder);
			mainBorder.mask = mask2;
			
			//Thinborder
			thinborder = new Shape();
			addChild(thinborder);

			//Catch resize events
			stage.addEventListener(Event.RESIZE, resizeListener);
			
			//Do initial resize so that borders/masks are drawn on
			resizeListener(null);
			
		}
		
		
		
		private function isInt(inStr:String):Boolean {
			try {
				var i:int = int(inStr);
				return true;
			} catch (error:Error) {
				return false;
			}
		}
		
		private function getVar(name:String):String{
			//trace("  ConvoEmbed: Looking for: " + name);
			var out:String = "";
			try {
				var keyStr:String;
				var valueStr:String;
					var paramObj:Object = this.root.loaderInfo.parameters;
					if (paramObj != null) {
						//trace("  paramObj!=null");
						for (keyStr in paramObj) {
							valueStr = String(paramObj[keyStr]);
							//trace("  ConvoEmbed: " + keyStr + ":" + valueStr);
							if (keyStr == name) {
								//trace("  keyStr == name!!!");
								out = valueStr;
							}
						}
					} else {
						//trace("  paramObj==null");
					}
			} catch (error:Error) {
				trace(error.toString());
			}
			return out;
		}
		
		function resizeListener (e:Event):void {
			var xOffsetFromRight:Number = 6;
			var yOffsetFromBottom:Number = 6;
			
			bottomshadow.graphics.clear();
			bottomshadow.graphics.beginFill(0xFFFFFF, 1);
			bottomshadow.graphics.drawRoundRect(0, 0, stage.stageWidth - xOffsetFromRight, stage.stageHeight - yOffsetFromBottom, 20, 20);
			bottomshadow.graphics.endFill();
			bottomshadow.filters = Shadow.getDropShadowFilterArray(0x000000, 5, 3, .5);
			
			
			mask1 = new Shape();
			mask1.graphics.beginFill(0xFFFFFF, 1);
			mask1.graphics.drawRoundRect(0,0, stage.stageWidth-xOffsetFromRight, stage.stageHeight-yOffsetFromBottom, 20, 20);
			mask1.graphics.endFill();
			
			mask2 = new Shape();
			mask2.graphics.beginFill(0xFFFFFF, 1);
			mask2.graphics.drawRoundRect(0,0, stage.stageWidth-xOffsetFromRight, stage.stageHeight-yOffsetFromBottom, 20, 20);
			mask2.graphics.endFill();
			
			mainBorder.graphics.clear();
			mainBorder.graphics.lineStyle(8, 0xffffff, .8, true, LineScaleMode.NONE, null, JointStyle.MITER, 3);
			mainBorder.graphics.drawRoundRect(0, 0, stage.stageWidth - xOffsetFromRight, stage.stageHeight - yOffsetFromBottom, 20, 20);
			mainBorder.mask = mask2;
			
			thinborder.graphics.clear();
			thinborder.graphics.lineStyle(1, 0xCCCCCC, 1.0, true, LineScaleMode.NONE, null, JointStyle.MITER, 3);
			thinborder.graphics.drawRoundRect(0,0, stage.stageWidth-xOffsetFromRight, stage.stageHeight-yOffsetFromBottom, 20, 20);
			
			main.mask = mask1;
			main.resize(stage.stageWidth-xOffsetFromRight, stage.stageHeight-yOffsetFromBottom);
		}
		
	}
	
}