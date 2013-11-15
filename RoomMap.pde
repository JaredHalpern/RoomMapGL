import processing.opengl.*;
    import SimpleOpenNI.*;
    SimpleOpenNI kinect;
    // variable to hold our current rotation represented in degrees
    float rotation = 0;

    void setup() {
      size(1024, 768, OPENGL);
      kinect = new SimpleOpenNI(this);
      kinect.enableDepth();
      kinect.enableRGB();
      kinect.alternativeViewPointDepthToImage();
}
    void draw() {
      background(0);
      kinect.update();

      PImage rgbImage = kinect.rgbImage();

      // prepare to draw centered in x-y
      // pull it 250 pixels closer on z
      translate(width/2, height/2, -250);

      // flip the point cloud vertically:
      rotateX(radians(180));

      // move the center of rotation
      // to inside the point cloud
      translate(0, 0, 1000);

      // rotate about the y-axis and bump the rotation
      // auto-rotate
      rotateY(radians(rotation));
      rotation++;

// mouse rotate
//float mouseRotationX = map(mouseX, 0, width, -180, 180);
//rotateY(radians(mouseRotationX));

//float mouseRotationY = map(mouseY, 0, height, -180, 180);
//rotateX(radians(mouseRotationY));

//      stroke(255);
      PVector[] depthPoints = kinect.depthMapRealWorld();
      // notice: "i+=10"
      // only draw every 10th point to make things faster
      for (int i = 0; i < depthPoints.length; i+=12) {
        PVector currentPoint = depthPoints[i];
        stroke(rgbImage.pixels[i]);
        point(currentPoint.x, currentPoint.y, currentPoint.z);
      }
}
