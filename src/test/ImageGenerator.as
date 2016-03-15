/**
 * Created by Izurat on 06.03.2016.
 */
package test
{
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;

public class ImageGenerator
{
    private const step:int = 20;

    public function ImageGenerator()
    {
    }

    public function generateImage(width:int, height:int):Bitmap
    {
        var i:int;
        var resShape:Shape = new Shape();
        resShape.width = width;
        resShape.height = height;
        resShape.graphics.beginFill(0x00FF00, 0.5);

        resShape.graphics.lineStyle(1, 0x00FFFF);
        for (i = 0; i < width / step; i++)
        {
            resShape.graphics.moveTo(i * step, 0);
            resShape.graphics.lineTo(i * step, height);
        }
        for (i = 0; i < height / step; i++)
        {
            resShape.graphics.moveTo(0, i * step);
            resShape.graphics.lineTo(width, i * step);
        }
        resShape.graphics.moveTo(1, 1);
        resShape.graphics.lineStyle(2, 0x0000FF);
        resShape.graphics.drawRect(1, 1, width-2, height-2);

        var resBD:BitmapData= new BitmapData(width,height);
        resBD.draw(resShape);
        var res:Bitmap = new Bitmap(resBD);
        return res;

    }
}
}
