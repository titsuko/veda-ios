package com.titsuko

import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping

@Controller
@RequestMapping("/admin")
class HomeController {

    @GetMapping
    fun getPage(): String = "home"
}
