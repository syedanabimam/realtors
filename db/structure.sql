CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
CREATE TABLE "posts" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "customer_name" varchar(255), "customer_email" varchar(255), "customer_phone_no" varchar(255), "house_name" varchar(255), "house_address" varchar(255), "description" varchar(255), "post_type_select" varchar(255), "created_at" datetime, "updated_at" datetime, "image_file_name" varchar(255), "image_content_type" varchar(255), "image_file_size" integer, "image_updated_at" datetime, "status" varchar(255), "rent_price" varchar(255), "latitude" float, "longitude" float, "country" varchar(255), "city" varchar(255), "google_address" varchar(255), "user_id" integer);
CREATE INDEX "index_posts_on_user_id" ON "posts" ("user_id");
INSERT INTO schema_migrations (version) VALUES ('20160210182036');

INSERT INTO schema_migrations (version) VALUES ('20160210182408');

INSERT INTO schema_migrations (version) VALUES ('20160211131150');

INSERT INTO schema_migrations (version) VALUES ('20160212162536');

INSERT INTO schema_migrations (version) VALUES ('20160212195147');

INSERT INTO schema_migrations (version) VALUES ('20160212195458');

INSERT INTO schema_migrations (version) VALUES ('20160212220440');

INSERT INTO schema_migrations (version) VALUES ('20160212221019');

INSERT INTO schema_migrations (version) VALUES ('20160212231116');

INSERT INTO schema_migrations (version) VALUES ('20160213011236');

