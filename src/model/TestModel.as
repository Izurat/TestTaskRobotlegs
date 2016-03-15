/**
 * Created by Izurat on 08.03.2016.
 */
package model
{
import VO.ImageVO;

import flash.display.Bitmap;
import flash.events.Event;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.utils.Timer;

import signals.DisplayImagesSignal;

import test.TestImagesPackGenerator;

public class TestModel
{
    private const _minImagesCount:int = 1;
    private const _sizeChangeStepsCount:int = 3;
    private const _maxImagesCount:int = 10;
    private const _minImageSize:int = 30;
    private const _maxImageSize:int = 300;

    private var _updateTimer:Timer;
    private const updateDelay:int = 1500;



    [Inject]
    public var $displayImagesSignal:DisplayImagesSignal;

    [Inject]
    public var imageFactory:IImageVoFactory;


    private var _imagesPackGenerator:TestImagesPackGenerator;

    public function TestModel()
    {
        _imagesPackGenerator = new TestImagesPackGenerator(_minImagesCount,_maxImagesCount,_minImageSize,_maxImageSize,_sizeChangeStepsCount);
    }

    public function changeImage(imageID:int):void
    {
        initTimer();
    }

    private function initTimer():void
    {
        clearTimer();
        _updateTimer = new Timer(updateDelay);
        _updateTimer.addEventListener(TimerEvent.TIMER, changeImageByTimer);
        _updateTimer.start();
    }

    private function clearTimer():void
    {
        if(_updateTimer)
        {
            _updateTimer.removeEventListener(TimerEvent.TIMER, changeImageByTimer);
            _updateTimer = null;
        }
    }

    private function changeImageByTimer(e:Event):void
    {
        var bitmaps:Vector.<Bitmap> = _imagesPackGenerator.nextImagesPack;
        var VOs:Vector.<ImageVO> = new Vector.<ImageVO>();
        for each(var currBitmap:Bitmap in bitmaps)
        {
            VOs.push(imageFactory.createImageVO(currBitmap));
        }
        imageFactory.resetVOs(VOs);
        imageFactory.setPositionsForVOs(VOs,new Point(200,200));
        $displayImagesSignal.send(VOs);
    }
}
}
