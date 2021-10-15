<%@ pagelanguage="java" import="java.sql.*,net.ucanaccess.jdbc.*"%>
<HTML>
<HEAD>
<TITLE> AGREGAR NUEVO PAIS</TITLE>
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
<link rel="stylesheet" href="estilo.css" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<BODY>
<%!
public Connection getConnection() throws SQLException {
String driver = "sun.jdbc.odbc.JdbcOdbcDriver";
String filePath= "c:\\Apache\\Tomcat\\webapps\\SUCARNET\\data\\datos.mdb";
String userName="",password="";

String fullConnectionString = "jdbc:odbc:Driver={MicroSoft Access Driver (*.mdb)};DBQ="+filePath;

    Connection conn = null;
try{
        Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
 conn = DriverManager.getConnection(fullConnectionString,userName,password);

}
 catch (Exception e) {
System.out.println("Error: " + e);
 }
    return conn;
}%>

<%
Connection conexion = getConnection();
   if (!conexion.isClosed()){
out.write("OK");
 
      Statement st = conexion.createStatement();
      Statement st1 = conexion.createStatement();
      ResultSet rs1 = st1.executeQuery("insert into pais (codigo,nombre) values ('it','Italia')" );
      ResultSet rs = st.executeQuery("select * from usuario" );

      // Ponemos los resultados en un table de html
      out.println("<table border=\"1\"><tr><td>Id</td><td>Nombre</td><td>Apellido</td><td>Telefono</td></tr>");
      while (rs.next())
      {
         out.println("<tr>");
         out.println("<td>"+rs.getString("sexo")+"</td>");
         out.println("<td>"+rs.getString("nombre")+"</td>");
         out.println("<td>"+rs.getInt("edad")+"</td>");
         out.println("<td>"+rs.getString("pais")+"</td>");
         out.println("</tr>");
      }
      out.println("</table>");

      // cierre de la conexion
      conexion.close();
}

%>
<p>&nbsp; </P>
</BODY>
</HTML>