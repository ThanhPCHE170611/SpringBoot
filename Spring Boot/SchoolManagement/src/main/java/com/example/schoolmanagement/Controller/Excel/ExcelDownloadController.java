package com.example.schoolmanagement.Controller.Excel;

import com.example.schoolmanagement.Model.*;
import com.example.schoolmanagement.Repository.MarkRepository;
import com.example.schoolmanagement.Repository.StudentTranscriptRepository;
import com.example.schoolmanagement.Repository.UserRepository;
import com.example.schoolmanagement.Service.ExcelDownloadService;
import lombok.AllArgsConstructor;
import org.apache.commons.compress.utils.IOUtils;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFClientAnchor;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Controller
@RequestMapping("/schooladmin/exceldownload")
@AllArgsConstructor
public class ExcelDownloadController {

    private final ExcelDownloadService excelDownLoadService;

    @GetMapping("/deactivereport")
    public void downloadDeactiveStudentReport(HttpServletResponse response, HttpSession session) throws IOException {
        excelDownLoadService.dowloadDeactiveStudentReportForSchoolAdmin(response, session);
    }


    @GetMapping(path = "/ethnicreport/{ethnicid}")
    public void downloadEthnicStudentReport(@PathVariable String ethnicid ,HttpServletResponse response, HttpSession session) throws IOException {
        excelDownLoadService.downloadEthnicStudentReportForSchoolAdmin(ethnicid, response, session);
    }

    @GetMapping(path = "/subjectreport/{subjectcode}")
    public void downloadSubjectTeacherReport(@PathVariable String subjectcode, HttpServletResponse response, HttpSession session) throws IOException{
        excelDownLoadService.downloadSubjectTeacherReportForSchoolAdmin(subjectcode, response, session);
    }

    @GetMapping(path = "/upclassreport")
    public void downloadStudentUpClass(HttpServletResponse response, HttpSession session) throws IOException{
        excelDownLoadService.downloadStudentUpClassForSchoolAdmin(response, session);
    }

    @GetMapping("/sadeactivereport")
    public void dowloadSADeactiveReport(HttpServletResponse response) throws IOException{
        excelDownLoadService.dowloadSADeactiveReport(response);
    }

    @GetMapping("/saupclassreport")
    public void downloadSAUpClassReport(HttpServletResponse response) throws  IOException{
        excelDownLoadService.downloadSAUpClassReport(response);
    }

    @GetMapping("/sasubjectreport/{subjectcode}")
    public void downloadSASubjectTeacherReport(@PathVariable String subjectcode, HttpServletResponse response) throws IOException{
        excelDownLoadService.downloadSASubjectTeacherReport(subjectcode, response);
    }

    @GetMapping("/saethnicreport/{ethnicid}")
    public void downloadSAEthnicStudentReport(@PathVariable String ethnicid , HttpServletResponse response) throws IOException {
        excelDownLoadService.downloadSAEthnicStudentReport(ethnicid, response);
    }

    @GetMapping("/generateusertemplate")
    public void generateUserTemplate(HttpServletResponse response) throws IOException{
        excelDownLoadService.generateUserTemplate(response);
    }


}
