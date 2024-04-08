<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" type="image/png" sizes="16x16" href="images/favicon.png">
    <title>Edit Item</title>
    <link href="${pageContext.request.contextPath}/css/admin/lib/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/admin/helper.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/admin/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet">
</head>
<body class="fix-header">
 <c:if test="${not empty message}">
         <div id="overlay" class="overlay" onclick="hidePopup()"></div>
    <div id="popup" class="popup">
        <h2>${message.getTitle()}</h2>
        <p>${message.getDesc()}</p>
        <button class="popupbutton" onclick="hidePopup()">Close</button>
    </div>
    </c:if>
    <div class="preloader">
        <svg class="circular" viewBox="25 25 50 50">
            <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="2" stroke-miterlimit="10" />
        </svg>
    </div>

    <div id="main-wrapper">
        <div class="header">
            <nav class="navbar top-navbar navbar-expand-md navbar-light">
                <div class="navbar-header">
                    <a class="navbar-brand" href="dashboard.html">
                        <span><svg width="206" height="50" viewBox="0 0 206 50" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M0.55 0.839998H14.55V49H0.55V0.839998ZM17.49 38.29H18.05C20.3367 38.29 21.9467 38.1967 22.88 38.01C23.86 37.7767 24.5833 37.2633 25.05 36.47C25.5633 35.63 25.8433 34.3 25.89 32.48C25.9833 30.1467 26.03 27.6267 26.03 24.92C26.03 22.26 25.9833 19.7167 25.89 17.29C25.7967 15.47 25.4933 14.14 24.98 13.3C24.5133 12.46 23.7433 11.9467 22.67 11.76C21.5967 11.62 20.0567 11.55 18.05 11.55H17.49V0.839998H18.05C21.7833 0.839998 24.8867 1.00333 27.36 1.33C29.88 1.65666 31.9567 2.17 33.59 2.87C35.1767 3.57 36.4367 4.52666 37.37 5.74C38.3033 6.95333 38.98 8.47 39.4 10.29C39.7733 11.9233 40.0067 13.86 40.1 16.1C40.24 18.2933 40.31 21.2333 40.31 24.92C40.31 28.6533 40.24 31.6167 40.1 33.81C40.0067 36.0033 39.7733 37.9167 39.4 39.55C38.98 41.37 38.3033 42.8867 37.37 44.1C36.4367 45.3133 35.1767 46.27 33.59 46.97C31.9567 47.67 29.88 48.1833 27.36 48.51C24.8867 48.8367 21.7833 49 18.05 49H17.49V38.29ZM74.8681 24.92C74.8681 20.86 74.8448 18.2 74.7981 16.94C74.7048 15.0267 74.4481 13.65 74.0281 12.81C73.6081 11.9233 72.9315 11.3867 71.9981 11.2C71.0648 11.06 69.7348 10.99 68.0081 10.99C66.0015 10.99 64.6948 11.0833 64.0881 11.27V0.349996C64.5081 0.30333 65.1381 0.279997 65.9781 0.279997H68.0081C73.2348 0.279997 77.2715 0.699997 80.1181 1.54C83.0115 2.33333 85.1115 3.66333 86.4181 5.53C87.6315 7.25666 88.3781 9.52 88.6581 12.32C88.9848 15.12 89.1481 19.32 89.1481 24.92C89.1481 29.82 89.0315 33.6 88.7981 36.26C88.6115 38.8733 88.0981 41.0433 87.2581 42.77C86.3248 44.73 84.8781 46.2233 82.9181 47.25C81.0048 48.2767 78.3215 48.9533 74.8681 49.28V24.92ZM68.0081 49.56C61.1948 49.56 56.2948 48.8133 53.3081 47.32C51.7681 46.5733 50.5548 45.57 49.6681 44.31C48.7815 43.05 48.1281 41.4867 47.7081 39.62C47.3348 37.9867 47.1015 36.12 47.0081 34.02C46.9148 31.8733 46.8681 28.84 46.8681 24.92C46.8681 20.02 46.9615 16.2633 47.1481 13.65C47.3815 11.0367 47.9181 8.84333 48.7581 7.07C49.6915 5.15666 51.1148 3.68666 53.0281 2.66C54.9415 1.63333 57.6481 0.933332 61.1481 0.559998V24.92C61.1481 27.6733 61.1948 30.31 61.2881 32.83C61.3815 34.7433 61.6148 36.1433 61.9881 37.03C62.4081 37.9167 63.0848 38.43 64.0181 38.57C64.8115 38.7567 66.1415 38.85 68.0081 38.85C69.9215 38.85 71.2281 38.78 71.9281 38.64V49.49C71.5081 49.5367 70.8781 49.56 70.0381 49.56H68.0081ZM97.0051 2.8V0.839998H111.005L138.025 46.97V49H124.095L97.0051 2.8ZM124.725 18.41V0.839998H138.025V41.16L124.725 18.41ZM97.0051 8.61L110.305 31.36V49H97.0051V8.61ZM158.033 0.839998H159.223L164.753 20.02L156.703 49H142.703L158.033 0.839998ZM173.783 40.46H162.093L165.033 29.68H170.633L162.373 0.839998H175.183L190.513 49H176.233L173.783 40.46Z" fill="black"/>
                            <path d="M195.379 39.62C196.872 38.8267 198.389 38.43 199.929 38.43C203.382 38.43 205.109 40.04 205.109 43.26C205.109 44.9867 204.526 46.4567 203.359 47.67C202.192 48.8367 200.792 49.42 199.159 49.42C197.526 49.42 196.266 48.9533 195.379 48.02C194.539 47.0867 194.119 45.8267 194.119 44.24C194.119 42.6067 194.539 41.0667 195.379 39.62Z" fill="#F8B602"/>
                            </svg>
                            </span>
                    </a>
                </div>
                <div class="navbar-collapse">
                    <ul class="navbar-nav mr-auto mt-md-0"></ul>
                    <ul class="navbar-nav my-lg-0">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle text-muted  " href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img src="${pageContext.request.contextPath}/images/admin/images/bookingSystem/user-icn.png" alt="user" class="profile-pic" /></a>
                            <div class="dropdown-menu dropdown-menu-right animated zoomIn">
                                <ul class="dropdown-user">
                                    <li><a href="logout.html"><i class="fa fa-power-off"></i> Logout</a></li>
                                </ul>
                            </div>
                        </li>
                    </ul>
                </div>
            </nav>
        </div>

        <div class="left-sidebar">
            <div class="scroll-sidebar">
                <nav class="sidebar-nav">
                    <ul id="sidebarnav">
                        <li class="nav-devider"></li>
                        <li class="nav-label">Home</li>
                        <li> <a href="dashboard.html"><i class="fa fa-tachometer"></i><span>Dashboard</span></a></li>
                        <li class="nav-label">Log</li>
                        <li> <a href="${pageContext.request.contextPath}/admin/users"> <span><i class="fa fa-user f-s-20 "></i></span><span>Users</span></a></li>
                        <li> <a class="has-arrow  " href="#" aria-expanded="false"><i class="fa fa-archive f-s-20 color-warning"></i><span class="hide-menu">category</span></a>
                            <ul aria-expanded="false" class="collapse">
                                <!-- <li><a href="all_category.html">All categorys</a></li> -->
                                <li><a href="${pageContext.request.contextPath}/admin/category">Add Category</a></li>
                            </ul>
                        </li>
                        <li> <a class="has-arrow  " href="#" aria-expanded="false"><i class="fa fa-cutlery" aria-hidden="true"></i><span class="hide-menu">Menu</span></a>
                            <ul aria-expanded="false" class="collapse">
                                <li><a href="${pageContext.request.contextPath}/admin/items">All Items</a></li>
                                <li><a href="${pageContext.request.contextPath}/admin/additem">Add Item</a></li>
                            </ul>
                        </li>
                        <li> <a href="${pageContext.request.contextPath}/admin/orders"><i class="fa fa-shopping-cart" aria-hidden="true"></i><span>Orders</span></a></li>

                    </ul>
                </nav>
            </div>
        </div>
        <div class="page-wrapper">
            

            <div class="container-fluid">
                <div class="col-lg-12">
                    <div class="card card-outline-primary">
                        <div class="card-header">
                            <h4 class="m-b-0 text-white">Edit Item</h4>
                        </div>
                        <div class="card-body">
                            <form:form action="${pageContext.request.contextPath}/admin/edititem" method="post" enctype="multipart/form-data">
    <div class="form-body">
        <hr>
        <div class="row p-t-20">
            <input type="hidden" name="id" value="${item.getId()}">
            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label">Dish Name</label>
                    <input required="true" name="name" type="text" class="form-control" value="${item.getName()}" />
                    <c:if test="${not empty nameerror}">
    <span class="error">${nameerror}</span>
</c:if>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group has-danger">
                    <label class="control-label">Description</label>
                    <input required="true" name="desc" value="${item.getDescription()}" type="text" class="form-control form-control-danger" />
                    <c:if test="${not empty descerror}">
    <span class="error">${descerror}</span>
</c:if>
                </div>
            </div>
        </div>
        <div class="row p-t-20">
            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label">Price</label>
                    <input required="true" type="number" value="${item.getPrice()}" name="price" class="form-control" placeholder="0" />
                    <c:if test="${not empty priceerror}">
    <span class="error">${priceerror}</span>
</c:if>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group has-danger">
                    <label class="control-label">Image</label>
                    <input required="true" name="image"  type="file" id="file" class="form-control form-control-danger" placeholder="12n" />
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="form-group">
                    <label class="control-label">Select Category</label>
                    <select name="category" class="form-control custom-select" data-placeholder="Choose a Category" tabindex="1">
    <option value="-1">--Select Category--</option>
    <c:forEach items="${categories}" var="category">
        <c:choose>
            <c:when test="${category.getName() == item.getCategory().getName()}">
                <option value="${category.getId()}" selected>${category.getName()}</option>
            </c:when>
            <c:otherwise>
                <option value="${category.getId()}">${category.getName()}</option>
            </c:otherwise>
        </c:choose>
    </c:forEach>
</select>
                    <c:if test="${not empty categoryerror}">
    <span class="error">${categoryerror}</span>
</c:if>
                </div>
            </div>
        </div>
    </div>
    <div class="form-actions">
        <input type="submit" name="submit" class="btn btn-primary" value="Save">
        <a href="add_menu.html" class="btn btn-inverse">Cancel</a>
    </div>
</form:form>

                        </div>
                    </div>
                </div>
            </div>
            
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/admin/lib/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/admin/lib/bootstrap/js/popper.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/admin/lib/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/admin/jquery.slimscroll.js"></script>
    <script src="${pageContext.request.contextPath}/js/admin/sidebarmenu.js"></script>
    <script src="${pageContext.request.contextPath}/js/admin/lib/sticky-kit-master/dist/sticky-kit.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/admin/custom.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/common.js"></script>
</body>
</html>
