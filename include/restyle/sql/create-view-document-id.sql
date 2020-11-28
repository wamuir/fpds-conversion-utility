CREATE VIEW IF NOT EXISTS documentID AS
  SELECT
    meta.id AS id,
    meta.docType as docType,
    awardContractID.agencyID AS awardContractAgencyID,
    awardContractID.PIID AS awardContractPIID,
    awardContractID.modNumber AS awardContractModNumber,
    awardContractID.transactionNumber AS awardContractTransactionNumber,
    IDVID.agencyID AS IDVAgencyID,
    IDVID.PIID AS IDVPIID,
    IDVID.modNumber AS IDVModNumber,
    OtherTransactionAwardContractID.agencyID AS OtherTransactionAwardContractAgencyID,
    OtherTransactionAwardContractID.PIID AS OtherTransactionAwardContractPIID,
    OtherTransactionAwardContractID.modNumber AS OtherTransactionAwardContractModNumber,
    OtherTransactionIDVID.agencyID AS OtherTransactionIDVAgencyID,
    OtherTransactionIDVID.PIID AS OtherTransactionIDVPIID,
    OtherTransactionIDVID.modNumber AS OtherTransactionIDVModNumber,
    referencedIDVID.agencyID AS referencedIDVagencyID,
    referencedIDVID.PIID AS referencedIDVPIID,
    referencedIDVID.modNumber AS referencedIDVmodNumber
  FROM meta
  LEFT JOIN awardContractID ON meta.id = awardContractID.id
  LEFT JOIN IDVID ON meta.id = IDVID.id
  LEFT JOIN OtherTransactionAwardContractID ON meta.id = OtherTransactionAwardContractID.id
  LEFT JOIN OtherTransactionIDVID ON meta.id = OtherTransactionIDVID.id
  LEFT JOIN referencedIDVID ON meta.id = referencedIDVID.id;
