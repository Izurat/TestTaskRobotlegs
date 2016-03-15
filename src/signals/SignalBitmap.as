/**
 * Created by Izurat on 27.02.2016.
 */
package signals
{
import flash.display.Bitmap;

import org.osflash.signals.Signal;

public class SignalBitmap extends Signal
{
    public function SignalBitmap()
    {
        super(Bitmap);
    }

    public function send(bitmap:Bitmap):void
    {
        dispatch(bitmap);
    }
}
}
