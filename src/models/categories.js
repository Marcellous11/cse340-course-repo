import db from "./db.js";

const getAllCategories = async() => {
    const query = `
        SELECT category_id, name
        FROM project_categories 
        ORDER BY name;
    `;

    const result = await db.query(query);
    return result.rows;
};

const assignCategoryToProject = async(categoryId, projectId) => {
    const query = `
        INSERT INTO service_project_category (category_id, service_project_id)
        VALUES ($1, $2);
    `;

    await db.query(query, [categoryId, projectId]);
}

const updateCategoryAssignments = async(projectId, categoryIds) => {
    // First, remove existing category assignments for the project
    const deleteQuery = `
        DELETE FROM service_project_category
        WHERE service_project_id = $1;
    `;
    await db.query(deleteQuery, [projectId]);

    // Next, add the new category assignments
    for (const categoryId of categoryIds) {
        await assignCategoryToProject(categoryId, projectId);
    }
}

const getCategoriesByServiceProjectId = async(projectId) => {
    const query = `
        SELECT pc.category_id, pc.name
        FROM service_project_category spc
        JOIN project_categories pc ON pc.category_id = spc.category_id
        WHERE spc.service_project_id = $1;
    `;

    const result = await db.query(query, [projectId]);
    return result.rows;
}

export { getAllCategories, updateCategoryAssignments, getCategoriesByServiceProjectId };