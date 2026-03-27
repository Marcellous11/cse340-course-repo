import db from "./db.js";

const getAllServiceProjects = async () => {
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
        FROM public.service_projects
        WHERE organization_id = $1
        ORDER BY project_date;
      `;

  const query_params = [organizationId];
  const result = await db.query(query, query_params);

  return result.rows;
};

const getUpcomingProjects = async (number_of_projects) => {
  const query = `
    SELECT
        service_projects.project_id,
        service_projects.title,
        service_projects.description,
        service_projects.project_date,
        service_projects.location,
        organizations.organization_id,
        organizations.name
    FROM public.service_projects
    LEFT JOIN public.organizations
    ON service_projects.organization_id = organizations.organization_id
    ORDER BY service_projects.project_date DESC
    LIMIT $1
    `;
  const query_params = [number_of_projects];
  const results = await db.query(query, query_params);

  return results.rows;
};

const getProjectDetails = async (id) => {
  const query = `
    SELECT
        service_projects.project_id,
        service_projects.title,
        service_projects.description,
        service_projects.project_date,
        service_projects.location,
        organizations.organization_id,
        organizations.name
    FROM public.service_projects
    LEFT JOIN public.organizations
    ON service_projects.organization_id = organizations.organization_id
    WHERE service_projects.project_id = $1
    `;
  const query_params = [id];
  const results = await db.query(query, query_params);

  return results.rows.length > 0 ? results.rows[0] : null;
};

const createProject = async (title, description, location, date, organizationId) => {
    const query = `
      INSERT INTO service_projects (title, description, location, project_date, organization_id)
      VALUES ($1, $2, $3, $4, $5)
      RETURNING project_id;
    `;

    const query_params = [title, description, location, date, organizationId];
    const result = await db.query(query, query_params);

    if (result.rows.length === 0) {
        throw new Error('Failed to create project');
    }

    if (process.env.ENABLE_SQL_LOGGING === 'true') {
        console.log('Created new project with ID:', result.rows[0].project_id);
    }

    return result.rows[0].project_id;
}


// Export the model functions
export {
  getAllServiceProjects,
  getProjectsByOrganizationId,
  getUpcomingProjects,
  getProjectDetails,
  createProject
};
