/**
 * Created by Izurat on 25.02.2016.
 */
package service
{
import flash.display.Loader;
import flash.events.Event;
import flash.net.URLLoader;
import flash.net.URLRequest;

import org.robotlegs.mvcs.Actor;

import signals.SignalBitmap;

public class ImagesService extends Actor implements IImagesService
{
    private var _configURL:String = "https://dl.dropboxusercontent.com/u/6835411/cats/cats.xml";
    private var _config:XML;
    private var _xmlLoader:URLLoader;
    private var _imageLoader:Loader;

    private var _links:Vector.<String>;

    private var _$onImageLoaded:SignalBitmap = new SignalBitmap();

    private var _waitingImagesCounter:int;

    private var _isRequiredToLoadInitialImages:Boolean = false;

    public function ImagesService()
    {
        _waitingImagesCounter = 0;
        super();
        CONFIG::debug
        {
            return;
        }
        _xmlLoader = new URLLoader();
        _xmlLoader.addEventListener(Event.COMPLETE, xmlLoaded);
        _xmlLoader.load(new URLRequest(_configURL));
    }

    private function xmlLoaded(e:Event):void
    {
        _xmlLoader.removeEventListener(Event.COMPLETE, xmlLoaded);
        _config = XML(_xmlLoader.data);
        var length:int = _config.image.length();
        _links = new Vector.<String>();
        for (var i:int = 0; i < length; i++)
        {
            _links.push(_config.image[i].@link);
        }
        _xmlLoader = null;
        loadInitImages();
    }

    //todo unit test here;
    public function loadRandomImage():void
    {
        _waitingImagesCounter++;
        loadImargeIfRequiredAndPossible();
    }

    public function loadInitImages():void
    {
        if (_config == null)
        {
            _isRequiredToLoadInitialImages = true;
            return;
        }
        _isRequiredToLoadInitialImages = false;
        var imagesCount:int = _config.imagesCount.@value;
        _waitingImagesCounter += imagesCount;
        loadImargeIfRequiredAndPossible();
    }

    private function loadImargeIfRequiredAndPossible():void
    {
        if (_waitingImagesCounter == 0)
        {
            return;
        }
        if (_imageLoader != null || _xmlLoader != null || _links == null)
        {
            return;
        }

        var link:String = _links[int(Math.random() * (_links.length - 1))];

        _imageLoader = new Loader();
        _imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageLoadedHandler);
        _imageLoader.load(new URLRequest(link));
    }

    private function onImageLoadedHandler(e:Event):void
    {
        _waitingImagesCounter--;
        _imageLoader.removeEventListener(Event.COMPLETE, onImageLoadedHandler);
        _imageLoader = null;
        _$onImageLoaded.send(e.target.content);
        loadImargeIfRequiredAndPossible();
    }


    public function get $onImageLoaded():SignalBitmap
    {
        return _$onImageLoaded;
    }
}
}
