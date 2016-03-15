/**
 * Created by Izurat on 29.02.2016.
 */
package model
{
import VO.ImageVO;

import flash.geom.Point;
import flash.geom.Rectangle;

import utils.MaxRect;


public class ImageVOMaxRectAlgorytmFactory extends BaseImageVOFactory implements IImageVoFactory
{

    public function setPositionsForVOs(vos:Vector.<ImageVO>, fieldSize:Point):void
    {
        resetVOs(vos);
        fillField(vos, fieldSize, 1);
    }

    private function fillField(imageVOs:Vector.<ImageVO>, fieldSize:Point, prevChangingScaleFactorCoef:Number):void
    {
        decreaseScaleValueOfElements(imageVOs, fieldSize);
        increaseScaleValueToAnyElement(imageVOs, fieldSize);
    }

    private function decreaseScaleValueOfElements(imageVOs:Vector.<ImageVO>, fieldSize:Point):void
    {
        if (isPossibleToDraw(imageVOs, fieldSize))
        {
            updatePositions(imageVOs, fieldSize);
            return;
        }
        else
        {
            for each(var curr:ImageVO in imageVOs)
            {
                curr.scaleValue -= step;
                if(isPossibleToDraw(imageVOs, fieldSize))
                {
                    updatePositions(imageVOs, fieldSize);
                    return;
                }
            }
        }
        decreaseScaleValueOfElements(imageVOs, fieldSize);
    }

    private function increaseScaleValueToAnyElement(imageVOs:Vector.<ImageVO>, fieldSize:Point):void
    {
        var isAnyIncreased:Boolean = false;
        for each(var curr:ImageVO in imageVOs)
        {
            curr.scaleValue += step;
            if (!isPossibleToDraw(imageVOs, fieldSize))
            {
                curr.scaleValue -= step;
            }
            else
            {
                isAnyIncreased = true;
            }
        }
        if (isAnyIncreased)
        {
            updatePositions(imageVOs, fieldSize);
            increaseScaleValueToAnyElement(imageVOs, fieldSize);
        }
    }

    private function isPossibleToDraw(imageVOs:Vector.<ImageVO>, fieldSize:Point):Boolean
    {
        sortImageVOsBySize(imageVOs);
        var currentMaxRectUtil:MaxRect = new MaxRect(fieldSize.x, fieldSize.y);
        for each(var curr:ImageVO in imageVOs)
        {
            var resRect:Rectangle = currentMaxRectUtil.quickInsert(curr.scaledSizeX, curr.scaledSizeY);
            if (resRect == null)
            {
                return false;
            }
        }
        return true;
    }

    private function updatePositions(imageVOs:Vector.<ImageVO>, fieldSize:Point):void
    {
        sortImageVOsBySize(imageVOs);
        var currentMaxRectUtil:MaxRect = new MaxRect(fieldSize.x, fieldSize.y);
        for each(var curr:ImageVO in imageVOs)
        {
            var resRect:Rectangle = currentMaxRectUtil.quickInsert(curr.scaledSizeX, curr.scaledSizeY);
            curr.setPosition(resRect.x, resRect.y);
        }
    }

    private function sortImageVOsBySize(imageVOs:Vector.<ImageVO>):void
    {
        var tmp:ImageVO;
        for (var i:int = 0; i < imageVOs.length-1; i++)
        {
            for(var j:int = 0; j < imageVOs.length-i-1; j++)
            {
                if(imageVOs[j].scaledSize> imageVOs[j+1].scaledSize)
                {
                    tmp = imageVOs[j];
                    imageVOs[j] = imageVOs[j+1];
                    imageVOs[j+1] = tmp;
                }
            }
        }
    }
}
}
