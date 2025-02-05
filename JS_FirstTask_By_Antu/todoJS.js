const taskInput = document.getElementById('task-input');
        const taskList = document.getElementById('task-list');

        // Add task when pressing Enter
        taskInput.addEventListener('keydown', function (event) {
            if (event.key === "Enter") {
                addTask();
            }
        });

        function addTask() {
            const taskValue = taskInput.value.trim();

            // Prevent empty tasks
            if (taskValue === "") {
                alert("Task cannot be empty!");
                return;
            }

            // Prevent duplicate tasks
            const tasks = taskList.querySelectorAll('li');
            for (let task of tasks) {
                if (task.firstChild.textContent === taskValue) {
                    alert("This task already exists!");
                    taskInput.value = ""; // Clear input field
                    return;
                }
            }

            // Create new list item
            const li = document.createElement('li');
            li.textContent = taskValue;

            // Add "Complete" button
            const completeButton = document.createElement('button');
            completeButton.textContent = "Complete";
            completeButton.className = "complete";
            completeButton.onclick = function () {
                li.classList.toggle('completed');
            };

            // Add "Delete" button
            const deleteButton = document.createElement('button');
            deleteButton.textContent = "Delete";
            deleteButton.className = "delete";
            deleteButton.onclick = function () {
                taskList.removeChild(li);
            };

            // Append buttons to the list item
            li.appendChild(completeButton);
            li.appendChild(deleteButton);

            // Add the list item to the task list
            taskList.appendChild(li);

            // Clear input field for the next task
            taskInput.value = "";
        }