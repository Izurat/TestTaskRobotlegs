/**
 * Created by Izurat on 26.02.2016.
 */
package Controller
{

import model.Model;
import model.TestModel;

import org.robotlegs.mvcs.SignalCommand;

public class OnUserClickCommand extends SignalCommand
{
    [Inject]
    public var arg:int;

    [Inject]
    public var _model:Model;

    CONFIG::debug
    {
        [Inject]
        public var _testModel:TestModel;
    }
    




    public function OnUserClickCommand()
    {
        super();
    }

    override public function execute():void
    {
        CONFIG::debug
        {
            _testModel.changeImage(arg);
            return;
        }
        _model.changeImage(arg);
    }
}
}
