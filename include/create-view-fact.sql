CREATE VIEW IF NOT EXISTS fact AS
  SELECT *
  FROM documentID
  LEFT JOIN competitionInformation on documentID.id = competitionInformation.id
  LEFT JOIN contractInformation on documentID.id = contractInformation.id
  LEFT JOIN contractMarketingData on documentID.id = contractMarketingdata.id
  LEFT JOIN contractorDataA on documentID.id = contractorDataA.id
  LEFT JOIN contractorDataB on documentID.id = contractorDataB.id
  LEFT JOIN dates on documentID.id = dates.id
  LEFT JOIN dollarValues on documentID.id = dollarValues.id
  LEFT JOIN legislativeMandates on documentID.id = legislativeMandates.id
  LEFT JOIN preferencePrograms on documentID.id = preferencePrograms.id
  LEFT JOIN productOrServiceInformation on documentID.id = productOrServiceInformation.id
  LEFT JOIN purchaserInformation on documentID.id = purchaserInformation.id
  LEFT JOIN solicitationID on documentID.id = solicitationID.id
  LEFT JOIN transactionInformation on documentID.id = transactionInformation.id;
