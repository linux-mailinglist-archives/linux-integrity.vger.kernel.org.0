Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3063E49F8
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Aug 2021 18:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbhHIQcP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Aug 2021 12:32:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:60050 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233075AbhHIQby (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Aug 2021 12:31:54 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179GBWLP004569;
        Mon, 9 Aug 2021 16:31:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=ryFmKdn22aDzTv7hHbtLareszmknkHuvUfAEeNFJAMw=;
 b=txPXFvjDh7zRCncSkmL8Oo68+TnzhdhsBhbQHjWpcLR8XX2L4YnRB+dWCLhjqapcOabA
 nr+1kYrMSyN45mYuLQMWCAjvFDmXphd4nndeUbE5Rk61JkIvqKsbH3gw7NyVEPYtLGfG
 a6wa7/88MKS1or340Ozf/h6qhf+SElC4QGAGlPManXIdBKXS15ri5XsiAUIqF1AH5w9W
 W9D8XOFF0i6zBUy6xgj8b6aKXLe5nj+HtJGZLFXg4+3V0ToREewHMqjd26ZbFMZWdO+b
 ALPQQZXDPlKx7dkNBJkTwWeJDgi/tuugulX19nS/E3crJznFIpNcA37yk0Y6kcitTYvM IA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=ryFmKdn22aDzTv7hHbtLareszmknkHuvUfAEeNFJAMw=;
 b=vRhnzcZfRq1gs45k1roolG7XS1JtaLK0T/8ntLnXGWTH5/bouvXa/CG90fGASm5xh9Fy
 eLTniIjK1oUsnc8J9SDK+NITH5WGMziFV/x/2jHoCzTlIUOhVyk/ifckSeze9aAEpY/l
 UIfMMVwWrbH6Cd2smqr8jAmw4wzbeLtpeK/QvtVBCMj2xgccOqZMTi031rjWNykwXHnO
 7ls1pQ7LVmPflzIBHf2Pdm8HRWZpsj9A1Unph4PKE4in9vRY2j6JZVKh9ScU9BarE4Qd
 M+RuNeQcr/qCQUDgrXnL3lFHbsdfujqvjbTDvd+uGJy//H49kFv8HxigvcOzMI/ycFFw RA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aav18hq60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 16:31:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 179GUa1K066307;
        Mon, 9 Aug 2021 16:31:05 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by aserp3020.oracle.com with ESMTP id 3a9vv385x7-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 16:31:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dH3ZOBgRGh70kd0dUowd8WWWRiuCAd6GwdliN6W9eNOpx+5h+swEv4KtwH77+19K3NyrwEuJ7l7eiNXkLU4QZX4/R7JpH9V4G7P6W1m5wcMfDiWwOg9/XvUoyHT/Ypw51X1MV9UBqZ+nO6R/fO3i2M38l1siXFUDntVXzWXSo9rY7Gzkg8rqcTINXdObNkHxmj5XxnUDPcagMLqmzoP03vmoufTxmrF69Vo1U4VkIw7bdIM1Brx99lPPucXkAnk85e8n1/VEpzzdxpkSeKvskmYUCtC++u0gJZccKI2l8vUuGlEys3bsrcaWRiGkJZFgewjU1LsWX4oIvL1yCkTIuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryFmKdn22aDzTv7hHbtLareszmknkHuvUfAEeNFJAMw=;
 b=cc12kforJWX6FmT/D0FJJdd4DJyBSE71KjOHUjFhrS5scO8xYcYGJdN2uHGpUE94Jl1bINkzLYEW/1NZKV8Yi3Szdg2MBqhvD3IF8mpHUfLYGYKYIum91mErv5o95pIlj1zFaJ8+pjs7Z2vrcmx/emLJ5I/dx9KYsZdw2r0nV1bBCvAVF18MeDil04JCvVJ1s7Cz0SDBILimusOkzCL/YDiJwehS26jswEhI8km79C6jFQYAOwjruJ+IRea54AhDVHYzCqKAtZpO7bUSJyjRtCm22TaQiSK0ec+5oJfaVOxJPCI4nV2XXnPPT2AIF2iBCLvUmxQ3su3eTomrwK07JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryFmKdn22aDzTv7hHbtLareszmknkHuvUfAEeNFJAMw=;
 b=da1HA2DmVFjP+C64Q2OibD1lRbspPDEgAFwwkBflnTas7NfO0q6AvN5BaALe/ZYP4n+7ufr55T6RdeNEn2WEmZHsdgnmH6wA0mkPQxebrIABUt9nm6tbtaZQhk5m7LzK+ZsZjn1fpVM+lbIgl+krZBinw3So29b+keCtM6oO7To=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BYAPR10MB2631.namprd10.prod.outlook.com (2603:10b6:a02:ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Mon, 9 Aug
 2021 16:30:52 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3%4]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 16:30:52 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v3 07/14] x86: Add early SHA support for Secure Launch early measurements
Date:   Mon,  9 Aug 2021 12:38:49 -0400
Message-Id: <1628527136-2478-8-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1628527136-2478-1-git-send-email-ross.philipson@oracle.com>
References: <1628527136-2478-1-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:806:a7::26) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lateralus.us.oracle.com (209.17.40.43) by SA9PR10CA0021.namprd10.prod.outlook.com (2603:10b6:806:a7::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Mon, 9 Aug 2021 16:30:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56356604-02e6-4702-c32f-08d95b530d9f
X-MS-TrafficTypeDiagnostic: BYAPR10MB2631:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB263147148B4977D2489BCA8AE6F69@BYAPR10MB2631.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ynp6sBQGb0dMCygKK+tPf1lNLFX+IFf6M7fjeRCUqJZGB2dzsvuSBLLUrdmxzTkQ0CvgVleejY2c2MJwMnSKAjN31r5lcNv9p6lb6r4pYfItMd/dE7x/3rFpDMXqSyMM70GGnPDTWHiAHI2KA4S0XO3FRglx76wCv5+KB9jJhXvSpJjterDHXaqkEOHsz4gIvPvmuctWDQRjnnH/spV1fa+aK9pmRJ/t6Z/7dE2Spj/kXvJ9MSiGeyrGVrj8PX2MzvkpjhxlONyC5pYGNNvAhlBQsGwoDnpezhSc56egYuSDFum2Chd6climqFMZ08Ch/r7iuYjMyiYrfKfJiWHhTaP6tYlmnb7qUYVszPN4esowRmdcMejdPSQZpRbXz2qdPE4lo9Bz5W5mCStdPzLXBtw7cNF/LMm8xytR2GJ6L7DmQd7KWWRKrztj4arOKZGf5LcMlzavD//dPBjEX8IG6o5ABQcXmO5BtFnGNX3W54PgHDgM4/3jBjjZcho3/cI/rIcVkVebOFHj+UPQf31ZRsBV3qJt2DKpuiWFUsvD62MUkqgyOsE3ybDXidFym8osa0ymtMSCsgrr7bgD+t/WLZWWwatU5fQ+nSBo17vZNzl4ttmAaBD08YNxIZgVsHdfeU7tmOn1jMvKAINjgilF1cfmEK+PNfHavRc8cg4TEY+QhKEig7q2+7idKuIZh+jUT81amzSW6B4mQwENqBx/Gw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(376002)(346002)(366004)(4326008)(7416002)(6486002)(36756003)(8936002)(478600001)(26005)(2906002)(7696005)(52116002)(8676002)(186003)(38350700002)(38100700002)(66556008)(83380400001)(66946007)(5660300002)(956004)(66476007)(2616005)(86362001)(44832011)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?soibW9pqBNdLog1e0RKH92wqKIb3rvxsfaqpC2o0Uvazfl4Qqy2kUD93AyrL?=
 =?us-ascii?Q?SWupM7sWA8lZqHxO1f4OJ98DNP9yw5AZc2BSajy0mwmwBCMTghnnbHSD30rz?=
 =?us-ascii?Q?QXIY2RpRsMk5sxzxjuq8RkJE5W9Z2ai/TEYzjc7GRH8k8JLEqUdMXJ4ispm6?=
 =?us-ascii?Q?CJSjCM6XxwqzFLu/Y2Ov/t0ZUXEnhF19akJTBgq5PvAsFoEzyl5icaJXXQqE?=
 =?us-ascii?Q?crGdHBRd04pQhaeviEasmM0uvDJB841McgW/CYblWLfNf5wP+t4/CsVtqkdc?=
 =?us-ascii?Q?xQkbVA4kirrRB3CPIaws5yE24UbYEYjhIjQhD3+xkeVH0TH3L67rFs4D0luD?=
 =?us-ascii?Q?ZjdsAeFsJ435v/oqG8NzRrd0K9ZIEbt69LOtBC5JdpApHsJdZo9syeXB2Se0?=
 =?us-ascii?Q?xT+SANFzxgQ2tnaJGEeNFVVccSwGfkKpHJIVWpcS4cOsZ8PMd21d+vaBNGJO?=
 =?us-ascii?Q?h2Z58a1JsyIsLUUPvhadPOJoa3shJ3tY5a87OMofBBN1kDO+0Gawpu8+gF6Y?=
 =?us-ascii?Q?HpBBwRHf59oN8sTXtvP9ZgV2uZJ9M9E92lqCxDMIPypTrhMUJaYHK93ulwZf?=
 =?us-ascii?Q?v/mmHIswhWKGyTjCjpgs0Duw3345KH4jstnk3MCdusW+/Qh3kpM9oHBJVwuF?=
 =?us-ascii?Q?lczVWO44NloIIrBYLSw8nLxouEekBGUsSh6ve5wWWkPW91Dr2P2UzH+PWnRs?=
 =?us-ascii?Q?/l7UJrrPdk/OJlqeCgV2oAlPjtnZFapXUcnda0IGzTt5s0OdpUPYRMSNaa3w?=
 =?us-ascii?Q?0liX/O33lIZgbxTipysUErTb990S8QO5qKvpS/zs6paNmNx1dBC/8ZI+kvN1?=
 =?us-ascii?Q?yrEyzlaHQwBmLZW+Ac9EWlcNJAaHmmm8VzR4PRZIdCrNGM0uGM55qfunsFDB?=
 =?us-ascii?Q?NV5T18/DN40cybWT9X++o5t2KoaZJUcrKt5Psk5XOuBaKvwg950ftMJKshw0?=
 =?us-ascii?Q?MLdMpZpplaPSctYU/uLplD7oafh10cpBk1g9DyrnGKLu8fwhf4+8WMs1FPEj?=
 =?us-ascii?Q?XXd7FW2tMJJFGOJ1c1wtXAGwYvyvstVIdm60DgzlBq1RmLT7aH4+bmRlZuiJ?=
 =?us-ascii?Q?hRISEM1Rb+bqrGtl184FWSOIp1JvTuB4iSNgYn5ep5KUkoDCRbHA7XUSqsEq?=
 =?us-ascii?Q?3lIkK8lQmiNxhefgZLOwUr15WCTwPkZySx4FsyQoJU+fE6cXgn51H3Y1PCsR?=
 =?us-ascii?Q?aTPVOP+4K3v5goojaskWPEp7Sjk0/aDkPuUCnf8+57KrAAZgJjUNYgZ4m04z?=
 =?us-ascii?Q?DOBVavfoQAqOK1jRbxVP4ShB1Wrb5PLPJFjuD6p5WAO+loOtzegX4eTWnils?=
 =?us-ascii?Q?pypEIJsNCHdvA2KfzUGw/nse?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56356604-02e6-4702-c32f-08d95b530d9f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 16:30:52.1371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+MpN5eEm5dFQkwijvlJtpP4CLZSSLcRacf3kDO2JO6sgUwS+d8nUC/LzAfqVUmSGse/yr48XAl5fqIWEM8JYGiLbBW5QHcQVpQMMNeMq24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2631
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10071 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108090119
X-Proofpoint-ORIG-GUID: 9zHnqkVUWrwGBIMk52sEBwA8i5X8GSI4
X-Proofpoint-GUID: 9zHnqkVUWrwGBIMk52sEBwA8i5X8GSI4
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: "Daniel P. Smith" <dpsmith@apertussolutions.com>

The SHA algorithms are necessary to measure configuration information into
the TPM as early as possible before using the values. This implementation
uses the established approach of #including the SHA libraries directly in
the code since the compressed kernel is not uncompressed at this point.

The SHA code here has its origins in the code from the main kernel, commit
c4d5b9ffa31f (crypto: sha1 - implement base layer for SHA-1). That code could
not be pulled directly into the setup portion of the compressed kernel because
of other dependencies it pulls in. The result is this is a modified copy of
that code that still leverages the core SHA algorithms.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/boot/compressed/Makefile       |   2 +
 arch/x86/boot/compressed/early_sha1.c   | 103 ++++++++++++++++++++++++++++++++
 arch/x86/boot/compressed/early_sha1.h   |  17 ++++++
 arch/x86/boot/compressed/early_sha256.c |   7 +++
 lib/crypto/sha256.c                     |   8 +++
 lib/sha1.c                              |   4 ++
 6 files changed, 141 insertions(+)
 create mode 100644 arch/x86/boot/compressed/early_sha1.c
 create mode 100644 arch/x86/boot/compressed/early_sha1.h
 create mode 100644 arch/x86/boot/compressed/early_sha256.c

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 431bf7f..059d49a 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -102,6 +102,8 @@ vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
 efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
 
+vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/early_sha1.o $(obj)/early_sha256.o
+
 $(obj)/vmlinux: $(vmlinux-objs-y) $(efi-obj-y) FORCE
 	$(call if_changed,ld)
 
diff --git a/arch/x86/boot/compressed/early_sha1.c b/arch/x86/boot/compressed/early_sha1.c
new file mode 100644
index 0000000..74f4654
--- /dev/null
+++ b/arch/x86/boot/compressed/early_sha1.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 Apertus Solutions, LLC.
+ */
+
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <linux/string.h>
+#include <asm/boot.h>
+#include <asm/unaligned.h>
+
+#include "early_sha1.h"
+
+#define SHA1_DISABLE_EXPORT
+#include "../../../../lib/sha1.c"
+
+/* The SHA1 implementation in lib/sha1.c was written to get the workspace
+ * buffer as a parameter. This wrapper function provides a container
+ * around a temporary workspace that is cleared after the transform completes.
+ */
+static void __sha_transform(u32 *digest, const char *data)
+{
+	u32 ws[SHA1_WORKSPACE_WORDS];
+
+	sha1_transform(digest, data, ws);
+
+	memset(ws, 0, sizeof(ws));
+	/*
+	 * As this is cryptographic code, prevent the memset 0 from being
+	 * optimized out potentially leaving secrets in memory.
+	 */
+	wmb();
+
+}
+
+void early_sha1_init(struct sha1_state *sctx)
+{
+	sha1_init(sctx->state);
+	sctx->count = 0;
+}
+
+void early_sha1_update(struct sha1_state *sctx,
+		       const u8 *data,
+		       unsigned int len)
+{
+	unsigned int partial = sctx->count % SHA1_BLOCK_SIZE;
+
+	sctx->count += len;
+
+	if (likely((partial + len) >= SHA1_BLOCK_SIZE)) {
+		int blocks;
+
+		if (partial) {
+			int p = SHA1_BLOCK_SIZE - partial;
+
+			memcpy(sctx->buffer + partial, data, p);
+			data += p;
+			len -= p;
+
+			__sha_transform(sctx->state, sctx->buffer);
+		}
+
+		blocks = len / SHA1_BLOCK_SIZE;
+		len %= SHA1_BLOCK_SIZE;
+
+		if (blocks) {
+			while (blocks--) {
+				__sha_transform(sctx->state, data);
+				data += SHA1_BLOCK_SIZE;
+			}
+		}
+		partial = 0;
+	}
+
+	if (len)
+		memcpy(sctx->buffer + partial, data, len);
+}
+
+void early_sha1_final(struct sha1_state *sctx, u8 *out)
+{
+	const int bit_offset = SHA1_BLOCK_SIZE - sizeof(__be64);
+	__be64 *bits = (__be64 *)(sctx->buffer + bit_offset);
+	__be32 *digest = (__be32 *)out;
+	unsigned int partial = sctx->count % SHA1_BLOCK_SIZE;
+	int i;
+
+	sctx->buffer[partial++] = 0x80;
+	if (partial > bit_offset) {
+		memset(sctx->buffer + partial, 0x0, SHA1_BLOCK_SIZE - partial);
+		partial = 0;
+
+		__sha_transform(sctx->state, sctx->buffer);
+	}
+
+	memset(sctx->buffer + partial, 0x0, bit_offset - partial);
+	*bits = cpu_to_be64(sctx->count << 3);
+	__sha_transform(sctx->state, sctx->buffer);
+
+	for (i = 0; i < SHA1_DIGEST_SIZE / sizeof(__be32); i++)
+		put_unaligned_be32(sctx->state[i], digest++);
+
+	*sctx = (struct sha1_state){};
+}
diff --git a/arch/x86/boot/compressed/early_sha1.h b/arch/x86/boot/compressed/early_sha1.h
new file mode 100644
index 0000000..6584ea5
--- /dev/null
+++ b/arch/x86/boot/compressed/early_sha1.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 Apertus Solutions, LLC
+ */
+
+#ifndef BOOT_COMPRESSED_EARLY_SHA1_H
+#define BOOT_COMPRESSED_EARLY_SHA1_H
+
+#include <crypto/sha1.h>
+
+void early_sha1_init(struct sha1_state *sctx);
+void early_sha1_update(struct sha1_state *sctx,
+		       const u8 *data,
+		       unsigned int len);
+void early_sha1_final(struct sha1_state *sctx, u8 *out);
+
+#endif /* BOOT_COMPRESSED_EARLY_SHA1_H */
diff --git a/arch/x86/boot/compressed/early_sha256.c b/arch/x86/boot/compressed/early_sha256.c
new file mode 100644
index 0000000..db8d784
--- /dev/null
+++ b/arch/x86/boot/compressed/early_sha256.c
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 Apertus Solutions, LLC
+ */
+
+#define SHA256_DISABLE_EXPORT
+#include "../../../../lib/crypto/sha256.c"
diff --git a/lib/crypto/sha256.c b/lib/crypto/sha256.c
index 72a4b0b..e532220 100644
--- a/lib/crypto/sha256.c
+++ b/lib/crypto/sha256.c
@@ -149,13 +149,17 @@ void sha256_update(struct sha256_state *sctx, const u8 *data, unsigned int len)
 	}
 	memcpy(sctx->buf + partial, src, len - done);
 }
+#ifndef SHA256_DISABLE_EXPORT
 EXPORT_SYMBOL(sha256_update);
+#endif
 
 void sha224_update(struct sha256_state *sctx, const u8 *data, unsigned int len)
 {
 	sha256_update(sctx, data, len);
 }
+#ifndef SHA256_DISABLE_EXPORT
 EXPORT_SYMBOL(sha224_update);
+#endif
 
 static void __sha256_final(struct sha256_state *sctx, u8 *out, int digest_words)
 {
@@ -188,13 +192,17 @@ void sha256_final(struct sha256_state *sctx, u8 *out)
 {
 	__sha256_final(sctx, out, 8);
 }
+#ifndef SHA256_DISABLE_EXPORT
 EXPORT_SYMBOL(sha256_final);
+#endif
 
 void sha224_final(struct sha256_state *sctx, u8 *out)
 {
 	__sha256_final(sctx, out, 7);
 }
+#ifndef SHA256_DISABLE_EXPORT
 EXPORT_SYMBOL(sha224_final);
+#endif
 
 void sha256(const u8 *data, unsigned int len, u8 *out)
 {
diff --git a/lib/sha1.c b/lib/sha1.c
index 9bd1935..0598efd 100644
--- a/lib/sha1.c
+++ b/lib/sha1.c
@@ -187,7 +187,9 @@ void sha1_transform(__u32 *digest, const char *data, __u32 *array)
 	digest[3] += D;
 	digest[4] += E;
 }
+#ifndef SHA1_DISABLE_EXPORT
 EXPORT_SYMBOL(sha1_transform);
+#endif
 
 /**
  * sha1_init - initialize the vectors for a SHA1 digest
@@ -201,4 +203,6 @@ void sha1_init(__u32 *buf)
 	buf[3] = 0x10325476;
 	buf[4] = 0xc3d2e1f0;
 }
+#ifndef SHA1_DISABLE_EXPORT
 EXPORT_SYMBOL(sha1_init);
+#endif
-- 
1.8.3.1

