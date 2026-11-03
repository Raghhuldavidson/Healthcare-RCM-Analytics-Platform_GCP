# 🏥 Healthcare RCM Analytics Platform on GCP

A GCP-based Healthcare **Revenue Cycle Management (RCM)** data platform that ingests data from **two independent hospital source systems**, unifies them into a conformed **Silver layer (SCD Type 2 + data quality quarantine)**, and produces **Gold analytical KPIs** for provider, department, patient history, payor performance, and financial metrics — orchestrated end-to-end by **Cloud Composer (Airflow)**.

---



## 🏗 Architecture Overview


<img width="1774" height="780" alt="Screenshot 2026-11-03 123648" src="https://github.com/user-attachments/assets/a0f02139-382f-4ac4-9632-16a8eb8fe505" />

---

## ☁️ GCP Services Used

| Service | Purpose |
|---|---|
| **Cloud SQL (MySQL)** | Two source DBs: `hospital_a_db`, `hospital_b_db` |
| **Cloud Storage (GCS)** | Landing, archive, configs, temp |
| **Dataproc (PySpark)** | MySQL → GCS JSON ingestion; CSV → BigQuery loaders |
| **BigQuery** | Bronze (external), Silver (SCD2), Gold (KPIs), temp_dataset (audit + logs) |
| **Cloud Composer (Airflow)** | Parent DAG → PySpark DAG → BigQuery DAG orchestration |

---

## ⚙️ Load Config (`configs/load_config.csv`)

**Columns:** `database`, `datasource`, `tablename`, `loadtype`, `watermark`, `is_active`, `targetpath`

| Table | Load Type | Watermark | Active |
|---|---|---|---|
| `encounters` | Incremental | `ModifiedDate` | ✅ |
| `patients` | Incremental | `ModifiedDate` | ✅ |
| `transactions` | Incremental | `ModifiedDate` | ✅ |
| `providers` | Full | — | ✅ |
| `departments` | Full | — | ✅ |

---

## 🎼 Airflow / Cloud Composer DAGs

| DAG | Schedule | Tasks |
|---|---|---|
| `parent_dag` | `"0 5 * * *"` | `TriggerDagRunOperator(pyspark_dag, wait_for_completion=True)` **>>** `TriggerDagRunOperator(bigquery_dag, wait_for_completion=True)` |
| `pyspark_dag` | — | `DataprocStartClusterOperator` (`my-demo-cluster`, `us-east1`) → 4 × `DataprocSubmitJobOperator` → `DataprocStopClusterOperator` |
| `bigquery_dag` | `None` | `bronze_tables` → `silver_tables` → `gold_tables` (each `BigQueryInsertJobOperator`, reads SQL from `/home/airflow/gcs/data/BQ/<layer>.sql`) |

**PySpark DAG task order:**
pyspark_task_1 = hospitalA_mysqlToLanding.py
pyspark_task_2 = hospitalB_mysqlToLanding.py
pyspark_task_3 = claims.py
pyspark_task_4 = cpt_codes.py
