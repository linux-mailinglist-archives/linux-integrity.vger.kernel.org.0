Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C5C64C15C
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Dec 2022 01:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237890AbiLNAfR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Dec 2022 19:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237806AbiLNAel (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Dec 2022 19:34:41 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D411E73B;
        Tue, 13 Dec 2022 16:34:40 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDLNqaH028144;
        Wed, 14 Dec 2022 00:34:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=FcqSzew0O0FjdrK9TzNxq8T1yreYM9HpipI2oLXI4wo=;
 b=vMCILZREWqbaDhZOiuQu+ty7uwsYepewwcFAx7vG+z+LJ5AnZKht/v+t/kxJ/i/DdqCV
 TWTAZ8itt1LuldoVb/yFkZwqvcppRPi7VYlzvrrh9ZygHPWJStKu+hlHjTIcnw3IFLyg
 tJw6Zhm23zOAm/Y5FwVt+YqsnAaTaggYxeege+O0K8GRd13xXY+DtxsJNGehybPiB6ee
 lBZoCpkjl0t8qWfRvHzSvXUm9iIIELf3RkXyjie8hIYnhxFsaoL+fcnIl5+Ek54JaRTF
 Z0AEhYKLUBh8n/pOcuQadOs/qAVBMb3sQgdSYGhhKRxWqEh+esBzhlCtivyX+jLTk8pc FQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyeu0p8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 00:34:17 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BDNUSBH031747;
        Wed, 14 Dec 2022 00:34:16 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3meyep4h1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 00:34:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKSvG2eYthNiz4Bg4I89xhnmSFA/Dsgsyb8IFQENMlD4KChml6Hwt7+pgYuNFujBHDn+CiN+DRFsukCEKHTAy+/gwT6lV93NudIwfW4Hgysqpny+ZvYGm7KP5w7UJF4oo1MQgB1zs5mCTrGKxyXcJB+Nw59tXNX6MrOCBjbkTcmREblwOuv/fBd8ybGmbx1DHKaP2Blazzh32O3lGuF54XUWgCEzzisofrKOY1ZuPwf44D72t/T7KaDEoNv2q9dIBNdVz/T9IryH8jfygVlkpYzqP+GXjvhSNncNMwZtU8lraA1GR6ClsuJE+Tbhr+ZGMIuCZEGfzubh4Y293F05mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcqSzew0O0FjdrK9TzNxq8T1yreYM9HpipI2oLXI4wo=;
 b=ZATdh3FIJgCDc/Ho3xyLpBHn2MXWH0w+LVmXqXCZGNoNLIOjZtFGUkEPj04GHxzR/tFRC0wOjIbawmKdNEuuAe32Bb8CLiuqMgFu8FqAeg34D1xFvcp9lMOtvY3nZz2Yh6RXnTy7tNVvneROX2p7nIW3FpDItKG8z+VFq+cYKEXRElg0FCKdzIffaly45fEPyId6xnWRBIravf3nAt9xMZdA+m6t6YFzG5OTPL3OZIZQa8NsRo4M+mWPBdjEmR7ilbwioWZxQp9zUz4bcrdveI+M8bfBhDIiFw5JLYLj1i7rhORV+LlJgnYIAInJnTeqxxPP4N4FBnQF9Vonict3xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcqSzew0O0FjdrK9TzNxq8T1yreYM9HpipI2oLXI4wo=;
 b=BVyvV8G9S9OEKo/KEhMU6LwYgfoEApwQrTdS1YHx+q38ssNTFyeayFUTaGqc3y0MpepqWlOtdYyk/NpXynA0q4FOx8YXItcCZPL6fuRk4+hTbAaIehGoCJPa7fAA1aKsG9jOkTgox87gIyXrzOTaM1RhGXpKg9v1cpCfLq/N08k=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by BN0PR10MB5223.namprd10.prod.outlook.com (2603:10b6:408:12a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 00:34:14 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4%4]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 00:34:14 +0000
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
Subject: [PATCH v3 08/10] integrity: Use root of trust signature restriction
Date:   Tue, 13 Dec 2022 19:33:59 -0500
Message-Id: <20221214003401.4086781-9-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20221214003401.4086781-1-eric.snowberg@oracle.com>
References: <20221214003401.4086781-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:5:bc::34) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|BN0PR10MB5223:EE_
X-MS-Office365-Filtering-Correlation-Id: 489ba04c-d578-42d2-1f94-08dadd6aed38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ApO727HRLjx1gsPyIMe6gkcdgY3XCz+3xGROuizr+C6Th5GK9vtBlPo/UtzcXlH2LVxANfhkJNDKuV27vZTbWz0wpCN9OKMubm6cglWYYjHZPuI1K0fH6INKRbW23taRStr67wNiKOi6FFe4hCt90oHidv65X7ykCmER2ZDNt0fQpo17DyC2bkcWTCky9anx5PIcGpqlB1P00IJ/sjqSJgM9DHouHROEfRoqXiNmNYfljcoFed5ZDn+1s1lBRBsdLSPVAZPGS/B4fnYfHF0oiRaiVPnss94+pkcc5DBFXqfDM5hQtd2HoReIuWMieNAkP2yw4RvWHnC26/d83MulH64BjZ3TLErpSGIncEGJyyR0k+yD6WUe9JZ24GAe/pPVbYt1d+ri2yFvrYYnEeuz+PDeOzIs3FtYBMJq4R3BKdlzSjjzookLJzDQWpkq2xGEYETkdNfqd9KSaoKThxCTJv174kpHwCxbj+j87BIChXjG8uaSTAdbBJwC8keglbQ+vxNLTdphiObThDOShxbwLyyGdTD2JeW5JPDYA6QHnPSmWmcSm1FBCWWh6/R/+FDglI2bhNtd99tLZDSUdD4F+avsqnIbOWZ5IuyVN/diA1rm8TAXB6TjWjjVklhpIrrBJLfdRoHnWM9mKeDDJj4TDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199015)(41300700001)(38100700002)(86362001)(6486002)(8936002)(478600001)(6666004)(4326008)(66946007)(8676002)(316002)(66556008)(186003)(2906002)(83380400001)(6512007)(66476007)(6506007)(7416002)(1076003)(44832011)(2616005)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?le0tVj8x4BhsCQTCUqv8g3M6dtlxzoNsfLO+7f0kPbrAU8omDx/fXil39G4k?=
 =?us-ascii?Q?dO/6fjsL+JkWUz44b35//hOPHyTMnQI6q0qSiGTnHabrvc9jJ8t9KxegEr6t?=
 =?us-ascii?Q?TbUcZ2btRVdojJ5U0cpGTVG9EcJsd/upaLvLQ8oZSvQGePlZ29urd2xH+ngb?=
 =?us-ascii?Q?/QWyOML1TQFV0N9NQQJzRBeGlBdZit2e+zJctnCAeHhR4gnOqh9hQweZNfRV?=
 =?us-ascii?Q?/d54uvPZLxL4JUVTTQvJ4cqNvfCqGBTGWzRetodsPvADHTQQxgBsMkAOux6J?=
 =?us-ascii?Q?bHZhGNYAUNbE44RcfAkKdTmU0XIiZjGuzepWI0sLNZ1vj40q3VpTBXXbKAyg?=
 =?us-ascii?Q?aYztgJWpZPAyKdcMcapuS4Ait4dVTQrhcUQxExiO5wrdul5CHycNt3COGAg4?=
 =?us-ascii?Q?wRwOSFNPE73QBCjD2KnWG7Ygmc0rtRuqnG48GkLLNIot8CfTy0skBdlR41f7?=
 =?us-ascii?Q?7hKcN3UlWLa1hg1/oqWvRL7UZhGhBr/s0a5JLiXkhct4LtUL5Mbb8Z6KG4yL?=
 =?us-ascii?Q?1UU9vg/lCy7R38r1fBisLtuKeO7r2yaJprMZlvzJLhP+9P90KgEzrO8NabG6?=
 =?us-ascii?Q?Cpc+vWpyDrW5VKUpi0f5uYGzjxuhZQP+4cqDvTnzckrVhZ9QtlRTsw8Ilmc+?=
 =?us-ascii?Q?pt8k4P4+5ofp5kjn1+G85biMjbEAkr0/chewTDsxx5Gvl2y5g/wDrdFvwIxd?=
 =?us-ascii?Q?iRIHhO3rm4IeNPxGLJKqNTXbG9HQXSnu2q+xxApywPPhK1K+hGNEjm15WL3S?=
 =?us-ascii?Q?DyW5FDLc9NDYqWsI+1cZBswL094/esHCVgV5keU2EMLkT1W6IVtk8J7uIHs5?=
 =?us-ascii?Q?vd6cNsxen0naqWrW5GJ2wvD7U22Kzzvo/FrqFt1LPrSSHwWcGtQFkkBoVBVL?=
 =?us-ascii?Q?t+xAUezHqxapITUf+a2CCX1VIMRDMvMi7kr30C4yMIZ4Sdzx5dTP2HH5puVM?=
 =?us-ascii?Q?W5kEpPHZBLYlF8Ci4vWVVCHttAUcZ0V4p3mP8F2GUsZUnZwJ5Wv+II87QVs5?=
 =?us-ascii?Q?k/aQH6zuyWes1VPalFY8Oew28HNY8bn2eI0vnXgRPeYuraLEScOlAEZXqneq?=
 =?us-ascii?Q?RaAqpXEkS7pRVDV4JxpaEdgbZFyDNZsPttftn5OOEhX7BpuRnr0LVDQhcUJn?=
 =?us-ascii?Q?bD+goG9QS/eL8ixx8NNh0i1UeklIEFA8hU1t/UB62wkZMwRcrgtsnCpepWA5?=
 =?us-ascii?Q?BBoqF25E7mbjrGBn1wsNsoBxnZXm7VOYG2keQAJ6Zng5qn93U5aqVkJQTO8G?=
 =?us-ascii?Q?HO1hNTMTB9v/lFgUB69I+4Ad9TrKs+jYKFNHAI9gnTf7xozs5evJ3tqmKIvm?=
 =?us-ascii?Q?5LyTepNjDCdcPJITIgWxWjgPNc92Q2vxKhFJN8Xl2QTKN8j+H3zeYLrDngPI?=
 =?us-ascii?Q?AAP+pnWdEa6aDHX8+IaCkkfOMRetUwS0Yd8K1Q94A0WgdqUUzjjJcolP2o8d?=
 =?us-ascii?Q?BZpVNVjVGLKBqXPE9RRW1Od7hJb+X01aUUBotSx+5WFYnRAddeP1sYsSAGQj?=
 =?us-ascii?Q?nuy2/dI6pg3ECUVoJQLn9sszHQYt58Q7QSkMpGL+8ZfBi5RgUhoYLMm6Zdd8?=
 =?us-ascii?Q?v9SWtf8d0QCxMJMthUts7jmu94XaKVPcW48WnrT9JLYc2PzmiU/twd3Kmqrq?=
 =?us-ascii?Q?ySz+ezfmKm4TOgA87gRGUT8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 489ba04c-d578-42d2-1f94-08dadd6aed38
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 00:34:14.4058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8tg0EqgN5Lf+Hpxs7W4TU7DlHxxfxfDvbZoIOePc7LjiL/Oag9kteWqTxXqKz32OuLxXWShsxl+3d1GWLX3oh9wWDHtJKtFeyI9gHhYQ2qc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5223
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212140002
X-Proofpoint-ORIG-GUID: vRBgYwg7fkI8eVg9s1Y1iuT5mt8L3ZKd
X-Proofpoint-GUID: vRBgYwg7fkI8eVg9s1Y1iuT5mt8L3ZKd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Keys added to the IMA keyring must be vouched for by keys contained
within the builtin or secondary keyrings.  These keys must also be
endorsed as or by a CA. The CA qualifications include having the CA bit
and the keyCertSign KeyUsage bit set. Or they could be validated by a
properly formed intermediate certificate as long as it was signed by a
qualifying CA.  Currently these restrictions are not enforced. Use the
new restrict_link_by_ca_builtin_and_secondary_trusted and
restrict_link_by_ca_builtin_trusted to enforce the missing CA
restrictions when adding keys to the IMA keyring. With the CA restrictions
enforced, allow the machine keyring to be enabled with
IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 security/integrity/Kconfig     | 1 -
 security/integrity/digsig.c    | 4 ++--
 security/integrity/ima/Kconfig | 6 +++---
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
index 599429f99f99..14cc3c767270 100644
--- a/security/integrity/Kconfig
+++ b/security/integrity/Kconfig
@@ -68,7 +68,6 @@ config INTEGRITY_MACHINE_KEYRING
 	depends on INTEGRITY_ASYMMETRIC_KEYS
 	depends on SYSTEM_BLACKLIST_KEYRING
 	depends on LOAD_UEFI_KEYS
-	depends on !IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
 	help
 	 If set, provide a keyring to which Machine Owner Keys (MOK) may
 	 be added. This keyring shall contain just MOK keys.  Unlike keys
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 8a82a6c7f48a..1fe8d1ed6e0b 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -34,9 +34,9 @@ static const char * const keyring_name[INTEGRITY_KEYRING_MAX] = {
 };
 
 #ifdef CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
-#define restrict_link_to_ima restrict_link_by_builtin_and_secondary_trusted
+#define restrict_link_to_ima restrict_link_by_ca_builtin_and_secondary_trusted
 #else
-#define restrict_link_to_ima restrict_link_by_builtin_trusted
+#define restrict_link_to_ima restrict_link_by_ca_builtin_trusted
 #endif
 
 static struct key *integrity_keyring_from_id(const unsigned int id)
diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 7249f16257c7..6fe3bd0e5c82 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -269,13 +269,13 @@ config IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
 	default n
 	help
 	  Keys may be added to the IMA or IMA blacklist keyrings, if the
-	  key is validly signed by a CA cert in the system built-in or
-	  secondary trusted keyrings.
+	  key is validly signed by a CA cert in the system built-in,
+	  secondary trusted, or machine keyrings.
 
 	  Intermediate keys between those the kernel has compiled in and the
 	  IMA keys to be added may be added to the system secondary keyring,
 	  provided they are validly signed by a key already resident in the
-	  built-in or secondary trusted keyrings.
+	  built-in, secondary trusted or machine keyrings.
 
 config IMA_BLACKLIST_KEYRING
 	bool "Create IMA machine owner blacklist keyrings (EXPERIMENTAL)"
-- 
2.27.0

