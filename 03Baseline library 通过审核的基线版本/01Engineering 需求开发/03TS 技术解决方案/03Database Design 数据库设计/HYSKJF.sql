/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2018/8/7 19:52:35                            */
/*==============================================================*/


drop table if exists Admin;

drop table if exists AdminLog;

drop table if exists Advertise;

drop table if exists Application;

drop table if exists BalanceHistory;

drop table if exists Consume;

drop table if exists CreditCash;

drop table if exists CreditExchange;

drop table if exists CreditHistory;

drop table if exists CreditSubmit;

drop table if exists Evaluation;

drop table if exists HotelRooms;

drop table if exists LoginLog;

drop table if exists Member;

drop table if exists MemberAccount;

drop table if exists MemberCard;

drop table if exists MemberCardReceive;

drop table if exists MemberInfoChange;

drop table if exists MemberManager;

drop table if exists Merchant;

drop table if exists MerchantAccount;

drop table if exists MerchantConfigure;

drop table if exists MerchantInfo;

drop table if exists MerchantMoneyReturn;

drop table if exists Message;

drop table if exists News;

drop table if exists OperationLog;

drop table if exists PreMemberCard;

drop table if exists ProductInfo;

drop table if exists Purchase;

drop table if exists Reissue;

drop table if exists Requirement;

drop table if exists Suggestion;

drop table if exists merchantInfoModified;

/*==============================================================*/
/* Table: Admin                                                 */
/*==============================================================*/
create table Admin
(
   AdminID              numeric(8,0) not null,
   AdminName            varchar(20),
   AdminAcc             varchar(20),
   AdminPwd             varchar(32),
   primary key (AdminID)
);

/*==============================================================*/
/* Table: AdminLog                                              */
/*==============================================================*/
create table AdminLog
(
   adlogID              int not null,
   AdminID              numeric(8,0) not null,
   adlogFunction        varchar(50),
   adlogInfo            text,
   adlogTime            date,
   primary key (adlogID)
);

/*==============================================================*/
/* Table: Advertise                                             */
/*==============================================================*/
create table Advertise
(
   adverID              int not null,
   merID                numeric(8,0),
   adverImage           varchar(150),
   adverDescript        text,
   adverURL             varchar(150),
   adverType            varchar(10),
   adverCost            float,
   adverStart           date,
   adverEnd             date,
   primary key (adverID)
);

/*==============================================================*/
/* Table: Application                                           */
/*==============================================================*/
create table Application
(
   acaID                int not null,
   merID                numeric(8,0),
   AdminID              numeric(8,0),
   acaMerchant          numeric(8,0),
   acaStat              varchar(10),
   acaReallo            numeric(8,0),
   acaReaTime           date,
   acaaMerchant         numeric(8,0),
   primary key (acaID)
);

/*==============================================================*/
/* Table: BalanceHistory                                        */
/*==============================================================*/
create table BalanceHistory
(
   vhID                 int not null,
   memID                numeric(18,0) not null,
   mcID                 numeric(18,0) not null,
   vhMoney              float,
   vhTime               date,
   primary key (vhID)
);

/*==============================================================*/
/* Table: Consume                                               */
/*==============================================================*/
create table Consume
(
   cumID                int not null,
   memID                numeric(18,0) not null,
   mcID                 numeric(18,0) not null,
   cumMoney             float,
   cumWay               varchar(20),
   cumCredit            float,
   cumMerchant          numeric(8,0),
   macID                int,
   cumTime              datetime,
   primary key (cumID)
);

/*==============================================================*/
/* Table: CreditCash                                            */
/*==============================================================*/
create table CreditCash
(
   ccID                 int not null,
   memID                numeric(18,0),
   mcID                 numeric(18,0),
   ccWays               varchar(20),
   ccBankAccount        int,
   ccCredit             float,
   ccMoney              float,
   ccTime0              datetime,
   primary key (ccID)
);

/*==============================================================*/
/* Table: CreditExchange                                        */
/*==============================================================*/
create table CreditExchange
(
   ceStat               varchar(20),
   ceID                 int not null,
   memID                numeric(18,0) not null,
   mcID                 numeric(18,0) not null,
   ceWays               varchar(20),
   ceItem               varchar(20),
   ceAmount             int,
   ceCost               float,
   ceAdress             varchar(20),
   ceTime               datetime,
   primary key (ceID)
);

/*==============================================================*/
/* Table: CreditHistory                                         */
/*==============================================================*/
create table CreditHistory
(
   chID                 int not null,
   memID                numeric(18,0) not null,
   mcID                 numeric(18,0) not null,
   chCredit             float,
   chRemain             float,
   chType               varchar(16),
   primary key (chID)
);

/*==============================================================*/
/* Table: CreditSubmit                                          */
/*==============================================================*/
create table CreditSubmit
(
   csID                 int not null,
   merID                numeric(8,0),
   csStat               bool,
   csMoney              float,
   csCredit             float,
   primary key (csID)
);

/*==============================================================*/
/* Table: Evaluation                                            */
/*==============================================================*/
create table Evaluation
(
   evaID                int not null,
   AdminID              numeric(8,0),
   merID                numeric(8,0) not null,
   memID                numeric(18,0) not null,
   evaInfo              varchar(200),
   evaIP                varchar(20),
   evaBy                numeric(18,0),
   evaTime              datetime,
   evaEnable            bool,
   evaReply             bool,
   evaReplyBy           numeric(8,0),
   evaRepInfo           varchar(200),
   evaRepTime           datetime,
   primary key (evaID)
);

/*==============================================================*/
/* Table: HotelRooms                                            */
/*==============================================================*/
create table HotelRooms
(
   pduID                int not null,
   merID                numeric(8,0),
   pduName              varchar(15),
   pduPrice             float,
   pduMemPrice          float,
   pduIntro             varchar(100),
   pduImage             varchar(150),
   pduRemain            int,
   hrRoomtype           varchar(20),
   hrBreadfast          varchar(20),
   hrBed                varchar(20),
   hrNetwork            varchar(20),
   hrRoomStat           varchar(20),
   hrSpecialPrice       float,
   hrWeekendPrice       float,
   hrAvailable          bool,
   hrComment            varchar(50),
   primary key (pduID)
);

/*==============================================================*/
/* Table: LoginLog                                              */
/*==============================================================*/
create table LoginLog
(
   llogID               int not null,
   merID                numeric(8,0),
   macID                int,
   llogAccount          int,
   llogDate             datetime,
   llogType             varchar(10),
   primary key (llogID)
);

/*==============================================================*/
/* Table: Member                                                */
/*==============================================================*/
create table Member
(
   memID                numeric(18,0) not null,
   memCer               varchar(16),
   memCerID             numeric(20,0),
   memName              varchar(16),
   memSex               varchar(4),
   memBirth             date,
   memPhone             int,
   memAdress            text,
   memEmail             varchar(100),
   primary key (memID)
);

/*==============================================================*/
/* Table: MemberAccount                                         */
/*==============================================================*/
create table MemberAccount
(
   memID                numeric(18,0) not null,
   maID                 int,
   maName               varchar(20),
   maPwd                varchar(32),
   maCumPwd             varchar(10),
   maEnable             bool,
   primary key (memID)
);

/*==============================================================*/
/* Table: MemberCard                                            */
/*==============================================================*/
create table MemberCard
(
   memID                numeric(18,0) not null,
   mcID                 numeric(18,0) not null,
   merID                numeric(8,0),
   mcType               varchar(10),
   mcCredit             float,
   mcBalance            float,
   mcEnable             bool,
   primary key (memID, mcID)
);

/*==============================================================*/
/* Table: MemberCardReceive                                     */
/*==============================================================*/
create table MemberCardReceive
(
   mcrID                int not null,
   AdminID              numeric(8,0) not null,
   merID                numeric(8,0) not null,
   mcrReceivedCount     int,
   mcrZone              varchar(50),
   mcrTime              date,
   primary key (mcrID)
);

/*==============================================================*/
/* Table: MemberInfoChange                                      */
/*==============================================================*/
create table MemberInfoChange
(
   micID                int not null,
   memID                numeric(18,0) not null,
   micCer               varchar(16),
   micCerID             int,
   micName              varchar(16),
   micSex               varchar(4),
   micPhone             int,
   micBirth             date,
   micAdredd            varchar(100),
   micEmail             varchar(100),
   micReason            varchar(100),
   micTime              datetime,
   primary key (micID)
);

/*==============================================================*/
/* Table: MemberManager                                         */
/*==============================================================*/
create table MemberManager
(
   mmaID                int not null,
   memID                numeric(18,0) not null,
   merID                numeric(8,0) not null,
   macID                int not null,
   mmaTime              date,
   mmanagerID           int,
   primary key (mmaID)
);

/*==============================================================*/
/* Table: Merchant                                              */
/*==============================================================*/
create table Merchant
(
   merID                numeric(8,0) not null,
   merSubID             int,
   merTopID             int,
   merType              varchar(10),
   merName              varchar(50),
   merCumPresent        float,
   merDicPresent        float,
   merAppStat           bool,
   merRecommend         bool,
   primary key (merID)
);

/*==============================================================*/
/* Table: MerchantAccount                                       */
/*==============================================================*/
create table MerchantAccount
(
   merID                numeric(8,0) not null,
   macID                int not null,
   macAcc               varchar(15),
   macCumAcc            int,
   macPasswd            varchar(32),
   macAccType           int,
   macLastLogin         datetime,
   macEnable            bool,
   primary key (merID, macID)
);

/*==============================================================*/
/* Table: MerchantConfigure                                     */
/*==============================================================*/
create table MerchantConfigure
(
   merID                numeric(8,0) not null,
   confIP               varchar(20),
   confCNenable         bool,
   confMPenable         bool,
   confMerKind          varchar(10),
   confEnableLevel      bool,
   confEnableImage      bool,
   confEnableHotel      bool,
   confMaxPurchase      float,
   primary key (merID)
);

/*==============================================================*/
/* Table: MerchantInfo                                          */
/*==============================================================*/
create table MerchantInfo
(
   merID                numeric(8,0) not null,
   merIntroduce         varchar(200),
   merImage             varchar(100),
   merMainImage         bool,
   merAdress            text,
   merTelphone          varchar(18),
   merFax               varchar(20),
   merURL               varchar(50),
   merEmail             varchar(50),
   merPrincipal         varchar(50),
   merAppellation       varchar(20),
   merDuty              varchar(20),
   merPhone             varchar(20),
   merLevel             int,
   merPostNum           varchar(15),
   merProvince          varchar(20),
   merCity              varchar(20),
   merArea              varchar(20),
   merLandmark          varchar(100),
   merDiscount          varchar(100),
   merDiscountEvent     varchar(100),
   primary key (merID)
);

/*==============================================================*/
/* Table: MerchantMoneyReturn                                   */
/*==============================================================*/
create table MerchantMoneyReturn
(
   merID                numeric(8,0) not null,
   mmrID                int,
   mmrMoney             float,
   mmrConsumoMoney      float,
   mmrStat              varchar(20)
);

/*==============================================================*/
/* Table: Message                                               */
/*==============================================================*/
create table Message
(
   mesID                int not null,
   mesTitle             varchar(50),
   mesContent           text,
   mesSource            numeric(8,0),
   mesDestination       numeric(8,0),
   mesRead              bool,
   primary key (mesID)
);

/*==============================================================*/
/* Table: News                                                  */
/*==============================================================*/
create table News
(
   newsID               int not null,
   newsTitle            varchar(50),
   newsContent          text,
   newsType             varchar(10),
   newsImage            varchar(50),
   newsBelong           varchar(10),
   newsEnableHP         bool,
   newsEnableAct        bool,
   primary key (newsID)
);

/*==============================================================*/
/* Table: OperationLog                                          */
/*==============================================================*/
create table OperationLog
(
   ologID               int not null,
   merID                numeric(8,0),
   macID                int,
   ologAccount          int,
   ologTime             datetime,
   ologURL              varchar(50),
   ologFuntion          varchar(50),
   ologOperation        text,
   ologInfo             text,
   primary key (ologID)
);

/*==============================================================*/
/* Table: PreMemberCard                                         */
/*==============================================================*/
create table PreMemberCard
(
   pmcID                numeric(18,0) not null,
   merID                numeric(8,0) not null,
   pmcStat              bool,
   pmcMerchant          numeric(8,0),
   pmcMerMaker          numeric(8,0),
   pmcProvider          int,
   pmcMakeTime          date,
   pmcProvideTime       date,
   primary key (pmcID)
);

/*==============================================================*/
/* Table: ProductInfo                                           */
/*==============================================================*/
create table ProductInfo
(
   pduID                int not null,
   merID                numeric(8,0) not null,
   pduName              varchar(15),
   pduPrice             float,
   pduMemPrice          float,
   pduIntro             varchar(100),
   pduImage             varchar(150),
   pduRemain            int,
   primary key (pduID)
);

/*==============================================================*/
/* Table: Purchase                                              */
/*==============================================================*/
create table Purchase
(
   purID                int not null,
   memID                numeric(18,0) not null,
   mcID                 numeric(18,0) not null,
   purBelong            numeric(8,0),
   purMerchant          numeric(8,0),
   purMoney             float,
   purRemain            float,
   purTime              datetime,
   primary key (purID)
);

/*==============================================================*/
/* Table: Reissue                                               */
/*==============================================================*/
create table Reissue
(
   reiID                int not null,
   memID                numeric(18,0),
   reiReason            text,
   reiTime              date,
   reiOldNum            numeric(18,0) not null,
   reiNewNum            numeric(18,0) not null,
   primary key (reiID)
);

/*==============================================================*/
/* Table: Requirement                                           */
/*==============================================================*/
create table Requirement
(
   reqID                int not null,
   memID                numeric(18,0) not null,
   reqInfo              varchar(200),
   reqTime              datetime,
   reqBy                numeric(18,0),
   reqReply             bool,
   reqRepContent        varchar(200),
   reqRepBy             numeric(8,0),
   reqRepTime           datetime,
   primary key (reqID)
);

/*==============================================================*/
/* Table: Suggestion                                            */
/*==============================================================*/
create table Suggestion
(
   sugID                int not null,
   merID                numeric(8,0) not null,
   sugTitle             varchar(50),
   sugContent           text,
   sugDate              date,
   primary key (sugID)
);

/*==============================================================*/
/* Table: merchantInfoModified                                  */
/*==============================================================*/
create table merchantInfoModified
(
   merID                numeric(8,0) not null,
   Attribute_249        int not null,
   merIntroduce         varchar(200),
   merImage             varchar(100),
   merMainImage         bool,
   merAdress            text,
   merTelphone          varchar(18),
   merFax               varchar(20),
   merURL               varchar(50),
   merEmail             varchar(50),
   merPrincipal         varchar(50),
   merAppellation       varchar(20),
   merDuty              varchar(20),
   merPhone             varchar(20),
   merLevel             int,
   merPostNum           varchar(15),
   merProvince          varchar(20),
   merCity              varchar(20),
   merArea              varchar(20),
   merLandmark          varchar(100),
   merDiscount          varchar(100),
   merDiscountEvent     varchar(100),
   Attribute_250        varchar(20) not null,
   primary key (merID, Attribute_249)
);

alter table AdminLog add constraint FK_Relationship_34 foreign key (AdminID)
      references Admin (AdminID) on delete restrict on update restrict;

alter table Advertise add constraint FK_Relationship_19 foreign key (merID)
      references Merchant (merID) on delete restrict on update restrict;

alter table Application add constraint FK_Reference_28 foreign key (acaaMerchant)
      references Merchant (merID) on delete restrict on update restrict;

alter table Application add constraint FK_Relationship_21 foreign key (acaMerchant)
      references Merchant (merID) on delete restrict on update restrict;

alter table Application add constraint FK_Relationship_24 foreign key (acaReallo)
      references Admin (AdminID) on delete restrict on update restrict;

alter table BalanceHistory add constraint FK_Relationship_27 foreign key (memID, mcID)
      references MemberCard (memID, mcID) on delete restrict on update restrict;

alter table Consume add constraint FK_Reference_42 foreign key (cumMerchant, macID)
      references MerchantAccount (merID, macID) on delete restrict on update restrict;

alter table Consume add constraint FK_Relationship_32 foreign key (memID, mcID)
      references MemberCard (memID, mcID) on delete restrict on update restrict;

alter table CreditCash add constraint FK_Relationship_41 foreign key (memID, mcID)
      references MemberCard (memID, mcID) on delete restrict on update restrict;

alter table CreditExchange add constraint FK_Relationship_40 foreign key (memID, mcID)
      references MemberCard (memID, mcID) on delete restrict on update restrict;

alter table CreditHistory add constraint FK_Relationship_31 foreign key (memID, mcID)
      references MemberCard (memID, mcID) on delete restrict on update restrict;

alter table CreditSubmit add constraint FK_Relationship_39 foreign key (merID)
      references Merchant (merID) on delete restrict on update restrict;

alter table Evaluation add constraint FK_Relationship_23 foreign key (evaBy)
      references Member (memID) on delete restrict on update restrict;

alter table Evaluation add constraint FK_Relationship_36 foreign key (evaReplyBy)
      references Admin (AdminID) on delete restrict on update restrict;

alter table Evaluation add constraint FK_Relationship_7 foreign key (merID)
      references Merchant (merID) on delete restrict on update restrict;

alter table HotelRooms add constraint FK_Inheritance_1 foreign key (pduID)
      references ProductInfo (pduID) on delete restrict on update restrict;

alter table LoginLog add constraint FK_Relationship_30 foreign key (merID, macID)
      references MerchantAccount (merID, macID) on delete restrict on update restrict;

alter table MemberAccount add constraint FK_Relationship_35 foreign key (memID)
      references Member (memID) on delete restrict on update restrict;

alter table MemberCard add constraint FK_Relationship_28 foreign key (memID)
      references Member (memID) on delete restrict on update restrict;

alter table MemberCard add constraint FK_Relationship_29 foreign key (merID)
      references Merchant (merID) on delete restrict on update restrict;

alter table MemberCardReceive add constraint FK_Relationship_43 foreign key (merID)
      references Merchant (merID) on delete restrict on update restrict;

alter table MemberCardReceive add constraint FK_Relationship_44 foreign key (AdminID)
      references Admin (AdminID) on delete restrict on update restrict;

alter table MemberInfoChange add constraint FK_Relationship_13 foreign key (memID)
      references Member (memID) on delete restrict on update restrict;

alter table MemberManager add constraint FK_Relationship_37 foreign key (merID, mmanagerID)
      references MerchantAccount (merID, macID) on delete restrict on update restrict;

alter table MemberManager add constraint FK_Relationship_38 foreign key (memID)
      references Member (memID) on delete restrict on update restrict;

alter table MerchantAccount add constraint FK_Relationship_1 foreign key (merID)
      references Merchant (merID) on delete restrict on update restrict;

alter table MerchantConfigure add constraint FK_Relationship_42 foreign key (merID)
      references Merchant (merID) on delete restrict on update restrict;

alter table MerchantInfo add constraint FK_Relationship_3 foreign key (merID)
      references Merchant (merID) on delete restrict on update restrict;

alter table MerchantMoneyReturn add constraint FK_Relationship_45 foreign key (merID)
      references Merchant (merID) on delete restrict on update restrict;

alter table Message add constraint FK_Reference_43 foreign key (mesSource)
      references Merchant (merID) on delete restrict on update restrict;

alter table Message add constraint FK_Reference_44 foreign key (mesSource)
      references Admin (AdminID) on delete restrict on update restrict;

alter table Message add constraint FK_Reference_45 foreign key (mesDestination)
      references Admin (AdminID) on delete restrict on update restrict;

alter table Message add constraint FK_Reference_46 foreign key (mesDestination)
      references Merchant (merID) on delete restrict on update restrict;

alter table OperationLog add constraint FK_Relationship_22 foreign key (merID, macID)
      references MerchantAccount (merID, macID) on delete restrict on update restrict;

alter table PreMemberCard add constraint FK_Reference_41 foreign key (pmcMerchant, pmcProvider)
      references MerchantAccount (merID, macID) on delete restrict on update restrict;

alter table PreMemberCard add constraint FK_Reference_47 foreign key (pmcMerMaker)
      references Admin (AdminID) on delete restrict on update restrict;

alter table PreMemberCard add constraint FK_Relationship_9 foreign key (pmcMerMaker)
      references Merchant (merID) on delete restrict on update restrict;

alter table ProductInfo add constraint FK_Relationship_16 foreign key (merID)
      references Merchant (merID) on delete restrict on update restrict;

alter table Purchase add constraint FK_Reference_24 foreign key (purBelong)
      references Merchant (merID) on delete restrict on update restrict;

alter table Purchase add constraint FK_Reference_26 foreign key (purMerchant)
      references Merchant (merID) on delete restrict on update restrict;

alter table Purchase add constraint FK_Relationship_26 foreign key (memID, mcID)
      references MemberCard (memID, mcID) on delete restrict on update restrict;

alter table Reissue add constraint FK_Reference_29 foreign key (memID, reiNewNum)
      references MemberCard (memID, mcID) on delete restrict on update restrict;

alter table Reissue add constraint FK_Reference_30 foreign key (memID, reiOldNum)
      references MemberCard (memID, mcID) on delete restrict on update restrict;

alter table Reissue add constraint FK_Relationship_33 foreign key (memID)
      references Member (memID) on delete restrict on update restrict;

alter table Requirement add constraint FK_Reference_31 foreign key (reqRepBy)
      references Admin (AdminID) on delete restrict on update restrict;

alter table Requirement add constraint FK_Relationship_25 foreign key (reqBy)
      references Member (memID) on delete restrict on update restrict;

alter table Suggestion add constraint FK_Relationship_20 foreign key (merID)
      references Merchant (merID) on delete restrict on update restrict;

alter table merchantInfoModified add constraint FK_Inheritance_2 foreign key (merID)
      references MerchantInfo (merID) on delete restrict on update restrict;

