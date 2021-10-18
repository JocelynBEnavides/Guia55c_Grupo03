@WebServlet (value="/anotaciones")
public class MappingAnotaciones extends HttpServlet {
  private static final long serialVersionUID = 1L;
 
  public MappingAnotaciones() {
    super();
  }
 
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    response.getWriter().append("Servlet de Prueba de Mapping por anotaciones");
  }
 
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    doGet(request, response);
  }
}