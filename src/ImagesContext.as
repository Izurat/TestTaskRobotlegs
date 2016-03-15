/**
 * Created by Izurat on 25.02.2016.
 */
package
{
import Controller.OnUserClickCommand;
import Controller.OnUserClickSignal;

import flash.display.DisplayObjectContainer;

import model.IImageVoFactory;

import model.ImageVOSimpleAlgorytmFactory;

import model.Model;
import model.TestModel;

import org.robotlegs.mvcs.SignalContext;

import service.ImagesService;

import signals.DisplayImagesSignal;
import signals.RemoveImageSignal;

import view.ImagesView;
import view.ImagesViewMediator;

public class ImagesContext extends SignalContext
{
    public function ImagesContext(contextView:DisplayObjectContainer)
    {
        super(contextView);
    }

    override public function startup():void
    {
        //var imageVOFactory:ImageVOMaxRectAlgorytmFactory = new ImageVOMaxRectAlgorytmFactory();
        var imageVOFactory:ImageVOSimpleAlgorytmFactory = new ImageVOSimpleAlgorytmFactory();
        injector.mapValue(IImageVoFactory,imageVOFactory);

        injector.mapSingleton(ImagesService);
        injector.mapSingleton(DisplayImagesSignal);
        injector.mapSingleton(RemoveImageSignal);
        injector.mapSingleton(Model);
        CONFIG::debug
        {
            injector.mapSingleton(TestModel);
        }


        signalCommandMap.mapSignalClass(OnUserClickSignal, OnUserClickCommand);

        mediatorMap.mapView(ImagesView, ImagesViewMediator);
        contextView.addChild(new ImagesView());

        super.startup();
    }
}
}
