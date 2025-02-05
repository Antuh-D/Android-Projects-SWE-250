window.onload = () => {
    const welcomePage = document.getElementById("welcomePage");
    const todoPage = document.getElementById("todoPage");
    const getStartedBtn = document.getElementById("getStartedBtn");

    const form1 = document.querySelector("#addForm");
    const items = document.getElementById("items");
    const submit = document.getElementById("submit");

    let editItem = null;

  
    getStartedBtn.addEventListener("click", () => {
        welcomePage.style.display = "none";
        todoPage.style.display = "block";
    });

    form1.addEventListener("submit", addItem);
    items.addEventListener("click", removeItem);

    function addItem(e) {
        e.preventDefault();

        if (submit.value !== "Submit") {
            editItem.target.parentNode.childNodes[0].data = document.getElementById("item").value;

            submit.value = "Submit";
            document.getElementById("item").value = "";

            showSuccess("Text edited successfully");
            return false;
        }

        let newItem = document.getElementById("item").value;
        if (newItem.trim() === "") return false;

        document.getElementById("item").value = "";

        let li = document.createElement("li");
        li.className = "list-group-item";

        let deleteButton = document.createElement("button");
        deleteButton.className = "btn-danger btn btn-sm float-right delete";
        deleteButton.appendChild(document.createTextNode("Delete"));

        let editButton = document.createElement("button");
        editButton.className = "btn-success btn btn-sm float-right edit";
        editButton.appendChild(document.createTextNode("Edit"));

        li.appendChild(document.createTextNode(newItem));
        li.appendChild(deleteButton);
        li.appendChild(editButton);

        items.appendChild(li);
    }

    function removeItem(e) {
        e.preventDefault();

        if (e.target.classList.contains("delete")) {
            if (confirm("Are you sure?")) {
                let li = e.target.parentNode;
                items.removeChild(li);
                showSuccess("Text deleted successfully");
            }
        }

        if (e.target.classList.contains("edit")) {
            document.getElementById("item").value = e.target.parentNode.childNodes[0].data;
            submit.value = "EDIT";
            editItem = e;
        }
    }

    function showSuccess(message) {
        const lblsuccess = document.getElementById("lblsuccess");
        lblsuccess.innerHTML = message;
        lblsuccess.style.display = "block";

        setTimeout(() => {
            lblsuccess.style.display = "none";
        }, 3000);
    }

    window.toggleButton = (ref, btnID) => {
        document.getElementById(btnID).disabled = false;
    };
};
