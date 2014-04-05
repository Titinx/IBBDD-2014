 Una unidad esta constituida por las siguientes secciones:
 
  – Cabecera de la unidad

  – Sección “Interface” (o sección pública)

  – Sección “implementatión” (o sección privada)

  – Sección de inicialización


UNIT<identificador>
  INTERFACE
    USES<lista de unidades>; {opcional}
    {declaraciones públicas de objetos exportables}
 
  IMPLEMENTATION
  {declaraciones privadas}
  {definición de procedimientos y funciones públicas}

  BEGIN
  {código de inicialización} {opcional}
  END.
