function toggleEngine() {

  var gSearch = document.getElementById("gSearch");
  var dSearch = document.getElementById("dSearch");
  var logo = document.getElementById("engineLogo").src;
  localStorage.setItem('preferredEngine', logo);

  if (logo.indexOf("brave.svg") != -1) {
    document.getElementById("engineLogo").src = "icons/google.svg";
    gSearch.style.display = "block";
    dSearch.style.display = "none";
  } else {
    document.getElementById("engineLogo").src = "icons/brave.svg";
    dSearch.style.display = "block";
    gSearch.style.display = "none";
  }

  document.getElementById("textField").reset();
}
