<%@page contentType="text/html" pageEncoding="iso-8859-1" import="java.sql.*,net.ucanaccess.jdbc.*" %>
    <html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Actualizar, Eliminar, Crear registros.</title>
        <link rel="stylesheet" type="text/css" href="estilo.css" />
        <script type="text/javascript">
            function actualizar(b) {
                document.getElementById("isbn1").value = document.getElementById("is" + b.id).innerHTML;
                document.getElementById("titulo2").value = document.getElementById("ti" + b.id).innerHTML;
                document.getElementById("autor2").value = document.getElementById("au" + b.id).innerHTML;
                document.getElementById("publicacion2").value = document.getElementById("pb" + b.id).innerHTML;
                document.getElementById("editorial2").value = document.getElementById("ed" + b.id).innerHTML;
                document.getElementById("actualizarRd").checked = true;
            }

            function eliminar(b) {
                document.getElementById("isbn1").value = document.getElementById("is" + b.id).innerHTML;
                document.getElementById("titulo2").value = document.getElementById("ti" + b.id).innerHTML;
                document.getElementById("autor2").value = document.getElementById("au" + b.id).innerHTML;
                document.getElementById("publicacion2").value = document.getElementById("pb" + b.id).innerHTML;
                document.getElementById("eliminarRd").checked = true;
            }

            function validar() {
                var valido = true;
                elm = document.getElementByClassName("formbusca");
                for (i = 0; i < elm.length; i++) {
                    if (elm[i].value == "" || elm[i].value == null) {
                        valido = false;
                    }
                }
                if (valido) {
                    document.getElementById('btnbuscar').disabled = false;
                } else {
                    document.getElementById('btnbuscar').disable = true;
                }
            }
        </script>
    </head>

    <body>
        <H1>Mantenimiento de libros</H1>
        <form action="matto.jsp" method="post" name="Actualizar">
            <table align="center">
                <tr>
                    <td>ISBN<input type="text" name="isbn" id="isbn1" required value="" size="40" patter="[0-9]{9}" placeholder="#############" />
                    </td>
                </tr>
                <tr>
                    <td>Titulo<input required type="text" name="titulo" id="titulo2" value="" size="50" /></td>
                </tr>
                <tr>
                    <td>Autor: <input requerid type="text" name="Autor" id="autor2" value="" size="50" /> </td>
                </tr>
                <tr>
                    <td>A&ntilde;o de publicacion: <input requerid type="text" min="1500" max="2021" name="publicacion" id="publicacion2" value="" />

                        <%
                            ServletContext context_dos = request.getServletContext();
                            String path_dos = context_dos.getRealPath("/data");
                            Connection conexion_dos = getConnection(path_dos);
                            if (!conexion_dos.isClosed()){
                                out.write("");
 
                            Statement ct = conexion_dos.createStatement();
                            ResultSet rc = ct.executeQuery("select * from editorial");

                            // Ponemos los resultados en una lista de html
                            out.println("       Editorial: <select id=\"editorial2\" name ='editorial'>");
      
                                while (rc.next()){
                                    out.println("<option>"+rc.getString("nombre")+"</option>");
       
                                }
                                out.println("</select><br/>");

                            // cierre de la conexion
                            conexion_dos.close();
                            }
                        %>

                    </td>
                </tr>
                <tr>
                    <td> Action <input type="radio" name="Action" value="Actualizar" id="actalizarRd" /> Actualizar
                        <input type="radio" name="Action" value="Eliminar" id="eliminarRd" /> Eliminar
                        <input type="radio" name="Action" value="Crear" /> Crear
                    </td>
                    <td align="center"><input type="SUBMIT" value="ACEPTAR" id="boton" />
                    </td>
                </tr>
        </form>
        </tr>
        </table>
        </form>
        <br><br>
        <%-- ejercicio 3 --%>
            <form name="formBuscar" method="get">
                <table align="center">
                    <tr>
                        <td>ISBN: <input type="text" id="isbn1" name="isbn" patter="[0-9]{9}" placeholder="#############" requerid value="" size="20" /></td>
                        <td><input id="boton" type="submit" name="boton" value="BUSCAR" /></td>
                        <td><a id="volver" href="libs.jsp">Volver</a></td>
                    </tr>
                </table>
            </form>
            <form align="center">
                Titulo: <input onkeyup="validar()" class="inputFormu" type="text" name="titulo"> &nbsp;&nbsp; Autor: <input onkeyup="validar()" class="inputFormu" type="text" name="Autor" /> &nbsp;&nbsp;
                <input type="SUBMIT" id="btnbuscar" name="btnbuscar" value="BUSCAR" />
                <td><a id="volver" href="libs.jsp">Volver</a></td>
            </form>
            <%!
public Connection getConnection(String path) throws SQLException{
    String driver = "sun.jdbc.odbc.JdbcOdbcDriver";
    String filePath = path+"\\datos.mdb";
    String userName = "", password= "";
    String fullConnectionString = "jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=" + filePath;

    Connection conn = null;

    try{
        Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
        conn = DriverManager.getConnection(fullConnectionString, userName,password);
    }
    catch(Exception e){
        System.out.println("Error: "+ e);
    }
    return conn;
}
%>
                <%
ServletContext context = request.getServletContext();
String path = context.getRealPath("/data");
Connection conexion = getConnection(path);
   if (!conexion.isClosed()){
    out.write("OK");
    //Statement st = conexion.createStatement();
    //ResultSet rs = st.executeQuery("select * from libros" );

    //Parte del Ejercicio 3
      String query;
      String buscarT = request.getParameter("titulo");
      String buscarA = request.getParameter("Autor");
      String buscarI = request.getParameter("isbn");
      String autor = request.getParameter("Autor");
      String titulo = request.getParameter("titulo");

      if(buscarT != null){
        query= "select * from libros where titulo LIKE"+ "'" + buscarT + "'" +" OR Autor LIKE"+"'" + buscarA + "'";
      }else if(buscarI != null){
        query = "select * from libros where isbn =" + "'" + buscarI + "'";
      }else{
        query = "select * from libros";
      }

      Statement st = conexion.createStatement();

      String orden = "";
      try{
         orden = request.getParameter("orden");
      }
      catch(Exception e) {
         
       }
      ResultSet rs = st.executeQuery(query);
      try{
         if(orden.equals("ASC") || orden.equals("DESC")){
            rs =  st.executeQuery("select * from libros ORDER BY titulo "+orden );
         }
      }
      catch(Exception e) {
         
      }
      // Ponemos los resultados en un table de html
      try{
         if(orden.equals("ASC")){
            out.println("<table id=\"color\"; align = \"center\";><tr id=\"color\"><td>Num.</td><td>ISBN</td><td><a href='libs.jsp?orden=DESC'>T&iacute;tulo</a></td><td>Autor</td><td>A&ntilde;o de Publicaci&oacute;n</td><td>Editorial</td><td>Acci&oacute;n</td></tr>");
         }else{
            out.println("<table id=\"color\"; align = \"center\";><tr id=\"color\"><td>Num.</td><td>ISBN</td><td><a href='libs.jsp?orden=ASC'>T&iacute;tulo</a></td><td>Autor</td><td>A&ntilde;o de Publicaci&oacute;n</td><td>Editorial</td><td>Acci&oacute;n</td></tr>");
         }
      }
      catch(Exception e) {
         out.println("<table id=\"color\"; align = \"center\";><tr id=\"color\"><td>Num.</td><td>ISBN</td><td><a href='libs.jsp?orden=ASC'>T&iacute;tulo</a></td><td>Autor</td><td>A&ntilde;o de Publicaci&oacute;n</td><td>Editorial</td><td>Acci&oacute;n</td></tr>");
      }
      /*
      // Ponemos los resultados en un table de html
      out.println("<table id=\"color\"; align = \"center\";><tr id=\"color\"><td>Num.</td><td>ISBN</td><td><a href='libs.jsp?orden=ASC'>T&iacute;tulo</a></td><td>Autor</td><td>A&ntilde;o de Publicaci&oacute;n</td><td>Editorial</td><td>Acci&oacute;n</td></tr>");*/
      int i=1;
      while (rs.next())
      {
        out.println("<tr>");
        out.println("<td name=\"color\">"+ i +"</td>");
        out.println("<td name=\"color\" id='is"+i+"'>"+rs.getString("isbn")+"</td>");
        out.println("<td name=\"color\" id='ti"+i+"'>"+rs.getString("titulo")+"</td>");
        out.println("<td name=\"color\" id='au"+i+"'>"+rs.getString("Autor")+"</td>");
        out.println("<td name=\"color\" id='pb"+i+"'>"+rs.getString("publicacion")+"</td>");
        out.println("<td name=\"color\" id='ed"+i+"'>"+rs.getString("editorial")+"</td>");
       
        out.println("<td name=\"color\"><a href=\"#!\"; id='"+i+"' onclick='actualizar(this);'>Actualizar</a><br><a href=\"#!\"; id='"+i+"' onclick='eliminar(this);'>Eliminar</a></td>");
        out.println("</tr>");
         i++;
      }
      out.println("</table>");

      // cierre de la conexion
      conexion.close();
    }
%>
                    <br>
                    <br>
                    <p><a id="volver" href="listado-csv.jsp" download=”libros.csv”>Descargar Listado</a>&nbsp;&nbsp;&nbsp;&nbsp;
                        <a id="volver" href="listado-txt.jsp" download="Libros.txt">Descargar Listado.txt</a>&nbsp;&nbsp;&nbsp;&nbsp;
                        <a id="volver" href="listado-xml.jsp" download="Libros.xml">Descargar Listado.xml</a>&nbsp;&nbsp;&nbsp;&nbsp;
                        <a id="volver" href="lista-json.jsp" download="Libros.json">Descargar Listado.json</a>&nbsp;&nbsp;&nbsp;&nbsp;</p>
    </body>

    </html>