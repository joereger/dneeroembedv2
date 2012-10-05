package com.dneero.answerspanel
{
	import flash.display.MovieClip;
	
	public class QTMatrixCell {
		
		private var row:int = 0;
		private var col:int = 0;
		private var obj:Object = 0;
    

		
		public function QTMatrixCell(col:int, row:int, obj:Object){
			//trace("QTMatrixCell instanciated");
			this.col = col;
			this.row = row;
			this.obj = obj;
		}
		
		
		public function getRow():int{
			return row;
		}
		public function setRow(row:int):void{
			this.row = row;
		}
		
		public function getCol():int{
			return col;
		}
		public function setCol(col:int):void{
			this.col = col;
		}
		
		public function getObj():Object{
			return obj;
		}
		public function setObj(obj:Object):void{
			this.obj = obj;
		}
		
		public function setHeight(height:Number):void{
			if (obj is QTMatrixColname){
				//trace("setting height on cell(row:"+row+", col:"+col+") to "+height);
				QTMatrixColname(obj).colname_txt.width = height;
				QTMatrixColname(obj).colname_txt.y = height;
				//trace("QTMatrixColname(obj).colname_txt.x="+QTMatrixColname(obj).colname_txt.x);
				//trace("QTMatrixColname(obj).colname_txt.y="+QTMatrixColname(obj).colname_txt.y);
			} else if (obj is QTMatrixRowname){
				QTMatrixRowname(obj).rowname_txt.height = height;
			} else if (obj is MovieClip){
				MovieClip(obj).height;
			}
		}
		
		public function getHeight():Number{
			if (obj is QTMatrixColname){
				return QTMatrixColname(obj).colname_txt.textWidth;
			} else if (obj is QTMatrixRowname){
				return QTMatrixRowname(obj).rowname_txt.textHeight;
			} else if (obj is MovieClip){
				return MovieClip(obj).height;
			}
			return obj.height;
		}
		
		public function setWidth(width:Number):void{
			if (obj is QTMatrixColname){
				//trace("setting width on cell(row:"+row+", col:"+col+") to "+width);
				QTMatrixColname(obj).colname_txt.height = width;
				//trace("QTMatrixColname(obj).colname_txt.x="+QTMatrixColname(obj).colname_txt.x);
				//trace("QTMatrixColname(obj).colname_txt.y="+QTMatrixColname(obj).colname_txt.y);
			} else if (obj is QTMatrixRowname){
				QTMatrixRowname(obj).rowname_txt.width = width;
			} else if (obj is MovieClip){
				MovieClip(obj).width;
			}
		}
		
		public function getWidth():Number{
			if (obj is QTMatrixColname){
				return QTMatrixColname(obj).colname_txt.textHeight;
			} else if (obj is QTMatrixRowname){
				return QTMatrixRowname(obj).rowname_txt.textWidth;
			} else if (obj is MovieClip){
				return MovieClip(obj).width;
			}
			return obj.width;
		}
		
		public function getX():Number{
			return obj.x;
		}
		
		public function getY():Number{
			return obj.y;
		}
		
	}
	
	
}