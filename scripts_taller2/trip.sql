/*
Simon Restrepo
Vista que trae la informacion de un vuelo y sus tripulantes en el tiempo
*/

--Vista para informacion de Pilotos y Copilotos
CREATE OR REPLACE VIEW PILOTOS_DATA
AS
SELECT P.ID, P.HORAS_VUELO, P.TIPO_CARGO, 
    E.NOMBRE, E.APELLIDO, E.SEXO, E.HORAS_DESCANSO, E.ESTADO
FROM PILOTOS P 
    INNER JOIN EMPLEADOS E ON E.ID = P.EMPLEADO_ID;

--Vista para informacion de Tripulacion auxiliar del vuelo  
CREATE OR REPLACE VIEW TRIPULATION_DATA
AS
SELECT E.ID, E.NOMBRE, E.APELLIDO, E.SEXO, E.HORAS_DESCANSO, E.ESTADO, E.TIPO_EMPLEADO
FROM EMPLEADOS E
WHERE TIPO_EMPLEADO IN ('Tripulante','Auxiliar de Servicio');

--Vista Final
CREATE OR REPLACE VIEW FLIGHT_TRIPULATION
AS
SELECT
    I.VUELO_ID,
    P.ID PILOTO_ID, 
    P.NOMBRE||' '||P.APELLIDO NOMBRE_PILOTO,
    'PILOTO' TRIPULANTE
FROM ITINERARIOS I  
    INNER JOIN PILOTOS_DATA P ON P.ID = I.PILOTO_ID
UNION
SELECT 
    I.VUELO_ID,
    COP.ID COPILOTO_ID, 
    COP.NOMBRE||' '||COP.APELLIDO NOMBRE_COPILOTO,
    'COPILOTO' TRIPULANTE
FROM ITINERARIOS I
    INNER JOIN PILOTOS_DATA COP ON COP.ID = I.COPILOTO_ID
UNION
SELECT
    I.VUELO_ID,
    TRIP.ID TRIPULANTE_ID, 
    TRIP.NOMBRE||' '||TRIP.APELLIDO NOMBRE_TRIPULANTE,
    UPPER(TRIP.TIPO_EMPLEADO) TRIPULANTE
FROM ITINERARIOS I
    INNER JOIN TRIPULANTE_PROGRAMACIONES T ON I.ID = T.ITINERARIO_ID
    INNER JOIN TRIPULATION_DATA TRIP ON TRIP.ID = T.EMPLEADO_ID;
        
/*

    SELECT *
    FROM FLIGHT_TRIPULATION
    WHERE VUELO_ID = 4

*/   
