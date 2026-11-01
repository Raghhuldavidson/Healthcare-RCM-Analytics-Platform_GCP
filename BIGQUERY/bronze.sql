-- Description: Create external tables for bronze dataset in BigQuery
-- please do not forget to replace the bucket path

CREATE EXTERNAL TABLE IF NOT EXISTS `healthcare-rcm-510903.bronze_dataset.departments_ha` 
OPTIONS (
  format = 'JSON',
  uris = ['gs://healthcare_gcpbucket/landing/hospital-a/departments/*.json']
);

CREATE EXTERNAL TABLE IF NOT EXISTS `healthcare-rcm-510903.bronze_dataset.encounters_ha` 
OPTIONS (
  format = 'JSON',
  uris = ['gs://healthcare_gcpbucket/landing/hospital-a/encounters/*.json']
);

CREATE EXTERNAL TABLE IF NOT EXISTS `healthcare-rcm-510903.bronze_dataset.patients_ha` 
OPTIONS (
  format = 'JSON',
  uris = ['gs://healthcare_gcpbucket/landing/hospital-a/patients/*.json']
);

CREATE EXTERNAL TABLE IF NOT EXISTS `healthcare-rcm-510903.bronze_dataset.providers_ha` 
OPTIONS (
  format = 'JSON',
  uris = ['gs://healthcare_gcpbucket/landing/hospital-a/providers/*.json']
);

CREATE EXTERNAL TABLE IF NOT EXISTS `healthcare-rcm-510903.bronze_dataset.transactions_ha` 
OPTIONS (
  format = 'JSON',
  uris = ['gs://healthcare_gcpbucket/landing/hospital-a/transactions/*.json']
);

---------------------------------------------------------------------------------------------------------------------------

CREATE EXTERNAL TABLE IF NOT EXISTS `healthcare-rcm-510903.bronze_dataset.departments_hb` 
OPTIONS (
  format = 'JSON',
  uris = ['gs://healthcare_gcpbucket/landing/hospital-b/departments/*.json']
);

CREATE EXTERNAL TABLE IF NOT EXISTS `healthcare-rcm-510903.bronze_dataset.encounters_hb` 
OPTIONS (
  format = 'JSON',
  uris = ['gs://healthcare_gcpbucket/landing/hospital-b/encounters/*.json']
);

CREATE EXTERNAL TABLE IF NOT EXISTS `healthcare-rcm-510903.bronze_dataset.patients_hb` 
OPTIONS (
  format = 'JSON',
  uris = ['gs://healthcare_gcpbucket/landing/hospital-b/patients/*.json']
);

CREATE EXTERNAL TABLE IF NOT EXISTS `healthcare-rcm-510903.bronze_dataset.providers_hb` 
OPTIONS (
  format = 'JSON',
  uris = ['gs://healthcare_gcpbucket/landing/hospital-b/providers/*.json']
);

CREATE EXTERNAL TABLE IF NOT EXISTS `healthcare-rcm-510903.bronze_dataset.transactions_hb` 
OPTIONS (
  format = 'JSON',
  uris = ['gs://healthcare_gcpbucket/landing/hospital-b/transactions/*.json']
);

---------------------------------------------------------------------------------------------------------------------------