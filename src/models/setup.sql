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


