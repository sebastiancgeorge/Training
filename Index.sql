-- Users table
CREATE TABLE auth.users (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

-- Organizations table
CREATE TABLE auth.organizations (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

-- Organization roles
CREATE TABLE auth.organization_roles (
    id SERIAL PRIMARY KEY,
    organization_id INTEGER NOT NULL,
    name TEXT NOT NULL,
    FOREIGN KEY (organization_id) REFERENCES auth.organizations(id)
);

-- Permissions table
CREATE TABLE auth.permissions (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

-- Role-Permission mapping
CREATE TABLE auth.organization_role_permissions (
    id SERIAL PRIMARY KEY,
    organization_role_id INTEGER NOT NULL,
    permission_id INTEGER NOT NULL,
    FOREIGN KEY (organization_role_id) REFERENCES auth.organization_roles(id),
    FOREIGN KEY (permission_id) REFERENCES auth.permissions(id)
);

-- User-Role mapping
CREATE TABLE auth.user_roles (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    organization_role_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES auth.users(id),
    FOREIGN KEY (organization_role_id) REFERENCES auth.organization_roles(id)
);

create index idx_user_roles_user_orgrole
on auth.user_roles (user_id, organization_role_id);

create index idx_org_roles_org
on auth.organization_roles (organization_id, id);

create index idx_role_permissions_role
on auth.organization_role_permissions (organization_role_id, permission_id);

create index idx_role_permissions_permission
on auth.organization_role_permissions (permission_id);

create unique index idx_permissions_name
on auth.permissions (name);

explain analyse select distinct p.id, p.name
from auth.user_roles ur
join auth.organization_roles r
    on r.id = ur.organization_role_id
join auth.organization_role_permissions rp
    on rp.organization_role_id = r.id
join auth.permissions p
    on p.id = rp.permission_id
where ur.user_id = 1
  and r.organization_id = 2;


