-- Table: organizations
CREATE TABLE organizations
(
    organization_id SERIAL PRIMARY KEY,           -- auto‑incrementing PK
    name           VARCHAR(150) NOT NULL,         -- organization name
    description    TEXT        NOT NULL,          -- longer free‑form description
    contact_email  VARCHAR(255) NOT NULL,         -- email address for contact
    logo_filename  VARCHAR(255) NOT NULL          -- filename of the logo image
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

