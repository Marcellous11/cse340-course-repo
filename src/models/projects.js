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

export { getAllServiceProjects };