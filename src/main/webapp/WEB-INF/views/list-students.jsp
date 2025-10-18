<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>${titulo}</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            line-height: 1.6;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
        h1 {
            color: #333;
        }
        .tech-list, .user-list {
            margin: 15px 0;
            padding-left: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .button {
            background-color: #4CAF50;
            border: none;
            color: white;
            padding: 8px 16px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 4px;
        }
        .button.payment {
            background-color: green; /* Verde */
            color:white;
        }
        .button.edit {
            background-color: #2196F3; /* Azul */
        }
        .button.delete {
            background-color: #f44336; /* Rojo */
        }
        .button-container {
            margin-bottom: 20px;
        }
        .actions-cell {
            white-space: nowrap; /* Evita que los botones se apilen */
        }
    </style>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<div class="container">
	    <div class="button-container">
	        <a href="${pageContext.request.contextPath}/students/new" class="button">Crear Estudiante</a>
	    </div>
	
	    <!-- Formulario para subir Excel -->
	    <h3>Importar estudiantes desde Excel:</h3>
	    <form action="${pageContext.request.contextPath}/students/uploadExcel" 
	          method="post" enctype="multipart/form-data">
	        <input id="excelFile" type="file" name="file" accept=".xls,.xlsx" required />
	        <button id="botonSubir" type="button" class="button">Subir Excel</button>
	    </form>
	
	    <h3>Lista de Estudiantes:</h3>
	    <table>
	        <thead>
	            <tr>
	                <th>ID</th>
	                <th>Nombre</th>
	                <th>Apellido</th>
	                <th>Email</th>
	                <th>Acciones</th>
	            </tr>
	        </thead>
	        <tbody>
	            <c:forEach items="${students}" var="student">
	                <tr>
	                    <td>${student.id}</td>
	                    <td>${student.firstName}</td>
	                    <td>${student.lastName}</td>
	                    <td>${student.email}</td>
	                    <td class="actions-cell">
	                        <!-- Botón Editar -->
	                        <a href="${pageContext.request.contextPath}/students/edit/${student.id}" 
	                           class="button edit">
	                            Editar
	                        </a>
	                        <!-- Botón Eliminar -->
	                        <a href="${pageContext.request.contextPath}/students/delete/${student.id}" 
	                           class="button delete" 
	                           onclick="return confirm('¿Estás seguro de que quieres eliminar este estudiante?')">
	                            Eliminar
	                        </a>
	                        <a 
	                           class="button payment" 
	                           onclick="PayPalButton()">
	                            Pagar Paypal
	                        </a>
	                    </td>
	                </tr>
	            </c:forEach>
	        </tbody>
	    </table>
	    <div id="uploadResult" style="margin-top:10px; color:green;"></div>
	    <p>Context Path: ${pageContext.request.contextPath}</p>
	</div>
<script>
async function PayPalButton() {
	var contextPath = "${pageContext.request.contextPath}";
    try {
      const response = await fetch('http://localhost:8081/paypal/create-order', {
        method: 'POST',
      });
      const text = await response.text();

      console.log('Respuesta del backend:', text);

      // Buscar el enlace de aprobación en el texto de la respuesta
      const match = text.match(/Aprobar en:\s*(https[^\s]+)/);
      if (match && match[1]) {
        const approveUrl = match[1];
        //setMessage('Redirigiendo a PayPal...');
        window.location.href = approveUrl; // 🔁 redirige al sandbox de PayPal
      } else {
        //setMessage('No se encontró el enlace de aprobación.');
      }
	  alert('pago procesado');
    } catch (error) {
      console.error('Error al crear la orden:', error);
      //setMessage('Error al crear la orden.');
    } finally {
      //setLoading(false);
    }

  
}

var botonSubir = document.getElementById("botonSubir");
botonSubir.addEventListener("click", (e) => {
	e.preventDefault();
	//console.log(this.className); // WARNING: `this` is not `my_element`
	//console.log(e.currentTarget === this); // logs `false`
	const fileInput = document.getElementById("excelFile");
    if (!fileInput.files.length) {
        alert("Selecciona un archivo primero.");
        return;
    }
    const formData = new FormData();
    formData.append("file", fileInput.files[0]);

    peticionAjax(formData);
    
    
	
});
function peticionAjax(formData){
	var contextPath = "${pageContext.request.contextPath}";
    contextPath = 'http://localhost:8080/spring-mvc-6';
    console.log('contextPath', contextPath);
	$.ajax({
        url: contextPath + "/students/upload/",
        type: "POST",
        data: formData,
        processData: false, // importante
        contentType: false, // importante
        success: function(data) {
            $("#uploadResult").text(data + " ✅");
            console.log("Respuesta del servidor:", data);
        },
        error: function(xhr, status, error) {
            $("#uploadResult").text("Error al subir el archivo ❌");
            console.error("Error:", error);
        }
    });
}
function peticionFetch(formData){
	var contextPath = "${pageContext.request.contextPath}";
    contextPath = 'http://localhost:8080/spring-mvc-6';
    console.log('contextPath', contextPath);
	fetch(contextPath + "/students/upload/", {
        method: "POST",
        body: formData
    })
    .then(response => {
        if (!response.ok) {
            throw new Error("Error al subir archivo, status: " + response.status);
        }
        return response.text(); // tu controlador devuelve un String
    })
    .then(data => {
        document.getElementById("uploadResult").textContent = data + " ✅";
        console.log("Respuesta del servidor:", data);
    })
    .catch(error => {
        document.getElementById("uploadResult").textContent = "Error al subir el archivo ❌";
        console.error("Error:", error);
    });
}
</script>
</body>
</html>