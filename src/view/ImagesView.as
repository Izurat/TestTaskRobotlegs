/**
 * Created by Izurat on 25.02.2016.
 */
package view
{
import flash.display.Shape;
import flash.display.Sprite;

public class ImagesView extends Sprite
{
    public function ImagesView()
    {
        super();
        var shape:Shape = new Shape();
        shape.graphics.lineStyle(12, 0x00FF00);
        shape.graphics.drawRect(0, 0, 200,200);
        addChild(shape);
    }
}
}
