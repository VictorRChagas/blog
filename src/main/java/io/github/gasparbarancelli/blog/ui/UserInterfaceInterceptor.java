package io.github.gasparbarancelli.blog.ui;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.SmartView;
import org.springframework.web.servlet.View;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.constraints.NotNull;
import java.util.Optional;

@Component
public class UserInterfaceInterceptor implements HandlerInterceptor {

    private final FacadeService facadeService;

    public UserInterfaceInterceptor(FacadeService facadeService) {
        this.facadeService = facadeService;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        if (modelAndView != null && !isRedirectView(modelAndView)) {
            var tags = facadeService.getTags();
            modelAndView.addObject("tags", tags);
        }
    }

    public static boolean isRedirectView(@NotNull ModelAndView modelAndView) {
        String viewName = Optional.ofNullable(modelAndView.getViewName()).orElse("");
        if (viewName.startsWith("redirect:/")) {
            return true;
        }
        View view = modelAndView.getView();
        return view instanceof SmartView && ((SmartView) view).isRedirectView();
    }

}
