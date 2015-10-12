var i;
for(i=0; i<3; i++)
{
    var x1 = random_range(0,1024);
    var y1 = random_range(400,600);
    instance_create(x1,y1,Cloud);
}
var h;
for(h=0; h<8; h++)
{
    var x1 = random_range(0,1024);
    var y1 = random_range(700,780);
    instance_create(x1,y1,Hill);
}
