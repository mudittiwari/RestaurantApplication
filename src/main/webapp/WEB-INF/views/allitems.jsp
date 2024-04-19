<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> <%@
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ page
language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<c:set var="totalProducts" value="0" />
<c:forEach var="quantity" items="${cart.values()}">
  <c:set var="totalProducts" value="${totalProducts + quantity}" />
</c:forEach>
<c:set var="totalPrice" value="0" />
<c:forEach var="entry" items="${cart}">
    <c:set var="item" value="${entry.key}" />
    <c:set var="quantity" value="${entry.value}" />
    <c:set var="subtotal" value="${item.price * quantity}" />
    <c:set var="totalPrice" value="${totalPrice + subtotal}" />
</c:forEach>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Food Order Website</title>
   
    <link
      href="https://cdn.jsdelivr.net/npm/tailwindcss/dist/tailwind.min.css"
      rel="stylesheet"
    />
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"
    />

    <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
    <style>
      @import url("https://fonts.googleapis.com/css2?family=Poppins:wght@700&display=swap");
    </style>
    <link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet">
    <link
      rel="stylesheet"
      type="text/css"
      href="${pageContext.request.contextPath}/css/style.css"
    />
    <style>
      body {
          background-image: url("${pageContext.request.contextPath}/images/resources/bg-image.png");
          background-size: 105% 105%;
          background-repeat: no-repeat;
          background-attachment: fixed;
          background-position: center;
      }
  </style>
  </head>

  <body class="bg-gray-100 rounded-3xl p-1 bg-Image">

    <c:if test="${not empty message}">
      <div id="overlay" class="overlay" onclick="hidePopup()"></div>
      <div id="popup" class="popup">
          <h2>${message.getTitle()}</h2>
          <p>${message.getDesc()}</p>
          <button class="popupbutton" onclick="hidePopup()">Close</button>
      </div>
  </c:if>

    <div class="flex w-full justify-start">
      <!-- Left Navbar -->
      <div class="flex justify-start left-0" id="leftnavbar">
        <div
          x-data="setup()"
          x-init="$refs.loading.classList.add('hidden');"
          @resize.window="watchScreen()"
        >
          <div
            class="flex h-screen bg-Transparent antialiased text-gray-900 bg-gray-100 dark:bg-dark dark:text-light"
          >
            <!-- Loading screen -->
            <div
              x-ref="loading"
              class="fixed inset-0 z-50 flex items-center justify-center text-2xl font-semibold text-white bg-yellow-400"
            >
              Loading.....
            </div>
            <!-- Sidebar -->
            <div class="flex flex-shrink-0 transition-all">
              <div
                x-show="isSidebarOpen"
                @click="isSidebarOpen = false"
                class="fixed inset-0 z-10 lg:hidden"
              ></div>
              <!-- Mobile bottom bar -->
              <nav
                aria-label="Options"
                class="fixed inset-x-0 left-0 top-0 flex flex-row items-start justify-between px-4 py-2 sm:hidden shadow-t rounded-t-3xl"
              >
                <!-- Menu button -->
                <button
                  @click="(isSidebarOpen && currentSidebarTab == 'linksTab') ? isSidebarOpen = false : isSidebarOpen = true; currentSidebarTab = 'linksTab'"
                  class="p-2 transition-colors rounded-lg shadow-md hover:bg-yellow-400 hover:text-white focus:outline-none focus:ring focus:ring-yellow-300 focus:ring-offset-white focus:ring-offset-2"
                  :class="(isSidebarOpen && currentSidebarTab == 'linksTab') ? 'text-white bg-yellow-300' : 'text-gray-500 bg-white'"
                >
                  <svg
                    aria-hidden="true"
                    class="w-6 h-6"
                    xmlns="http://www.w3.org/2000/svg"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M4 6h16M4 12h16M4 18h7"
                    />
                  </svg>
                </button>
              </nav>
              <!-- Left mini bar -->
              <nav
                aria-label="Options"
                class="h-20 z-20 flex-col items-center flex-shrink-0 hidden w-16 sm:flex rounded-tr-3xl rounded-br-3xl"
              >
                <!-- Logo -->
                <div class="flex-shrink-0"></div>
                <div
                  class="flex flex-col items-center flex-1 p-2 space-y-4 top-0 fixed"
                >
                  <!-- Menu button -->
                  <button
                    @click="(isSidebarOpen && currentSidebarTab == 'linksTab') ? isSidebarOpen = false : isSidebarOpen = true; currentSidebarTab = 'linksTab'"
                    class="p-2 transition-colors rounded-lg shadow-md hover:bg-yellow-400 hover:text-white focus:outline-none focus:ring focus:ring-yellow-300 focus:ring-offset-white focus:ring-offset-2"
                    :class="(isSidebarOpen && currentSidebarTab == 'linksTab') ? 'text-white bg-yellow-300' : 'text-gray-500 bg-white'"
                  >
                    <span class="sr-only">Toggle sidebar</span>
                    <svg
                      aria-hidden="true"
                      class="w-6 h-6"
                      xmlns="http://www.w3.org/2000/svg"
                      fill="none"
                      viewBox="0 0 24 24"
                      stroke="currentColor"
                    >
                      <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M4 6h16M4 12h16M4 18h7"
                      />
                    </svg>
                  </button>
                </div>
              </nav>
              <div
                id="rightnavbar"
                x-transition:enter="transform transition-transform duration-300"
                x-transition:enter-start="-translate-x-full"
                x-transition:enter-end="translate-x-0"
                x-transition:leave="transform transition-transform duration-300"
                x-transition:leave-start="translate-x-0"
                x-transition:leave-end="-translate-x-full"
                x-show="isSidebarOpen"
                class="fixed inset-y-0 left-0 z-10 flex-shrink-0 w-64 bg-white border-r-2 border-yellow-100 shadow-lg sm:left-16 rounded-tr-3xl rounded-br-3xl sm:w-72 lg:static lg:w-64"
              >
                <nav
                  x-show="currentSidebarTab == 'linksTab'"
                  aria-label="Main"
                  class="flex flex-col h-full"
                >
                  <!-- Links -->
                  <div
                    class="flex-1 px-4 space-y-2 overflow-hidden hover:overflow-auto"
                  >
                    <div>
                      <div
                        class="flex flex-col items-start h-screen bg-white rounded-l-2xl w-2/5"
                      >
                        <img
                          src="${pageContext.request.contextPath}/images/resources/logo-dona.png"
                          class="w-28 h-20 m-12"
                        />
                        <div class="flex">
                          <div class="w-72 pr-20">
                            <ul class="pb-8 flex flex-col gap-8">
                              <li
                                class="py-3 pl-8 gap-4 bg-yellow-400 text-white rounded-2xl flex items-center text-white active"
                              >
                                <svg
                                  width="26"
                                  height="29"
                                  viewBox="0 0 26 29"
                                  fill="none"
                                  xmlns="http://www.w3.org/2000/svg"
                                >
                                  <path
                                    d="M0.333374 24.8334C0.333374 27.6967 6.81337 29 12.8334 29C18.8534 29 25.3334 27.6967 25.3334 24.8334C25.3334 22.56 21.3984 21.5334 18.5634 21.09L20.5 19.1667C22.0152 17.6517 23.0471 15.7214 23.4651 13.6199C23.8832 11.5184 23.6687 9.34012 22.8488 7.36054C22.0289 5.38095 20.6404 3.68896 18.8588 2.49854C17.0773 1.30812 14.9827 0.672729 12.84 0.672729C10.6974 0.672729 8.60282 1.30812 6.82127 2.49854C5.03972 3.68896 3.65118 5.38095 2.83126 7.36054C2.01134 9.34012 1.79685 11.5184 2.21493 13.6199C2.63301 15.7214 3.66488 17.6517 5.18004 19.1667L7.11004 21.0967C4.26837 21.5334 0.333374 22.56 0.333374 24.8334ZM14.5 7.33338C14.5 7.17862 14.5431 7.02691 14.6245 6.89527C14.7059 6.76362 14.8223 6.65723 14.9607 6.58802C15.0991 6.51881 15.2541 6.48951 15.4082 6.50341C15.5623 6.51731 15.7096 6.57385 15.8334 6.66671C16.8653 7.44094 17.7222 8.42427 18.348 9.55239C18.9738 10.6805 19.3545 11.928 19.465 13.2134C19.5016 13.6082 19.3952 14.0031 19.1652 14.3261C18.9352 14.6491 18.5968 14.8788 18.2117 14.9734L16.1667 15.485V17.3334C16.1667 17.5544 16.0789 17.7664 15.9226 17.9226C15.7663 18.0789 15.5544 18.1667 15.3334 18.1667C15.1124 18.1667 14.9004 18.0789 14.7441 17.9226C14.5878 17.7664 14.5 17.5544 14.5 17.3334V7.33338ZM7.00004 9.00004V7.33338C7.00004 7.11236 7.08784 6.9004 7.24412 6.74412C7.4004 6.58784 7.61236 6.50004 7.83337 6.50004C8.05439 6.50004 8.26635 6.58784 8.42263 6.74412C8.57891 6.9004 8.66671 7.11236 8.66671 7.33338V9.00004C8.67002 9.28745 8.74874 9.56895 8.89498 9.81639C9.04122 10.0638 9.24986 10.2685 9.50004 10.41V7.33338C9.50004 7.11236 9.58784 6.9004 9.74412 6.74412C9.9004 6.58784 10.1124 6.50004 10.3334 6.50004C10.5544 6.50004 10.7663 6.58784 10.9226 6.74412C11.0789 6.9004 11.1667 7.11236 11.1667 7.33338V10.41C11.4169 10.2685 11.6255 10.0638 11.7718 9.81639C11.918 9.56895 11.9967 9.28745 12 9.00004V7.33338C12 7.11236 12.0878 6.9004 12.2441 6.74412C12.4004 6.58784 12.6124 6.50004 12.8334 6.50004C13.0544 6.50004 13.2663 6.58784 13.4226 6.74412C13.5789 6.9004 13.6667 7.11236 13.6667 7.33338V9.00004C13.6639 9.73689 13.4171 10.4521 12.9648 11.0337C12.5125 11.6154 11.8802 12.0308 11.1667 12.215V17.3334C11.1667 17.5544 11.0789 17.7664 10.9226 17.9226C10.7663 18.0789 10.5544 18.1667 10.3334 18.1667C10.1124 18.1667 9.9004 18.0789 9.74412 17.9226C9.58784 17.7664 9.50004 17.5544 9.50004 17.3334V12.215C8.78659 12.0308 8.15428 11.6154 7.70196 11.0337C7.24964 10.4521 7.0028 9.73689 7.00004 9.00004ZM8.59004 22.5767L11.065 25.0534C11.2972 25.2857 11.5729 25.47 11.8763 25.5957C12.1797 25.7215 12.5049 25.7862 12.8334 25.7862C13.1618 25.7862 13.487 25.7215 13.7905 25.5957C14.0939 25.47 14.3695 25.2857 14.6017 25.0534L17.0767 22.5767C21.6567 23.1067 23.6667 24.3134 23.6667 24.8334C23.6667 25.58 19.9817 27.3334 12.8334 27.3334C5.68504 27.3334 2.00004 25.58 2.00004 24.8334C2.00004 24.3134 4.01004 23.1067 8.59004 22.5767Z"
                                    fill="white"
                                  />
                                </svg>
                                <a
                                  href="${pageContext.request.contextPath}/dashboard"
                                  >Dashboard</a
                                >
                              </li>
                              <li
                                class="py-2 pl-8 gap-4 bg-white rounded-2xl flex items-center text-black hover:bg-yellow-400 hover:text-white"
                              >
                                <svg
                                  width="40"
                                  height="40"
                                  viewBox="0 0 40 40"
                                  fill="none"
                                  xmlns="http://www.w3.org/2000/svg"
                                >
                                  <path
                                    d="M6.66663 29.1666C6.66663 29.8297 6.93002 30.4656 7.39886 30.9344C7.8677 31.4032 8.50358 31.6666 9.16663 31.6666H10.085C10.2762 32.6085 10.7872 33.4554 11.5314 34.0636C12.2756 34.6719 13.2072 35.0041 14.1683 35.0041C15.1294 35.0041 16.061 34.6719 16.8052 34.0636C17.5494 33.4554 18.0604 32.6085 18.2516 31.6666H23.5C24.6308 31.6587 25.7348 31.321 26.6766 30.695C26.6766 30.7416 26.6633 30.7866 26.6633 30.8333C26.6627 31.7299 26.9513 32.6027 27.4863 33.3222C28.0213 34.0417 28.7741 34.5694 29.6329 34.827C30.4917 35.0846 31.4107 35.0583 32.2533 34.752C33.096 34.4457 33.8174 33.8758 34.3103 33.1269C34.8033 32.378 35.0415 31.4901 34.9896 30.595C34.9378 29.6999 34.5986 28.8454 34.0224 28.1584C33.4463 27.4715 32.6639 26.9887 31.7915 26.7818C30.9191 26.5749 30.0033 26.6549 29.18 27.01C29.3206 26.3869 29.3566 25.7448 29.2866 25.11L28.6416 19.9433C28.8141 19.981 28.9901 20 29.1666 20H30C30.442 20 30.8659 19.8244 31.1785 19.5118C31.491 19.1992 31.6666 18.7753 31.6666 18.3333V16.6666C31.6666 16.2246 31.491 15.8007 31.1785 15.4881C30.8659 15.1756 30.442 15 30 15H29.1666C28.7805 15.0018 28.4 15.093 28.055 15.2665C27.7101 15.44 27.41 15.691 27.1783 16L26.91 15.7316C26.4402 15.265 25.8055 15.0021 25.1433 15H24.1666C23.9456 15 23.7337 15.0878 23.5774 15.244C23.4211 15.4003 23.3333 15.6123 23.3333 15.8333C23.3333 16.0543 23.4211 16.2663 23.5774 16.4225C23.7337 16.5788 23.9456 16.6666 24.1666 16.6666H25.1433C25.3639 16.6667 25.5754 16.7542 25.7316 16.91L26.705 17.8833C26.73 18.0383 27.3283 22.8466 27.6366 25.3166C27.7099 25.903 27.6576 26.4983 27.4832 27.063C27.3088 27.6276 27.0162 28.1487 26.625 28.5917C26.2338 29.0346 25.7528 29.3892 25.214 29.632C24.6752 29.8749 24.0909 30.0003 23.5 30H23.1833L21.6666 22.4183V20.8333C21.6666 20.1703 21.4032 19.5344 20.9344 19.0655C20.4656 18.5967 19.8297 18.3333 19.1666 18.3333H15.8333V14.1666C15.8333 13.5036 15.5699 12.8677 15.1011 12.3989C14.6322 11.93 13.9963 11.6666 13.3333 11.6666H9.16663C8.50358 11.6666 7.8677 11.93 7.39886 12.3989C6.93002 12.8677 6.66663 13.5036 6.66663 14.1666V20.8333C6.66663 21.4963 6.93002 22.1322 7.39886 22.6011C7.8677 23.0699 8.50358 23.3333 9.16663 23.3333H9.50996C8.62729 24.0287 7.91312 24.9145 7.42077 25.9246C6.92843 26.9347 6.67063 28.0429 6.66663 29.1666ZM30.8333 28.3333C31.3277 28.3333 31.8111 28.4799 32.2222 28.7546C32.6333 29.0293 32.9538 29.4198 33.143 29.8766C33.3322 30.3334 33.3817 30.8361 33.2853 31.321C33.1888 31.806 32.9507 32.2514 32.6011 32.6011C32.2514 32.9507 31.806 33.1888 31.321 33.2853C30.8361 33.3817 30.3334 33.3322 29.8766 33.143C29.4198 32.9538 29.0293 32.6333 28.7546 32.2222C28.4799 31.8111 28.3333 31.3277 28.3333 30.8333C28.3333 30.1703 28.5967 29.5344 29.0655 29.0655C29.5344 28.5967 30.1702 28.3333 30.8333 28.3333ZM15.8333 20H19.1666C19.3876 20 19.5996 20.0878 19.7559 20.244C19.9122 20.4003 20 20.6123 20 20.8333V21.6666H15.8333V20ZM16.5133 31.6666C16.3436 32.1537 16.0265 32.576 15.606 32.8748C15.1855 33.1736 14.6825 33.3341 14.1666 33.3341C13.6508 33.3341 13.1477 33.1736 12.7272 32.8748C12.3068 32.576 11.9897 32.1537 11.82 31.6666H16.5133ZM8.33329 14.1666C8.33329 13.9456 8.42109 13.7337 8.57737 13.5774C8.73365 13.4211 8.94561 13.3333 9.16663 13.3333H13.3333C13.5543 13.3333 13.7663 13.4211 13.9225 13.5774C14.0788 13.7337 14.1666 13.9456 14.1666 14.1666V15H8.33329V14.1666ZM8.33329 16.6666H14.1666V18.3083H8.33329V16.6666ZM9.16663 21.6666C8.94561 21.6666 8.73365 21.5788 8.57737 21.4225C8.42109 21.2663 8.33329 21.0543 8.33329 20.8333V19.975H14.1666V21.6666H9.16663Z"
                                    fill="#A098AE"
                                  />
                                </svg>
                                <a
                                  href="${pageContext.request.contextPath}/items"
                                  >Food Order</a
                                >
                              </li>
                              <li
                                class="py-2 pl-8 gap-4 bg-white rounded-2xl flex items-center text-black hover:bg-yellow-400 hover:text-white"
                              >
                                <svg
                                  width="40"
                                  height="40"
                                  viewBox="0 0 40 40"
                                  fill="none"
                                  xmlns="http://www.w3.org/2000/svg"
                                >
                                  <path
                                    d="M30.8333 10H10.8333C9.72822 10 8.66842 10.439 7.88701 11.2204C7.10561 12.0018 6.66663 13.0616 6.66663 14.1667V27.5C6.66663 28.6051 7.10561 29.6649 7.88701 30.4463C8.66842 31.2277 9.72822 31.6667 10.8333 31.6667H13.3333V33.3883C13.3333 33.6146 13.3947 33.8366 13.511 34.0306C13.6273 34.2247 13.794 34.3836 13.9935 34.4903C14.193 34.5971 14.4177 34.6477 14.6436 34.6368C14.8696 34.6259 15.0884 34.5538 15.2766 34.4283L19.4183 31.6667H30.8333C31.9384 31.6667 32.9982 31.2277 33.7796 30.4463C34.561 29.6649 35 28.6051 35 27.5V14.1667C35 13.0616 34.561 12.0018 33.7796 11.2204C32.9982 10.439 31.9384 10 30.8333 10ZM21.8333 20.5467L20.3116 22.2717L20.5266 24.565C20.5467 24.7804 20.5107 24.9972 20.422 25.1945C20.3333 25.3918 20.195 25.5627 20.0206 25.6906C19.8462 25.8185 19.6416 25.8991 19.4268 25.9244C19.212 25.9497 18.9943 25.9189 18.795 25.835L16.6666 24.915L14.5533 25.8333C14.3543 25.919 14.1365 25.9515 13.9211 25.9278C13.7058 25.904 13.5003 25.8247 13.3248 25.6978C13.1492 25.5708 13.0097 25.4004 12.9197 25.2033C12.8298 25.0062 12.7925 24.7891 12.8116 24.5733L13.0283 22.275L11.5 20.5467C11.3568 20.3834 11.2585 20.1858 11.2148 19.9731C11.1711 19.7604 11.1835 19.54 11.2508 19.3336C11.318 19.1271 11.4378 18.9417 11.5984 18.7956C11.759 18.6494 11.9548 18.5476 12.1666 18.5L14.415 18L15.5816 16.0167C15.7018 15.8427 15.8624 15.7005 16.0497 15.6023C16.2369 15.5041 16.4452 15.4528 16.6566 15.4528C16.8681 15.4528 17.0763 15.5041 17.2636 15.6023C17.4508 15.7005 17.6114 15.8427 17.7316 16.0167L18.8983 18.0033L21.145 18.5033C21.3577 18.5487 21.555 18.6487 21.7174 18.7935C21.8798 18.9383 22.0017 19.1228 22.0711 19.3289C22.1406 19.5351 22.1552 19.7558 22.1135 19.9693C22.0718 20.1828 21.9752 20.3818 21.8333 20.5467ZM27.5 25H24.1666C23.9456 25 23.7336 24.9122 23.5774 24.7559C23.4211 24.5996 23.3333 24.3877 23.3333 24.1667C23.3333 23.9457 23.4211 23.7337 23.5774 23.5774C23.7336 23.4211 23.9456 23.3333 24.1666 23.3333H27.5C27.721 23.3333 27.9329 23.4211 28.0892 23.5774C28.2455 23.7337 28.3333 23.9457 28.3333 24.1667C28.3333 24.3877 28.2455 24.5996 28.0892 24.7559C27.9329 24.9122 27.721 25 27.5 25ZM30 21.6667H24.1666C23.9456 21.6667 23.7336 21.5789 23.5774 21.4226C23.4211 21.2663 23.3333 21.0543 23.3333 20.8333C23.3333 20.6123 23.4211 20.4004 23.5774 20.2441C23.7336 20.0878 23.9456 20 24.1666 20H30C30.221 20 30.4329 20.0878 30.5892 20.2441C30.7455 20.4004 30.8333 20.6123 30.8333 20.8333C30.8333 21.0543 30.7455 21.2663 30.5892 21.4226C30.4329 21.5789 30.221 21.6667 30 21.6667ZM30 18.3333H24.1666C23.9456 18.3333 23.7336 18.2455 23.5774 18.0893C23.4211 17.933 23.3333 17.721 23.3333 17.5C23.3333 17.279 23.4211 17.067 23.5774 16.9107C23.7336 16.7545 23.9456 16.6667 24.1666 16.6667H30C30.221 16.6667 30.4329 16.7545 30.5892 16.9107C30.7455 17.067 30.8333 17.279 30.8333 17.5C30.8333 17.721 30.7455 17.933 30.5892 18.0893C30.4329 18.2455 30.221 18.3333 30 18.3333Z"
                                    fill="#A098AE"
                                  />
                                </svg>
                                <a
                                  href="${pageContext.request.contextPath}/favourite"
                                  >Favourite</a
                                >
                              </li>
                              <li
                                class="py-2 pl-8 gap-4 bg-white rounded-2xl flex items-center text-black hover:bg-yellow-400 hover:text-white"
                              >
                                <svg
                                  width="40"
                                  height="40"
                                  viewBox="0 0 40 40"
                                  fill="none"
                                  xmlns="http://www.w3.org/2000/svg"
                                >
                                  <path
                                    d="M20 10.8333V20.4883L13.5767 26.91C13.4202 27.0665 13.3323 27.2787 13.3323 27.5C13.3323 27.7213 13.4202 27.9335 13.5767 28.09C13.7331 28.2465 13.9454 28.3344 14.1667 28.3344C14.388 28.3344 14.6002 28.2465 14.7567 28.09L21.4233 21.4233C21.5007 21.3458 21.562 21.2538 21.6037 21.1526C21.6455 21.0513 21.6669 20.9428 21.6667 20.8333V10.8333C21.6667 10.6123 21.5789 10.4004 21.4226 10.2441C21.2663 10.0878 21.0543 10 20.8333 10C20.6123 10 20.4004 10.0878 20.2441 10.2441C20.0878 10.4004 20 10.6123 20 10.8333ZM34.1667 26.6667H24.1667C23.9456 26.6667 23.7337 26.7545 23.5774 26.9107C23.4211 27.067 23.3333 27.279 23.3333 27.5C23.3333 27.721 23.4211 27.933 23.5774 28.0893C23.7337 28.2455 23.9456 28.3333 24.1667 28.3333H34.1667C34.3877 28.3333 34.5996 28.2455 34.7559 28.0893C34.9122 27.933 35 27.721 35 27.5C35 27.279 34.9122 27.067 34.7559 26.9107C34.5996 26.7545 34.3877 26.6667 34.1667 26.6667Z"
                                    fill="#A098AE"
                                  />
                                  <path
                                    d="M32.5 10C32.279 10 32.067 10.0878 31.9108 10.2441C31.7545 10.4004 31.6667 10.6123 31.6667 10.8333V11.7467C30.3476 10.1531 28.6922 8.87122 26.8192 7.99294C24.9462 7.11465 22.902 6.66173 20.8334 6.66667C18.5036 6.66672 16.2098 7.24134 14.1552 8.33963C12.1006 9.43792 10.3485 11.026 9.05425 12.9631C7.75997 14.9003 6.96342 17.1268 6.73516 19.4453C6.50689 21.7638 6.85396 24.1029 7.74561 26.2553C8.63727 28.4076 10.046 30.3069 11.847 31.7848C13.648 33.2627 15.7857 34.2736 18.0707 34.728C20.3557 35.1823 22.7175 35.0662 24.9469 34.3897C27.1763 33.7133 29.2044 32.4975 30.8517 30.85C31.0086 30.6929 31.0967 30.4798 31.0965 30.2577C31.0964 30.0357 31.008 29.8228 30.8509 29.6658C30.6937 29.5089 30.4807 29.4208 30.2586 29.421C30.0365 29.4212 29.8236 29.5095 29.6667 29.6667C27.8666 31.4703 25.5583 32.6807 23.0511 33.1357C20.5438 33.5907 17.9574 33.2685 15.6384 32.2124C13.3193 31.1563 11.3785 29.4166 10.0758 27.2265C8.77319 25.0364 8.17102 22.5006 8.34999 19.9586C8.52896 17.4167 9.48053 14.9902 11.0772 13.0043C12.6738 11.0183 14.8393 9.56779 17.2835 8.84703C19.7276 8.12627 22.3337 8.16971 24.7524 8.97153C27.1712 9.77336 29.2871 11.2953 30.8167 13.3333H29.1667C28.9457 13.3333 28.7337 13.4211 28.5774 13.5774C28.4212 13.7337 28.3334 13.9457 28.3334 14.1667C28.3334 14.3877 28.4212 14.5996 28.5774 14.7559C28.7337 14.9122 28.9457 15 29.1667 15H32.5C32.721 15 32.933 14.9122 33.0893 14.7559C33.2456 14.5996 33.3334 14.3877 33.3334 14.1667V10.8333C33.3334 10.6123 33.2456 10.4004 33.0893 10.2441C32.933 10.0878 32.721 10 32.5 10Z"
                                    fill="#A098AE"
                                  />
                                  <path
                                    d="M29.1667 16.6667C28.9457 16.6667 28.7337 16.7545 28.5774 16.9108C28.4211 17.067 28.3333 17.279 28.3333 17.5V18.4067C27.1462 18.5788 26.0408 19.1118 25.1669 19.9335C24.2931 20.7552 23.6931 21.8257 23.4483 23C23.3989 23.2425 23.404 23.4929 23.4633 23.7331C23.5227 23.9734 23.6348 24.1974 23.7915 24.3889C23.9482 24.5804 24.1456 24.7346 24.3694 24.8403C24.5931 24.946 24.8376 25.0006 25.085 25H33.2517C33.4991 25.0006 33.7436 24.946 33.9673 24.8403C34.1911 24.7346 34.3885 24.5804 34.5452 24.3889C34.7019 24.1974 34.814 23.9734 34.8734 23.7331C34.9327 23.4929 34.9378 23.2425 34.8883 23C34.6434 21.8253 34.0429 20.7543 33.1684 19.9326C32.2939 19.1109 31.1877 18.5781 30 18.4067V17.5C30 17.279 29.9122 17.067 29.7559 16.9108C29.5997 16.7545 29.3877 16.6667 29.1667 16.6667Z"
                                    fill="#A098AE"
                                  />
                                </svg>
                                <a
                                  href="${pageContext.request.contextPath}/orders"
                                  >Order History</a
                                >
                              </li>
                              <li
                                class="py-2 pl-8 gap-4 bg-white rounded-2xl flex items-center text-black hover:bg-yellow-400 hover:text-white"
                                x-data="{ isOpen: false }"
                              >
                                <button
                                  @click="isOpen = !isOpen; $nextTick(() => {isOpen ? $refs.userMenu.focus() : null})"
                                  class="transition-opacity py-2 gap-4 flex items-center rounded-lg opacity-80 hover:opacity-100 focus:outline-none focus:ring focus:ring-indigo-600 focus:ring-offset-white focus:ring-offset-2"
                                >
                                  <svg
                                    width="40"
                                    height="40"
                                    viewBox="0 0 40 40"
                                    fill="none"
                                    xmlns="http://www.w3.org/2000/svg"
                                  >
                                    <path
                                      d="M24.6438 26.3562L24.5688 23.7C25.1313 23.5937 25.9188 22.6437 26.2375 22.1375L25.1625 19.725C24.5688 19.6313 23.3375 19.575 22.8813 19.925L20.9563 18.0938C21.275 17.625 21.1625 16.4 21.025 15.8188L18.5563 14.875C18.075 15.2187 17.1688 16.0563 17.0938 16.625L14.4375 16.6937C14.3313 16.1312 13.375 15.3562 12.875 15.0312L10.4625 16.1062C10.3688 16.7 10.3125 17.9313 10.6625 18.3875L8.83755 20.3125C8.36255 19.9937 7.13755 20.1125 6.5563 20.2437L5.61255 22.7063C5.9563 23.2 6.7938 24.0938 7.3563 24.175L7.4313 26.8312C6.87505 26.9438 6.0938 27.8875 5.7688 28.3937L6.85005 30.8062C7.43755 30.9 8.6688 30.95 9.12505 30.6125L11.05 32.4312C10.7313 32.9 10.85 34.1313 10.9813 34.7125L13.4438 35.6562C13.9313 35.3062 14.8375 34.4688 14.9125 33.9062L17.5688 33.8312C17.6813 34.4 18.625 35.175 19.1375 35.4937L21.5438 34.425C21.6438 33.825 21.6875 32.6 21.35 32.1437L23.1688 30.2125C23.6438 30.5375 24.8688 30.4187 25.4563 30.2875L26.3938 27.8187C26.0438 27.3375 25.2125 26.4375 24.6438 26.3562ZM18.8188 26.3375C18.6062 26.895 18.233 27.3769 17.7465 27.7224C17.26 28.0678 16.682 28.2612 16.0855 28.2781C15.4891 28.295 14.9011 28.1347 14.3957 27.8174C13.8904 27.5001 13.4906 27.0401 13.2467 26.4955C13.0028 25.951 12.9259 25.3463 13.0257 24.7581C13.1254 24.1698 13.3974 23.6243 13.8072 23.1906C14.217 22.7569 14.7462 22.4545 15.3278 22.3215C15.9095 22.1886 16.5175 22.2311 17.075 22.4437C17.4456 22.5844 17.7847 22.7969 18.0729 23.0689C18.3612 23.3408 18.593 23.667 18.755 24.0288C18.917 24.3905 19.006 24.7806 19.0169 25.1768C19.0279 25.5729 18.9606 25.9674 18.8188 26.3375ZM34.375 9.1625C34.0813 8.91875 33.3875 8.4875 33.0438 8.6L31.9875 6.8C32.25 6.55625 32.2125 5.7375 32.1438 5.36875L30.3375 4.34375C29.9813 4.475 29.2626 4.8625 29.1875 5.2125L27.1 5.23125C27.0188 4.88125 26.2938 4.50625 25.9375 4.375L24.15 5.43125C24.0875 5.8 24.0625 6.61875 24.325 6.8625L23.3 8.675C22.95 8.56875 22.2625 9.0125 21.975 9.25625L21.9938 11.3312C22.2875 11.575 22.9813 12 23.325 11.8938L24.3813 13.6938C24.1188 13.9375 24.1563 14.7563 24.225 15.125L26.0313 16.15C26.3813 16.0187 27.1 15.6313 27.1813 15.2812L29.2625 15.2625C29.35 15.6125 30.075 15.9875 30.4313 16.1187L32.2188 15.0625C32.2813 14.6875 32.3063 13.875 32.0375 13.6312L33.0688 11.8187C33.4125 11.9187 34.1 11.4812 34.3876 11.2375L34.375 9.1625ZM28.1813 11.8813C27.8583 11.8806 27.5428 11.7843 27.2745 11.6045C27.0062 11.4247 26.7972 11.1694 26.6739 10.8709C26.5506 10.5724 26.5184 10.244 26.5816 9.92726C26.6448 9.61051 26.8004 9.31958 27.0288 9.0912C27.2571 8.86282 27.5481 8.70722 27.8648 8.64406C28.1816 8.5809 28.5099 8.613 28.8084 8.73631C29.1069 8.85963 29.3622 9.06863 29.5421 9.33692C29.7219 9.60521 29.8182 9.92077 29.8188 10.2437C29.8193 10.4589 29.7773 10.6721 29.6952 10.871C29.613 11.0699 29.4924 11.2506 29.3403 11.4027C29.1881 11.5549 29.0074 11.6755 28.8085 11.7576C28.6096 11.8397 28.3965 11.8817 28.1813 11.8813Z"
                                      fill="#A098AE"
                                    />
                                  </svg>
                                  <a>Settings</a>
                                </button>
                                <div
                                  x-show="isOpen"
                                  @click.away="isOpen = false"
                                  @keydown.escape="isOpen = false"
                                  x-ref="userMenu"
                                  tabindex="-1"
                                  class="absolute w-48 py-1 mt-2 origin-bottom-left bg-white rounded-md shadow-lg left-10 bottom-14 focus:outline-none"
                                  role="menu"
                                  aria-orientation="vertical"
                                  aria-label="user menu"
                                >
                                  <a
                                    href="${pageContext.request.contextPath}/login"
                                    class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100"
                                    role="menuitem"
                                    >Sign out</a
                                  >
                                </div>
                              </li>
                            </ul>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </nav>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Main Content -->
      <div class="flex flex-col w-full mt-16">
        <c:forEach var="category" items="${items.keySet()}">
          <div class="w-full ml-20 text-2xl font-bold titleColor">
            ${category}
          </div>
          <div class="w-full flex flex-wrap justify-start gap-12">
            <!-- Product Card -->
            <div class="swiper mt-4 w-full h-full">
              <div class="swiper-wrapper h-full">
                <!-- Product Cards -->
                <c:forEach
                  items="${items[category]}"
                  var="item"
                  varStatus="loop"
                >
                  <!-- Open new swiper-slide for every 3 products -->
                  <c:if test="${loop.index % 3 == 0}">
            <div class="swiper-slide">
              <div class="w-full flex flex-wrap justify-center  h-full gap-12">
          </c:if>
          <div class="w-1/5 bg-white overflow-hidden border border-yellow-100 rounded-2xl flex flex-col items-center">
            <div class="relative w-full px-2">
              <img class="w-full h-44 object-fill hover:scale-110 transform transition duration-500 ease-in-out cursor-pointer"
                src="${pageContext.request.contextPath}${item.getImage()}" alt="Product Image" />
              <a href="${pageContext.request.contextPath}/${favourites.contains(item) ? 'removefavourite' : 'addfavourite'}/${item.getId()}">
            <button class="absolute top-0 right-0 mt-2 mr-2">
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"
                fill="${favourites.contains(item) ? 'currentColor' : 'none'}" stroke="currentColor" stroke-width="2"
                stroke-linecap="round" stroke-linejoin="round" class="h-6 w-6">
                <path
                  d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 19.78l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z">
                </path>
              </svg>
            </button>
          </a>
            </div>
            <div class="font-bold text-xl mt-5 titleColor">${item.getName()}</div>
            <div class="py-2 text-center ">
              <div class="flex justify-between gap-4">
                <div class="mt-4 flex flex-col justify-center items-center">
                  <span class="text-sm font-semibold titleColor">Category</span>
                  <span class="text-sm textColor">${item.getCategory().getName()}</span>
                </div>
                <div class="mt-4 flex flex-col justify-center items-center">
                  <span class="text-sm font-semibold titleColor">Price</span>
                  <span class="text-sm textColor font-bold">${item.getPrice()}</span>
                </div>
              </div>
            </div>
            <div class="pt-2 pb-4 w-full flex flex-col items-center justify-between text-sm">
              <button class="btnBg w-max text-white font-bold py-2 px-4 m-2 rounded-2xl">
                Add to Cart - ${item.getPrice()}
              </button>
              <div class="btnBg w-max text-white font-bold py-2 m-2 rounded-2xl px-4">
                In Stock
              </div>
            </div>
          </div>
                  <!-- Close the swiper-slide if this is the 3rd product or the last product -->
                  <c:if test="${loop.index % 3 == 2 or loop.last}">
              </div>
            </div>
          </c:if>
                </c:forEach>
              </div>
            </div>
            <div class="swiper-button-prev flex"></div>
            <div class="swiper-button-next"></div>
          </div>
        </c:forEach>
      </div>
      <!-- Right Navbar -->
      <div class="flex justify-end right-0" id="rightnavbar">
        <div
          x-data="setup2()"
          x-init="$refs.loading.classList.add('hidden');"
          @resize.window="watchScreen()"
        >
          <div
            class="flex bg-Transparent h-screen right-0 antialiased text-gray-900 justify-end bg-gray-100 dark:bg-dark dark:text-light"
          >
            <!-- Loading screen -->
            <div
              x-ref="loading"
              class="fixed inset-0 right-0 z-50 flex items-center justify-center text-2xl font-semibold text-white bg-yellow-400"
            >
              Loading.....
            </div>
            <!-- Sidebar -->
            <div class="flex flex-shrink-0 transition-all right-0 justify-end">
              <!-- Mobile bottom bar -->
              <nav
                aria-label="Options"
                class="absolute h-20 right-2 top-0 flex flex-row items-start z-0 justify-end border-t border-yellow-100 sm:hidden rounded-t-3xl w-40"
              >
                <!-- Menu button -->

                <div class="flex gap-7 items-center">
                  <img
                   
                    src="${pageContext.request.contextPath}/images/resources/fav-icon.png"
                    href="${pageContext.request.contextPath}/favourite"
                   
                    class="w-7 h-6 mt-1"
                 
                  />
                  <button
                    @click="(isSidebarOpen && currentSidebarTab == 'linksTab') ? isSidebarOpen = false : isSidebarOpen = true; currentSidebarTab = 'linksTab'"
                    class="p-2 right-0 transition-colors rounded-lg hover:bg-yellow-400 hover:text-white focus:outline-none focus:ring focus:ring-yellow-300 focus:ring-offset-white focus:ring-offset-2"
                    :class="(isSidebarOpen && currentSidebarTab == 'linksTab') ? 'text-white bg-yellow-300' : 'text-gray-500'"
                  >
                    <img
                      src="${pageContext.request.contextPath}/images/resources/orders.png"
                      class="w-7 h-7"
                    />
                  </button>
                </div>
              </nav>
              <!-- Left mini bar -->
              <nav
                aria-label="Options"
                class="absolute h-10 right-2 top-0 bg-Transparent z-20 flex-col items-center flex-shrink-0 right-0 justify-start hidden w-28 sm:flex rounded-tr-3xl rounded-br-3xl"
              >
                <!-- Logo -->
                <div class="flex items-center gap-4 top-0">
                  <!-- Menu button -->
                  <img
                    src="${pageContext.request.contextPath}/images/resources/fav-icon.png"
                    class="w-7 h-6 mt-1"
                  />
                  <button
                    @click="(isSidebarOpen && currentSidebarTab == 'linksTab') ? isSidebarOpen = false : isSidebarOpen = true; currentSidebarTab = 'linksTab'"
                    class="p-2 transition-colors right-0 rounded-lg hover:bg-yellow-400 hover:text-white focus:outline-none focus:ring focus:ring-yellow-300 focus:ring-offset-white focus:ring-offset-2"
                    :class="(isSidebarOpen && currentSidebarTab == 'linksTab') ? 'text-white bg-yellow-300' : 'text-gray-500'"
                  >
                    <div class="flex gap-7">
                      <img
                        src="${pageContext.request.contextPath}/images/resources/orders.png"
                        class="w-7 h-7"
                      />
                    </div>
                  </button>
                </div>
              </nav>
              <div
                x-transition:enter="transition-transform transition-opacity ease-in-out duration-300"
                x-transition:enter-start="transform translate-x-full opacity-0"
                x-transition:enter-end="transform translate-x-0 opacity-100"
                x-transition:leave="transition-transform transition-opacity ease-in-out duration-300"
                x-transition:leave-start="transform translate-x-0 opacity-100"
                x-transition:leave-end="transform translate-x-full opacity-0"
                x-show="isSidebarOpen"
                class="fixed inset-y-0 right-0 justify-end z-10 flex-shrink-0 w-64 bg-white border-r-2 border-yellow-100 shadow-lg sm:left-16 rounded-tr-3xl rounded-br-3xl sm:w-72 lg:static lg:w-64"
              >
                <nav
                  x-show="currentSidebarTab == 'linksTab'"
                  aria-label="Main"
                  class="flex flex-col h-full"
                >
                  <div
                    class="flex-1 px-4 space-y-2 overflow-hidden hover:overflow-auto"
                  >
                    <div>
                      <!-- Close icon -->
                      <div class="flex justify-end">
                        <button
                          @click="isSidebarOpen = false"
                          class="p-2 mt-12 z-20 transition-colors rounded-lg hover:bg-yellow-400 hover:text-white focus:outline-none focus:ring focus:ring-yellow-300 focus:ring-offset-white focus:ring-offset-2"
                        >
                          <svg
                            xmlns="http://www.w3.org/2000/svg"
                            class="w-6 h-6"
                            fill="none"
                            viewBox="0 0 24 24"
                            stroke="currentColor"
                          >
                            <path
                              stroke-linecap="round"
                              stroke-linejoin="round"
                              stroke-width="2"
                              d="M6 18L18 6M6 6l12 12"
                            />
                          </svg>
                        </button>
                      </div>

                      <div
                        class="flex flex-col items-start h-screen bg-white rounded-l-2xl w-2/5"
                      >
                        <div class="flex">
                          <div class="w-72 pr-20">
                            <!-- component -->
                            <c:if test="${empty cart}">
                              <p>Your cart is empty.</p>
                            </c:if>
                            <c:if test="${not empty cart}">
                              <div class="p-5">
                                <div class="flex h-64 justify-center">
                                  <div class="relative">
                                    <div
                                      class="flex flex-row cursor-pointer truncate p-2 px-4 rounded"
                                    >
                                      <div
                                        class="flex flex-row-reverse ml-20 w-full"
                                      >
                                        <div slot="icon" class="relative">
                                          <div
                                            class="absolute text-xs rounded-full -mt-1 -mr-2 px-1 font-bold top-0 right-0 bg-red-700 text-white"
                                          >
                                            ${totalProducts}
                                          </div>

                                          <svg
                                            xmlns="http://www.w3.org/2000/svg"
                                            width="100%"
                                            height="100%"
                                            fill="none"
                                            viewBox="0 0 24 24"
                                            stroke="currentColor"
                                            stroke-width="2"
                                            stroke-linecap="round"
                                            stroke-linejoin="round"
                                            class="feather feather-shopping-cart w-6 h-6 mt-2"
                                          >
                                            <circle
                                              cx="9"
                                              cy="21"
                                              r="1"
                                            ></circle>
                                            <circle
                                              cx="20"
                                              cy="21"
                                              r="1"
                                            ></circle>
                                            <path
                                              d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"
                                            ></path>
                                          </svg>
                                        </div>
                                      </div>
                                    </div>
                                    <div
                                      class="w-full rounded-b border-t-0 z-10"
                                    >
                                      <div class="w-full">
                                        <c:forEach var="entry" items="${cart}">
                                          <c:set
                                            var="item"
                                            value="${entry.key}"
                                          />
                                          <c:set
                                            var="quantity"
                                            value="${entry.value}"
                                          />
                                          <div
                                            class="p-2 flex bg-white hover:bg-gray-100 cursor-pointer border-b border-gray-100"
                                          >
                                            <div class="p-2 w-12">
                                              <img
                                                src="${pageContext.request.contextPath}${item.getImage()}"
                                                alt="img product"
                                              />
                                            </div>
                                            <div class="flex-auto text-sm w-32">
                                              <div class="font-bold">
                                                ${item.getName()}
                                              </div>
                                              <div class="truncate">
                                                ${item.getDescription()}
                                              </div>
                                              <div class="text-gray-400">
                                                Qt: ${quantity}
                                              </div>
                                            </div>
                                            <div
                                              class="flex flex-col w-18 font-medium items-end"
                                            >
                                              <div
                                                class="w-4 h-4 mb-6 hover:bg-red-200 rounded-full cursor-pointer text-red-700"
                                              >
                                                <a
                                                  href="${pageContext.request.contextPath}/removefromcart/${item.getId()}"
                                                >
                                                  <svg
                                                    xmlns="http://www.w3.org/2000/svg"
                                                    width="100%"
                                                    height="100%"
                                                    fill="none"
                                                    viewBox="0 0 24 24"
                                                    stroke="currentColor"
                                                    stroke-width="2"
                                                    stroke-linecap="round"
                                                    stroke-linejoin="round"
                                                    class="feather feather-trash-2"
                                                  >
                                                    <polyline
                                                      points="3 6 5 6 21 6"
                                                    ></polyline>
                                                    <path
                                                      d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"
                                                    ></path>
                                                    <line
                                                      x1="10"
                                                      y1="11"
                                                      x2="10"
                                                      y2="17"
                                                    ></line>
                                                    <line
                                                      x1="14"
                                                      y1="11"
                                                      x2="14"
                                                      y2="17"
                                                    ></line>
                                                  </svg>
                                                </a>
                                              </div>
                                              ${item.getPrice()}
                                            </div>
                                          </div>
                                        </c:forEach>

                                        <div class="p-4 justify-center flex">
                                          <button
                                            class="text-base undefined hover:scale-110 focus:outline-none flex justify-center px-4 py-2 rounded font-bold cursor-pointer hover:bg-teal-700 hover:text-teal-100 bg-teal-100 text-teal-700 border duration-200 ease-in-out border-teal-600 transition"
                                          >
                                            Checkout $${totalPrice}
                                          </button>
                                        </div>
                                      </div>
                                    </div>
                                  </div>
                                </div>
                                <div class="h-32"></div>
                              </div>
                            </c:if>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </nav>
              </div>
            </div>
          </div>
        </div>
      </div>

      <script
        src="https://cdn.jsdelivr.net/gh/alpinejs/alpine@v2.7.3/dist/alpine.min.js"
        defer
      ></script>
      <script>
        const setup = () => {
          return {
            isSidebarOpen: false,
            currentSidebarTab: null,
            isSettingsPanelOpen: false,
            isSubHeaderOpen: false,
            watchScreen() {
              if (window.innerWidth <= 1024) {
                this.isSidebarOpen = false;
              }
            },
          };
        };
      </script>
      <script>
        const setup2 = () => {
          return {
            isSidebarOpen: false,
            currentSidebarTab: null,
            isSettingsPanelOpen: false,
            isSubHeaderOpen: false,
            watchScreen() {
              if (window.innerWidth <= 1024) {
                this.isSidebarOpen = false;
              }
            },
          };
        };
      </script>
      <script>
        const swiper = new Swiper(".swiper", {
          direction: "horizontal",
          loop: true,

          pagination: {
            el: ".swiper-pagination",
          },

          navigation: {
            nextEl: ".swiper-button-next",
            prevEl: ".swiper-button-prev",
          },

          scrollbar: {
            el: ".swiper-scrollbar",
          },
        });
      </script>
    </div>
  </body>
</html>
