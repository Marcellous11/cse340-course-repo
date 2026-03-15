-- Table: organizations
CREATE TABLE organizations
(
    organization_id SERIAL PRIMARY KEY,           -- auto‑incrementing PK
    name           VARCHAR(150) NOT NULL,         -- organization name
    description    TEXT        NOT NULL,          -- longer free‑form description
    contact_email  VARCHAR(255) NOT NULL,         -- email address for contact
    logo_filename  VARCHAR(255) NOT NULL          -- filename of the logo image
);

-- -------------------------------------------------
-- Table: service_projects
-- -------------------------------------------------
CREATE TABLE service_projects
(
    project_id       SERIAL PRIMARY KEY,
    organization_id INTEGER NOT NULL,
    title           VARCHAR(200) NOT NULL,
    description     TEXT NOT NULL,
    location        VARCHAR(150) NOT NULL,
    project_date    VARCHAR(20) NOT NULL,
    created_at      TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
	FOREIGN KEY (organization_id)
	REFERENCES organizations (organization_id)
);

-- -------------------------------------------------
-- Table: project_categories   (the “lookup” table)
-- -------------------------------------------------
CREATE TABLE project_categories
(
    category_id SERIAL PRIMARY KEY,
    name        VARCHAR(100) NOT NULL UNIQUE          -- category name must be unique
);

-- -------------------------------------------------
-- Junction table: service_project_category
--   * One project can have many categories
--   * One category can be linked to many projects
-- -------------------------------------------------
CREATE TABLE service_project_category
(
    service_project_id INTEGER NOT NULL,
    category_id        INTEGER NOT NULL,
    PRIMARY KEY (service_project_id, category_id),
    CONSTRAINT fk_spc_project
        FOREIGN KEY (service_project_id)
        REFERENCES service_projects (project_id)
        ON DELETE CASCADE,         -- if a project is removed, drop its links
    CONSTRAINT fk_spc_category
        FOREIGN KEY (category_id)
        REFERENCES project_categories (category_id)
        ON DELETE RESTRICT        -- keep a category if projects still use it
);




INSERT INTO organizations (name, description, contact_email, logo_filename)
VALUES
  ('BrightFuture Builders',
   'A nonprofit focused on improving community infrastructure through sustainable construction projects.',
   'info@brightfuturebuilders.org',
   'brightfuture-logo.png'),
  ('GreenHarvest Growers',
   'An urban farming collective promoting food sustainability and education in local neighborhoods.',
   'contact@greenharvest.org',
   'greenharvest-logo.png'),
  ('UnityServe Volunteers',
   'A volunteer coordination group supporting local charities and service initiatives.',
   'hello@unityserve.org',
   'unityserve-logo.png');

   -- -------------------------------------------------
-- Insert sample service projects (5 per organisation)
-- -------------------------------------------------

INSERT INTO service_projects
        (organization_id, title, description, location, project_date)
VALUES
    -- ── Organization 1: BrightFuture Builders ───────────────────────
    (1, 'Riverbank Revitalization',
        'Renovate the downtown riverbank promenade with sustainable materials and native plants.',
        'River City, TX',
        '2024-09-15'),
    (1, 'Community Playground Build',
        'Construct an eco‑friendly playground with recycled wood and solar lighting.',
        'River City, TX',
        '2024-10-10'),
    (1, 'Solar Roof Installation',
        'Install photovoltaic panels on the roof of the local community center.',
        'River City, TX',
        '2024-11-05'),
    (1, 'Green Roof Garden',
        'Create a vegetable garden on the roof of the municipal library.',
        'River City, TX',
        '2024-12-01'),
    (1, 'Bike‑Lane Expansion',
        'Add protected bike lanes along Main Street to improve commuter safety.',
        'River City, TX',
        '2025-01-20'),
    (2, 'Urban Farm Expansion',
        'Add 30 new raised beds and a rain‑water harvesting system to the downtown farm.',
        'Northside District, WA',
        '2024-09-22'),
    (2, 'School Garden Program',
        'Build a teaching garden at Jefferson High School and provide curriculum materials.',
        'Northside District, WA',
        '2024-10-18'),
    (2, 'Community Compost Hub',
        'Set up a neighborhood compost drop‑off point and run workshops on composting.',
        'Northside District, WA',
        '2024-11-12'),
    (2, 'Pollinator Meadow',
        'Plant a 1‑acre meadow with native wildflowers to support bees and butterflies.',
        'Northside District, WA',
        '2024-12-08'),
    (2, 'Winter Food‑Shelf Initiative',
        'Grow and preserve winter vegetables for local food‑banks.',
        'Northside District, WA',
        '2025-01-15'),
    (3, 'Food‑Bank Volunteer Day',
        'Collect, sort, and distribute food donations for local families.',
        'Eastside Community Center, NY',
        '2024-09-30'),
    (3, 'Senior Center Tech Workshop',
        'Teach seniors basic computer and smartphone skills.',
        'Eastside Community Center, NY',
        '2024-10-25'),
    (3, 'Neighborhood Cleanup',
        'Organise a street‑wide litter pick‑up and recycling drive.',
        'Eastside Community Center, NY',
        '2024-11-20'),
    (3, 'Holiday Toy Drive',
        'Gather, sort, and deliver toys to children in need.',
        'Eastside Community Center, NY',
        '2024-12-15'),
    (3, 'Emergency Shelter Staffing',
        'Volunteer shifts to staff the local emergency shelter during winter.',
        'Eastside Community Center, NY',
        '2025-01-10');


INSERT INTO project_categories (name) VALUES
    ('Construction / Build'),          -- 1
    ('Education & Training'),          -- 2
    ('Food & Shelter Assistance');    -- 3

/* -------------------------------------------------
   Project → Category mapping
   (feel free to adjust categories per project)
   ------------------------------------------------- */

-- Organization 1 (BrightFuture Builders) projects
INSERT INTO service_project_category (service_project_id, category_id) VALUES
    (1, 1),   -- Riverbank Revitalization      → Construction
    (2, 1),   -- Community Playground Build    → Construction
    (3, 1),   -- Solar Roof Installation       → Construction
    (4, 1),   -- Green Roof Garden              → Construction
    (5, 1);   -- Bike‑Lane Expansion           → Construction
-- Organization 2 (GreenHarvest Growers) projects
INSERT INTO service_project_category (service_project_id, category_id) VALUES
    (6, 2),   -- Urban Farm Expansion          → Education
    (7, 2),   -- School Garden Program         → Education
    (8, 3),   -- Community Compost Hub         → Food & Shelter
    (9, 2),   -- Pollinator Meadow            → Education
    (10,3);   -- Winter Food‑Shelf Initiative → Food & Shelter
-- Organization 3 (UnityServe Volunteers) projects
INSERT INTO service_project_category (service_project_id, category_id) VALUES
    (11,3),   -- Food‑Bank Volunteer Day      → Food & Shelter
    (12,2),   -- Senior Center Tech Workshop → Education
    (13,3),   -- Neighborhood Cleanup           → Food & Shelter
    (14,3),   -- Holiday Toy Drive             → Food & Shelter
    (15,2);   -- Emergency Shelter Staffing    → Education






