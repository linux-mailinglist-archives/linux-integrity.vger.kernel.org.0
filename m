Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62193BE0FC
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jul 2021 04:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhGGCrz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jul 2021 22:47:55 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:60548 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230015AbhGGCrx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jul 2021 22:47:53 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1672aAW3017217;
        Wed, 7 Jul 2021 02:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=+nPl48nlWnXHpdaxRKVuTTPNiBsbRpR28wSSqdusiRA=;
 b=U79iRAYrgKecSWaEB6kegkBLMlP9EGx9ZE2N8jznrJY+1GeAHbJR5fHnVYQQhavY900o
 elWJM7OFsaYNMwue5zYJ1YnVtsbNTlMjPhJu2ixj9GDZ97zlrX9bgyVEnf7vmSF+N2io
 SAA79O4DQ6xYluJ8oa0TQy4dzxyq+zP0yaOv0SFriVaAwX2HiWGUDNOlSme5b7DAi9cJ
 RD6VsMTDOrvZOCGV9g/CZVMSKw6EpX6VNrRjnTtGot32wY+SMtOdvXIhYoWHHgRqdhWM
 3skEkUuZQ3byH0vr00T7ZgAZKTnASU4Y6ytrfNsov/Ko61Z/q/Y7iomQIp38SxYqUGJn Hw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39kq8ec4yq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 02:44:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1672aTlK070901;
        Wed, 7 Jul 2021 02:44:37 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2168.outbound.protection.outlook.com [104.47.73.168])
        by userp3020.oracle.com with ESMTP id 39k1nw7pxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 02:44:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPA8w+5st964rjIW7AgqQ7YR8P6xig4cBYOYemGJQyJX8BaCe+Gvf4gs+tDoUlxknDg2xUw1Lev3k5+965nVHLS0AjgY+Q4a7040xgFHESBpwwq1oty0TYbu4EHfNWaAxuI6B6tOeM+29je5xkXRojaoGJQmyRlnb56Tb8RPgfJvaHvs+bzcMBFyOP+Ef4prpKhgH5fEbu9HhkGuwcbQCDrOMZkWfL3YW9uEGOwJlBzXL3ah1Of2GItss9dsl1EbG7iH7XNpbz4myybQ6MkNRM36BHb7khZuq3YuTbyCLGKnm5UhG2OJqGHfnOayOVs5vNsMSGKTIt88Y7g53qgUTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nPl48nlWnXHpdaxRKVuTTPNiBsbRpR28wSSqdusiRA=;
 b=NsLz9R18zNLUihxUVs6ITwhrZA5es1YFgf5rj0/w/7uYmFEnlN/LqRqqO3hw3B+br3udjG72XMrxipSsZgs8TxmrPEazr0CA0GpNCxvTTvxmCKBNnF4ATvePHS3gyUEfgoO7LJoGFk96j5pTboo4iUC2/j4RciUsQjFRPLo/6LLy+lNK/dO2a44aDvZvz6xkRIej9E45WfuSIzDIyeTVgacXOWVKPvDUQ6XlqZOEjjHJtynlly3S4WmzatAW4ImND+EAf+9dwMjFow97xpcCxdr2wXLpVnrJNK6bhssnoehOO0f6lJt7p1qByw7FGz3MtO6WDUAlC8f+tx072EpSdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nPl48nlWnXHpdaxRKVuTTPNiBsbRpR28wSSqdusiRA=;
 b=st67fMjah++GFdaVVqpDncnckqJkvmiLUxJG9n4iI9fMKK1ikkdYPHpul+QcboT5md/dQAMNqXjFsJHZnBL9ewmYWBG9f9PNEk63syzKefyIbybu8hMHMqdKUZ3b2k9HrcQlGR3a8Dp0K7gpxzSbZCr/vhHO9/8+c33l95+pCPs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3863.namprd10.prod.outlook.com (2603:10b6:610:c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.24; Wed, 7 Jul
 2021 02:44:35 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197%8]) with mapi id 15.20.4287.027; Wed, 7 Jul 2021
 02:44:34 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        zohar@linux.ibm.com, dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko@kernel.org, jmorris@namei.org, serge@hallyn.com
Cc:     eric.snowberg@oracle.com, keescook@chromium.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        scott.branden@broadcom.com, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        glin@suse.com, konrad.wilk@oracle.com
Subject: [PATCH RFC 05/12] integrity: Introduce mok keyring
Date:   Tue,  6 Jul 2021 22:43:56 -0400
Message-Id: <20210707024403.1083977-6-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210707024403.1083977-1-eric.snowberg@oracle.com>
References: <20210707024403.1083977-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::10) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.5) by SJ0PR03CA0245.namprd03.prod.outlook.com (2603:10b6:a03:3a0::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 02:44:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3942b30d-6347-4d3f-2bae-08d940f127a6
X-MS-TrafficTypeDiagnostic: CH2PR10MB3863:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB3863F7D623E993919A1FD305871A9@CH2PR10MB3863.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Sfx/w0LBKbMcJLgSDsuMKYQ+2HKedRF6T6JxYl9tGZ3Fn2RWmk+udHu7qco638lrPy1QVfK2i19hfYoClxC7GX8GgKJX7fC8fHd2wwnpSW+e1Q0JlPPcvhk+CGnC8Gulwwbh2FULYHH8GmIpHZzrDv77vbyOhuj439cI78bxUts3/UTUociF6RHbcmeF7awiBpxvAvjQoC3oqUO8bVkCoRFAMrLfbA8PB9Xls4r9YtejEX8XdEKL4aqGtZwaDLo9nzJflIgpZXXWINGLL5A81WuFOdh1jmUemShFfAyhzCVprmLKXQEcOJQteCat7PBZvzJ9DvjwIFh3BLxKb0Zc5BYO3N3AgsRPE/8iSRyuQjiaDM+Ra7AuqjcNK7m1o3KkahRYLQHTVuUXIUO938Aw+//J2hj6lgx2ESjgLCqjTt7FMXl8XeSzwFmrMmX+e0/92vlLRf9oZ2QCPUjnYZ8fJVmsulyAqe3hZl6aQAyE/BO9YSgl5clx3HVchi6bg7GGZA7C/RctqwfSt2qr4ia1MrCJc94PyWHD+2kCcJpeEKc3eHpcT7PfMr6XNbw4ZwSO7ToVmRRDXpe5ZhxBiovJUsI9let/PO4hG6WiME+B0WJBOOCXcoK3uePHR0PN0BIDTiMWupetfZacEdYlXZeFapSYFYnujLZddNaQ0kP5wLXjLLC/rbFQSGPM/7JoBxYlPsDIduvPjmf1mAym+BEfUgErMu4Cu6jwiychocbrvM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(346002)(396003)(376002)(921005)(107886003)(6486002)(7696005)(316002)(66946007)(1076003)(44832011)(86362001)(38350700002)(6666004)(36756003)(83380400001)(186003)(4326008)(956004)(26005)(7416002)(8676002)(52116002)(2906002)(38100700002)(2616005)(8936002)(66476007)(5660300002)(478600001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DqTthVWiL3GOa5qBX1Bzs2mEdg95pr4KD2HH6Nr4fWn4PfdCL6yibwF8kebG?=
 =?us-ascii?Q?fSuEQZ51sk0zd2jURtQ0XqmiX/iHxm1AoDrwFUIQPU/Jpb8b529CQzGAchwu?=
 =?us-ascii?Q?VA4Z5hBhiTEhv6Ct9ZugjLLRsr/mlWHA8FLLfgtliFtWVRHKvd7KVxWej4lt?=
 =?us-ascii?Q?4UoadUp8YWV0FprLS3SlFjhUCdinAMutohDbJ5OOGgGoR9sBMN6AOYc4pGiI?=
 =?us-ascii?Q?AcmoBNn+OT2x6X0Dict4hPt9WvHg/qPfpnTSmgSfbe6NUe6O53tWJR6crwMT?=
 =?us-ascii?Q?R07hYxfUGigjPGY2TLxOsdY4GEqa5O1TClqLbrAeVJleVigbGkp/Y2NJyI9W?=
 =?us-ascii?Q?5fiMCtGt9rrlF1pOP9/kURJ29ZVWxaXvCruriJwXlo0ocpYuztM/hZqqdWHz?=
 =?us-ascii?Q?7towl304pxuJB7y3A7cI1SsX1n0OePSb5YaBVqIH7yQop5MZH4jdAE0OdLdb?=
 =?us-ascii?Q?afse4fZIowo8GhCLAOm+oI5TqwMUgXRgFhwCMNPO3rBqHVRQqljw8zAl+GWJ?=
 =?us-ascii?Q?3r0obNU4pvvgWHmjqBdmKkBOunTmSIWWpclidZtWzZb31O2B712WHv7I4NKB?=
 =?us-ascii?Q?QFkM5o4UAE7rGn+HyHIkqgKeLtQ3/eY4wGgsEKkZh/y1MQiUYdpevfxw1RXd?=
 =?us-ascii?Q?gNgsGXJ7rcdd4vjvQADhI6Dtk2dPrbR3zOCzgX9XVoJuJwzFNZrZZGxJ0vQu?=
 =?us-ascii?Q?sVvw5H0/0ZTxtb/1l7You7tu6xiwFGC7YFZJIBkqTwTv7cvv5iEYTwISRLAU?=
 =?us-ascii?Q?3davphE8F1MGJRVRdRTlcD9oJ27pzfLmraEyls9YcM0TLwxA3NQlReIxrFUE?=
 =?us-ascii?Q?qkeb/9BKnanCh9E9EnazNfEHo0/oO6aOgsHdBm72IMHiakYcqtc+JNNFZZYd?=
 =?us-ascii?Q?eoTxvvu6fgOZvXTqwyGDNUHgPZIy3EqxipxkiMoSSHAiTag4bobnEQRxONHG?=
 =?us-ascii?Q?jszhMsAhdVX7aQ5oT606HoasGvcTs+TghBxiPay0ctarAhu/OW1Ckg3B122H?=
 =?us-ascii?Q?UEiaUBVD9aOTmShuY1X9yRh7fqsikPNd7t09pPIojQCfyjIqhxecDt6MPcqV?=
 =?us-ascii?Q?LYiHMUSLY1TVZdJb80EYrNxxKkVQ0aJ+UEI0DU1dZQk7yI4aVgNqdSSWRQDz?=
 =?us-ascii?Q?M3GGpkB8n4gkiHSStijn+dLAcopKZ++6T5ltvKLO8FRG/QU1OV9/aaA8C50S?=
 =?us-ascii?Q?pSGI3VpyC+juf+3NvixrKi1jOpA3HINZetIMupOuzo7bc2soNIaGYgSEhVDR?=
 =?us-ascii?Q?Iad+7AsHNILt24Ue32bgKqbmm8H2iSc7lqvGGrGDRNhoHmq2c4yJKyDgyfqK?=
 =?us-ascii?Q?vKA26PjnQDho524aKHdun8az?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3942b30d-6347-4d3f-2bae-08d940f127a6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 02:44:34.8064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uePlM1zyZWYx3k2aIAYfnxxdvo07i7QM2KRSMrJEYzIpgN4ei2B61uJzC2tyJWB8GOR3oIMfXPtQt6R2hyjOnMt87rRA1+jyXaMaU8RrQhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3863
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10037 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107070012
X-Proofpoint-GUID: VCpXr_neGmwqRLQc2TUPzYDlEhuyMTZy
X-Proofpoint-ORIG-GUID: VCpXr_neGmwqRLQc2TUPzYDlEhuyMTZy
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Introduce a new keyring called mok.  This keyring will be used during
boot. Afterwards it will be destroyed.

Follow on patches will use this keyring to load trusted MOK keys.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 security/integrity/Makefile                   |  3 ++-
 security/integrity/digsig.c                   |  1 +
 security/integrity/integrity.h                |  7 ++++-
 security/integrity/platform_certs/load_uefi.c |  1 +
 .../integrity/platform_certs/mok_keyring.c    | 26 +++++++++++++++++++
 5 files changed, 36 insertions(+), 2 deletions(-)
 create mode 100644 security/integrity/platform_certs/mok_keyring.c

diff --git a/security/integrity/Makefile b/security/integrity/Makefile
index 7ee39d66cf16..8e2e98cba1f6 100644
--- a/security/integrity/Makefile
+++ b/security/integrity/Makefile
@@ -9,7 +9,8 @@ integrity-y := iint.o
 integrity-$(CONFIG_INTEGRITY_AUDIT) += integrity_audit.o
 integrity-$(CONFIG_INTEGRITY_SIGNATURE) += digsig.o
 integrity-$(CONFIG_INTEGRITY_ASYMMETRIC_KEYS) += digsig_asymmetric.o
-integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) += platform_certs/platform_keyring.o
+integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) += platform_certs/platform_keyring.o \
+						  platform_certs/mok_keyring.o
 integrity-$(CONFIG_LOAD_UEFI_KEYS) += platform_certs/efi_parser.o \
 				      platform_certs/load_uefi.o \
 				      platform_certs/keyring_handler.o
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index a8436c6b93ec..56800a5f1e10 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -30,6 +30,7 @@ static const char * const keyring_name[INTEGRITY_KEYRING_MAX] = {
 	".ima",
 #endif
 	".platform",
+	".mok",
 };
 
 #ifdef CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index f801b2076f01..5126c80bd0d4 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -151,7 +151,8 @@ int integrity_kernel_read(struct file *file, loff_t offset,
 #define INTEGRITY_KEYRING_EVM		0
 #define INTEGRITY_KEYRING_IMA		1
 #define INTEGRITY_KEYRING_PLATFORM	2
-#define INTEGRITY_KEYRING_MAX		3
+#define INTEGRITY_KEYRING_MOK		3
+#define INTEGRITY_KEYRING_MAX		4
 
 extern struct dentry *integrity_dir;
 
@@ -282,9 +283,13 @@ integrity_audit_log_start(struct audit_context *ctx, gfp_t gfp_mask, int type)
 #ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
 void __init add_to_platform_keyring(const char *source, const void *data,
 				    size_t len);
+void __init destroy_mok_keyring(void);
 #else
 static inline void __init add_to_platform_keyring(const char *source,
 						  const void *data, size_t len)
 {
 }
+static inline void __init destroy_mok_keyring(void)
+{
+}
 #endif
diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index f290f78c3f30..94faa4b32441 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -193,6 +193,7 @@ static int __init load_uefi_certs(void)
 
 	/* Load the MokListRT certs */
 	rc = load_moklist_certs();
+	destroy_mok_keyring();
 
 	return rc;
 }
diff --git a/security/integrity/platform_certs/mok_keyring.c b/security/integrity/platform_certs/mok_keyring.c
new file mode 100644
index 000000000000..2b0d17caf8fd
--- /dev/null
+++ b/security/integrity/platform_certs/mok_keyring.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MOK keyring routines.
+ *
+ * Copyright (c) 2021, Oracle and/or its affiliates.
+ */
+
+#include "../integrity.h"
+
+static __init int mok_keyring_init(void)
+{
+	int rc;
+
+	rc = integrity_init_keyring(INTEGRITY_KEYRING_MOK);
+	if (rc)
+		return rc;
+
+	pr_notice("MOK Keyring initialized\n");
+	return 0;
+}
+device_initcall(mok_keyring_init);
+
+void __init destroy_mok_keyring(void)
+{
+	return integrity_destroy_keyring(INTEGRITY_KEYRING_MOK);
+}
-- 
2.18.4

