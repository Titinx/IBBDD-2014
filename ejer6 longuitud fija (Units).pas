Unit primitivas;

Interface
const
	code_empty =-1;
	code_ok = 1;
	code_notok = 2;
	code_exist = 3;
	code_notexist = 4;

type
	
	Persona=record
		DNI:LongWord;
		nombre:String[20];
		apellido:String[15];
		edad:Integer;
		valido:Boolean;
		proxvacio:Integer; //Se usa solo cuando el valido esta en false.		
	end;

	resp = record
		DNI:LongWord;
		nombre:String[20];
		apellido:String[15];
		edad:Integer;
	end;

	archive = file of Persona;
	respaldo = file of resp;
	code = -1..4;

	control=record
		p:Persona; //SE USA COMO AUXILIAR
		a:archive;
		texto:Text; //Para exportar
		r:respaldo; //El archivo para respaldar
		privacio:Integer; //Guarda la primer posicion vacia.
	end;

procedure Cargar(var ctl:control);
function Primero (var ctl:control):code;
function Siguiente (var ctl:control):code;
function Recuperar (var ctl:control; d:LongWord):code;
procedure Exportar (var ctl:control);
function Insertar (var ctl:control):code;
function Eliminar (var ctl:control):code;
function Modificar (var ctl:control):code;
procedure Respaldar (var ctl:control);
procedure inicializarVacios(var ctl:control);
procedure exportarRespasldo(var ctl:control);
procedure Igualar2(var aux:Persona; p:persona);
{procedure Exportar1 (var ctl:control);}

Implementation
//YA VIENE ABIERTO EL ARCHIVO!

// PRIVADOS!!!!

procedure Igualar(var aux:resp; p:persona);
begin
	aux.dni:=p.dni;
	aux.nombre:=p.nombre;
	aux.apellido:=p.apellido;
	aux.edad:=p.edad;
end;

procedure Igualar2(var aux:Persona; p:persona);
begin
	aux.dni:=p.dni;
	aux.nombre:=p.nombre;
	aux.apellido:=p.apellido;
	aux.edad:=p.edad;
end;

function esVacio(var a:archive):Boolean;
begin
	esVacio:= FileSize(a) = 0;
end;

procedure inicializarVacios(var ctl:control);
begin
	if (not esVacio(ctl.a)) then 
	begin
		seek(ctl.a, 0);
		while (not eof(ctl.a)) do begin
			read(ctl.a,ctl.p);
			if(not ctl.p.valido) then begin
				ctl.p.proxvacio:=ctl.privacio;
				ctl.privacio:=FilePos(ctl.a) -1;
				seek(ctl.a, ctl.privacio);
				write(ctl.a, ctl.p);
			end;
		end;
	end;
end;

procedure leerSinDni(var p:Persona; d:longWord); //Es privado
begin
	p.dni:=d;
	writeln('Ingrese el nombre: ');
	{$I-}
	readln(p.nombre);
	{$I+}
	while (IOresult <> 0) do
	begin
		writeln ('Nombre incorrecto, ingrese otro.');
		{$I-}
		readln (p.nombre);
		{$I+}
	end;
	writeln('Ingrese el apellido: ');
	{$I-}
	readln(p.apellido);
	{$I+}
		while (IOresult <> 0) do
	begin
		writeln ('Apellido incorrecto, ingrese otro.');
		{$I-}
		readln (p.apellido);
		{$I+}
     end;
	writeln('ingrese la edad: ');
	{$I-}
	readln(p.edad);
	{$I+}
		while (IOresult <> 0) do
	begin
		writeln ('Edad incorrecta, ingrese otra.');
		{$I-}
		readln (p.edad);
		{$I+}
     end;
	p.valido:=true;
end;

// PUBLICOS!!!

procedure Cargar(var ctl:control);
var
	d:LongWord;
begin
	writeln ('Ingrese un dni');
	{$I-}
	readln (d);
	{$I+}
	while (IOresult <> 0) do
	begin
		writeln ('DNI incorrecto, ingrese otro.');
		{$I-}
		readln(d);
		{$I+}
	end;
	leerSinDni(ctl.p, d);
	seek (ctl.a, FileSize(ctl.a));
	write (ctl.a, ctl.p);
end;

function Primero (var ctl:control):code; //Devolves el primero en ctl.p.
	var
		ok:code;              
	begin
		ok:=code_notok;
		reset(ctl.a);
		if(not esVacio(ctl.a)) then begin
			while (not eof(ctl.a)) and (ok = code_notok) do begin
				read(ctl.a, ctl.p);
				if(ctl.p.valido) then
					ok:=code_ok;
			end;
		end;
		Primero:=ok;
	end;

function Siguiente(var ctl:control):code;
var
		ok:code;              
	begin
		ok:=code_notok;
		while ((not eof(ctl.a)) and (ok = code_notok)) do begin
			read(ctl.a, ctl.p);
			if(ctl.p.valido) then
				ok:=code_ok;
		end;
		Siguiente:=ok;
	end;

function Recuperar(var ctl:control; d:LongWord):code;
var
	ok: code;
	aux:Persona;
begin
	aux:=ctl.p;
	ok:= Primero(ctl);
	if (ok=code_ok) then
		while ((ctl.p.DNI <> d) and (ok = code_ok)) do
			ok:=Siguiente(ctl);	
	if (ctl.p.dni = d) then begin
		ctl.p:=aux;
		Recuperar:= code_exist
	end
	else begin
		ctl.p:=aux;
		Recuperar:=code_notexist;
	end;
end;

procedure Exportar(var ctl:control);
var
	t:Text;
	cont:Integer;
	aux:Persona;
begin
	reset (ctl.a);
	if (FileSize(ctl.a)= 0) then
		writeln ('El archivo se encuentra vacio')
	else begin
		cont:=1;
		read(ctl.a, aux);
		writeln('Se creara el archivo personas.txt');
		Assign (t, 'personas.txt');
		rewrite (t);
		write(t, 'DNI':11); write (t, 'Nombre':18); write (t, 'Apellido':18); writeln (t, 'Edad':8); //Es para la tabla
		while (not EOF(ctl.a)) do begin
			if (aux.valido) then
				writeln(t, cont, ') ', aux.DNI:11, aux.nombre:18, aux.apellido:18, aux.edad:8)
			else
				writeln(t, cont, ') ');
			read (ctl.a, aux);
			cont:=cont+1;
		end;
		if (aux.valido) then
			writeln(t, cont, ') ', aux.DNI:11, aux.nombre:18, aux.apellido:18, aux.edad:8)
		else
			writeln(t, cont, ') ');
		close (t);
	end;	
end;

function Insertar(var ctl:control):code;
var
	actual:Integer;
	aux:Persona;
	d:LongWord;
begin
	actual:=FilePos(ctl.a);
    writeln('Ingrese el dni a insertar: ');
    {$I-}
    readln(d);
    {$I+}
    while (IOresult <> 0) do
    begin
    	writeln ('DNI incorrecto, ingrese otro.');
    	{$I-}
    	readln(d);
    	{$I+}
    end;
	if (Recuperar(ctl, d) = code_exist) then begin
		Insertar:=code_exist;
	end
	else begin	
		leerSinDni(ctl.p, d);
		if (ctl.privacio = code_empty) then begin
			seek(ctl.a, FileSize(ctl.a));
			write (ctl.a, ctl.p);
            writeln ('AGREGADO EN EL FINAL');
		end
		else begin
			seek(ctl.a, ctl.privacio);
			read (ctl.a, aux);
			seek (ctl.a, ctl.privacio);
			ctl.privacio:=aux.proxvacio;
			write (ctl.a, ctl.p); // porque se insertan el que tengo que agregar
            writeln ('AGREGADO POR EL MEDIO');
		end;
		Insertar:= code_ok;
	end;
	seek (ctl.a, actual);
end;

function Eliminar(var ctl:control):code;
var
	d:LongWord;
	actual:Integer;
begin
	if (esVacio(ctl.a)) then
		Eliminar:=code_notexist
	else begin
		actual:=FilePos(ctl.a);
		write('Ingrese el DNI de la persona a eliminar: ');
		{$I-}
		readln(d);
		{$I+}
		while (IOresult <> 0) do
		begin
			writeln ('DNI incorrecto, ingrese otro.');
			{$I-}
			readln(d);
			{$I+}
		end;
		if (Recuperar(ctl, d) = code_exist) then begin
			ctl.p.valido:=false;
			ctl.p.proxvacio:= ctl.privacio;
			ctl.privacio:= FilePos(ctl.a) -1;
			seek (ctl.a, ctl.privacio);
			write (ctl.a, ctl.p);
			seek (ctl.a, actual);
			Eliminar:= code_ok;
		end
		else begin
			seek (ctl.a, actual);
			Eliminar:= code_notexist;
		end;
	end;
end;

function Modificar(var ctl:control):code;
begin
	if (esVacio(ctl.a)) then
		Modificar:=code_notexist
	else begin
		if (Recuperar(ctl, ctl.p.dni) = code_exist) then begin
       		seek (ctl.a, FilePos(ctl.a) - 1);
			write (ctl.a, ctl.p);
			Modificar:= code_ok;
		end
		else begin
			Modificar:= code_notexist;
		end;
	end;
end;

procedure Respaldar (var ctl:control);
var
	aux: resp;
begin
	if (esVacio(ctl.a)) then
		writeln ('El archivo esta vacio.')
	else begin
		Assign (ctl.r, 'respaldo');
		rewrite (ctl.r);
		if (Primero(ctl) = code_ok) then begin
			Igualar (aux, ctl.p);
			write (ctl.r, aux);
			while (Siguiente(ctl) = code_ok) do begin
				Igualar (aux, ctl.p);
				write (ctl.r, aux);
			end;
		end;
        close (ctl.r);
	end;
end;

procedure exportarRespasldo(var ctl:control);
var
	t:Text;
	cont:Integer;
	aux:resp;
begin
	reset (ctl.r);
	if (FileSize(ctl.r)= 0) then
		writeln ('El archivo se encuentra vacio')
	else begin
		cont:=1;
		seek (ctl.r, 0);
		read(ctl.r, aux);
		writeln('Se creara el archivo personasrespaldo.txt');
		Assign (t, 'personasrespaldo.txt');
		rewrite (t);
		write(t, 'DNI':11); write (t, 'Nombre':18); write (t, 'Apellido':18); writeln (t, 'Edad':8); //Es para la tabla
		while (not EOF(ctl.r)) do begin
			writeln(t, cont, ') ', aux.DNI:11, aux.nombre:18, aux.apellido:18, aux.edad:8);
			read (ctl.r, aux);
			cont:=cont+1;
		end;
		writeln(t, cont, ') ', aux.DNI:11, aux.nombre:18, aux.apellido:18, aux.edad:8);
		close (t);
		close (ctl.r);
	end;	
end;

begin

end.
