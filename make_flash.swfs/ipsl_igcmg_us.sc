.flash filename="ipsl_igcmg_us.swf" version=6 compress background=#FFFFFF

.gradient lightwight radial :
   0%   #FFFFFFFF
   30%   #FFFFFFFF
   100%  #FFFFFF00
.end
.gradient shadowblack radial :
   0%   #000000FF
   50%   #000000FF
   100% #00000000
.end
.gradient blackblue :
   0%   #000000
   100% #047BB5
.end

.circle disklogo r=100 fill=#047BB5 line=0
.circle disklightwight r=60 fill=lightwight line=0
.circle diskshadowblack r=100 fill=shadowblack line=0

.put diskshadowblack 130 30 
.put disklogo 100 0
.put disklightwight 120 10

.font myfont1 "VeraBI.swf"
.font myfont2 "VeraBd.swf"

.textshape logotitle1 font=myfont1 text="Institut" size=50%
.filled filledlogotitle1 outline=logotitle1 fill=blackblue line=0
.put filledlogotitle1 x=340 y=70

.textshape logotitle2 font=myfont1 text="Pierre" size=50%
.filled filledlogotitle2 outline=logotitle2 fill=blackblue line=0
.put filledlogotitle2 x=330 y=100

.textshape logotitle3 font=myfont1 text="Simon" size=50%
.filled filledlogotitle3 outline=logotitle3 fill=blackblue line=0
.put filledlogotitle3 x=320 y=130

.textshape logotitle4 font=myfont1 text="Laplace" size=50%
.filled filledlogotitle4 outline=logotitle4 fill=blackblue line=0
.put filledlogotitle4 x=310 y=160

.text logotitle5 font=myfont1 text="Environmental" size=32% color=black
.put logotitle5 x=105 y=90

.text logotitle6 font=myfont1 text="Sciences" size=32% color=black
.put logotitle6 x=105 y=120

# French characters in UTF-8 (hex) (a confirmer avec prochaine version CVS)
# à=\xE0 è=\xE8 é=\xE9

.text text_author_1 font=myfont2 text="IGCMG - IPSL Global Climate" color=black size=32%
.put text_author_1 pin=center x=280 y=240

.text text_author_2 font=myfont2 text="Modelling Group" color=black size=32%
.put text_author_2 pin=center x=280 y=260

.end
