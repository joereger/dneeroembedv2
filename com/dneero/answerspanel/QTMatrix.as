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
	import com.dneero.answerspanel.QTMatrixCell;

	
	public class QTMatrix extends MovieClip implements QuestionType {
		
		private var questionid:int;
		private var rows:Array;
		private var cols:Array;
		private var questionXML:XML;
		private var cells:Array;
		private var CELLSPACING:Number = 5;
		
		
		public function QTMatrix(questionXML:XML){
			//trace("QTMatrix instanciated");
			if (stage) {initListener(null);} else {addEventListener(Event.ADDED_TO_STAGE, initListener);}
		    this.questionXML = questionXML;
			this.questionid = questionXML.attribute("questionid");
			//trace(questionXML);
			
			rows = new Array();
			var rowList:XMLList  = questionXML.rows.row;
			for each (var row:XML in rowList) {
				rows.push(row.text());
			}
			
			cols = new Array();
			var colList:XMLList  = questionXML.cols.col;
			for each (var col:XML in colList) {
				cols.push(col.text());
			}
		}
		
		
		function initListener (e:Event):void {
			//trace("QTMatrix.initListener() called");
			removeEventListener(Event.ADDED_TO_STAGE, initListener);
			//Put the upper left item in
			cells = new Array();
			var itm;
			var cell;
			var colnum:int = 0;
			var rownum:int = 0;
			for each (var row:String in rows) {
				colnum = 0;
				for each (var col:String in cols) {
					//If we're just gettin' goin'
					if (colnum==0 && rownum==0){
						//Add the upper left box
						itm = new QTMatrixRowname();
						itm.rowname_txt.text = " ";
						cell = new QTMatrixCell(0, 0, itm);
						addChild(itm);
						cells.push(cell);
					    //Add the col names
						var colnum_top_row = 1;
						for each (var colname:String in cols) {
							itm = new QTMatrixColname();
							itm.colname_txt.htmlText = colname + "";
							itm.colname_txt.wordWrap = true;
							itm.colname_txt.autoSize = TextFieldAutoSize.LEFT;
							cell = new QTMatrixCell(colnum_top_row, 0, itm);
							addChild(itm);
							cells.push(cell);
							colnum_top_row = colnum_top_row + 1;
						}
					}
					//Add rowname
					if (colnum==0){
						itm = new QTMatrixRowname();
						itm.rowname_txt.htmlText = row + "";
						itm.rowname_txt.wordWrap = true;
						itm.rowname_txt.autoSize = TextFieldAutoSize.LEFT;
						cell = new QTMatrixCell(0, rownum+1, itm);
						addChild(itm);
						cells.push(cell);
					}
					//Add main on/off checks
					if (isChecked(row, col)){
						itm = new QTMatrixOn();
						cell = new QTMatrixCell(colnum+1, rownum+1, itm);
						addChild(itm);
						cells.push(cell);
					} else {
						itm = new QTMatrixOff();
						cell = new QTMatrixCell(colnum+1, rownum+1, itm);
						addChild(itm);
						cells.push(cell);
					}
					colnum = colnum + 1;
				}
				rownum = rownum+1;
			}
		}
		
	
		

		public function resize (maxWidth:Number, maxHeight:Number):void {
			//trace("QTMatrix -- RESIZE -- maxWidth="+maxWidth+" maxHeight="+maxHeight);
			//Choose a hard-coded max height
			var maxHeightOfColnames:Number = 150;  //trace("maxHeightOfColnames="+maxHeightOfColnames);
			//Set to that height
			setRowHeight(0, maxHeightOfColnames); //trace("setRowHeight() done");
			//See what the max height is
			var maxHeightOfColnamesComplex:Number = maxRowHeight(0);  //trace("maxHeightOfColnamesComplex="+maxHeightOfColnamesComplex);
			//Choose the smaller of the two
			if (maxHeightOfColnamesComplex<maxHeightOfColnames){maxHeightOfColnames = maxHeightOfColnamesComplex;} 
			//Add spacing
			maxHeightOfColnames = maxHeightOfColnames + CELLSPACING; //trace("(final) maxHeightOfColnames="+maxHeightOfColnames);
			//Set row height for col names
			setRowHeight(0, maxHeightOfColnames);  //trace("setRowHeight() done");
			//Do a simple calculation of checkbox width based on the number of columns
			var maxWidthOfCheckboxes:Number = maxWidthOfCheckbox() * cols.length;  //trace("maxWidthOfCheckboxes="+maxWidthOfCheckboxes);
			//Do a more complex calculation of checkbox width
			var maxWidthOfCheckboxesComplex:Number = widthOfColNames();  //trace("maxWidthOfCheckboxesComplex="+maxWidthOfCheckboxesComplex);
			//Choose the larger of the two checkbox widths
			if (maxWidthOfCheckboxesComplex>maxWidthOfCheckboxes){ maxWidthOfCheckboxes = maxWidthOfCheckboxesComplex; } //trace("(final) maxWidthOfCheckboxes="+maxWidthOfCheckboxes);
			//Subtract the width of the checkboxes to see how much width I can use for the row names
			var maxWidthOfRownames:Number = maxWidth - maxWidthOfCheckboxes;  //trace("maxWidthOfRownames="+maxWidthOfRownames);
			//But if the row names are too thin I need to widen them
			if (maxWidthOfRownames<50){maxWidthOfRownames=50;} 
			//Add spacing
			maxWidthOfRownames = maxWidthOfRownames; //trace("(final) maxWidthOfRownames="+maxWidthOfRownames);
			//Set the col width for the row names
			setColWidth(0, maxWidthOfRownames);  //trace("setColWidth() done");
			//Iterate each cell, setting x and y
			for each (var cell:QTMatrixCell in cells) {
				cell.getObj().x = getMyX(cell);
				cell.getObj().y = getMyY(cell);
				if (cell.getRow()==0){
					//trace("cell(row:"+cell.getRow()+", col:"+cell.getCol()+")");
					//trace("cell.getObj().x="+cell.getObj().x);
					//trace("cell.getObj().y="+cell.getObj().y);
				}
			}
		}
		
		
		
		public function getQuestionid():int{
			return questionid;
		}
		
		private function isChecked(row:String, col:String):Boolean{
			var checkedList:XMLList  = questionXML.checked.rowcolpair;
			for each (var rowcolpair:XML in checkedList) {
				if (rowcolpair.attribute("row")==row && rowcolpair.attribute("col")==col){
					return true;
				}
			}
			return false;
		}
		
		private function getMyX(cell:QTMatrixCell):Number{
			for each (var othercell:QTMatrixCell in cells) {
				//If this cell is in my row
				if(othercell.getRow()==cell.getRow()){
					//If this cell is immediately to my left
					if(othercell.getCol()==cell.getCol()-1){
						var widthOfColsToLeft:Number = 0;
						for (var i=0; i<cell.getCol(); i++){
							widthOfColsToLeft = widthOfColsToLeft + maxColWidth(i);
						}
						return widthOfColsToLeft + (cell.getCol()*CELLSPACING);
					}
				}
			}
			return 0;
		}
		
		private function getMyY(cell:QTMatrixCell):Number{
			for each (var othercell:QTMatrixCell in cells) {
				//If this cell is in my col
				if(othercell.getCol()==cell.getCol()){
					//If this cell is immediately to my left
					if(othercell.getRow()==cell.getRow()-1){
						var heightOfRowsAbove:Number = 0;
						for (var i=0; i<cell.getRow(); i++){
							heightOfRowsAbove = heightOfRowsAbove + maxRowHeight(i);
						}
						return heightOfRowsAbove + (cell.getRow()*CELLSPACING);
					}
				}
			}
			return 0;
		}
		
		private function widthOfColNames():Number{
			var widthOfColNames:Number = 0;
			for each (var cell:QTMatrixCell in cells) {
				//If this is a col title
				if(cell.getRow()==0){
					//And not the top left cell
					if(cell.getCol()>0){
						widthOfColNames = widthOfColNames + maxColWidth(cell.getCol()) + CELLSPACING;
					}
				}
			}
			return widthOfColNames;
		}
		
		private function heightOfRowNames():Number{
			var heightOfRowNames:Number = 0;
			for each (var cell:QTMatrixCell in cells) {
				//If this is a row title
				if(cell.getCol()==0){
					//And not the top left cell
					if(cell.getRow()>0){
						heightOfRowNames = heightOfRowNames + maxRowHeight(cell.getRow()) + CELLSPACING;
					}
				}
			}
			return heightOfRowNames;
		}
		
		private function maxColHeight(col:int):Number{
			var max = 0;
			for each (var cell:QTMatrixCell in cells) {
				if(cell.getCol()==col){
					if (cell.getHeight() > max){
						max = cell.getHeight();
					}
				}
			}
			return max;
		}
		
		private function maxColWidth(col:int):Number{
			var max = 0;
			for each (var cell:QTMatrixCell in cells) {
				if(cell.getCol()==col){
					if (cell.getWidth() > max){
						max = cell.getWidth();
					}
				}
			}
			return max;
		}
		
		private function maxRowHeight(row:int):Number{
			var max = 0;
			for each (var cell:QTMatrixCell in cells) {
				if(cell.getRow()==row){
					if (cell.getHeight() > max){
						max = cell.getHeight();
					}
				}
			}
			return max;
		}
		
		private function maxRowWidth(row:int):Number{
			var max = 0;
			for each (var cell:QTMatrixCell in cells) {
				if(cell.getRow()==row){
					if (cell.getWidth() > max){
						max = cell.getWidth();
					}
				}
			}
			return max;
		}
		
		private function maxWidthOfCheckbox():Number{
			var max:Number = 0;
			var on = new QTMatrixOn();
			if (on.width > max){
				max = on.width;
			}
			var off = new QTMatrixOff();
			if (off.width > max){
				max = off.width;
			}
			return max;
		}
		
		private function maxHeightOfCheckbox():Number{
			var max:Number = 0;
			var on = new QTMatrixOn();
			if (on.height > max){
				max = on.height;
			}
			var off = new QTMatrixOff();
			if (off.height > max){
				max = off.height;
			}
			return max;
		}
		
		private function setRowHeight(row:int, height:Number):void{
			for each (var cell:QTMatrixCell in cells) {
				if(cell.getRow()==row){
					cell.setHeight(height);
				}
			}
		}
		
		private function setRowWidth(row:int, width:Number):void{
			for each (var cell:QTMatrixCell in cells) {
				if(cell.getRow()==row){
					cell.setWidth(width);
				}
			}
		}
		
		private function setColHeight(col:int, height:Number):void{
			for each (var cell:QTMatrixCell in cells) {
				if(cell.getCol()==col){
					cell.setHeight(height);
				}
			}
		}
		
		private function setColWidth(col:int, width:Number):void{
			for each (var cell:QTMatrixCell in cells) {
				if(cell.getCol()==col){
					cell.setWidth(width);
				}
			}
		}
		
		
		
	}
	
	
}