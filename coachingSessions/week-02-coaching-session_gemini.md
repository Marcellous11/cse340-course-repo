# Week 02 Coaching Session: Marcellous

**Coach:** Welcome! Just to be clear from the start, this is a coaching session, not a test. It is perfectly okay—and even encouraged—to say 'I don't know' or 'I made a mistake.' That's the fastest way we'll learn today. I'm excited to dive into your Week 2 project with you. Before we get into the technical weeds of your database and server setup, could you please start by confirming your name for me?

**Marcellous:** Marcellous

**Coach:** It’s great to meet you, Marcellous! I'm ready to dive in whenever you are. To get us started on our first topic—**Relational Database Design**—could you tell me a bit about the purpose of the tables you created for this assignment and then **paste a relevant SQL query** (like a `CREATE TABLE` or a specific `SELECT`) that shows how those tables relate to one another?

**Marcellous:**
```sql
 -- Table: organizations
CREATE TABLE organizations
(
    organization_id SERIAL PRIMARY KEY,           -- auto‑incrementing PK
    name           VARCHAR(150) NOT NULL,         -- organization name
    description    TEXT        NOT NULL,          -- longer free‑form description
    contact_email  VARCHAR(255) NOT NULL,         -- email address for contact
    logo_filename  VARCHAR(255) NOT NULL          -- filename of the logo image
);
```

**Coach:** Thanks for sharing that, Marcellous! That's a solid, clean structure for your `organizations` table. Using `SERIAL` for the primary key is a great move for keeping those IDs unique and automatic. To get a better feel for your **Relational Database Design**, does this table stand alone, or do you have other tables (like users, events, or categories) that link back to `organization_id` to create a relationship?

**Marcellous:** There are other times in the project but they current don't link to each together. This is just simple entity for the organization I will be interacting with

**Coach:** That makes sense—keeping things decoupled can definitely simplify your initial setup while you focus on the core CRUD operations. Since we've got the structural side down, let's move into **Topic 2: Server-Side Data Access Logic**. Could you show me the **Node.js function** you wrote that actually talks to your database to pull this organization data?

**Marcellous:** 
```js
import db from "./db.js";

const getAllOrganizations = async () => {
  const query = `
        SELECT organization_id, name, description, contact_email, logo_filename
      FROM public.organizations;
    `;

  const result = await db.query(query);
  console.log(result);
  return result.rows;
};

export { getAllOrganizations };
```

**Coach:** That's a very clean, asynchronous function, Marcellous. Using `async/await` is definitely the way to go to keep your code readable while waiting for the database to respond. Since you are using `db.query(query)`, could you walk me through what's happening inside that `db` object—specifically, are you using a library like **pg (node-postgres)** to handle the actual connection to your database?

**Marcellous:** 
```js
import { Pool } from "pg";
let db = null;
const pool = new Pool({
  connectionString: process.env.DB_URL,
  ssl: true,
});

db = pool;
```

I left some code out but basically this pool object connects to my db using the pg library. It suppose reduce the amount of time I connect to the db by keeping a lasting connection. 

**Coach:** That is a spot-on explanation, Marcellous. You’ve hit the nail on the head: using a **Pool** is much more efficient than opening and closing a new connection for every single request, which can really slow down a server under load. Now that we’ve seen how the data is pulled from the database, let's move to **Topic 3: Express Server Logic and Routing**. Could you share a **specific routing declaration** from your main server file (like an `app.get` or `router.get`) that uses that `getAllOrganizations` function to handle an incoming request?

**Marcellous:** 
```js
app.get("/organizations", async (req, res) => {
  const organizations = await getAllOrganizations();
  const title = "Our Partner Organizations";

  res.render("organizations", { title, organizations });
});
```

Again very straight forward. I get the response from the db and then with EJS I am able to pass that data to the front end to be manipulated in the HTML

**Coach:** It really is elegant when the pieces start fitting together like that, Marcellous. You're handling the asynchronous data fetch perfectly before passing it off to the view. That leads us perfectly into our final area, **Topic 4: Client-Side Rendering**. Since you're using EJS to bridge the gap between your server and the browser, could you share **a specific line of EJS syntax** from your `organizations.ejs` file that actually displays that data (like the organization name or the logo) to the user?

**Marcellous:** 
```html
<ul>
    <% organizations.forEach( org=>{ %>
        <li><img src="/images/<%=org.logo_filename%>" alt="<%=org.description%>"><strong><%=org.name%></strong>: <%= org.contact_email%></li>
    <%});%>
</ul>
```

Here in this snippet, I iterate through the organization object to build multiple li elements and populate its properties with data

**Coach:** That’s a textbook example of using EJS to turn a data array into a dynamic list, Marcellous! Using the `<%= %>` tags to inject the specific properties—like that image source and the email—is exactly how you bridge the gap between your backend logic and the user's browser. Now that we've walked through the database schema, the data access function, the Express route, and finally the EJS rendering, you've successfully covered the entire "Round Trip" of a web request. Looking back at this loop you've built, is there any part of this flow—from the SQL table to the final HTML list—that felt the most challenging or "clicked" for you for the first time during this assignment?

**Marcellous:** I just recent felt like the syntax for EJS made more sense to me. This could just be my own memorization tactic but seeing the bars increase ie <% , <%- , <%=, as decrease amounts of rendering / functionality. <% processing raw js with no output. <%- producing an output with HMTL and <%= just putting out raw text, no HTML

**Coach:** That is a fantastic mental model! Associating the "weight" or complexity of the symbol with the amount of processing the browser does is a great way to memorize it. Your observation is spot on: `<%` (The "Heavy" work): All logic, no visual output; `<%-` (The "Open" output): Lets everything through, including HTML tags; `<%=` (The "Safe" output): The most common one you'll use, as it "escapes" the data to ensure it's treated as plain text. Since you've successfully navigated through all four topics—**Database Design**, **Data Access**, **Server Routing**, and **EJS Rendering**—we have completed our coaching session requirements!