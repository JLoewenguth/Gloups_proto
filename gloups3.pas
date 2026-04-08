program gloups;

//maj: fantomeB, IA simplifiee, portes
//prob: depart=couleur + score

uses crt;

const maxx=21;
maxy=16;

var tabl,tabl2: array[1..maxx,1..maxy] of char;
a:char;					//commande
i,j,v,w,v2,w2,posx,posy,score:integer;		//ij(trace du cadre) vw (fantomeA) px py(pacman)
stop,nogum:boolean;		//nogum(passage fantome sur gum)

procedure init(taillex,tailley:integer);
var i,j:integer;
begin
	for i:=2 to tailley-1 do
		for j:=2 to taillex-1 do
			tabl[j,i]:='.';
	textcolor(yellow);
	tabl[round(taillex/2),round(tailley/2)]:=#2;
	textcolor(lightgray);
end;

procedure dessine_cadre(taillex,tailley:integer);
var i,j:integer;
begin
	clrscr;
    for i:=2 to taillex-1 do
    begin
        tabl[i,1]:=#205;
		tabl[i,tailley]:=#205;
    end;
    for i:=2 to tailley-1 do
    begin
        tabl[1,i]:=#186;
        tabl[taillex,i]:=#186;
    end;
	tabl[1,1]:=#201;		//coins
    tabl[1,tailley]:=#200;
    tabl[taillex,1]:=#187;
    tabl[taillex,tailley]:=#188;
    tabl[1,9]:=' ';
    tabl[21,9]:=' ';
	tabl[3,3]:=#201;		//ile NordOuest
    tabl[3,4]:=#200;
    tabl[5,3]:=#187;
    tabl[5,4]:=#188;
    tabl[4,3]:=#205;
    tabl[4,4]:=#205;        //fin ile NO
	tabl[7,3]:=#201;		//ile NO 2
    tabl[7,4]:=#200;
    tabl[9,3]:=#187;
    tabl[9,4]:=#188;
    tabl[8,3]:=#205;
    tabl[8,4]:=#205;	   //fin ile NO 2
	tabl[11,1]:=#203;	   //mur nord
	tabl[11,2]:=#186;
	tabl[11,3]:=#186;
	tabl[11,4]:=#186;	  //fin mur N
	tabl[13,3]:=#201;		//ile NordEst
    tabl[13,4]:=#200;
    tabl[15,3]:=#187;
    tabl[15,4]:=#188;
    tabl[14,3]:=#205;
    tabl[14,4]:=#205;        //fin ile NE
	tabl[17,3]:=#201;		//ile NE 2
    tabl[17,4]:=#200;
    tabl[19,3]:=#187;
    tabl[19,4]:=#188;
    tabl[18,3]:=#205;
    tabl[18,4]:=#205;        //fin ile NE 2
	tabl[11,6]:=#203;		 //centre haut
    tabl[11,7]:=#186;
	tabl[11,8]:=#186;
    tabl[13,6]:=#205;
    tabl[10,6]:=#205;
    tabl[9,6]:=#205;
    tabl[12,6]:=#205;        //fin centre haut
	tabl[3,6]:=#205;		//mur NO
	tabl[4,6]:=#205;
	tabl[5,6]:=#205;		//fin mur NO
	tabl[17,6]:=#205;		//mur NE
	tabl[18,6]:=#205;
	tabl[19,6]:=#205;		//fin mur NE
	tabl[7,6]:=#186;		 //T NO
    tabl[7,7]:=#186;
    tabl[7,8]:=#204;
    tabl[7,9]:=#186;
    tabl[7,10]:=#186;
    tabl[8,8]:=#205;
	tabl[9,8]:=#205;	     //fin T NO
	tabl[15,6]:=#186;		 //T NE
    tabl[15,7]:=#186;
    tabl[15,8]:=#185;
    tabl[15,9]:=#186;
    tabl[15,10]:=#186;
    tabl[14,8]:=#205;
	tabl[13,8]:=#205;	     //fin T NE
	tabl[9,10]:=#201;		 //centre
    tabl[13,10]:=#187;
    tabl[9,11]:=#200;
    tabl[13,11]:=#188;
    tabl[10,10]:=#205;
    tabl[12,10]:=#205;
	tabl[11,10]:=#205;
    tabl[10,11]:=#205;
    tabl[12,11]:=#205;
	tabl[11,11]:=#205;		//fin centre
    tabl[7,12]:=#186;		//mur O
    tabl[7,13]:=#186;
    tabl[7,14]:=#200;
    tabl[8,14]:=#205;           //fin mur O
    tabl[15,12]:=#186;		//mur E
    tabl[15,13]:=#186;
    tabl[15,14]:=#188;
    tabl[14,14]:=#205;		//fin mur E
	tabl[2,8]:=#205;		//sorties
	tabl[3,8]:=#205;
	tabl[4,8]:=#205;
	tabl[5,8]:=#205;
	tabl[20,8]:=#205;
	tabl[19,8]:=#205;
	tabl[18,8]:=#205;
	tabl[17,8]:=#205;
	tabl[1,8]:=#200;
	tabl[21,8]:=#188;
	tabl[2,10]:=#205;
	tabl[3,10]:=#205;
	tabl[4,10]:=#205;
	tabl[5,10]:=#205;
	tabl[20,10]:=#205;
	tabl[19,10]:=#205;
	tabl[18,10]:=#205;
	tabl[17,10]:=#205;
	tabl[1,10]:=#201;
	tabl[21,10]:=#187;		//fin sorties
	tabl[5,12]:=#186;		//L SO
	tabl[5,13]:=#186;
	tabl[5,14]:=#188;
	tabl[4,14]:=#205;
	tabl[3,14]:=#205;		//fin L SO
	tabl[17,12]:=#186;		//L SE
	tabl[17,13]:=#186;
	tabl[17,14]:=#200;
	tabl[18,14]:=#205;
	tabl[19,14]:=#205;		//fin L SE
	tabl[1,12]:=#204;		//muret SO
	tabl[2,12]:=#205;
	tabl[3,12]:=#205;		//fin muret SO
	tabl[21,12]:=#185;		//muret SE
	tabl[20,12]:=#205;
	tabl[19,12]:=#205;		//fin muret SE
	tabl[10,13]:=#205;		//T sud
	tabl[11,13]:=#203;
	tabl[12,13]:=#205;
	tabl[11,14]:=#186;		//fin T sud
    for i:=1 to tailley do
    begin
        for j:=1 to taillex do
        write(tabl[j,i]);
        writeln;
    end;
end;

procedure dessine_terrain(taillex,tailley:integer);
var i,j:integer;
begin
   textcolor(yellow);
   tabl[posx,posy]:=#2;
   for i:=2 to tailley-1 do
	   for j:=2 to taillex do
			if tabl[j,i]<>tabl2[j,i] then
			begin
				gotoxy(j,i);
				write(tabl[j,i]);
	   end;
   textcolor(lightgray);
end;

function peut_bouger(x,y:integer):boolean;		//collisions pacman ou fantomes
begin
	peut_bouger:=((tabl[x,y]=' ') or (tabl[x,y]='.'));
end;

function fpeut_bouger(x,y:integer):boolean;		//collisions pacman ou fantomes
begin
	fpeut_bouger:=((tabl[x,y]=' ') or (tabl[x,y]='.') or (tabl[x,y]=#2));
end;

procedure f;		//fantomeA
begin
    gotoxy(v,w);
	if nogum=false then		//remplacement du gum si il y en avait un
		write ('.')
	else
		write (' ');
    begin
		if posx<v then		//move horizontal
			if fpeut_bouger(v-1,w) then
				v:=(v-1);
		if posx>v then
			if fpeut_bouger(v+1,w) then
				v:=(v+1);
		if posy<w then		//move vertical
			if fpeut_bouger(v,w-1) then
				w:=(w-1);
		if posy>w then
			if fpeut_bouger(v,w+1) then
				w:=(w+1);
	end;
    gotoxy(v,w);
	if (tabl[v,w]='.') then		//affectation de nogum
		nogum:=false
	else
		nogum:=true;
	textcolor(lightred);
    write ('A');
	textcolor(lightgray);
end;

procedure f2;		//fantomeB
begin
    gotoxy(v2,w2);
	if nogum=false then		//remplacement du gum si il y en avait un
		write ('.')
	else
		write (' ');
    begin
		if posx<(v2+1) then		//move horizontal
			if fpeut_bouger(v2-1,w2) then
				v2:=(v2-1);
		if posx>(v2+1) then
			if fpeut_bouger(v2+1,w2) then
				v2:=(v2+1);
		if posy<(w2+1) then		//move vertical
			if fpeut_bouger(v2,w2-1) then
				w2:=(w2-1);
		if posy>(w2+1) then
			if fpeut_bouger(v2,w2+1) then
				w2:=(w2+1);
	end;
    gotoxy(v2,w2);
	if (tabl[v2,w2]='.') then		//affectation de nogum
		nogum:=false
	else
		nogum:=true;
	textcolor(lightmagenta);
    write ('B');
	textcolor(lightgray);
end;

BEGIN
    clrscr;
    cursoroff;
    stop:=false;
    nogum:=false;
    posx:=round(maxx/2);		//centrage de pacman
    posy:=round(maxy/2);
    init(maxx,maxy);
    v:=(2);		//pos fantomeA
    w:=(2);
	v2:=(20);
	w2:=(2);
	score:=0;
	gotoxy(10,17);
	writeln(score);
    gotoxy(v,w);
	textcolor(lightred);
    write ('A');
	textcolor(lightgray);
    dessine_cadre(maxx,maxy);
    a:=readkey;
    tabl2:=tabl;
    while (a<>#27) and (stop=false) do
    begin
		if (tabl[posx,posy]=tabl[v,w]) or (tabl[posx,posy]=tabl[v2,w2]) then		//capture de pacman
		stop:=true;
        a:=readkey;
        if a=#77 then		//aller a droite
			begin
			if peut_bouger(posx+1,posy) then
				begin
					tabl[posx,posy]:=' ';
					posx:=posx+1;
					if tabl[posx,posy]='.' then score:=score+1;
					if (((posx=20) or (posx=21)) and (posy=9)) then		//porte droite
					begin
						tabl[20,9]:=' ';
						posx:=2;
						posy:=9;
					end;
					dessine_terrain(maxx,maxy);
					gotoxy(10,17);
					writeln(score);
				end;
			f;
			f2;
			end;
        if a=#75 then		//aller a gauche
			begin
			if peut_bouger(posx-1,posy) then
				begin
					tabl[posx,posy]:=' ';
					posx:=posx-1;
					if tabl[posx,posy]='.' then score:=score+1;
					if (((posx=2) or (posx=1)) and (posy=9)) then			//porte gauche
					begin
						tabl[2,9]:=' ';
						posx:=20;
						posy:=9;
					end;
					dessine_terrain(maxx,maxy);
					gotoxy(10,17);
					writeln(score);
				end;
			f;
			f2;
			end;
        if a=#72 then		//descendre
			begin
			if peut_bouger(posx,posy-1) then
				begin
					tabl[posx,posy]:=' ';
					posy:=posy-1;
					if tabl[posx,posy]='.' then score:=score+1;
					dessine_terrain(maxx,maxy);
					gotoxy(10,17);
					writeln(score);
				end;
			f;
			f2;
			end;
        if a=#80 then		//monter
			begin
			if peut_bouger(posx,posy+1) then
				begin
					tabl[posx,posy]:=' ';
					posy:=posy+1;
					if tabl[posx,posy]='.' then score:=score+1;
					dessine_terrain(maxx,maxy);
					gotoxy(10,17);
					writeln(score);
				end;
			f;
			f2;
			end;
		if (tabl[posx,posy]=tabl[v,w]) or (tabl[posx,posy]=tabl[v2,w2]) then		//capture de pacman
			stop:=true
    end;
	clrscr;
	gotoxy(9,6);
	write('Gloups !!');
	gotoxy(5,9);
	write('Vous avez gloups');
	write(#130);
	gotoxy(5,10);
	textcolor(lightred);
	write(score);
	textcolor(lightgray);
	write(' petits points.');
        gotoxy(2,14);
        write('("entrer" pour quitter)');
	readln;
END.

