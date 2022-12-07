Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37303645FD7
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Dec 2022 18:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiLGRNs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Dec 2022 12:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiLGRNn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Dec 2022 12:13:43 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837D167207;
        Wed,  7 Dec 2022 09:13:40 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7GGpQ1016130;
        Wed, 7 Dec 2022 17:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=zvfH9OOTWmnjOzirR9ArsmAdZMBFNwfvCzWsRoZHEmw=;
 b=Cff0/X/M4eP/ih0cvaWAJR/qeEOfwwnk7TWuAqQFxvyA0/iV6fdnxHViU/Bm2GO9bnVF
 u4BZnyPHjsdBC4t81ePEW0IWRBHjsntgDJTFXMRPlvH2vwX0WoeOaOuHvUaurU4CoISt
 jA6z18tpN3rPNPP89Ewjc5GFHcMG98OUi4pLiX5d9e3yi1Iha6uCVFmJWdAB6ZwzIIuL
 Vb9wqswP61j+uhOEIO9inFHw0BSFWrse7jyR9jOYx7YORUNfjTtnM387NspFW/OMLYfh
 qRq66CCojMkTDyQ9FZ8ReNLpC2vrTF2qY6Gkr12EezvXiauT2dL3FcnBjrRWALME5EQd wQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3maud70vuy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 17:13:04 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B7FwNFu033884;
        Wed, 7 Dec 2022 17:13:03 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3maa7wtwks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 17:13:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehBZM/8gFjCrLSZddeD+B0bCduwedwWkfF2q26DxOjV6OnWM72uuDt6pVH8XxV3+Qfl8x6dDkl9F654k2vCas3DYoS5Kg2ca7Isr5Yelgplu4JJOPeoiBwPKc1cqml158srWD5oYye2XfbFmVZaRHgipDk3p661I7CYirLN20qjtrjr+wGj9LNQdVgV0D9/8jPjOir8Yksnf3Y75geYea/fO6QsDCMHNEz3cqSLlrwE6NGjMwcIRqDcOzMw++qEd3Pk3eMxtv6cs5LFP7MZVPhDSTuuDES5879JQCA+A0lM9dVprfhbtbpFP2eO5TEATI0EwTvEHj2BnLfAi+YKT4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvfH9OOTWmnjOzirR9ArsmAdZMBFNwfvCzWsRoZHEmw=;
 b=Awpw6IdYeCxZxpxHGW/RLZ/JlpLIUGdeSYwBEnsasCQRClViZqoHMLj/6beuWaCCPRPHBjMhvAscm2ZnaKUmMPxsZhxRk9pPtdg+f2c/prVAjnIst9bsB/cThH3QjXcSsq/GGRPqav3FPIhZBO6CIyHG+Pd4YNIIMXLpHTRT33cUdrJWIhtdxABM15M4eijhRXRRkaV9UcP3ALkwfm5cXqcYHnwh7h45KfZ63XaFQjKtUugG1aUSSuzL7GB3SKi/zFNzdlRjRyg+Q1tvLi88eJsg+SRrcpLbaWfu1f2CfB+rG9AcwoICnP/9+09Xym9zfZBqblYVWFzWPwvxrJlklA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvfH9OOTWmnjOzirR9ArsmAdZMBFNwfvCzWsRoZHEmw=;
 b=gjcw8XtasGDOYL8o4VDAcX7A1eapbFXa+Jo5rdiViM2ko8pSRLf0H0MS178o9tJPE1ojOhlTjQyu9b7BSwP4m3SM3G1tg0If7Jvv+YMPE9iAMB0gGSb1tDNzLEy7ADHQvIdTHSS6fId0+8zo8H+e0X6YXI3icJyAPZLcodtjrPo=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB4182.namprd10.prod.outlook.com (2603:10b6:610:7a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 17:13:00 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4%4]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 17:13:00 +0000
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
Subject: [PATCH v2 08/10] integrity: Use root of trust signature restriction
Date:   Wed,  7 Dec 2022 12:12:36 -0500
Message-Id: <20221207171238.2945307-9-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20221207171238.2945307-1-eric.snowberg@oracle.com>
References: <20221207171238.2945307-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0220.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::15) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|CH2PR10MB4182:EE_
X-MS-Office365-Filtering-Correlation-Id: 22135200-81bb-45de-10a1-08dad8764aad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0+KAzs8bY52oYq+Ys5JD26BHfOEg3LQQFN/PmmfBbfD9rjSqJhlrEjsjQVmuZG84kOsIc1vYYRh98albafJxvRfealCzoOf7bP4R7SBlkdM4ygbFFmCnhv8KY4v4Pw4K+YRhytExULBBCVpgv/PjgJV9+EHrID7brz7na4rgDR0sH2x+Disd34GQYJODLQUdhjO8frQLxFKELOwsI99B7N4SAa3l04f+CNtTfE3Mrtw+aA9xH5oj8eoy/n4H+BYMFSdMZh/6/4wgEJPexLeHFY42TrwOCR73eDjJ8NYYA3Qgklx8i3CzrVjt67Yf9Eewf0sBcgsUQyrLPg8W6EXICjzr/ezx4RSY2s7wzsRa2coOZaLjjctsrUgRmWE766GaHRKWOLt/feGn/gCQDcef0LtY319tcE474oKyNVEZL8675bqFM1xQlyOD97IHCdUGfDfrhxnHsHTWF085IfKQI559yOCKWQq2Z84c9VsXPS3tqQrSsUnI4updKhtMVWXHbTQPDJDZC6m8vhILnJuZqxLyebutsnLT79NoP1X+wMMpKhgH331Yb/1WX8QTG3bUsha8cMeynsDMxbGGBAln+WANcg+r+2gfDQDq0rKeoXrHZy5OCm17ggGwy4FUPopddF82NiYk8CMvwEkYEseZqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(346002)(396003)(376002)(39860400002)(451199015)(66946007)(66556008)(6486002)(6506007)(6512007)(316002)(4326008)(86362001)(8676002)(66476007)(6666004)(1076003)(2906002)(38100700002)(41300700001)(2616005)(186003)(7416002)(44832011)(478600001)(83380400001)(8936002)(36756003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TSpyD0XcFUf5SxO1mc69YsmuvJTJxpF05wO/frIH8aJole5VwMqxc6S5l3/1?=
 =?us-ascii?Q?EAcKWkPrlQf7+NxCS9VO6BJv5/BeRo8yq4nR8wN1yjgH+qqhgviT0YMdiYpn?=
 =?us-ascii?Q?KrLGG1CZdLdhCc2TavQQnhGg1wf/PSgPgjisiqRV5o7UrB7uDPPs7kYItA1d?=
 =?us-ascii?Q?rEsrmpj00oCmfxfQ6VC6SyFOi54dOvPwWYspnZjL5j285RxNvNvCwlZVJ+GB?=
 =?us-ascii?Q?7w4jqj+MpFuYhBecnp8Il72N8V5ffHUTJRo4aqzEuAszy4PKbxUFCDIJnS7J?=
 =?us-ascii?Q?eVNMQubySwlMmcMUQlEipOzGwjOaCqJaiJuHxVeyzmTofzulwZVus5rkc2V4?=
 =?us-ascii?Q?c5dIVPKWw+WT0BfeosohFhvvK/HqTSkKwcz/wv5gKpp11folaJbxupFTKfPa?=
 =?us-ascii?Q?TCdHUOifjT5sf/TuWtiOwvrGBv8KDE+X7CLGkNp61SpToIJso8jVF17fB9IB?=
 =?us-ascii?Q?c0sc2ra+1gH4A+UEdZllh8z4itnWvRH50QfLjeWN8YU7WlbxXYj0yD9QKsWA?=
 =?us-ascii?Q?DIW5PcGC7Fg1OSEDnByH262oFjsGP1tt3x0eRwVo134gyti4wM4/3CKTw/xf?=
 =?us-ascii?Q?Wwa8g8X8ApBhoqR56hfaWkCffhHRnotomSuV73hj1+gOLPdntCpNN8JVy9bZ?=
 =?us-ascii?Q?zpGbch+Y8lBsJP8DCqvJl2rk0BRSxXKoJXPSmZpLFqdZpkgP6vVEoVKbxdNV?=
 =?us-ascii?Q?rahzyyna02+V1oBrQvWvOy7fbIR23Sa+SqdZt6pyYZLGU74vV051WsOEj2Iw?=
 =?us-ascii?Q?fZQGgFXXIYk8lsp4uVOwtWaXPawiuBzv1jP9+cVRJ4rEUsgTVbATxgWM5qCB?=
 =?us-ascii?Q?ITuHQoUDJI73CtwuSQota5AmaJOAMNFQUJ5yraTKl4DNn73lYOVaRbLM4PXX?=
 =?us-ascii?Q?Ae2zhS1bSbPecpcdfoszbDc5sVID6ZmXSPn1angNNbYZzHXhXvQRgMbE8trK?=
 =?us-ascii?Q?YmO10CZ5j6M9CDQ3hICe3jZLbobo8W2XCnwONRpQOO4xicpwhkrEmgUtijZB?=
 =?us-ascii?Q?CdkctLZTuqsdBALKWVYm66vE1bGSQwWMtVGdW49ujlVRbYD692v1744mBj0+?=
 =?us-ascii?Q?hNCu5G0b2X9UqFXM0kjPQCtaty90f9f/6QexTPwcY4ha9CuLZ9jVvEh2O/yS?=
 =?us-ascii?Q?4pd68nDfZkUFc12pV/4u6xrTVbHYCbCrnjCb0cUtuc30IHAYVaoOLzNVKLPz?=
 =?us-ascii?Q?PCl9NVW2jqPNbgiGs1ce4cwZi45NS1qBjlsjBEP0RXgcK1obZmeS4UzDPO5S?=
 =?us-ascii?Q?21aXGEak5MdjIxx2Y5mDeXui2qeEVJWaBoTO35OmER68wzR5/zc8yqEAJqOM?=
 =?us-ascii?Q?I5t4/Oq/daVlahdg4Dw4lZyED9iUmHpjIqcihFHhIsZ0p3MDwLR5okDJ9aUg?=
 =?us-ascii?Q?T8kl3/YAwzSsK0KY60XxpO5SVF67ojfWnXBc1Aqdha2f5z2Pkoh2azr0j2do?=
 =?us-ascii?Q?Gv5B0fGU09TTie/7yrIg6CAazQiTC4CmwVtAUrYybfPYNv6dXdOpqgYer+9q?=
 =?us-ascii?Q?p+iWmH8aw3vSyGEplXlBPoEow3hWFJb3zHHpQS3b8KAu0hQPcikVnr4qOh5U?=
 =?us-ascii?Q?YLimF9CaNuDlK38HTQxNKRXo++DZJ39H/aDC5j+XzkFUkFynvpQZ27W19/er?=
 =?us-ascii?Q?w5fXJEkksdJABbJsLV8yXqA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22135200-81bb-45de-10a1-08dad8764aad
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 17:12:59.9442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQW3DMx6VduihMRGMisFY8mAO8Jer4ldU/gTYTjS5Lb6jh8fO5AClf+zg1xXOrataTYztub4WAVhbAC8pTH4DRHlVSq0Zr1LHP1Q3KVH550=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4182
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_08,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212070150
X-Proofpoint-GUID: FGMLKIJ4r0nHt-3YgLfuaaMHUg77u5xz
X-Proofpoint-ORIG-GUID: FGMLKIJ4r0nHt-3YgLfuaaMHUg77u5xz
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
within the builtin or secondary keyrings.  These keys must also be self
signed, have the CA bit set and have the keyCertSign KeyUsage bit set.
Or they could be validated by a properly formed intermediate CA.
Currently these restrictions are not enforced. Use the new
restrict_link_by_ca_builtin_and_secondary_trusted and
restrict_link_by_ca_builtin_trusted to enforce the missing
CA restrictions when adding keys to the IMA keyring. With the
CA restrictions enforced, allow the machine keyring to be
enabled with IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY.

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

