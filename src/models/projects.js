import db from "./db.js";

const getAllServiceProjects = async() => {
    const query = `
        SELECT organizations.name, service_projects.title, service_projects.description, service_projects.location, service_projects.project_date, service_projects.created_at
        FROM public.service_projects
        LEFT JOIN public.organizations 
        ON organizations.organization_id = service_projects.organization_id;
    `;

    const result = await db.query(query);
    return result.rows;
};

const getProjectsByOrganizationId = async (organizationId) => {
      const query = `
        SELECT
          project_id,
          organization_id,
          title,
          description,
          location,
          project_date
        FROM service_projects
        WHERE organization_id = $1
        ORDER BY project_date;
      `;
      
      const query_params = [organizationId];
      const result = await db.query(query, query_params);

      return result.rows;
};

// Export the model functions
export { getAllServiceProjects, getProjectsByOrganizationId };