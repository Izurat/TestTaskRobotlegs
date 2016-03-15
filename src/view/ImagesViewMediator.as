/**
 * Created by Izurat on 24.02.2016.
 */
package view
{
import Controller.OnUserClickSignal;

import VO.ImageVO;

import com.greensock.TweenMax;
import com.greensock.data.TweenMaxVars;

import flash.events.Event;
import flash.events.MouseEvent;

import org.robotlegs.mvcs.Mediator;

import signals.DisplayImagesSignal;
import signals.RemoveImageSignal;

import view.ImageDisplay;

import view.ImagesView;

public class ImagesViewMediator extends Mediator
{
    [Inject]
    public var imagesView:ImagesView;

    [Inject]
    public var $onClicked:OnUserClickSignal;

    [Inject]
    public var $displayImagesSignal:DisplayImagesSignal;

    [Inject]
    public var $removeImageSignal:RemoveImageSignal;

    private var _imagesOnView:Vector.<ImageDisplay>;

    private var _currentTween:TweenMax;

    public function ImagesViewMediator()
    {
        super();
        _imagesOnView = new Vector.<ImageDisplay>();
    }

    override public function onRegister():void
    {
        imagesView.addEventListener(MouseEvent.CLICK, onMouseClick);
        $displayImagesSignal.add(applyImages);
        $removeImageSignal.add(removeImage);
    }

    private function onMouseClick(e:Event):void
    {
        if(e.target is ImageDisplay)
        {
            var currTarget:ImageDisplay = e.target as ImageDisplay;
            $onClicked.send(currTarget.id);
        }
        else if(_imagesOnView.length == 0)
        {
            $onClicked.send(-1);
        }
    }

    private var waitingImages:Vector.<ImageVO>;

    private function applyImages(images:Vector.<ImageVO>):void
    {
        waitingImages = images;
        fadeOut();
    }

    private function displayImages():void
    {
        var currImageDisplay:ImageDisplay;
        for each(currImageDisplay in _imagesOnView)
        {
            currImageDisplay.parent.removeChild(currImageDisplay);
        }
        _imagesOnView = new Vector.<ImageDisplay>();
        for each(var curr:ImageVO in waitingImages)
        {
            currImageDisplay = new ImageDisplay(curr.bitmap, curr.id);
            currImageDisplay.scaleFactor = curr.scaleValue;
            currImageDisplay.x = curr.positionX;
            currImageDisplay.y = curr.positionY;
            _imagesOnView.push(currImageDisplay);
            currImageDisplay.updateGraphics();
            imagesView.addChild(currImageDisplay);
        }
    }

    private function removeImage(id:int):void
    {
        var currImage:ImageDisplay;
        for (var i:int = 0; i < _imagesOnView.length; i++)
        {
            currImage = _imagesOnView[i];
            if (currImage.id == id)
            {
                imagesView.removeChild(currImage);
                _imagesOnView.splice(i, 1);
                return;
            }
        }
    }


    private function clearCurrentTween():void
    {
        if (_currentTween)
        {
            _currentTween.kill();
            _currentTween = null;
        }

    }

    private function onFadeInHandler():void
    {
        clearCurrentTween();
    }

    private function onFadeOutHandler():void
    {
        displayImages();
        fadeIn();
    }

    private function fadeIn():void
    {
        clearCurrentTween();
        var tweenMaxVars:TweenMaxVars = new TweenMaxVars();
        tweenMaxVars.autoAlpha(1);
        tweenMaxVars.onComplete(onFadeInHandler);
        _currentTween = TweenMax.to(imagesView, 1, tweenMaxVars);
    }

    private function fadeOut():void
    {
        clearCurrentTween();
        var tweenMaxVars:TweenMaxVars = new TweenMaxVars();
        tweenMaxVars.autoAlpha(0);
        tweenMaxVars.onComplete(onFadeOutHandler);
        _currentTween = TweenMax.to(imagesView, 1, tweenMaxVars);
    }

}
}
