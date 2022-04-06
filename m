Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFBB4F5B77
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Apr 2022 12:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355739AbiDFJj0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Apr 2022 05:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1584706AbiDFJfw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Apr 2022 05:35:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7DE435372;
        Tue,  5 Apr 2022 18:54:32 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 235Nw802004892;
        Wed, 6 Apr 2022 01:54:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=VdPNx25G2dvg4epz8CwqsxtVGHhhQxextydbflBLWBM=;
 b=XKo9IhvxgfvrN2cnROtID0TlBMuofi+Qmwnts7L3CW8bBpGw/xfWaFkDYqstR9ANJber
 9L7ffwre57oArs1jryCfKHFYF3Z+Ru/S8285sSGMJMKB4Q4b/1Ce+A8radnxLfun0qUW
 IMVFNPhC0jDfiLlitpxFUCuZDt7i/rBbasQqMgF4waisvcLYFs19Ai5CJCBrMuvAeI5m
 SmQgvNzigcPTJppK9GIyC8e7beNp/gss1kHwSk/V8bnH7ZXgdfU4tupqD7p+dsLTlwpz
 gIp1g+Mp9ayhvhKz7FayRgyIT/jslGst51g76uLcWe1fvwHfYpCOhwvvHYdL5YdA3y4f fw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d92ykh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 01:54:06 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2361oQF5003498;
        Wed, 6 Apr 2022 01:54:06 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx42aj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 01:54:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8weuBcPMpNtUIwOD0Hea2H2Qzba8vNjmyO1YmWsFJlMdEQqFVE/piLHBWaORPcOPvMWnBwo5Ww6FWoy5TkV+XdLHkwP+2+HwP/b/kojevezwjUe31+BGZupDZZTHBq4CkwLO3qQoGOn/FH5zBPOZdkHCmAyey+QraMwgOR/c5u4lA4FWMqP21O6uJhPNMzkQS21+AqQ02EH36a96iBCO1dCcU7KLTmN/fx0OJFvykEwsC1sW9jJ6cuFHOnU9g2kaeiXaY/2KX6OI4BuVfBEMoHxmxY67pVNrcPEjqhVdJ31LpDs9GPiPlqqQdI2lzS7Kei/gCO/sZEo7Dwj5vs+cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdPNx25G2dvg4epz8CwqsxtVGHhhQxextydbflBLWBM=;
 b=Ffj90idO3TNGl3w0tjiClh+kVa52taslxZtJFcgn5Y8rczaS4IwnqQWQuzPzhLNcrnF2qji0jarb0dVzw4z7rlq4mTHcocg5bL+QrQI/0fKbMZ0t2bzfp5ldWK2lvd6BEp2Ey17KC9AP2DKc4D2auaA0QO+mh5PmN+mqf2tC1khAjvVtHWX9XhWnjFMe3I9fwCG4PvhM/itgydIhF/S+kh5YvSWwbbC9NLSGSVba8NnQNGFoIH2KnyGjFL8SVxPO14S4TDaxpImITc0Td5S/kIIzqtrcvpAwddbBt201uxdHXUg8ZImXRz1K0YC8bcZ92HNlzqI28IQV0zYZuUV6EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdPNx25G2dvg4epz8CwqsxtVGHhhQxextydbflBLWBM=;
 b=hf8h6WJ9LkpjR87lOrTyDYETO6L2MFdy+vptqOzNYdy2o6oDQQSdQr/F+QevfxETJmoMCwKw49SNYtCVF6Qkhq8BMKAR9Zm/sHJ5MAI3VBd464wMZfUlm1Ge4azn7+znE7AI1Th0StehBf+ucwD4dtmUo2VfCkjZvXu4Wdimmp0=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by MN2PR10MB4349.namprd10.prod.outlook.com (2603:10b6:208:1d4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 01:54:04 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7ded:5b3:a28f:2e55]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7ded:5b3:a28f:2e55%5]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 01:54:04 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     dhowells@redhat.com, dwmw2@infradead.org, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        roberto.sassu@huawei.com, nramas@linux.microsoft.com,
        eric.snowberg@oracle.com, pvorel@suse.cz, tiwai@suse.de,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH 6/7] KEYS: X.509: Flag Intermediate CA certs as built in
Date:   Tue,  5 Apr 2022 21:53:36 -0400
Message-Id: <20220406015337.4000739-7-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220406015337.4000739-1-eric.snowberg@oracle.com>
References: <20220406015337.4000739-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0091.namprd11.prod.outlook.com
 (2603:10b6:806:d1::6) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b50fb05e-acd0-42de-c747-08da177053ee
X-MS-TrafficTypeDiagnostic: MN2PR10MB4349:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB4349EEBFC2B99E558BC059C887E79@MN2PR10MB4349.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F+EyaLaZRr5QN/Za8jppd0HWyRHovu6YfCxR14frRXoSMaV1ffUeX9tSPWCPHM42zMrC/4idKc4H/wDo2AfVAiZDgRe9+Hf0Y3EM6il4ZZchKqxhcEgj3CRK7tdUlTXUz1N043hizPRU9Y4M5Z4cBh4T+K8A/hEhlNRbTnUrUOtUQOPmSHKaZOM9OUE8/NTult9u/VeIsasVqhKHaYq2dgMJFBH2i3/7OoTasIFvpgE+/79HrJfiRpT0OHB3o6IGhXJPhhVb7IG4w/SJ1euRQjUqzstmkYIsdbSXosUL2i9196OgwNkPEGwo0vv+PQs4lpTjlqzA2fJ0p257aY3U3RCPlwK5fn86pmFFvOm0YiL+T1JBZkFvZWtvYHNxELgUlsIhjVqD9mZW93xr7++fmxdLKUrIC3GNMgb2jKGnGHgzHaUZN7zsER1uv/vygF1jqLAQLCajipR9aDAKDGNnPeUwvXlJHmDj3vJtYmQvxtBBG4zHqpRGKaWWxRJ7uAW2dvLbbMIT28OVD7WJJChuchBu960Q+gpqEdg40Fr0rACq2PES+3YNizDRSDQGRFFGG94drr/a1Z/dvphgpkI+lh2Jv89bgKqmIeAfY9vbocUiX+JWnujZkSCEKrpcLBAOZ4g+PmBc1yvvdAaiY9+HQt18GwQNenb+tIEZaltqY4R8/eDd2ckRm9E/xx8ZD/6mS/Q/l9ZHFGu18jC03fD+JQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(8676002)(6486002)(6506007)(6512007)(6666004)(5660300002)(508600001)(316002)(4326008)(66556008)(1076003)(83380400001)(36756003)(186003)(26005)(44832011)(38350700002)(38100700002)(66946007)(2616005)(86362001)(8936002)(2906002)(7416002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uypl4AAb+0tPVL7pFE6HfnkPO3eSNwLKLPXo2IGmSZuM2Fa3oJf6z4ZGWcUf?=
 =?us-ascii?Q?nNtx4dqgKUPpkAN/xI5c4skXsmaud31uO0JnC8SP43MHEGNNiIF1X8MLcfjV?=
 =?us-ascii?Q?P8NfXSQ9vdDRv6O15uVVDQ34S++aMd/+6SdTFxQlE28dMa0zbw4ok1G9g28Q?=
 =?us-ascii?Q?q0MQelnH2mExv4CRevNr7OLps2c8QZP9d6ASflSZRk3shUCUcWrFrr6T1cBc?=
 =?us-ascii?Q?hVZx32UGL1Z9TuzygFB4Df3+DjyQwc3feSyFtP5yW9LorG/QUYdCL4bsy2KO?=
 =?us-ascii?Q?Urgfv9J1LmJues+hcnkTkfAFLXExq07I73RlkNZLV2pKYn5syFVEijc3llFC?=
 =?us-ascii?Q?20EpzgQ/SStieoCe27z7AvUAF2HAlgLAIxy5bH5CIu4txYlDlObtkykWbOMJ?=
 =?us-ascii?Q?QWA1aL4+4XLDQca5UGSxMoc55Vz17nPjFGNbVANjrwd1Srb17JWokRTVaU8H?=
 =?us-ascii?Q?ctWc8RisOgN+/fe10J0ZXiwX7XCO3REaTttvBtf+/FCxfG7Xp8B05TyRyxD5?=
 =?us-ascii?Q?jTAqao7DZQS76V6+7569b39EHJv9cO8q7slXiqc1caNAl+tKdV4FFJTo/VsJ?=
 =?us-ascii?Q?v3YSu9XJNDy47+lFfDEAhEzPQVJsXpUKTAGgXB4OibfuqzktLiwxo4ZhgBhO?=
 =?us-ascii?Q?uZqBLQTSf4gRWeh4MrOmDXlOlpdD+qwhGUaHgOCQfWJTY887SBwQY3q2Jlds?=
 =?us-ascii?Q?h/P3S/F4tBfmpMcB4iz1N46CZtZ01NKrdL0XHVKzz6DkyGw9Tvas3Jih3WlX?=
 =?us-ascii?Q?jj2yqv2Fog3ieK3YkQyW3lRNJN/kB5jbJaczJJQ7dSottHldaEO3SJSD8cQA?=
 =?us-ascii?Q?noMtqZKVJy9+y7VQSu0b1liRXHnVZ0ZePoku98Fv7WcA/l+6rXIjke51ZcXr?=
 =?us-ascii?Q?F9mJO6dCr3EUjc0VmZtSyQ22iHbDAZr14MJMjRmwlCgFWwnUwksfnoA1drrb?=
 =?us-ascii?Q?1t8BtdYHtd5U3whiLt38IhUCnpAR0Zt6PFIzuAXCLdLY5Q6y1LByV4YHiHyb?=
 =?us-ascii?Q?qv5z1yO42zIb7GobVEiGWNCnrgwXXaZ5DgjCgVxOmsZesWJyFmVO3gINjdFD?=
 =?us-ascii?Q?ZaTDTnFBpmGMLbHzTBEhLfOVmfBVza/S8+j4bgoaNyk8nMT5VS8jAk8loH5H?=
 =?us-ascii?Q?uxCdD+3fjBID+pzSgrRb3Citti78WZo1X7QvB0rQvoJo3deuSLfl+7uyvngn?=
 =?us-ascii?Q?00i/wgMOMtdlWo8gWHDzddznsHLBUYDWVhvYLXp9aYtjxkMz1T0w9qdu4ufX?=
 =?us-ascii?Q?8zhUYydc660YK5PsfFhHP1G7+LTsuNGiz+0MFMJO6v6uV9UYVAOmpiVZGpXE?=
 =?us-ascii?Q?l/U1sahr3vkwk2hL0/C7v8axW5kG0NzxS/QAXib990jpDiFmRulkxsgbvE/N?=
 =?us-ascii?Q?1WTtxrgBfQQCGjhHzaepcGhiTae+BeUBa1xW375ofRKzU+3B6Cvrb0Nw85Ru?=
 =?us-ascii?Q?sKee/SHkqKFmij4oKcgunTdAHFX3M5WLOLLebXfSBYyYLZj/o9en6d8utYrA?=
 =?us-ascii?Q?n8SKPssEox/TjEJ1uDlXu9wmKWxYYpmgnR1KzuPTE3EOQdMP+BoOYnQehRFO?=
 =?us-ascii?Q?Pg6vBjuLz4x2tdV+2gMZCwo+xX0NUnnLjvudrEtPVGZ+wkVXoBrv4ziQ9kXZ?=
 =?us-ascii?Q?cnapWHw8QzIRfDmElJhB/E2m7vR//xzzn6Vowa5YXM6FNNUd/6CIQNQL8YpT?=
 =?us-ascii?Q?3axv/qkhqpXHTWk1Bstx/ooAcltmtIh2SuyQRaiTM+Ti1FK3D8q7zKhR9RGp?=
 =?us-ascii?Q?Gto32FcOFSXN03YdRLbUSZKHuhKv89M=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b50fb05e-acd0-42de-c747-08da177053ee
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 01:54:04.0310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZ/ppRE+nEUaWoE2JgIcj0PgJldjfW8QL45Ru58qWRWC5TEs8IvkjNKaCXY0UmiKnrSUy/IxcDf4wvAM/Z4kkvAbdTmRHd2kk1RFLBOLV8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4349
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-05_08:2022-04-04,2022-04-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204060004
X-Proofpoint-ORIG-GUID: UICZSiilHIDfhnbEw2BJ4c-cDcRayPW_
X-Proofpoint-GUID: UICZSiilHIDfhnbEw2BJ4c-cDcRayPW_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Currently X.509 Intermediate CA certs do not have the builtin root of trust
key flag set. Allow intermediate CA certs to be added.  Requirements for an
intermediate CA include: Usage extension defined as keyCertSign, Basic
Constrains for CA is false, and Intermediate CA cert is signed by a current
builtin ROT key.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 crypto/asymmetric_keys/x509_public_key.c | 14 ++++++++++++--
 include/linux/ima.h                      | 16 ++++++++++++++++
 include/linux/key-type.h                 |  1 +
 security/keys/key.c                      |  5 +++++
 4 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric_keys/x509_public_key.c
index 7290e765f46b..9052dd761ea3 100644
--- a/crypto/asymmetric_keys/x509_public_key.c
+++ b/crypto/asymmetric_keys/x509_public_key.c
@@ -215,8 +215,18 @@ static int x509_key_preparse(struct key_preparsed_payload *prep)
 	prep->payload.data[asym_auth] = cert->sig;
 	prep->description = desc;
 	prep->quotalen = 100;
-	if (cert->is_kcs_set && cert->self_signed && cert->is_root_ca)
-		prep->payload_flags |= KEY_ALLOC_ROT;
+	if (cert->is_kcs_set) {
+		if (cert->self_signed && cert->is_root_ca)
+			prep->payload_flags |= KEY_ALLOC_ROT;
+		/*
+		 * In this case it could be an Intermediate CA.  Set
+		 * KEY_MAYBE_ROT for now.  If the restriction check
+		 * passes later, the key will be allocated with the
+		 * correct ROT flag.
+		 */
+		else if (!cert->self_signed && !cert->is_root_ca)
+			prep->payload_flags |= KEY_MAYBE_ROT;
+	}
 
 	/* We've finished with the certificate */
 	cert->pub = NULL;
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 426b1744215e..3f23bccf880a 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -12,6 +12,7 @@
 #include <linux/security.h>
 #include <linux/kexec.h>
 #include <crypto/hash_info.h>
+#include <keys/system_keyring.h>
 struct linux_binprm;
 
 #ifdef CONFIG_IMA
@@ -176,6 +177,21 @@ static inline void ima_post_key_create_or_update(struct key *keyring,
 						 bool create) {}
 #endif  /* CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS */
 
+#ifdef CONFIG_ASYMMETRIC_KEY_TYPE
+#ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
+#define ima_validate_builtin_rot restrict_link_by_rot_builtin_and_secondary_trusted
+#else
+#define ima_validate_builtin_rot restrict_link_by_rot_builtin_trusted
+#endif
+#else
+static inline int ima_validate_builtin_rot(struct key *dest_keyring,
+					   const struct key_type *type,
+					   const union key_payload *payload,
+					   struct key *unused){
+	return -EPERM;
+}
+#endif
+
 #ifdef CONFIG_IMA_APPRAISE
 extern bool is_ima_appraise_enabled(void);
 extern void ima_inode_post_setattr(struct user_namespace *mnt_userns,
diff --git a/include/linux/key-type.h b/include/linux/key-type.h
index ed0aaad3849b..da09e68903e2 100644
--- a/include/linux/key-type.h
+++ b/include/linux/key-type.h
@@ -38,6 +38,7 @@ struct key_preparsed_payload {
 	time64_t	expiry;		/* Expiry time of key */
 	unsigned int	payload_flags;  /* Proposed payload flags */
 #define KEY_ALLOC_ROT	0x0001		/* Proposed Root of Trust (ROT) key */
+#define KEY_MAYBE_ROT	0x0002		/* Proposed possible Root of Trust key */
 } __randomize_layout;
 
 typedef int (*request_key_actor_t)(struct key *auth_key, void *aux);
diff --git a/security/keys/key.c b/security/keys/key.c
index 732bb837fc51..c553040dcc02 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -900,6 +900,11 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 		}
 	}
 
+	/* Previous restriction check passed therefore try to validate root of trust */
+	if ((prep.payload_flags & KEY_MAYBE_ROT) &&
+	   !(ima_validate_builtin_rot(keyring, index_key.type, &prep.payload, NULL)))
+		prep.payload_flags |= KEY_ALLOC_ROT;
+
 	/* if we're going to allocate a new key, we're going to have
 	 * to modify the keyring */
 	ret = key_permission(keyring_ref, KEY_NEED_WRITE);
-- 
2.27.0

