<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="com.project.dao.LoginDao" 
    pageEncoding="ISO-8859-1" isELIgnored="false"%>
   	 <%! 
	LoginDao infoLog= new LoginDao();
    %>
<!DOCTYPE html>
<html>
<head>
<title>Dashboard</title>
<meta charset="utf-8">
		  <meta name="viewport" content="width=device-width, initial-scale=1">
		  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
		  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
		  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
		  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
		  
<style>

<!-- sidenavbar -->
body {
  font-family: "Calibri", sans-serif;
}

.sidenav {
  height: 100%;
  width: 250px;
  position: fixed;
  z-index: 1;
  top: 0;
  left: 0;
  background-color: #F5F5F5;
  overflow-x: hidden;
  padding-top: 20px;
}

.sidenav a {
  padding: 6px 8px 6px 16px;
  text-decoration: none;
  font-size: 20px;
  color: #0000ff;
  display: block;
}

.sidenav a:hover {
  color: #000000;
  text-decoration: none;
}

.main {
  margin-left: 200px; /* Same as the width of the sidenav */
}

</style>
</head>
<body>
	
	<%@ include file="../header.jsp" %>
	
	<div class="container">
	<div class="row">
	    <div class="col-sm-*">
			<!-- sidenavbar -->
			<%@page import="com.project.entity.Login" %>
			<%@page import="org.springframework.web.servlet.ModelAndView" %>
			<% Login l=(Login)session.getAttribute("userInfo");	 %>
			<div class="sidenav">
				<a><br/><br/>
				<div style="background-color: rgba(255,0,0,0.4);">&nbsp;&nbsp;&nbsp;
					<span class="badge badge-pill badge-warning">&nbsp;&nbsp;<%= l.getRole().toUpperCase() %>&nbsp;&nbsp;</span><br/><br/>
					<b>Username:</b> <%= l.getUsername() %><br/><br/>
					<b>Id:</b> <%= l.getId() %><br/>
					<a href="editView.html">
			    	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="text-decoration:underline; color:green;">edit...</span>
			    	</a>
				</div>
				</a><br/>
				
		<% if(!l.getId().equals("EMP100")){ %>
				<a href="personalInfo.html">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Personal Info
				</a>
		<%} %>
		
		<% if(l.getRole().equals("receptionist")){ %>
				<a href="addPatientView.html">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Add Patient
				</a>
				<a href="searchPatientView.html">
					<span style="color: orange;">&nbsp;&nbsp;&nbsp;&nbsp;>&nbsp;&nbsp;Search Patient</span>
				</a>
				<a href="opdQueueView.html">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;OPD Queue
				</a>
				<a href="prescriptionQueueView.html">
					<% String count=""+request.getAttribute("prescriptionsCount"); %>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Prescriptions 
					<span class="badge badge-pill badge-danger"><%=count %></span>
				</a>
		<%} %>
		
		<% if(l.getRole().equals("doctor")){ %>
				<a href="opdQueueD.html">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;OPD Queue
				</a>
				<a href="searchPatientView.html">
				<span style="color: orange;">&nbsp;&nbsp;&nbsp;&nbsp;>&nbsp;&nbsp;Search Patient</span>
				</a>
				<a class="text-primary">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Patient General Info
				</a>
				<a class="text-primary">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;History
				</a>
				<a class="text-primary">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Observations &<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Prescription
				</a>
		<%} %>
			</div>
	    </div>
	    
	    <div class="col-sm-12">
	      <!-- display window -->
			<div class="main"><br/><br/>
			<h1>Search Existing Patient</h1></br>
			 		<%	
					try{
						String status=(request.getAttribute("status")).toString();
						infoLog.logActivities(status);
						if(status.equals("false"))
						{  
					%>	<div class="text-danger"><b>Unable to fetch unique patient data..Verify your Credentials..</b></div>
					<%  }
						}catch(Exception e){infoLog.logActivities(""+e);}
					%>
			
			<div class="card bg-light border-primary mb-3" >
			  <div class="card-header"><h4>By Name</h4></div>
			  <div class="card-body">
			    <p class="card-text">
			    	<form action="searchPatientByName.html" method="post" >
						 <div class="form-group">
						 	<label>Firstname</label>
						 	<input type="text" class="form-control" id="exampleInputEmail1" name="firstName" placeholder="first name"
						 	required="required" autocomplete="off" maxlength="20">
						 </div>
						 <div class="form-group">
						 	<label>Lastname</label>
						 	<input type="text" class="form-control" id="exampleInputEmail1" name="lastName" placeholder="last name"
						 	required="required" autocomplete="off" maxlength="20">
						 </div>
						 <div style="text-align: center;">
				    	<button type="submit" class="btn btn-primary">Search</button>
				    	</div>
				    </form>
			    </p>
			  </div>
			</div>
				
			<div class="card bg-light border-danger mb-3" >
			  <div class="card-header"><h4>By Id</h4></div>
			  <div class="card-body">
			    <p class="card-text">
			    	<form action="searchPatientById.html" method="post" >
						 <div class="form-group">
						 	<label>Id</label>
						 	<input type="text" class="form-control" id="exampleInputEmail1" name="id" placeholder="Pxxx"
						 	required="required" autocomplete="off" maxlength="10">
						 </div>
				    	<div style="text-align: center;">
				    	<button type="submit" class="btn btn-primary">Search</button>
				    	</div>
				    </form>
			    </p>
			  </div>
			</div>
			
			<div class="card bg-light border-info mb-3" >
			  <div class="card-header"><h4>By Mobile No</h4></div>
			  <div class="card-body">
			    <p class="card-text">
			    	<form action="searchPatientByMobileNo.html" method="post" >
						 <div class="form-group">
						 	<label>Mobile No</label>
						 	<input type="text" class="form-control" id="exampleInputEmail1" name="mobileNo" placeholder="10 digit"
						 	required="required" autocomplete="off" minlegth="10" maxlegth="10">
						 </div>
						 <div style="text-align: center;">
				    	<button type="submit" class="btn btn-primary">Search</button>
				    	</div>
				    </form>
			    </p>
			  </div>
			</div>
				
			<div class="card bg-light border-warning mb-3" >
			  <div class="card-header"><h4>By Aadhar No</h4></div>
			  <div class="card-body">
			    <p class="card-text">
			    	<form action="searchPatientByAdharNo.html" method="post" >
						 <div class="form-group">
						 	<label>Adhar No</label>
						 	<input type="text" class="form-control" id="exampleInputEmail1" name="aadharNo" placeholder="12 digit"
						 	required="required" autocomplete="off" minlegth="12" maxlegth="12">
						 </div>
						 <div style="text-align: center;">
				    	<button type="submit" class="btn btn-primary">Search</button>
				    	</div>
				    </form>
			    </p>
			  </div>
			</div>		
			
		</div>
		</div>
		
	</div>
	</div>
	
</body>
</html> 
<body>