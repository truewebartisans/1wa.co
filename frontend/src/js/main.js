import AddToHomeScreen from "a2hs.js";

// Styles
import "../scss/_main.scss";

// Define variables
const stickyElements = document.querySelectorAll(".sticky");

// Add position: sticky to elements
if (stickyElements.length > 0) {
  import("stickyfilljs").then(Stickyfill => Stickyfill.add(stickyElements));
}

// Add to Home Screen
AddToHomeScreen({
  fontFamily: '"Inter var", Inter, sans-serif'
});
