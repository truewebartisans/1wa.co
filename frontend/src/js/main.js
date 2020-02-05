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

// First we get the viewport height and we multiple it by 1% to get a value for a vh unit
let vh = window.innerHeight * 0.01;
// Then we set the value in the --vh custom property to the root of the document
document.documentElement.style.setProperty("--vh", `${vh}px`);

// We listen to the resize event
window.addEventListener("resize", () => {
  // We execute the same script as before
  let vh = window.innerHeight * 0.01;
  document.documentElement.style.setProperty("--vh", `${vh}px`);
});
