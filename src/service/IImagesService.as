/**
 * Created by Izurat on 25.02.2016.
 */
package service
{
import signals.SignalBitmap;

public interface IImagesService
{
    function loadRandomImage():void

    function get $onImageLoaded():SignalBitmap;
}
}
