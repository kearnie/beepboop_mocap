import processing.sound.*;
SoundFile file; 

// Originally from http://perfume-dev.github.io/

import java.util.ArrayList;
import java.util.List;

BvhParser parserA = new BvhParser();
PBvh bvh1, bvh2, bvh3;

long totalFrameTime;
long loopCounter;
long loopTime;

void setup()
{
  size( 600, 600, P3D );
  background( 0 );
  noStroke();
  frameRate( 30 );
  file = new SoundFile(this, "beepboop.wav");
  file.loop();

  bvh1 = new PBvh( loadStrings( "A_test.bvh" ) ); // testing w this one
  //bvh2 = new PBvh( loadStrings( "B_test.bvh" ) );
  //bvh3 = new PBvh( loadStrings( "C_test.bvh" ) );

  totalFrameTime = bvh1.parser.totalLoopTimeMillis();
  
  loop();
  
}

long lastMillis = -1;
long setToMillis = 0;

public void draw()
{
  if (lastMillis == -1) {
    lastMillis = millis();
  }
  background( 0 );
  fill(209,181,56);
  rect(0,0,width,height);
  fill(150,129,36);
  rect(20,20,width-40,height-40,8);
  fill(0);
  rect(30,30,width-60,height-60,18);

  //camera
  float _cos = 0.0;
  float _sin = 0.0;
  //camera(width/4.f + width/4.f * _cos +200, height/2.0f-100, 550 + 150 * _sin, width/2.0f, height/2.0f, -400, 0, 1, 0);
  camera(width/2, height/2, 510.0, width/2, height/2, 0.0, 0, 1, 0); 
  
  //ground 
  fill( color( 255 ));
  stroke(127);
  //line(width/2.0f, height/2.0f, -30, width/2.0f, height/2.0f, 30);
  stroke(127);
  //line(width/2.0f-30, height/2.0f, 0, width/2.0f + 30, height/2.0f, 0);
  stroke(255);

  pushMatrix();
  translate( width/2, height/2-10, 0);
  scale(-1, -1, -1);

  long currMillis = millis() % totalFrameTime;
  long elapsedMillis = currMillis - lastMillis;
  long savedCurrMillis = currMillis;
  if (currMillis < lastMillis) {
    loopCounter = 150;
    loopTime = setToMillis;
  }
  
  if (loopCounter > 0) {
    loopCounter--;
    setToMillis = 200;
  } else {
    setToMillis += elapsedMillis;
  }
    

  //model
  bvh1.update( (int)setToMillis );
  //bvh2.update( millis() );
  //bvh3.update( millis() );
  
  //bvh1.draw();
  //bvh2.draw();
  //bvh3.draw();
  
  lastMillis = savedCurrMillis;
  
  popMatrix();
  
  pushMatrix();
  int num = 54;
  int r = width / num; 
  noStroke();
  fill(64,64,64);
  //int count = 0;
  /*for (float i = 40; i < width-40; i = i+r) {
    count++;
    fill(0+count*2);
    for (float j = 40; j < height-40; j = j+r) {
      ellipse(j,i,r,r);
    }
  }*/
  
  
  fill(64,64,64); // 34
  
  for (float i = 40; i < width-40; i = i+r) {
    int count = 0;
    for (float j = 40; j < height-40; j = j+r) {
      count++;
      if (isBoneNear(bvh1.getBones(),i,j)) {
        if (loopCounter > 0) {
          fill(214,73,73);
          file.amp(0);
        } else {
          fill(182,232,169);
          file.amp(1);
        }
        ellipse(i,j,r,r);
      } else {
        fill(0+count*2);
        ellipse(i,j,r,r);
      }
    }
  }
  
  
  //ellipse(0,0,200,200);
  popMatrix();
      
}

boolean isBoneNear(List<BvhBone> bones, float x, float y) {
  float epsilon = 6.8;
  float scale = 2.7;
  x = x / scale;
  y = -y / scale;
  float xOffset = -105.0;
  float yOffset = 201.0;
  x += xOffset;
  y += yOffset;
  for (BvhBone bone : bones) {
    PVector start = bone.absPos;
    PVector end;
    epsilon = 6.8;
    if (bone.getName().equals("Head")) {
      epsilon = 12;
    }
    if (bone.getParent() == null) {
      end = bone.getChildren().get(0).absPos;
    } else {
      end = bone.getParent().absPos;
    }
    //PVector end = bone.absEndPos;
    float x1 = start.x;
    float y1 = start.y;
    float x2 = end.x;
    float y2 = end.y;
    double dist = lineDist(x1, y1, x2, y2, x, y);
    if (dist < epsilon) return true;
  }
  return false; 
}

double lineDist(float x1, float y1, float x2, float y2, float x3, float y3) {
  float px=x2-x1;
  float py=y2-y1;
  float temp=(px*px)+(py*py);
  float u=((x3 - x1) * px + (y3 - y1) * py) / (temp);
  if(u>1){
    u=1;
  }
  else if(u<0){
    u=0;
  }
  float x = x1 + u * px;
  float y = y1 + u * py;
  float dx = x - x3;
  float dy = y - y3;
  double dist = Math.sqrt(dx*dx + dy*dy);
  return dist;
}