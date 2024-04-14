var swiper = new Swiper(".mySwiper", {
  effect: "coverflow",
  grabCursor: true,
  centeredSlides: true,
  loop: true,
  slidesPerView: "1",
  coverflowEffect: {
    rotate: 0,
    stretch: 0,
    depth: 100,
    modifier: 4,
    slideShadows: false,
  },
  keyboard: {
    enabled: true,
  },
  mousewheel: {
    thresholdDelta: 70,
  },
  initialSlide: 0,
  on: {
    click(event) {
      swiper.slideTo(this.clickedIndex);
    },
  },
  breakpoints: {
    640: {
      slidesPerView: 2,
    },
  },
});
function showGIF() {
  var gif = document.getElementById("gif");
  gif.classList.remove("hidden"); // Remove the 'hidden' class to show the GIF
  gif.src = gif.src;
}

// Event listener to trigger the showGIF function on any click event
document.addEventListener("click", function () {
  //   showGIF(); // Call the function to show the GIF whenever any click event happens
});

window.addEventListener("load", function () {
  //   showGIF(); // Call the function to show the GIF when the page loads
});

// js for sidebar

document.addEventListener("DOMContentLoaded", function () {
  const image = document.getElementById("image");
  const slideInDiv = document.getElementById("slideInDiv");
  slideInDiv.style.left = "-280px"; // Hide the sliding div
  // Function to toggle the visibility of the sliding div
  function toggleSlideInDiv() {
    slideInDiv.style.left = slideInDiv.style.left === "0px" ? "280px" : "0px";
  }

  // Event listener for image click to toggle sidebar visibility
  image.addEventListener("click", toggleSlideInDiv);

  // Event listener to hide the sidebar when clicked outside
  document.addEventListener("click", function (event) {
    if (!slideInDiv.contains(event.target) && event.target !== image) {
      slideInDiv.style.left = "-280px"; // Hide the sliding div
    }
  });

  // Prevent hiding the sidebar when clicking on buttons inside it
  slideInDiv.addEventListener("click", function (event) {
    event.stopPropagation(); // Prevent click event from bubbling up to document
  });
});

// JavaScript for right-sidebar
document.addEventListener("DOMContentLoaded", function () {
  const image2 = document.getElementById("image2");
  const rightSidebar = document.getElementById("slideInDiv2");

  // Function to toggle the visibility of the sliding div
  function toggleSlideInDiv2() {
    rightSidebar.style.right =
      rightSidebar.style.right === "-40px" ? "400px" : "-40px";
  }

  // Event listener for image click to toggle sidebar visibility
  image2.addEventListener("click", toggleSlideInDiv2);

  // Event listener to hide the sidebar when clicked outside
  document.addEventListener("click", function (event) {
    if (!rightSidebar.contains(event.target) && event.target !== image2) {
      rightSidebar.style.right = "-450px"; // Hide the sliding div
    }
  });

  // Prevent hiding the sidebar when clicking on buttons inside it
  rightSidebar.addEventListener("click", function (event) {
    event.stopPropagation(); // Prevent click event from bubbling up to document
  });
});

//js for slider buttons

document.addEventListener("DOMContentLoaded", function () {
  const buttons = document.querySelectorAll(".button");
  const borderHighlight = document.getElementById("borderHighlight");

  buttons.forEach((button) => {
    button.addEventListener("click", function () {
      // Remove active class from all buttons
      buttons.forEach((btn) => btn.classList.remove("active"));
      // Add active class to the clicked button
      this.classList.add("active");
      // Move the border highlight element to the clicked button
      const leftPosition = this.offsetLeft;
      borderHighlight.style.transform = `translateX(${leftPosition}px)`;
    });
  });
});

// js for right sidebar cart

document.addEventListener("DOMContentLoaded", function () {
  const starterItems = document.getElementById("starter-items");
  const meatItems = document.getElementById("meat-items");
  const fishItems = document.getElementById("fish-items");
  const dessertItems = document.getElementById("dessert-items");
  const grandTotalText = document.getElementById("grand-total");

  let grandTotal = 0;

  function addItem(category, name, price, imageSrc) {
    const item = document.createElement("li");
    item.classList.add("item");
    item.innerHTML = `
        <img src="${imageSrc}" alt="${name}" style="width: 50px; height: 50px; border-radius: 50%;">
        <span class="item-name">${name}</span>
        <div class="quantity">
          <button class="minus-btn">-</button>
          <label>×<span>1</span></label>
          <button class="plus-btn">+</button>
        </div>
        <span class="item-price">$${price.toFixed(2)}</span>
      `;

    category.appendChild(item);
  }

  function updateTotal() {
    grandTotalText.textContent = `Grand Total: $${grandTotal.toFixed(2)}`;
  }

  function clearAllItems() {
    starterItems.innerHTML = "";
    meatItems.innerHTML = "";
    fishItems.innerHTML = "";
    dessertItems.innerHTML = "";
    grandTotal = 0;
    updateTotal();
  }

  // Sample item data (can be replaced with actual item data)
  const items = [
    {
      category: starterItems,
      name: "Soup",
      price: 5.99,
      imageSrc: "./img/chef (2).png",
    },
    {
      category: starterItems,
      name: "Salad",
      price: 7.99,
      imageSrc: "./img/chef (2).png",
    },
    {
      category: meatItems,
      name: "Steak",
      price: 15.99,
      imageSrc: "./img/chef (2).png",
    },
    {
      category: meatItems,
      name: "Burger",
      price: 9.99,
      imageSrc: "./img/chef (2).png",
    },
    {
      category: fishItems,
      name: "Salmon",
      price: 12.99,
      imageSrc: "./img/chef (2).png",
    },
    {
      category: fishItems,
      name: "Shrimp",
      price: 11.99,
      imageSrc: "./img/chef (2).png",
    },
    {
      category: dessertItems,
      name: "Cake",
      price: 8.99,
      imageSrc: "./img/chef (2).png",
    },
    {
      category: dessertItems,
      name: "Ice Cream",
      price: 6.99,
      imageSrc: "./img/chef (2).png",
    },
  ];

  // Add items to respective categories
  items.forEach((item) => {
    addItem(item.category, item.name, item.price, item.imageSrc);
  });

  // Event listeners for plus and minus buttons
  document.querySelectorAll(".plus-btn").forEach((button) => {
    button.addEventListener("click", function () {
      const itemPrice = parseFloat(
        this.parentElement.nextElementSibling.textContent.slice(1)
      );
      const quantityInput = this.parentElement.querySelector("span");
      let quantity = parseInt(quantityInput.innerHTML);
      quantity++;
      quantityInput.innerHTML = quantity;
      grandTotal += itemPrice;
      updateTotal();
    });
  });

  document.querySelectorAll(".minus-btn").forEach((button) => {
    button.addEventListener("click", function () {
      const itemPrice = parseFloat(
        this.parentElement.nextElementSibling.textContent.slice(1)
      );
      const quantityInput = this.parentElement.querySelector("span");
      let quantity = parseInt(quantityInput.innerHTML);

      if (quantity === 1) {
        // If quantity is 1, remove the item from the list
        const item = this.closest(".item");
        const category = item.closest(".items");
        category.removeChild(item);
      } else {
        // Otherwise, decrease the quantity and update total
        quantity--;
        quantityInput.innerHTML = quantity;
        grandTotal -= itemPrice;
        updateTotal();
      }
    });
  });

  // Event listener for Clear All button
  document
    .getElementById("clear-all-btn")
    .addEventListener("click", clearAllItems);
});
