/**
 * Created by Izurat on 07.03.2016.
 */
package test
{
import flash.display.Bitmap;
import flash.geom.Point;

public class TestImagesPackGenerator
{
    private var _minImagesCount:int;
    private var _maxImagesCount:int;

    private var _minImageSize:int;
    private var _maxImageSize:int;
    private var _sizeChangeSteps:int;

    private var _sizes:Vector.<Point>;

    private var _sizeStep:int;

    private var _imagesGenerator:ImageGenerator;

    public function TestImagesPackGenerator(minImagesCount:int,maxImagesCount:int,minImageSize:int,maxImageSize:int,sizeChangeSteps:int)
    {
        _maxImagesCount = maxImagesCount;
        _maxImageSize = maxImageSize;
        _minImagesCount = minImagesCount;
        _minImageSize = minImageSize;

        _sizeChangeSteps = sizeChangeSteps;
        _sizeStep = (maxImageSize - minImageSize)/sizeChangeSteps;
        _imagesGenerator = new ImageGenerator();
        initSizes();

    }

    private function initSizes():void
    {
        _sizes = new Vector.<Point>();
        for(var i:int =0;i<_minImagesCount;i++)
        {
            _sizes.push(new Point(_minImageSize,_minImageSize));
        }
    }

    public function get nextImagesPack():Vector.<Bitmap>
    {
        updateSizes();
        var res:Vector.<Bitmap> = new Vector.<Bitmap>;
        for each(var currSize:Point in _sizes)
        {
            res.push(_imagesGenerator.generateImage(currSize.x,currSize.y));
        }
        return res;
    }

    private function updateSizes(startSizeIndex:int = 0):void
    {
        var currSize:Point;
        if(startSizeIndex>=_sizes.length)
        {
            if(_sizes.length<_maxImagesCount)
            {
                _sizes.push(new Point(_minImageSize,_minImageSize));
                updateSizes(startSizeIndex);
                return;
            }
            else
            {
                initSizes();
                return;
            }
        }
        else
        {
            currSize = _sizes[startSizeIndex];
            if(currSize.y>=_maxImageSize)
            {
                if(currSize.x<=_minImageSize)
                {
                    currSize.x = _minImageSize;
                    currSize.y = _minImageSize;
                    updateSizes(startSizeIndex+1);
                }
                currSize.x-= _sizeStep;
                if(currSize.x<_minImageSize)
                {
                    currSize.x = _minImageSize;
                }
            }
            else if(currSize.x<_maxImageSize)
            {
                currSize.x+=_sizeStep;
                if(currSize.x>_maxImageSize)
                {
                    currSize.x = _maxImageSize;
                }
            }
            else
            {
                currSize.y+=_sizeStep;
                if(currSize.y>_maxImageSize)
                {
                    currSize.y = _maxImageSize;
                }
            }
        }
    }
}
}
