package com.dneero.answerspanel 
{
	
	import flash.events.*;
	import flash.media.Video;
	import flash.display.MovieClip;
	import flash.net.*;
	import flash.text.TextField;
	import fl.controls.Button;
	import flash.display.DisplayObject;
	
	public class StreamingVideoPlayer extends MovieClip {
		private var _videoURL:String;
		private var _video:Video;
		private var _vidWidth:Number;
		private var _vidHeight:Number;
		private var _main_nc:NetConnection = new NetConnection();
		private var _ns:NetStream;
		private var _start_btn:PlayVideoButton;
		
		private var maxWidth:Number = 0;
		private var maxHeight:Number = 0;
		
		
		public function StreamingVideoPlayer(flvLocation:String, maxWidth:Number, maxHeight:Number):void {
			trace("StreamingVideoPlayer instanciated.  flvLocation="+flvLocation+" "+maxWidth+" "+maxHeight);
			//set video params
			_videoURL = flvLocation;
			this.maxWidth = maxWidth;
			this.maxHeight = maxHeight;
			//if (maxHeight>600) {
			//	maxHeight = 600;
			//}
			//add eventListeners to NetConnection and connect
			_main_nc.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
			_main_nc.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			_main_nc.connect(null);
		}
		
		public function resize (maxWidth:Number, maxHeight:Number):void {
			trace("StreamingVideoPlayer -- RESIZE -- maxWidth="+maxWidth+" maxHeight="+maxHeight);
			this.maxWidth = maxWidth;
			this.maxHeight = maxHeight;
			//if (maxHeight>600) { maxHeight = 600; }
			//if (maxWidth<=0) { maxWidth = 10; }
			//if (maxHeight<-0) { maxHeight = 10; }
			if (_video != null) { 
				_video = resizeAndKeepAspect(_video, maxWidth, maxHeight);
			}
			if (_start_btn) {
				_start_btn.x = (maxWidth-_start_btn.width)/2+_video.x;
				_start_btn.y = (maxHeight-_start_btn.height)/2+_video.y;
			}
		}
		
		private function resizeAndKeepAspect(img, boundW, boundH):DisplayObject {
			trace("StreamingVideoPlayer resizeAndKeepAspect() boundW="+boundW+" boundH="+boundH);
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
			if (imgW < 0) { imgW = 0; }
			if (imgH < 0) { imgH = 0; }
			img.width = imgW;
			img.height = imgH;
			trace("StreamingVideoPlayer resizeAndKeepAspect() imgW="+imgW+" imgH="+imgH);
			return img;
		}
		
		
		private function onNetStatus(event:Object):void {
			//handles NetConnection and NetStream status events
			switch (event.info.code) {
				case "NetConnection.Connect.Success":
					//play stream if connection successful
					trace("StreamingVideoPlayer onNetStatus(NetConnection.Connect.Success)");
					connectStream();
					break;
				case "NetStream.Play.StreamNotFound":
					//error if stream file not found in
					//location specified
					trace("StreamingVideoPlayer onNetStatus(NetStream.Play.StreamNotFound)");
					trace("Stream not found: " + _videoURL);
					break;
				case "NetStream.Play.Stop":
					//do if video is stopped
					trace("StreamingVideoPlayer onNetStatus(NetStream.Play.Stop)");
					videoPlayComplete();
					break;
			}
			//trace(event.info.code);
		}
		
		/* -------------------Connection------------------- */
		private function connectStream():void {
			//netstream object
			_ns = new NetStream(_main_nc);
			_ns.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			_ns.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
			//other event handlers assigned 
			//to the netstream client property
			var custom_obj:Object = new Object();
			custom_obj.onMetaData = onMetaDataHandler;
			custom_obj.onCuePoint = onCuePointHandler;
			custom_obj.onPlayStatus = playStatus;
			_ns.client = custom_obj;
			//attach netstream to the video object
			_video = new Video(maxWidth,maxHeight);
			_video.attachNetStream(_ns);
			//video position could be parameterized but hardcoded
			//here to account for optional movie frame border
			_video.x = 0;
			_video.y = 0;
			addChild(_video);
			setVideoInit();
		}
		
		/* -------------NetStream actions and events-------------- */
		private function videoPlayComplete():void {
			setVideoInit();
		}
		
		private function setVideoInit():void {
			try {
				trace("_videoURL="+_videoURL);
				_ns.play(_videoURL);
				_ns.pause();
				_ns.seek(0);
				resize(maxWidth, maxHeight);
				addStartBtn();
			} catch (error:Error) {
				trace(error.toString());
			}
		}
		private function playStatus(event:Object):void {
			//handles onPlayStatus complete event if available
			switch (event.info.code) {
				case "NetStream.Play.Complete":
					//do if video play completes
					videoPlayComplete();
					break;
			}
			//trace(event.info.code);
		}
		private function playFlv(event:MouseEvent):void {
			_ns.play(_videoURL);
			//_ns.seek(192); //used for testing
			removeChild(_start_btn);
		}
		private function pauseFlv(event:MouseEvent):void {
			_ns.pause();
		}
		
		/* ---------Buttons, labels, and other assets------------- */
		//could be placed in it's own VideoControler class
		private function addStartBtn():void {
			_start_btn = new PlayVideoButton();
			//_start_btn.width = 80;
			_start_btn.x = (maxWidth-_start_btn.width)/2+_video.x;
			_start_btn.y = (maxHeight-_start_btn.height)/2+_video.y;
			//_start_btn.label = "Start Video";
			_start_btn.addEventListener(MouseEvent.CLICK,playFlv);
			addChild(_start_btn);
		}
		
		/* -----------------Information handlers---------------- */
		private function onMetaDataHandler(metaInfoObj:Object):void {
			_video.width = metaInfoObj.width;
			_vidWidth = metaInfoObj.width;
			_video.height = metaInfoObj.height;
			_vidHeight = metaInfoObj.height;
			//trace("metadata: duration=" + metaInfoObj.duration + 
				//"width=" + metaInfoObj.width + " height=" +
				//metaInfoObj.height + " framerate=" +
				//metaInfoObj.framerate);
		}
		private function onCuePointHandler(cueInfoObj:Object):void {
			//trace("cuepoint: time=" + cueInfoObj.time + " name=" + 
				//cueInfoObj.name + " type=" + cueInfoObj.type);
		}
		
		/* -----------------------Error handlers------------------------ */
		private function securityErrorHandler(event:SecurityErrorEvent):
		void {
			trace("securityErrorHandler: " + event);
		}
		private function asyncErrorHandler(event:AsyncErrorEvent):void {
			trace(event.text);
		}
	}

	
}