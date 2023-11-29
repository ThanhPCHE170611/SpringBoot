package com.example.schoolmanagement.Controller.SchoolAdmin;

import com.example.schoolmanagement.Model.ChangeClass;
import com.example.schoolmanagement.Model.Organization;
import com.example.schoolmanagement.Model.Users;
import com.example.schoolmanagement.Repository.ChangeClassRepository;
import com.example.schoolmanagement.Service.ChangeClassService;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@AllArgsConstructor

public class SchoolAdminRequestManagementController {

    private final ChangeClassRepository changeClassRepository;
    private final ChangeClassService changeClassService;

    @GetMapping(path = "/schooladmin/requestmanagement")
    public String viewAllRequest(HttpSession session, Model model,  @RequestParam(value = "page", defaultValue = "0") int page,
                                 @RequestParam(value = "size", defaultValue = "10") int pageSize){
        if(session.getAttribute("user") == null){
            return "redirect:/auth/login";
        }
        else {
            Users schoolAdmin = (Users) session.getAttribute("user");
            Page<ChangeClass> requests = changeClassService.getRequests(schoolAdmin, page, pageSize);
            model.addAttribute("requests", requests);
            model.addAttribute("page", page);
            return "schooladminchangeclassmanagement";
        }

    }

    @GetMapping(path = "/schooladmin/requestmanagement/accept/{requestId}")
    public String viewAcceptRequest(@PathVariable Long requestId, HttpSession session, Model model){
        ChangeClass request = changeClassRepository.findById(requestId).get();
        model.addAttribute("request", request);
        return "schooladminacceptrequest";
    }
    @GetMapping(path = "/schooladmin/requestmanagement/reject/{requestId}")
    public String viewRejectRequest(@PathVariable Long requestId, HttpSession session, Model model){
        ChangeClass request = changeClassRepository.findById(requestId).get();
        model.addAttribute("request", request);
        return "schooladminrejectrequest";
    }

    @PostMapping(path = "/schooladmin/requestmanagement/accept")
    public String acceptRequest(@RequestParam Long requestid, @RequestParam String reason, HttpSession session, Model model){
        if(isValidReason(reason)){
            ChangeClass request = changeClassRepository.findById(requestid).get();
            request.setReason(reason);
            request.setStatus("accept");
            changeClassService.updateRequest(request);
            Users student  = request.getStudent();
            student.setStudentclass(request.getNewClass());
            changeClassService.updateStudentClass(student);
            model.addAttribute("error", "Accept successful!");
            return "redirect:/schooladmin/requestmanagement";
        } else {
            model.addAttribute("error", "Reason invalid!");
            return "redirect:/schooladmin/requestmanagement/accept/" + requestid;
        }
    }

    @PostMapping(path = "/schooladmin/requestmanagement/reject")
    public String rejectRequest(@RequestParam Long requestid, @RequestParam String reason, HttpSession session, Model model){
        if(isValidReason(reason)){
            ChangeClass request = changeClassRepository.findById(requestid).get();
            request.setReason(reason);
            request.setStatus("reject");
            changeClassService.updateRequest(request);
            model.addAttribute("error", "Reject successful!");
            return "redirect:/schooladmin/requestmanagement";
        } else {
            model.addAttribute("error", "Reason invalid!");
            return "redirect:/schooladmin/requestmanagement/accept/" + requestid;
        }
    }

    private boolean isValidReason(String reason){
        return reason.matches("^[\\p{L}\\d<=>.\\s]+$");
    }
}
