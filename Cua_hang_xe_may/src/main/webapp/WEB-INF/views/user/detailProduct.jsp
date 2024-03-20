<%@page import="com.demo.entities.Image"%>
<%@page import="com.demo.helpers.ColorHelper"%>
<%@page import="com.demo.entities.ProductColor"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="com.demo.entities.ProductVersion"%>
<%@page import="com.demo.models.ProductModel"%>
<%@page import="com.demo.entities.Product"%>
<%@page import="com.demo.models.CommentModel"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.demo.entities.CommentCustom"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored = "false"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
   <%
   List<Image> images = (List<Image>) request.getAttribute("images");
   if(images == null) images = new ArrayList<>();
   List<CommentCustom> comments =(List<CommentCustom>) request.getAttribute("comments");
      if(comments == null) comments = new ArrayList<>();
      String id= request.getParameter("id");
      int idproduct = Integer.parseInt(id);
      Product product = (Product) request.getAttribute("product");
   %>
     <%ProductModel productModel = new ProductModel(); 
                    List<ProductVersion> productVersions = productModel.findAllVersionByProduct(idproduct);
                    	int productVersionID = productVersions.get(0).getId();
                        List<ProductColor> productColorsFirst = productModel.findAllColorByProductVersion(productVersionID);
                        ProductColor productColor = productColorsFirst.get(0);
                        if(productVersions == null) productVersions = new ArrayList<>();
                        
        CommentModel commentModel = new CommentModel();
    %>
   <style>
    .color-cell{
        height: 25px;
        margin-top: 10px;
        border: 1px solid #d2d2d6;
        transform: skewX(-30deg);
        padding: 5px 9px;
    }
    .color-value{
        justify-content: flex-start;
    }

</style>
 <script>
        	
				$(document).ready(function() {
					
					$('.color span').click(function() {
						var colorID = $('#con', this).val();
						$.ajax({
							type: 'GET',
							dataType: 'json',
							contentType: 'application/json; charset=utf-8',
							url: '${pageContext.request.contextPath}/details',
							data: {
								action: 'changeVersion',
								colorID : colorID
							},
							success: function (data) {
								var color = data.color;
								var version = data.version;
								var options = { style: 'decimal', useGrouping: true };
								var price = color.price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
								$('#img').attr('src', '${pageContext.request.contextPath}/assets/user/Image/' + color.photo);
								$('#price').html('Giá ' + price +' VNĐ');
								$('#versionName').html( version.versionName);
								$('#ColornName').html(color.color);
								$('#cartId').attr('href' , '${pageContext.request.contextPath}/cart?action=buynow&id='+color.id) 
								
							}
						});
					});
				});
		
        </script>
        
        
    <div class="container-fluid ">
        <div class="container">
            <h1>Bảng giá và màu sắc </h1>
            <div class="row mt-3" style="font-size: 20px;border-top: 5px solid orange;">
                <div class="col-lg-6 ">
                    <div class="container-fluid p-0"  > 
                  
                       <div class="large" style="width: 100%; height: 100% ;" id="result"> 
                      
                          <img id="img" src="${pageContext.request.contextPath}/assets/user/Image/<%=productColor.getPhoto() %>" alt="" id="largeImage" style="width: 100%; height: 100%">
                        
                         <div class="container d-flex">
                <div class="header mr-5">
                    <h1><%=product.getName() %>  </h1>  <h1  id="versionName"> Phiên bản <%=productVersions.get(0).getVersionName() %></h1>	<h1  id="ColornName"> <%=productColor.getColor() %></h1>
                    <div id="price" style="font-size: 30px;">Giá <fmt:formatNumber type="number" value="<%= productColor.getPrice()%>" pattern="#,##0"/> VNĐ </div>
                </div>
           	
            
        </div> 
       
                       </div>
                   </div aaa>
                </div >
                
       
                <div class="col-lg-6 pt-5">
                    <div class="bg-white">
                   	<%if(productVersions != null) { %>
                    <%for(ProductVersion pv : productVersions) { %>
                        <div class="color-value">
                        	<div>
                        		<b> <%= pv.getVersionName() %> </b>
	                        	<div class="color-group" id="versionSpecial" style="display: flex; cursor: pointer;" >
	                        
	                        		<%
	                        		   List<ProductColor> productColors = productModel.findAllColorByProductVersion(pv.getId()); 
	                        			
	                        		   if(productColors == null) productColors = new ArrayList<>();
	                        			ColorHelper colorHelper = new ColorHelper();
	                        			
	                        		%>
	                        		
	                        		<% for(ProductColor pc: productColors)  {%>
	                        			<div style="display: flex; margin-right: 15px;" class="color">
	                        				<div class="color-item" style="display: flex; margin-right: 15px;">
		                        		<div class="color-cell" style="background-color: <%= colorHelper.colorHelper(pc.getValue())[0] %>; width: 20px;"></div>
		                                <div class="color-cell" style="background-color: <%= colorHelper.colorHelper(pc.getValue())[1] %>; width: 20px;"> </div>
		                          	</div>
		                          		   <span style="padding-top: 10px"><%= pc.getColor()%> <input id="con" type="hidden" value="<%= pc.getId()%>"></span>
	                        			</div>
		                        	
		                            <% } %>
	                        	</div>	
                        	</div>
                   		 </div>
                   		 <br>
                   		 <% } 
                   	}
                   	%>
                   		 
               		 </div>
           		 </div>
        	</div>
    </div>

    <div class="container-fluid mb-2 ">
        <div class="container ">
        	<div class="row">
        		 <div class="col-6"> 
        		 	  <a href="${pageContext.request.contextPath}/cart?action=buynow&id=<%=productColor.getId()%>" 
        		 	  id="cartId" style="text-decoration: none;"><button class="btn btn-primary btn-lg btn-block"
        		 	   name="btnDatHang" style="width: 200px;height: 70px;">Thêm Vào Giỏ Hàng</button>
        		 	   </a> 
        		 </div>
        		 <div class="col-lg-6">
        		 	<div class="rent-item ">
        		 		 <% for(Image i: images) { %>	
        		 		 	<img class="mr-3 w-50 h-50"  src="${pageContext.request.contextPath}/assets/user/Image/<%=i.getPhoto()%>"> 
        		 		 	
        		 		 <% } %>
        		 	</div>
        		 	
        		 </div>
        	</div>
        	
         
        </div>
 		
    </div> 
    <div class="container-fluid mb-5">
        <div class="container pb-5" >
            <h1>Thông số kĩ thuật</h1>
            <div class="row mt-5" style="font-size: 20px;border-top: 5px solid orange;">
                <div class="col-6 mb-5 mt-5">Khối lượng bản thân</div>
                <div class="col-lg-6 mt-5"><%=product.getWeight() %></div>
            </div>
            <div class="row " style="font-size: 20px;">
                <div class="col-6 mb-5">Dài x Rộng x Cao</div>
                <div class="col-lg-6"><%=product.getSize() %> mm</div>
            </div>
            <div class="row " style="font-size: 20px;">
                <div class="col-6 mb-5">Độ cao yên</div>
                <div class="col-lg-6"><%=product.getSaddleHeight() %> mm</div>
            </div>
            <div class="row " style="font-size: 20px;">
                <div class="col-6 mb-5">Dung tích bình xăng</div>
                <div class="col-lg-6"><%=product.getPetrolCapacity() %> </div>
            </div>
            <div class="row " style="font-size: 20px;">
                <div class="col-6 mb-5">Kích cỡ lốp trước/sau</div>
                <div class="col-lg-6"> <%=product.getWheelSize() %></div>
            </div>
            <div class="row " style="font-size: 20px;">
                <div class="col-6 mb-5">Phuộc trước</div>
                <div class="col-lg-6"><%=product.getBeforeFork()%> </div>
            </div>
            <div class="row " style="font-size: 20px;">
                <div class="col-6 mb-5">Phuộc sau</div>
                <div class="col-lg-6"><%=product.getAfterFork()%></div>
            </div>
            <div class="row " style="font-size: 20px;">
                <div class="col-6 mb-5">Công suất tối đa</div>
                <div class="col-lg-6"><%=product.getMaxiumCapacity()%></div>
            </div>
            <div class="row " style="font-size: 20px;">
                <div class="col-6 mb-5">Dung tích nhớt máy</div>
                <div class="col-lg-6"><%=product.getOilCapacity()%> khi thay nhớt</div>
            </div>
            <div class="row " style="font-size: 20px;">
                <div class="col-6 mb-5">Mức thụ nhiên liệu</div>
                <div class="col-lg-6"><%=product.getFuelConsumption()%></div>
            </div>
            <div class="row " style="font-size: 20px;">
                <div class="col-6 mb-5">Dung tích xi lanh</div>
                <div class="col-lg-6"><%=product.getCylinderCapacity()%>cc</div>
            </div>
            <div class="row " style="font-size: 20px;">
                <div class="col-6 mb-5">Moment cực đại</div>
                <div class="col-lg-6"><%=product.getMaxiumMoment()%> </div>
            </div>
            <div class="row " style="font-size: 20px;">
                <div class="col-6 mb-5">Tỷ số nén</div>
                <div class="col-lg-6"><%=product.getCompressionRatio()%></div>
            </div>
            <div class="row " style="font-size: 20px;">
                <div class="col-6 mb-5">Loại động cơ</div>
                <div class="col-lg-6"><%=product.getEngieType()%> làm mát bằng dung dịch </div>
            </div>
            
        </div>
    </div> 
    
    <!-- Detail End -->


    <!-- Related Car Start -->
    <div class="container-fluid pb-0">
        <div class="container pb-5">
            <h2 class="mb-4">Chi tiết</h2>
            <div class="owl-carousel related-carousel position-relative" style="padding: 0 30px;">
                <div class="rent-item">
                    <img class="img-fluid mb-4" src="${pageContext.request.contextPath}assets/user/Image/Honda/denxe.jpg" alt="">
                    <h4 class="text-uppercase mb-4">Đèn Xe</h4>
                    <div class="d-flex justify-content-center mb-4">
                        <span> Chế độ đèn luôn sáng đảm bảo cho người sử dụng có tầm nhìn tốt nhất trong các trường hợp 
                             đi trong điều kiện ánh sáng không đảm bảo</span>
                    </div>
                </div>
                <div class="rent-item">
                    <img class="img-fluid mb-4" src="${pageContext.request.contextPath}assets/user/Image/Honda/copxe.jpg" alt="">
                    <h4 class="text-uppercase mb-4">Hộp đựng đồ dưới yên xe</h4>
                    <div class="d-flex justify-content-center mb-4">
                        <span> Cho phép chứa tới 2 mũ bảo hiểm nửa đầu cùng nhiều vật dụng cá nhân khác
                            mà vẫn giữ nguyên thiết kế thon gọn. </span>
                    </div>
                </div>
                <div class="rent-item">
                    <img class="img-fluid mb-4" src="${pageContext.request.contextPath}assets/user/Image/Honda/donghoxe.jpg" alt="">
                    <h4 class="text-uppercase mb-4">Đồng Hồ Xe</h4>
                    <div class="d-flex justify-content-center mb-4">
                        <span> Mặt đồng hồ LCD kỹ thuật số với thiết kế hiện đại, gọn gàng, giúp tăng khả năng hiển thị và dễ dàng quan sát <br>
                        </span>
                    </div>
                </div>
                <div class="rent-item">
                    <img class="img-fluid mb-4" src="${pageContext.request.contextPath}assets/user/Image/Honda/smart key.jpg" alt="">
                    <h4 class="text-uppercase mb-4">Smart Key</h4>
                    <div class="d-flex justify-content-center mb-4">
                        <span> Việc xác định vị trí xe cùng chức năng báo động được tích hợp trên thiết bị điều khiển FOB 
                            giúp tăng sự tiện lợi và an tâm cho khách hàng.</span>
                    </div>
                </div>
            
            </div>
        </div>
    </div>
    <script>
    	$(document).ready(function() {
    		var productID = $('#productID').val();
    		
    		console.log(productID);
    		function loadComment(){
    			var s = '';
        		$.ajax({
        			type: 'GET',
        			url: '${pageContext.request.contextPath}/details',
        			data: {
        				action : 'loadComment',
        				productID : productID
        			},
        			success: function(comments) {
						for (var i = 0; i < comments.length; i++) {
							s+= '<div class="d-flex align-items-top bg-light mb-4">';
							s+= '<div class="d-flex align-items-center justify-content-center flex-shrink-0 bg-white ml-n4 mr-4" style="width: 100px;">';
							s+= '<img src="${pageContext.request.contextPath}/assets/admin/dist/img/avatar2.png" class="rounded-circle w-50" alt="">';
							s+= '</div>';
							s+= '<div>';
							s+= '<p style="margin: 0; color: black;">' + comments[i].accountId + '</p>';
							s+= '<p class="p-1 m-0" style="font-size: 15px;">' + comments[i].created +'</p>';
							s+= '<p class="m-0 p-1" style=" color: black; font-family: Arial, Helvetica, sans-serif;">' + comments[i].content + '</p>';
							s+= ' </div></div>';
						}
						$('#resultLoadComment').html(s);
						$('#feedbackNumber').html('Co ' + comments.length + ' danh gia');
					}
        			
        		});
        	}
    		
    		setInterval(loadComment, 50);
		});
    	
    </script>
    <input id="productID" type="hidden" value="<%= idproduct %>">
    <span id="test"></span>
    <div class="container-fluid ">
    <h1 class="mb-6" style="border-top: 5px solid orange;">Đánh Giá Sản Phẩm</h1>
            <p style="color: black;" id="feedbackNumber"></p>
        <div class="container" >
            
            
            <div id="resultLoadComment">
               
            </div>
         
            <form action="${pageContext.request.contextPath}/details?action=comment" method="post">
                <div class="form-group">
                	<input type="hidden" name="productId" value="<%= id%>">
                	<c:if test="${sessionScope.account != null}">
                	<input type="hidden" name="accountId" value="${sessionScope.account.id}">
                	 <textarea class="form-control py-3 px-4" name="content" rows="2" placeholder="Bình luận" required="required"></textarea>
                    <div class="mt-1">
                        <button class="btn btn-primary py-3 px-3" type="submit">Gửi đánh giá</button>
                    </div>
                	</c:if>
                	<c:if test="${sessionScope.account == null}">
                	<span>
                	 Bạn Chưa Đăng Nhập Tài Khoản! <a href="${pageContext.request.contextPath}/login"> Đăng Nhập ngay để bình luận </a>
                	
                	 </span>
                	</c:if>
                   
                </div>
            </form>
        </div>
    </div>
    <!-- Related Car End -->
    <div class="container-fluid py-0">
        <div class="container pt-0">
            <h1 class="display-6 text-uppercase text-center mb-1">Có thể bạn quan tâm</h1>
            <div class="row list">
                <div class="col-lg-3 col-md-6 mb-2 item">
                    <div class="rent-item mb-4">
                        <img class="img-fluid mb-4" src="${pageContext.request.contextPath}assets/user/Image/Honda/xeSo/Blade_special.png" alt="">
                        <h4 class="text-uppercase mb-4">EXCITER 155 VVA PHIÊN BẢN GIỚI HẠN ABS GP</h4>
                        <div class="d-flex justify-content-center mb-4">
                            <div class="px-2">
                                <i class="fa fa-dollar-sign text-primary mr-1"></i>
                                <span>54.000.000 VNĐ</span>
                            </div>
                        </div>
                        <a class="btn btn-primary px-3" href="">Xem Chi Tiết</a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-2 item">
                    <div class="rent-item mb-4">
                        <img class="img-fluid mb-4" src="${pageContext.request.contextPath}assets/user/Image/Honda/xeSo/Blade_special.png" alt="">
                        <h4 class="text-uppercase mb-4">EXCITER 155 VVA PHIÊN BẢN GIỚI HẠN ABS GP</h4>
                        <div class="d-flex justify-content-center mb-4">
                            <div class="px-2">
                                <i class="fa fa-dollar-sign text-primary mr-1"></i>
                                <span>54.000.000 VNĐ</span>
                            </div>
                        </div>
                        <a class="btn btn-primary px-3" href="">Xem Chi Tiết</a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-2 item">
                    <div class="rent-item mb-4">
                        <img class="img-fluid mb-4" src="${pageContext.request.contextPath}assets/user/Image/Honda/xeSo/Blade_special.png" alt="">
                        <h4 class="text-uppercase mb-4">EXCITER 155 VVA PHIÊN BẢN GIỚI HẠN ABS GP</h4>
                        <div class="d-flex justify-content-center mb-4">
                            <div class="px-2">
                                <i class="fa fa-dollar-sign text-primary mr-1"></i>
                                <span>54.000.000 VNĐ</span>
                            </div>
                        </div>
                        <a class="btn btn-primary px-3" href="">Xem Chi Tiết</a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-2 item">
                    <div class="rent-item mb-4">
                        <img class="img-fluid mb-4" src="${pageContext.request.contextPath}assets/user/Image/Honda/xeSo/Blade_special.png" alt="">
                        <h4 class="text-uppercase mb-4">EXCITER 155 VVA PHIÊN BẢN GIỚI HẠN ABS GP</h4>
                        <div class="d-flex justify-content-center mb-4">
                            <div class="px-2">
                                <i class="fa fa-dollar-sign text-primary mr-1"></i>
                                <span>54.000.000 VNĐ</span>
                            </div>
                        </div>
                        <a class="btn btn-primary px-3" href="">Xem Chi Tiết</a>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <!-- Vendor Start -->
     <div class="container-fluid py-5">
                <div class="container py-5">
                    <div class="owl-carousel vendor-carousel">
                        <div class="bg-light p-4">
                            <img src="${pageContext.request.contextPath}/assets/user/Image/Honda/logo-vinfast.png" alt="">
                        </div>
                        <div class="bg-light p-4">
                            <img src="${pageContext.request.contextPath}/assets/user/Image/Honda/suzuki.png" alt="">
                        </div>
                        <div class="bg-light p-4">
                            <img src="${pageContext.request.contextPath}/assets/user/Image/Honda/logo_ducati.png" alt="">
                        </div>
                        <div class="bg-light p-4">
                            <img src="${pageContext.request.contextPath}/assets/user/Image/Honda/yamaha.png" alt="">
                        </div>
                        <div class="bg-light p-4">
                            <img src="${pageContext.request.contextPath}/assets/user/Image/Honda/piago.png" alt="">
                        </div>
                        <div class="bg-light p-4">
                            <img style="width:114px;height:114px" src="${pageContext.request.contextPath}/assets/user/Image/Honda/logohonda2.png" alt="">
                        </div>
                        <div class="bg-light p-4">
                             <img src="${pageContext.request.contextPath}/assets/user/img/vendor-7.png" alt="">
                        </div>
                    </div>
                </div>
            </div> 
    <!-- Vendor End -->
     <script>
        function validateForm(){
            var hovaten = document.getElementById("hovaten").value;
            var dc = document.getElementById("dc").value;
            var dt= document.getElementById("dt").value;
            var email = document.getElementById("email").value;
            var cmnd = document.getElementById("cmnd").value;
            if(hovaten.trim() === ""){
                document.getElementById("hotenError").style.display = "block"; 
            } else{
                document.getElementById("hotenError").style.display = "none";
            }
            if(dc.trim() === ""){
                document.getElementById("dcError").style.display = "block"; 
            }  
            else{
                document.getElementById("dcError").style.display = "none";
            }
             if(dt.trim() === ""){
                document.getElementById("dtError").style.display = "block"; 
             }  
             else{
                document.getElementById("dtError").style.display = "none";
             }
            if(email.trim() === ""){
                document.getElementById("emailError").style.display = "block"; 
            }  
            else{
                document.getElementById("emailError").style.display = "none";
            }
            if(cmnd.trim() === ""){
                document.getElementById("cmndError").style.display = "block"; 
            }  
            else{
                document.getElementById("cmndError").style.display = "none";
            }
            return false;
        }
        function showForm(){
            var form = document.getElementById("container1");
            var opt =document.getElementById("httt-1");
            var opt1 = document.getElementById("httt-2");
            var opt2 = document.getElementById("httt-3");
            if(opt1.checked){
              document.getElementById("theForm").style.display = "block";
              document.getElementById("visaForm").style.display="none";
            }else if(opt2.checked){
                document.getElementById("theForm").style.display = "none";
                document.getElementById("visaForm").style.display="block";

            }else{
                document.getElementById("theForm").style.display = "none";
              document.getElementById("visaForm").style.display="none";
            }

        }
    </script>

    