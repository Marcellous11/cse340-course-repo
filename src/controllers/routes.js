import express from "express";

import { showHomePage } from "./index.js";
import {
    showOrganizationsPage,
    showOrganizationDetailsPage,
    showNewOrganizationForm,
    processNewOrganizationForm,
    organizationValidation,
    showEditOrganizationForm,
    processEditOrganizationForm
} from "./organizations.js";
import {
    showProjectDetailsPage,
    showProjectsPage,
    processNewProjectForm,
    showNewProjectForm,
    projectValidation,
    showEditProjectForm,
    processEditProjectForm
} from "./projects.js";
import {
    showCategoriesPage,
    showAssignCategoriesForm,
    processAssignCategoriesForm,
    showNewCategoryForm,
    processNewCategoryForm,
    showEditCategoryForm,
    processEditCategoryForm,
    categoryValidation
} from "./categories.js";
import {
    showUserRegistrationForm,
    processUserRegistrationForm,
    showLoginForm,
    processLoginForm,
    processLogout,
    requireLogin,
    requireRole,
    showDashboard,
    showUsersPage
} from "./users.js";
import { testErrorPage } from "./errors.js";


const router = express.Router();

router.get("/", showHomePage);
router.get("/register", showUserRegistrationForm);
router.post("/register", processUserRegistrationForm);
// User login routes
router.get("/login", showLoginForm);
router.post("/login", processLoginForm);
router.get("/logout", processLogout);
// Protected dashboard route
router.get("/dashboard", requireLogin, showDashboard);
router.get(
    "/users",
    requireLogin,
    requireRole("admin", { forbiddenRedirect: "/dashboard" }),
    showUsersPage
);
router.get("/organizations", showOrganizationsPage);
router.get("/organization/:id", showOrganizationDetailsPage);
router.get("/new-organization", requireRole("admin"), showNewOrganizationForm);
router.post(
    "/new-organization",
    requireRole("admin"),
    organizationValidation,
    processNewOrganizationForm
);
router.get("/edit-organization/:id", requireRole("admin"), showEditOrganizationForm);
router.post(
    "/edit-organization/:id",
    requireRole("admin"),
    organizationValidation,
    processEditOrganizationForm
);
router.get("/projects", showProjectsPage);
router.get("/project/:id", showProjectDetailsPage);
router.get("/new-project", requireRole("admin"), showNewProjectForm);
router.post(
    "/new-project",
    requireRole("admin"),
    projectValidation,
    processNewProjectForm
);
router.get("/edit-project/:id", requireRole("admin"), showEditProjectForm);
router.post(
    "/edit-project/:id",
    requireRole("admin"),
    projectValidation,
    processEditProjectForm
);
router.get("/categories", showCategoriesPage);
router.get("/new-category", requireRole("admin"), showNewCategoryForm);
router.post(
    "/new-category",
    requireRole("admin"),
    categoryValidation,
    processNewCategoryForm
);
router.get("/edit-category/:id", requireRole("admin"), showEditCategoryForm);
router.post(
    "/edit-category/:id",
    requireRole("admin"),
    categoryValidation,
    processEditCategoryForm
);
router.get(
    "/assign-categories/:projectId",
    requireRole("admin"),
    showAssignCategoriesForm
);
router.post(
    "/assign-categories/:projectId",
    requireRole("admin"),
    processAssignCategoriesForm
);


// error-handling routes
router.get("/test-error", testErrorPage);

export default router;