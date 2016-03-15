/**
 * Created by Izurat on 04.03.2016.
 */
package model
{
import VO.ImageVO;

import flash.display.Bitmap;

import utils.UniqueIdDispatcher;

public class BaseImageVOFactory
{
    protected const step:Number = 0.005;

    public function createImageVO(bitmap:Bitmap):ImageVO
    {
        return new ImageVO(bitmap, UniqueIdDispatcher.unigueID);
    }

    public function resetVOs(imagesForReset:Vector.<ImageVO>):void
    {
        for each(var curr:ImageVO in imagesForReset)
        {
            curr.resetPositionAndScale();
        }
    }
}
}
