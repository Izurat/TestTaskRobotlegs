/**
 * Created by Izurat on 27.02.2016.
 */
package signals
{
import org.osflash.signals.Signal;

public class SignalInt extends Signal
{
    public function SignalInt()
    {
        super();
    }

    public function send(value:int):void
    {
        dispatch(value);
    }
}
}
