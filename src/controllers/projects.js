// Import any needed model functions
import {
  getAllServiceProjects,
  getProjectDetails,
  getUpcomingProjects,
} from "../models/projects.js";

// Define any controller functions
const showProjectsPage = async (req, res) => {
  const NUMBER_OF_UPCOMING_PROJECTS = 5;
  const projects = await getUpcomingProjects(NUMBER_OF_UPCOMING_PROJECTS);
  const title = "Upcoming Service Projcts";

  res.render("projects", { title, projects });
};

const showProjectDetailsPage = async (req, res) => {
  const projectId = req.params.id;
  const projectDetails = await getProjectDetails(projectId);
  const title = projectDetails.title;

  res.render("project", { title, projectDetails });
};

// Export any controller functions
export { showProjectsPage, showProjectDetailsPage };
