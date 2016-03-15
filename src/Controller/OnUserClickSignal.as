/**
 * Created by Izurat on 26.02.2016.
 */
package Controller
{
import org.osflash.signals.Signal;

public class OnUserClickSignal extends Signal
{
    public function OnUserClickSignal()
    {
        super(int);
    }

    public function send(clickTargetId:int):void
    {
        dispatch(clickTargetId);
    }
}
}
