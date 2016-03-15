/**
 * Created by Izurat on 27.02.2016.
 */
package utils
{
public class UniqueIdDispatcher
{
    private static var _idCounter:int = 0;

    public static function get unigueID():int
    {
        _idCounter++;
        return _idCounter;
    }
}
}
