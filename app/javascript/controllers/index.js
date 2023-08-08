// Import and register all your controllers from the importmap under controllers/*

import { application } from "controllers/application"

// Eager load all controllers defined in the import map under controllers/**/*_controller
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)


document.addEventListener("DOMContentLoaded", () => {
  const priceInput = document.getElementById("item-price");
  const addTaxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");

  priceInput.addEventListener("input", () => {
    const inputText = priceInput.value;
    if (/^[0-9]+$/.test(inputText)) {
      const price = parseInt(inputText, 10);
      if (price >= 300 && price <= 9999999) {
        const tax = Math.floor(price * 0.1);
        addTaxPrice.textContent = tax.toLocaleString();
        profit.textContent = (price - tax).toLocaleString();
      } else {
        addTaxPrice.textContent = "";
        profit.textContent = "";
      }
    } else {
      addTaxPrice.textContent = "";
      profit.textContent = "";
    }
  });
});
