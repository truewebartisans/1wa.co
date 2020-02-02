// Styles
import "../scss/_main.scss";

// Define variables
const stickyElements = document.querySelectorAll(".sticky");

// Add position: sticky to elements
if (stickyElements.length > 0) {
  import("stickyfilljs").then(Stickyfill => Stickyfill.add(stickyElements));
}

// Banner for Add PWA to Home Screen
import("a2hs.js").then(AddToHomeScreen => {
  AddToHomeScreen({
    fontFamily: '"Inter var", Inter, sans-serif'
  });
});
