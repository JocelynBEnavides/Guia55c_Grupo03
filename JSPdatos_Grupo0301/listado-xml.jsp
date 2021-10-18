<%@page contentType="application/xml" pageEncoding="UTF-8" import="java.sql.*,net.ucanaccess.jdbc.*, javax.servlet.*, javax.servlet.http.*"%>
<%@ page import="java.io.*,java.sql.*"%>

<% 
    response.setStatus(200);
    response.setHeader("Content-Disposition", "attachment; filename=listadoLibros.xml");
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
    ServletContext context = request.getServletContext();
    String path2 = context.getRealPath("/data");
    Connection conexion = getConnection(path2);

   if (!conexion.isClosed()){

        Statement sta = conexion.createStatement();
        ResultSet res = sta.executeQuery("select * from libros");
	  
        out.println("<Listado>");
        while (res.next()){
		    out.println("<Libro>");

		    String isbn = res.getString("isbn");
		    String titu = res.getString("titulo");
		    String aut = res.getString("Autor");
		    String publica = res.getString("publicacion");
		    String edito = res.getString("editorial");
		 
		    out.println("<isbn>"+isbn+"</isbn>");
		    out.println("<titulo>"+titu+"</titulo>");
		    out.println("<autor>"+aut+"</autor>");
		    out.println("<publicacion>"+publica+"</publicacion>");
		    out.println("<editorial>"+edito+"</editorial>");
         
		    out.println("</Libro>");
        }
            out.println("</Listado>");

            // cierre de la conexion
            conexion.close();
    }
%>
