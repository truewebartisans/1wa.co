// Get cookie value
function getCookie(name) {
  let matches = document.cookie.match(
    new RegExp(
      "(?:^|; )" +
        name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, "\\$1") +
        "=([^;]*)"
    )
  );

  return matches ? decodeURIComponent(matches[1]) : undefined;
}

// If cookie "cc" is undefined, show banner
if (getCookie("cc") === undefined) {
  // Define banner element and OK button
  const cookieConfirm = document.querySelector(".cookie-confirm");
  const cookieConfirmButton = document.querySelector(".cookie-confirm-button");
  // Show banner
  cookieConfirm.classList.remove("hidden");
  // Click on button to hidden banner and set cookie "cc=1"
  cookieConfirmButton.addEventListener("click", function () {
    cookieConfirm.classList.add("hidden");
    document.cookie = "cc=1";
  });
}
