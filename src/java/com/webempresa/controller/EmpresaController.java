/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.webempresa.controller;

import java.util.List;
import com.webempresa.model.Empresa;
import com.webempresa.webservices.EmpresaWebService;
import com.webempresa.webservices.EmpresaWebService_Service;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author CATASTOR
 */
@WebServlet(name = "EmpresaController", urlPatterns = {"/EmpresaController"})
public class EmpresaController extends HttpServlet {
    
    private static final String createCompany = "/createCompany.jsp";    
    private static final String editCompany = "/editCompany.jsp";    
    private static final String listCompanies = "/listCompanies.jsp";
    private static final String companyDetails = "/companyDetails.jsp";
    private final EmpresaWebService_Service service;
    private final EmpresaWebService port; 
    
    public EmpresaController() {
        super();
        service = new EmpresaWebService_Service();
        port = service.getEmpresaWebServicePort();
    }  
    
    public void createCompany(HttpServletRequest request){
        
        Empresa empresa = new Empresa(request.getParameter("CompanyNIT"), request.getParameter("Name"), request.getParameter("Address"), request.getParameter("Phone")); 
        com.webempresa.webservices.Empresa empresaWS = new com.webempresa.webservices.Empresa();
        empresaWS.setNit(empresa.getNit());
        empresaWS.setNombre(empresa.getNombre());
        empresaWS.setDireccion(empresa.getDireccion());
        empresaWS.setTelefono(empresa.getTelefono());
        
        try {        
            port.createCompany(empresaWS);
        } catch (Exception ex) {
            Logger.getLogger(EmpresaController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }    
        
    public void updateCompany(HttpServletRequest request){
        
        try {   
            Empresa empresa = this.findCompany(request); 
            empresa.setNombre(request.getParameter("Name"));
            empresa.setDireccion(request.getParameter("Address"));
            empresa.setTelefono(request.getParameter("Phone"));
            
            com.webempresa.webservices.Empresa empresaWS = new com.webempresa.webservices.Empresa();
            empresaWS.setNit(empresa.getNit());
            empresaWS.setNombre(empresa.getNombre());
            empresaWS.setDireccion(empresa.getDireccion());
            empresaWS.setTelefono(empresa.getTelefono());
            
            port.updateCompany(empresaWS);  
            
        } catch (Exception ex) {
            Logger.getLogger(EmpresaController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }   
        
    public void deleteCompany(HttpServletRequest request){
        
        try {   
            Empresa empresa = this.findCompany(request);
            
            com.webempresa.webservices.Empresa empresaWS = new com.webempresa.webservices.Empresa();
            empresaWS.setNit(empresa.getNit());
            empresaWS.setNombre(empresa.getNombre());
            empresaWS.setDireccion(empresa.getDireccion());
            empresaWS.setTelefono(empresa.getTelefono());
            
            port.deleteCompany(empresaWS); 
            
            //Eliminar empleados asociados
            //EmpleadoController empleadoController = new EmpleadoController();
            //empleadoController.deleteAllEmployees(request.getParameter("CompanyNIT"));
            
        } catch (Exception ex) {
            Logger.getLogger(EmpresaController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }  
    
    public Empresa findCompany(HttpServletRequest request){
        
        Empresa empresa;
        
        try {                    
            com.webempresa.webservices.Empresa empresaWS = port.findCompany(request.getParameter("CompanyNIT")); 
            empresa = new Empresa(empresaWS.getNit(), empresaWS.getNombre(), empresaWS.getDireccion(), empresaWS.getTelefono());
                        
            return empresa;   
            
        } catch (Exception ex) {
            Logger.getLogger(EmpresaController.class.getName()).log(Level.SEVERE, null, ex);
        }
                
        return null;
    } 
    
    public ArrayList<Empresa> listCompanies(){
        
        ArrayList<Empresa> listEmpresas = new ArrayList<>();
        List<com.webempresa.webservices.Empresa> listEmpresasWS = new ArrayList<>();
        
        try {
            listEmpresasWS = port.listCompanies();
            
            for (com.webempresa.webservices.Empresa empresaWS : listEmpresasWS) {                
                Empresa empresa = new Empresa(empresaWS.getNit(), empresaWS.getNombre(), empresaWS.getDireccion(), empresaWS.getTelefono());
                listEmpresas.add(empresa);
            }
            
        } catch (Exception ex) {
            Logger.getLogger(EmpresaController.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return listEmpresas;
    }
    
    public String manageRequest(HttpServletRequest request){
    
        EmpleadoController empleadoController = new EmpleadoController();
        String action = request.getParameter("action");
        String forward = "";
                 
        if (action.equalsIgnoreCase("listCompanies")){
            forward = listCompanies;
            request.setAttribute("companies", this.listCompanies());
        }         
        else if (action.equalsIgnoreCase("createCompany")){   
            this.createCompany(request);
            forward = listCompanies;     
            request.setAttribute("companies", this.listCompanies());            
        }           
        else if (action.equalsIgnoreCase("editCompany")){
            forward = editCompany;
            request.setAttribute("company", this.findCompany(request)); 
        }                
        else if (action.equalsIgnoreCase("updateCompany")){
            this.updateCompany(request);
            forward = listCompanies;
            request.setAttribute("companies", this.listCompanies()); 
        }       
        else if (action.equalsIgnoreCase("deleteCompany")){
            this.deleteCompany(request);
            forward = listCompanies;
            request.setAttribute("companies", this.listCompanies()); 
        }        
        else if (action.equalsIgnoreCase("companyDetails")){
            forward = companyDetails;
            request.setAttribute("company", this.findCompany(request));  
            request.setAttribute("employees", empleadoController.listEmployees(request.getParameter("CompanyNIT"))); 
        }  
        return forward;
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EmpresaController</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EmpresaController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String forward;
        
        forward = this.manageRequest(request);
        RequestDispatcher view = request.getRequestDispatcher(forward);
        view.forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String forward;        
        forward = this.manageRequest(request);
        RequestDispatcher view = request.getRequestDispatcher(forward);
        view.forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
