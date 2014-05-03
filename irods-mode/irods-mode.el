;; iRODS Mode for Emacs 
;; Don Pellegrino (donald.a.pellegrino@gmail.com)
;; May 3, 2014

;; Based on the example given by Xah Lee in: "How to Write a Emacs
;; Major Mode for Syntax Coloring," 2008-11-30, online:
;; http://ergoemacs.org/emacs/elisp_syntax_coloring.html

;; Define several classes of keywords

;; The set of possible keyword is taken from the documentation on the
;; Wiki "Changes and Improvements to the Rule Language and the Rule
;; Engine" page at
;; http://wiki.irods.org/index.php/Changes_and_Improvements_to_the_Rule_Language_and_the_Rule_Engine.
(defvar irods-keywords)
(setq irods-keywords
      '("true"
	"false"
	"exp"
	"log"
	"abs"
	"floor"
	"ceiling"
	"average"
	"max"
	"min"
	"int"
	"double"
	"bool"
	"datetimef"
	"datetime"
	"timestr"
	"timestrf"
	"writeLine"
	"substr"
	"strlen"
	"split"
	"triml"
	"trimr"
	"str"
	"like"
	"regex"
	"on"
	"errorcode"
	"errormsg"
	"fail"
	"failmsg"
	"list"
	"elem"
	"setelem"
	"size"
	"hd"
	"tl"
	"cons"
	"if"
	"then"
	"else"
	"foreach"
	"let"
	"in"
	"match"
	"while"
	"SELECT"
	"WHERE"
	"count"
	"sum"
	"order_desc"
	"order_asc"))

;; The set of possible session variables is taken from the Wiki
;; "Attributes" page at https://wiki.irods.org/index.php/Attributes.
(defvar irods-sessionvars)
(setq irods-sessionvars
      '("$userNameClient"
	"$rodsZoneClient"
	"$privClient"
	"$authStrClient"
	"$userAuthSchemeClient"
	"$userNameProxy"
	"$rodsZoneProxy"
	"$privProxy"
	"$authStrProxy"
	"$userAuthSchemeProxy"
	"$otherUser"
	"$connectCnt"
	"$connectSock"
	"$connectOption"
	"$connectStatus"
	"$connectApiTnx"
	"$objPath"
	"$dataType"
	"$dataSize"
	"$chksum"
	"$version"
	"$filePath"
	"$replNum"
	"$replStatus"
	"$writeFlag"
	"$dataOwner"
	"$dataOwnerZone"
	"$dataComments"
	"$dataAccess"
	"$dataAccessInx"
	"$dataId"
	"$collId"
	"$statusString"
	"$destRescName"
	"$backupRescName" 
	"$rescName"
	"$rescGroupName"
	"$zoneName"
	"$rescLoc"
	"$rescType"
	"$rescTypeInx" 
	"$rescClass"
	"$rescClassInx"
	"$rescVaultPath"
	"$rescMaxObjSize"
	"$freeSpace" 
	"$freeSpaceTimeStamp"
	"$rescInfo"
	"$rescId"
	"$rescComments"
	"$collName"
	"$collParentName"
	"$otherUserName"
	"$otherUserZone"
	"$otherUserType"))

;; The set of possible actions is taken from the list on the Wiki
;; "Attributes" page at http://wiki.irods.org/index.php/Attributes
(defvar irods-events)
(setq irods-events
      '("acSetRescSchemeForCreate"
	"acPreprocForDataObjOpen"
	"acSetMultiReplPerResc" 
	"acPostProcForPut" 
	"acPostProcForCopy" 
	"acPostProcForFilePathReg" 
	"acPostProcForCreate" 
	"acPostProcForOpen" 
	"acSetNumThreads"
	"acDataDeletePolicy"
	"acPostProcForDelete"
	"acNoChkFilePathPerm"
	"acTrashPolicy"
	"acSetPublicUserPolicy"
	"acSetValuePathPolicy"
	"acSetReServerNumProc"
	"acPreprocForCollCreate"
	"acPostProcForCollCreate"
	"acPreProcForRmColl"
	"acPostProcForRmColl"
	"acPreProcForModifyUser"
	"acPostProcForModifyUser"
	"acPreProcForModifyAVUmetadata"
	"acPostProcForModifyAVUmetadata"
	"acPreProcForCreateUser"
	"acPostProcForCreateUser"
	"acPreProcForDeleteUser"
	"acPostProcForDeleteUser"
	"acPreProcForCreateResource"
	"acPostProcForCreateResource"
	"acPreProcForCreateToken"
	"acPostProcForCreateToken"
	"acPreProcForModifyUserGroup"
	"acPostProcForModifyUserGroup"
	"acPreProcForDeleteResource"
	"acPostProcForDeleteResource"
	"acPreProcForDeleteToken"
	"acPostProcForDeleteToken"
	"acPreProcForModifyResource"
	"acPostProcForModifyResource"
	"acPreProcForModifyResourceGroup"
	"acPostProcForModifyResourceGroup"
	"acPreProcForModifyCollMeta"
	"acPostProcForModifyCollMeta"
	"acPreProcForModifyDataObjMeta"
	"acPostProcForModifyDataObjMeta"
	"acPreProcForModifyAccessControl"
	"acPostProcForModifyAccessControl"
	"acPreProcForObjRename"
	"acPostProcForObjRename"
	"acPreProcForGenQuery"
	"acPostProcForGenQuery"
	"acPreProcForExecCmd"
	"acCreateUser"
	"acCreateUserF1"
	"acVacuum"
	"acCreateDefaultCollections"
	"acCreateUserZoneCollections"
	"acCreateCollByAdmin"
	"acDeleteUser"
	"acDeleteUserF1"
	"acDeleteDefaultCollections"
	"acDeleteUserZoneCollections"
	"acDeleteCollByAdmin"
	"acRenameLocalZone"
	"acGetUserByDN"
	"acAclPolicy" ))

;; The set of iRODS microservices is taken from the iRODS
;; documentation at https://wiki.irods.org/doxygen/globals.html
(defvar irods-functions)
(setq irods-functions
      '("msiAclPolicy"
	"msiAddConditionToGenQuery"
	"msiAddKeyVal"
	"msiAddKeyValToMspStr"
	"msiAddSelectFieldToGenQuery"
	"msiAddToNcArray"
	"msiAddUserToGroup"
	"msiAdmAddAppRuleStruct"
	"msiAdmClearAppRuleStruct"
	"msiAdmInsertRulesFromStructIntoDB"
	"msiAdmReadRulesFromFileIntoStruct"
	"msiAdmShowIRB"
	"msiAdmWriteRulesFromStructIntoFile"
	"msiApplyDCMetadataTemplate"
	"msiAssociateKeyValuePairsToObj"
	"msiAutoReplicateService"
	"msiBytesBufToStr"
	"msiCheckAccess"
	"msiCheckHostAccessControl"
	"msiCheckOwner"
	"msiCheckPermission"
	"msiCloseGenQuery"
	"msiCollCreate"
	"msiCollectionSpider"
	"msiCollRepl"
	"msiCollRsync"
	"msiCommit"
	"msiConvertCurrency"
	"msiCopyAVUMetadata"
	"msiCreateCollByAdmin"
	"msiCreateUser"
	"msiCreateUserAccountsFromDataObj"
	"msiCreateXmsgInp"
	"msiDataObjAutoMove"
	"msiDataObjChksum"
	"msiDataObjChksumWithOptions"
	"msiDataObjClose"
	"msiDataObjCopy"
	"msiDataObjCreate"
	"msiDataObjGet"
	"msiDataObjGetWithOptions"
	"msiDataObjLseek"
	"msiDataObjOpen"
	"msiDataObjPhymv"
	"msiDataObjPut"
	"msiDataObjPutWithOptions"
	"msiDataObjRead"
	"msiDataObjRename"
	"msiDataObjRepl"
	"msiDataObjReplWithOptions"
	"msiDataObjRsync"
	"msiDataObjTrim"
	"msiDataObjUnlink"
	"msiDataObjWrite"
	"msiDboExec"
	"msiDbrCommit"
	"msiDbrRollback"
	"msiDeleteCollByAdmin"
	"msiDeleteDisallowed"
	"msiDeleteUnusedAVUs"
	"msiDeleteUser"
	"msiDeleteUsersFromDataObj"
	"msiDigestMonStat"
	"msiExecCmd"
	"msiExecGenQuery"
	"msiExecStrCondQuery"
	"msiExecStrCondQueryWithOptions"
	"msiExecStrCondQueryWithOptionsNew"
	"msiExit"
	"msiExportRecursiveCollMeta"
	"msiExtractNaraMetadata"
	"msiExtractTemplateMDFromBuf"
	"msiFlagDataObjwithAVU"
	"msiFlagInfectedObjs"
	"msiFloatToString"
	"msiFlushMonStat"
	"msiFreeBuffer"
	"msiFreeNcStruct"
	"msiFtpGet"
	"msiGetAuditTrailInfoByActionID"
	"msiGetAuditTrailInfoByKeywords"
	"msiGetAuditTrailInfoByObjectID"
	"msiGetAuditTrailInfoByTimeStamp"
	"msiGetAuditTrailInfoByUserID"
	"msiGetCollectionACL"
	"msiGetCollectionContentsReport"
	"msiGetCollectionPSmeta"
	"msiGetCollectionSize"
	"msiGetContInxFromGenQueryOut"
	"msiGetDataObjACL"
	"msiGetDataObjAIP"
	"msiGetDataObjAVUs"
	"msiGetDataObjPSmeta"
	"msiGetDiffTime"
	"msiGetFormattedSystemTime"
	"msiGetIcatTime"
	"msiGetMoreRows"
	"msiGetObjectPath"
	"msiGetObjType"
	"msiGetQuote"
	"msiGetRescAddr"
	"msiGetRulesFromDBIntoStruct"
	"msiGetSessionVarValue"
	"msiGetStderrInExecCmdOut"
	"msiGetStdoutInExecCmdOut"
	"msiGetSystemTime"
	"msiGetTaggedValueFromString"
	"msiGetUserACL"
	"msiGetUserInfo"
	"msiGetValByKey"
	"msiGoodFailure"
	"msiGuessDataType"
	"msiH5Dataset_read"
	"msiH5Dataset_read_attribute"
	"msiH5File_close"
	"msiH5File_open"
	"msiH5Group_read_attribute"
	"msiHello"
	"msiHumanToSystemTime"
	"msiImageConvert"
	"msiImageGetProperties"
	"msiImageScale"
	"msiIp2location"
	"msiIsColl"
	"msiIsData"
	"msiListEnabledMS"
	"msiLoadACLFromDataObj"
	"msiLoadMetadataFromDataObj"
	"msiLoadMetadataFromXml"
	"msiLoadUserModsFromDataObj"
	"msiMakeGenQuery"
	"msiMakeQuery"
	"msiMergeDataCopies"
	"msiNcClose"
	"msiNcCreate"
	"msiNcGetArrayLen"
	"msiNcGetAttNameInInqOut"
	"msiNcGetAttValStrInInqOut"
	"msiNcGetDataType"
	"msiNcGetDimLenInInqOut"
	"msiNcGetDimNameInInqOut"
	"msiNcGetElementInArray"
	"msiNcGetFormatInInqOut"
	"msiNcGetGrpInInqOut"
	"msiNcGetNattsInInqOut"
	"msiNcGetNdimsInInqOut"
	"msiNcGetNGrpsInInqOut"
	"msiNcGetNumDim"
	"msiNcGetNvarsInInqOut"
	"msiNcGetVarIdInInqOut"
	"msiNcGetVarNameInInqOut"
	"msiNcGetVarsByType"
	"msiNcGetVarTypeInInqOut"
	"msiNcInq"
	"msiNcInqGrps"
	"msiNcInqId"
	"msiNcInqWithId"
	"msiNcIntDataTypeToStr"
	"msiNcOpen"
	"msiNcOpenGroup"
	"msiNcRegGlobalAttr"
	"msiNcSubsetVar"
	"msiNcVarStat"
	"msiNoChkFilePathPerm"
	"msiNoTrashCan"
	"msiObjByName"
	"msiobjget_dbo"
	"msiobjget_http"
	"msiobjget_irods"
	"msiobjget_slink"
	"msiobjget_srb"
	"msiobjget_test"
	"msiobjget_z3950"
	"msiobjput_dbo"
	"msiobjput_http"
	"msiobjput_irods"
	"msiobjput_slink"
	"msiobjput_srb"
	"msiobjput_test"
	"msiobjput_z3950"
	"msiObjStat"
	"msiOprDisallowed"
	"msiPhyBundleColl"
	"msiPhyPathReg"
	"msiPostThis"
	"msiPrintGenQueryInp"
	"msiPrintGenQueryOutToBuffer"
	"msiPrintKeyValPair"
	"msiPropertiesAdd"
	"msiPropertiesClear"
	"msiPropertiesClone"
	"msiPropertiesExists"
	"msiPropertiesFromString"
	"msiPropertiesGet"
	"msiPropertiesNew"
	"msiPropertiesRemove"
	"msiPropertiesSet"
	"msiPropertiesToString"
	"msiQuota"
	"msiRcvXmsg"
	"msiRdaCommit"
	"msiRdaNoResults"
	"msiRdaRollback"
	"msiRdaToDataObj"
	"msiRdaToStdout"
	"msiReadMDTemplateIntoTagStruct"
	"msiRecursiveCollCopy"
	"msiRegisterData"
	"msiRemoveKeyValuePairsFromObj"
	"msiRenameCollection"
	"msiRenameLocalZone"
	"msiReplColl"
	"msiRmColl"
	"msiRollback"
	"msiSdssImgCutout_GetJpeg"
	"msiSendMail"
	"msiSendStdoutAsEmail"
	"msiSendXmsg"
	"msiServerBackup"
	"msiServerMonPerf"
	"msiSetACL"
	"msiSetBulkPutPostProcPolicy"
	"msiSetChkFilePathPerm"
	"msiSetDataObjAvoidResc"
	"msiSetDataObjPreferredResc"
	"msiSetDataType"
	"msiSetDataTypeFromExt"
	"msiSetDefaultResc"
	"msiSetGraftPathScheme"
	"msiSetKeyValuePairsToObj"
	"msiSetMultiReplPerResc"
	"msiSetNoDirectRescInp"
	"msiSetNumThreads"
	"msiSetPublicUserOpr"
	"msiSetQuota"
	"msiSetRandomScheme"
	"msiSetReplComment"
	"msiSetRescQuotaPolicy"
	"msiSetRescSortScheme"
	"msiSetReServerNumProc"
	"msiSetResource"
	"msiSleep"
	"msiSortDataObj"
	"msiSplitPath"
	"msiStageDataObj"
	"msiStoreVersionWithTS"
	"msiStrArray2String"
	"msiStrchop"
	"msiString2KeyValPair"
	"msiString2StrArray"
	"msiStripAVUs"
	"msiStrlen"
	"msiStrToBytesBuf"
	"msiStructFileBundle"
	"msiSubstr"
	"msiSysChksumDataObj"
	"msiSysMetaModify"
	"msiSysReplDataObj"
	"msiTarFileCreate"
	"msiTarFileExtract"
	"msiTwitterPost"
	"msiVacuum"
	"msiVerifyACL"
	"msiVerifyAVU"
	"msiVerifyDataType"
	"msiVerifyExpiry"
	"msiVerifyFileSizeRange"
	"msiVerifyOwner"
	"msiWriteRodsLog"
	"msiXmlDocSchemaValidate"
	"msiXmsgCreateStream"
	"msiXmsgServerConnect"
	"msiXmsgServerDisConnect"
	"msiXsltApply"
	"msiz3950Submit"))

;; Create the RegEx string for each class of keywords.
(defvar irods-keywords-regexp)
(setq irods-keywords-regexp (regexp-opt irods-keywords 'words))
(defvar irods-sessionvars-regexp)
(setq irods-sessionvars-regexp (regexp-opt irods-sessionvars 'words))
(defvar irods-events-regexp)
(setq irods-events-regexp (regexp-opt irods-events 'words))
(defvar irods-functions-regexp)
(setq irods-functions-regexp (regexp-opt irods-functions 'words))

;; Clear Memory
(setq irods-keywords nil)
(setq irods-sessionvars nil)
(setq irods-events nil)
(setq irods-functions nil)

;; Create the list for font-lock. Each class of keyword is given a
;; particular face.
(defvar irods-font-lock-keywords)
(setq irods-font-lock-keywords
      `((,irods-events-regexp . font-lock-builtin-face)
	(,irods-sessionvars-regexp . font-lock-constant-face)
	(,irods-functions-regexp . font-lock-function-name-face)
	(,irods-keywords-regexp . font-lock-keyword-face)))

(define-derived-mode irods-mode fundamental-mode
  "irods-mode"
  "Major mode for editing iRODS Rules."

  ;; Code for syntax highlighting
  (setq font-lock-defaults '((irods-font-lock-keywords)))

  ;; Clear memory
  (setq irods-keywords-regexp nil)
  (setq irods-sessionvars-regexp nil)
  (setq irods-events-regexp nil)
  (setq irods-functions-regexp nil))

(provide 'irods-mode)
