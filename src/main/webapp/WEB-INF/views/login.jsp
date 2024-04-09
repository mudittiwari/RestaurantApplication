<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css">
  </head>
  <body>

     <c:if test="${not empty message}">
         <div id="overlay" class="overlay" onclick="hidePopup()"></div>
    <div id="popup" class="popup">
        <h2>${message.getTitle()}</h2>
        <p>${message.getDesc()}</p>
        <button class="popupbutton" onclick="hidePopup()">Close</button>
    </div>
    </c:if>
    <div class="container">
      <div class="bg-setup">
        <img
          src="${pageContext.request.contextPath}/images/login/original-7d148df3d5adc14ce85768a605c2d245-removebg-preview 1.png"
          alt=""
        />
        <img src="${pageContext.request.contextPath}/images/login/Ellipse 44.png" alt="" />
        <img src="${pageContext.request.contextPath}/images/login/Ellipse 45.png" alt="" />
        <img src=".${pageContext.request.contextPath}/images/login/vawe (2).png" alt="" />
        <img src="${pageContext.request.contextPath}/images/login/vawe (3).png" alt="" />
        <img src="${pageContext.request.contextPath}/images/login/Oval Copy.png" alt="" />
        <div class="login-form">
          <h2>Log-in</h2>  
          <c:url value="/login" var="loginUrl"/> 
          <form class="form-container" action="${loginUrl}" method="post" >         
           <input type="text" placeholder="username" name="username" id="username" />  
            <svg width="25" height="24" viewBox="0 0 25 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                <mask id="mask0_205_180" style="mask-type:luminance" maskUnits="userSpaceOnUse" x="0" y="0" width="25" height="24">
                <path d="M24.645 0H0.835938V24H24.645V0Z" fill="white"/>
                </mask>
                <g mask="url(#mask0_205_180)">
                <path fill-rule="evenodd" clip-rule="evenodd" d="M9.08367 6.09314C9.08367 5.40605 9.28579 4.73438 9.66448 4.16309C10.0432 3.59179 10.5814 3.14652 11.2112 2.88358C11.8409 2.62064 12.5338 2.55184 13.2024 2.68589C13.8709 2.81993 14.485 3.1508 14.967 3.63665C15.4489 4.1225 15.7772 4.7415 15.9102 5.41539C16.0431 6.08928 15.9749 6.78779 15.714 7.42258C15.4532 8.05737 15.0115 8.59994 14.4447 8.98166C13.878 9.36339 13.2116 9.56714 12.53 9.56714C11.616 9.56714 10.7394 9.20113 10.0931 8.54963C9.44676 7.89813 9.08367 7.0145 9.08367 6.09314ZM12.53 1.01514C11.5338 1.01573 10.5601 1.31405 9.7321 1.87239C8.90406 2.43073 8.25884 3.22401 7.87802 4.15195C7.49719 5.07988 7.39785 6.10081 7.59257 7.08564C7.78728 8.07048 8.2673 8.97501 8.97194 9.68489C9.67657 10.3948 10.5742 10.8781 11.5513 11.0738C12.5284 11.2695 13.5412 11.1687 14.4615 10.7843C15.3818 10.3999 16.1684 9.74902 16.7218 8.91401C17.2752 8.079 17.5706 7.09734 17.5706 6.09314C17.5706 5.42603 17.4402 4.76547 17.1868 4.14918C16.9335 3.53289 16.5622 2.97296 16.0941 2.50139C15.626 2.02981 15.0703 1.65583 14.4587 1.40082C13.8472 1.1458 13.1918 1.01474 12.53 1.01514ZM9.13823 13.8441C7.57722 13.8441 6.08015 14.4692 4.97635 15.5819C3.87255 16.6945 3.25244 18.2036 3.25244 19.7771C3.25244 20.8971 3.69382 21.9713 4.47949 22.7633C5.26515 23.5552 6.33074 24.0001 7.44184 24.0001H9.87929C10.0898 24.0001 10.2916 23.9159 10.4405 23.7658C10.5893 23.6158 10.6729 23.4123 10.6729 23.2001C10.6729 22.988 10.5893 22.7845 10.4405 22.6345C10.2916 22.4844 10.0898 22.4001 9.87929 22.4001H7.43985C6.75078 22.4001 6.08993 22.1242 5.60268 21.6331C5.11543 21.1419 4.84169 20.4757 4.84169 19.7811C4.84169 18.6327 5.29426 17.5314 6.09983 16.7194C6.9054 15.9073 7.99799 15.4511 9.13724 15.4511H15.9248C17.064 15.4511 18.1566 15.9073 18.9622 16.7194C19.7678 17.5314 20.2203 18.6327 20.2203 19.7811C20.2203 20.4757 19.9466 21.1419 19.4594 21.6331C18.9721 22.1242 18.3113 22.4001 17.6222 22.4001H15.1818C14.9713 22.4001 14.7694 22.4844 14.6206 22.6345C14.4717 22.7845 14.3881 22.988 14.3881 23.2001C14.3881 23.4123 14.4717 23.6158 14.6206 23.7658C14.7694 23.9159 14.9713 24.0001 15.1818 24.0001H17.6212C18.7323 24.0001 19.7979 23.5552 20.5835 22.7633C21.3692 21.9713 21.8106 20.8971 21.8106 19.7771C21.8106 18.2036 21.1905 16.6945 20.0867 15.5819C18.9829 14.4692 17.4858 13.8441 15.9248 13.8441H9.13823Z" fill="#F2F2F2"/>
                </g>
                </svg>
                
            <input type="password" id="password" name="password" placeholder="Password" /> 
            <svg width="22" height="23" viewBox="0 0 22 23" fill="none" xmlns="http://www.w3.org/2000/svg">
                <g clip-path="url(#clip0_205_174)">
                <mask id="mask0_205_174" style="mask-type:luminance" maskUnits="userSpaceOnUse" x="0" y="0" width="22" height="23">
                <path d="M22 0H0V23H22V0Z" fill="white"/>
                </mask>
                <g mask="url(#mask0_205_174)">
                <path fill-rule="evenodd" clip-rule="evenodd" d="M10.9801 -1.41859e-05H11.4459C12.2618 -1.41859e-05 12.9199 -1.41114e-05 13.4546 0.0449859C13.9657 0.0697439 14.467 0.200263 14.9295 0.428986C15.6383 0.806052 16.2146 1.4082 16.5757 2.14899C16.7942 2.63259 16.9187 3.15671 16.9421 3.69099C16.9851 4.24799 16.9851 4.93599 16.9851 5.79099V6.40899C17.4756 6.46764 17.953 6.61304 18.3969 6.83899C19.2938 7.31719 20.0227 8.07997 20.4793 9.01799C20.757 9.63254 20.9144 10.2989 20.9422 10.978C20.9996 11.709 20.9996 12.618 20.9996 13.763V15.091C20.9996 16.237 20.9996 17.145 20.9422 17.876C20.9139 18.5552 20.7568 19.2217 20.4802 19.837C20.0231 20.7744 19.2938 21.5365 18.3969 22.014C17.8087 22.304 17.171 22.4685 16.5212 22.498C15.822 22.558 14.9525 22.558 13.8573 22.558H8.57059C7.47442 22.558 6.60589 22.558 5.90668 22.498C5.25731 22.4685 4.62003 22.3043 4.03189 22.015C3.13473 21.537 2.40542 20.7742 1.94859 19.836C1.67153 19.2209 1.51447 18.5542 1.48659 17.875C1.4292 17.144 1.4292 16.235 1.4292 15.09V13.762C1.4292 12.616 1.4292 11.708 1.48659 10.977C1.51483 10.2981 1.67187 9.63186 1.94859 9.01699C2.40542 8.07882 3.13473 7.31601 4.03189 6.83799C4.47535 6.61157 4.95247 6.46581 5.44276 6.40699V5.78899C5.44276 4.93599 5.44276 4.24799 5.48581 3.68899C5.50949 3.15465 5.63433 2.63053 5.85311 2.14699C6.21378 1.40598 6.78975 0.803483 7.49833 0.425986C7.96091 0.197584 8.46224 0.0674036 8.97329 0.0429858C9.50607 -0.0020142 10.1642 -0.00201416 10.982 -0.00201416L10.9801 -1.41859e-05ZM15.4757 5.82299V6.30599C14.9975 6.29599 14.4599 6.29599 13.8496 6.29599H8.57059C7.9632 6.29599 7.42276 6.29599 6.9445 6.30599V5.82299C6.9445 4.92899 6.9445 4.30499 6.98276 3.82299C6.99133 3.49317 7.06185 3.16834 7.19033 2.86699C7.40746 2.42038 7.75484 2.05755 8.18224 1.83099C8.4708 1.69657 8.78184 1.62283 9.09763 1.61399C9.56155 1.57499 10.1575 1.57399 11.0107 1.57399H11.4124C12.2685 1.57399 12.8644 1.57399 13.3255 1.61399C13.6412 1.62312 13.9522 1.69684 14.2409 1.83099C14.6672 2.05679 15.0142 2.4181 15.2318 2.86299C15.3604 3.16466 15.4309 3.48984 15.4394 3.81999C15.4767 4.30499 15.4776 4.92899 15.4776 5.82299H15.4757ZM6.02624 7.92299C5.57245 7.93704 5.1258 8.04478 4.71198 8.23999C4.09836 8.56689 3.59946 9.08847 3.28676 9.72999C3.10043 10.1627 2.99739 10.6296 2.98355 11.104C2.93189 11.765 2.93094 12.604 2.93094 13.796V15.056C2.93094 16.245 2.93094 17.088 2.98355 17.748C2.99699 18.2224 3.10004 18.6894 3.28676 19.122C3.59946 19.7635 4.09836 20.2851 4.71198 20.612C5.12593 20.8068 5.5725 20.9145 6.02624 20.929C6.6585 20.983 7.46102 20.984 8.6012 20.984H13.8257C14.963 20.984 15.7694 20.984 16.4007 20.929C16.8545 20.9149 17.3011 20.8072 17.7149 20.612C18.3286 20.2851 18.8275 19.7635 19.1402 19.122C19.3265 18.6892 19.4295 18.2224 19.4434 17.748C19.495 17.087 19.496 16.248 19.496 15.056V13.796C19.496 12.607 19.496 11.764 19.4434 11.104C19.4299 10.6296 19.3269 10.1626 19.1402 9.72999C18.8275 9.08847 18.3286 8.56689 17.7149 8.23999C17.301 8.04518 16.8544 7.93746 16.4007 7.92299C15.7684 7.86899 14.9659 7.86799 13.8257 7.86799H8.60407C7.46772 7.86899 6.66042 7.86899 6.02911 7.92299H6.02624ZM11.9634 13.376C11.9634 13.1673 11.8841 12.9671 11.7429 12.8195C11.6017 12.6719 11.4102 12.589 11.2106 12.589C11.0109 12.589 10.8195 12.6719 10.6783 12.8195C10.5371 12.9671 10.4578 13.1673 10.4578 13.376V15.476C10.4578 15.5793 10.4773 15.6817 10.5151 15.7772C10.5529 15.8726 10.6084 15.9594 10.6783 16.0325C10.7482 16.1056 10.8312 16.1635 10.9225 16.2031C11.0138 16.2426 11.1117 16.263 11.2106 16.263C11.3094 16.263 11.4073 16.2426 11.4987 16.2031C11.59 16.1635 11.673 16.1056 11.7429 16.0325C11.8128 15.9594 11.8682 15.8726 11.9061 15.7772C11.9439 15.6817 11.9634 15.5793 11.9634 15.476V13.376Z" fill="#F2F2F2"/>
                </g>
                </g>
                <defs>
                <clipPath id="clip0_205_174">
                <rect width="22" height="23" fill="white"/>
                </clipPath>
                </defs>
                </svg>
                
            <label class="toggle">
              <input type="checkbox" id="remember-me" />
              <span class="slider"></span>
              <label for="remember-me">Remember&nbspMe</label>
            </label>
            <input value="Login" type="submit" />
            <span class="social-login">
               <a href=""><svg width="41" height="41" viewBox="0 0 41 41" fill="none" xmlns="http://www.w3.org/2000/svg">
                <g clip-path="url(#clip0_205_191)">
                <path d="M3.44058 13.6027V18.2972H0V24.0372H3.44058V41.0966H10.5028V24.0389H15.2435C15.2435 24.0389 15.6876 21.2868 15.9029 18.2767H10.5319V14.351C10.5319 13.765 11.3006 12.9757 12.0625 12.9757H15.9131V7H10.6788C3.26462 7 3.44058 12.7451 3.44058 13.6027Z" fill="white"/>
                </g>
                <defs>
                <clipPath id="clip0_205_191">
                <rect width="41" height="41" fill="white"/>
                </clipPath>
                </defs>
                </svg>
                </a>
               <a href=""><svg width="31" height="30" viewBox="0 0 31 30" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M29.14 15.3125C29.14 14.3375 29.0496 13.4 28.8817 12.5H15.5V17.825H23.1467C22.8108 19.5375 21.8033 20.9875 20.2921 21.9625V25.425H24.9033C27.59 23.025 29.14 19.5 29.14 15.3125Z" fill="white"/>
                <path d="M15.5001 28.75C19.3363 28.75 22.5526 27.525 24.9034 25.425L20.2922 21.9625C19.0263 22.7875 17.4118 23.2875 15.5001 23.2875C11.8059 23.2875 8.66717 20.875 7.54342 17.625H2.81592V21.175C5.15383 25.6625 9.94592 28.75 15.5001 28.75Z" fill="white"/>
                <path d="M7.54317 17.6125C7.259 16.7875 7.09109 15.9125 7.09109 15C7.09109 14.0875 7.259 13.2125 7.54317 12.3875V8.83752H2.81567C1.84692 10.6875 1.2915 12.775 1.2915 15C1.2915 17.225 1.84692 19.3125 2.81567 21.1625L6.49692 18.3875L7.54317 17.6125Z" fill="white"/>
                <path d="M15.5001 6.725C17.5926 6.725 19.4526 7.425 20.938 8.775L25.0068 4.8375C22.5397 2.6125 19.3363 1.25 15.5001 1.25C9.94592 1.25 5.15383 4.3375 2.81592 8.8375L7.54342 12.3875C8.66717 9.1375 11.8059 6.725 15.5001 6.725Z" fill="white"/>
                </svg>
                </a>
               <a href=""><svg width="25" height="30" viewBox="0 0 25 30" fill="none" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                <rect width="25" height="30" fill="url(#pattern0)"/>
                <defs>
                <pattern id="pattern0" patternContentUnits="objectBoundingBox" width="1" height="1">
                <use xlink:href="#image0_205_194" transform="matrix(0.00254777 0 0 0.00212314 -0.000636943 0)"/>
                </pattern>
                <image id="image0_205_194" width="393" height="471" xlink:href="data:image/png;base64,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"/>
                </defs>
                </svg>
                </a>
            </span>
            <input type="hidden"                          
        name="${_csrf.parameterName}"  
        value="${_csrf.token}"/>
          </form>
        </div>
      </div>
    </div>
    <script src="${pageContext.request.contextPath}/js/common.js"></script>
  </body>
</html>