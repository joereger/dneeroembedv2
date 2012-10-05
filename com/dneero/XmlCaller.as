package com.dneero
{
	

	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.*;
	import com.dneero.UrlParams;
	

	public class XmlCaller extends EventDispatcher{
		
		public static const XML_LOADED = "xml_loaded";
		private var xmlLoader:URLLoader  = new  URLLoader();
		private var xmlData:XML = new XML();
		//private var urlParams:UrlParams;
		
		
		public function XmlCaller(){
			trace("XmlCaller instanciated");
			//this.urlParams = urlParams;
			
			//HANDLE ERRORS!!  How??
			
			if (1==1){
				xmlLoader = new URLLoader();
				xmlData = new XML();
				xmlLoader.addEventListener(Event.COMPLETE, loadXML);
				var c:String = "0";
				if (UrlParams.getIscached()){
					c  = "1";
				}
				var p:String = "0";
				if (UrlParams.getIspreview()){
					p  = "1";
				}
				xmlLoader.load(new URLRequest(UrlParams.getBaseurl()+"fv2/response.xml?s="+UrlParams.getSurveyid()+"&r="+UrlParams.getResponseid()+"&u="+UrlParams.getUserid()+"&c="+c+"&p="+p));
			} else {
				xmlData = new XML("<?xml version=\"1.0\" encoding=\"UTF-8\"?><response surveyid=\"330\" responseid=\"43762\" userid=\"1\"><survey surveyid=\"330\"><title>Embed Version 2 First Test ttteee</title><description>first test of embed version two</description></survey><question type=\"textbox\" questionid=\"8266\"><question>How is the thing?</question><answer>fds</answer></question><question type=\"essay\" questionid=\"8267\"><question>What is the meaning of life?</question><answer>dsf</answer></question><question type=\"matrix\" questionid=\"8268\" respondentcanselectmany=\"false\"><question>When does stuff happen?</question><rows><row>Blue</row><row>Orange</row><row>Red</row><row>Green</row><row>Purple</row></rows><cols><col>Apple</col><col>Banana</col><col>Onion</col><col>Bean</col></cols><checked><rowcolpair row=\"Green\" col=\"Apple\" /><rowcolpair row=\"Purple\" col=\"Banana\" /><rowcolpair row=\"Red\" col=\"Banana\" /><rowcolpair row=\"Orange\" col=\"Apple\" /><rowcolpair row=\"Blue\" col=\"Banana\" /></checked></question><question type=\"range\" questionid=\"8269\" mintitle=\"Small\" min=\"1.0\" step=\"2.0\" max=\"6.0\" maxtitle=\"Tiny\"><question>How small is the big thing?</question><answer>3.0</answer></question><question type=\"checkboxes\" questionid=\"8270\"><question>Which of these do you like?</question><option isselected=\"true\">Stars&#xD;</option><option isselected=\"false\">Galaxies&#xD;</option><option isselected=\"false\">Supernovas&#xD;</option><option isselected=\"false\">Planets</option></question><question type=\"dropdown\" questionid=\"8271\"><question>Which of these is purple?</question><option isselected=\"true\">Purple headed snake&#xD;</option><option isselected=\"false\">Red zinger&#xD;</option><option isselected=\"false\">Orange drink</option></question></response>");
				trace(xmlData);
			}
		}
		
		
		
		function loadXML(e:Event):void{
			trace("XmlCaller -- loadXML() called");
			xmlData = new XML(e.target.data);
			trace(xmlData);
			dispatchEvent(new Event(XmlCaller.XML_LOADED));
		}
		
		
        public function getXmlData():XML{
			return xmlData;
		}
		
	
		
	}
	
	
}