//ArshadFX_BarHL_Objects   Copyright © 2009, Arshad Qureshi, email : arshedfx@gmail.com
#property copyright "Copyright © 2009, Arshed Qureshi. ArshadFX"
#property indicator_chart_window
extern bool    H1          = 1;
extern int     ObjH1       = 2;
extern bool    H4          = 1;
extern int     ObjH4       = 2;
extern bool    D1          = 1; 
extern int     ObjD1       = 2;
extern bool    W1          = 1; 
extern int     ObjW1       = 2;
extern bool    M1          = 1; 
extern int     ObjM1       = 2;
extern string  Colors="Select Color & Drawing";
extern color   BarsHigh    = Green;
extern color   BarsLow     = Red;
extern int     LineLable   = 1;  // 0=Nolable, 1=Bar'sIndexNo, 2=Bar'sIndexNo + Price
extern bool    H1Position  = 0;  // 0= On bars as normal SupportResistance line, 1= Right side of chart
extern bool    H4Position  = 0;
extern bool    D1Position  = 1;
extern bool    W1Position  = 1;
extern bool    M1Position  = 1;

// -- GV HourIndexHigh, HourIndexLow... Houre1TimeStart,.. End. ---------------
double H1h[], H1l[], H4h[], H4l[], D1h[], D1l[], W1h[], W1l[], M1h[], M1l[];
datetime H1ts[], H1te[], H4ts[], H4te[], D1ts[], D1te[], W1ts[], W1te[], M1ts[], M1te[];
int MaxObj=0; // Maximum Objects
// --- Init & Deinit ----------------------------------------------------------
int init()  {ArrayResize(H1h,ObjH1+1); ArrayResize(H1l,ObjH1+1); ArrayResize(H1ts,ObjH1+1); ArrayResize(H1te,ObjH1+1);
             ArrayResize(H4h,ObjH4+1); ArrayResize(H4l,ObjH4+1); ArrayResize(H4ts,ObjH4+1); ArrayResize(H4te,ObjH4+1);
             ArrayResize(D1h,ObjD1+1); ArrayResize(D1l,ObjD1+1); ArrayResize(D1ts,ObjD1+1); ArrayResize(D1te,ObjD1+1);
             ArrayResize(W1h,ObjW1+1); ArrayResize(W1l,ObjW1+1); ArrayResize(W1ts,ObjW1+1); ArrayResize(W1te,ObjW1+1);
             ArrayResize(M1h,ObjM1+1); ArrayResize(M1l,ObjM1+1); ArrayResize(M1ts,ObjM1+1); ArrayResize(M1te,ObjM1+1);
             if (ObjH1+1 > MaxObj) MaxObj=ObjH1+1; // in case of some varient drawing lines
             if (ObjH4+1 > MaxObj) MaxObj=ObjH4+1;
             if (ObjD1+1 > MaxObj) MaxObj=ObjD1+1;
             if (ObjW1+1 > MaxObj) MaxObj=ObjW1+1;
             if (ObjM1+1 > MaxObj) MaxObj=ObjM1+1;
             return(0);}
int deinit(){rLines(MaxObj+1); Comment("");  return(0);}

// ---- Main function call ----------------------------------------------------
int start()
   {
   int x;
   for(x=0; x<MaxObj; x++)
      {
      H1h[x]=iHigh(Symbol(),60,x);     H1l[x]=iLow(Symbol(),60,x);
      H4h[x]=iHigh(Symbol(),240,x);    H4l[x]=iLow(Symbol(),240,x);
      D1h[x]=iHigh(Symbol(),1440,x);   D1l[x]=iLow(Symbol(),1440,x);
      W1h[x]=iHigh(Symbol(),10080,x);  W1l[x]=iLow(Symbol(),10080,x);
      M1h[x]=iHigh(Symbol(),43200,x);  M1l[x]=iLow(Symbol(),43200,x);

      H1ts[x]=iTime(Symbol(),60,x);    H1te[x]=Time[0];
      H4ts[x]=iTime(Symbol(),240,x);   H4te[x]=Time[0];
      D1ts[x]=iTime(Symbol(),1440,x);  D1te[x]=Time[0];
      W1ts[x]=iTime(Symbol(),10080,x); W1te[x]=Time[0];
      M1ts[x]=iTime(Symbol(),43200,x); M1te[x]=Time[0];
      }

   if (H1) {dH1(ObjH1+1);}
   if (H4) {dH4(ObjH4+1);}
   if (D1) {dD1(ObjD1+1);}
   if (W1) {dW1(ObjW1+1);}
   if (M1) {dM1(ObjM1+1);}

   Comment("Spread : ",MarketInfo(Symbol(), MODE_SPREAD));
   }
   //return(0);




void dH1(int Obj) // Draw Lines 1Hour
   {
   for (int x=1; x<Obj; x++)
      {
      ObjectDelete("H1_High_"+x);   // High_Hour_1
      if (H1Position){ObjectCreate("H1_High_"+x,OBJ_TREND,0,Time[0]+(Time[0]-Time[5]),H1h[x],Time[0]+(Time[0]-Time[25]),H1h[x],0);}
                     else {ObjectCreate("H1_High_"+x,OBJ_TREND,0,H1ts[x],H1h[x],H1te[x],H1h[x],0);}
      ObjectSet("H1_High_"+x,OBJPROP_RAY,0);  ObjectSet("H1_High_"+x,OBJPROP_COLOR,BarsHigh);
      ObjectSet("H1_High_"+x,OBJPROP_STYLE,2);
      if (LineLable==1){ObjectSetText("H1_High_"+x,"H1_High_"+x);}
      if (LineLable==2){ObjectSetText("H1_High_"+x,"H1_High_"+x+"    "+DoubleToStr(H1h[1],Digits),6);}

      ObjectDelete("H1_Low_"+x);   // Low_Hour_1
      if (H1Position){ObjectCreate("H1_Low_"+x,OBJ_TREND,0,Time[0]+(Time[0]-Time[5]),H1l[x],Time[0]+(Time[0]-Time[25]),H1l[x],0);}
                     else {ObjectCreate("H1_Low_"+x,OBJ_TREND,0,H1ts[x],H1l[x],H1te[x],H1l[x],0);}
      ObjectSet("H1_Low_"+x,OBJPROP_RAY,0);  ObjectSet("H1_Low_"+x,OBJPROP_COLOR,BarsLow);
      ObjectSet("H1_Low_"+x,OBJPROP_STYLE,2);
      if (LineLable==1){ObjectSetText("H1_Low_"+x,"H1_Low_"+x);}
      if (LineLable==2){ObjectSetText("H1_Low_"+x,"H1_Low_"+x+"    "+DoubleToStr(H1l[1],Digits),6);}
      }
   }

void dH4(int Obj) // Draw Lines 4Hour
   {
   for (int x=1; x<Obj; x++)
      {
      ObjectDelete("H4_High_"+x);   // High_Hour_1
      if (H4Position){ObjectCreate("H4_High_"+x,OBJ_TREND,0,Time[0]+(Time[0]-Time[5]),H4h[x],Time[0]+(Time[0]-Time[25]),H4h[x],0);}
                     else {ObjectCreate("H4_High_"+x,OBJ_TREND,0,H4ts[x],H4h[x],H4te[x],H4h[x],0);}
      ObjectSet("H4_High_"+x,OBJPROP_RAY,0);  ObjectSet("H4_High_"+x,OBJPROP_COLOR,BarsHigh);
      ObjectSet("H4_High_"+x,OBJPROP_WIDTH,1);
      if (LineLable==1){ObjectSetText("H4_High_"+x,"H4_High_"+x);}
      if (LineLable==2){ObjectSetText("H4_High_"+x,"H4_High_"+x+"    "+DoubleToStr(H4h[1],Digits),6);}

      ObjectDelete("H4_Low_"+x);   // Low_Hour_1
      if (H4Position){ObjectCreate("H4_Low_"+x,OBJ_TREND,0,Time[0]+(Time[0]-Time[5]),H4l[x],Time[0]+(Time[0]-Time[25]),H4l[x],0);}
                     else {ObjectCreate("H4_Low_"+x,OBJ_TREND,0,H4ts[x],H4l[x],H4te[x],H4l[x],0);}
      ObjectSet("H4_Low_"+x,OBJPROP_RAY,0);  ObjectSet("H4_Low_"+x,OBJPROP_COLOR,BarsLow);
      ObjectSet("H4_Low_"+x,OBJPROP_WIDTH,1);
      if (LineLable==1){ObjectSetText("H4_Low_"+x,"H4_Low_"+x);}
      if (LineLable==2){ObjectSetText("H4_Low_"+x,"H4_Low_"+x+"    "+DoubleToStr(H4l[1],Digits),6);}
      }
   }

void dD1(int Obj) // Draw Lines Daily
   {
   for (int x=1; x<Obj; x++)
      {
      ObjectDelete("D1_High_"+x);   // High_Hour_1
      if (D1Position){ObjectCreate("D1_High_"+x,OBJ_TREND,0,Time[0]+(Time[0]-Time[5]),D1h[x],Time[0]+(Time[0]-Time[25]),D1h[x],0);}
                     else {ObjectCreate("D1_High_"+x,OBJ_TREND,0,D1ts[x],D1h[x],D1te[x],D1h[x],0);}
      ObjectSet("D1_High_"+x,OBJPROP_RAY,0);  ObjectSet("D1_High_"+x,OBJPROP_COLOR,BarsHigh);
      ObjectSet("D1_High_"+x,OBJPROP_WIDTH,2);
      if (LineLable==1){ObjectSetText("D1_High_"+x,"D1_High_"+x);}
      if (LineLable==2){ObjectSetText("D1_High_"+x,"D1_High_"+x+"    "+DoubleToStr(D1h[1],Digits),6);}

      ObjectDelete("D1_Low_"+x);   // Low_Hour_1
      if (D1Position){ObjectCreate("D1_Low_"+x,OBJ_TREND,0,Time[0]+(Time[0]-Time[5]),D1l[x],Time[0]+(Time[0]-Time[25]),D1l[x],0);}
                     else {ObjectCreate("D1_Low_"+x,OBJ_TREND,0,D1ts[x],D1l[x],D1te[x],D1l[x],0);}
      ObjectSet("D1_Low_"+x,OBJPROP_RAY,0);  ObjectSet("D1_Low_"+x,OBJPROP_COLOR,BarsLow);
      ObjectSet("D1_Low_"+x,OBJPROP_WIDTH,2);
      if (LineLable==1){ObjectSetText("D1_Low_"+x,"D1_Low_"+x);}
      if (LineLable==2){ObjectSetText("D1_Low_"+x,"D1_Low_"+x+"    "+DoubleToStr(D1l[1],Digits),6);}
      }
   }

void dW1(int Obj) // Draw Lines Weekly
   {
   for (int x=1; x<Obj; x++)
      {
      ObjectDelete("W1_High_"+x);   // High_Hour_1
      if (W1Position){ObjectCreate("W1_High_"+x,OBJ_TREND,0,Time[0]+(Time[0]-Time[5]),W1h[x],Time[0]+(Time[0]-Time[25]),W1h[x],0);}
                     else {ObjectCreate("W1_High_"+x,OBJ_TREND,0,W1ts[x],W1h[x],W1te[x],W1h[x],0);}
      ObjectSet("W1_High_"+x,OBJPROP_RAY,0);  ObjectSet("W1_High_"+x,OBJPROP_COLOR,BarsHigh);
      ObjectSet("W1_High_"+x,OBJPROP_WIDTH,3);
      if (LineLable==1){ObjectSetText("W1_High_"+x,"W1_High_"+x);}
      if (LineLable==2){ObjectSetText("W1_High_"+x,"W1_High_"+x+"    "+DoubleToStr(W1h[1],Digits),6);}

      ObjectDelete("W1_Low_"+x);   // Low_Hour_1
      if (W1Position){ObjectCreate("W1_Low_"+x,OBJ_TREND,0,Time[0]+(Time[0]-Time[5]),W1l[x],Time[0]+(Time[0]-Time[25]),W1l[x],0);}
                     else {ObjectCreate("W1_Low_"+x,OBJ_TREND,0,W1ts[x],W1l[x],W1te[x],W1l[x],0);}
      ObjectSet("W1_Low_"+x,OBJPROP_RAY,0);  ObjectSet("W1_Low_"+x,OBJPROP_COLOR,BarsLow);
      ObjectSet("W1_Low_"+x,OBJPROP_WIDTH,3);
      if (LineLable==1){ObjectSetText("W1_Low_"+x,"W1_Low_"+x);}
      if (LineLable==2){ObjectSetText("W1_Low_"+x,"W1_Low_"+x+"    "+DoubleToStr(W1l[1],Digits),6);}
      }
   }

void dM1(int Obj) // Draw Lines Monthly
   {
   for (int x=1; x<Obj; x++)
      {
      ObjectDelete("M1_High_"+x);   // High_Hour_1
      if (W1Position){ObjectCreate("M1_High_"+x,OBJ_TREND,0,Time[0]+(Time[0]-Time[5]),M1h[x],Time[0]+(Time[0]-Time[25]),M1h[x],0);}
                     else {ObjectCreate("M1_High_"+x,OBJ_TREND,0,M1ts[x],M1h[x],M1te[x],M1h[x],0);}
      ObjectSet("M1_High_"+x,OBJPROP_RAY,0);  ObjectSet("M1_High_"+x,OBJPROP_COLOR,BarsHigh);
      ObjectSet("M1_High_"+x,OBJPROP_WIDTH,4);
      if (LineLable==1){ObjectSetText("M1_High_"+x,"M1_High_"+x);}
      if (LineLable==2){ObjectSetText("M1_High_"+x,"M1_High_"+x+"    "+DoubleToStr(M1h[1],Digits),6);}

      ObjectDelete("M1_Low_"+x);   // Low_Hour_1
      if (W1Position){ObjectCreate("M1_Low_"+x,OBJ_TREND,0,Time[0]+(Time[0]-Time[5]),M1l[x],Time[0]+(Time[0]-Time[25]),M1l[x],0);}
                     else {ObjectCreate("M1_Low_"+x,OBJ_TREND,0,M1ts[x],M1l[x],M1te[x],M1l[x],0);}
      ObjectSet("M1_Low_"+x,OBJPROP_RAY,0);  ObjectSet("M1_Low_"+x,OBJPROP_COLOR,BarsLow);
      ObjectSet("M1_Low_"+x,OBJPROP_WIDTH,4);
      if (LineLable==1){ObjectSetText("M1_Low_"+x,"M1_Low_"+x);}
      if (LineLable==2){ObjectSetText("M1_Low_"+x,"M1_Low_"+x+"    "+DoubleToStr(M1l[1],Digits),6);}
      }
   }


void rLines(int Obj)     // Remove Lines
   {
   for (int x=1; x<Obj; x++)
      {
      ObjectDelete("H1_High_"+x);  // High_Hour_1
      ObjectDelete("H1_Low_"+x);   // Low_Hour_1
      ObjectDelete("H4_High_"+x);  // High_Hour_1
      ObjectDelete("H4_Low_"+x);   // Low_Hour_1
      ObjectDelete("D1_High_"+x);  // High_Hour_1
      ObjectDelete("D1_Low_"+x);   // Low_Hour_1
      ObjectDelete("W1_High_"+x);  // High_Hour_1
      ObjectDelete("W1_Low_"+x);   // Low_Hour_1
      ObjectDelete("M1_High_"+x);  // High_Hour_1
      ObjectDelete("M1_Low_"+x);   // Low_Hour_1
      }
   }





