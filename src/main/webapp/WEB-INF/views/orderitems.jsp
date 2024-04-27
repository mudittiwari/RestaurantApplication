<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Details</title>
<link
      href="${pageContext.request.contextPath}/css/admin/lib/bootstrap/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      href="${pageContext.request.contextPath}/css/admin/helper.css"
      rel="stylesheet"
    />
    <link
      href="${pageContext.request.contextPath}/css/admin/style.css"
      rel="stylesheet"
    />
    <link
      href="${pageContext.request.contextPath}/css/common.css"
      rel="stylesheet"
    />
</head>
<body>
    <h1 class="w-full text-center m-t-40 ">Order Details</h1>
    <div class="table-responsive m-t-40" style="padding: 20px;">
        <table
          id="itemstable"
          class="display nowrap table table-hover table-striped table-bordered"
          cellspacing="0"
          width="100%"
        >
          <thead class="thead-dark">
            <tr>
              <th>Item ID</th>
              <th>Item Category</th>
              <th>Item Name</th>
              <th>Item Price</th>
            </tr>
          </thead>
        <tbody>
            <c:forEach items="${orderItems}" var="item">
                <tr>
                    <td>${item.getId()}</td>
                    <td>${item.getCategory().getName()}</td>
                    <td>${item.getName()}</td>
                    <td>${item.getDiscountedPrice()}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    </div>
</body>
</html>
