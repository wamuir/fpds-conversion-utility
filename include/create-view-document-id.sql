CREATE VIEW IF NOT EXISTS documentID AS
 SELECT record.id AS id, record.docType as docType,
    awardContractID.agencyID AS awardContractAgencyID,
    awardContractID.PIID AS awardContractPIID,
    awardContractID.modNumber AS awardContractModNumber,
    awardContractID.transactionNumber AS awardContractTransactionNumber,
    IDVID.agencyID AS IDVAgencyID,
    IDVID.PIID AS IDVPIID,
    IDVID.modNumber AS IDVModNumber,
    referencedIDVID.agencyID AS referencedIDVagencyID,
    referencedIDVID.PIID AS referencedIDVPIID,
    referencedIDVID.modNumber AS referencedIDVmodNumber
  FROM record
  LEFT JOIN awardContractID ON record.id = awardContractID.id
  LEFT JOIN IDVID ON record.id = IDVID.id
  LEFT JOIN referencedIDVID ON record.id = referencedIDVID.id;
