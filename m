Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAEE3F99C9
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Aug 2021 15:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245280AbhH0NWT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 Aug 2021 09:22:19 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:31276 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245212AbhH0NWF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Aug 2021 09:22:05 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17RA7sZ1024207;
        Fri, 27 Aug 2021 13:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=i4xQmbvI4G/h2NIs8DYNtjtoMidMR3X2fKkOhOoUOS8=;
 b=zlhPJQvIt8bun2SFQ70uLFXjvSadVmCtPZZgbrgTt4YAI41iKOr8oiRKxFLcP55nfMd+
 Cnv+z5BFs32eDY16eL2EuZ78iyeMVZWCT+akam2AZbyxYg637SPOHxE6sgMGIaMCSrbb
 7T/IXtWWOxf80MIfyRzdNJNJ7RhXG5I4eaTnSFGwmV+lcqG2AKIY5BpwBazL9aVKPmKL
 jXRrJyC0kjv16kgI4oW4ZYWyirD/SI3lV8ptPBTqRCLOifFFKGf/a2d00YxTJ2/OOsUN
 WNOcQ7Q6LTK/AC42I1rnx1S4LkBwnCOZx0jWs9HDDu/0H/rBBHSQBEjAp3T4dOcFiltM SQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=i4xQmbvI4G/h2NIs8DYNtjtoMidMR3X2fKkOhOoUOS8=;
 b=tLbrpyXqDApvTIXKbh/kQFZ5ExgF0yII48SKSxIgy/d+bmC/i+LJE0k+m1pln6HN3d3N
 eqop309HOKJEfBtYcVJ7lIQih85IZDIvsDNfKyRca02g3HhF3oILeAajb+kWR1KTpaMS
 vfwK09t3dRjjbC0neEhjJpwoEsIq/kWRZivRtFmiJvjJmaYVn4xwWJPFKOTmFqVkqXtU
 Sm1F8RTSZQa7Vnk9LWwOkLrzEFWEnhWE1IduskFN/afzEmUlG7tqMeWFlONw2mOadt9T
 oNsaVttp5E0blEj6foSxM8NUIrs0Ur11QxfJXeqwYdsh3eni/9I5LCLVEaSAf3OiORef Rw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ap0xpbyx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 13:20:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17RDBXLM007403;
        Fri, 27 Aug 2021 13:20:54 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2043.outbound.protection.outlook.com [104.47.51.43])
        by aserp3030.oracle.com with ESMTP id 3ajqhmjmbs-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 13:20:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGveCsFd6yIUPAMR3nOhgK7P/zUYoTGpxjtE3Bh+vhZ45ilDSy85omix5GzkolsXb1fiN8YjMGrtRAi0fpFaR31KC+6bG6xmsGklgaQbXTPZzpmE6pSLBFFRtef2kF4nL4BQWmQvMcP/KRQgULRSb8gPA+Q5sZ1YkdoYAdvoCjcgsmhj5Gd+bhLH57Mg2DOO+0C7E7QVoaiiptfqCuOoeABv230eHHRxzjjFwRu1oNmSQih3g3WLQFAZQQE9zlVnd9ZXc1QwFFE1s1bAG8SrD8rOA14Vny2mpm34/+waiS1yMIUW1mTLKle8XgAI+3c7ae8+vdUppB9tTzXsrvAVnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4xQmbvI4G/h2NIs8DYNtjtoMidMR3X2fKkOhOoUOS8=;
 b=hFy0SvULxGr91A+S7cRtaniXfZCMCwHXf+YhD+lsdPpjZwwgoSIW/+ngYasxu3rHwzbON4idj2eBDkrvLJzw824gOWrohWsTWKpiVWNLvIJSxsPvaP2LD/e9Y5Z7x25wbUbTSGCaonZ3gAmtA+0y39M3xHpKyU1mjphU9qOiRPV/bv4NaoVXd0X39zei2zzzHzZyExgoVJ4iGQeWgur2MumokMTpXKbKlF/+hy507knAKkEQ0Ch7ik8X6UX57YRDovFUHEkz7liZeWPfX4e0Pp5ioEeLYD3QBF6aKHl+T++jOTi0Sh3SUTkVAzTLGCEADY+UKVNIdfgeuyHe4zOrNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4xQmbvI4G/h2NIs8DYNtjtoMidMR3X2fKkOhOoUOS8=;
 b=Qm9LjrsbuDFAHc51oGCp6Zi695HZXwnC0ivLu1Cc/devX/Kgm3GB5nLpSd7E01Omr7OuAOVF/wg/MoPwyZ81WUHHoLc3rfRQCuLkAq0EMtaFTCJ1IxMkHJI/8HWTLjBpfRXidFGYUkw+SkepYw+8NkvuoD33nmRvp0RN+g0mTPU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BYAPR10MB3237.namprd10.prod.outlook.com (2603:10b6:a03:153::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.23; Fri, 27 Aug
 2021 13:20:52 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3%4]) with mapi id 15.20.4457.020; Fri, 27 Aug 2021
 13:20:52 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v4 09/14] x86: Secure Launch kernel late boot stub
Date:   Fri, 27 Aug 2021 09:28:32 -0400
Message-Id: <1630070917-9896-10-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
References: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:805:de::24) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lateralus.us.oracle.com (209.17.40.45) by SN6PR05CA0011.namprd05.prod.outlook.com (2603:10b6:805:de::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.8 via Frontend Transport; Fri, 27 Aug 2021 13:20:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 017dce5b-e83f-4def-e4f3-08d9695d7e2c
X-MS-TrafficTypeDiagnostic: BYAPR10MB3237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB32375AFAF93A02419C9A15D1E6C89@BYAPR10MB3237.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BaToLpkIEtBm+IbpHgPRIHg5tJux2GZDEi2WSk8/qF+CLTj8izjrh8Cgq1TKH3nV3tmdf8DHcjmUwEXyns1hor1bt7WaORCKiKpZXhDVWBUeThiOHzbsj8OVz95MGh5frlsgL67r2aeLINyvohk5A6HWaHedHa55rKNh6z0Yp/hS0cxD9ubi7vytxOmZWMUd8HgTeqUUkcqceoLTyjGW21VrXI2KL+ljCfCRqYpqjCfPpsjEMLlAGQxvIQtgVk1f39MG59CjPYNJsQnlFKoKYycbNtz8JFkesRI0dlMB0tMk0bf9cK+rx8irQx8fKtjNBzok8lCFvbfMnS/ocpa9C9sDoyGbxIarrCGEaDVnFeYVaAAkKe83six7PxeXe1HPv29ZUUACeazKZy9dJGSACdiEwGwGpHCKTyO4DGFRjw4aCKLfDdOltZczvi+du1uAzbX7BxkCdc2hAtKo9x5HqAMeEU6OitUQTx6aymtMI5UiWYbiyscC7QLjIzFr9eZ3i5fGYVHCYWWzTM+b315CimBlhK19tu4GmQKQGB7tixYu30gs+kxcIi0CuxKzfdhdSPFNMKyPug4dnaei/g28PX0TSDorlLPZNEzxJWGq1/YSTpSVXK+r/FRlyVr41vCJl7FrHQlWDRpcoZ7U2nPoLOdYzy1U760M1ubcduCREPiou64qdF7ZfvC0EzKdWC1g3BLhL2fw3i7BIdzm2urPeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(346002)(376002)(396003)(956004)(44832011)(2616005)(30864003)(2906002)(52116002)(26005)(7696005)(478600001)(38350700002)(38100700002)(6486002)(36756003)(186003)(83380400001)(6666004)(86362001)(8936002)(8676002)(316002)(66946007)(66556008)(4326008)(66476007)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+8AqBj5TyNxXBoPG0D5jfEu2uLJy/RUlRIgS8aFkO0NxiDxk16Kv7e2Xp767?=
 =?us-ascii?Q?lzFludkebeNPOUzKWmdUHJusl8AG14KJFAlNxoMiYuyUOBXfwOskIhLDvV2O?=
 =?us-ascii?Q?fLN1Em+fHI/81n9pTzRIN8sm6umw5s2yGOnE5G6Nmi+aMzo78GOhKBjW4fsO?=
 =?us-ascii?Q?TmD2bJG8ZYQ5u4wtWqUSiS6IItEw6PThtWcMCmNhGC+UJWUbYjmXk9mPYQOh?=
 =?us-ascii?Q?EaMjN+9psDL43sSmsrg7d2OGSg9xnCDhQYcBj8SV2fqhBsX5cBLynrigI59x?=
 =?us-ascii?Q?azJevL0YKFHpYlEJ1TK1fRiafk91pJ8uHAKLQ8cpI4EEG19c45gSey/iGabj?=
 =?us-ascii?Q?Jkmb9sKgte+2JYRWO5nJmgSmTdda/H4xf+hZ7cN7pv5EsxvnPL+W5P0jxFaY?=
 =?us-ascii?Q?FHt030g8yyo/RIOBYUWkqOblCY+BBHHSYD+12S8CXpRnM9ETkffoba0bnmY4?=
 =?us-ascii?Q?cte2vl4xGnY6uUvEzpewpQbajywh3WiyI0s0lzG4pG4vl4XZgLR1EIS6R8tT?=
 =?us-ascii?Q?rD4ge+MOyo67ICIPh/JOUqI8pRE6rhKd5ZbBD/FL2TlrBvjxuV2SqafCnIpE?=
 =?us-ascii?Q?aFUm1jfdcnAfQZ4v1Tu59MnBpMb7jDyE/eTB/yP0TswxVth/nJG9jsDKC9kO?=
 =?us-ascii?Q?MLEqW1n5q/HUhUwDUYDd3WNSROVcUApO8l67fKoruL0FTdCgmQV/Xnx6tc4e?=
 =?us-ascii?Q?pHghlPxjG6MvNo+EqjdKanEytFL7zFSDp3JeR8O1MoY5PJDx5g0owz/jVC47?=
 =?us-ascii?Q?MoiltrT6MX4NW7/gPW0VCvJFlyDckL86F+3t5Aw0rdkFvq3CRTn7PBEmilBI?=
 =?us-ascii?Q?XN2tD6wXNajaTJl7LHPwRYaRFMBOiReU7zF2fBiPMwEALOWjGobPUUqwTRnz?=
 =?us-ascii?Q?LlqaHqnyYbrez+64ogERJavFmzPUWeHPCMr4oHNvFVtvofijRjPqULsTTKsE?=
 =?us-ascii?Q?2MA4qL2r4nJJV1tX360vQH6zQzHZDItCQwajEmeoVWkN4AcqCCd0hOfwh6LV?=
 =?us-ascii?Q?SU9IjiQOkNYnefhUiiaI6i0kZFE70R975k0fXa5UebP0moGnMMW+Rxdbr29i?=
 =?us-ascii?Q?CFqGiowaaAsTB8GPaSa/JJO7j1A6r5+0QGKZMEQwYxm3SUBzEtDKoIUXXGrH?=
 =?us-ascii?Q?u5IaPnLRjox/r08W7mgj/ZcaKwVGtob1TApdT9ATHYfUlC/cRIgzZP/xXkC8?=
 =?us-ascii?Q?kGBUR6H8c1Fo/XPQaD3NToUzwEC5PztcziXJa7/CeR3+8qjFEdxwuFhwlq5O?=
 =?us-ascii?Q?75Ux3uL6kEF/fF+hgZBzZYBISDuLfrUoNHrFGr60bXGzp/+7CTeixWVqzi2U?=
 =?us-ascii?Q?vmdDrW14sCyy+riGkMWuAZiW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 017dce5b-e83f-4def-e4f3-08d9695d7e2c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 13:20:52.1131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sWCubs3nC0ahkGaZ+RSyjIEpyi5roDB6XFGQIrBmSn5kUnAhEAG3rItnp5a9gG6fjKT1mtwZYGfFk1je0gE7Al6ZA2/thSLHv5UdCiXZ1uw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3237
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10088 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108270086
X-Proofpoint-GUID: YPnD9WqctYBD3WRfXQIXA3HUDN_wfVoK
X-Proofpoint-ORIG-GUID: YPnD9WqctYBD3WRfXQIXA3HUDN_wfVoK
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The routine slaunch_setup is called out of the x86 specific setup_arch
routine during early kernel boot. After determining what platform is
present, various operations specific to that platform occur. This
includes finalizing setting for the platform late launch and verifying
that memory protections are in place.

For TXT, this code also reserves the original compressed kernel setup
area where the APs were left looping so that this memory cannot be used.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/kernel/Makefile   |   1 +
 arch/x86/kernel/setup.c    |   3 +
 arch/x86/kernel/slaunch.c  | 460 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/dmar.c |   4 +
 4 files changed, 468 insertions(+)
 create mode 100644 arch/x86/kernel/slaunch.c

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 3e625c6..d6ee904 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -80,6 +80,7 @@ obj-$(CONFIG_X86_32)		+= tls.o
 obj-$(CONFIG_IA32_EMULATION)	+= tls.o
 obj-y				+= step.o
 obj-$(CONFIG_INTEL_TXT)		+= tboot.o
+obj-$(CONFIG_SECURE_LAUNCH)	+= slaunch.o
 obj-$(CONFIG_ISA_DMA_API)	+= i8237.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-y				+= cpu/
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 055a834..482bd76 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -19,6 +19,7 @@
 #include <linux/root_dev.h>
 #include <linux/hugetlb.h>
 #include <linux/tboot.h>
+#include <linux/slaunch.h>
 #include <linux/usb/xhci-dbgp.h>
 #include <linux/static_call.h>
 #include <linux/swiotlb.h>
@@ -976,6 +977,8 @@ void __init setup_arch(char **cmdline_p)
 	early_gart_iommu_check();
 #endif
 
+	slaunch_setup_txt();
+
 	/*
 	 * partially used pages are not usable - thus
 	 * we are rounding upwards:
diff --git a/arch/x86/kernel/slaunch.c b/arch/x86/kernel/slaunch.c
new file mode 100644
index 0000000..f91f0b5
--- /dev/null
+++ b/arch/x86/kernel/slaunch.c
@@ -0,0 +1,460 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Secure Launch late validation/setup and finalization support.
+ *
+ * Copyright (c) 2021, Oracle and/or its affiliates.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/linkage.h>
+#include <linux/mm.h>
+#include <linux/io.h>
+#include <linux/uaccess.h>
+#include <linux/security.h>
+#include <linux/memblock.h>
+#include <asm/segment.h>
+#include <asm/sections.h>
+#include <asm/tlbflush.h>
+#include <asm/e820/api.h>
+#include <asm/setup.h>
+#include <linux/slaunch.h>
+
+static u32 sl_flags;
+static struct sl_ap_wake_info ap_wake_info;
+static u64 evtlog_addr;
+static u32 evtlog_size;
+static u64 vtd_pmr_lo_size;
+
+/* This should be plenty of room */
+static u8 txt_dmar[PAGE_SIZE] __aligned(16);
+
+u32 slaunch_get_flags(void)
+{
+	return sl_flags;
+}
+EXPORT_SYMBOL(slaunch_get_flags);
+
+struct sl_ap_wake_info *slaunch_get_ap_wake_info(void)
+{
+	return &ap_wake_info;
+}
+
+struct acpi_table_header *slaunch_get_dmar_table(struct acpi_table_header *dmar)
+{
+	/* The DMAR is only stashed and provided via TXT on Intel systems */
+	if (memcmp(txt_dmar, "DMAR", 4))
+		return dmar;
+
+	return (struct acpi_table_header *)(&txt_dmar[0]);
+}
+
+void __noreturn slaunch_txt_reset(void __iomem *txt,
+				  const char *msg, u64 error)
+{
+	u64 one = 1, val;
+
+	pr_err("%s", msg);
+
+	/*
+	 * This performs a TXT reset with a sticky error code. The reads of
+	 * TXT_CR_E2STS act as barriers.
+	 */
+	memcpy_toio(txt + TXT_CR_ERRORCODE, &error, sizeof(error));
+	memcpy_fromio(&val, txt + TXT_CR_E2STS, sizeof(val));
+	memcpy_toio(txt + TXT_CR_CMD_NO_SECRETS, &one, sizeof(one));
+	memcpy_fromio(&val, txt + TXT_CR_E2STS, sizeof(val));
+	memcpy_toio(txt + TXT_CR_CMD_UNLOCK_MEM_CONFIG, &one, sizeof(one));
+	memcpy_fromio(&val, txt + TXT_CR_E2STS, sizeof(val));
+	memcpy_toio(txt + TXT_CR_CMD_RESET, &one, sizeof(one));
+
+	for ( ; ; )
+		asm volatile ("hlt");
+
+	unreachable();
+}
+
+/*
+ * The TXT heap is too big to map all at once with early_ioremap
+ * so it is done a table at a time.
+ */
+static void __init *txt_early_get_heap_table(void __iomem *txt, u32 type,
+					     u32 bytes)
+{
+	void *heap;
+	u64 base, size, offset = 0;
+	int i;
+
+	if (type > TXT_SINIT_TABLE_MAX)
+		slaunch_txt_reset(txt,
+			"Error invalid table type for early heap walk\n",
+			SL_ERROR_HEAP_WALK);
+
+	memcpy_fromio(&base, txt + TXT_CR_HEAP_BASE, sizeof(base));
+	memcpy_fromio(&size, txt + TXT_CR_HEAP_SIZE, sizeof(size));
+
+	/* Iterate over heap tables looking for table of "type" */
+	for (i = 0; i < type; i++) {
+		base += offset;
+		heap = early_memremap(base, sizeof(u64));
+		if (!heap)
+			slaunch_txt_reset(txt,
+				"Error early_memremap of heap for heap walk\n",
+				SL_ERROR_HEAP_MAP);
+
+		offset = *((u64 *)heap);
+
+		/*
+		 * After the first iteration, any offset of zero is invalid and
+		 * implies the TXT heap is corrupted.
+		 */
+		if (!offset)
+			slaunch_txt_reset(txt,
+				"Error invalid 0 offset in heap walk\n",
+				SL_ERROR_HEAP_ZERO_OFFSET);
+
+		early_memunmap(heap, sizeof(u64));
+	}
+
+	/* Skip the size field at the head of each table */
+	base += sizeof(u64);
+	heap = early_memremap(base, bytes);
+	if (!heap)
+		slaunch_txt_reset(txt,
+				  "Error early_memremap of heap section\n",
+				  SL_ERROR_HEAP_MAP);
+
+	return heap;
+}
+
+static void __init txt_early_put_heap_table(void *addr, unsigned long size)
+{
+	early_memunmap(addr, size);
+}
+
+/*
+ * TXT uses a special set of VTd registers to protect all of memory from DMA
+ * until the IOMMU can be programmed to protect memory. There is the low
+ * memory PMR that can protect all memory up to 4G. The high memory PRM can
+ * be setup to protect all memory beyond 4Gb. Validate that these values cover
+ * what is expected.
+ */
+static void __init slaunch_verify_pmrs(void __iomem *txt)
+{
+	struct txt_os_sinit_data *os_sinit_data;
+	unsigned long last_pfn;
+	u32 field_offset, err = 0;
+	const char *errmsg = "";
+
+	field_offset = offsetof(struct txt_os_sinit_data, lcp_po_base);
+	os_sinit_data = txt_early_get_heap_table(txt, TXT_OS_SINIT_DATA_TABLE,
+						 field_offset);
+
+	/* Save a copy */
+	vtd_pmr_lo_size = os_sinit_data->vtd_pmr_lo_size;
+
+	last_pfn = e820__end_of_ram_pfn();
+
+	/*
+	 * First make sure the hi PMR covers all memory above 4G. In the
+	 * unlikely case where there is < 4G on the system, the hi PMR will
+	 * not be set.
+	 */
+	if (os_sinit_data->vtd_pmr_hi_base != 0x0ULL) {
+		if (os_sinit_data->vtd_pmr_hi_base != 0x100000000ULL) {
+			err = SL_ERROR_HI_PMR_BASE;
+			errmsg =  "Error hi PMR base\n";
+			goto out;
+		}
+
+		if (PFN_PHYS(last_pfn) > os_sinit_data->vtd_pmr_hi_base +
+		    os_sinit_data->vtd_pmr_hi_size) {
+			err = SL_ERROR_HI_PMR_SIZE;
+			errmsg = "Error hi PMR size\n";
+			goto out;
+		}
+	}
+
+	/*
+	 * Lo PMR base should always be 0. This was already checked in
+	 * early stub.
+	 */
+
+	/*
+	 * Check that if the kernel was loaded below 4G, that it is protected
+	 * by the lo PMR. Note this is the decompressed kernel. The ACM would
+	 * have ensured the compressed kernel (the MLE image) was protected.
+	 */
+	if ((__pa_symbol(_end) < 0x100000000ULL) &&
+	    (__pa_symbol(_end) > os_sinit_data->vtd_pmr_lo_size)) {
+		err = SL_ERROR_LO_PMR_MLE;
+		errmsg = "Error lo PMR does not cover MLE kernel\n";
+	}
+
+	/*
+	 * Other regions of interest like boot param, AP wake block, cmdline
+	 * already checked for PMR coverage in the early stub code.
+	 */
+
+out:
+	txt_early_put_heap_table(os_sinit_data, field_offset);
+
+	if (err)
+		slaunch_txt_reset(txt, errmsg, err);
+}
+
+static void __init slaunch_txt_reserve_range(u64 base, u64 size)
+{
+	int type;
+
+	type = e820__get_entry_type(base, base + size - 1);
+	if (type == E820_TYPE_RAM) {
+		pr_info("memblock reserve base: %llx size: %llx\n", base, size);
+		memblock_reserve(base, size);
+	}
+}
+
+/*
+ * For Intel, certain regions of memory must be marked as reserved by putting
+ * them on the memblock reserved list if they are not already e820 reserved.
+ * This includes:
+ *  - The TXT HEAP
+ *  - The ACM area
+ *  - The TXT private register bank
+ *  - The MDR list sent to the MLE by the ACM (see TXT specification)
+ *  (Normally the above are properly reserved by firmware but if it was not
+ *  done, reserve them now)
+ *  - The AP wake block
+ *  - TPM log external to the TXT heap
+ *
+ * Also if the low PMR doesn't cover all memory < 4G, any RAM regions above
+ * the low PMR must be reservered too.
+ */
+static void __init slaunch_txt_reserve(void __iomem *txt)
+{
+	struct txt_sinit_memory_descriptor_record *mdr;
+	struct txt_sinit_mle_data *sinit_mle_data;
+	void *mdrs;
+	u64 base, size, heap_base, heap_size;
+	u32 field_offset, mdrnum, mdroffset, mdrslen, i;
+
+	base = TXT_PRIV_CONFIG_REGS_BASE;
+	size = TXT_PUB_CONFIG_REGS_BASE - TXT_PRIV_CONFIG_REGS_BASE;
+	slaunch_txt_reserve_range(base, size);
+
+	memcpy_fromio(&heap_base, txt + TXT_CR_HEAP_BASE, sizeof(heap_base));
+	memcpy_fromio(&heap_size, txt + TXT_CR_HEAP_SIZE, sizeof(heap_size));
+	slaunch_txt_reserve_range(heap_base, heap_size);
+
+	memcpy_fromio(&base, txt + TXT_CR_SINIT_BASE, sizeof(base));
+	memcpy_fromio(&size, txt + TXT_CR_SINIT_SIZE, sizeof(size));
+	slaunch_txt_reserve_range(base, size);
+
+	field_offset = offsetof(struct txt_sinit_mle_data,
+				sinit_vtd_dmar_table_size);
+	sinit_mle_data = txt_early_get_heap_table(txt, TXT_SINIT_MLE_DATA_TABLE,
+						  field_offset);
+
+	mdrnum = sinit_mle_data->num_of_sinit_mdrs;
+	mdroffset = sinit_mle_data->sinit_mdrs_table_offset;
+
+	txt_early_put_heap_table(sinit_mle_data, field_offset);
+
+	if (!mdrnum)
+		goto nomdr;
+
+	mdrslen = (mdrnum * sizeof(struct txt_sinit_memory_descriptor_record));
+
+	mdrs = txt_early_get_heap_table(txt, TXT_SINIT_MLE_DATA_TABLE,
+					mdroffset + mdrslen - 8);
+
+	mdr = (struct txt_sinit_memory_descriptor_record *)
+			(mdrs + mdroffset - 8);
+
+	for (i = 0; i < mdrnum; i++, mdr++) {
+		/* Spec says some entries can have length 0, ignore them */
+		if (mdr->type > 0 && mdr->length > 0)
+			slaunch_txt_reserve_range(mdr->address, mdr->length);
+	}
+
+	txt_early_put_heap_table(mdrs, mdroffset + mdrslen - 8);
+
+nomdr:
+	slaunch_txt_reserve_range(ap_wake_info.ap_wake_block,
+				  ap_wake_info.ap_wake_block_size);
+
+	/*
+	 * Earlier checks ensured that the event log was properly situated
+	 * either inside the TXT heap or outside. This is a check to see if the
+	 * event log needs to be reserved. If it is in the TXT heap, it is
+	 * already reserved.
+	 */
+	if (evtlog_addr < heap_base || evtlog_addr > (heap_base + heap_size))
+		slaunch_txt_reserve_range(evtlog_addr, evtlog_size);
+
+	for (i = 0; i < e820_table->nr_entries; i++) {
+		base = e820_table->entries[i].addr;
+		size = e820_table->entries[i].size;
+		if ((base >= vtd_pmr_lo_size) && (base < 0x100000000ULL))
+			slaunch_txt_reserve_range(base, size);
+		else if ((base < vtd_pmr_lo_size) &&
+			 (base + size > vtd_pmr_lo_size))
+			slaunch_txt_reserve_range(vtd_pmr_lo_size,
+						  base + size - vtd_pmr_lo_size);
+	}
+}
+
+/*
+ * TXT stashes a safe copy of the DMAR ACPI table to prevent tampering.
+ * It is stored in the TXT heap. Fetch it from there and make it available
+ * to the IOMMU driver.
+ */
+static void __init slaunch_copy_dmar_table(void __iomem *txt)
+{
+	struct txt_sinit_mle_data *sinit_mle_data;
+	void *dmar;
+	u32 field_offset, dmar_size, dmar_offset;
+
+	memset(&txt_dmar, 0, PAGE_SIZE);
+
+	field_offset = offsetof(struct txt_sinit_mle_data,
+				processor_scrtm_status);
+	sinit_mle_data = txt_early_get_heap_table(txt, TXT_SINIT_MLE_DATA_TABLE,
+						  field_offset);
+
+	dmar_size = sinit_mle_data->sinit_vtd_dmar_table_size;
+	dmar_offset = sinit_mle_data->sinit_vtd_dmar_table_offset;
+
+	txt_early_put_heap_table(sinit_mle_data, field_offset);
+
+	if (!dmar_size || !dmar_offset)
+		slaunch_txt_reset(txt,
+				  "Error invalid DMAR table values\n",
+				  SL_ERROR_HEAP_INVALID_DMAR);
+
+	if (unlikely(dmar_size > PAGE_SIZE))
+		slaunch_txt_reset(txt,
+				  "Error DMAR too big to store\n",
+				  SL_ERROR_HEAP_DMAR_SIZE);
+
+
+	dmar = txt_early_get_heap_table(txt, TXT_SINIT_MLE_DATA_TABLE,
+					dmar_offset + dmar_size - 8);
+	if (!dmar)
+		slaunch_txt_reset(txt,
+				  "Error early_ioremap of DMAR\n",
+				  SL_ERROR_HEAP_DMAR_MAP);
+
+	memcpy(&txt_dmar[0], dmar + dmar_offset - 8, dmar_size);
+
+	txt_early_put_heap_table(dmar, dmar_offset + dmar_size - 8);
+}
+
+/*
+ * The location of the safe AP wake code block is stored in the TXT heap.
+ * Fetch it here in the early init code for later use in SMP startup.
+ *
+ * Also get the TPM event log values that may have to be put on the
+ * memblock reserve list later.
+ */
+static void __init slaunch_fetch_os_mle_fields(void __iomem *txt)
+{
+	struct txt_os_mle_data *os_mle_data;
+	u8 *jmp_offset;
+
+	os_mle_data = txt_early_get_heap_table(txt, TXT_OS_MLE_DATA_TABLE,
+					       sizeof(*os_mle_data));
+
+	ap_wake_info.ap_wake_block = os_mle_data->ap_wake_block;
+	ap_wake_info.ap_wake_block_size = os_mle_data->ap_wake_block_size;
+
+	jmp_offset = os_mle_data->mle_scratch + SL_SCRATCH_AP_JMP_OFFSET;
+	ap_wake_info.ap_jmp_offset = *((u32 *)jmp_offset);
+
+	evtlog_addr = os_mle_data->evtlog_addr;
+	evtlog_size = os_mle_data->evtlog_size;
+
+	txt_early_put_heap_table(os_mle_data, sizeof(*os_mle_data));
+}
+
+/*
+ * Intel TXT specific late stub setup and validation.
+ */
+void __init slaunch_setup_txt(void)
+{
+	void __iomem *txt;
+	u64 one = TXT_REGVALUE_ONE, val;
+
+	if (!boot_cpu_has(X86_FEATURE_SMX))
+		return;
+
+	/*
+	 * First see if SENTER was done and not by TBOOT by reading the status
+	 * register in the public space. If the public register space cannot
+	 * be read, TXT is disabled.
+	 */
+	txt = early_ioremap(TXT_PUB_CONFIG_REGS_BASE,
+			    TXT_NR_CONFIG_PAGES * PAGE_SIZE);
+	if (!txt)
+		return;
+
+	memcpy_fromio(&val, txt + TXT_CR_STS, sizeof(val));
+	early_iounmap(txt, TXT_NR_CONFIG_PAGES * PAGE_SIZE);
+
+	/* Was SENTER done? */
+	if (!(val & TXT_SENTER_DONE_STS))
+		return;
+
+	/* Was it done by TBOOT? */
+	if (boot_params.tboot_addr)
+		return;
+
+	/* Now we want to use the private register space */
+	txt = early_ioremap(TXT_PRIV_CONFIG_REGS_BASE,
+			    TXT_NR_CONFIG_PAGES * PAGE_SIZE);
+	if (!txt) {
+		/* This is really bad, no where to go from here */
+		panic("Error early_ioremap of TXT priv registers\n");
+	}
+
+	/*
+	 * Try to read the Intel VID from the TXT private registers to see if
+	 * TXT measured launch happened properly and the private space is
+	 * available.
+	 */
+	memcpy_fromio(&val, txt + TXT_CR_DIDVID, sizeof(val));
+	if ((u16)(val & 0xffff) != 0x8086) {
+		/*
+		 * Can't do a proper TXT reset since it appears something is
+		 * wrong even though SENTER happened and it should be in SMX
+		 * mode.
+		 */
+		panic("Invalid TXT vendor ID, not in SMX mode\n");
+	}
+
+	/* Set flags so subsequent code knows the status of the launch */
+	sl_flags |= (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT);
+
+	/*
+	 * Reading the proper DIDVID from the private register space means we
+	 * are in SMX mode and private registers are open for read/write.
+	 */
+
+	/* On Intel, have to handle TPM localities via TXT */
+	memcpy_toio(txt + TXT_CR_CMD_SECRETS, &one, sizeof(one));
+	memcpy_fromio(&val, txt + TXT_CR_E2STS, sizeof(val));
+	memcpy_toio(txt + TXT_CR_CMD_OPEN_LOCALITY1, &one, sizeof(one));
+	memcpy_fromio(&val, txt + TXT_CR_E2STS, sizeof(val));
+
+	slaunch_fetch_os_mle_fields(txt);
+
+	slaunch_verify_pmrs(txt);
+
+	slaunch_txt_reserve(txt);
+
+	slaunch_copy_dmar_table(txt);
+
+	early_iounmap(txt, TXT_NR_CONFIG_PAGES * PAGE_SIZE);
+
+	pr_info("Intel TXT setup complete\n");
+}
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index d66f79a..d167e5d 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -29,6 +29,7 @@
 #include <linux/iommu.h>
 #include <linux/numa.h>
 #include <linux/limits.h>
+#include <linux/slaunch.h>
 #include <asm/irq_remapping.h>
 #include <asm/iommu_table.h>
 #include <trace/events/intel_iommu.h>
@@ -663,6 +664,9 @@ static inline int dmar_walk_dmar_table(struct acpi_table_dmar *dmar,
 	 */
 	dmar_tbl = tboot_get_dmar_table(dmar_tbl);
 
+	/* If Secure Launch is active, it has similar logic */
+	dmar_tbl = slaunch_get_dmar_table(dmar_tbl);
+
 	dmar = (struct acpi_table_dmar *)dmar_tbl;
 	if (!dmar)
 		return -ENODEV;
-- 
1.8.3.1

