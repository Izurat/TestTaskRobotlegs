/**
 * Created by Izurat on 04.03.2016.
 */
package model
{
import VO.ImageVO;

import flash.geom.Point;

import utils.ImagesSorter;

public class ImageVOSimpleAlgorytmFactory extends BaseImageVOFactory implements IImageVoFactory
{
    public function ImageVOSimpleAlgorytmFactory()
    {
    }


    public function setPositionsForVOs(vos:Vector.<ImageVO>, fieldSize:Point):void
    {
        resetVOs(vos);
        if(decreaseScaleToCompatible(vos, fieldSize))
        {
            increaseScaleIfPossible(vos, fieldSize);
        }
        new ImagesSorter().distributeImages(vos,fieldSize);
    }
    private function increaseScaleIfPossible(vos:Vector.<ImageVO>, fieldSize:Point):void
    {
        if (!new ImagesSorter().tryDistributeImages(vos, fieldSize))
        {
            return;
        }
        var isAnyScaled:Boolean = false;
        for each(var currImage:ImageVO in vos)
        {
            currImage.scaleValue += step;
            if (!new ImagesSorter().tryDistributeImages(vos, fieldSize))
            {
                currImage.scaleValue -= step;
            }
            else
            {
                isAnyScaled = true
            }
        }
        if(isAnyScaled)
        {
            increaseScaleIfPossible(vos, fieldSize);
        }
    }

    private function decreaseScaleToCompatible(vos:Vector.<ImageVO>, fieldSize:Point):Boolean
    {
        if (new ImagesSorter().tryDistributeImages(vos, fieldSize))
        {
            return true;
        }
        var scaledToLimitCounter:int = 0;
        var resScaleValue:Number;
        for each(var currImage:ImageVO in vos)
        {
            resScaleValue = currImage.scaleValue - step;
            if (resScaleValue < currImage.leastScaleValue)
            {
                resScaleValue = currImage.leastScaleValue;
                scaledToLimitCounter++;
            }
            currImage.scaleValue = resScaleValue;
            if (new ImagesSorter().tryDistributeImages(vos, fieldSize))
            {
                return true;
            }
        }
        if(scaledToLimitCounter  == vos.length)
        {
            return false;
        }
        return decreaseScaleToCompatible(vos, fieldSize);
    }
}
}
