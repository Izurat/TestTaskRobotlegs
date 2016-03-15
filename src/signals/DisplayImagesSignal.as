/**
 * Created by Izurat on 01.03.2016.
 */
package signals
{
import VO.ImageVO;

import org.osflash.signals.Signal;

public class DisplayImagesSignal extends Signal
{
    public function DisplayImagesSignal()
    {
        super(Vector.<ImageVO>);
    }

    public function send(imageVOs:Vector.<ImageVO>):void
    {
        dispatch(imageVOs);
    }
}
}
