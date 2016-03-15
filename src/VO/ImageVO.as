/**
 * Created by Izurat on 01.03.2016.
 */
package VO
{
import flash.display.Bitmap;
import flash.geom.Point;
import flash.geom.Rectangle;

public class ImageVO
{
    private var _bitmap:Bitmap;
    private var _scaleValue:Number;
    private var _id:int;

    private var _positionX:int;
    private var _positionY:int;

    public function ImageVO(bitmap:Bitmap,id:int)
    {
        _bitmap = bitmap;
        _id = id;
        resetPositionAndScale();
    }

    public function resetPositionAndScale():void
    {
        _scaleValue = 1;
        resetPosition();
    }

    public function resetPosition():void
    {
        _positionX = 0;
        _positionY = 0;
    }

    public function setPosition(x:int,y:int):void
    {
        _positionX = x;
        _positionY = y;
    }


    public function get bitmap():Bitmap
    {
        return _bitmap;
    }

    public function get scaleValue():Number
    {
        return _scaleValue;
    }

    public function get id():int
    {
        return _id;
    }

    public function get positionX():int
    {
        return _positionX;
    }

    public function get positionY():int
    {
        return _positionY;
    }

    public function get scaledSizeX():int
    {
        return _bitmap.width*scaleValue;
    }

    public function get scaledSizeY():int
    {
        return _bitmap.height*scaleValue;
    }

    public function get sizeX():int
    {
        return _bitmap.width;
    }

    public function get sizeY():int
    {
        return _bitmap.height;
    }

    public function set scaleValue(value:Number):void
    {
        _scaleValue = value;
    }

    public function get scaledSize():int
    {
        return scaledSizeX*scaledSizeY;
    }

    public function get topRight():Point
    {
        return new Point(_positionX+scaledSizeX,_positionY);
    }

    public function get downLeft():Point
    {
        return new Point(_positionX,_positionY+scaledSizeY);
    }

    public function get downRight():Point
    {
        return new Point(_positionX+scaledSizeX,_positionY+scaledSizeY);
    }

    public function get topLeft():Point
    {
        return new Point(_positionX,_positionY);
    }

    public function get rect():Rectangle
    {
        return new Rectangle(positionX,positionY,scaledSizeX,scaledSizeY);
    }

    public function getIsIntersectsWithRect(checkingRect:Rectangle):Boolean
    {
        var intersection:Rectangle = checkingRect.intersection(rect);
        return intersection.width !=0 && intersection.height !=0;
    }

    public function getIsInscribedInRect(checkingRect:Rectangle):Boolean
    {
        var res:Boolean = checkingRect.containsRect(rect);
        return res;
    }

    public function get leastScaleValue():Number
    {
        if(sizeX<=sizeY)
        {
            return 2/sizeX;
        }
        return 2/sizeY;
    }

}
}
