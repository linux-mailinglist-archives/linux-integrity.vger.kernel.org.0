Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A28C645FCF
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Dec 2022 18:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiLGRNq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Dec 2022 12:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiLGRNm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Dec 2022 12:13:42 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A51654DE;
        Wed,  7 Dec 2022 09:13:40 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7GGlS0021894;
        Wed, 7 Dec 2022 17:13:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=BwjU6HLISIcurPWwMgKVLqa4mU1kc4uoYuJlz7APYHM=;
 b=e6wJWEHctxftKPRlCGskX1ikgDVrPCoLSHxMEBVlAz3Sp2T/NVqchQ/qko+9T2PGIU78
 KKONBeLj8LCspiWyQfGdBMZyWhHrgkevEw17OXoXNKXYoo/p6u+hRSr5LjyoixrvtAiY
 wyg4oDrg0NClFmaMk/srzVTNv3QoQICNdfXJJa8fSCwq7su3hKlx28FrAz0xykN+NAWZ
 bmmQbyYVx6dZBNKe2zjGJdAsQAr5Cp8un8sV5j7VWKOwE51p2xh1B3+Su2UOJrxnXLkF
 nbQFi0ErbRWW6s4zU9/+c2daWYPUNlN0yxjlcpy6x3YtlhbUbrL65+ooUfoBf0TVYmqT sA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3maubagw0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 17:13:10 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B7FwPH8002304;
        Wed, 7 Dec 2022 17:13:09 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3maa7chkjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 17:13:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nee7/UrWKz4KvdvAhEWQJFsq24E33FdgIUPvarXlZxrSgQnOTKtS4QUk0Sn/gfs7hIhFfmLTNYzyjCdrQ9RmPpQ07bpn7x50XlpGxHlrJ4jov7TBATotle0ZyLemCxnuHNl7qNEdyjf9ZMtoXxR2wANGcTxKZW+eSBN2P/m2GYtACevzqI4hkRLXZarYT/eqMq5fnTwe1+nCEwok1d86RVo3PlBxhRnRO3Bf92cXkmr+Z0Ylsi40xHJiS/S5+paDo3kMbW7JOoIGOZMkok7N/Umt1fClzDywdZUrrYDQxC4ooY1LdFbv7Pda9vctvlTmDzdAIdnd1SyzKLkHb1Uk1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwjU6HLISIcurPWwMgKVLqa4mU1kc4uoYuJlz7APYHM=;
 b=Q2yrySjvy64nYmQiUGE8+KODcPYotnj28T4+Q83TpkjureXcMWAMbOWtDvNLrJOtRiIDDvZ0ZTawyvSshdRWLdzH4xd2V4nagsEBTeW38zF3sX6lnWjquzA2cwk9B87ykC2MecxHxzPL+Ab2qj24L9TZRbk5Yi9J9S7pHlJqKiwziklq+P74rdW88f4PbjTgeIeVuMEy8X7oe407eU1FtX25+V+dkkjhMLPBalpj/x+wtoYzzW/cnrL/E25yLFG5mQyp0CKZPA5zz3xu9hZ9qFJTlZ46jNZdt3iEDQwKwDUn1t5sPLHaNBqXZdZ7o3VTp0vTHMag4AcoqL3IEtEXgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwjU6HLISIcurPWwMgKVLqa4mU1kc4uoYuJlz7APYHM=;
 b=yKPL+YYHM9c7rIajDYxWbA57zSeYlvuipRg/m8T/JcLEV94QpHsDGABhNzKRroCnLK0KzF8fsGAOb+S7nQRTKzlcRF3g8zfU9G5HGyUgDxGmYTxjWIivDNeQdxGD+WM8N/ni84NAYmJKOsug92WjGpvhCvZ3ISVXkIVET5DchfI=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by SJ0PR10MB4685.namprd10.prod.outlook.com (2603:10b6:a03:2df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 17:13:06 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4%4]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 17:13:05 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     jarkko@kernel.org, zohar@linux.ibm.com
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, pvorel@suse.cz, noodles@fb.com, tiwai@suse.de,
        bp@suse.de, eric.snowberg@oracle.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, erpalmer@linux.vnet.ibm.com,
        coxu@redhat.com, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 10/10] integrity: restrict INTEGRITY_KEYRING_MACHINE to restrict_link_by_ca
Date:   Wed,  7 Dec 2022 12:12:38 -0500
Message-Id: <20221207171238.2945307-11-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20221207171238.2945307-1-eric.snowberg@oracle.com>
References: <20221207171238.2945307-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0138.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::23) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|SJ0PR10MB4685:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c609ca5-9f40-435e-8004-08dad8764ddc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ABK83vBcC44/pXYq6olY9k/klNAKzC4m11Z72R08fVClZDBHpeecl2fCAytBperz6Mq08jzRqimwTUQ0QjH3dNuzxMCqq62QVMr0uGHwH6oVysafxc0oE26wcXu8k78Qq9k3j46AZ3G14QKDlOG1KBuNS6w9d9i66yLWRA3HJz4Nk9eph5jT6GkBaGp2Kk87Q3Rmbz3uQSiGUvmAf/lzpbKQSwpY2+SovKrCD2O5cZERHXgiy46IH56XnToCUKmvB5bJEO1/HF8jKJNexDYMvtmJlC4JbtF9qqNyKj0rBzekrpR/OqPA5kvKnhXXOAC1QSCwf8vrfvm0daW2AWZ1RjZioAa5L8g3fl3xxNPUpAB1ZCVi3iYOumeVUc00qXM7oX4h/f+G34nnSyJ7Z29yuNGkbnO+AwlILMa85gDczKlhRDfuvuskIbNZ9od6wzkKKC8v4ycLqnR+gWZ5fpdGvcqrNL9DPJmjU26XYdNoD6CTUqUV3/sQ2j02fuZ4epYzFxMaiNzClOdlBzbVoEmQ02Zf87JXabI6+0qmB/3MLOWhabucP+UWY8ghjdzEEMDgtomfkgHTT4dS+o+IY9ZyPAzJ539As66ja31gTt6Y+uVYsdMELh8GhgkwNoZv5KA+txyF8Uc8cgF6eCzagLi97g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(396003)(136003)(366004)(376002)(451199015)(5660300002)(1076003)(36756003)(41300700001)(2616005)(7416002)(83380400001)(38100700002)(8936002)(2906002)(44832011)(478600001)(6486002)(6666004)(6512007)(316002)(66556008)(4326008)(8676002)(66476007)(6506007)(86362001)(66946007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GRgudxubvAa7diJ9hTyRvd5pOwZcUCQYPAyqP2VFiFAN5eEY1LLO8avtbZ/J?=
 =?us-ascii?Q?ZIxKa5t4rS+oFsObq6548ovp1xAyDgWvx/Q7hvH243kz5vgJCJprB+AYAp1u?=
 =?us-ascii?Q?SMYP/Sv2RpnS+0loq1aOBL9+ojkSG7QGBayz0xLJ1NQaSuVbJ4YOn1dq8J4L?=
 =?us-ascii?Q?eewlE3k288v1L2K00wKUNW0y1aqBhovmSOQIRzqZ9quQXo3yxhnvwVoEbmsD?=
 =?us-ascii?Q?A7Qdww10yDhjYz4AzdX08OlNfH3hjHoKQNtJ4S5SDszRqseZ7V5TqiJh1XX/?=
 =?us-ascii?Q?66s1Mw98zs9kGh777aB/DjL75i2sgKZ1VwbkbCbCQR2qD9jj41vDXLtTZ6fC?=
 =?us-ascii?Q?jfRnNd5fsHd84kZUDBlBYcvqDp17kRVHcK9KUEJMt8rCMr59nU9cwLECBXpH?=
 =?us-ascii?Q?CnqzeJZGwYNBFIvNMWeYwyE5oVfAw/2Ev8AWCvgw4+yUtT2vKxAmOjigMLB7?=
 =?us-ascii?Q?4e973WdYAuJ58NvEdPnlqKIKoA4b96M5O61HQFN4h2DBAnFenS+QvVDWCmMq?=
 =?us-ascii?Q?nCNDk4F30DYNZJCp++NgG8HE1EYXYzS2AxcI8BqI/e9+2CRKIx9ieKOwo8Qx?=
 =?us-ascii?Q?BFrI/RX49TMjTSza/vBwtR+BXQRcun+5pHcwXcgmp4vorKECmKMA+wYdDXhQ?=
 =?us-ascii?Q?Hth53nB7flaxFjdSZALq+nJjYgfYHDVC1gLDP57vw0Q1c8tecENoMCl8kfva?=
 =?us-ascii?Q?OQjyhS8EPr1hv4oGBXH5Y7Hszd37vBRmP45dSTVdmZhe9nEtr81tEzB1amAy?=
 =?us-ascii?Q?Cv/3iUtCgMoDtF6h+nhggTLd5R9hEC0PXHkBou9JNnaZDoz4wHG3v0UnsW6s?=
 =?us-ascii?Q?+OHxWxkY3HmQmYcBErE28jakjEqSykw9q5M9FgefDMKZALI+By0sgbycp6yK?=
 =?us-ascii?Q?WBFAzFg0WKj17VgkGQLUq2Qju5lN+7B8t6cKq7Cxr/KxB6llSo9PWYMtUjI7?=
 =?us-ascii?Q?NiTUcpvqN3G9ARzNXbvWHZRe+LF+0xV29Kt1Krrh28glQevPq1k4iRJYWY9K?=
 =?us-ascii?Q?UsqUy5ILHMsHMq/fcmOZnzZDdSedKov8sHP5sSoE6grhkuOGtecVQq1IbZVX?=
 =?us-ascii?Q?kqsz1cg2UzKtICZdJ8WxxfS0/BYiRRHTsA4nXsznd+HQvuXVvbjBq3yV8UBo?=
 =?us-ascii?Q?aedGKi9yTbR1gKaVHCygYQRocOvJ7oP8/Iww3XFVeR0bNTox97gxg2eyTjwh?=
 =?us-ascii?Q?+kAKK4qxVJ3LJYNasNSiFG2urjj2C2c98kEImTl3QYnpbf1vZMPBdByTUNgV?=
 =?us-ascii?Q?9H86IeoX/p6af9I9stpeYBTNkIuQKjy0sU3T2Achgarc1Bz0OX8SdsptUkLx?=
 =?us-ascii?Q?u3zxohh8FAXXYxoNW6qsKv1bPoY50HgCtIDDs9keCMT6Ii8ArusiYTPRkqFA?=
 =?us-ascii?Q?RlIDH95AbMFpD1SfxW35Yft2yr3wU1IlFBBlV3eUVebuW+Op4d8aglU7DH/w?=
 =?us-ascii?Q?lOsd8FqmowzPZ3bQMEBXhlY6pDqrPDRGaMNHcVrYAURoYeNxV61FHdQKuGLQ?=
 =?us-ascii?Q?RIQvzMCr7eYiMofY6vKTOEk+n9g9HGZNAQ0TRD0Jq9owkUN1imQyj6s8QhWn?=
 =?us-ascii?Q?eV/yqjJyT3c5gNXvH9Xo/ynhfcRhhmUfui/q2gbcqJpAHgMQMgjLGc0Z4tve?=
 =?us-ascii?Q?fu6QDwyyS/gXQo2pgsYre6w=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c609ca5-9f40-435e-8004-08dad8764ddc
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 17:13:05.5070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ke+1EeCNrw1sslgpKKN/QN8SOZc9mx/iS+2R5ZMO3VJLT2GuATsOHGVAb063cv9BJ9M91X+lpghWSwfFZu657CWLCfoCrGvB7zs2/Im+QMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4685
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_08,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070150
X-Proofpoint-GUID: l5z464-Eg8dgu_oy_ZzjWhrYKftNDtwC
X-Proofpoint-ORIG-GUID: l5z464-Eg8dgu_oy_ZzjWhrYKftNDtwC
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

