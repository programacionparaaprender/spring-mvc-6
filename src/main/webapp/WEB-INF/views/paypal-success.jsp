<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Pago Exitoso</title>
    <style>
        body {
            font-family: "Segoe UI", Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f6f8;
        }
        .container {
            max-width: 600px;
            margin: 80px auto;
            padding: 30px;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            text-align: center;
        }
        h1 {
            color: #28a745;
            margin-bottom: 20px;
            font-size: 26px;
        }
        p {
            font-size: 16px;
            color: #333;
            margin: 8px 0;
        }
        .data-box {
            background-color: #f9f9f9;
            padding: 15px;
            border-radius: 6px;
            margin-top: 20px;
            text-align: left;
        }
        strong {
            color: #000;
        }
        .button {
            display: inline-block;
            background-color: #007bff;
            color: white;
            padding: 10px 18px;
            margin-top: 25px;
            border-radius: 6px;
            text-decoration: none;
            transition: background-color 0.3s;
        }
        .button:hover {
            background-color: #0056b3;
        }
        .footer {
            margin-top: 30px;
            font-size: 13px;
            color: #777;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>✅ Pago Completado con Éxito</h1>

        <div class="data-box">
            <p><strong>Token:</strong> ${token}</p>
            <p><strong>Payer ID:</strong> ${payerId}</p>
            <c:if test="${not empty amount}">
                <p><strong>Monto:</strong> $${amount}</p>
            </c:if>
            <c:if test="${not empty transactionId}">
                <p><strong>ID de Transacción:</strong> ${transactionId}</p>
            </c:if>
        </div>

        <a href="${pageContext.request.contextPath}/students" class="button">Volver al listado</a>

        <div class="footer">
            <p>Gracias por tu pago. Puedes revisar los detalles en tu cuenta PayPal.</p>
        </div>
    </div>
</body>
</html>
