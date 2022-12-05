from google.cloud import bigquery
from dotenv import load_dotenv
import os


# load global variables
load_dotenv(dotenv_path='credentials.env')

GOOGLE_APPLICATION_CREDENTIALS = os.getenv('GOOGLE_APPLICATION_CREDENTIALS')
GOOGLE_PROJECT_ID = os.getenv('GOOGLE_PROJECT_ID')
GOOGLE_DATASET = os.getenv('GOOGLE_DATASET')

client = bigquery.Client()
dataset_ref = client.dataset(GOOGLE_DATASET)


class GoogleHelper():

    def __init__(self):
        pass

    def get_project_id(self):
        return GOOGLE_PROJECT_ID

    def get_dataset(self):
        return GOOGLE_DATASET
    
    def load_data_from_dataframe(self, dataframe, table):
        table_ref = dataset_ref.table(table)
        client.load_table_from_dataframe(dataframe, table_ref).result()

    def query(self, stmt):
        query_job = client.query(stmt)
        results = query_job.result()  # Waits for job to complete.
        return results

    def drop_table(self, table):
        client.delete_table(table)
