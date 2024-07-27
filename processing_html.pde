
PImage savedBackground;  // 保存された背景を格納する変数

color pointer_color = (0);  // 黒い背景の検知用

color po_col_up;  // 壁にのめりこまないように
color po_col_right;
color po_col_left;
color po_col_down;

boolean up, down, left, right; //キーの押す・離すを検知する値を定義  // ポインターが変な動きしないように  // booleanはtrueとfalseのデータ型

int glo_x;
int glo_y;
int mig_tukattaka = 0;  // 右を前回使った→1  使ってない→0    // これが1だったら、次に左を使わない。
int ground_x = 100;
int ground_y = 100;

//int side_or_no ;  // スタート位置を決める  // 1なら側面 0なら上下
int st_place = 0;  // スタート位置
int go_place = 0;  //ゴール位置

int st_place_x = 0;  // スタート位置(x座標)
int st_place_y = 0;

int go_place_x = 0;  // ゴール位置(x座標)
int go_place_y = 0;

int go_or_no = 0;  // 0がゴールしてない 1がゴールした

float moved_x = 0;
float moved_y = 0;

float pointer_x;  // ポインターの位置
float pointer_y;

void setup(){
  
  //fullScreen();  // 全画面にできる
  size(900,900);
  stroke(0);
  strokeWeight(3);
  fill(255);
  rect(100,100,710,710);  //白色の背景
  


  noStroke();
  fill(0);
  for(int x=0; x<17;x++ ){
    for(int y=0; y<17;y++ ){
      rect(ground_x+30+x*40,ground_y+30+y*40,10,10);
      
      glo_x = x; // 別の関数内でxやy(何番目かのxとy)を使えるようにする
      glo_y = y;
      
      if(y == 0){
        dic_way_ueari();
      }
      else{
        dic_way();
      }
    }
    
  }
    //スタート位置とゴールの位置を決める  (外周のどこかにする。反対側の面にする)
    //side_or_no = int(random(0,2));
    //if(side_or_no == 0){  // スタートとゴールを側面にする  
    //}
    //if(side_or_no == 1){  //　スタートとゴールを上下にする
    //}
    //18*18のどこかにスタートとゴールを決める。(324通り)
  while(true){
    st_place = int(random(0,325));
    go_place = int(random(0,325));
    
    if(abs(st_place%18 - go_place%18) >= 13  && abs(st_place/18 - go_place/18) >= 13){  // スタートとゴールのxとyの座標の距離の差がそれぞれ10以上の時と、
      break;
    }
  }
  
  int point = 0;
  
  for(int x=0; x<18;x++ ){
    for(int y=0; y<18;y++ ){
      
      if(point == st_place){  // スタート位置を描画
        strokeWeight(1);
        stroke(0);
        fill(255,255,0);
        
        st_place_x = ground_x + 40*x;  // スタート位置を保存
        st_place_y = ground_y + 40*y;
        rect(st_place_x, st_place_y, 30, 30);
        
        noStroke();
        
        textSize(30);  // スタート文字を付ける
        fill(20);
        text("S",ground_x + 40*x +7,ground_y + 40*y +25);
        noStroke();
      }
      if(point == go_place){  // ゴール位置を描画
        strokeWeight(1);
        stroke(0);
        fill(255,0,0);

        go_place_x = ground_x + 40*x;  // ゴール位置を保存
        go_place_y = ground_y + 40*y;
        rect(go_place_x,go_place_y,30,30);
        
        noStroke();
        
        textSize(30);  //　ゴール文字を付ける
        fill(20);
        text("G",ground_x + 40*x +7,ground_y + 40*y +25);
        noStroke();
        
      }  // 波かっこの向きは気を付ける!!!!!!!!!!!!!!!!!!!!!!!!!!
      
      point++;
    }
  }

    
    
  savedBackground = get();  // 背景の保存
  //save("test.png");  //保存
}


//void keyTyped(){   // 最初止まって動きずらい
  
//  if(keyCode == UP){
//    moved_y -= 5;
//  }
  
//  if(keyCode == DOWN){
//    moved_y += 5;
//  }
  
//  if(keyCode == RIGHT){
//    moved_x += 5;
//  }
  
//  if(keyCode == LEFT){
//    moved_x -= 5;
//  }
//}

int speed = 2;
  
void draw(){
  pointer_x = st_place_x + 15 + moved_x;  // ポインターの位置
  pointer_y = st_place_y + 15 + moved_y;
  frameRate(50);
  background(savedBackground);
    
  po_col_up = get(int(pointer_x), int(pointer_y - 2));   // 動かす前に読まないと行けない
  po_col_down = get(int(pointer_x), int(pointer_y + 2)); 
  po_col_right = get(int(pointer_x + 2), int(pointer_y)); 
  po_col_left = get(int(pointer_x - 2), int(pointer_y)); 
    
  if (go_or_no == 0){
  if(up == true && po_col_up != color(0))    moved_y -= speed;
  if(down == true && po_col_down != color(0))  moved_y += speed;
  if(left == true && po_col_left != color(0))  moved_x -= speed;
  if(right == true && po_col_right != color(0)) moved_x += speed;
  }
    
  //loadPixels(); //画面全体の色情報を配列pixelsとして読み込む  //Pixel[] からの読み取りまたは Pixel[]への書き込みの前に常に呼び出す必要がある。
  //pointer_color = pixels[int(st_place_y + 15 + moved_y*width + st_place_x + 15 + moved_x)];
  pointer_color = get(int(st_place_x + 15 + moved_x), int(st_place_y + 15 + moved_y));  // これあると2回に1回動かない
  //get_pointer_color();
  //println(red(pointer_color));
  
  //println(pointer_color);
  //println(int(st_place_y + 15 + moved_y*width + st_place_x + 15 + moved_x));
  //pointer_color = pixels[10];
  
  //fill(pointer_color);  // ちゃんと色が読み取れているかの確認
  //rect(100,100,20,20);
  
  //delay(1)  // できない
    
  
  fill(100,200,255,10);
  ellipse(pointer_x, pointer_y, 13,13);
  
  fill(50,100,255);
  ellipse(pointer_x, pointer_y, 10,10);
  
  //kabehantei();
  goal_hantei();

}

//void get_pointer_color(){   // ただの試し 固まらないようにどうすればいいかなって思って。
//  pointer_color = get(int(st_place_x + 15 + moved_x), int(st_place_y + 15 + moved_y));  // これあると2回に1回動かない 
//}


void keyPressed(){ //各キーが押されたとき、それに対応するbool値がtrue（=押された）になる  //ネットのコピペ //挙動がちゃんとして、斜めも行ける!!!!
  //if (pointer_color == 0){
    //if (pointer_color == color(0,0,0)){
    //    if(keyCode == UP){
    //      up = false;
    //      moved_y += speed;
    
    //    }
    //    if(keyCode == DOWN)  down = false;
    //    if(keyCode == LEFT)  left = false;
    //    if(keyCode == RIGHT) right = false;
      
    //  }
  //}

  //else{
    
    po_col_up = get(int(pointer_x), int(pointer_y - 2)); 
    po_col_down = get(int(pointer_x), int(pointer_y + 2)); 
    po_col_right = get(int(pointer_x + 2), int(pointer_y)); 
    po_col_left = get(int(pointer_x - 2), int(pointer_y)); 
  
    //if(keyCode == UP  && po_col_up != color(0))    up = true;
    //if(keyCode == DOWN  && po_col_down != color(0))  down = true;
    //if(keyCode == LEFT  && po_col_left != color(0))  left = true;
    //if(keyCode == RIGHT  && po_col_right != color(0)) right = true;
    
    if(keyCode == UP)    up = true;
    if(keyCode == DOWN)  down = true;
    if(keyCode == LEFT)  left = true;
    if(keyCode == RIGHT) right = true;
        
    //if(po_col_up == color(0)) up = false;
    //if(po_col_down == color(0)) down = false;
    //if(po_col_right == color(0)) right = false;
    //if(po_col_left == color(0)) left = false;
    
    //println(up);
    
  //}
}

void keyReleased(){ //各キーが離されたとき、それに対応するbool値がfalse（=離された）になる
  if(keyCode == UP)    up = false;
  if(keyCode == DOWN)  down = false;
  if(keyCode == LEFT)  left = false;
  if(keyCode == RIGHT) right = false;
}

void kabehantei(){  // 壁の判定。黒に当たったら戻す。
//pointer_color = get(int(st_place_x + 15 + moved_x), int(st_place_y + 15 + moved_y));  // これあると2回に1回動かない 
  
  if (pointer_color == color(0,0,0)){
      if(up == true){
        moved_y += speed * 1.3;
      }
      if(down == true){
        moved_y -=speed * 1.3;
      }
      if(left == true){
        moved_x += speed * 1.3;
      }
      if(right == true){
        moved_x -= speed * 1.3;
      }
  }
  
}


//void kabehantei2(){
//  po_col_up = get(int(pointer_x), int(pointer_y - 2)); 
//  po_col_down = get(int(pointer_x), int(pointer_y + 2)); 
//  po_col_right = get(int(pointer_x + 2), int(pointer_y)); 
//  po_col_left = get(int(pointer_x - 2), int(pointer_y)); 

//}



void goal_hantei(){
  if (pointer_color == color(255,0,0)){
    //strokeWeight(100);
    textAlign(CENTER,CENTER);
    //textSize(260);
    //fill(0);
    //text("GOAL!",width/2,height/2);
    textSize(250);
    fill(255,255,0);
    text("GOAL!",width/2,height/2);
    go_or_no = 1;
  }
}




int a;

void dic_way(){
  //return random(0,2); //0=左 1=下 2=右
  if(mig_tukattaka == 1){  // 前回右を使っているので、左を使わない
    a = int(random(1,3));
  }
  else{
    a = int(random(0,3));
  }
  
  if (a == 0){  // 左
    rect(ground_x+30+glo_x*40 -30, ground_y+30+glo_y*40 ,30,10);  // 始点はx座標だけ変えた  // 右に大きくしないといけないから、始点は左端に合わせる(?)
    mig_tukattaka = 0;
  }
  if (a == 1){  // 下
    rect(ground_x+30+glo_x*40, ground_y+30+glo_y*40 +10 ,10,30);  // 下に伸ばしたいから、yはプラスする!!!!!!!!!!!
    mig_tukattaka = 0;
  }
  if (a == 2){  // 右
    rect(ground_x+30+glo_x*40 +10, ground_y+30+glo_y*40 ,30,10); 
    mig_tukattaka = 1;
  }
}


void dic_way_ueari(){
  //return random(0,3); //0=左 1=下 2=右 3=上
  
  if(mig_tukattaka == 1){  // 前回右を使っているので、左を使わない
    a = int(random(1,4));   // random()だけだと小数点もランダムになる!!!!!!!!!!!!!!!!!!!!!!!!  // 上限は多分、未満
  }
  else{
    a = int(random(0,4));
  }
  
  if (a == 0){  // 左
    rect(ground_x+30+glo_x*40 -30, ground_y+30+glo_y*40 ,30,10);  // 始点はx座標だけ変えた  // 右に大きくしないといけないから、始点は左端に合わせる(?)
    mig_tukattaka = 0;
  }
  if (a == 1){  // 下
    rect(ground_x+30+glo_x*40, ground_y+30+glo_y*40 +10 ,10,30);  // 下に伸ばしたいから、yはプラスする!!!!!!!!!!!
    mig_tukattaka = 0;
  }
  if (a == 2){  // 右
    rect(ground_x+30+glo_x*40 +10, ground_y+30+glo_y*40 ,30,10); 
    mig_tukattaka = 1;
  }
  if (a == 3){  // 上
    rect(ground_x+30+glo_x*40, ground_y+30+glo_y*40 -30 ,10,30); 
    mig_tukattaka = 0;
  }
}

//public static int sint = 100;
