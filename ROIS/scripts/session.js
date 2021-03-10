if (sessionStorage.getItem("username") === '' || sessionStorage.getItem("username") === null) {
    localStorage.clear();
    sessionStorage.clear();
    window.location.href = 'Login.aspx';
}