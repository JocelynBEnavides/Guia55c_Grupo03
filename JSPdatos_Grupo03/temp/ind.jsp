<%
   String site = "http://www.google.com.gt" ;
 
response.setStatus(200);
response.setHeader("Content-Type", "text/csv");
response.setHeader("Content-Disposition","attachment; filename=\"filename.csv\"");
%><%@ page language="java" import="java.util.*" %>1,2,3
5,6,7
,,=sum(c1..c2)