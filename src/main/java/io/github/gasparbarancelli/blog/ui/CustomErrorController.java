package io.github.gasparbarancelli.blog.ui;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import java.util.Optional;

@Controller
public class CustomErrorController implements ErrorController {

    @GetMapping(value = "/error")
    public ModelAndView handleError(HttpServletRequest request) {
        var message = Optional.ofNullable(request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE))
                .map(statusCode -> (Integer) statusCode)
                .map(statusCode -> {
                    if (HttpStatus.NOT_FOUND.value() == statusCode) {
                        return "Página não encontrada.";
                    } else if (HttpStatus.INTERNAL_SERVER_ERROR.value() == statusCode) {
                        return "Erro ao processar sua requisição, tente novamente mais tarde.";
                    }
                    return null;
                })
                .orElse("Erro inesperado!!!");

        return new ModelAndView("error")
                .addObject("message", message);
    }

    @Override
    public String getErrorPath() {
        return "error";
    }

}
