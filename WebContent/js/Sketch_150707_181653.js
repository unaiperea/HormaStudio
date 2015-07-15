
var group = new Group();
var path = new Path();
path.add(new Point(100, 200));
path.add(new Point(150, 200));
path.add(new Point(150, 250));
path.strokeColor = 'red'

group.addChild(path);


    
group.rotation += 40;

var group = new Group();
group.pivot = group.bounds.topLeft;
var path = new Path();
path.add(new Point(100, 200));
path.add(new Point(150, 200));
path.add(new Point(150, 250));
path.strokeColor = 'red'

group.addChild(path);

group.rotation += 60;

