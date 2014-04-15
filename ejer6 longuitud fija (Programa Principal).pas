program car;
uses primitivas, crt;

procedure leerPersona(var p:Persona); //Es privado
begin
	writeln ('Ingrese un dni');
	{$I-}
	readln(p.dni);
	{$I+}
	while (IOresult <> 0) do
	begin
		writeln ('DNI incorrecto, ingrese otro.');
		{$I-}
		readln (p.dni);
		{$I+}
	end;	
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

procedure IniCrear(var ctl:control);
begin
	Assign(ctl.a, 'P1');
	ctl.privacio:=-1;
    rewrite(ctl.a);
end;

procedure IniAbrir(var ctl:control);
var
	s:string;
begin	
	writeln('igrese el nombre del archivo que quiere abrir');
	readln(s);
	{$i-}
	Assign (ctl.a, s);	
	reset(ctl.a);
	{$i+}
	while (IOresult <> 0) do begin
		writeln ('Nombre incorrecto, ingrese otro.');
		readln (s);
		{$i-}
		Assign (ctl.a, s);
		reset(ctl.a);
		{$i+}
		end;
	ctl.privacio:=-1;
	inicializarVacios (ctl);
    writeln('se abrio el archivo');
end;

procedure evaluarResultado (i:integer);
begin
	clrscr;
	case i of 
		1: 
		begin
			writeln('----------------------------------------');
			writeln('|      La operacion fue exitosa!        |');    
			writeln('----------------------------------------');
		end;

		2: 
		begin
			writeln('----------------------------------------');
			writeln('|        La operacion ha fallado!       |');
			writeln('----------------------------------------');
		end;
		3: 
		begin
			writeln('----------------------------------------');
			writeln('|        El elemento ya existe           |');
			writeln('----------------------------------------');
		end;
		4: 
		begin
			writeln('----------------------------------------');
			writeln('|        El elemento no existe!         |');
			writeln('----------------------------------------');
		end;
	end;
end;

procedure mostrarMenu();
begin
	writeln('|---------------------------------------------------------------------------|');
	writeln('|                            Introduccion a las Bases de Datos              |');
	writeln('|                                   Ejercicio 6                             |');
	writeln('|---------------------------------------------------------------------------|');
	writeln('|                                                                           |');
	writeln('|(1.)  CARGAR: agrega una persona al final del archivo.                     |');
	writeln('|                                                                           |');
	writeln('|(2.)  PRIMERO: devuelve el primer registro de persona.                     |');
	writeln('|                                                                           |');
	writeln('|(3.)  SIGUIENTE: devuelve la siguiente persona.                            |');
	writeln('|                                                                           |');
	writeln('|(4.)  RECUPERAR: busca el DNI ingresado.                                   |');
	writeln('|                                                                           |');
	writeln('|(5.)  EXPORTAR: exportar a un archivo de texto, el archivo personas        |');
	writeln('|                                                                           |');
	writeln('|(6.)  INSERTAR: agrega un registro de persona.                             |');
	writeln('|                                                                           |');
	writeln('|(7.)  ELIMINAR: elimina un registro de persona con un DNI dado.            |');
	writeln('|                                                                           |');
	writeln('|(8.)  MODIFCAR:  modifica un registro a partir de un DNI dado              |');
	writeln('|                                                                           |');
	writeln('|(9.)  RESPALDAR: genera una version nueva del archivo.                     |');
	writeln('|                                                                           |');
	writeln('|(10.) IMPRIMIR EL ULTIMO REGISTRO GUARDADO EN EL BUFFER.                   |');
	writeln('|                                                                           |');
	writeln('|(11.) EXPORTAR RESPALDO A TEXTO.                                           |');
	writeln('|                                                                           |');
	writeln('|(0.)  Salir.                                                               |');
	writeln('|---------------------------------------------------------------------------|');
end;


procedure Imprimir(var ctl:control);
	begin
        writeln ();
		writeln ('DNI:', ctl.p.dni);
		writeln ('Nombre:', ctl.p.nombre);
		writeln ('Apellido:', ctl.p.Apellido);
		writeln ('Edad:', ctl.p.Edad);
        writeln ();
        readln();
	end;

var
   ctl:control;
   opcion,d,inicio:integer;
   aux:Persona;
begin
writeln('|-----------------------------------------------------------------------|');
writeln('|                           Introduccion a las Bases de Datos           |');
writeln('|                            Ejercicio 6                                |');        
writeln('|-----------------------------------------------------------------------|');
writeln('| (1.)     Crear un archivo nuevo.                                      |');
writeln('| (2.)     Abrir un archivo existente.                                  |');
writeln('|-----------------------------------------------------------------------|');
{$I-}
readln (inicio);
{$I+}
while (IOresult <> 0) do
begin
	writeln ('Opcion incorrecta, ingrese otra.');
	{$I-}
	readln(inicio);
	{$I+}
end;
while ((inicio <> 1) and (inicio <> 2)) do
begin
	writeln ('Opcion incorrecta, ingrese otra.');
	{$I-}
	readln (inicio);
	{$I+}
	while (IOresult <> 0) do
	begin
		writeln ('Opcion incorrecta, ingrese otra.');
		{$I-}
		readln(inicio);
		{$I+}
	end;
end;
if (inicio = 1) then
	IniCrear(ctl)
else
	if (inicio = 2) then
		IniAbrir(ctl);
mostrarMenu;
{$I-}
readln (opcion);
{$I+}
while (IOresult <> 0) do
begin
	writeln ('Opcion incorrecta, ingrese otra.');
	{$I-}
	readln(opcion);
	{$I+}
end;
while ((opcion < 0) or (opcion >11 )) do
begin
	writeln ('Opcion incorrecta, ingrese otra.');
	{$I-}
	readln (opcion);
	{$I+}
	while (IOresult <> 0) do
	begin
		writeln ('Opcion incorrecta, ingrese otra.');
		{$I-}
		readln(opcion);
		{$I+}
	end;
end;while (opcion <> 0) do begin
//	clrscr;
	case opcion of
        1:begin
			  Cargar (ctl);
			  clrscr;
			  writeln('----------------------------------------');
			writeln('|      La operacion fue exitosa!        |');    
			writeln('----------------------------------------');
          end;
		2: begin
			evaluarResultado (Primero (ctl));
		//	reset (ctl.a);
			end;
		3: begin
           evaluarResultado (Siguiente (ctl));
           end;
		4: begin
			readln (d);
			evaluarResultado (Recuperar (ctl, d));
			end;
		5:begin
			Exportar (ctl);
			clrscr;
			writeln('----------------------------------------');
			writeln('|      La operacion fue exitosa!        |');    
			writeln('----------------------------------------');
		  end;
		6: evaluarResultado (Insertar (ctl));
		7: evaluarResultado (Eliminar (ctl));
		8: begin
			leerPersona(aux);
			Igualar2(ctl.p, aux);
			evaluarResultado (Modificar (ctl));
			end;
		9: begin
			clrscr;
			Respaldar (ctl);
			writeln('----------------------------------------');
			writeln('|      La operacion fue exitosa!        |');    
			writeln('----------------------------------------');
		  end;
		10: begin
				clrscr;
				Imprimir (ctl);
		    end;
		11: begin
				exportarRespasldo(ctl);
				writeln('----------------------------------------');
				writeln('|      La operacion fue exitosa!        |');    
				writeln('----------------------------------------');
			end;
	end;
    //writeln ('Pulse ENTER para continuar');
    readln();
	mostrarMenu;
	{$I-}
readln (opcion);
{$I+}
while (IOresult <> 0) do
begin
	writeln ('Opcion incorrecta, ingrese otra.');
	{$I-}
	readln(opcion);
	{$I+}
end;
while ((opcion < 0) or (opcion >11 )) do
begin
	writeln ('Opcion incorrecta, ingrese otra.');
	{$I-}
	readln (opcion);
	{$I+}
	while (IOresult <> 0) do
	begin
		writeln ('Opcion incorrecta, ingrese otra.');
		{$I-}
		readln(opcion);
		{$I+}
	end;
end;
end;
close (ctl.a);
end.
