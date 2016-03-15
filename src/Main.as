package
{

import flash.display.Sprite;

public class Main extends Sprite
{
    private var _context:ImagesContext;
    public function Main()
    {
        new TestAdditionalQuestion();
        _context = new ImagesContext(this);
    }
}
}
