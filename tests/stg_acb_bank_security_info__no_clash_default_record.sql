SELECT *
FROM {{ ref('stg_acb_bank_security_info') }}
WHERE SECURITY_CODE = '-1'
AND RECORD_SOURCE != 'System.DefaultKey'