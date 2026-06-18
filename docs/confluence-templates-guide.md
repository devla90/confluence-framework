# Guide: How to Create Custom Templates in Confluence Cloud

This guide explains step by step how to convert the markdown templates in this repository into functional Confluence Cloud Space Templates.

---

## 1. Template Types in Confluence Cloud

| Type | Scope | When to use |
|------|-------|-------------|
| **Space Template** | Available only within a space | For our case, all templates are Space Templates of `{SPACE_KEY}` |
| **Global Template** | Available in all spaces | Useful if domains are later split into their own spaces |

### Recommendation for your project

Since the entire project lives in a single space (`{SPACE_KEY}`), all templates are created as **Space Templates** of that space. This makes them available when creating any page within `{SPACE_KEY}`.

| Template | Type | Sections where used |
|----------|------|---------------------|
| Functional Specification | Space Template | {PREFIX}-FRONT, {PREFIX}-BACK, {PREFIX}-BIZ |
| ADR | Space Template | {PREFIX}-FRONT, {PREFIX}-BACK, {PREFIX}-ARCH |
| API Specification | Space Template | {PREFIX}-BACK |
| Environment Configuration | Space Template | All technical sections |
| Runbook | Space Template | {PREFIX}-FRONT, {PREFIX}-BACK, {PREFIX}-ARCH |
| Security Document | Space Template | {PREFIX}-SEC |
| Migration Document | Space Template | Multiple sections |
| Test Plan | Space Template | {PREFIX}-QA |
| Test Strategy | Space Template | {PREFIX}-QA |
| Infrastructure Request | Space Template | {PREFIX}-ARCH |
| Deployment Role Request | Space Template | {PREFIX}-ARCH |

---

## 2. Create a Space Template — Step by Step

### Step 1: Go to the space template settings

1. Navigate to the space where you want to create the template (e.g., `{SPACE_KEY}`)
2. Click on **Space Settings** (gear icon in the sidebar)
3. In the "Look and feel" section, click on **Content templates**
4. Click on **Create template**

### Step 2: Name the template

- **Name**: Use the descriptive template name (e.g., "Functional Specification")
- **Description**: One line explaining when to use it (e.g., "Document features AS-IS or TO-BE with requirements and business rules")

### Step 3: Build the template content

This is where you translate the markdown file into native Confluence elements. See section 3 of this guide for translating each element.

### Step 4: Add default labels

At the bottom of the template editor, in the **Labels** field:
- Add the default labels for the template (e.g., `type:func-spec`, `status:draft`)
- These labels will be automatically applied to every page created from this template

### Step 5: Save and test

1. Click **Save**
2. Go to the space and create a new page (click **Create**)
3. Verify that the template appears in the list
4. Create a test page and confirm the structure is correct
5. Delete the test page

### Step 6: Promote the template (optional but recommended)

To make the template appear **first** when someone creates a new page:
1. Go to **Space Settings** > **Content templates**
2. Find the template you created
3. Click the star icon or "Promote" next to the template
4. Promoted templates appear highlighted in the page creation dialog

---

## 3. Translation: Markdown to Confluence Elements

### Page Properties (metadata table)

**In the markdown** (example from `templates/func-spec.md`):
```markdown
## Page Properties

| Field | Value |
|-------|-------|
| **Status** | DRAFT |
| **Owner** | @author |
```

**In Confluence**:
1. Type `/page properties` in the editor to insert the **Page Properties** macro
2. Inside the macro, create a table with two columns: Field and Value
3. The table inside the Page Properties macro will be readable by the Page Properties Report macro on index pages

> **Important**: The table MUST be inside the Page Properties macro to be indexable by CQL and Page Properties Report. A regular table will not work.

### Headings (sections)

**In the markdown**:
```markdown
## 1. General Description
### In Scope
```

**In Confluence**:
- `## Text` -> Select the text and apply **Heading 2**
- `### Text` -> Select the text and apply **Heading 3**
- Keep section numbering (1, 2, 3...) for consistency

### Tables

**In the markdown**:
```markdown
| ID | Requirement | Priority |
|----|-------------|----------|
| RF-001 | | High / Medium / Low |
```

**In Confluence**:
1. Type `/table` or use the keyboard shortcut to insert a table
2. Define columns with the headers from the markdown
3. For example rows, leave the content as an editable placeholder

### Placeholders `{...}`

**In the markdown**:
```markdown
| **Owner** | @author |
```

**In Confluence** — Option A (Template Variables):
1. Type `/template variable` in the editor
2. Name the variable (e.g., "author")
3. When someone creates a page from the template, Confluence will ask them to fill in the variables

**In Confluence** — Option B (Placeholder Text):
1. Type `/placeholder text` in the editor
2. Type the guide text (e.g., "Enter the owner's name here")
3. The text appears gray and disappears when the user types

> **Recommendation**: Use **template variables** for Page Properties (Status, Owner, Approver) and **placeholder text** for long content sections.

### Information Macros (Info, Warning, Note)

**In the markdown**:
```markdown
> *Complete only if applicable.*
```

**In Confluence**:
- For informational notes: Type `/info` -> inserts a blue information panel
- For warnings: Type `/warning` -> inserts a yellow panel
- For important notes: Type `/note` -> inserts a gray panel
- For danger/errors: Type `/error` -> inserts a red panel

Use these panels for in-template instructions that guide the author.

### Diagrams (draw.io)

**In the markdown**:
```markdown
**AS-IS Diagram**: *(insert draw.io diagram here)*
```

**In Confluence**:
1. Type `/draw.io` or `/diagram` in the editor
2. The integrated draw.io editor opens
3. Create an empty placeholder diagram or one with the basic structure
4. Save — it is embedded and editable directly in Confluence

> If draw.io is not installed, ask the Confluence administrator to enable it from the Marketplace.

### Issue Tracker Links

**In the markdown**:
```markdown
| Issue Tracker Epic | PROJ-XXXX (link via issue tracker macro) |
```

**In Confluence**:
1. For a single issue: Paste the issue URL — Confluence automatically converts it into a Smart Link
2. For a filter/list: Type `/jira` -> insert the Jira Issues macro -> paste a JQL query or filter URL
3. For a template variable: Use placeholder text with the instruction "Paste the epic URL here"

### Design Tool Embeds

**In the markdown**:
```markdown
| Design Tool Links and Embeds |
```

**In Confluence**:
1. Copy the frame URL from your design tool (e.g., Figma)
2. Paste in the Confluence editor — it automatically converts into a visual embed
3. Alternative: Type `/figma` if the Figma macro is installed

> The embed updates automatically when the design changes in the source tool.

### Status Badges

**In the markdown**:
```markdown
| Migration Status | NOT STARTED / IN PROGRESS / COMPLETED |
```

**In Confluence**:
1. Type `/status` in the editor
2. Select the color (green, yellow, red, gray)
3. Type the status text
4. It appears as a visual inline badge

### Expand/Collapse (optional content)

For sections that are optional or contain additional detail:
1. Type `/expand` in the editor
2. Set the title of the collapsible block
3. Type the content inside — it displays collapsed by default

---

## 4. Template Variables

Template variables are fields that Confluence asks the user to fill in **when creating the page**. They are ideal for Page Properties.

### How to add a variable

1. In the template editor, position the cursor where the variable should go
2. Type `/template variable`
3. Configure:
   - **Name**: Variable name (e.g., "owner")
   - **Type**: Text (default) or List (for predefined options)
4. If it is a List type, add the options (e.g., "DRAFT, IN-REVIEW, APPROVED")

### Recommended variables per template

| Variable | Type | Options | Used in |
|----------|------|---------|---------|
| status | List | DRAFT, IN-REVIEW, APPROVED, ARCHIVED, OBSOLETE | All |
| owner | Text | — | All |
| approver | Text | — | All |
| phase | List | AS-IS, TO-BE, Transition | func-spec, migration |
| environment | List | DEV, QA, STG, PROD | env-config |
| severity | List | P1, P2, P3 | runbook |
| classification | List | CONFIDENTIAL, INTERNAL, PUBLIC | security-doc |

### Result

When a user creates a page from a template with variables, Confluence shows a dialog:

```
+-------------------------------------+
| Create page from template           |
|                                     |
| Title: [________________]           |
|                                     |
| Owner: [________________]           |
| Approver: [________________]        |
| Status: [DRAFT v]                   |
| Phase: [TO-BE v]                    |
|                                     |
|            [Create]  [Cancel]       |
+-------------------------------------+
```

---

## 5. Create a Global Template

The process is similar but done from the global administration:

1. Go to **Settings** (gear icon at top right) > **Global templates and blueprints**
2. Click on **Add global page template**
3. Follow the same steps as for Space Templates (section 2)
4. Global Templates appear in ALL spaces when creating a new page

> **Who can create Global Templates**: Only Confluence administrators. Coordinate with the site administrator to create the global templates listed in section 1.

---

## 6. Validation Checklist

Before communicating a template to the team, verify:

- [ ] **Page Properties macro**: Inserted correctly (not a regular table)
- [ ] **Template variables**: Key fields prompt for input when creating a page
- [ ] **Default labels**: Labels `type:`, `status:draft` are configured
- [ ] **Numbered sections**: All sections from the markdown are present
- [ ] **Placeholders**: Content sections have guide text
- [ ] **Macros**: draw.io, Jira Issues, Status work correctly
- [ ] **Template promoted**: Appears highlighted when creating a new page
- [ ] **End-to-end test**: Create a page from the template, fill in test data, verify that Page Properties Report detects it, delete the test page

---

## 7. Troubleshooting

| Problem | Cause | Solution |
|---------|-------|----------|
| Page Properties macro does not appear | Not available in your Confluence plan | Only available in Confluence Cloud Standard and Premium. Verify your plan. |
| draw.io is not available | Macro not installed | Ask the admin to install "draw.io Diagrams" from Atlassian Marketplace |
| Template variables do not appear when creating a page | Template does not have variables configured | Edit the template and add variables with `/template variable` |
| Default labels are not applied | Not configured in the template | Edit template > Labels section > add the labels |
| Template does not appear when creating a page | Template is not in the correct space or is not promoted | Verify the template is in the space where the page is being created (or is Global) |
| Design embed does not work | The URL is not public or the user does not have access | The URL must be accessible to whoever views the page. Configure sharing in the design tool. |
