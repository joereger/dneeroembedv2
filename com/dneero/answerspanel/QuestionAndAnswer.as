package com.dneero.answerspanel
{
	
	import flash.display.MovieClip;
	import fl.containers.ScrollPane;
	import flash.events.Event;
	import flash.display.Stage;
	import fl.controls.ScrollPolicy;
    import fl.controls.TextArea;
	import flash.text.TextFieldAutoSize;
	import gs.TweenLite;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.AVM1Movie;
	import flash.net.URLRequest;
	import flash.events.IOErrorEvent;
	import com.dneero.Shadow;
	//import flash.net.NetConnection;
	//import flash.net.NetStream;
	//import flash.media.Video;
	//import flash.events.AsyncErrorEvent;
	//import fl.video.FLVPlayback;
	//import flash.events.Event;
	//import flash.events.MouseEvent;
	
	public class QuestionAndAnswer extends MovieClip {
		
		private var questionid:int;
		private var question:String;
		private var answer:QuestionType;
		private var questionXML:XML;
		
		private var maxWidth:Number = 0;
		private var maxHeight:Number = 0;
		
		private var exImgLoader:Loader;
		private var img;
		private var aud;
		private var vid;
		private var image:String;
		private var audio:String;
		private var video:String;
		//var ns:NetStream;
		
		private var rtMargin:Number = 40;
		private var minimumQuestionWidth:Number = 100;
		private var maxImgHeight:Number = 150;
		
		public var question_txt;
		public var questionAndAnswerBg_mc;
		
		public function QuestionAndAnswer(questionXML:XML, answer:QuestionType){
			//trace("QuestionAndAnswer instanciated");
			if (stage) {initListener(null);} else {addEventListener(Event.ADDED_TO_STAGE, initListener);}
			this.questionXML = questionXML;
			this.question = questionXML.question.text();
			this.answer = answer;
			this.image = questionXML.image.text();
			this.audio = questionXML.audio.text();
			this.video = questionXML.video.text();
			//trace("this.question=" + this.question);
			//trace("this.questionXML="+this.questionXML);
			//trace("this.image=" + this.image);
			//trace("this.audio=" + this.audio);
			//trace("this.video="+this.video);
		}
		
		function initListener (e:Event):void {
			//trace("QuestionAndAnswer.initListener() called");
			removeEventListener(Event.ADDED_TO_STAGE, initListener);
			question_txt.htmlText = question+"";
			question_txt.wordWrap = true;
			question_txt.autoSize = TextFieldAutoSize.LEFT;
			addChild(answer);
			
			try{
				if (image.length > 0) {
					var url:String = image;
					var urlRequest:URLRequest = new URLRequest(url);
					//trace("Will try to load: url="+url);
					exImgLoader = new Loader();
					exImgLoader.contentLoaderInfo.addEventListener(Event.INIT, imageInitted);
					exImgLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, imageIoError);
					exImgLoader.load(urlRequest);
				}
			} catch (error:Error) { trace("Error catch: " + error); }
			
			try{
				if (audio.length > 0) { 
					//aud = new StreamingVideoPlayer(audio,150,75);
					//addChild(aud);
					//resize(maxWidth, maxHeight); //Resize this
					//AnswersPanelListOfQuestionsAndAnswers(parent).resizeUsingPrevious(); //Resize parent
				}
			} catch (error:Error) { trace("Error catch: " + error); }
			
			try{
				if (video.length > 0) { 
					//vid = new Video();
					//addChild(vid);
					//var nc:NetConnection = new NetConnection();
					//nc.connect(null);
					//ns = new NetStream(nc);
					//ns.addEventListener(AsyncErrorEvent.ASYNC_ERROR, ayncErrorHandler);
					//vid.attachNetStream(ns);
					//ns.play(video);
					////vid = new FLVPlayback();
					////addChild(vid);
					////vid.source = video;
					////vid.mouseEnabled = true;
					////vid.skin = "SkinUnderPlaySeekMute.swf";
					////vid.skinAutoHide = false;
					////vid.autoPlay = false;
					////vid.play();
					//addEventListener(MouseEvent.CLICK, videoClick);
					//addEventListener(MouseEvent.MOUSE_OVER, videoClick);
					//addEventListener(MouseEvent.MOUSE_OUT, videoClick);
					vid = new StreamingVideoPlayer(video,160,120);
					addChild(vid);
					resize(maxWidth, maxHeight); //Resize this
					AnswersPanelListOfQuestionsAndAnswers(parent).resizeUsingPrevious(); //Resize parent
				}
			} catch (error:Error) { trace("Error catch: " + error); }
		}
		
		//public function videoClick(event:MouseEvent):void{
			//trace("Video Clicked: "+event.toString);
		//}
		
		//public function ayncErrorHandler(event: AsyncErrorEvent): void {
			// ignore for now
		//}

		public function resize (maxWidth:Number, maxHeight:Number):void {
			//trace("QuestionAndAnswer -- RESIZE -- maxWidth="+maxWidth+" maxHeight="+maxHeight);
			this.maxWidth = maxWidth;
			this.maxHeight = maxHeight;
			//trace("QuestionAndAnswer -PRE- this.width="+this.width);
			//trace("QuestionAndAnswer -PRE- this.height="+this.height);
			//trace("QuestionAndAnswer -PRE- question_txt.x="+question_txt.x);
			//trace("QuestionAndAnswer -PRE- question_txt.y="+question_txt.y);
			//trace("QuestionAndAnswer -PRE- MovieClip(answer).getBounds(this).y=" + MovieClip(answer).getBounds(this).y);
			//trace("QuestionAndAnswer -PRE- MovieClip(answer).getBounds(this).width="+MovieClip(answer).getBounds(this).width);
			//trace("QuestionAndAnswer -PRE- MovieClip(answer).getBounds(this).height="+MovieClip(answer).getBounds(this).height);
			//trace("QuestionAndAnswer -PRE- questionAndAnswerBg_mc.x="+questionAndAnswerBg_mc.x);
			//trace("QuestionAndAnswer -PRE- questionAndAnswerBg_mc.y="+questionAndAnswerBg_mc.y);
			//trace("QuestionAndAnswer -PRE- questionAndAnswerBg_mc.width="+questionAndAnswerBg_mc.width);
			//trace("QuestionAndAnswer -PRE- questionAndAnswerBg_mc.height="+questionAndAnswerBg_mc.height);
			
			//Initial sizing
			question_txt.width = maxWidth - rtMargin;
			MovieClip(answer).x = question_txt.x;
			MovieClip(answer).y = question_txt.textHeight + 5;
			answer.resize(maxWidth-rtMargin, 999999);
			questionAndAnswerBg_mc.x = 3;
			questionAndAnswerBg_mc.y = 0;
			questionAndAnswerBg_mc.width = maxWidth - rtMargin - 4;
			questionAndAnswerBg_mc.height = 10 + (MovieClip(answer).getBounds(this).y + MovieClip(answer).getBounds(this).height);
			
			//Hangle images/videos/etc
			var haveMedia:Boolean = false;
			if (image.length>0 || video.length>0 || audio.length>0) { haveMedia = true; }
			if (haveMedia) { //If there's an image, include it in sizing/layout calculations
				//trace("QuestionAndAnswer haveMedia=true");
				resizeMediaElements((maxWidth-rtMargin-5)/2, maxImgHeight);
				setXForMedia((maxWidth-rtMargin-5)/2); //Put it at 200 pixels from right side
				setYForMedia(3);
				question_txt.width = getMediaX() - 5;
				MovieClip(answer).x = question_txt.x;
			    MovieClip(answer).y = question_txt.textHeight + 5;
				answer.resize(getMediaX() - 5, 999999);
				questionAndAnswerBg_mc.height = 10 + (MovieClip(answer).getBounds(this).y + MovieClip(answer).getBounds(this).height);
				if (getMediaHeight()>questionAndAnswerBg_mc.height) { //if the image is taller than the background
					questionAndAnswerBg_mc.height = getMediaHeight() + 10;
				}
				//trace("QuestionAndAnswer too crunched? MovieClip(answer).getBounds(this).width="+MovieClip(answer).getBounds(this).width+" minimumQuestionWidth="+minimumQuestionWidth);
				if (MovieClip(answer).getBounds(this).width < minimumQuestionWidth) { //If the question/answer are too crunched
					//Basically, redo the initial sizing
					question_txt.width = maxWidth - rtMargin;
					MovieClip(answer).x = question_txt.x;
					MovieClip(answer).y = question_txt.textHeight + 5;
					answer.resize(maxWidth-rtMargin, 999999);
					questionAndAnswerBg_mc.x = 3;
					questionAndAnswerBg_mc.y = 0;
					questionAndAnswerBg_mc.width = maxWidth - rtMargin - 4;
					questionAndAnswerBg_mc.height = 10 + (MovieClip(answer).getBounds(this).y + MovieClip(answer).getBounds(this).height);
					//But move the image below
					resizeMediaElements(maxWidth-rtMargin-5, maxImgHeight); //Can now consider full width as long as not too tall
					setXForMedia(0);
					setYForMedia((MovieClip(answer).getBounds(this).y + MovieClip(answer).getBounds(this).height) + 3);
					questionAndAnswerBg_mc.height = 10 + (MovieClip(answer).getBounds(this).y + MovieClip(answer).getBounds(this).height) + getMediaHeight();
				}
			}
			//trace("QuestionAndAnswer -POST- this.width="+this.width);
			//trace("QuestionAndAnswer -POST- this.height="+this.height);
			//trace("QuestionAndAnswer -POST- question_txt.x="+question_txt.x);
			//trace("QuestionAndAnswer -POST- question_txt.y="+question_txt.y);
			//trace("QuestionAndAnswer -POST- MovieClip(answer).getBounds(this).y=" + MovieClip(answer).getBounds(this).y);
			//trace("QuestionAndAnswer -POST- MovieClip(answer).getBounds(this).width="+MovieClip(answer).getBounds(this).width);
			//trace("QuestionAndAnswer -POST- MovieClip(answer).getBounds(this).height="+MovieClip(answer).getBounds(this).height);
			//trace("QuestionAndAnswer -POST- questionAndAnswerBg_mc.x="+questionAndAnswerBg_mc.x);
			//trace("QuestionAndAnswer -POST- questionAndAnswerBg_mc.y="+questionAndAnswerBg_mc.y);
			//trace("QuestionAndAnswer -POST- questionAndAnswerBg_mc.width="+questionAndAnswerBg_mc.width);
			//trace("QuestionAndAnswer -POST- questionAndAnswerBg_mc.height="+questionAndAnswerBg_mc.height);
		}
		
		private function resizeMediaElements(boundW:Number, boundH:Number):void {
			//trace("QuestionAndAnswer resizeMediaElements");
			if (img!=null) { img = resizeAndKeepAspect(img, boundW, boundH); }
			if (aud!=null) { aud = resizeAndKeepAspect(aud, boundW, boundH); }
			if (vid != null) { 
				//trace("QuestionAndAnswer vid!=null");
				//vid = resizeAndKeepAspect(vid, boundW, boundH); 
				vid.resize(boundW, boundH);
			} else {
				//trace("QuestionAndAnswer vid==null");
			}
		}
		
		private function setXForMedia(x:Number):void {
			if (img!=null) { img.x=x; }
			if (aud!=null) { aud.x=x; }
			if (vid!=null) { vid.x=x; }
		}
		
		private function setYForMedia(y:Number):void {
			if (img!=null) { img.y=y; }
			if (aud!=null) { aud.y=y; }
			if (vid!=null) { vid.y=y; }
		}
		
		private function getMediaHeight():Number {
			var out:Number = 0;
			if (img!=null && img.height>out) { out = img.height; }
			if (aud!=null && aud.height>out) { out = aud.height; }
			if (vid!=null && vid.height>out) { out = vid.height + 45; }
			return out;
		}
		
		private function getMediaWidth():Number {
			var out:Number = 0;
			if (img!=null && img.width>out) { out = img.width; }
			if (aud!=null && aud.width>out) { out = aud.width; }
			if (vid!=null && vid.width>out) { out = vid.width; }
			return out;
		}
		
		private function getMediaX():Number {
			var out:Number = 0;
			if (img!=null) { out = img.x; }
			if (aud!=null) { out = aud.x; }
			if (vid!=null) { out = vid.x; }
			return out;
		}
		
		private function getMediaY():Number {
			var out:Number = 0;
			if (img!=null) { out = img.y; }
			if (aud!=null) { out = aud.y; }
			if (vid!=null) { out = vid.y; }
			return out;
		}
		
		
		private function imageInitted(e:Event):void{
			//img = exImgLoader.content;
			img = exImgLoader;
			//if (img is AVM1Movie){
			//	trace("is AVM1Movie");
			//	img = exImgLoader;
			//} else {
			//	trace("not AVM1Movie");
			//	img = exImgLoader.content;
			//}
			img = resizeAndKeepAspect(img, maxWidth / 2, maxImgHeight);
			if (img.width>0 && img.height>0){
				addChild(img);
				//img.x = (290 - img.width)/2;
				//img.x = 0;
				//img.y = 0;
				img.alpha = 0.0;
				//trace("QuestionAndAnswer: about to apply filters to img... img.width="+img.width);
				//img.filters = Shadow.getDropShadowFilterArray(0x000000); 
				TweenLite.to(img, 1, { alpha:1 } );
				resize(maxWidth, maxHeight);
				AnswersPanelListOfQuestionsAndAnswers(parent).resizeUsingPrevious(); //Resize parent
			}
		}
		
		private function imageIoError(e:Event):void{
			trace("imageIoError happened:"+e);
		}

		
		
		private function resizeAndKeepAspect(img,boundW,boundH):DisplayObject {
			var imgW:Number = img.width;
			var imgH:Number = img.height;
			var ratio:Number;
			if (imgW >= imgH) {
				// image is wide or square
				ratio = imgH/imgW;
				imgW = boundW;
				imgH = imgW*ratio;
				if (imgH > boundH) {
					// image's height is still too large...resize on height
					imgH = boundH;
					imgW = imgH/ratio;
				}
			} else if (imgH > imgW) {
				// image is tall
				ratio = imgW/imgH;
				imgH = boundH;
				imgW = imgH*ratio;
				if (imgW > boundW) {
					// image's width is still too large...resize on width
					imgW = boundW;
					imgH = imgW/ratio;
				}
			}
			img.width = imgW;
			img.height = imgH;
			//trace("imgW=" + imgW);
			//trace("imgH="+imgH);
			return img;
		}
		
		public function getQuestionXML():XML {
			return questionXML;
		}


		
	}
	
	
}