<%@page contentType="application/vnd.ms-excel" pageEncoding="UTF-8" import="java.sql.*,net.ucanaccess.jdbc.*, javax.servlet.*, javax.servlet.http.*"%>
<%@ page import="java.io.*,java.sql.*"%>

<%
    response.setStatus(200);
    response.setHeader("Content-Disposition", "attachment; filename=listadoLibros.csv");
%>

<%!
    public Connection getConnection(String path) throws SQLException {
    String driver = "sun.jdbc.odbc.JdbcOdbcDriver";
    String filePath= path+"\\datos.mdb";
    String userName="",password="";
    String fullConnectionString = "jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=" + filePath;

    Connection conn = null;
try{
    Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
    conn = DriverManager.getConnection(fullConnectionString,userName,password);

}
 catch (Exception e) {
    System.out.println("Error: " + e);
 }
    return conn;
}
%>
<%
    ServletContext context_tres = request.getServletContext();
    String path_tres = context_tres.getRealPath("/data");
    Connection conexion_tres = getConnection(path_tres);

   if (!conexion_tres.isClosed()){

    Statement zt = conexion_tres.createStatement();
    ResultSet rz = zt.executeQuery("select * from libros");
	  
    out.println("ISBN; Titulo; Publicacion; Editorial");
    while (rz.next()){

		String isbn = rz.getString("isbn");
		String titu = rz.getString("titulo");
		String publica = rz.getString("publicacion");
		String edito = rz.getString("editorial");
        out.println(isbn+";"+titu+";"+publica+";"+edito);
    }

    // cierre de la conexion
    conexion_tres.close();
}
%>