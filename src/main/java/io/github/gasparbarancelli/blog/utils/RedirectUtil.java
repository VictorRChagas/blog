package io.github.gasparbarancelli.blog.utils;

import org.springframework.web.servlet.ModelAndView;

import java.util.function.Supplier;

public class RedirectUtil {

    public static Supplier<ModelAndView> defaultRedirect = () -> new ModelAndView("redirect:/");
}
