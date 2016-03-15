/**
 * Created by Izurat on 01.03.2016.
 */
package model
{
import VO.ImageVO;

import flash.display.Bitmap;
import flash.geom.Point;

public interface IImageVoFactory
{
    function createImageVO(bitmap:Bitmap):ImageVO
    function resetVOs(imagesForReset:Vector.<ImageVO>):void
    function setPositionsForVOs(vos:Vector.<ImageVO>,fieldSize:Point):void
}
}
