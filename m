Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAE03F997D
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Aug 2021 15:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245192AbhH0NWI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 Aug 2021 09:22:08 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:28174 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245153AbhH0NWB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Aug 2021 09:22:01 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17RA8dsT025578;
        Fri, 27 Aug 2021 13:20:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=ryFmKdn22aDzTv7hHbtLareszmknkHuvUfAEeNFJAMw=;
 b=xhFGcUFwrN6ewYsW+QVqZkNY5IF/4glpZhjosMVPbcsMI8MqmBPDxb270ptCxpL/SOid
 ntKLisXwmvqVB63nmDsIV+scIovW0Cm4YNIAobJuR4pJ4bCxNI+d3/wIdPZzNpAmhRwx
 PK5bdpurOFIdo2Yv8pnL4QxtoPHDj3S9O7+2Q5izKliJQht/6qy0lO2iEqmfKDP7JN1/
 VJ5Nalir5pMPxbXopbuOc8O62oOnN/D4WgaMYCItIr0wHo2e2G9VHzjxETuX44S00wLx
 MWwR3/Fm/1xNYS4Zha8gFmYFapYrQF36a7VXPvbDf8kMeoyqrIKD2iUJ5GnhWvdj8rfk fA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=ryFmKdn22aDzTv7hHbtLareszmknkHuvUfAEeNFJAMw=;
 b=PmXxhYdf8zaVv19lqdt8YZ4rtP4jiF3HCmQ8PWiHCtsYwqF1nOwIGDkbX997HwUGmPA1
 YMlXZBN3DzNyBo/TIRXSCh9IhYZ9I6emDJ9BWVDKfIa7Mi0qzZcX5wJ8+MJ7+pnRa5o0
 4q8x+ZJAhqXaZXrriVU2mRIQ/UyedACI94lYpCM4kzGMXBT4cOYsqPt62GxEvAQcwsKI
 sJCCp4gct590jlUE9Jw/oK7OFDcI8C4jyDCAISyyoiLvbup7J3xO6y+4xg2k1+oAccV3
 I87krG8nU9QSSdJ1FiqnWecAis2FUUhjKQMVIzJ8vOHBLwFuHpwyQFjcvJAPeTtAGJJj dA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ap3eauqkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 13:20:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17RD9oud076983;
        Fri, 27 Aug 2021 13:20:50 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2041.outbound.protection.outlook.com [104.47.51.41])
        by userp3030.oracle.com with ESMTP id 3ajpm4pqa4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 13:20:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYyHW2sSW+E5Ziwy3YazlnLm97s8vIFRi0KoTenxUEBJb26ZtzscVi/ozbUbuH6kJMN9hg/jTkdX2ejY8PmChnK6SjfqAHhEZAbBNxHTews5317OYJI13008iQqnP9FIB3ZudtjYfXsE/WIwk7xq7Nq1o3UHWLDy9DUGZi2mUkaIQWYFJPMnLrxIBHa2UwK6AL9TNyKIeWHduTpqBPp5ZqX5Bh4Kmzf9B69x42kwbaz5mFBTDUT0B1Zveqhg0FyE9ZLKd/Nnwp7fjn47nvSIMje0Ik4gcIh8MS5lmE4xCrRDAGVqCvUYPyO3L0cLxKM5u/AwC8xwWRd+od8y/VpArw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryFmKdn22aDzTv7hHbtLareszmknkHuvUfAEeNFJAMw=;
 b=cYliL/fJqjRaRxJap9LryXh5hs0BRiwUsdjFShFWrbyLhM6mHUtLiukNATIoU1X62fdsPMlFvdmULkjoRsukA95vDuFNFq54dYLOX5yF+0c/oRq90kGt7PcF+4/B582q2wUHc2t6mqjCdVPKJCjDtuJovnPODlEvbbEh3RhAffAQP9CD8MTSNufUXoZzS60Jh0eP5XjohOdzUCuhd7Kjhj+8UHbjNJ5rXwdExvsxuf6rZPE+q0xOsfvFLHqysBxPamERa8T5Q3KfOEkt5mLNW0eZvMzo16SPPWe3K20PbhakEo4ach+Yqybx9CqoxJHMgoNvUEAB7PEXkd0yvNUxmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryFmKdn22aDzTv7hHbtLareszmknkHuvUfAEeNFJAMw=;
 b=Ezf/KzfqMzdeT1qfRW1jYm9WGpzRh5fzlEzL4aBg1ahcsmBAkOKOOf2wW5Nn6hYqw7G7Yvlb1b4o77eU+M83hfXaGTdHsqhXgkojE46+NXDJIPogsA7KbsUavNm4FBhKKA0GkEVTKSWISow59OCnkVKt1oMplJzbXnVv/PHkb1k=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BYAPR10MB3237.namprd10.prod.outlook.com (2603:10b6:a03:153::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.23; Fri, 27 Aug
 2021 13:20:48 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3%4]) with mapi id 15.20.4457.020; Fri, 27 Aug 2021
 13:20:48 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v4 07/14] x86: Add early SHA support for Secure Launch early measurements
Date:   Fri, 27 Aug 2021 09:28:30 -0400
Message-Id: <1630070917-9896-8-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
References: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:805:de::24) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lateralus.us.oracle.com (209.17.40.45) by SN6PR05CA0011.namprd05.prod.outlook.com (2603:10b6:805:de::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.8 via Frontend Transport; Fri, 27 Aug 2021 13:20:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e33f5f5c-bda8-41a8-b75c-08d9695d7c24
X-MS-TrafficTypeDiagnostic: BYAPR10MB3237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB323743A22630132F0D84B168E6C89@BYAPR10MB3237.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O2MTsUjJtFIjmgJ/884LO9SCXZvBoDSOT/+1b5O/kUwQQJ5IudOVtzVdQqvhYj8KFDsJnUC1JgsaHNAXticBoZz5AL58cUp+xM4ZrxQ5xAgJ2NrIZ/TFrBl62cBtSwSfDZYQmy8CwdSy8JJZox0Uyw0fIrcelXmrkrP2CjB4U9D2X+5VUAyWM3KF4IdniHsK/vxKpVovGeieVhlYC4AC1FyHnX/JDuEP1txLeDft7x41BiMC73vNabQ1gMih+2Cvv/09WEHtW0F5jHs2UUVAM1Q4E5PVL/HZOna+iyuI2OWQmLn6UnZCD7x780DYBjf2uTdd+4qZQm8O/PTKHW7Ae1brerU1yds9KLGiaP51eLYsbMdOxXc10c3KZVOBdBhDaItOKHatpTNKcJ9948j81U8+ZydeGM2Cfpvqb4PsbprHlHV5O2/RvcwQBmbgnIqRDa3tvtZdqAd8IKZMPHESkU367l9T5SHWvK5WJxmxHRultN79Ht1FplPb/7W0belUdTR1KQLNXyzlE8+BRTOnhNwnY6DR+y+Px1l8almGQoQagBtp9oC9O7eotGtv5A5WflywVKziEXq4AlkaVmbcwiY0k7TCq3BrNQMV8CsjpCrutwK5B3vFUQNlZM4+dB781MumWSnJfhPq5dOO8uXQSLjRf2F+xeVAl+/7TrB3n8dxVlwu6NGOZp3c5zoLeuxSa3sjmlZzFoN+9liI6w850A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(346002)(376002)(396003)(956004)(44832011)(2616005)(2906002)(52116002)(26005)(7696005)(478600001)(38350700002)(38100700002)(6486002)(36756003)(186003)(83380400001)(6666004)(86362001)(8936002)(8676002)(316002)(66946007)(66556008)(4326008)(66476007)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rh1DckNapPGX41PPTfvPTQbt2zD4a/ohioOziajk4T6rutPWKK6s+/BOicCp?=
 =?us-ascii?Q?dWoSTkcGnXlIgjk+DL20P6iRJt4m+KUCXdFIr+wucSgXxqRrnNVVs+moWtT9?=
 =?us-ascii?Q?G0rHLSAWxY4PnWf9uQUZPAt4E3gD7hTbGIUCi0+LCfChT1DpZeUPBG1WqgQH?=
 =?us-ascii?Q?qzK5cSVaUi40PYaXNaG0wsMlgeE23g95duYvcVv/dVf8Op25a9qIHBjv4UGz?=
 =?us-ascii?Q?v5E9BklbMvV3Xu2gg6WgmOeVwFYrfGyIXv3C+pqosaV0ZoermCaaJFWTPbVV?=
 =?us-ascii?Q?hUKY964g5uSGiCLyNlGZHWTx/mSG8I5bHWau4yjNRV8mqIZAau5pRN+yYnzd?=
 =?us-ascii?Q?T02pNsntTM4iNhWjO4rQyxT7vqM0HcoFWZe9u7YhLnOqgFo2S/qBqgs44rCA?=
 =?us-ascii?Q?GPClZ9cJAnhZ6IZZLB0VKX5uTyt04GAr36A7pP6UXaNNeyOzYcxUKRGz66CV?=
 =?us-ascii?Q?Mz5/NzMwWxcbhbmHiJhknc8Qgq9Emlsc60aUHq7SN6fswFwik7CFUaUfAWd1?=
 =?us-ascii?Q?lKHlhXmizTVRpWreH1w5jH5T61mhD3rWqwRU2tly/vVD536mjJC8GJD0wMag?=
 =?us-ascii?Q?vVXV+QUIqYd/C4vawsdtMbWOG+0k8Ig9Fn9CHnVXrXJwKx7zWGg4tbG55fI0?=
 =?us-ascii?Q?gu7ws4djtK8/mlG7nmx0l8eD1ulrXpVQVIOKA5/M0HrjufOStGo6OoCc3Laf?=
 =?us-ascii?Q?NI8IKHLtT3GiqHNSJpQOfqT84ZO6wHKJjIbXnowAOnKmVgbrao3iyrzUs9a9?=
 =?us-ascii?Q?N6oHrBZTqaaESmJGLGBsCLab995j9ZPe+/DUs0y/lt7cmD7fFgpJj2M5Cc/G?=
 =?us-ascii?Q?tmiOn93BsDedq5BkBufNRSrZXMUyicToL6Nf7yMrnzjxE/0PdrcT8nwuFE+y?=
 =?us-ascii?Q?vQPnBGFC3AIoDQ6sPDwONpSAhbYVWJ2v1JF4dT5heU5sF5QrDgl/RRsJNU95?=
 =?us-ascii?Q?jWUf16U8gNl7zmC3ob1uvDJrr+Bc5ZTOHbnzceiTuVYo3ZnJepe/Qes8oqnu?=
 =?us-ascii?Q?w63vLhuFNLU8mVQAna3aVkg9YAuPW7AmwmX6UceZWDoO72hHIMqkpeBGIafB?=
 =?us-ascii?Q?nyeU7VVeCb+NTD11vwmxBt99SqQZ4T3kxB5QuWjXCmp4qwBQKkYVmFWXcYw/?=
 =?us-ascii?Q?gHyf2LoGKZpjq8jU0MAQoq9xA7n9nt2tGGmKrd/Mlr0VgQ+v5Z69O1ClPGPM?=
 =?us-ascii?Q?d0kdOUbQhIPifouQVtiqZzZKGa2XMabaURCs9l9rOG89vOEzR9LpiXFCvq8v?=
 =?us-ascii?Q?okZhI6dQj5359EouSGR/FB0RW4EFfJKQPJObPCp0ZkcYkcinyqIJnlBj7qBF?=
 =?us-ascii?Q?MEe/AP+dxHZQxHndM6rn3Bl4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e33f5f5c-bda8-41a8-b75c-08d9695d7c24
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 13:20:48.6591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8sx5g9P6PNdyI77w9Pl9xvuC9v5z9gxCa7gVHMk3MDltm5MjHFn1PFc0C3qKW8tMm3QntTG3gd4J03t4pwyF5Gfmls7kEN+Aq53JZfKt0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3237
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10088 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108270086
X-Proofpoint-ORIG-GUID: 2miuq_qZC1s68I_qsjvuqUng2blpsPLM
X-Proofpoint-GUID: 2miuq_qZC1s68I_qsjvuqUng2blpsPLM
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

