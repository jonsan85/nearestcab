// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.mycompany.nearestcab.controller;

import com.mycompany.nearestcab.controller.CabController;
import com.mycompany.nearestcab.domain.Cab;
import java.io.UnsupportedEncodingException;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect CabController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String CabController.create(@Valid Cab cab, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, cab);
            return "cabs/create";
        }
        uiModel.asMap().clear();
        cab.persist();
        return "redirect:/cabs/" + encodeUrlPathSegment(cab.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String CabController.createForm(Model uiModel) {
        populateEditForm(uiModel, new Cab());
        return "cabs/create";
    }
    
    @RequestMapping(value = "/{id}", produces = "text/html")
    public String CabController.show(@PathVariable("id") Long id, Model uiModel) {
        uiModel.addAttribute("cab", Cab.findCab(id));
        uiModel.addAttribute("itemId", id);
        return "cabs/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String CabController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("cabs", Cab.findCabEntries(firstResult, sizeNo));
            float nrOfPages = (float) Cab.countCabs() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("cabs", Cab.findAllCabs());
        }
        return "cabs/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String CabController.update(@Valid Cab cab, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, cab);
            return "cabs/update";
        }
        uiModel.asMap().clear();
        cab.merge();
        return "redirect:/cabs/" + encodeUrlPathSegment(cab.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", produces = "text/html")
    public String CabController.updateForm(@PathVariable("id") Long id, Model uiModel) {
        populateEditForm(uiModel, Cab.findCab(id));
        return "cabs/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    public String CabController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        Cab cab = Cab.findCab(id);
        cab.remove();
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/cabs";
    }
    
    void CabController.populateEditForm(Model uiModel, Cab cab) {
        uiModel.addAttribute("cab", cab);
    }
    
    String CabController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
        String enc = httpServletRequest.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        } catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}
