package com.example.schoolmanagement.Controller.Excel;

import com.example.schoolmanagement.Model.*;
import com.example.schoolmanagement.Repository.MarkRepository;
import com.example.schoolmanagement.Repository.StudentTranscriptRepository;
import com.example.schoolmanagement.Repository.UserRepository;
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
    private final UserRepository userRepository;
    private final StudentTranscriptRepository studentTranscriptRepository;
    private final MarkRepository markRepository;

    @GetMapping("/deactivereport")
    public void downloadDeactiveStudentReport(HttpServletResponse response, HttpSession session) throws IOException {
        Users schoolAdmin = (Users) session.getAttribute("user");
        Organization schoolOrganization = schoolAdmin.getSchoolOrganization();
        List<Users> students = userRepository.findAllByschoolOrganizationAndStatusAndDeactiveTime(schoolOrganization.getId(), "deactive");
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Deactive Student Sheet");
        Row headerRow = sheet.createRow(0);
        headerRow.createCell(0).setCellValue("Organization");
        headerRow.createCell(1).setCellValue("RollNumber");
        headerRow.createCell(2).setCellValue("Full Name");
        headerRow.createCell(3).setCellValue("Picture");
        headerRow.createCell(4).setCellValue("Gender");
        headerRow.createCell(5).setCellValue("Address");

        int rowIdx = 1;
        for (Users student : students) {
            Row row = sheet.createRow(rowIdx++);
            row.createCell(0).setCellValue(student.getSchoolOrganization().getSchoolname());
            row.createCell(1).setCellValue(student.getRollNumber());
            row.createCell(2).setCellValue(student.getFullname());
            String imagePath = student.getPicture();

            if (imagePath != null) {
                // Create an input stream to read the image
                FileInputStream fis = new FileInputStream("D:\\SpringBootGitHub\\SpringBoot\\Spring Boot\\SchoolManagement\\src\\main\\resources\\static\\images\\" + student.getRollNumber() + ".png");

                // Convert the image to a byte array
                byte[] imageBytes = IOUtils.toByteArray(fis);

                // Create a drawing object
                Drawing<?> drawing = sheet.createDrawingPatriarch();

                // Create an anchor for the image
                ClientAnchor anchor = new XSSFClientAnchor(0, 0, 0, 0, (short) 3, rowIdx - 1, (short) 4, rowIdx);

                // Create an image
                int pictureIndex = workbook.addPicture(imageBytes, Workbook.PICTURE_TYPE_JPEG);
                drawing.createPicture(anchor, pictureIndex);
                fis.close();
            }
            row.createCell(4).setCellValue(student.getGender().getGender());
            row.createCell(5).setCellValue(student.getAddress());
        }
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=DeactiveStudent.xlsx");
        workbook.write(response.getOutputStream());
    }


    @GetMapping(path = "/ethnicreport/{ethnicid}")
    public void downloadEthnicStudentReport(@PathVariable String ethnicid ,HttpServletResponse response, HttpSession session) throws IOException {
        Users schoolAdmin = (Users) session.getAttribute("user");
        Organization schoolOrganization = schoolAdmin.getSchoolOrganization();
        List<Users> students = userRepository.findAllByschoolOrganizationAndStatusAndEthnic(schoolOrganization.getId(), "active", Long.parseLong(ethnicid));
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Ethnic Student Sheet");
        Row headerRow = sheet.createRow(0);
        headerRow.createCell(0).setCellValue("Organization");
        headerRow.createCell(1).setCellValue("RollNumber");
        headerRow.createCell(2).setCellValue("Full Name");
        headerRow.createCell(3).setCellValue("Picture");
        headerRow.createCell(4).setCellValue("Gender");
        headerRow.createCell(5).setCellValue("Address");

        int rowIdx = 1;
        for (Users student : students) {
            Row row = sheet.createRow(rowIdx++);
            row.createCell(0).setCellValue(student.getSchoolOrganization().getSchoolname());
            row.createCell(1).setCellValue(student.getRollNumber());
            row.createCell(2).setCellValue(student.getFullname());
            String imagePath = student.getPicture();

            if (imagePath != null) {
                // Create an input stream to read the image
                FileInputStream fis = new FileInputStream("D:\\SpringBootGitHub\\SpringBoot\\Spring Boot\\SchoolManagement\\src\\main\\resources\\static\\images\\" + student.getRollNumber() + ".png");

                // Convert the image to a byte array
                byte[] imageBytes = IOUtils.toByteArray(fis);

                // Create a drawing object
                Drawing<?> drawing = sheet.createDrawingPatriarch();

                // Create an anchor for the image
                ClientAnchor anchor = new XSSFClientAnchor(0, 0, 0, 0, (short) 3, rowIdx - 1, (short) 4, rowIdx);

                // Create an image
                int pictureIndex = workbook.addPicture(imageBytes, Workbook.PICTURE_TYPE_JPEG);
                drawing.createPicture(anchor, pictureIndex);
                fis.close();
            }
            row.createCell(4).setCellValue(student.getGender().getGender());
            row.createCell(5).setCellValue(student.getAddress());
        }
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=EthnicStudent.xlsx");
        workbook.write(response.getOutputStream());
    }

    @GetMapping(path = "/subjectreport/{subjectcode}")
    public void downloadSubjectTeacherReport(@PathVariable String subjectcode, HttpServletResponse response, HttpSession session) throws IOException{
        Users schoolAdmin = (Users) session.getAttribute("user");
        Organization schoolOrganization = schoolAdmin.getSchoolOrganization();
        List<Users> allUsers = userRepository.findAllByschoolOrganizationAndStatus(schoolOrganization.getId(), "active");
        Set<Users> teachers = new HashSet<>();
        for (Users user : allUsers){
            List<TeacherClassSubject> teacherClassSubjects = user.getTeacherClassSubjects();
            for (TeacherClassSubject teacherClassSubject : teacherClassSubjects){
                if (teacherClassSubject.getSubjectTeaching().getSubjectcode().equals(subjectcode) && teacherClassSubject.getStatus().equalsIgnoreCase("active")){
                    teachers.add(user);
                }
            }
        }
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Subject Teacher Sheet");
        Row headerRow = sheet.createRow(0);
        headerRow.createCell(0).setCellValue("Organization");
        headerRow.createCell(1).setCellValue("RollNumber");
        headerRow.createCell(2).setCellValue("Full Name");
        headerRow.createCell(3).setCellValue("Picture");
        headerRow.createCell(4).setCellValue("Gender");
        headerRow.createCell(5).setCellValue("Ethnic");
        headerRow.createCell(6).setCellValue("Religion");

        int rowIdx = 1;
        for (Users teacher : teachers) {
            Row row = sheet.createRow(rowIdx++);
            row.createCell(0).setCellValue(teacher.getSchoolOrganization().getSchoolname());
            row.createCell(1).setCellValue(teacher.getRollNumber());
            row.createCell(2).setCellValue(teacher.getFullname());
            String imagePath = teacher.getPicture();

            if (imagePath != null) {
                // Create an input stream to read the image
                FileInputStream fis = new FileInputStream("D:\\SpringBootGitHub\\SpringBoot\\Spring Boot\\SchoolManagement\\src\\main\\resources\\static\\images\\" + teacher.getRollNumber() + ".png");

                // Convert the image to a byte array
                byte[] imageBytes = IOUtils.toByteArray(fis);

                // Create a drawing object
                Drawing<?> drawing = sheet.createDrawingPatriarch();

                // Create an anchor for the image
                ClientAnchor anchor = new XSSFClientAnchor(0, 0, 0, 0, (short) 3, rowIdx - 1, (short) 4, rowIdx);

                // Create an image
                int pictureIndex = workbook.addPicture(imageBytes, Workbook.PICTURE_TYPE_JPEG);
                drawing.createPicture(anchor, pictureIndex);
                fis.close();
            }
            row.createCell(4).setCellValue(teacher.getGender().getGender());
            row.createCell(5).setCellValue(teacher.getEthnic().getEthnic());
            row.createCell(6).setCellValue(teacher.getReligions().getReligion());
        }
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=SubjectTeacher.xlsx");
        workbook.write(response.getOutputStream());
    }

    @GetMapping(path = "/upclassreport")
    public void downloadStudentUpClass(HttpServletResponse response, HttpSession session) throws IOException{
        Users schoolAdmin = (Users) session.getAttribute("user");
        Organization schoolOrganization = schoolAdmin.getSchoolOrganization();
        List<Users> allUsers = userRepository.findAllByschoolOrganizationAndStatus(schoolOrganization.getId(), "active");
        List<Users> students = new ArrayList<>();
        for (Users user : allUsers){
            System.out.println("User with roll Number:" + user.getRollNumber());
            double totalMark = 0;
            List<StudentTranscript> studentTranscripts = studentTranscriptRepository.findAllByStudent(user);
            if(studentTranscripts != null){
                for (StudentTranscript studentTranscript : studentTranscripts){
                    //get mark list of that student in that semester -> many subject
                    double numberToDevide = studentTranscriptRepository.findByStudentSemesterAndStudent(studentTranscript.getStudent(), studentTranscript.getSemester()).size();
                    List<Mark> markList = markRepository.findAllBySemesterAndRollNumber(studentTranscript.getSemester().getId(), user.getRollNumber());
                    double markAVG = 0;
                    for (Mark mark : markList){
                        if(mark.getWeight()*10 == 1){
                            markAVG += mark.getMark()*0.1;
                        } else if(mark.getWeight()*10 == 2){
                            markAVG += mark.getMark()*0.2;
                        } else {
                            markAVG += mark.getMark()*0.3;
                        }
                    }
                    markAVG /= Math.pow(numberToDevide, 2);
                    System.out.println("RollNumber:" + user.getRollNumber());
                    System.out.println("MarkAVG:" + markAVG);
                    totalMark += markAVG;
                }
                totalMark /= 2;
                System.out.println("TotalMark:" + totalMark);
            }
            if(totalMark >= 5){
                user.setMarkAverage(totalMark);
                students.add(user);
            }
        }
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Upclass Student Sheet");
        Row headerRow = sheet.createRow(0);
        headerRow.createCell(0).setCellValue("Organization");
        headerRow.createCell(1).setCellValue("RollNumber");
        headerRow.createCell(2).setCellValue("Full Name");
        headerRow.createCell(3).setCellValue("Picture");
        headerRow.createCell(4).setCellValue("Gender");
        headerRow.createCell(5).setCellValue("Address");
        headerRow.createCell(6).setCellValue("Average Mark");
        int rowIdx = 1;
        for (Users student : students) {
            Row row = sheet.createRow(rowIdx++);
            row.createCell(0).setCellValue(student.getSchoolOrganization().getSchoolname());
            row.createCell(1).setCellValue(student.getRollNumber());
            row.createCell(2).setCellValue(student.getFullname());
            String imagePath = student.getPicture();

            if (imagePath != null) {
                // Create an input stream to read the image
                FileInputStream fis = new FileInputStream("D:\\SpringBootGitHub\\SpringBoot\\Spring Boot\\SchoolManagement\\src\\main\\resources\\static\\images\\" + student.getRollNumber() + ".png");

                // Convert the image to a byte array
                byte[] imageBytes = IOUtils.toByteArray(fis);

                // Create a drawing object
                Drawing<?> drawing = sheet.createDrawingPatriarch();

                // Create an anchor for the image
                ClientAnchor anchor = new XSSFClientAnchor(0, 0, 0, 0, (short) 3, rowIdx - 1, (short) 4, rowIdx);

                // Create an image
                int pictureIndex = workbook.addPicture(imageBytes, Workbook.PICTURE_TYPE_JPEG);
                drawing.createPicture(anchor, pictureIndex);
                fis.close();
            }
            row.createCell(4).setCellValue(student.getGender().getGender());
            row.createCell(5).setCellValue(student.getAddress());
            row.createCell(6).setCellValue(student.getMarkAverage());
        }
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=UpclassStudent.xlsx");
        workbook.write(response.getOutputStream());
    }

    @GetMapping("/sadeactivereport")
    public void dowloadSADeactiveReport(HttpServletResponse response) throws IOException{
        List<Users> students = userRepository.findAllByStatusAndDeactiveTime( "deactive");
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Deactive Student Sheet");
        Row headerRow = sheet.createRow(0);
        headerRow.createCell(0).setCellValue("Organization");
        headerRow.createCell(1).setCellValue("RollNumber");
        headerRow.createCell(2).setCellValue("Full Name");
        headerRow.createCell(3).setCellValue("Picture");
        headerRow.createCell(4).setCellValue("Gender");
        headerRow.createCell(5).setCellValue("Address");

        int rowIdx = 1;
        for (Users student : students) {
            Row row = sheet.createRow(rowIdx++);
            row.createCell(0).setCellValue(student.getSchoolOrganization().getSchoolname());
            row.createCell(1).setCellValue(student.getRollNumber());
            row.createCell(2).setCellValue(student.getFullname());
            String imagePath = student.getPicture();

            if (imagePath != null) {
                // Create an input stream to read the image
                FileInputStream fis = new FileInputStream("D:\\SpringBootGitHub\\SpringBoot\\Spring Boot\\SchoolManagement\\src\\main\\resources\\static\\images\\" + student.getRollNumber() + ".png");

                // Convert the image to a byte array
                byte[] imageBytes = IOUtils.toByteArray(fis);

                // Create a drawing object
                Drawing<?> drawing = sheet.createDrawingPatriarch();

                // Create an anchor for the image
                ClientAnchor anchor = new XSSFClientAnchor(0, 0, 0, 0, (short) 3, rowIdx - 1, (short) 4, rowIdx);

                // Create an image
                int pictureIndex = workbook.addPicture(imageBytes, Workbook.PICTURE_TYPE_JPEG);
                drawing.createPicture(anchor, pictureIndex);
                fis.close();
            }
            row.createCell(4).setCellValue(student.getGender().getGender());
            row.createCell(5).setCellValue(student.getAddress());
        }
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=DeactiveStudent.xlsx");
        workbook.write(response.getOutputStream());
    }

    @GetMapping("/saupclassreport")
    public void downloadSAUpClassReport(HttpServletResponse response) throws  IOException{
        List<Users> allUsers = userRepository.findAllByStatus("active");
        List<Users> students = new ArrayList<>();
        for (Users user : allUsers){
            System.out.println("User with roll Number:" + user.getRollNumber());
            double totalMark = 0;
            List<StudentTranscript> studentTranscripts = studentTranscriptRepository.findAllByStudent(user);
            if(studentTranscripts != null){
                for (StudentTranscript studentTranscript : studentTranscripts){
                    //get mark list of that student in that semester -> many subject
                    double numberToDevide = studentTranscriptRepository.findByStudentSemesterAndStudent(studentTranscript.getStudent(), studentTranscript.getSemester()).size();
                    List<Mark> markList = markRepository.findAllBySemesterAndRollNumber(studentTranscript.getSemester().getId(), user.getRollNumber());
                    double markAVG = 0;
                    for (Mark mark : markList){
                        if(mark.getWeight()*10 == 1){
                            markAVG += mark.getMark()*0.1;
                        } else if(mark.getWeight()*10 == 2){
                            markAVG += mark.getMark()*0.2;
                        } else {
                            markAVG += mark.getMark()*0.3;
                        }
                    }
                    markAVG /= Math.pow(numberToDevide, 2);
                    System.out.println("RollNumber:" + user.getRollNumber());
                    System.out.println("MarkAVG:" + markAVG);
                    totalMark += markAVG;
                }
                totalMark /= 2;
                System.out.println("TotalMark:" + totalMark);
            }
            if(totalMark >= 5){
                user.setMarkAverage(totalMark);
                students.add(user);
            }
        }
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Upclass Student Sheet");
        Row headerRow = sheet.createRow(0);
        headerRow.createCell(0).setCellValue("Organization");
        headerRow.createCell(1).setCellValue("RollNumber");
        headerRow.createCell(2).setCellValue("Full Name");
        headerRow.createCell(3).setCellValue("Picture");
        headerRow.createCell(4).setCellValue("Gender");
        headerRow.createCell(5).setCellValue("Address");
        headerRow.createCell(6).setCellValue("Average Mark");
        int rowIdx = 1;
        for (Users student : students) {
            Row row = sheet.createRow(rowIdx++);
            row.createCell(0).setCellValue(student.getSchoolOrganization().getSchoolname());
            row.createCell(1).setCellValue(student.getRollNumber());
            row.createCell(2).setCellValue(student.getFullname());
            String imagePath = student.getPicture();

            if (imagePath != null) {
                // Create an input stream to read the image
                FileInputStream fis = new FileInputStream("D:\\SpringBootGitHub\\SpringBoot\\Spring Boot\\SchoolManagement\\src\\main\\resources\\static\\images\\" + student.getRollNumber() + ".png");

                // Convert the image to a byte array
                byte[] imageBytes = IOUtils.toByteArray(fis);

                // Create a drawing object
                Drawing<?> drawing = sheet.createDrawingPatriarch();

                // Create an anchor for the image
                ClientAnchor anchor = new XSSFClientAnchor(0, 0, 0, 0, (short) 3, rowIdx - 1, (short) 4, rowIdx);

                // Create an image
                int pictureIndex = workbook.addPicture(imageBytes, Workbook.PICTURE_TYPE_JPEG);
                drawing.createPicture(anchor, pictureIndex);
                fis.close();
            }
            row.createCell(4).setCellValue(student.getGender().getGender());
            row.createCell(5).setCellValue(student.getAddress());
            row.createCell(6).setCellValue(student.getMarkAverage());
        }
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=UpclassStudent.xlsx");
        workbook.write(response.getOutputStream());
    }

    @GetMapping("/sasubjectreport/{subjectcode}")
    public void downloadSASubjectTeacherReport(@PathVariable String subjectcode, HttpServletResponse response) throws IOException{
        List<Users> allUsers = userRepository.findAllByStatus("active");
        Set<Users> teachers = new HashSet<>();
        for (Users user : allUsers){
            List<TeacherClassSubject> teacherClassSubjects = user.getTeacherClassSubjects();
            for (TeacherClassSubject teacherClassSubject : teacherClassSubjects){
                if (teacherClassSubject.getSubjectTeaching().getSubjectcode().equals(subjectcode) && teacherClassSubject.getStatus().equalsIgnoreCase("active")){
                    teachers.add(user);
                }
            }
        }
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Subject Teacher Sheet");
        Row headerRow = sheet.createRow(0);
        headerRow.createCell(0).setCellValue("Organization");
        headerRow.createCell(1).setCellValue("RollNumber");
        headerRow.createCell(2).setCellValue("Full Name");
        headerRow.createCell(3).setCellValue("Picture");
        headerRow.createCell(4).setCellValue("Gender");
        headerRow.createCell(5).setCellValue("Ethnic");
        headerRow.createCell(6).setCellValue("Religion");

        int rowIdx = 1;
        for (Users teacher : teachers) {
            Row row = sheet.createRow(rowIdx++);
            row.createCell(0).setCellValue(teacher.getSchoolOrganization().getSchoolname());
            row.createCell(1).setCellValue(teacher.getRollNumber());
            row.createCell(2).setCellValue(teacher.getFullname());
            String imagePath = teacher.getPicture();

            if (imagePath != null) {
                // Create an input stream to read the image
                FileInputStream fis = new FileInputStream("D:\\SpringBootGitHub\\SpringBoot\\Spring Boot\\SchoolManagement\\src\\main\\resources\\static\\images\\" + teacher.getRollNumber() + ".png");

                // Convert the image to a byte array
                byte[] imageBytes = IOUtils.toByteArray(fis);

                // Create a drawing object
                Drawing<?> drawing = sheet.createDrawingPatriarch();

                // Create an anchor for the image
                ClientAnchor anchor = new XSSFClientAnchor(0, 0, 0, 0, (short) 3, rowIdx - 1, (short) 4, rowIdx);

                // Create an image
                int pictureIndex = workbook.addPicture(imageBytes, Workbook.PICTURE_TYPE_JPEG);
                drawing.createPicture(anchor, pictureIndex);
                fis.close();
            }
            row.createCell(4).setCellValue(teacher.getGender().getGender());
            row.createCell(5).setCellValue(teacher.getEthnic().getEthnic());
            row.createCell(6).setCellValue(teacher.getReligions().getReligion());
        }
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=SubjectTeacher.xlsx");
        workbook.write(response.getOutputStream());
    }

    @GetMapping("/saethnicreport/{ethnicid}")
    public void downloadSAEthnicStudentReport(@PathVariable String ethnicid , HttpServletResponse response) throws IOException {
        List<Users> students = userRepository.findAllByStatusAndEthnic("active", Long.parseLong(ethnicid));
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Ethnic Student Sheet");
        Row headerRow = sheet.createRow(0);
        headerRow.createCell(0).setCellValue("Organization");
        headerRow.createCell(1).setCellValue("RollNumber");
        headerRow.createCell(2).setCellValue("Full Name");
        headerRow.createCell(3).setCellValue("Picture");
        headerRow.createCell(4).setCellValue("Gender");
        headerRow.createCell(5).setCellValue("Address");

        int rowIdx = 1;
        for (Users student : students) {
            Row row = sheet.createRow(rowIdx++);
            row.createCell(0).setCellValue(student.getSchoolOrganization().getSchoolname());
            row.createCell(1).setCellValue(student.getRollNumber());
            row.createCell(2).setCellValue(student.getFullname());
            String imagePath = student.getPicture();

            if (imagePath != null) {
                // Create an input stream to read the image
                FileInputStream fis = new FileInputStream("D:\\SpringBootGitHub\\SpringBoot\\Spring Boot\\SchoolManagement\\src\\main\\resources\\static\\images\\" + student.getRollNumber() + ".png");

                // Convert the image to a byte array
                byte[] imageBytes = IOUtils.toByteArray(fis);

                // Create a drawing object
                Drawing<?> drawing = sheet.createDrawingPatriarch();

                // Create an anchor for the image
                ClientAnchor anchor = new XSSFClientAnchor(0, 0, 0, 0, (short) 3, rowIdx - 1, (short) 4, rowIdx);

                // Create an image
                int pictureIndex = workbook.addPicture(imageBytes, Workbook.PICTURE_TYPE_JPEG);
                drawing.createPicture(anchor, pictureIndex);
                fis.close();
            }
            row.createCell(4).setCellValue(student.getGender().getGender());
            row.createCell(5).setCellValue(student.getAddress());
        }
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=EthnicStudent.xlsx");
        workbook.write(response.getOutputStream());
    }


}
