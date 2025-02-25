select p.patient_num, p.sex_cd, p.age_in_years_num,
    count(distinct f.start_date) num_enc,
    count(distinct case when c.feature_name = 'Asthma' then start_date else null end) num_asthma,
    count(distinct case when c.feature_name = 'Chronic airway obstruction' then start_date else null end) num_copd,
    count(distinct case when cd.name_char like '%albuterol%' then start_date else null end) num_albuterol
from Patient_Dimension p
inner join observation_fact f on f.patient_num = p.patient_num
left join dt_keser_import_concept_feature c on c.concept_cd = f.Concept_Cd
left join concept_dimension cd on cd.concept_cd = f.Concept_Cd
group by p.patient_num, p.sex_cd, p.age_in_years_num
