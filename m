Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3535B64C134
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Dec 2022 01:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237768AbiLNAef (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Dec 2022 19:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237744AbiLNAec (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Dec 2022 19:34:32 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3EB1DA79;
        Tue, 13 Dec 2022 16:34:31 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDLOCPo017259;
        Wed, 14 Dec 2022 00:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=ns4doCMIogENs7dEUwwt3w44xeLE3Bdj20dPZT718Vk=;
 b=EjkKYQFozoCyw2NjraJ1wZMFwxB7/1PXo0O2wY44mPbLQOi3LmGgId0oh5EpsrpkI07w
 Qqrt4r0/R20KFBsACEXGaJfdMkQbUaa4rVxNGQn9g2chAb7tFGIK84KIn89z5NJgo+yA
 CH3mJsFhYa6oBJ5PQ2cZwpTGanstjm9JKpLHSIkV1myJ2d70nhmmfyvOPB9q5vGm/pAq
 WMtzFJM8SL5qqH0dD1eiabCjyTLk/3HzxPT5i+ItG9Yf1xQb9jw02ICo3Xd7/v6KY3oT
 BnEV5QtWPCfdcuYoYpfwgDqLlVKAUWHgSY6y17XSnpHQUWIiWr5lkfZAugdB/vBQGwiR /g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyex0p16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 00:34:03 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BE00YSR012219;
        Wed, 14 Dec 2022 00:34:01 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3meyev4sed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 00:34:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCJvsqhOG8oBAavESYlYCHGvsGbTvRunPbZFqgFcQPjbQ9pdnA81bLPipDlxOR/H7pQ5Xn+N6Gqd0AqE3ELMPpAS0oLUOch0EDquDTs3PGjMObJogoATKatLyQLCt+BzPgIoo/6HP65Dwz0oa7h9DD7+dxx9rSrIQP90iu7f4bh9Z4npa9qB+0cDT0vhCwz2t3USKWckbxqVTlgCxrnIBHUKNPr4W5SJ143qqdQxTQSQaz3Rg7eeKm4+4fdBxfADbx6mqMIrn0f9t0TpwGx7acsYsLAVNmva5EPAUTzjL2EB2GmsVs3VBrkeX7v6f0ongAd2l4JIBFgV2fqdVrqZ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ns4doCMIogENs7dEUwwt3w44xeLE3Bdj20dPZT718Vk=;
 b=gtbl9Z1v7aBHwVaDAiWxT9QlZ9KOmIgAOCNhWW9lBHx4pNzn+h2YR6dHPf8CG0GN9mtHl+U+c0g2laFVhtVI4FzOA2+G1NBFO0mUCH+FBzGJGN/fNbDFuMgmDEvMk/8DMQXcVO1EUnxzENHBueQrlwOFO2xjvMszV+jEoKFXcGmRLIZ/lproYd9y1heRXO96V0D3VLCXvGnnQNW9wa6am/ZBJkkHI/q8X2JGofRNV7apKlA+9Vm7syNJ38eizF6davzeRAFExWHnsIR1MToFurpaeAOlbel0wfwI0w0lU45dbnOJPETSaS0/inPV7esMCTAHLdGq0jBJabIXMdvAhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ns4doCMIogENs7dEUwwt3w44xeLE3Bdj20dPZT718Vk=;
 b=GbtvxOZJ15rEsiHe2vjixQoMWybHsHfxziCNl35IHO61Hpkmmije2x1RbaFgWg9VkbzjkA1wbpKWoD+rN5L2O2RwU03PUXpmTClbWQDxD170h7U2uqwlmZhx3yTEYpAvGDI2zGMHKlH3eXHwjYY5EqDplRBtYwH2nUSMe3j3jRk=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by BN0PR10MB5223.namprd10.prod.outlook.com (2603:10b6:408:12a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 00:33:59 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4%4]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 00:33:59 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     jarkko@kernel.org, zohar@linux.ibm.com
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, pvorel@suse.cz, noodles@fb.com, tiwai@suse.de,
        eric.snowberg@oracle.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, erpalmer@linux.vnet.ibm.com,
        coxu@redhat.com, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v3 00/10] Add CA enforcement keyring restrictions
Date:   Tue, 13 Dec 2022 19:33:51 -0500
Message-Id: <20221214003401.4086781-1-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:5:40::26) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|BN0PR10MB5223:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a628d2b-e67a-4536-cd6a-08dadd6ae463
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vqh7/05/KlV8lJvBK7P6eVyFUw1GYpnbTVT0jWTOFAdHDVyt3kSYtKBk77DR5MRtgDL3MEJ8O31M+14/TwIyzppSUTY/Tp1FI0aRZSvjmN6PrJ5fSZMEeJ+/8bFqmykC0vCJ+Aq9E9UyjrjHXXvTqHzvxqpzeF7K+e0A5G2AWUrldJJQIrEDLdW+/ftC8tQwURkabaPVNiQehdtKI6wIMCSJrWQNvVyShKHH6eHw4OtkHl3imnoyfiYYMfKm3WhPJsbV7L5KfZrRsbNjF2ncDsYq3y+PPTmGajdyOQDHNwfEtJLumsmhkEoVhKxytoK3NgqOsUCesMIFhc1g1DwDLn8TT7Y40dRmF+m3dGoYL5Xmwd1iaHY8v2bwCs2ddvnPk9ZRjxPvs12K//a5okaUZCdSmI0tRXJGlRkOoYwLK/3RKbdz9FtAKpzK7xDQGfd6a9Gy13rMqrlzz36503fCnwFZO4upuF7sIjX1yKwOdr1KyNVIXBBsshgxhYtIkWhCXbrQi5TiwtwcHB+rBMBHnwbcMlDneDbhDr6LIHOfjF5VZd7Sjv91ibDdiuT0uxFupyHP1GlhunENOdcuEB75x2kgmGJI6mO6aBiCO13H2eTSIK52NWK19eX/raUA0XEn9Bu92WKkXiYQFNPQb4jLDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199015)(41300700001)(38100700002)(86362001)(6486002)(8936002)(478600001)(6666004)(4326008)(66946007)(8676002)(316002)(66556008)(186003)(2906002)(83380400001)(6512007)(66476007)(6506007)(7416002)(1076003)(44832011)(2616005)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iRpxKAgVKpdoAAsCUIPZeMYifC2WKfhS4YlmiUtZHGi+Morp1qMZHuOzGQyq?=
 =?us-ascii?Q?vmjqKyPGNBju4o5sFuMBB6POQCNBTmgD9BGyMWNvX+a57lh83UgcyxwJEPkp?=
 =?us-ascii?Q?ykzbOTloxd5HWT9WREfxLxuGlN+dj5HC7FuOeFJrTC6th40EGSs37LMHGLmL?=
 =?us-ascii?Q?e3fzfYqxpV5AeMfL0MJ2vCqX4gPZJMf5YS0s2N/dMVB4rouaXvp0ltd9env+?=
 =?us-ascii?Q?DQJ3NXDqL6S4O0absQtkKEMcpSJU3PN8pKJ+fZrJpvbravWf3XQzTjQt+TNQ?=
 =?us-ascii?Q?03EJYDMCmnHGLsTxL5/r3NMAE3NkT/Q+/CHFsAYwq/PGwjqi5UxHPCLgSmC3?=
 =?us-ascii?Q?M2xzegaVps/6jgDtvrn3at43qcuBnMwxEGHGWLizff746nE3exykoT3h1w9S?=
 =?us-ascii?Q?+5GTaSUG1ogTdRb+h4CFrSctBHG1+YSkxj4XzIZZhd2yy9jW8ZQzf51kiTH6?=
 =?us-ascii?Q?EqG7BiFmFnoyOzAb/Q0DrteqYwWNgP7HUJFQ73cgSUiuM08jqqeJZytGXN/k?=
 =?us-ascii?Q?4zy9wrWU8a1BIoKDoQvVgfSpYxLHEUhcS6oajNI85ka0B9TW6bx6lCSZT4SZ?=
 =?us-ascii?Q?eqX1dQsTtFaCE2DlPTvwvO9ZyY5G87Gl4P/72oAvH/h9W9woAAZzTAHr8ejz?=
 =?us-ascii?Q?7vYGPqJCa6DRM7sR/gIuxWEJpdHmjTm4s/7SPVqAc+vl39OddPKyEGmH9M1m?=
 =?us-ascii?Q?BSFfFtRQRPUjgfwF6qIIytz40z1Rplt+6fR87SzEgYE34rJ+1lHCpJlPt2Bq?=
 =?us-ascii?Q?c1dg8lZGgcMLj5s0YQedog21/HR/EyRQ9QAnF5uHFms4/mHMMOHD7xFsAhpb?=
 =?us-ascii?Q?jLy/JZJGiNgCgbJVfuNdjyj4EikKeXgQOuqyVixz3bWAE9WmcLzQi/MJ8C89?=
 =?us-ascii?Q?CQYDh69/M54b6x2bBMgXoGMO4VYlZz+5NPRAGwzS1G4xmg33FYleMbxz4tpE?=
 =?us-ascii?Q?YsRZ2/qqVEk59tiA1clIPXiUAVWoZkAwd/t3dM2kTizllfl3sCJGea90Zzbi?=
 =?us-ascii?Q?O6BzjQnFi6xq37j6kq4NyypIoWIZogj2/0zy/9G16wcBl3Gjh8iZfzJ4tBZM?=
 =?us-ascii?Q?pSb3eV3CT+PGPqlFeapi7P+uEUYD7N4jwbYob3fCx5iWPVMpUw/UW8AAzBAj?=
 =?us-ascii?Q?ifGzpbZq2M6rVCIXSps/MTc1BRR52JyUKmyal0H7cr2YHVzBGkHQD+8Appm2?=
 =?us-ascii?Q?XfK2kFNdb/DjsVfCl0ZkmQ6b4woD+9xEpHi0Z0puyph/rsH+W72yCCgfgDD+?=
 =?us-ascii?Q?XSMVkHPQu0ePuuhuGdMY+azUxxXX9hZmax0sQmidBD3rNyR7Xm5I3qxJHH+g?=
 =?us-ascii?Q?ulWk2s5AA1ibl4R8u3VbKjsrbTTivoYqsWtkesInCZHXZcyYZ0U/F22es+l4?=
 =?us-ascii?Q?+TbYAg13FQTfNwqQnLr2Jz6IiEl6LgBq3CW0NQxv7DaUbxva5PmsKSdaOycH?=
 =?us-ascii?Q?MJ1nn7mydIkvCPMRB92r3ES+9Ihp5MeVHC+l93Ir/Xx+HA+TlLMyHKB0na0l?=
 =?us-ascii?Q?jBaDA0ZBJdc229cTQR0XU9PzwVO/bR9J4zlr4rSw7U3yI4w7vejGI8iO3Cqh?=
 =?us-ascii?Q?ZEXG8IblNwPb5w8xqiWhfiWYdJtPgR+M62wTr/jKUua4IgWvcLf+2AXUroQS?=
 =?us-ascii?Q?bzBTJugFO6ITNtXF9ChWkXg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a628d2b-e67a-4536-cd6a-08dadd6ae463
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 00:33:59.6238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9VPKc+QhG2SO+OKuALfjS0E840QQ7mjGOKcv//GwGvDXlzdia/GPVVaemDcAed+hrRodLCYqdazU9xRpjgQkBMisMNbr40rDwT61sHZMQhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5223
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212140002
X-Proofpoint-GUID: xohwN_5B8emlLZaMXl0SMBwlX6UjqXIE
X-Proofpoint-ORIG-GUID: xohwN_5B8emlLZaMXl0SMBwlX6UjqXIE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Prior to the introduction of the machine keyring, most distros simply 
allowed all keys contained within the platform keyring to be used
for both kernel and module verification.  This was done by an out of
tree patch.  Some distros took it even further and loaded all these keys
into the secondary trusted keyring.  This also allowed the system owner 
to add their own key for IMA usage.

Each distro contains similar documentation on how to sign kernel modules
and enroll the key into the MOK.  The process is fairly straightforward.
With the introduction of the machine keyring, the process remains
basically the same, without the need for any out of tree patches.

The machine keyring allowed distros to eliminate the out of tree patches
for kernel module signing.  However, it falls short in allowing the end 
user to add their own keys for IMA. Currently the machine keyring can not 
be used as another trust anchor for adding keys to the ima keyring, since 
CA enforcement does not currently exist.  This would expand the current 
integrity gap. The IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY 
Kconfig states that keys may be added to the ima keyrings if the key is 
validly signed by a CA cert in the system built-in or secondary trusted 
keyring.  Currently there is not code that enforces the contents of a
CA cert. Any key in the builtin or secondary keyring can be used. 

To allow IMA to be enabled with the machine keyring, this series introduces
enforcement of key usage in the certificate. This series also applies
this enforcement across all kernel keyrings.

The machine keyring shares  similarities with both the builtin and
secondary keyrings.  Similar to the builtin, no keys may be added to the
machine keyring following boot. The secondary keyring allows user
provided keys to be added following boot; however, a previously enrolled
kernel key must vouch for the key before it may be included. The system
owner may include their own keys into the machine keyring prior to boot.
If the end-user is not the system owner, they may not add their own keys
to the machine keyring.  

The machine keyring is only populated when Secure Boot is enabled.  A
system owner has the ability to control the entire Secure Boot keychain
(PK, KEK, DB, and DBX).  The system owner can also turn Secure Boot off.
With this control, they may use insert-sys-cert to include their own key 
and re-sign their kernel and have it boot.  The system owner also has 
control to include or exclude MOK keys. This series does not try to 
interpret how a system owner has configured their machine.  If the system 
owner has taken the steps to add their own MOK keys, they will be 
included in the machine keyring and used for verification, exactly 
the same way as keys contained in the builtin and secondary keyrings.
Since the system owner has the ability to add keys before booting to
either the machine or builtin keyrings, it is viewed as inconsequential 
if the key originated from one or the other.

This series introduces two different ways to configure the machine keyring.
By default, nothing changes and all MOK keys are loaded into it.  Whenever
a CA cert is found within the machine, builtin, or secondary, a flag 
indicating this is stored in the public key struct.  The other option is 
if the new Kconfig INTEGRITY_CA_MACHINE_KEYRING is enabled, only CA certs 
will be loaded into the machine keyring. All remaining MOK keys will be 
loaded into the platform keyring.

A CA cert shall be defined as any X509 certificate that contains the 
keyCertSign key usage and has the CA bit set to true.

With this series applied, CA enforcement is in place whenever 
IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY is enabled.  Meaning, 
before any key can be included into the ima keyring, it must be
vouched for by a CA key contained within the builtin, secondary, or 
machine keyrings.

IMA allows userspace applications to be signed. The enduser may sign
their own application, however they may also want to use an application
provided by a 3rd party.  The entity building the kernel, may not be the
same entity building the userspace program.  The system owner may also
be a third entity.  If the system owner trusts the entity building the
userspace program, they will include their public key within the MOK.
This key would be used to sign the key added to the ima keyring. Not all
3rd party userspace providers have the capability to properly manage a
root CA.  Some may outsource to a different code signing provider.  Many
code signing providers use Intermediate CA certificates. Therefore, this
series also includes support for Intermediate CA certificates.

This series could be broken up into 3 different parts.  The first two
patches could be taken now.  They solve current issues that will be
triggered by the build robots.  Patches 3-8 add CA enforcement for the
ima keyring.  Patches 9-10 restrict the machine keyring to only load CA
certs into it.  Patches 9-10 require all the previous patches. 

Changelog:

v3:
- Allow Intermediate CA certs to be enrolled through the MOK. The
  Intermediate CA cert must contain keyCertSign key usage and have the 
  CA bit set to true. This was done by removing the self signed
  requirement.


Eric Snowberg (10):
  KEYS: Create static version of public_key_verify_signature
  KEYS: Add missing function documentation
  KEYS: X.509: Parse Basic Constraints for CA
  KEYS: X.509: Parse Key Usage
  KEYS: Introduce a CA endorsed flag
  KEYS: Introduce keyring restriction that validates ca trust
  KEYS: X.509: Flag Intermediate CA certs as endorsed
  integrity: Use root of trust signature restriction
  KEYS: CA link restriction
  integrity: restrict INTEGRITY_KEYRING_MACHINE to restrict_link_by_ca

 certs/system_keyring.c                    | 32 +++++++++-
 crypto/asymmetric_keys/restrict.c         | 76 +++++++++++++++++++++++
 crypto/asymmetric_keys/x509_cert_parser.c | 31 +++++++++
 crypto/asymmetric_keys/x509_parser.h      |  2 +
 crypto/asymmetric_keys/x509_public_key.c  | 16 +++++
 include/crypto/public_key.h               | 30 +++++++++
 include/keys/system_keyring.h             | 12 +++-
 include/linux/ima.h                       | 11 ++++
 include/linux/key-type.h                  |  3 +
 include/linux/key.h                       |  2 +
 security/integrity/Kconfig                | 11 +++-
 security/integrity/digsig.c               | 12 ++--
 security/integrity/ima/Kconfig            |  6 +-
 security/keys/key.c                       | 13 ++++
 14 files changed, 245 insertions(+), 12 deletions(-)


base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
-- 
2.27.0

