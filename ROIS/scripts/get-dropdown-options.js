locationDropDownReceiving();
locationDropDownOutgoing();

if (!localStorage && !sessionStorage) {
    window.location.href = 'Login.aspx';
}

function locationDropDownReceiving() {
    let currentUserId = sessionStorage.getItem("userId");
    let data = JSON.stringify({ userId: currentUserId, transactionMode: 1 });
    let request = new XMLHttpRequest();
    request.open('POST', 'ROISWebService.asmx/GetDropDownData');
    request.setRequestHeader('Content-Type', 'application/json; charset=utf-8');

    request.onload = function () {
        if (this.status >= 200 && this.status < 400) {
            let location = JSON.parse(this.responseText);

            localStorage.setItem("receivingDropdown", JSON.stringify(location));
        }
        else {

        }
    };

    request.onerror = function () {

    };

    request.send(data);
}

function locationDropDownOutgoing() {
    let currentUserId = sessionStorage.getItem("userId");
    let data = JSON.stringify({ userId: currentUserId, transactionMode: 2 });
    let request = new XMLHttpRequest();
    request.open('POST', 'ROISWebService.asmx/GetDropDownData');
    request.setRequestHeader('Content-Type', 'application/json; charset=utf-8');

    request.onload = function () {
        if (this.status >= 200 && this.status < 400) {
            let location = JSON.parse(this.responseText);

            localStorage.setItem("outgoingDropdown", JSON.stringify(location));
        }
        else {

        }
    };

    request.onerror = function () {

    };

    request.send(data);
}