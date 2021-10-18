<%--
Document&nbsp;&nbsp; : AECTabla
Created on : 25-dic-2012, 10:11:06
Author&nbsp;&nbsp;&nbsp;&nbsp; : Jtaguaa
--%>
 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.sql.*" %>
 
<%
/* Paso 1) Obtener los datos del formulario */
String ls_isbn = request.getParameter("isbn");
String ls_titulo = request.getParameter("titulo");
String ls_action = request.getParameter("Action");
 
/* Paso 2) Inicializar variables */
String ls_result = "Base de datos actualizada...";
String ls_query = "";
String filePath= "c:\\Apache\\Tomcat\\webapps\\SUCARNET\\data\\datos.mdb";
String ls_dburl = "jdbc:odbc:Driver={MicroSoft Access Driver (*.mdb)};DBQ="+filePath;
String ls_usuario = "";
String ls_password = "";
String ls_dbdriver = "sun.jdbc.odbc.JdbcOdbcDriver";
 
/* Paso 3) Crear query&nbsp; */
if (ls_action.equals("Crear")) {
ls_query = " insert into libros (isbn, titulo)";
ls_query += " values (";
ls_query += "'" + ls_isbn + "',";
ls_query += "'" + ls_titulo + "')";
}
 
if (ls_action.equals("Eliminar")) {
ls_query = " delete from libros where isbn = ";
ls_query += "'" + ls_isbn + "'";
}
 
if (ls_action.equals("Actualizar")) {
ls_query = " update libros";
ls_query += " set titulo= " + "'" + ls_titulo + "'";
ls_query += " where isbn = " + "'" + ls_isbn + "'";
}
 
/* Paso4) Conexión a la base de datos */
Connection l_dbconn = null;
 
try {
Class.forName(ls_dbdriver);
/*&nbsp; getConnection(URL,User,Pw) */
l_dbconn = DriverManager.getConnection(ls_dburl,ls_usuario,ls_password);
 
/*Creación de SQL Statement */
Statement l_statement = l_dbconn.createStatement();
/* Ejecución de SQL Statement */
l_statement.execute(ls_query);
} catch (ClassNotFoundException e) {
ls_result = " Error creando el driver!";
ls_result += " <br/>" + e.toString();
} catch (SQLException e) {
ls_result = " Error procesando el SQL!";
ls_result += " <br/>" + e.toString();
} finally {
/* Cerramos */
try {
if (l_dbconn != null) {
l_dbconn.close();
}
} catch (SQLException e) {
ls_result = "Error al cerrar la conexión.";
ls_result += " <br/>" + e.toString();
}
}
%>
html>
<html>
<head><title>Updating a Database</title></head>
<body>
 
La siguiente instrucción fue ejecutada:
<br/><br/>
<%=ls_query%>
<br/><br/>
 
El resultado fue:
<br/><br/>
<%=ls_result%>
<br/><br/>
 
<a href="libros.jsp">Entre otro valor</a>
</body>
</html>