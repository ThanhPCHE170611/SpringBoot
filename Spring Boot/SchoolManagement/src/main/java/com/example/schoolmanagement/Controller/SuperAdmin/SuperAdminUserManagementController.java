package com.example.schoolmanagement.Controller.SuperAdmin;


import com.example.schoolmanagement.Model.*;
import com.example.schoolmanagement.Model.Class;
import com.example.schoolmanagement.Model.Error;
import com.example.schoolmanagement.Repository.*;
import com.example.schoolmanagement.Service.SuperAdminUserManagementService;
import lombok.AllArgsConstructor;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.util.*;

@Controller
@AllArgsConstructor
public class SuperAdminUserManagementController {

    private final SuperAdminUserManagementService superAdminUserManagementService;
    private final GenderRepository genderRepository;
    private final ReligionRepository religionRepository;
    private final EthnicRepository ethnicRepository;
    private final RoleRepository roleRepository;
    private final OrganizationRepository organizationRepository;
    private final ClassRepository classRepository;
    private final PasswordEncoder passwordEncoder;
    private final ImportUserHistoryRepository importUserHistoryRepository;
    private final UserRepository userRepository;
    private final CityRepository cityRepository;
    private final DistrictRepository districtRepository;
    private final WardRepository wardRepository;

    @GetMapping(path = "/superadmin/usermanagement")
    public String viewUserManagementPage(HttpSession session, Model model,
                                         @RequestParam(value = "page", defaultValue = "0") int page,
                                         @RequestParam(value = "size", defaultValue = "25") int pageSize,
                                         @RequestParam(name = "filterUsername", required = false) String filterUsername,
                                         @RequestParam(name = "filterEmail", required = false) String filterEmail,
                                         @RequestParam(name = "filterFullName", required = false) String filterFullname,
                                         @RequestParam(name = "filterRole", required = false) Long filterRole,
                                         @RequestParam(name = "filterGender", required = false) Long filterGender,
                                         @RequestParam(name = "filterEthnic", required = false) Long filterEthnic,
                                         @RequestParam(name = "filterReligion", required = false) Long filterReligion,
                                         @RequestParam(name = "filterOrganization", required = false) Long filterOrganization) {

        if (session.getAttribute("user") == null) {
            return "redirect:/auth/login";
        } else {
            Page<Users> users = null;
            Specification<Users> spec = Specification.where(null);
            if (filterUsername != null && !filterUsername.isEmpty()) {
                spec = spec.and((root, query, criteriaBuilder) ->
                        criteriaBuilder.like(root.get("username"), "%" + filterUsername + "%")
                );
            }
            else if(filterEmail != null && !filterEmail.isEmpty()){
                spec = spec.and((root, query, criteriaBuilder) ->
                        criteriaBuilder.like(root.get("email"), "%" + filterEmail + "%")
                );
            }
            else if(filterFullname != null && !filterFullname.isEmpty()){
                spec = spec.and((root, query, criteriaBuilder) ->
                        criteriaBuilder.like(root.get("fullname"), "%" + filterFullname + "%")
                );
            }
            else if (filterRole != null && filterRole > 0) {
                Role filterRoleObj = roleRepository.findById(filterRole).get();
                spec = spec.and((root, query, criteriaBuilder) -> {
                    return criteriaBuilder.isMember(filterRoleObj, root.get("roles"));
                });
            } else if (filterGender != null && filterGender > 0) {
                spec = spec.and((root, query, criteriaBuilder) ->
                        criteriaBuilder.equal(root.get("gender").get("Id"), filterGender)
                );
            } else if (filterEthnic != null && filterEthnic > 0) {
                spec = spec.and((root, query, criteriaBuilder) ->
                        criteriaBuilder.equal(root.get("ethnic").get("Id"), filterEthnic)
                );
            } else if (filterReligion != null && filterReligion > 0) {
                spec = spec.and((root, query, criteriaBuilder) ->
                        criteriaBuilder.equal(root.get("religions").get("Id"), filterReligion)
                );
            } else if (filterOrganization != null && filterOrganization > 0) {
                spec = spec.and((root, query, criteriaBuilder) ->
                        criteriaBuilder.equal(root.get("schoolOrganization").get("Id"), filterOrganization)
                );
            } else {
                users = superAdminUserManagementService.getUsers(page, pageSize);
            }
            users = superAdminUserManagementService.getUsersWithCriteria(spec, PageRequest.of(page, pageSize));
            List<Role> roles = roleRepository.findAll();
            List<Gender> genders = genderRepository.findAll();
            List<Ethnic> ethnics = ethnicRepository.findAll();
            List<Religion> religions = religionRepository.findAll();
            List<Organization> organizations = organizationRepository.findAll("active");

            model.addAttribute("users", users);
            model.addAttribute("roles", roles);
            model.addAttribute("genders", genders);
            model.addAttribute("ethnics", ethnics);
            model.addAttribute("religions", religions);
            model.addAttribute("organizations", organizations);

            // Add the filter criteria to the model to repopulate the filter form
            model.addAttribute("filterUsername", filterUsername);
            model.addAttribute("filterEmail", filterEmail);
            model.addAttribute("filterFullname", filterFullname);
            model.addAttribute("filterRole", filterRole);
            model.addAttribute("filterGender", filterGender);
            model.addAttribute("filterEthnic", filterEthnic);
            model.addAttribute("filterReligion", filterReligion);
            model.addAttribute("filterOrganization", filterOrganization);
            return "superadminusermanagement";
        }
    }

    @GetMapping("/superadmin/usermanagement/deleteuser/{rollnumber}")
    public String deleteUser(@PathVariable String rollnumber, HttpSession session, Model model){
        if(session.getAttribute("user") == null){
            return "redirect:/auth/login";
        } else {
            superAdminUserManagementService.deleteUser(rollnumber);
            return "redirect:/superadmin/usermanagement";
        }
    }

    @GetMapping("/superadmin/usermanagement/update/{rollnumber}")
    public String ViewFormUpdateUser(@PathVariable String rollnumber, HttpSession session, Model model){
        Users users = userRepository.findById(rollnumber).get();
        List<Gender> genders = genderRepository.findAll();
        List<Ethnic> ethnics = ethnicRepository.findAll();
        List<Religion> religions = religionRepository.findAll();
        List<Role> allRoles = roleRepository.findAll();
        List<City> cities = cityRepository.findAll("active");
        List<District> districts = districtRepository.findAll("active");
        List<Ward> wards = wardRepository.findAll("active");
        List<Organization> organizations = organizationRepository.findAllByWardAndStatus(users.getSchoolOrganization().getWardorganization().getId(), "active");
        List<Role> roles = new ArrayList<>();
        for (Role role : allRoles){
            if(!role.getRolename().equals("superadmin")){
                roles.add(role);
            }
        }
        boolean isstudent = false, isteacher = false, isschooladmin = false;
        for (Role role : users.getRoles()){
            if(role.getRolename().equals("student")){
                isstudent = true;
                model.addAttribute("isttudent", true);
            } else if(role.getRolename().equals("teacher")){
                isteacher = true;
                model.addAttribute("isteacher", true);
            } else if (role.getRolename().equals("schooladmin")){
                isschooladmin = true;
                model.addAttribute("isschooladmin", true);
            }
        }
        //split student class and teacher class:
        //each teacher just responsibility for one class
        //each class just have 50 students max
        List<Class> classes = classRepository.findAllByclassOrganization(users.getSchoolOrganization());
        List<Class> studentClass = new ArrayList<>();
        List<Class> teacherClass  = new ArrayList<>();
        model.addAttribute("genders", genders);
        model.addAttribute("ethnics", ethnics);
        model.addAttribute("religions", religions);
        model.addAttribute("roles", roles);
        model.addAttribute("user", users);
        for (Class aClass : classes){
            if(userRepository.findAllBystudentclass(aClass.getId(), "active").size()<50 || (isstudent && aClass.getId() == users.getStudentclass().getId())){
                studentClass.add(aClass);
            }
            if(userRepository.findAllByteacherclass(aClass.getId(), "active").isEmpty() || (isteacher && users.getTeacherclass()!=null && aClass.getId() == users.getTeacherclass().getId())){
                teacherClass.add(aClass);
            }
        }
        model.addAttribute("cities", cities);
        model.addAttribute("districts", districts);
        model.addAttribute("wards", wards);
        model.addAttribute("organizations", organizations);
        model.addAttribute("studentclass", studentClass);
        model.addAttribute("teacherclass", teacherClass);
        return "superadminupdateuser";
    }

    @PostMapping(path = "/superadmin/usermanagement/update")
    public String updateUser(@RequestParam String rollnumber, @RequestParam String email,
                             @RequestParam(name = "picture", required = false) MultipartFile picture,
                             @RequestParam("fullname") String fullname, @RequestParam String status,
                             @RequestParam(name="organization", required = false) Long organization,
                             @RequestParam List<Long> roles, @RequestParam(name="studentclass", required = false) Long studentclass,
                             @RequestParam(name="teacherclass", required = false) Long teacherclass,
                             @RequestParam("password") String newpassword, @RequestParam(name="gender") Long gender, @RequestParam("ethnic") Long ethnic, @RequestParam("religion") Long religion,
                             @RequestParam("parrentname") String parrentname, @RequestParam("address") String address, @RequestParam("hometown") String hometown,
                             @RequestParam(name = "hobbies", required = false) String hobbies, HttpSession session, Model model){
        //check if student want to update profile picture:
        //get the current information:
        boolean canUpdate = true;
        Users users = userRepository.findById(rollnumber).get();
        if(!isFullNameValid(fullname)){
            canUpdate = false;
            model.addAttribute("error", "Wrong fullname format!");
            return ViewFormUpdateUser(rollnumber, session, model);
        }
        if(!isEmailValid(email)){
            canUpdate = false;
            model.addAttribute("error", "Wrong email format!");
            return ViewFormUpdateUser(rollnumber, session, model);
        }
        if(userRepository.findUsersByEmail(email).isPresent() && !userRepository.findUsersByEmail(email).get().getEmail().equals(email)){
            canUpdate = false;
            model.addAttribute("error", "Email is exist!");
            return ViewFormUpdateUser(rollnumber, session, model);
        }
        if(!status.equals("active") && !status.equals("deactive")){
            canUpdate = false;
            model.addAttribute("error", "Status must be active or deactive!");
            return ViewFormUpdateUser(rollnumber, session, model);
        }
        if(organization == null ){
            canUpdate = false;
            model.addAttribute("error", "You must select the organization of user!" );
            return ViewFormUpdateUser(rollnumber, session, model);
        }
        if(!isPasswordValid(newpassword)){
            canUpdate = false;
            model.addAttribute("error", "Wrong new password format!");
            return ViewFormUpdateUser(rollnumber, session, model);
        }
        if(!isFullNameValid(parrentname)){
            canUpdate = false;
            model.addAttribute("error", "Wrong parrent name format!");
            return ViewFormUpdateUser(rollnumber, session, model);
        }
        if(!isAddressValid(address)){
            canUpdate = false;
            model.addAttribute("error", "Wrong address format!");
            return ViewFormUpdateUser(rollnumber, session, model);
        }
        if(!isAddressValid(hometown)){
            canUpdate = false;
            model.addAttribute("error", "Wrong home town format!");
            return ViewFormUpdateUser(rollnumber, session, model);
        }
        if(roles.isEmpty()){
            canUpdate = false;
            model.addAttribute("error", "Please select at least one roles!");
            return ViewFormUpdateUser(rollnumber, session, model);
        }
        //Update without picture
        if(canUpdate && picture.isEmpty()){
            superAdminUserManagementService.updateUserWithoutPicture(session,users ,fullname, newpassword, gender, ethnic, religion, parrentname, address, hometown, hobbies, status, roles, studentclass, teacherclass, email, organization);
            model.addAttribute("error", "Update information successfully!");
            return viewUserManagementPage(session, model, 0, 25, null, null, null, null, null, null, null, null);
        }// update avatar
        else if(canUpdate && !picture.isEmpty()){
            superAdminUserManagementService.updateStudentWithPicture(picture, session,users ,fullname, newpassword, gender, ethnic, religion, parrentname, address, hometown, hobbies, status, roles, studentclass, teacherclass, email, organization);
            model.addAttribute("error", "Update information successfully!");
            return viewUserManagementPage(session, model, 0, 25, null, null, null, null, null, null, null, null);

        }
        return viewUserManagementPage(session, model, 0, 25, null, null, null, null, null, null, null, null);

    }
    private boolean isFullNameValid(String fullName) {
        return fullName.matches("^[\\p{L}\\s]+$");
    }
    private boolean isPasswordValid(String password){
        return password.matches("^[^\\p{L}\\s]*$");
    }
    private boolean isAddressValid(String address){
        return address.matches("^[\\p{L}\\d\\s,./-]+$");
    }

    private boolean isEmailValid(String email){
        return email.matches("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$");
    }
    private boolean isRollNumberValid(String rollNumber){
        return rollNumber.matches("^(ha|se|he)[a-zA-Z0-9_]{4}$");
    }

    @GetMapping("/superadmin/usermanagement/adduser")
    public String viewFormAddUser(HttpSession session, Model model){
        if(session.getAttribute("user") == null){
            return "redirect:/auth/login";
        } else {
            List<Gender> genders = genderRepository.findAll();
            List<Ethnic> ethnics = ethnicRepository.findAll();
            List<Religion> religions = religionRepository.findAll();
            List<Role> allRoles = roleRepository.findAll();
            List<City> cities = cityRepository.findAll("active");
            List<District> districts = districtRepository.findAll("active");
            List<Ward> wards = wardRepository.findAll("active");
            List<Organization> organizations = organizationRepository.findAll("active");
            List<Role> roles = new ArrayList<>();
            for (Role role : allRoles){
                if(!role.getRolename().equals("superadmin")){
                    roles.add(role);
                }
            }
            model.addAttribute("genders", genders);
            model.addAttribute("ethnics", ethnics);
            model.addAttribute("religions", religions);
            model.addAttribute("roles", roles);
            model.addAttribute("cities", cities);
            model.addAttribute("districts", districts);
            model.addAttribute("wards", wards);
            model.addAttribute("organizations", organizations);
            return "superadminadduser";
        }
    }

    @PostMapping(path = "/superadmin/usermanagement/adduser")
    public String createUser(@RequestParam String rollnumber, @RequestParam String email,
                             @RequestParam String username, @RequestParam String password,
                             @RequestParam Long organization, @RequestParam List<Long> roles,
                             @RequestParam(name="gender") Long gender, @RequestParam("ethnic") Long ethnic, @RequestParam("religion") Long religion,
                             HttpSession session, Model model){
        boolean canAdd = true;
        if(!isRollNumberValid(rollnumber)){
            canAdd = false;
            model.addAttribute("error", "RollNumber is invalid!\nThe format is ha|se|he and 4 number\nExample:ha0000");
            return viewFormAddUser(session, model);
        }
        if(userRepository.findById(rollnumber).isPresent()){
            canAdd = false;
            model.addAttribute("error", "RollNumber is dupplicate!");
            return viewFormAddUser(session, model);
        }
        if(!username.matches("^[a-zA-Z][a-zA-Z0-9_]{2,14}$")){
            canAdd = false;
            model.addAttribute("error", "Username is invalid!");
            return viewFormAddUser(session, model);
        }
        if(userRepository.findUsersByUsername(username).isPresent()){
            canAdd = false;
            model.addAttribute("error", "Username is dupplicate!");
            return viewFormAddUser(session, model);
        }
        if(!isEmailValid(email)){
            canAdd = false;
            model.addAttribute("error", "Email is invalid!");
            return viewFormAddUser(session, model);
        }
        if(userRepository.findUsersByEmail(email).isPresent()){
            canAdd = false;
            model.addAttribute("error", "Email is dupplicate!");
            return viewFormAddUser(session, model);
        }
        if(organization == null){
            canAdd = false;
            model.addAttribute("error", "Please select the organization, If dont see the organization, create more in Organization Management!");
            return viewFormAddUser(session, model);
        }
        if(roles == null){
            canAdd = false;
            model.addAttribute("error", "Please select at least one role!");
            return viewFormAddUser(session, model);
        }
        if(canAdd){
            Set<Role> roleSet = new HashSet<>();
            for (Long role : roles){
                roleSet.add(roleRepository.findById(role).get());
            }
            Users newUser = new Users(rollnumber, username, email, passwordEncoder.encode(password), genderRepository.findById(gender).get(), religionRepository.findById(religion).get(), ethnicRepository.findById(ethnic).get(), roleSet, organizationRepository.findById(organization).get());
            superAdminUserManagementService.addUser(newUser);
            model.addAttribute("error", "Add user success, please update user information soon!");
            return viewUserManagementPage(session, model, 0, 25, null, null, null, null, null, null, null, null);
        }
        return viewUserManagementPage(session, model, 0, 25, null, null, null, null, null, null, null, null);
    }

    @GetMapping("/superadmin/usermanagement/adduserbyexcel")
    public String viewImportByExcelPage(HttpSession session, Model model,  @RequestParam(value = "page", defaultValue = "0") int page,
                                        @RequestParam(value = "size", defaultValue = "5") int size){
        if(session.getAttribute("user") == null){
            return "redirect:/auth/login";
        } else {
            Users author =(Users) session.getAttribute("user");
            Pageable pageable = PageRequest.of(page, size);
            Page<ImportUserHistory> historyList = importUserHistoryRepository.findImportUserHistoriesByAuthor(author, pageable);
            model.addAttribute("historyList", historyList);
            model.addAttribute("page", page);
            model.addAttribute("size", size);
            return "superadminimportuserbyexcel";
        }
    }

    @PostMapping("/superadmin/exceldownload/uploaduser")
    public String testFile(@RequestParam("file") MultipartFile file, HttpServletResponse response, HttpSession session, Model model) throws io.jsonwebtoken.io.IOException {
        try (Workbook workbook = new XSSFWorkbook(file.getInputStream())){
            List<Users> newUserList = new ArrayList<>();
            List<String> emailList = new ArrayList<>();
            List<String> CCCDList = new ArrayList<>();
            List<String> rollNumberList = new ArrayList<>();
            Sheet inputDataSheet = workbook.getSheetAt(0);

            int lastDataRow = 200;
            // Get require data from file to validate dupplicate in file
            for (int i = 1; i<= inputDataSheet.getLastRowNum(); i++){
                if (inputDataSheet.getRow(i).getCell(0) == null) {
                    if (inputDataSheet.getRow(i).getCell(1) == null) {
                        if (inputDataSheet.getRow(i).getCell(2).getStringCellValue().equals("")) {
                            if (inputDataSheet.getRow(i).getCell(3) == null) {
                                if (inputDataSheet.getRow(i).getCell(4)==null) {
                                    if (inputDataSheet.getRow(i).getCell(5)==null) {
                                        if (inputDataSheet.getRow(i).getCell(6)==null) {
                                            if (inputDataSheet.getRow(i).getCell(7)==null) {
                                                if (inputDataSheet.getRow(i).getCell(8)==null) {
                                                    if (inputDataSheet.getRow(i).getCell(9)==null) {
                                                        if (inputDataSheet.getRow(i).getCell(10)==null) {
                                                            lastDataRow = i;
                                                            break;
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            for (int i = 1; i< lastDataRow; i++){
                if(inputDataSheet.getRow(i).getCell(0) != null){
                    Cell rollNumber = inputDataSheet.getRow(i).getCell(0);
                    rollNumberList.add(rollNumber.getCellType() == CellType.STRING ? rollNumber.getStringCellValue() : String.valueOf(rollNumber.getNumericCellValue()));
                }
                if (inputDataSheet.getRow(i).getCell(1) != null){
                    Cell email = inputDataSheet.getRow(i).getCell(1);
                    emailList.add(email.getCellType() == CellType.STRING ? email.getStringCellValue() : String.valueOf(email.getNumericCellValue()));
                }
                if(inputDataSheet.getRow(i).getCell(2) != null){
                    Cell cccd = inputDataSheet.getRow(i).getCell(2);
                    CCCDList.add(cccd.getCellType() == CellType.STRING ? cccd.getStringCellValue() : String.valueOf(cccd.getNumericCellValue()));
                }
            }
            List<com.example.schoolmanagement.Model.Error> errorTotal = new ArrayList<>();
            for (int i = 1; i < lastDataRow; i++) {
                StringBuilder errorInRow = new StringBuilder("");
                Row row = inputDataSheet.getRow(i);
                // Perform validation for each row and update the "Error" column
                Users newStudent =  validateAndHandleErrors(row, errorInRow, rollNumberList, emailList, CCCDList);
                if(!errorInRow.toString().equals("")){
                    errorTotal.add(new Error(errorInRow.toString(), (i+1)));
                }
                if(newStudent != null){
                    newUserList.add(newStudent);
                }
            }
            //  have error in file import, accepted for download one more time with old data!
            Users author = (Users) session.getAttribute("user");
            Date currentDate = new Date(System.currentTimeMillis());
            ImportUserHistory newImportUserHistory = null;
            if(!errorTotal.isEmpty()){
                System.out.println("failed");
                //find history by author and date -> if have one and status = fail (update history) -> rewrite file in resources by path,
                newImportUserHistory = superAdminUserManagementService.createNewInportUserHistory(author, currentDate, errorTotal);
                    //temp file of history will be store in db by path
                    //write temp file to resources
                String path = "D:/SpringBootGitHub/SpringBoot/Spring Boot/SchoolManagement/src/main/resources/static/excelfiles/" + author.getRollNumber() + "_" + currentDate + "_" + newImportUserHistory.getId()+".xlsx";
                superAdminUserManagementService.writeExcelFile(workbook, path);
                return "redirect:/superadmin/usermanagement/adduserbyexcel";
                //if user click in name of history, it will download file
            } else {
                System.out.println("success");
                newImportUserHistory = superAdminUserManagementService.createNewInportUserHistory(author, currentDate, errorTotal);
                // not have any error in file
                String path = "D:/SpringBootGitHub/SpringBoot/Spring Boot/SchoolManagement/src/main/resources/static/excelfiles/" + author.getRollNumber() + "_" + currentDate + "_" + newImportUserHistory.getId()+".xlsx";
                superAdminUserManagementService.writeExcelFile(workbook, path);
                superAdminUserManagementService.saveAllUser(newUserList, newImportUserHistory);
                System.out.println("save success");
                // update status = success, remove error log
                // save all student in db, set new student to history student list
            }
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (IOException e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
        return viewImportByExcelPage(session, model, 0 , 5);
    }
    private Users validateAndHandleErrors(Row row, StringBuilder errorInRow, List<String> rollNumberList, List<String> emailList, List<String> CCCDList) throws io.jsonwebtoken.io.IOException {
        Users newUser = null;
        boolean check = true;
        //Get Data
        Cell cccd = row.getCell(2);
        Cell dayOfBirth = row.getCell(3); //required
        Cell rollNumber = row.getCell(0); //required
        Cell organization = row.getCell(7); //required
        Cell email = row.getCell(1); //required
        Cell gender = row.getCell(8);
        Cell ethnic = row.getCell(9);
        Cell religion = row.getCell(10);
        //Validate:
        //check all require field is not null
        if(organization == null || rollNumber== null || dayOfBirth== null ||
                email == null){
            errorInRow.append("All required(red) cell must not be empty.\n");
            row.createCell(11).setCellValue(errorInRow.toString());
            check = false;
        }
        if(organization != null){
            if(!organizationRepository.findOrganizationBySchoolname(organization.getCellType() == CellType.STRING ? organization.getStringCellValue() : String.valueOf(organization.getNumericCellValue())).isPresent()){
                errorInRow.append("Organization is not exist.\n");
                row.createCell(11).setCellValue(errorInRow.toString());
                check = false;
            }
        }
        // validate for rollnumber: in correct format, not dupplicate in file and in db
        if(rollNumber != null){
            if(!isRollNumberValid(rollNumber.getCellType() == CellType.STRING ? rollNumber.getStringCellValue() : String.valueOf(rollNumber.getNumericCellValue()))){
                errorInRow.append("RollNumber is invalid.\n");
                row.createCell(11).setCellValue(errorInRow.toString());
                check = false;
            }
            else if(isRollNumberDupplicateInFile(rollNumberList, rollNumber.getCellType() == CellType.STRING ? rollNumber.getStringCellValue() : String.valueOf(rollNumber.getNumericCellValue()))){
                errorInRow.append("RollNumber is dupplicate in file.\n");
                row.createCell(11).setCellValue(errorInRow.toString());
                check = false;
            }
            else if(userRepository.findById(rollNumber.getStringCellValue()).isPresent()){
                errorInRow.append("RollNumber is dupplicate with student in Database.\n");
                row.createCell(11).setCellValue(errorInRow.toString());
                check = false;
            }
        }
        // validate for email: in correct format, not dupplicate in file and in db
        if(email != null ){
            if(!isEmailValid((email.getCellType() == CellType.STRING ? email.getStringCellValue() : String.valueOf(email.getNumericCellValue())))){
                errorInRow.append("Email is invalid.\n");
                row.createCell(11).setCellValue(errorInRow.toString());
                check = false;
            }
            else if(isEmailDupplicateInFile(emailList, (email.getCellType() == CellType.STRING ? email.getStringCellValue() : String.valueOf(email.getNumericCellValue())))){
                errorInRow.append("Email is dupplicate in file.\n");
                row.createCell(11).setCellValue(errorInRow.toString());
                check = false;
            }
            else if(userRepository.findUsersByEmail((email.getCellType() == CellType.STRING ? email.getStringCellValue() : String.valueOf(email.getNumericCellValue()))).isPresent()){
                errorInRow.append("Email is dupplicate with student in Database.\n");
                row.createCell(11).setCellValue(errorInRow.toString());
                check = false;
            }
        }
        // validate for cccd: in correct format, not dupplicate in file and in db
        if(cccd != null){
            if(!isCCCDValid((cccd.getCellType() == CellType.STRING ? cccd.getStringCellValue() : String.valueOf(cccd.getNumericCellValue())))){
                errorInRow.append("CCCD is invalid.\n");
                row.createCell(11).setCellValue(errorInRow.toString());
                check = false;
            }
            else if(isCCCDDupplicateInFile(CCCDList, (cccd.getCellType() == CellType.STRING ? cccd.getStringCellValue() : String.valueOf(cccd.getNumericCellValue())))){
                errorInRow.append("CCCD is dupplicate in file.\n");
                row.createCell(11).setCellValue(errorInRow.toString());
                check = false;
            }
            else if(userRepository.findUsersByCccd((cccd.getCellType() == CellType.STRING ? cccd.getStringCellValue() : String.valueOf(cccd.getNumericCellValue()))).isPresent()){
                errorInRow.append("CCCD is dupplicate with student in Database.\n");
                row.createCell(11).setCellValue(errorInRow.toString());
                check = false;
            }
        }
        // validate format of dayOfBirth: dd/mm/yyyy
        if(dayOfBirth != null){
            if(!isValidDayOfBirth((dayOfBirth.getCellType() == CellType.STRING ? dayOfBirth.getStringCellValue() : String.valueOf(dayOfBirth.getNumericCellValue())))){
                errorInRow.append("Day of birth is invalid.\n");
                row.createCell(11).setCellValue(errorInRow.toString());
                check = false;
            }
        }
        if(gender != null){
            if(!genderRepository.findGenderByGender((gender.getCellType() == CellType.STRING ? gender.getStringCellValue() : String.valueOf(gender.getNumericCellValue()))).isPresent()){
                errorInRow.append("Gender is not exist.\n");
                row.createCell(11).setCellValue(errorInRow.toString());
                check = false;
            }
        }
        if(ethnic != null){
            if(!ethnicRepository.findEthnicByEthnic((ethnic.getCellType() == CellType.STRING ? ethnic.getStringCellValue() : String.valueOf(ethnic.getNumericCellValue()))).isPresent()){
                errorInRow.append("Ethnic is not exist.\n");
                row.createCell(11).setCellValue(errorInRow.toString());
                check = false;
            }
        }
        if(religion != null){
            if(!religionRepository.findReligionByReligion((religion.getCellType() == CellType.STRING ? religion.getStringCellValue() : String.valueOf(religion.getNumericCellValue()))).isPresent()){
                errorInRow.append("Religion is not exist.\n");
                row.createCell(11).setCellValue(errorInRow.toString());
                check = false;
            }
        }
        if(check){
            //get data
            Organization schoolOrganization = organizationRepository.findOrganizationBySchoolname(organization.getCellType() == CellType.STRING ? organization.getStringCellValue() : String.valueOf(organization.getNumericCellValue())).get();
            String rollNumberStr = (rollNumber.getCellType() == CellType.STRING ? rollNumber.getStringCellValue() : String.valueOf(rollNumber.getNumericCellValue()));
            String emailStr = (email.getCellType() == CellType.STRING ? email.getStringCellValue() : String.valueOf(email.getNumericCellValue()));
            String cccdStr = (cccd.getCellType() == CellType.STRING ? cccd.getStringCellValue() : String.valueOf(cccd.getNumericCellValue()));
            String dobStr = (dayOfBirth.getCellType() == CellType.STRING ? dayOfBirth.getStringCellValue() : String.valueOf(dayOfBirth.getNumericCellValue()));
            Gender genderObj = genderRepository.findGenderByGender((gender.getCellType() == CellType.STRING ? gender.getStringCellValue() : String.valueOf(gender.getNumericCellValue()))).get();
            Ethnic ethnicObj = ethnicRepository.findEthnicByEthnic((ethnic.getCellType() == CellType.STRING ? ethnic.getStringCellValue() : String.valueOf(ethnic.getNumericCellValue()))).get();
            Religion religionObj = religionRepository.findReligionByReligion((religion.getCellType() == CellType.STRING ? religion.getStringCellValue() : String.valueOf(religion.getNumericCellValue()))).get();
            // auto generate username and password
            String username = rollNumberStr + cccdStr.substring(cccdStr.length()-6); ;
            String password = passwordEncoder.encode("1234@");
            Role role = roleRepository.findById((long) 1).get();
            newUser = new Users(rollNumberStr, emailStr, cccdStr, dobStr, genderObj, ethnicObj, religionObj, username, password, schoolOrganization, role);
        }
        return newUser;
    }

    private boolean isValidDayOfBirth(String s) {
        return s.matches("^(0[1-9]|[12][0-9]|3[01])[/](0[1-9]|1[012])[- /.](19|20)\\d\\d$");
    }

    private boolean isCCCDDupplicateInFile(List<String> cccdList, String s) {
        long count = cccdList.stream()
                .filter(cccd -> cccd.equalsIgnoreCase(s))
                .count();
        return count > 1;
    }

    private boolean isCCCDValid(String s) {
        return s.matches("^[0-9_]{12}$");
    }

    private boolean isEmailDupplicateInFile(List<String> emailList, String s) {
        for (String email : emailList){
            System.out.println(email);
        }
        System.out.println(s);
        long count = emailList.stream()
                .filter(email -> email.equalsIgnoreCase(s))
                .count();
        return count > 1;
    }

    private boolean isRollNumberDupplicateInFile(List<String> rollNumberList, String s) {
        long count = rollNumberList.stream()
                .filter(rollNumber -> rollNumber.equalsIgnoreCase(s))
                .count();
        return count > 1;
    }

    @GetMapping("/superadmin/usermanagement/historydetail/{id}")
    public String excelUploadUserHistoryDetails(@PathVariable Long id, HttpSession session, Model model){
        if(session.getAttribute("user") == null){
            return "redirect:/auth/login";
        } else {
            ImportUserHistory history = importUserHistoryRepository.findById(id).get();
            model.addAttribute("history", history);
            return "superadminimportuserbyexceldetail";
        }
    }

    @GetMapping("/superadmin/usermanagement/historydetail/downloadtempfile/{id}")
    public void downloadTempFile(@PathVariable Long id, HttpServletResponse response) throws IOException {
        ImportUserHistory history = importUserHistoryRepository.findById(id).get();
        String path = "D:/SpringBootGitHub/SpringBoot/Spring Boot/SchoolManagement/src/main/resources/static" + history.getPath();
        superAdminUserManagementService.downloadTempFile(path, response);
    }


}
