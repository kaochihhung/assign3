//assign3, joekao, 20151105
final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;

int gameState;

PImage bg1Img, bg2Img, enemyImg, fighterImg, hpImg, treasureImg, start1Img, start2Img, end1Img, end2Img;

// treasure positon
int treasurex=floor(random(25,590));
int treasurey=floor(random(50,440));
int treasurew=40;
int treasureh=40;

int hplength; // hp

int bg1x; // background1
int bg2x; // backpround2
// enemy postion & speed
int enemyx=0;
int enemyy=floor(random(50,150));
int enemyw=50;
int enemyh=60;
float enemySpeedx;
float enemySpeedy;
int enemyWidth=70;
int enemyHeight=70;
int enemyTeamX = 0;
int enemyTeamY = enemyy +70;  

// fighter postion & speed
int fighterx;
int fightery;
int fighterw=40;
int fighterh=50;
float fighterSpeed;


// fighter control
boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

  
void setup () {
  size(640,480);
  //load image
  bg1Img=loadImage("img/bg1.png");
  bg2Img=loadImage("img/bg2.png");
  enemyImg=loadImage("img/enemy.png");
  fighterImg=loadImage("img/fighter.png");
  hpImg=loadImage("img/hp.png");
  treasureImg=loadImage("img/treasure.png");
  start1Img=loadImage("img/start1.png");
  start2Img=loadImage("img/start2.png");
  end1Img=loadImage("img/end1.png");
  end2Img=loadImage("img/end2.png");
  
  //background intial
  bg1x=640;
  bg2x=0;
  
  //enemy move direction
  enemySpeedx= 3;
  enemySpeedy= 0;
  
  // fighter speed
  fighterSpeed=5;
  
  // fighter position
  fighterx=580;
  fightery=240;
  //  hp length
  hplength = 2*200/10;

  gameState = GAME_START; 
   
}

void draw() {
  
  switch(gameState){
    case GAME_START:
       //show startpage
      image(start2Img,0,0);
                 
      // mouse action
      if (mouseX>200 && mouseX<450){
        if(mouseY>370 && mouseY<420){
          if(mousePressed){
          gameState=GAME_RUN;
        } else {
          image(start1Img,0,0);
        }
        }
       }
      break;
      
    case GAME_RUN:
      
      image(bg1Img,bg1x-640,0);
      image(bg2Img,bg2x-640,0);
      image(fighterImg,fighterx,fightery);
      image(hpImg,20,20);
      image(treasureImg,treasurex,treasurey);
      image(enemyImg,enemyx,enemyy);
      
      // reset hp
     
      // hp position 
      noStroke();
      colorMode(RGB);
      fill(255,0,0);
      rect(25,25,hplength,20);
      

      // background move
      bg1x += 1;
      bg1x %= 1280;
      bg2x +=1;
      bg2x %=1280;
      // enemy move
      enemyx += enemySpeedx;
      enemyy += enemySpeedy;
      enemyx %= 640+280;
      
      for (int row = 0; row < 5; row++){
        for ( int col = 0; col < 5; col ++){
                  
        enemyTeamX = enemyx - (enemyWidth)*col;
        image(enemyImg,enemyTeamX,enemyTeamY);
        enemyTeamY = enemyy+(enemyHeight)*row;
        }
      }

      // fighter move
      if(upPressed){
        fightery -= fighterSpeed;
      }
      if(downPressed){
        fightery += fighterSpeed;
      }
      if(leftPressed){
        fighterx -= fighterSpeed;
      }
      if(rightPressed){
        fighterx += fighterSpeed;
      }
      
      // fighter over boundary
      if(fightery < 0){
        fightery = 0;
      }
      if(fightery > height-50){
        fightery = height-50;
      }
      if(fighterx < 0){
        fighterx = 0;
      }
      if(fighterx > width-50){
        fighterx = width-50;
      } 
                  
      // get treasure
      if (fighterx <= treasurex+treasurew && fighterx >=treasurex-fighterw){
        if (fightery >= treasurey-fighterh && fightery <= treasurey+treasureh){
        hplength += 20;
        treasurex=floor(random(25,590));
        treasurey=floor(random(50,440));
        }
      }
      if (hplength>200){
        hplength=200;
      }
          
          
                   
   
      break;
      
    case GAME_OVER:
      //show startpage
      image(end2Img,0,0);
      
      // mouse action
      if (mouseX>200 && mouseX<450){
        if(mouseY>310 && mouseY<350){
          if(mousePressed){
          gameState = GAME_RUN;
          } else {
          image(end1Img,0,0);
          }
        }
       }
      break;
    }
}
        
void keyPressed(){
  if (key == CODED){ 
    switch (keyCode){
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
      }
  }
}
void keyReleased(){
  if (key == CODED){ 
      switch(keyCode){
        case UP:
          upPressed = false;
          break;
        case DOWN:
          downPressed = false;
          break;
        case LEFT:
          leftPressed = false;
          break;
        case RIGHT:
          rightPressed = false;
          break;
      }
  }
}
