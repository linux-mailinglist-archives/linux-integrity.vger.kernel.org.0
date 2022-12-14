Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F168964C154
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Dec 2022 01:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237854AbiLNAfB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Dec 2022 19:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237743AbiLNAek (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Dec 2022 19:34:40 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814D71EAD4;
        Tue, 13 Dec 2022 16:34:38 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDLNqvI019987;
        Wed, 14 Dec 2022 00:34:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=BwjU6HLISIcurPWwMgKVLqa4mU1kc4uoYuJlz7APYHM=;
 b=zeE/ZyeNAqjkTPDBdOX/rB5AhP1AtmamvrYa2mkpZE4tMJEtNteIoWCXnoCUOZvsWu1j
 ij0o70doNBOvD8I3ZxBWt9+TCdiljLW5VRGgLqXtLCG67ygH63M5uQi7VOiEcPIZ47hu
 J8ul0oP3GSVfAw7A6s6CdyjP/FoHVFPxqEFclGjehkPXUDXyqMs+xpXDLRBsSr5X8flh
 p72tudkOepCJe+uQvk8IQolretYusf5A1L/0kpv5rAddwEl9eSzhqyi2EQxOUBZGu93+
 kd+NztY/l7J0nfJDQIAR26039jw+sXKwqf3GdqpQZuIqidfFruPgF7YSxOCbGpuVDrz4 8A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyeu8p7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 00:34:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BDNh14S031305;
        Wed, 14 Dec 2022 00:34:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3meyet4sj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 00:34:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jupGOPsSczDLrX28VLKoZpb7zcvOkLDvDvSQb9zVPz/4fnTlyFDz6SLMlnLrATWXMQKBNtHz0467BMSAUriMl5kuIaXc3Xb+dgupchP/pbwFlv+s0fgufbx8hWP/50cuIt735+zy4RI8iPY7ArYijpaPTztragtQG8DouG2D361TpFBLrDawMdnM8u9Fccj4sdim53XQaEgKL+3cHphH9zl9i7tELmPDsKgoZdMZNCUI8dACL84tbJfq+szzHFJb4At6hqNYhs3IYxRxxo8vKq5Fg599p7dBzzyKzFj0vHhsab0vaLTsl1K+YbcvenmbMO42XKkJrcdI7EnphS46bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwjU6HLISIcurPWwMgKVLqa4mU1kc4uoYuJlz7APYHM=;
 b=EREKDJm/BSV9f5XHhj/K8u7PnC0NtchLIB0vKAdim7G9DCNq0HDocfOMdVxCR4XEx5vhBroNrZMRcbI7A7LUTYo6wpGPthSVGf7W1qOgj81dZz7yr9baejUv5DsOAF1IDydbBfi9/rHK96qYJAmXe7rIjORU0CnmkvY+TdZxaY6QaI+8cfLGYwQ761N9JBo/EQqgE4XgnCSGHA0r2Es1zoQv9Vl8KDPTkPSHrKs88bgZ6xpX8Cz7iLtf8XPAkcmyXHGhG3Aiu7A6E7YeiNf3jXs0q5v3/f/v3ElYLjsA9jKTWya4T5EElMX7CsXfU7Flm05luqCLvch/7OkGfeX40w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwjU6HLISIcurPWwMgKVLqa4mU1kc4uoYuJlz7APYHM=;
 b=rLWm8w97qJ0gBOhp2ljHu6r60pEAEzeNLlJyVMb/15eQ7BRI8OlFlP5eCjAJ44wnzt8Zo5ysY01izyiOxED866z9dtJJpnZTJPn7YBoW/KJ1vcJXl+54RAzIJSFqIs8eK/iMshMpgvCeRHILealC0ptFo9ht8dRz30Y0ZAb1kcc=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by BY5PR10MB4324.namprd10.prod.outlook.com (2603:10b6:a03:205::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 00:34:18 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4%4]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 00:34:18 +0000
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
Subject: [PATCH v3 10/10] integrity: restrict INTEGRITY_KEYRING_MACHINE to restrict_link_by_ca
Date:   Tue, 13 Dec 2022 19:34:01 -0500
Message-Id: <20221214003401.4086781-11-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20221214003401.4086781-1-eric.snowberg@oracle.com>
References: <20221214003401.4086781-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:5:3b8::21) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|BY5PR10MB4324:EE_
X-MS-Office365-Filtering-Correlation-Id: 196a559b-97bd-4d29-e835-08dadd6aef82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4d7kr/wZuvVUf9qwDa3FmJfTCjTlgXk8x2lyn0r7bxyHhuae7mveQGPtS5y74abcPyQQsHyviCnFs97Y2DeFfl/TwvqY8uIe6HFZ3f3g5PH2ns+F9MMstcV1aXu5bmUik+myiNPtJkYOc949wrSJZfDoOUxQ3SarYIEEZxBGIiBAaSlJ7/+/BEzy9bkRq5Xi1pijTx5cpuGwYW0R2vp9ld8eVNZaXscM0G9Dpv7tcomBG7P9mZm5/HNCuToraEVAyQtxIGz+O9y7nMnOQ5kXvXkaexUOlDF+oz9PlP6gNyccaffXz5qjeMrF0VyVR0x2jYDSiF1IQ6M3pm5reESPbgC6EZNoHuXY3Axv+GBdTM6jD17jWKYJp81/W04nicepZZePG5X+caIxkXHYIh5GBqYBMOhPWSdofiBetNu23p5Xi7ciUnE9TgnohucxeoBIBr2tYghdYAJ0aLQd1hNQebbeb+T9Rontv/WT+lfRHnVfCZJkqQBnxc7r8pRMmCxmVC5+H1jx/VgGfYGZp3pGPPNHeTel/D9D5nNbXR5BkOzDzkw+NtPGVBLsqRW2oewX3MwapIGbwyif3rWLMnNP+/s22IZxu9MRLOGdVqbJi3+1ezFnxPpc7eWRBf0iJk/7iqufpXbz4WK8eceMq60Obg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(376002)(346002)(39860400002)(396003)(451199015)(36756003)(478600001)(6666004)(6486002)(38100700002)(86362001)(8936002)(1076003)(83380400001)(44832011)(5660300002)(7416002)(2616005)(8676002)(66476007)(41300700001)(66556008)(2906002)(4326008)(6506007)(6512007)(316002)(66946007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KUiArnUcO/nlF6E8RNlU/3UhRLU5zaIDp9npkktzz7yCD7VxolgTQQPtLAYL?=
 =?us-ascii?Q?ZdHR5cs1C1B7MXOGRtvzy4m8ZRdGluHLdbi1KsadKQLKJwrhQlDfUfcE3zI3?=
 =?us-ascii?Q?1Hd3rTSFXWQhxhjFKaRCu2Tv4Wi9/rt/PIPLQCFW8E8jUQAlJvD8ID1FWUKi?=
 =?us-ascii?Q?iUkGXnMWzbKP9PpEXczdU7tbXWDt57mpZRb+kWD7jXR/iwfhREO7q/jEkbxr?=
 =?us-ascii?Q?bWGztoTYByhA3axtf1sTucMQOArqpxs1cCwEX0bnhq9dWUE33hiNxWO0D/FI?=
 =?us-ascii?Q?2bAaPNnwyTcRbvRlBtShinEDVXRWt6tTLZBWeNI5IZz2UEIgYCZIsD/Wyy28?=
 =?us-ascii?Q?pyMxVZtWdC5a0AG4AW0rCYnmKFa0ntag+ys1VOluv04lA5BpRuKYcGBRXGUm?=
 =?us-ascii?Q?YhWSVDEr1ZV7EaFj3u0Tp5Sn6Bgk+1xqpjdEifcSGfIDUqxZmDMNsI/2hppp?=
 =?us-ascii?Q?1rgEzRvrSDuhJMDxJr40fgFq0DIkdpCb7u8vLmWGLZ/D5PPMcZOAIkpMpJUJ?=
 =?us-ascii?Q?ZL7JSKog2pfgOO6QJogdBAuZjwgZkC/JMG4Hlkq6Y8YR/cL1Jww14DIz8UHa?=
 =?us-ascii?Q?I+vGI+XY07hyzTZA+eUoP2vyXU+IMaKBCmLUjB2TCKrI52pN7Z+hrByCX7W7?=
 =?us-ascii?Q?vjQMApz3Eijg6cnnlpkKxopvVN5VDWTcjHwMn1xTBbsIhRyngudOZCRGanlY?=
 =?us-ascii?Q?9Fj8d89yvzJB9Oyxp8gOUGMdbWDitLmv3nzJ6+PKfwAp5VUlgK5mJmxYwx+h?=
 =?us-ascii?Q?q//dBS2TGoVIXyaAB9bzssAR9OdwdJtm7eITaW6QWkxXbkFCVqxh4b7wYwWn?=
 =?us-ascii?Q?KsAuqXyJ/eIYVKj15dHv2InzLE5Sy11JSpXypl8goM1HmCm9jl3blYJYujwE?=
 =?us-ascii?Q?OjYtXAy67VRb9GJgZVrx8q4cco8K0wGSveQEyZXPwuHLFCpIhegWqN0jAMER?=
 =?us-ascii?Q?U1wYsKGGlSruM+8ce6bKLxdMZJ26wdo2bd+0d+gMk1qGoliwgyY3bstKq+/O?=
 =?us-ascii?Q?1YHcrnq49gtTo3b6o7gJ7VOxF6k/i+7ivuhTPcHe+0Q4g+n6Nl59ElyyIWX6?=
 =?us-ascii?Q?8RX6ITcwR93z2T77O+Rv90XMmrGOTIcuVY1Jq+//Cl6+XmEWnlcXDEay3YON?=
 =?us-ascii?Q?sf+NI51OxEZ7HRj2L23laG9yvM/3K6Nn/8Ly1kpidSwRJFE92pUichuJqYMW?=
 =?us-ascii?Q?GgtuwOUjsI/8QM6JfclHJ1jlNyifZ19DTFgFqnrbsykSzfjBqnSBjdXubVRI?=
 =?us-ascii?Q?8HpviRxeIblBfJG0anwwDmGKXdeS5+3hOufT0FlKW+AMi8HtzmVG0XjD7hrZ?=
 =?us-ascii?Q?W8F3YhZlL1Jnn5SluMcPEdOfzHsbnz25m8Ub6633Xi65JF52ADMfL1Mz+KLy?=
 =?us-ascii?Q?92zTug7H9TxWcqixeRm9hKppj8xFBubzO8RF2Uw586t2RCP96EJ1steIHw8k?=
 =?us-ascii?Q?CmVXSzL8W1OjZ3VQ9kURKLVw2k4wBWdU4Kd1ETsAx3Gzhjix5eME1EnxnyFJ?=
 =?us-ascii?Q?htJjHZ4RVY45YdApBKP7X5/j/Wu12pFskc0/fF2YNSJNpysUeLz6+1glHI13?=
 =?us-ascii?Q?Abn8Q17FD6bCH1DmVjhTdQxq4jgv+S8BVTFA5AnEVQZZakwiYUo5Q1/osx+S?=
 =?us-ascii?Q?Ec/rs+eL2hCbMk065ZNX0mI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 196a559b-97bd-4d29-e835-08dadd6aef82
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 00:34:18.4233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wi8uz4R9ZyMXugJAv48UsKj9mUnMassFK675FtgKVh6X/Je5Etdyk3xQkD5DBT5lxR28wdZ3e4xZippweda09zIlNKR5Lpr6Dd9wGuybnzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4324
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212140002
X-Proofpoint-ORIG-GUID: 4BiB11Szgt-6DAiV-T9Rdb9R3e1uWJDs
X-Proofpoint-GUID: 4BiB11Szgt-6DAiV-T9Rdb9R3e1uWJDs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Set the restriction check for INTEGRITY_KEYRING_MACHINE keys to
restrict_link_by_ca.  This will only allow CA keys into the machine
keyring.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 security/integrity/Kconfig  | 10 ++++++++++
 security/integrity/digsig.c |  8 ++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
index 14cc3c767270..3357883fa5a8 100644
--- a/security/integrity/Kconfig
+++ b/security/integrity/Kconfig
@@ -74,6 +74,16 @@ config INTEGRITY_MACHINE_KEYRING
 	 in the platform keyring, keys contained in the .machine keyring will
 	 be trusted within the kernel.
 
+config INTEGRITY_CA_MACHINE_KEYRING
+	bool "Only allow CA keys into the Machine Keyring"
+	depends on INTEGRITY_MACHINE_KEYRING
+	help
+	 If set, only Machine Owner Keys (MOK) that are Certificate
+	 Authority (CA) keys will be added to the .machine keyring. All
+	 other MOK keys will be added to the .platform keyring.  After
+	 booting, any other key signed by the CA key can be added to the
+	 secondary_trusted_keys keyring.
+
 config LOAD_UEFI_KEYS
        depends on INTEGRITY_PLATFORM_KEYRING
        depends on EFI
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 1fe8d1ed6e0b..b0ec615745e3 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -131,7 +131,8 @@ int __init integrity_init_keyring(const unsigned int id)
 		| KEY_USR_READ | KEY_USR_SEARCH;
 
 	if (id == INTEGRITY_KEYRING_PLATFORM ||
-	    id == INTEGRITY_KEYRING_MACHINE) {
+	    (id == INTEGRITY_KEYRING_MACHINE &&
+	    !IS_ENABLED(CONFIG_INTEGRITY_CA_MACHINE_KEYRING))) {
 		restriction = NULL;
 		goto out;
 	}
@@ -143,7 +144,10 @@ int __init integrity_init_keyring(const unsigned int id)
 	if (!restriction)
 		return -ENOMEM;
 
-	restriction->check = restrict_link_to_ima;
+	if (id == INTEGRITY_KEYRING_MACHINE)
+		restriction->check = restrict_link_by_ca;
+	else
+		restriction->check = restrict_link_to_ima;
 
 	/*
 	 * MOK keys can only be added through a read-only runtime services
-- 
2.27.0

