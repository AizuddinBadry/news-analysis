document.addEventListener("DOMContentLoaded", async function () {
  var response = await fetch(`${process.env.OKTA_URL}/api/v1/users/me`, {
    credentials: "include",
    method: "get",
    headers: { "Content-Type": "application/json" },
  });

  var userdata = await response.json();
  console.log(userdata.profile);
});
