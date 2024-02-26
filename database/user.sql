-- ********************************************************************************
-- This script creates the database users and grants them the necessary permissions
-- ********************************************************************************

CREATE USER mealplanner_app_owner
WITH PASSWORD 'mealplannerapp';

GRANT ALL
ON ALL TABLES IN SCHEMA public
TO mealplanner_app_owner;

GRANT ALL
ON ALL SEQUENCES IN SCHEMA public
TO mealplanner_app_owner;

CREATE USER mealplanner_app_appuser
WITH PASSWORD 'mealplannerapp';

GRANT SELECT, INSERT, UPDATE, DELETE
ON ALL TABLES IN SCHEMA public
TO mealplanner_app_appuser;

GRANT USAGE, SELECT
ON ALL SEQUENCES IN SCHEMA public
TO mealplanner_app_appuser;
