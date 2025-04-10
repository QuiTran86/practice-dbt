SELECT *
FROM {{ source('abc_bank', 'ACB_BANK_POSITION') }}