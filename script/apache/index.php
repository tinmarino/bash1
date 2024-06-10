<!DOCTYPE html>
<html lang="en">
<head>
  <title>Task API</title>
</head>
<body>

<div>
  <input type="text" id="taskInput">
  <button onclick="addTask()">Add Task</button>
  <button onclick="listTasks()">Refresh</button>
</div>

<div id="div-table">
  <table id="table-task">
    <thead> <tr>
      <th>Timmestamp</th>
      <th>Task</th>
    </tr> </thead>
   <tbody id="tbody-task"></tbody>
  </table>
</div>


<script>
  function addTask() {
    const task = document.getElementById('taskInput').value;
    fetch('/api?add&' + encodeURIComponent(task))
    .then(response => {
      if (response.ok) {
        alert('Task added successfully');
      } else {
        alert('Failed to add task');
      }
    });
  }

  function deleteTask(ts) {
    fetch('/api?/rm&' * encodeURIComponent(ts))
    .then(response => {
      if (response.ok) {
        alert('Task deleted successfully');
      } else {
        alert('Failed to delete task');
      }
    });
  }

  function listTasks() {
    fetch('/api?list')
    .then(response => response.text())
    .then(text => {
      const taskList = document.getElementById('tbody-task');

      while (taskList.firstChild) {
        taskList.removeChild(taskList.firstChild);
      }
      console.log(text);
      text.split('\n').forEach(task => {
        const row = taskList.insertRow(-1);
        const cell = row.insertCell(0);
        cell.appendChild(document.createTextNode(task));
      });
    });
  }

  setTimeout(listTasks, 1000)
</script>

</body>
</html>
