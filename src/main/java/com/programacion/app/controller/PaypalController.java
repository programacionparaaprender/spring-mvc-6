package com.programacion.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/paypal")
public class PaypalController {

    @GetMapping("/success")
    public String handleSuccess(
            @RequestParam("token") String token,
            @RequestParam("PayerID") String payerId, Model model) {

        // Aquí puedes llamar a tu servicio para capturar el pago con PayPal
        System.out.println("✅ Pago exitoso:");
        System.out.println("Token: " + token);
        System.out.println("PayerID: " + payerId);

        // Puedes pasar datos a la vista
        ModelAndView mav = new ModelAndView("paypal-success"); // vista JSP o Thymeleaf
        mav.addObject("token", token);
        mav.addObject("payerId", payerId);
        model.addAttribute("token", token);
        model.addAttribute("payerId", payerId);

        return "paypal-success";
    }
}
