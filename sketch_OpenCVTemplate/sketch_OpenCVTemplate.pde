import gab.opencv.*;
import processing.video.*;
import java.awt.Rectangle;

OpenCV opencv;
Capture cam;
Rectangle[] faces;
Rectangle[] noses;


void setup() 
{ 
  
  size(10, 10);
  
  initCamera();
  opencv = new OpenCV(this, cam.width, cam.height);
  
  surface.setResizable(true);
  surface.setSize(opencv.width, opencv.height);
  
  
}

void draw() 
{
  if(cam.available())
  {    
    cam.read();
    cam.loadPixels();
    opencv.loadImage((PImage)cam);

    // you should write most of your computer vision code here 
    
    
    // CODE
    opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE); 
    faces = opencv.detect();
    
    image(opencv.getInput(), 0, 0);
    noFill();
    stroke(0, 255, 0);
    strokeWeight(3);
    for (int i = 0; i < faces.length; i++) {
      rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
      
      opencv.setROI(faces[i].x,faces[i].y,faces[i].width,faces[i].height);
      opencv.loadCascade(OpenCV.CASCADE_NOSE);
      noses = opencv.detect();
      fill(255, 0, 0);
      stroke(255, 0, 0);
      for (int j = 0; j < noses.length; j++) {
        ellipse(faces[i].x + faces[i].width/2, faces[i].y + faces[i].height/2, noses[j].width, noses[j].height);
      }
      //ellipse(faces[i].x + faces[i].width/2, faces[i].y + faces[i].width/2, faces[i].width, faces[i].height);
  }
  opencv.releaseROI();
    
    // end code
    
  }
}

void initCamera()
{
  String[] cameras = Capture.list();
  if (cameras.length != 0) 
  {
    println("Using camera: " + cameras[0]); 
    cam = new Capture(this, cameras[0]);
    cam.start();    
    
    while(!cam.available()) print();
    
    cam.read();
    cam.loadPixels();
  }
  else
  {
    println("There are no cameras available for capture.");
    exit();
  }
}
