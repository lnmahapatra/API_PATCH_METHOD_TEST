# RESTful API Robot Framework Tests

This repository contains Robot Framework test cases for the `PATCH /objects/{id}` endpoint of the public API at https://restful-api.dev.

## ✅ Tech Stack

- Python 3.12+
- Robot Framework
- robotframework-requests
- GitHub Actions CI

## ✅ Install & Run

```bash
git clone https://github.com/lnmahapatra/SAMPLEAUTO.git
cd BRITDEMO
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate
pip install -r requirements.txt

robot tests/
ROBOT tests/patch_objects_tests.robot

✅ Test Cases

✅ Patch existing object successfully

❌ Patch non-existent object (should fail)

❌ Patch with invalid payload (should fail)

❌ Patch with empty payload (should fail or no-op)
