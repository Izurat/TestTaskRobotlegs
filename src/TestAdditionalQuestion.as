/**
 * Created by Izurat on 15.03.2016.
 */
package
{
public class TestAdditionalQuestion
{
    public function TestAdditionalQuestion()
    {
        trace("Additional task");
        var list1:Vector.<int> = createRandomIntSortedList();
        trace("list 1 " + intsToString(list1));
        var list2:Vector.<int> = createRandomIntSortedList();
        trace("list 2 " + intsToString(list2));
        var list3:Vector.<int> = list1.concat(list2);
        sortInts(list3);
        trace("merged list " + intsToString(list3));
    }

    private function createRandomIntSortedList(maxElementsCount:int = 100, maxValue:int = 1000):Vector.<int>
    {
        var res:Vector.<int> = new Vector.<int>();
        var resElementsCount:int = Math.random() * maxElementsCount;
        for (var i:int = 0; i < resElementsCount; i++)
        {
            res.push(int(Math.random() * maxValue));
        }
        sortInts(res);
        return res;
    }

    private function sortInts(ints:Vector.<int>):void
    {
        var tmp:int;
        for (var i:int = 0; i < ints.length - 1; i++)
        {
            for (var j:int = 0; j < ints.length - i - 1; j++)
            {
                if (ints[j] < ints[j + 1])
                {
                    tmp = ints[j];
                    ints[j] = ints[j + 1];
                    ints[j + 1] = tmp;
                }
            }
        }
    }

    private function intsToString(ints:Vector.<int>):String
    {
        var res:String = "";
        for each(var currInt:int in ints)
        {
            res += currInt + " ";
        }
        return res;
    }

}
}
