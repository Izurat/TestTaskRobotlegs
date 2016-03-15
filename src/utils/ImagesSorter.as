/**
 * Created by Izurat on 04.03.2016.
 */
package utils
{
import VO.ImageVO;

import flash.geom.Point;
import flash.geom.Rectangle;

public class ImagesSorter
{
    private var _fieldRect:Rectangle;

    private var _placedVOs:Vector.<ImageVO>;

    private const offset:int = 1;

    public function ImagesSorter()
    {
        _placedVOs = new Vector.<ImageVO>();
    }


    public function tryDistributeImages(imageVOs:Vector.<ImageVO>, fieldSize:Point):Boolean
    {
        _fieldRect = new Rectangle(0, 0, fieldSize.x, fieldSize.y);
        imageVOs =imageVOs.slice();
        sortImageVOsBySize(imageVOs);

        for each(var currPlacingVO:ImageVO in imageVOs)
        {
            if (!placeVOIfPossible(currPlacingVO))
            {
                return false;
            }
        }
        return true;
    }

    public function distributeImages(imageVOs:Vector.<ImageVO>, fieldSize:Point):void
    {
        _fieldRect = new Rectangle(1, 0, fieldSize.x, fieldSize.y);
        imageVOs =imageVOs.slice();
        sortImageVOsBySize(imageVOs);
        for each(var currPlacingVO:ImageVO in imageVOs)
        {
            placeVOIfPossible(currPlacingVO);
        }
    }

    private function placeVOIfPossible(placingVO:ImageVO):Boolean
    {
        if (_placedVOs.length==0)
        {
            placingVO.setPosition(1,1);
            if (checkIsPlacedCorrectly(placingVO))
            {
                _placedVOs.push(placingVO);
                return true;
            }
        }
        for each(var currPlacedVO:ImageVO in _placedVOs)
        {
            placingVO.setPosition(currPlacedVO.topRight.x + offset, currPlacedVO.topRight.y);
            if (checkIsPlacedCorrectly(placingVO))
            {
                _placedVOs.push(placingVO);
                return true;
            }
            placingVO.setPosition(currPlacedVO.downLeft.x, currPlacedVO.downRight.y + offset);
            if (checkIsPlacedCorrectly(placingVO))
            {
                _placedVOs.push(placingVO);
                return true;
            }
        }
        return false;
    }

    private function checkIsPlacedCorrectly(placedVO:ImageVO):Boolean
    {
        for each(var currPlacedVO:ImageVO in _placedVOs)
        {
            if (currPlacedVO.getIsIntersectsWithRect(placedVO.rect))
            {
                return false;
            }
        }
        if (!placedVO.getIsInscribedInRect(_fieldRect))
        {
            return false;
        }
        return true;
    }

    private function sortImageVOsBySize(VOs:Vector.<ImageVO>):Vector.<ImageVO>
    {
        var tmp:ImageVO;

        for (var i:int = 0; i < VOs.length - 1; i++)
        {
            for (var j:int = 0; j < VOs.length - i - 1; j++)
            {
                if (VOs[j].scaledSize < VOs[j + 1].scaledSize)
                {
                    tmp = VOs[j];
                    VOs[j] = VOs[j + 1];
                    VOs[j + 1] = tmp;
                }
            }
        }
        return VOs;
    }

}
}
