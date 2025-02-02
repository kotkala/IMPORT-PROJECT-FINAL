<%@page import="java.text.DecimalFormat"%>
<%@page import="com.demo.entities.Invoice"%>
<%@page import="com.demo.models.CustomerModel"%>
<%@page import="com.demo.entities.Customer"%>
<%@page import="com.demo.models.AccountModel"%>
<%@page import="com.demo.entities.Employee"%>
<%@page import="com.demo.models.EmployeeModel"%>
<%@page import="com.demo.models.ColorModel"%>
<%@page import="com.demo.entities.ProductColor"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.demo.models.ProductModel"%>
<%@page import="com.demo.entities.Product"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored = "false"%>
      <% Invoice invoice = (Invoice) request.getAttribute("invoice");
      ProductModel productModel = new ProductModel();
      ProductColor productColor = productModel.findProductColorById(invoice.getColorId());
      EmployeeModel employeeModel = new EmployeeModel();
      Employee employee = employeeModel.findEmployeebyId(invoice.getEmployeeId());
      CustomerModel customerModel = new CustomerModel();
      Customer customer = customerModel.findCustomerById(invoice.getCustomerId());
      AccountModel accountModel  = new AccountModel();
      DecimalFormat df = new DecimalFormat("######");
      %>
      <!-- Content Header (Page header) -->
      <div class="content-header">
        <div class="container-fluid">
          <div class="row mb-2">
            <div class="col-sm-6">
              <h1 class="ml-2">Sửa Dữ Liệu Mua Hàng</h1>
            </div><!-- /.col -->
            <div class="col-sm-6">
              <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath }/admin/home">Trang Chủ</a></li>
                <li class="breadcrumb-item active">Sửa Dữ Liệu Mua Hàng</li>
              </ol>
            </div><!-- /.col -->
          </div><!-- /.row -->
        </div><!-- /.container-fluid -->
      </div>
      <!-- /.content-header -->
      <!-- Main content -->
      <section class="content">
        <div class="container-fluid">
          <!-- Small boxes (Stat box) -->
            <div class="row">
                <div class="col-md-12">
                <div class="card card-primary">
                    <div class="col-md-8 d-flex justify-content-center">
                        <h2 class="m-3 pl-lg-3 w-0">Nhập Dữ Liệu Mua Hàng</h2>
                    </div>
                    <!-- /.card-header -->
                    <!-- form start -->
                    <form action="${pageContext.request.contextPath }/admin/home?action=processupdateInvoice&id=<%=invoice.getId() %>" method="post">
                      <div class="card-body p-4" >
                        <div class="row">
                          <div class="col-md-4 ml-5">
                            <div class="form-group" data-select2-id="129">
                                <label>Đã Mua Xe</label>
                                <select class="form-control select2 select2-danger select2-hidden-accessible"
                                                        data-dropdown-css-class="select2-danger" style="width: 100%;"
                                                        data-select2-id="999" tabindex="-1" aria-hidden="true" name="colorId">
                                                    <option selected="selected" value="<%=invoice.getColorId() %>"  data-select2-id="<%=198+ invoice.getColorId() %>">
                                                    <%= productModel.findProductById(productModel.findProductVersionById(productColor.getVersionID()).getProductID()).getName() %> -                                                  
                                                     <%=productModel.findProductVersionById(productColor.getVersionID()).getVersionName() %> - 
                                                  	<%=productColor.getColor()%> 
                                                    </option>
                                                    <%
                                                    ColorModel colorModel = new ColorModel();
                                                    List<ProductColor> colors =  colorModel.findAll();
                                                    if(colors == null) colors = new ArrayList<>();
                                                    %>
                                                    <% for(ProductColor c : colors)  {%>
                                                    <option data-select2-id="<%=198+ c.getId() %>" value="<%=c.getId()%>">
                                                    <%= productModel.findProductById(productModel.findProductVersionById(c.getVersionID()).getProductID()).getName() %> -                                                  
                                                     <%=productModel.findProductVersionById(c.getVersionID()).getVersionName() %> - 
                                                  	<%=c.getColor()%> 
                                                    </option>
                                                    <% } %>
                                                           
                                                </select>
                                </div>
                          </div>
                          <div class="col-md-4 ml-5">
                            <div class="form-group">
                                <label for="examplePrice">Giá Tiền(VNĐ)</label>
                                <input type="number" name="price" class="form-control" id="examplePrice" value="<%=df.format(invoice.getPrice()) %>" placeholder="3.000.000">
                            </div>
                          </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-4 ml-5">
                                <div class="form-group" data-select2-id="138">
                                <%
                                	List<Employee> employees = employeeModel.findAll();
                                	if(employees == null) employees = new ArrayList<>();
                                	%>
                                	
                                    <label>Nhân Viên Bán</label>
                                    
                                    <select name="employeeId" class="form-control select2 select2-danger select2-hidden-accessible" data-dropdown-css-class="select2-bootstrap4" style="width: 100%;" data-select2-id="13" tabindex="-1" aria-hidden="true">  
                                    <option selected="selected" value="<%=employee.getId() %>" data-select2-id="<%=10000 + employee.getId() %>"><%=accountModel.findAccountById(employee.getAccountID()).getName() %></option>
                                     <%for(Employee e: employees){ %>
                                    
                                    <option value="<%=e.getId() %>"  data-select2-id="<%=10000+ e.getId()%>"><%=accountModel.findAccountById(e.getAccountID()).getName() %> - MNV: <%=e.getId() %> </option>
                                    <% } %>
                                    </select>
                                </div>
                            </div>
                           <div class="col-sm-4 ml-5 ">
                            <div class="form-group" data-select2-id="128">
                          <%
                            List<Customer> customers = customerModel.findAll();
                            if(customers == null) customers = new ArrayList<>();
                        	%>
                                <label>Khách Hàng</label>
                                <select name="customerId" class="form-control select2 select2-danger select2-hidden-accessible" data-dropdown-css-class="select2-danger" style="width: 100%;" data-select2-id="14" tabindex="-1" aria-hidden="true">
                                <option selected="selected" value="<%=customer.getId() %>" data-select2-id="<%=1000 + customer.getId() %>"><%=customer.getName() %></option>
                                <% for(Customer c: customers) { %>
                                 <option value="<%=c.getId() %>" data-select2-id="<%=1000 + c.getId() %>"><%=c.getName() %> - <%=c.getPhone() %></option>                               	
                                <% } %>
                                </select>
                            </div>
                        </div>
                        </div>
                        <div class="row">
                           <div class="col-md-4 ml-5">
                                <div class="form-group">
                                    <label>Ngày Bán</label>
                                    <div class="input-group">
                                    <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="far fa-calendar-alt"></i></span>
                                    </div>
                                    <input id="date" name="tradeDate" value="<%=invoice.getTradeDate() %>" class="form-control" data-inputmask-alias="datetime" data-inputmask-inputformat="dd/mm/yyyy" data-mask="" inputmode="numeric">
                                    </div>
                                </div>
                            </div>
                      </div>
                      <!-- /.card-body -->
                      <div class="card-footer  ml-5">
                        <button type="submit" class="btn btn-primary">Sửa</button>
                      </div>
                      </div>
                        </form>
                    </div>
                  </div>
            </div>
                <!-- /.card-body -->
          <!-- /.row (main row) -->
          </div>
        </section>
        </div>
      <!-- /.content -->