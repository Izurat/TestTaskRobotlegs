/**
 * Created by Izurat on 25.02.2016.
 */
package model
{
import VO.ImageVO;

import flash.display.Bitmap;
import flash.geom.Point;

import service.ImagesService;

import signals.DisplayImagesSignal;
import signals.RemoveImageSignal;


public class Model
{
    [Inject]
    public var imagesService:ImagesService;

    [Inject]
    public var imageFactory:IImageVoFactory;

    [Inject]
    public var $displayImagesSignal:DisplayImagesSignal;

    [Inject]
    public var $removeImageSignal:RemoveImageSignal;

    private var _bitmapVOs:Vector.<ImageVO>;

    [PostConstruct]
    public function initialize():void
    {
        _bitmapVOs = new Vector.<ImageVO>();
        imagesService.$onImageLoaded.add(onImageLoaded);

    }

    public function changeImage(imageID:int):void
    {
        for(var i:int = 0;i<_bitmapVOs.length;i++)
        {
            if(_bitmapVOs[i].id == imageID)
            {
                $removeImageSignal.send(imageID);
                _bitmapVOs.splice(i,1);
                break;
            }
        }
        imagesService.loadRandomImage();
    }

    private function onImageLoaded(image:Bitmap):void
    {
        var newVO:ImageVO = imageFactory.createImageVO(image);
        _bitmapVOs.push(newVO);
        imageFactory.resetVOs(_bitmapVOs);
        imageFactory.setPositionsForVOs(_bitmapVOs,new Point(200,200));
        $displayImagesSignal.send(_bitmapVOs);
    }
}
}
