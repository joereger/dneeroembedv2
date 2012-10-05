package com.dneero
{
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class UrlParams {
		
		private static var surveyid:int = 0;
		private static var userid:int = 0;
		private static var responseid:int = 0;
		private static var plid:int = 0;
		private static var ispreview:Boolean = false;
		private static var iscached:Boolean = false;
		private static var baseurl:String = "http://www.dneero.com/";
		private static var ischarityonly:Boolean = false;
		private static var isresponseforcharity:Boolean = false;
		private static var isfree:Boolean = false;
		
		public function UrlParams(){
			//trace("UrlParams instanciated");
			//loadFromFlashVars();
		}
		
		//function initListener (e:Event):void {
		//	trace("UrlParams.initListener() called");
		//	removeEventListener(Event.ADDED_TO_STAGE, initListener);
		//}
		
		//public function loadFromFlashVars():void {
			//trace("Running loadFromFlashVars()");
			//var fv:String = "";
			//
			//fv = getVar("surveyid");
			//if (fv is int) { setSurveyid(int(fv)); }
			//trace(" -- surveyid="+surveyid);
//
			//fv = getVar("userid");
			//if (fv is int) { setUserid(int(fv)); }
			//trace(" -- userid="+userid);
//
			//fv = getVar("responseid");
			//if (fv is int) { setResponseid(int(fv)); }
			//trace(" -- responseid="+responseid);
//
			//fv = getVar("plid");
			//if (fv is int) { setPlid(int(fv)); }
			//trace(" -- plid="+plid);
//
			//fv = getVar("ispreview");
			//if (fv == "1" || fv == "yes") { setIspreview(true); } else { setIspreview(false); }
			//trace(" -- ispreview="+ispreview);
//
			//fv = getVar("iscached");
			//if (fv == "1" || fv == "yes") { setIscached(true); } else { setIscached(false); }
			//trace(" -- iscached="+iscached);
//
			//fv = getVar("baseurl");
			//if (fv.length > 0) { setBaseurl(fv); }
			//trace(" -- baseurl="+baseurl);
//
		//}
		
		
		
		
		
		public static function getSurveyid():int {
			return surveyid;
		}
		public static function setSurveyid(surveyid:int):void{
			UrlParams.surveyid = surveyid;
		}
		
		public static function getUserid():int{
			return userid;
		}
		public static function setUserid(userid:int):void{
			UrlParams.userid = userid;
		}
		
		public static function getResponseid():int{
			return responseid;
		}
		public static function setResponseid(responseid:int):void{
			UrlParams.responseid = responseid;
		}
		
		public static function getPlid():int{
			return plid;
		}
		public static function setPlid(plid:int):void{
			UrlParams.plid = plid;
		}
		
		public static function getIspreview():Boolean{
			return ispreview;
		}
		public static function setIspreview(ispreview:Boolean):void{
			UrlParams.ispreview = ispreview;
		}
		
		public static function getIscached():Boolean{
			return iscached;
		}
		public static function setIscached(iscached:Boolean):void{
			UrlParams.iscached = iscached;
		}
		
		public static function getBaseurl():String{
			return baseurl;
		}
		public static function setBaseurl(baseurl:String):void{
			UrlParams.baseurl = baseurl;
		}
		
		public static function getIscharityonly():Boolean{
			return ischarityonly;
		}
		public static function setIscharityonly(ischarityonly:Boolean):void{
			UrlParams.ischarityonly = ischarityonly;
		}
		
		public static function getIsresponseforcharity():Boolean{
			return isresponseforcharity;
		}
		public static function setIsresponseforcharity(isresponseforcharity:Boolean):void{
			UrlParams.isresponseforcharity = isresponseforcharity;
		}
		
		public static function getIsfree():Boolean{
			return isfree;
		}
		public static function setIsfree(isfree:Boolean):void{
			UrlParams.isfree = isfree;
		}
		
		
		
		
		
		
		
		
		
	}
	
	
}