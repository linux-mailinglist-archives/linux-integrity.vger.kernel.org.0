Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6604764C13E
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Dec 2022 01:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237786AbiLNAei (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Dec 2022 19:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237766AbiLNAef (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Dec 2022 19:34:35 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671D41D66C;
        Tue, 13 Dec 2022 16:34:34 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDLO7dr016062;
        Wed, 14 Dec 2022 00:34:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=9T70b9iy5omFjdxa6HUf4W+h/52V84VeDdJ/ZDQXe3U=;
 b=1DezFdD/LaHfgbOgLuNlGJx1QT26KX8gUISMbVChFcuABo7vj8MW8iMT03TMDOg0IavI
 S0qElciIA6Blcd/YsAlZMCkp2zB69pH3Qhohm1g47/wAkJtEquTi94CZx7NIf0DMiX7Q
 bZvw7SdupMWF9UfcyF8RAzRSK/qSffjK4XiwRm/JjJXmJE+q/GYBIM/5QOg6Tf2aOeIl
 RCIRyK6LTVtTGawhsyRPa5wtNpbOy4heQcjOJf6nzO9BnS3D7CqdVsfO9ZLoAkprb7Dq
 ruPsOML7K346dEf8Lyph0KzvBEtuDBbN7t/w5jyOp5IaNcCJkPGp97NwbT0idqViL/Jl Fg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyewrnth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 00:34:15 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BDNUIaO037224;
        Wed, 14 Dec 2022 00:34:15 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3meyekcq6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 00:34:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMgnWFQCN1KMslKg64Pi+Xb3Z71Tk0Yk8QO704ZN57JPkWxDNWFL4tmkcMXh0FsUT+NhFuCbxdEzmfaEjxxKzB2cfbgLX3p4aAeHxJDVxwB3rTastWR+x2MmO9/30RjqxhTUmqgvgqLV2/znhzILGhtGK8q2SW4C6/wtz4r9MEtwHPwfQ7jsm/Bk0OVCABVhM5Y90ljc/nuzeaG2SZVDO1CgZDzAyK+7580pjbl+ljieOirNHHGAoogW8Hkyh7Y+3PYVP7dVLlNIGerKsrXGIATUa+Gnq+Xry9wbsj16LlF3i60TLpjtEMwvPUcZWXwlJDBgDqxtnOkBaZoR3FKMaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9T70b9iy5omFjdxa6HUf4W+h/52V84VeDdJ/ZDQXe3U=;
 b=ZzpJizFY1ioWpYpgD/ednEkzxoztMQtXrwCKQYG7xSEqZtFTRLGO7MjLWfhdyAs+buZZflaX4sE/MBsSc+kxe6QYRBYPOTYE9jKb1fOLxO1BEuxPzQsnl9QkpW2SERy+a42+ZiQeisICtv/dygfkpUjTKMlYo//8cgR8PGP0+IsOVZ+sMBBLvM3wYWkou6KLVjNUWNnVMqfebg4b7CcuOsOmbGLEun0BpGhuPx9dnR0b9r5Eo4mOcUlgumdez5uG6SYrDKxzr6ARx0kciR8OFUkoN1CowbHHmB3E4UQvlfQhmurVL9bmcWFfjqwdeYqao3AeUXPVgN6+mVQSnZXjdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9T70b9iy5omFjdxa6HUf4W+h/52V84VeDdJ/ZDQXe3U=;
 b=EjY16i8J7wpSGAvU6QLehmKe0BGnegSxKne1dJ1Zapj2jF9zySCLnVd5hX5/H0olAMY0uqnCCHANCL5j8wsDQNU4ngyq8mTqVTlCx+Jm2L6pZL2vC+1bBMe4MYXu/+zA893B6aF+4JxSVDE2CCSBfZNS9Rufir6IX/3EigMsMHs=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by BN0PR10MB5223.namprd10.prod.outlook.com (2603:10b6:408:12a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 00:34:12 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4%4]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 00:34:12 +0000
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
Subject: [PATCH v3 07/10] KEYS: X.509: Flag Intermediate CA certs as endorsed
Date:   Tue, 13 Dec 2022 19:33:58 -0500
Message-Id: <20221214003401.4086781-8-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20221214003401.4086781-1-eric.snowberg@oracle.com>
References: <20221214003401.4086781-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM5PR07CA0080.namprd07.prod.outlook.com
 (2603:10b6:4:ad::45) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|BN0PR10MB5223:EE_
X-MS-Office365-Filtering-Correlation-Id: 6288827e-127a-491f-62eb-08dadd6aec15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SmA4pAGxsvgJx6YI0KEcy7elaSsZ5LgxGgKOEDS3GO3bZCHNNeTI2Pe+CxQNg6kNpqiZtDsE23X9f45P2BoDBZmr9Eo/nz/085FFkKd9DGxZ3Ay/OvCCfYax/cHrOTKHVttVh0UAW4qrB2IWaxKMmMaRDB6AX6Ubik3WflQFrVUrq3La5s6THER0t0GlY91wqBNZDz20GCDDyAi2fuQZt9eYSOeDr7cO7abCzFp8GxOgSI8kb8A4NPWufJbpwln0AXfBuy8tu/RfRpNBIrBPN0HlZgGQl6dCfMWwa9lxlhW/fdUL/z6FrrkNFCcLYPEG8IuQZcK1YKv1TyMhJNysF+Ae5F2oMZUIgvn6FAgmkOHckI5/LnRNqN+c6VhioIS/MKvW1VaKA+eqkJI096gLMwl/TVjjxxCo1CthILuCkasvvrjTZcJAxxerBJVaUGQB7qUqdyh2G2j3pYh71pSoEN6V/t0DtRjypSGXQK9LTLkJpuozSnx+kxVPQncrvWBhXnA/IcUjkIwxL36Arf4tAM9/13fiHT/D0Gr+M0xBaPIYsgyTn5FKe0dTRfXmmJSQIsu4w9Fgj2Bl/zVlx2c+M0iMYdpADqK9quKRxfONfHA/O6+3BVM2ZGlmUMyzHiyIiFvsxf3I09ehRGJ0ZZtNlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199015)(41300700001)(38100700002)(86362001)(6486002)(8936002)(478600001)(6666004)(4326008)(66946007)(8676002)(316002)(66556008)(186003)(2906002)(83380400001)(6512007)(66476007)(6506007)(7416002)(1076003)(44832011)(2616005)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+n9qvO7wn/BPv+B/m6Ly7P5YM+0HCvXYA2Qd0iG3GYWZ8Q08hhY8cH1cKzmo?=
 =?us-ascii?Q?S4GGhnRIKYBCUXyzDA6m3JBxH4rjthgWyf2G7zh/JYfZGg572pjw+go0toM8?=
 =?us-ascii?Q?zxLmmH+5mquiF/CuQ2CxCyy4I96XeaOH+2xakcUUiV5gOI7a+OwIgtcDWvXq?=
 =?us-ascii?Q?e7q0r2fEpWH9khraiCpscPCDmnApQEC12NYHjiVDANnxbxBBls4Cbbb9ELnH?=
 =?us-ascii?Q?EC9kKWRPpVr4l8ff06Hap0RV4MDxhYeSvGgiP2dHbsP9+ua5X4BHRc+Bc2Qt?=
 =?us-ascii?Q?Z/SLr4wHso+sDUb3BXQV3KcoVtTOxl+2jXg67iCzogxfMsLou7lORM3ed2Wy?=
 =?us-ascii?Q?SL2xAaiaWMNSC2UUUj3FNuDqd4s6P+z05Abf+X9fjyOfFAM1Kh9lxCotG6Sn?=
 =?us-ascii?Q?41FKni/2oQcG+oHvKxKfE7rDwNW8KA37GG4BKLTx//JiwNM7GzlBkHhhzflI?=
 =?us-ascii?Q?Jixr5YXC5DQXV/uUlRgKs/pHyb6BPIlso0wNHTjORAoQOornWUBCevt8gE7f?=
 =?us-ascii?Q?ga1u1Re2iOIxdYRTMddYPn/H62WYteLFIpfPOphVMqMshZ9TSfkb90urFcuM?=
 =?us-ascii?Q?Xo3yJ2X65E7d7z50ks36DrQT8/I0a9poeRtnUsnJm3uhbfrsfdVGXezlCHnC?=
 =?us-ascii?Q?p2JWxwC/xYGPbkW9Fq0tvRAYG5YJQ12uTtveNI2ns3DljJ5XkQZ5InHXfdbi?=
 =?us-ascii?Q?GPS/8F7lB+3LdBDb79dxONO3s8eadrnjj2PX41IUQ1kH2I6tFt9MMn1dmazI?=
 =?us-ascii?Q?7IiExtRmDkxPEwtuksZs0g/+LOUbMvXmp7HYA83bQOWpJ5GFOQ6j+Nkz1ILF?=
 =?us-ascii?Q?Tu784QuRl3MRKDxxP2fWBVWWMUpB1sLgHAHNW9DGV9027G+JW6oOreYCCarA?=
 =?us-ascii?Q?8Um1UqEKGPQFtMdor9CJdh1lQPWTfQhhLOD9dTbkOwXfg3b2ojqP3AGIyk+C?=
 =?us-ascii?Q?ZQKs5nyHem0kMqUyJx4egDxXdlqUvvfIrxinXGm0xiO/LxBQOIrXgObVnbz9?=
 =?us-ascii?Q?lZ7vZVYdtYat3c3m/q/Ywdm2WlikRyPWKIOR+KBFids0iYygAzA8KerWJp7+?=
 =?us-ascii?Q?G3IICSYtceApP2KtD48W1nPGUQRKPeLWQP2E2SPx0nR7pi2h7EqyAOtT1FKV?=
 =?us-ascii?Q?Oq+tNhyCU9UaBVyS11ZON/CzOMsRc/z1qgGIf9mhFrZO4vTA+GiL22Vviz6V?=
 =?us-ascii?Q?79/tYMNbO8B+rcV8AoB+ra0AvZf52gzrbepoa9kVhzPr/2Pk6CwhsdaE6gtA?=
 =?us-ascii?Q?tUDtmKCN+F8GAi4Ci9gkMaeeUeQnFrluMpsrkqWm2J9KVFwUwt+9bmJYX8SC?=
 =?us-ascii?Q?FC7bkExHE6uJ7jvW3gbXY152mOsqOPkIQgXH1h34h6uRBZoIQmb40bmTw1VI?=
 =?us-ascii?Q?/CHshUj7ufDBhN44h5JOrMzH456C0G7EQ1jy0Nxc2Pueh+yrlWk5euG/TPyt?=
 =?us-ascii?Q?bIDkGgDYMObMcpmOpd870CADEaVIpB9gl+D2LskBzfXCmhY+iRe9g5Vs6xTL?=
 =?us-ascii?Q?1qxoa54y0U5VfRzRPNLeICFTO0qxtF2Yec51m4XuZL2wFZ91q1+U83L/QGf+?=
 =?us-ascii?Q?kLe/uW7NqC6HND9C5sMbLEblKe3eXz0Xb4lF7INiuD1ZEJyB1DrP1PI+rb8W?=
 =?us-ascii?Q?rQ3sPsV9zUT1DFxG61Fusik=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6288827e-127a-491f-62eb-08dadd6aec15
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 00:34:12.8598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJb0eBPZLJMZFTzc48LgPdY9du/5m8rDC0pJc3GqlFHqYx2sI1w++277rQquy/aE3Ecl2UTM9cp1pRTwx6MQ4Btg6WY/0MpmATeOTgfIG/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5223
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212140002
X-Proofpoint-ORIG-GUID: -Qa9JTphCEIUQcJ91AbkgnOjgDa-PvCs
X-Proofpoint-GUID: -Qa9JTphCEIUQcJ91AbkgnOjgDa-PvCs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Currently X.509 intermediate certs with the CA flag set to false do not
have the endorsed CA (KEY_FLAG_ECA) set. Allow these intermediate certs to
be added.  Requirements for an intermediate include: Usage extension
defined as keyCertSign, Basic Constrains for CA is false, and the
intermediate cert is signed by a current endorsed CA.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 crypto/asymmetric_keys/x509_public_key.c | 14 ++++++++++++--
 include/linux/ima.h                      | 11 +++++++++++
 include/linux/key-type.h                 |  1 +
 security/keys/key.c                      |  5 +++++
 4 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric_keys/x509_public_key.c
index fd1d7d6e68e7..75699987a6b1 100644
--- a/crypto/asymmetric_keys/x509_public_key.c
+++ b/crypto/asymmetric_keys/x509_public_key.c
@@ -208,8 +208,18 @@ static int x509_key_preparse(struct key_preparsed_payload *prep)
 		goto error_free_kids;
 	}
 
-	if (cert->kcs_set && cert->root_ca)
-		prep->payload_flags |= KEY_ALLOC_PECA;
+	if (cert->kcs_set) {
+		if (cert->root_ca)
+			prep->payload_flags |= KEY_ALLOC_PECA;
+		/*
+		 * In this case it could be an Intermediate CA.  Set
+		 * KEY_MAYBE_PECA for now.  If the restriction check
+		 * passes later, the key will be allocated with the
+		 * correct CA flag
+		 */
+		else
+			prep->payload_flags |= KEY_MAYBE_PECA;
+	}
 
 	/* We're pinning the module by being linked against it */
 	__module_get(public_key_subtype.owner);
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 81708ca0ebc7..6597081b6b1a 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -12,6 +12,7 @@
 #include <linux/security.h>
 #include <linux/kexec.h>
 #include <crypto/hash_info.h>
+#include <keys/system_keyring.h>
 struct linux_binprm;
 
 #ifdef CONFIG_IMA
@@ -181,6 +182,16 @@ static inline void ima_post_key_create_or_update(struct key *keyring,
 						 bool create) {}
 #endif  /* CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS */
 
+#ifdef CONFIG_ASYMMETRIC_KEY_TYPE
+#ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
+#define ima_validate_builtin_ca restrict_link_by_ca_builtin_and_secondary_trusted
+#else
+#define ima_validate_builtin_ca restrict_link_by_ca_builtin_trusted
+#endif
+#else
+#define ima_validate_builtin_ca restrict_link_reject
+#endif
+
 #ifdef CONFIG_IMA_APPRAISE
 extern bool is_ima_appraise_enabled(void);
 extern void ima_inode_post_setattr(struct user_namespace *mnt_userns,
diff --git a/include/linux/key-type.h b/include/linux/key-type.h
index 0b500578441c..0d2f95f6b8a1 100644
--- a/include/linux/key-type.h
+++ b/include/linux/key-type.h
@@ -38,6 +38,7 @@ struct key_preparsed_payload {
 	time64_t	expiry;		/* Expiry time of key */
 	unsigned int	payload_flags;  /* Proposed payload flags */
 #define KEY_ALLOC_PECA	0x0001		/* Proposed Endorsed CA (ECA) key */
+#define KEY_MAYBE_PECA	0x0002		/* Proposed possible ECA key */
 } __randomize_layout;
 
 typedef int (*request_key_actor_t)(struct key *auth_key, void *aux);
diff --git a/security/keys/key.c b/security/keys/key.c
index e6b4946aca70..69d5f143683f 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -900,6 +900,11 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 		}
 	}
 
+	/* Previous restriction check passed therefore try to validate endorsed ca */
+	if ((prep.payload_flags & KEY_MAYBE_PECA) &&
+	   !(ima_validate_builtin_ca(keyring, index_key.type, &prep.payload, NULL)))
+		prep.payload_flags |= KEY_ALLOC_PECA;
+
 	/* if we're going to allocate a new key, we're going to have
 	 * to modify the keyring */
 	ret = key_permission(keyring_ref, KEY_NEED_WRITE);
-- 
2.27.0

