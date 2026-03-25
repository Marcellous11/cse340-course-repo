# Week 3 Coaching Session

## Role

**Your Role:** I am your supportive and non-judgmental Learning Coach and Software Mentor.

Welcome! Just to be clear from the start, this is a coaching session, not a test. It is perfectly okay—and even encouraged—to say "I don't know" or "I made a mistake." That's the fastest way we'll learn today.

---

## Introduction

**Coach:** Before we dive in—can you confirm your name, and briefly tell me how you felt about your Week 2 assignment overall?

**Marcellous:** Marcellous and week 2 was fine, no blockers

**Coach:** Got it, Marcellous—that’s a solid place to be. “No blockers” usually means we can dig into decisions and depth, which is where the real learning happens.

---

## Topic 1: Models

**Coach:** Please paste a non-trivial model function you wrote—specifically one that takes a parameter and uses it in an SQL query—and we’ll walk through what it’s doing and why you structured it that way.

### Code

```javascript
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
```

### Discussion

**Coach Feedback:**
- You’re using parameterized queries (`$1`) correctly.
- LEFT JOIN suggests optional relationship handling.
- Returning `null` for no results is clean but hides context.
- Potential issue: flat object mixing multiple entities.

---

### Question

**Coach:** Why did you choose a LEFT JOIN here instead of an INNER JOIN, and what behavior would change if you switched it?

**Marcellous:**  
If I had used inner join any value that didn't have a match on organization_id would just not return anything. But with the left join I will still get back service_project.organization_id even if organization.organization_id doesn't exist—which in hindsight seems silly because when would the organization not have an id. If i were to change it it would just use an inner join honestly

**Coach Feedback:**
- Correct understanding of JOIN behavior.
- LEFT JOIN is unnecessary if FK constraints exist.
- INNER JOIN better reflects your data model.

---

### Schema

```sql
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
```

---

### Key Insight

- LEFT JOIN is redundant due to FK constraint.
- project_date as VARCHAR is a design weakness.

---

## Topic 2: Views

### Code

```html
<h3>Organization</h3>
<p>
    <a href="/organization/<%= projectDetails.organization_id %>">
        <%= projectDetails.name %>
    </a>
</p>
```

### Discussion

**Coach Feedback:**
- Good use of `<%= %>` (escaped output).
- Clean routing structure.
- Assumes data always exists.

---

### Question

**Coach:** What would happen if `projectDetails` is null, and where should that be handled?

**Marcellous:**  
Projects can't exist without an organization, so that href will always work otherwise the page wont exist

**Coach Feedback:**
- Incorrect assumption.
- Problem is not the organization—it’s a missing project.
- Null will cause runtime error in view.

---

## Topic 3: Controllers

### Router

```javascript
const showProjectDetailsPage = async (req, res) => {
  const projectId = req.params.id;
  const projectDetails = await getProjectDetails(projectId);
  console.log(projectDetails);
  const title = projectDetails.title;

  res.render("project", { title, projectDetails });
};
```

---

### Discussion

**Coach Feedback:**
- Critical bug: no null check.
- Risk: `projectDetails.title` throws runtime error.
- Should validate before accessing properties.

---

### Question

**Coach:** Where should you handle the null case?

**Marcellous:**  
I would need to add it right after `getProjectDetails`

**Coach Feedback:**
- Correct location.
- Add validation before accessing properties.

---

## Topic 4: Error Handling

### Middleware

```javascript
// Catch-all route for 404 errors
app.use((req, res, next) => {
  const err = new Error("Page Not Found");
  err.status = 404;
  next(err);
});

// Global error handler
app.use((err, req, res, next) => {
  console.error("Error occurred:", err.message);
  console.error("Stack trace:", err.stack);

  const status = err.status || 500;
  const template = status === 404 ? "404" : "500";

  const context = {
    title: status === 404 ? "Page Not Found" : "Server Error",
    error: err.message,
    stack: err.stack,
  };

  res.status(status).render(`errors/${template}`, context);
});
```

---

### Discussion

**Coach Feedback:**
- Strong error handling structure.
- Centralized middleware is correct.
- Potential issue: exposing stack traces in production.

---

## Final Reflection

**Coach:** What is your weakest link?

**Marcellous:**  
Not checking projectDetails before assuming properties already exist

**Coach Feedback:**
- Correct identification of the core issue.
- This reflects a broader pattern: missing boundary validation.

---

## Additional Insight

- Controllers should validate data before rendering.
- Views should not handle control flow decisions.
- Models should return predictable results.

---

## Final Question

**Coach:** What’s the difference between `next()` and `next(err)`?

**Marcellous:**  
next(err) will send it to the global error handler

**Coach Feedback:**
- Correct.
- `next()` continues flow.
- `next(err)` triggers error middleware.

---

## Conclusion

You demonstrated strong awareness of:
- SQL structure
- Routing
- Error handling
- System architecture

Primary improvement area:
- Boundary validation and defensive programming.

Focus going forward:
- Validate before use
- Handle nulls explicitly
- Keep responsibilities separated across layers