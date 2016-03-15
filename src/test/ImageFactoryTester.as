/**
 * Created by Izurat on 06.03.2016.
 */
package test
{
import VO.ImageVO;

import flash.display.Sprite;

import model.IImageVoFactory;

public class ImageFactoryTester extends Sprite
{
    private var _testingFactory:IImageVoFactory;

    private var _maxFieldSize:int;
    private var _minFieldSize:int;

    private var _maxImagesCount:int;

    private var _currentFieldSizeX:int;
    private var _currentFieldSizeY:int;

    private var _images:Vector.<ImageVO>;

    public function ImageFactoryTester()
    {
    }

    public function startTesting(testingFactory:IImageVoFactory,minFieldSize:int,maxFieldSize:int,maxImagesCount:int):void
    {
        _testingFactory = testingFactory;
        _minFieldSize = minFieldSize;
        _maxFieldSize = maxFieldSize;
        _maxImagesCount = maxImagesCount;
    }


    private function iterateImageSizeAspect(image:ImageVO):void
    {
        //image.
    }
}
}
