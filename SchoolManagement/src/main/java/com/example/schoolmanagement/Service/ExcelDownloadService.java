package com.example.schoolmanagement.Service;

import com.example.schoolmanagement.Model.*;
import com.example.schoolmanagement.Repository.*;
import io.jsonwebtoken.io.IOException;
import lombok.AllArgsConstructor;
import org.apache.commons.compress.utils.IOUtils;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.usermodel.DataValidationConstraint.ValidationType;
import org.apache.poi.ss.util.CellRangeAddressList;
import org.apache.poi.xssf.usermodel.XSSFClientAnchor;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.data.querydsl.QSort;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
@AllArgsConstructor
public class ExcelDownloadService {
    private final UserRepository userRepository;
    private final StudentTranscriptRepository studentTranscriptRepository;
    private final MarkRepository markRepository;
    private final CityRepository cityRepository;
    private final DistrictRepository districtRepository;
    private final WardRepository wardRepository;
    private final  OrganizationRepository organizationRepository;
    private final GenderRepository genderRepository;
    private final EthnicRepository ethnicRepository;
    private final ReligionRepository religionRepository;
    public void dowloadDeactiveStudentReportForSchoolAdmin(HttpServletResponse response, HttpSession session) throws IOException, java.io.IOException {
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

    public void downloadEthnicStudentReportForSchoolAdmin(String ethnicid, HttpServletResponse response, HttpSession session) throws java.io.IOException {
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

    public void downloadSubjectTeacherReportForSchoolAdmin(String subjectcode, HttpServletResponse response, HttpSession session) throws java.io.IOException {
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

    public void downloadStudentUpClassForSchoolAdmin(HttpServletResponse response, HttpSession session) throws java.io.IOException {
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

    public void dowloadSADeactiveReport(HttpServletResponse response) throws java.io.IOException {
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

    public void downloadSAUpClassReport(HttpServletResponse response) throws java.io.IOException {
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

    public void downloadSASubjectTeacherReport(String subjectcode, HttpServletResponse response) throws java.io.IOException {
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

    public void downloadSAEthnicStudentReport(String ethnicid, HttpServletResponse response) throws java.io.IOException {
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

    public void generateUserTemplate(HttpServletResponse response) throws IOException, java.io.IOException {
        Workbook workbook = new XSSFWorkbook();
        Sheet inputdataSheet = workbook.createSheet("InputData");
        Sheet citySheet = workbook.createSheet("CitySheet");
        List<City> cities = cityRepository.findAll("active");
        Row cityHeaderRow = citySheet.createRow(0);
        cityHeaderRow.createCell(0).setCellValue("Mã");
        cityHeaderRow.createCell(1).setCellValue("Tên");
        int rowIdxCity = 1;
        for (City city : cities){
            Row row = citySheet.createRow(rowIdxCity++);
            row.createCell(0).setCellValue(city.getId());
            row.createCell(1).setCellValue(city.getCityname());
        }
        citySheet.protectSheet("admin");
        Sheet districtSheet = workbook.createSheet("DistrictSheet");
        List<District> districts = districtRepository.findAll("active");
        Row districtHeaderRow = districtSheet.createRow(0);
        districtHeaderRow.createCell(0).setCellValue("Mã");
        districtHeaderRow.createCell(1).setCellValue("Tên");
        districtHeaderRow.createCell(2).setCellValue("Thành phố");
        int rowIdxDistrict = 1;
        for (District district : districts){
            Row row = districtSheet.createRow(rowIdxDistrict++);
            row.createCell(0).setCellValue(district.getId());
            row.createCell(1).setCellValue(district.getDistricname());
            row.createCell(2).setCellValue((district.getCity() != null ? district.getCity().getCityname() : ""));
        }
        districtSheet.protectSheet("admin");
        Sheet wardSheet = workbook.createSheet("WardSheet");
        List<Ward> wards = wardRepository.findAll("active");
        Row wardHeaderRow = wardSheet.createRow(0);
        wardHeaderRow.createCell(0).setCellValue("Mã");
        wardHeaderRow.createCell(1).setCellValue("Tên");
        wardHeaderRow.createCell(2).setCellValue("Mã quận");
        int rowIdxWard = 1;
        for (Ward ward : wards){
            Row row = wardSheet.createRow(rowIdxWard++);
            row.createCell(0).setCellValue(ward.getId());
            row.createCell(1).setCellValue(ward.getWardname());
            row.createCell(2).setCellValue((ward.getDistrict()!= null ? ""+ward.getDistrict().getDistricname(): ""));
        }
        wardSheet.protectSheet("admin");
        Sheet ethnicSheet = workbook.createSheet("EthnicSheet");
        List<Ethnic> ethnics = ethnicRepository.findAll();
        Row ethnicHeaderRow = ethnicSheet.createRow(0);
        ethnicHeaderRow.createCell(0).setCellValue("id");
        ethnicHeaderRow.createCell(1).setCellValue("ethnic");
        int rowIdxEthnic = 1;
        for (Ethnic ethnic : ethnics){
            Row row = ethnicSheet.createRow(rowIdxEthnic++);
            row.createCell(0).setCellValue(ethnic.getId());
            row.createCell(1).setCellValue(ethnic.getEthnic());
        }
        ethnicSheet.protectSheet("admin");
        Sheet religionSheet = workbook.createSheet("ReligionSheet");
        List<Religion> religions = religionRepository.findAll();
        Row religionHeaderRow = religionSheet.createRow(0);
        religionHeaderRow.createCell(0).setCellValue("id");
        religionHeaderRow.createCell(1).setCellValue("religion");
        int rowIdxReligion = 1;
        for (Religion religion : religions){
            Row row = religionSheet.createRow(rowIdxReligion++);
            row.createCell(0).setCellValue(religion.getId());
            row.createCell(1).setCellValue(religion.getReligion());
        }
        religionSheet.protectSheet("admin");
        Sheet genderSheet = workbook.createSheet("GenderSheet");
        List<Gender> genders = genderRepository.findAll();
        Row genderHeaderRow = genderSheet.createRow(0);
        genderHeaderRow.createCell(0).setCellValue("id");
        genderHeaderRow.createCell(1).setCellValue("gender");
        int rowIdxGender = 1;
        for (Gender gender : genders){
            Row row = genderSheet.createRow(rowIdxGender++);
            row.createCell(0).setCellValue(gender.getId());
            row.createCell(1).setCellValue(gender.getGender());
        }
        genderSheet.protectSheet("admin");
        Sheet organizationSheet = workbook.createSheet("OrganizationSheet");
        List<Organization> organizations = organizationRepository.findAll();
        Row organizationHeaderRow = organizationSheet.createRow(0);
        organizationHeaderRow.createCell(0).setCellValue("id");
        organizationHeaderRow.createCell(1).setCellValue("Operatingtime");
        organizationHeaderRow.createCell(2).setCellValue("schoolcode");
        organizationHeaderRow.createCell(3).setCellValue("schoolname");
        organizationHeaderRow.createCell(4).setCellValue("status");
        organizationHeaderRow.createCell(5).setCellValue("ward");
        organizationHeaderRow.createCell(6).setCellValue("wardorganization");
        organizationHeaderRow.createCell(7).setCellValue("wardname");
        int rowIdxOrganization = 1;
        for (Organization organization : organizations){
            Row row = organizationSheet.createRow(rowIdxOrganization++);
            row.createCell(0).setCellValue(organization.getId());
            row.createCell(1).setCellValue(organization.getOperatingday());
            row.createCell(2).setCellValue(organization.getSchoolcode());
            row.createCell(3).setCellValue(organization.getSchoolname());
            row.createCell(4).setCellValue(organization.getStatus());
            row.createCell(5).setCellValue((organization.getWard() != null ? ""+ organization.getWard().getId() : ""));
            row.createCell(6).setCellValue((organization.getWardorganization() != null ? ""+organization.getWardorganization().getId() : ""));
            row.createCell(7).setCellValue((organization.getWardorganization() != null ? organization.getWardorganization().getWard().getWardname() : ""));
        }
        organizationSheet.protectSheet("admin");
        Row headerRow = inputdataSheet.createRow(0);
//        headerRow.createCell(0).setCellValue("City");
        headerRow.createCell(0).setCellValue("RollNumber");
        headerRow.createCell(1).setCellValue("Email");
        headerRow.createCell(2).setCellValue("CCCD");
        headerRow.createCell(3).setCellValue("DayOfBirth(dd/mm/yyyy)");
        headerRow.createCell(4).setCellValue("City");
        headerRow.createCell(5).setCellValue("District");
        headerRow.createCell(6).setCellValue("Ward");
        headerRow.createCell(7).setCellValue("Organization");
        headerRow.createCell(8).setCellValue("Gender");
        headerRow.createCell(9).setCellValue("Ethnic");
        headerRow.createCell(10).setCellValue("Religion");
        headerRow.createCell(11).setCellValue("Error");
        CellStyle redFontColor = workbook.createCellStyle();
        Font redFont = workbook.createFont();
        redFont.setColor(IndexedColors.RED.getIndex());
        redFontColor.setFont(redFont);

        CellStyle textStyle = workbook.createCellStyle();
        DataFormat dataFormat = workbook.createDataFormat();
        textStyle.setDataFormat(dataFormat.getFormat("@"));
        // change color of required cell and text format for cccd cell
        for (int i = 0; i<=11 ; i++){
            if(i < 2 || (i>=3 && i<=7)){
                headerRow.getCell(i).setCellStyle(redFontColor);
            }
        }
        DataValidationHelper dvHelper = inputdataSheet.getDataValidationHelper();
        String formulaCity = "CitySheet!$B$2:$B$65";
        String formulaGender = "GenderSheet!$B$2:$B$4";
        String formulaEthnic = "EthnicSheet!$B$2:$B$57";
        String formulaReligion = "ReligionSheet!$B$2:$B$18";
        DataValidationConstraint constraintCity = dvHelper.createFormulaListConstraint(formulaCity);
        DataValidationConstraint constraintGender = dvHelper.createFormulaListConstraint(formulaGender);
        DataValidationConstraint constraintEthnic = dvHelper.createFormulaListConstraint(formulaEthnic);
        DataValidationConstraint constraintReligion = dvHelper.createFormulaListConstraint(formulaReligion);
        CellRangeAddressList addressListCity = new CellRangeAddressList(1, 199, 4, 4);
        CellRangeAddressList addressListGender = new CellRangeAddressList(1, 199, 8, 8);
        CellRangeAddressList addressListEthnic = new CellRangeAddressList(1, 199, 9, 9);
        CellRangeAddressList addressListReligion = new CellRangeAddressList(1, 199, 10, 10);
        DataValidation cityValidation = dvHelper.createValidation(constraintCity, addressListCity);
        DataValidation genderValidation = dvHelper.createValidation(constraintGender, addressListGender);
        DataValidation ethnicValidation = dvHelper.createValidation(constraintEthnic, addressListEthnic);
        DataValidation religionValidation = dvHelper.createValidation(constraintReligion, addressListReligion);
        inputdataSheet.addValidationData(cityValidation);
        inputdataSheet.addValidationData(genderValidation);
        inputdataSheet.addValidationData(ethnicValidation);
        inputdataSheet.addValidationData(religionValidation);
        for (int i = 1; i<=200; i++){
            //index of row = 1
            Row row = inputdataSheet.createRow(i);
            String formulaDistrict = "OFFSET(DistrictSheet!$B$2, MATCH($E$"+ (i+1)+",DistrictSheet!$C$2:$C$707, 0) - 1, 0, COUNTIF(DistrictSheet!$C$2:$C$707, $E$"+(i+1)+"))";
            String formulaWard = "OFFSET(WardSheet!$B$2, MATCH($F$"+(i+1)+", WardSheet!$C$2:$C$10601, 0) - 1, 0, COUNTIF(WardSheet!$C$2:$C$10601, $F$"+(i+1)+"))";
            String formulaOrganization = "OFFSET(OrganizationSheet!$D$2, MATCH($G$"+(i+1)+",OrganizationSheet!$H$2:$H$10601, 0) - 1, 0, COUNTIF(OrganizationSheet!$H$2:$H$10601, $G$"+(i+1)+"))";
            DataValidationConstraint constraintDistrict = dvHelper.createFormulaListConstraint(formulaDistrict);
            CellRangeAddressList addressListDistrict = new CellRangeAddressList(i, i, 5, 5);
            DataValidation districtValidation = dvHelper.createValidation(constraintDistrict, addressListDistrict);
            DataValidationConstraint constraintWard = dvHelper.createFormulaListConstraint(formulaWard);
            CellRangeAddressList addressListWard = new CellRangeAddressList(i, i, 6, 6);
            DataValidation wardValidation = dvHelper.createValidation(constraintWard, addressListWard);
            DataValidationConstraint constraintOrganization = dvHelper.createFormulaListConstraint(formulaOrganization);
            CellRangeAddressList addressListOrganization = new CellRangeAddressList(i, i, 7, 7);
            DataValidation organizationValidation = dvHelper.createValidation(constraintOrganization, addressListOrganization);
            inputdataSheet.addValidationData(districtValidation);
            inputdataSheet.addValidationData(wardValidation);
            inputdataSheet.addValidationData(organizationValidation);
            row.createCell(2).setCellStyle(textStyle);
        }
        inputdataSheet.setDefaultColumnWidth(17);
        for (int i = 1; i < workbook.getNumberOfSheets(); i++){
            workbook.setSheetHidden(i, true);
        }
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=ImportStudent.xlsx");
        workbook.write(response.getOutputStream());
        workbook.close();
    }
}
