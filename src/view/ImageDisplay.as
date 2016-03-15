/**
 * Created by Izurat on 27.02.2016.
 */
package view
{
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.geom.Point;

public class ImageDisplay extends Sprite
{
    private var _id:int;
    private var _originalSize:Point;
    private var _scaleFactor:Number;

    private var _bitmap:Bitmap;

    public function ImageDisplay(bitmap:Bitmap, id:int)
    {
        _id = id;
        _bitmap = bitmap;
        _originalSize = new Point(bitmap.width, bitmap.height);
    }

    public function set scaleFactor(scaleFactor:Number):void
    {
        _scaleFactor = scaleFactor;
    }

    public function updateGraphics():void
    {
        addChild(_bitmap);
        scaleX = _scaleFactor;
        scaleY = _scaleFactor;
    }

    public function get id():int
    {
        return _id;
    }
}
}
