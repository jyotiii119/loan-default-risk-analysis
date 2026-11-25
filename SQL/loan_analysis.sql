
-- =====================================================
-- PROJECT: LOAN DEFAULT RISK ANALYSIS
-- DATABASE: PostgreSQL
-- TABLE: public.loans_analysis
-- =====================================================


-- 1. TOTAL LOAN APPLICATIONS

SELECT
    COUNT(*) AS total_applications
FROM public.loans_analysis;


-- 2. LOAN STATUS DISTRIBUTION

SELECT
    loan_status,
    COUNT(*) AS total_loans
FROM public.loans_analysis
GROUP BY loan_status
ORDER BY total_loans DESC;


-- 3. GOOD LOANS VS DEFAULTED LOANS

SELECT
    COUNT(*) FILTER (
        WHERE loan_status = 'Fully Paid'
    ) AS good_loans,

    COUNT(*) FILTER (
        WHERE loan_status = 'Charged Off'
    ) AS defaulted_loans
FROM public.loans_analysis;


-- 4. OVERALL BAD LOAN RATE
-- Denominator: Fully Paid + Charged Off

SELECT
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE loan_status = 'Charged Off'
        )
        /
        NULLIF(
            COUNT(*) FILTER (
                WHERE loan_status IN ('Fully Paid', 'Charged Off')
            ), 0
        ),
        2
    ) AS bad_loan_percentage
FROM public.loans_analysis;


-- 5. DEFAULT RATE BY INCOME BRACKET

SELECT
    CASE
        WHEN annual_income IS NULL THEN 'Unknown'
        WHEN annual_income < 25000 THEN 'Below 25K'
        WHEN annual_income < 50000 THEN '25K-50K'
        WHEN annual_income < 75000 THEN '50K-75K'
        WHEN annual_income < 100000 THEN '75K-100K'
        ELSE '100K+'
    END AS income_bracket,

    COUNT(*) FILTER (
        WHERE loan_status = 'Charged Off'
    ) AS defaulted_loans,

    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE loan_status = 'Charged Off'
        )
        /
        NULLIF(
            COUNT(*) FILTER (
                WHERE loan_status IN ('Fully Paid', 'Charged Off')
            ), 0
        ),
        2
    ) AS bad_loan_percentage

FROM public.loans_analysis
GROUP BY 1
ORDER BY 1;


-- 6. DEFAULT RATE BY EMPLOYMENT LENGTH

SELECT
    employment_length,

    COUNT(*) FILTER (
        WHERE loan_status = 'Charged Off'
    ) AS defaulted_loans,

    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE loan_status = 'Charged Off'
        )
        /
        NULLIF(
            COUNT(*) FILTER (
                WHERE loan_status IN ('Fully Paid', 'Charged Off')
            ), 0
        ),
        2
    ) AS bad_loan_percentage

FROM public.loans_analysis
GROUP BY employment_length
ORDER BY bad_loan_percentage DESC;


-- 7. DEFAULT RATE BY LOAN PURPOSE

SELECT
    purpose,

    COUNT(*) FILTER (
        WHERE loan_status = 'Charged Off'
    ) AS defaulted_loans,

    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE loan_status = 'Charged Off'
        )
        /
        NULLIF(
            COUNT(*) FILTER (
                WHERE loan_status IN ('Fully Paid', 'Charged Off')
            ), 0
        ),
        2
    ) AS bad_loan_percentage

FROM public.loans_analysis
GROUP BY purpose
ORDER BY bad_loan_percentage DESC;


-- 8. DEFAULT RATE BY STATE

SELECT
    state,

    COUNT(*) FILTER (
        WHERE loan_status = 'Charged Off'
    ) AS defaulted_loans,

    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE loan_status = 'Charged Off'
        )
        /
        NULLIF(
            COUNT(*) FILTER (
                WHERE loan_status IN ('Fully Paid', 'Charged Off')
            ), 0
        ),
        2
    ) AS bad_loan_percentage

FROM public.loans_analysis
GROUP BY state
ORDER BY bad_loan_percentage DESC;


-- 9. DEFAULT RATE BY LOAN SUB-GRADE

SELECT
    sub_grade,

    COUNT(*) FILTER (
        WHERE loan_status = 'Charged Off'
    ) AS defaulted_loans,

    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE loan_status = 'Charged Off'
        )
        /
        NULLIF(
            COUNT(*) FILTER (
                WHERE loan_status IN ('Fully Paid', 'Charged Off')
            ), 0
        ),
        2
    ) AS bad_loan_percentage

FROM public.loans_analysis
GROUP BY sub_grade
ORDER BY bad_loan_percentage DESC;


-- 10. DEFAULT RATE BY DEBT-TO-INCOME BAND

SELECT
    CASE
        WHEN debt_to_income IS NULL THEN 'Unknown'
        WHEN debt_to_income <= 10 THEN '0-10'
        WHEN debt_to_income <= 20 THEN '10-20'
        WHEN debt_to_income <= 30 THEN '20-30'
        WHEN debt_to_income <= 40 THEN '30-40'
        ELSE 'Above 40'
    END AS dti_band,

    COUNT(*) FILTER (
        WHERE loan_status = 'Charged Off'
    ) AS defaulted_loans,

    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE loan_status = 'Charged Off'
        )
        /
        NULLIF(
            COUNT(*) FILTER (
                WHERE loan_status IN ('Fully Paid', 'Charged Off')
            ), 0
        ),
        2
    ) AS bad_loan_percentage

FROM public.loans_analysis
GROUP BY 1
ORDER BY 1;


-- 11. PRELIMINARY MANUAL REVIEW FLAGS

SELECT
    loan_id,
    annual_income,
    employment_length,
    debt_to_income,
    sub_grade,
    purpose,
    loan_status,

    CASE
        WHEN debt_to_income > 30
          OR LEFT(sub_grade, 1) IN ('D', 'E', 'F', 'G')
          OR loan_status IN (
              'Late (31-120 days)',
              'In Grace Period'
          )
        THEN 'Review Required'
        ELSE 'Normal'
    END AS manual_review_status

FROM public.loans_analysis
ORDER BY loan_id;
