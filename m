Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F673E49FD
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Aug 2021 18:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbhHIQcR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Aug 2021 12:32:17 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:8396 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233041AbhHIQbu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Aug 2021 12:31:50 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179GCKT1013022;
        Mon, 9 Aug 2021 16:31:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=BFndF9X2/Ujv6O61kMW7rsfN4qRcJLVXEWSTc89yuEs=;
 b=XCjXpdTGkMIMvuBpRN/y5oQoFCx3ThL25Q6t+JTeouuSaRauCgpbevel27xilPkcyNDk
 cOW5r9h5ji3Zi0IfWvJLD77/paF9LuAs53JvUOqXO2rJ7o5ndC0F4i81Kq9QMNy1Hgh8
 YolArhG+rndIF/VrAD82OALhAcf8PBeOc8Uk9n/0Ydpw8qqx4pBlPrE5a8OMiE3n84mk
 BdqfCVTheVape6UpOhbJQHaYK72OfAIgkSKNSZTJ50KRP519iyP4tkH8+xz85bmMFaa9
 AmfbChTiH5JQic2NxewGnId4PWgAqNKw06vldbest4J6MM+1aSL4sdvzcCaBMfyh804d fA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=BFndF9X2/Ujv6O61kMW7rsfN4qRcJLVXEWSTc89yuEs=;
 b=Lguy0Yi5G0Ee/fiYlquOFpQyf69kFZ8Pip9Z8EtJ49spq9zaKTmS62igky5HBJ4j/uQD
 aBMm/ylPvlJjhio5JPFUvKTI69DnwxG8hd0AjODsSKw98WM7LnNoghsQLjRfWoHG54/S
 q/GjXr8wRQwMK7z6QLHJQbGZ6rqsFOkUHCZ4gQcR1hbpICcJcqq8SFKpU87xQd5RSxjW
 s8r6H4rsxy6U0ZXFPB1l7VMX/4EYaEbodMcAurSJFHDdsqIyiKCLLuS5T7+bF07I69MB
 bthmHUEhBR7cag7myIU0sAMOJismS+lzh/rh4UzmETk8XPXX9VF6+a5+C9EoYzQ8Ckwl gg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ab17ds2fp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 16:31:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 179GUeFC066407;
        Mon, 9 Aug 2021 16:31:06 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by aserp3020.oracle.com with ESMTP id 3a9vv3860c-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 16:31:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3yhTkbG8fIbFUCcI/H2ItkBpLz1obqniYdKcCrTUL4LRvxR2s+R3HW82iax9QCAjEHWTaiyQDFK6s4NVxdIhK/DGlzoom1F7G2mhqmyIsIyoXtLijSmxWU5kf+QSr0CXuS8MtCLJrNq59lLkSKkYtmg62LvnOYAsASXRIjfx015KNtLEaXY7OoMfIk96BjAxIOA8BgYrbOXkwhqx0XU/haExhzP1g20mZt7peeE+JBI7fE0juBgU9KwR6b98arIG6ahSSVR2oLBWMenxT8k4Cb2KNyuZKIfHN9M0rg0gSNuTBnB3SZZfhkoF27qt/5onREtBazbD5TJGgdnez7+Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFndF9X2/Ujv6O61kMW7rsfN4qRcJLVXEWSTc89yuEs=;
 b=QiPnnKzHgJzy+jOWsn2xKDEleoORN3wuSCV4VkGvxdB7dFJ75axKETDKNzogwoznQbJr61BiFzDsaoLcIyECtVPOVg+KQAtexFN8xRu2B7G+oupz2erFxkrKvP/ceFn+IebR3guR+2c1q7nPDDjLvPnMdGpikM+TmEKg8GBLsHzBEfq4jUqOL19gTJ008snUOTQ2IuSvxdTPJL5xFveQm31NhBhW8nQV914XInwZd/MHOmsqrbr3OX5+lErRA/QKQA9ji5HbPBhCRTdnFWErgHEXWx0aK4wRcw2oJ9MWGJm4qSsiMJ+5zD3H2SLRrTc3UYPMaUmqPl9gOa7f/eZFjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFndF9X2/Ujv6O61kMW7rsfN4qRcJLVXEWSTc89yuEs=;
 b=iYLqstgR7D+LRGvU3yqdLxiiblV8QMU1Jq4sHysP4xM1oFVPS62/MIJ5fjjvI4v/h4+moHPzuAo1R6x/EuhWmSdSMYzFnAYq2fmNZixMIzr22k0iNPGDjXIKSwGtTPfNuO25Xn4vqG+xV43hb+nZQbwGI4B/7m4NUr60GyLiTcQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BY5PR10MB3939.namprd10.prod.outlook.com (2603:10b6:a03:1f7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Mon, 9 Aug
 2021 16:31:03 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3%4]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 16:31:03 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v3 13/14] x86: Secure Launch late initcall platform module
Date:   Mon,  9 Aug 2021 12:38:55 -0400
Message-Id: <1628527136-2478-14-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1628527136-2478-1-git-send-email-ross.philipson@oracle.com>
References: <1628527136-2478-1-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:806:a7::26) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lateralus.us.oracle.com (209.17.40.43) by SA9PR10CA0021.namprd10.prod.outlook.com (2603:10b6:806:a7::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Mon, 9 Aug 2021 16:31:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba17fa46-b163-4c21-fac0-08d95b53149b
X-MS-TrafficTypeDiagnostic: BY5PR10MB3939:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB39398BF9FCEDDF0DAAECDE61E6F69@BY5PR10MB3939.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iPTSw3O8SBBz8c9Pttef9suYQWRSAPlPNLII4XXyGfGPPYtS43rYsRyncnaNS760U9BEVpfwFE+ele1IxtcgZnhvYFZXdF/7gLxl7SsYkxG4rZ93uCyM3dC9YknrTGfn9h/01JXH9sJAILgsFOYo8/MBN+14jrj47k99w81XpFb4aESIe9w4sHV/N8WmWLr4mQDVzutitwOwJCrkSPLe9EEpgH0UcTNQ0ZOIn00Ayfk5/na1dodAEgVUh+Ug0zjML71/Twd02njYYUcAx15xqwD1JF6LhNOZe6dRdjAhH2IEca00mcdCaMDCuhx8PiJ0Wet1AHupv3W8/9f7gJEM88pegYrzwbe7TpnvF0TdiIM48mCKXzWrO6XGJHpAzprvMNvE4FoDu9Z6LJxn0hoEWHM3CusJqm/LO7udyXHQAr+z+Yde5VrUaph29dO6EHKg06kE0wbrFJ8fIYokymeeUmwpJpfrxuo97uRWFvGzCvFYlWewhUgEG/dNsvqLQ4mMJHZ0wBhorbO/m/dFjLto/F9L42JObd/7+j9FV5Pzwyl3AH5KPVtq4s2Vb9KgZBeyPwLgfaetNQcyIyE5HIwf3PqUlEues6BTIdkuGP7m2jayBmgmaLe2IbWBaT0p7x5MRWqzByPG4tQbqoYgKuKnY03XryYnzXyaasdTHobr/YGg+IcTLmgyJFoVDpkStyTMP+U1c4hCBAAMKMcsurmDmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(346002)(376002)(136003)(366004)(38350700002)(478600001)(86362001)(316002)(38100700002)(52116002)(4326008)(7696005)(7416002)(2906002)(6666004)(8936002)(83380400001)(6486002)(186003)(5660300002)(8676002)(26005)(44832011)(30864003)(2616005)(66946007)(66476007)(66556008)(956004)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TROSQwyCX5CbNO2frbvktISkRYxxwMFOZ5dShPXiBpL80vPI3hankmiahJlh?=
 =?us-ascii?Q?BZ0aBNBKWVyLIU5ShcRmvxVA/Kh9V4ZCKtVp1kVkagiY8Zy52aXvaBLjKddj?=
 =?us-ascii?Q?WAeKk6t1kKzfhKOnIIgDes0E7LUV0mFVmhmvRRSePswdpbfR6bKK+yJlay4t?=
 =?us-ascii?Q?hdb1F+aRitkDCHAvEpHywi88dEysiisl6n0sILnHYLQ7fJ5H0Vc0dFrwmNQc?=
 =?us-ascii?Q?lq5pifo23yGpqKcbR2AHwuAtebFpZTozdXneGS0r5/xHMMoNHPwWWVP4Mnxd?=
 =?us-ascii?Q?4x03Nq8AD49YManiShGTNIvkpu7G9pJqeAM2do5WrjqYXxTBq1AUPKJEuJH7?=
 =?us-ascii?Q?coIzFtXi7W6x3LWu8fLSpUN9HvIadeZGO7m7Cd0/wfL0azk6zomtyX9ldNU8?=
 =?us-ascii?Q?nA26l4a0he2cPmd9YLwEHi7qTbj5vkUDSGXY2DtphZZWyITpcOf259QCXaPh?=
 =?us-ascii?Q?TCp/C3g1FKlsbuFrk4n4U/PLP5nLlIAgPh2Txk1C19zlB881oeBngK216zCx?=
 =?us-ascii?Q?pK10S/oA4hhRQ4WHkHw8icCujgMEd1J972hBMKcaelTsI9OUqV8D8PKkxhNB?=
 =?us-ascii?Q?41N/Wdz7OrTYAAmtZ+LTTfA7agvtiG6Yg5FC3mp4oo8Y4os3hJJUMltSE4Jt?=
 =?us-ascii?Q?4hJbuCxObRrofN9nbPTRBD0wjiT7AnNLoi4byrejMMGNVVlkR1/DS7I5lykm?=
 =?us-ascii?Q?b7bLxO24e3RhaWNulZ+BpxkkvyQ1Fk7l/pmWHftq8fzWFrDLLGoTT9fEzZ9X?=
 =?us-ascii?Q?JvOqH/yELSslakDjAdyi/ij7mTAxLw78BBUDoN9eX3eW6H8w279WVPH+0/f4?=
 =?us-ascii?Q?HAZOGBAwE1HCaUAl28KK92zqZ6RnZeAs/2ACs4b2Os2kfHGQ+XU4kpczyeTH?=
 =?us-ascii?Q?cZrojOJ0FMAYGLCgmKPDxw5nisP9J7p6D2ffB8gaMrGkCySTJwW+CHFlJkgN?=
 =?us-ascii?Q?HA3Y2f5nZjYnUuuXjm8dVVZmeESAn5NGk0MCn32xuCrQ1RnvNHWTblmB0Uz4?=
 =?us-ascii?Q?NKoqVBRDFhq93nBzzIdHqhELObbXkqvN+S+SMM+jVaf0u21KVSP+8unSFwc5?=
 =?us-ascii?Q?yfoByVQ2aAKg2SFoSErgVLTh2PES+UXVNvz9QJHdHGiwSoGdYkXE8Y9Qw3kA?=
 =?us-ascii?Q?9wEQwFHqjinoIOcKN2FV4mpasxroTT/u2IndZhSGBJPCagq1lL/Vz46y18oe?=
 =?us-ascii?Q?F2L8o0Y2xt+L/64bhCNTyhf563l4Epqr9IKL0aQP51hnLcRNvMhhF3vLNALT?=
 =?us-ascii?Q?mw/pXKYT0pK+YINUBPcstMa8rDyhuagiFhTYJJSPjgiPq5ZZAOYb64SGJAk8?=
 =?us-ascii?Q?qp+SmJdhGxjFFbFV0a/TIku1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba17fa46-b163-4c21-fac0-08d95b53149b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 16:31:03.6934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 32dozYdorUf5LSAt602Mu49ei69bqXUzaPjP52K2Q6UnnBxVHFL5jpOygGPzNKN6WpWarXiDpAk87C5BHUWp3/b9tl5RSJ6W+ZaK4aWZ8IA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3939
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10071 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108090119
X-Proofpoint-GUID: XB95YG6UA-SGBM4NqKA5xHdp0puQ8B-2
X-Proofpoint-ORIG-GUID: XB95YG6UA-SGBM4NqKA5xHdp0puQ8B-2
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: "Daniel P. Smith" <dpsmith@apertussolutions.com>

The Secure Launch platform module is a late init module. During the
init call, the TPM event log is read and measurements taken in the
early boot stub code are located. These measurements are extended
into the TPM PCRs using the mainline TPM kernel driver.

The platform module also registers the securityfs nodes to allow
access to TXT register fields on Intel along with the fetching of
and writing events to the late launch TPM log.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: garnetgrimm <grimmg@ainfosec.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/kernel/Makefile   |   1 +
 arch/x86/kernel/slmodule.c | 495 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 496 insertions(+)
 create mode 100644 arch/x86/kernel/slmodule.c

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index d6ee904..09b730a 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -81,6 +81,7 @@ obj-$(CONFIG_IA32_EMULATION)	+= tls.o
 obj-y				+= step.o
 obj-$(CONFIG_INTEL_TXT)		+= tboot.o
 obj-$(CONFIG_SECURE_LAUNCH)	+= slaunch.o
+obj-$(CONFIG_SECURE_LAUNCH)	+= slmodule.o
 obj-$(CONFIG_ISA_DMA_API)	+= i8237.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-y				+= cpu/
diff --git a/arch/x86/kernel/slmodule.c b/arch/x86/kernel/slmodule.c
new file mode 100644
index 0000000..807f9ca
--- /dev/null
+++ b/arch/x86/kernel/slmodule.c
@@ -0,0 +1,495 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Secure Launch late validation/setup, securityfs exposure and
+ * finalization support.
+ *
+ * Copyright (c) 2021 Apertus Solutions, LLC
+ * Copyright (c) 2021 Assured Information Security, Inc.
+ * Copyright (c) 2021, Oracle and/or its affiliates.
+ *
+ * Author(s):
+ *     Daniel P. Smith <dpsmith@apertussolutions.com>
+ *     Garnet T. Grimm <grimmg@ainfosec.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <linux/mm.h>
+#include <linux/io.h>
+#include <linux/uaccess.h>
+#include <linux/security.h>
+#include <linux/memblock.h>
+#include <asm/segment.h>
+#include <asm/sections.h>
+#include <crypto/sha2.h>
+#include <linux/slaunch.h>
+
+#define SL_FS_ENTRIES		10
+/* root directory node must be last */
+#define SL_ROOT_DIR_ENTRY	(SL_FS_ENTRIES - 1)
+#define SL_TXT_DIR_ENTRY	(SL_FS_ENTRIES - 2)
+#define SL_TXT_FILE_FIRST	(SL_TXT_DIR_ENTRY - 1)
+#define SL_TXT_ENTRY_COUNT	7
+
+#define DECLARE_TXT_PUB_READ_U(size, fmt, msg_size)			\
+static ssize_t txt_pub_read_u##size(unsigned int offset,		\
+		loff_t *read_offset,					\
+		size_t read_len,					\
+		char __user *buf)					\
+{									\
+	void __iomem *txt;						\
+	char msg_buffer[msg_size];					\
+	u##size reg_value = 0;						\
+	txt = ioremap(TXT_PUB_CONFIG_REGS_BASE,				\
+			TXT_NR_CONFIG_PAGES * PAGE_SIZE);		\
+	if (IS_ERR(txt))						\
+		return PTR_ERR(txt);					\
+	memcpy_fromio(&reg_value, txt + offset, sizeof(u##size));	\
+	iounmap(txt);							\
+	snprintf(msg_buffer, msg_size, fmt, reg_value);			\
+	return simple_read_from_buffer(buf, read_len, read_offset,	\
+			&msg_buffer, msg_size);				\
+}
+
+DECLARE_TXT_PUB_READ_U(8, "%#04x\n", 6);
+DECLARE_TXT_PUB_READ_U(32, "%#010x\n", 12);
+DECLARE_TXT_PUB_READ_U(64, "%#018llx\n", 20);
+
+#define DECLARE_TXT_FOPS(reg_name, reg_offset, reg_size)		\
+static ssize_t txt_##reg_name##_read(struct file *flip,			\
+		char __user *buf, size_t read_len, loff_t *read_offset)	\
+{									\
+	return txt_pub_read_u##reg_size(reg_offset, read_offset,	\
+			read_len, buf);					\
+}									\
+static const struct file_operations reg_name##_ops = {			\
+	.read = txt_##reg_name##_read,					\
+}
+
+DECLARE_TXT_FOPS(sts, TXT_CR_STS, 64);
+DECLARE_TXT_FOPS(ests, TXT_CR_ESTS, 8);
+DECLARE_TXT_FOPS(errorcode, TXT_CR_ERRORCODE, 32);
+DECLARE_TXT_FOPS(didvid, TXT_CR_DIDVID, 64);
+DECLARE_TXT_FOPS(e2sts, TXT_CR_E2STS, 64);
+DECLARE_TXT_FOPS(ver_emif, TXT_CR_VER_EMIF, 32);
+DECLARE_TXT_FOPS(scratchpad, TXT_CR_SCRATCHPAD, 64);
+
+/*
+ * Securityfs exposure
+ */
+struct memfile {
+	char *name;
+	void *addr;
+	size_t size;
+};
+
+static struct memfile sl_evtlog = {"eventlog", 0, 0};
+static void *txt_heap;
+static struct txt_heap_event_log_pointer2_1_element __iomem *evtlog20;
+static DEFINE_MUTEX(sl_evt_log_mutex);
+
+static ssize_t sl_evtlog_read(struct file *file, char __user *buf,
+			      size_t count, loff_t *pos)
+{
+	ssize_t size;
+
+	if (!sl_evtlog.addr)
+		return 0;
+
+	mutex_lock(&sl_evt_log_mutex);
+	size = simple_read_from_buffer(buf, count, pos, sl_evtlog.addr,
+				       sl_evtlog.size);
+	mutex_unlock(&sl_evt_log_mutex);
+
+	return size;
+}
+
+static ssize_t sl_evtlog_write(struct file *file, const char __user *buf,
+				size_t datalen, loff_t *ppos)
+{
+	char *data;
+	ssize_t result;
+
+	if (!sl_evtlog.addr)
+		return 0;
+
+	/* No partial writes. */
+	result = -EINVAL;
+	if (*ppos != 0)
+		goto out;
+
+	data = memdup_user(buf, datalen);
+	if (IS_ERR(data)) {
+		result = PTR_ERR(data);
+		goto out;
+	}
+
+	mutex_lock(&sl_evt_log_mutex);
+	if (evtlog20)
+		result = tpm20_log_event(evtlog20, sl_evtlog.addr,
+					 sl_evtlog.size, datalen, data);
+	else
+		result = tpm12_log_event(sl_evtlog.addr, sl_evtlog.size,
+					 datalen, data);
+	mutex_unlock(&sl_evt_log_mutex);
+
+	kfree(data);
+out:
+	return result;
+}
+
+static const struct file_operations sl_evtlog_ops = {
+	.read = sl_evtlog_read,
+	.write = sl_evtlog_write,
+	.llseek	= default_llseek,
+};
+
+static struct dentry *fs_entries[SL_FS_ENTRIES];
+
+struct sfs_file {
+	int parent;
+	const char *name;
+	const struct file_operations *fops;
+};
+
+static const struct sfs_file sl_files[] = {
+	{ SL_TXT_DIR_ENTRY, "sts", &sts_ops },
+	{ SL_TXT_DIR_ENTRY, "ests", &ests_ops },
+	{ SL_TXT_DIR_ENTRY, "errorcode", &errorcode_ops },
+	{ SL_TXT_DIR_ENTRY, "didvid", &didvid_ops },
+	{ SL_TXT_DIR_ENTRY, "ver_emif", &ver_emif_ops },
+	{ SL_TXT_DIR_ENTRY, "scratchpad", &scratchpad_ops },
+	{ SL_TXT_DIR_ENTRY, "e2sts", &e2sts_ops }
+};
+
+static int sl_create_file(int entry, int parent, const char *name,
+			  const struct file_operations *ops)
+{
+	if (entry < 0 || entry > SL_TXT_DIR_ENTRY)
+		return -EINVAL;
+	fs_entries[entry] =
+		 securityfs_create_file(name, 0440,
+					fs_entries[parent], NULL, ops);
+	if (IS_ERR(fs_entries[entry])) {
+		pr_err("Error creating securityfs %s file\n", name);
+		return PTR_ERR(fs_entries[entry]);
+	}
+	return 0;
+}
+
+static long slaunch_expose_securityfs(void)
+{
+	long ret = 0;
+	int i = 0;
+
+	fs_entries[SL_ROOT_DIR_ENTRY] = securityfs_create_dir("slaunch", NULL);
+	if (IS_ERR(fs_entries[SL_ROOT_DIR_ENTRY])) {
+		pr_err("Error creating securityfs slaunch root directory\n");
+		ret = PTR_ERR(fs_entries[SL_ROOT_DIR_ENTRY]);
+		goto err;
+	}
+
+	if (slaunch_get_flags() & SL_FLAG_ARCH_TXT) {
+		fs_entries[SL_TXT_DIR_ENTRY] =
+			securityfs_create_dir("txt",
+					      fs_entries[SL_ROOT_DIR_ENTRY]);
+		if (IS_ERR(fs_entries[SL_TXT_DIR_ENTRY])) {
+			pr_err("Error creating securityfs txt directory\n");
+			ret = PTR_ERR(fs_entries[SL_TXT_DIR_ENTRY]);
+			goto err_dir;
+		}
+
+		for (i = 0; i < SL_TXT_ENTRY_COUNT; i++) {
+			ret = sl_create_file(SL_TXT_FILE_FIRST - i,
+					     sl_files[i].parent, sl_files[i].name,
+					     sl_files[i].fops);
+			if (ret)
+				goto err_dir;
+		}
+	}
+
+	if (sl_evtlog.addr > 0) {
+		ret = sl_create_file(0, SL_ROOT_DIR_ENTRY, sl_evtlog.name,
+				     &sl_evtlog_ops);
+		if (ret)
+			goto err_dir;
+	}
+
+	return 0;
+
+err_dir:
+	for (i = 0; i <= SL_ROOT_DIR_ENTRY; i++)
+		securityfs_remove(fs_entries[i]);
+err:
+	return ret;
+}
+
+static void slaunch_teardown_securityfs(void)
+{
+	int i;
+
+	for (i = 0; i < SL_FS_ENTRIES; i++)
+		securityfs_remove(fs_entries[i]);
+
+	if (slaunch_get_flags() & SL_FLAG_ARCH_TXT) {
+		if (sl_evtlog.addr) {
+			memunmap(sl_evtlog.addr);
+			sl_evtlog.addr = NULL;
+		}
+		sl_evtlog.size = 0;
+		if (txt_heap) {
+			memunmap(txt_heap);
+			txt_heap = NULL;
+		}
+	}
+}
+
+static void slaunch_intel_evtlog(void __iomem *txt)
+{
+	struct txt_os_mle_data *params;
+	void *os_sinit_data;
+	u64 base, size;
+
+	memcpy_fromio(&base, txt + TXT_CR_HEAP_BASE, sizeof(base));
+	memcpy_fromio(&size, txt + TXT_CR_HEAP_SIZE, sizeof(size));
+
+	/* now map TXT heap */
+	txt_heap = memremap(base, size, MEMREMAP_WB);
+	if (!txt_heap)
+		slaunch_txt_reset(txt,
+			"Error failed to memremap TXT heap\n",
+			SL_ERROR_HEAP_MAP);
+
+	params = (struct txt_os_mle_data *)txt_os_mle_data_start(txt_heap);
+
+	sl_evtlog.size = params->evtlog_size;
+	sl_evtlog.addr = memremap(params->evtlog_addr, params->evtlog_size,
+				  MEMREMAP_WB);
+	if (!sl_evtlog.addr)
+		slaunch_txt_reset(txt,
+			"Error failed to memremap TPM event log\n",
+			SL_ERROR_EVENTLOG_MAP);
+
+	/* Determine if this is TPM 1.2 or 2.0 event log */
+	if (memcmp(sl_evtlog.addr + sizeof(struct tcg_pcr_event),
+		    TCG_SPECID_SIG, sizeof(TCG_SPECID_SIG)))
+		return; /* looks like it is not 2.0 */
+
+	/* For TPM 2.0 logs, the extended heap element must be located */
+	os_sinit_data = txt_os_sinit_data_start(txt_heap);
+
+	evtlog20 = tpm20_find_log2_1_element(os_sinit_data);
+
+	/*
+	 * If this fails, things are in really bad shape. Any attempt to write
+	 * events to the log will fail.
+	 */
+	if (!evtlog20)
+		slaunch_txt_reset(txt,
+			"Error failed to find TPM20 event log element\n",
+			SL_ERROR_TPM_INVALID_LOG20);
+}
+
+static void slaunch_tpm20_extend_event(struct tpm_chip *tpm, void __iomem *txt,
+				       struct tcg_pcr_event2_head *event)
+{
+	struct tpm_digest *digests;
+	u16 *alg_id_field = (u16 *)((u8 *)event +
+				    sizeof(struct tcg_pcr_event2_head));
+	u8 *dptr;
+	int ret;
+	u32 i, j;
+
+	digests = kcalloc(tpm->nr_allocated_banks, sizeof(*digests),
+			  GFP_KERNEL);
+	if (!digests)
+		slaunch_txt_reset(txt,
+			"Failed to allocate array of digests\n",
+			SL_ERROR_GENERIC);
+
+	for (i = 0; i < tpm->nr_allocated_banks; i++)
+		digests[i].alg_id = tpm->allocated_banks[i].alg_id;
+
+
+	/* Early SL code ensured there was a max count of 2 digests */
+	for (i = 0; i < event->count; i++) {
+		dptr = (u8 *)alg_id_field + sizeof(u16);
+
+		for (j = 0; j < tpm->nr_allocated_banks; j++) {
+			if (digests[j].alg_id != *alg_id_field)
+				continue;
+
+			switch (digests[j].alg_id) {
+			case TPM_ALG_SHA256:
+				memcpy(&digests[j].digest[0], dptr,
+				       SHA256_DIGEST_SIZE);
+				alg_id_field = (u16 *)((u8 *)alg_id_field +
+					SHA256_DIGEST_SIZE + sizeof(u16));
+				break;
+			case TPM_ALG_SHA1:
+				memcpy(&digests[j].digest[0], dptr,
+				       SHA1_DIGEST_SIZE);
+				alg_id_field = (u16 *)((u8 *)alg_id_field +
+					SHA1_DIGEST_SIZE + sizeof(u16));
+				break;
+			default:
+				;
+			}
+		}
+	}
+
+	ret = tpm_pcr_extend(tpm, event->pcr_idx, digests);
+	if (ret) {
+		pr_err("Error extending TPM20 PCR, result: %d\n", ret);
+		slaunch_txt_reset(txt,
+			"Failed to extend TPM20 PCR\n",
+			SL_ERROR_TPM_EXTEND);
+	}
+
+	kfree(digests);
+}
+
+static void slaunch_tpm20_extend(struct tpm_chip *tpm, void __iomem *txt)
+{
+	struct tcg_pcr_event *event_header =
+		(struct tcg_pcr_event *)(sl_evtlog.addr +
+					 evtlog20->first_record_offset);
+	/* Skip first TPM 1.2 event to get to first TPM 2.0 event */
+	struct tcg_pcr_event2_head *event =
+		(struct tcg_pcr_event2_head *)((u8 *)event_header +
+					       sizeof(struct tcg_pcr_event) +
+					       event_header->event_size);
+	int start = 0, end = 0, size;
+
+	while ((void  *)event < sl_evtlog.addr + evtlog20->next_record_offset) {
+		size = __calc_tpm2_event_size(event, event_header, false);
+		if (!size)
+			slaunch_txt_reset(txt,
+				"TPM20 invalid event in event log\n",
+				SL_ERROR_TPM_INVALID_EVENT);
+
+		/*
+		 * Marker events indicate where the Secure Launch early stub
+		 * started and ended adding post launch events.
+		 */
+		if (event->event_type == TXT_EVTYPE_SLAUNCH_END) {
+			end = 1;
+			break;
+		} else if (event->event_type == TXT_EVTYPE_SLAUNCH_START) {
+			start = 1;
+			goto next;
+		}
+
+		if (start)
+			slaunch_tpm20_extend_event(tpm, txt, event);
+
+next:
+		event = (struct tcg_pcr_event2_head *)((u8 *)event + size);
+	}
+
+	if (!start || !end)
+		slaunch_txt_reset(txt,
+			"Missing start or end events for extending TPM20 PCRs\n",
+			SL_ERROR_TPM_EXTEND);
+}
+
+static void slaunch_tpm12_extend(struct tpm_chip *tpm, void __iomem *txt)
+{
+	struct tpm12_event_log_header *event_header =
+		(struct tpm12_event_log_header *)sl_evtlog.addr;
+	struct tcg_pcr_event *event =
+		(struct tcg_pcr_event *)((u8 *)event_header +
+				sizeof(struct tpm12_event_log_header));
+	struct tpm_digest digest;
+	int start = 0, end = 0, size, ret;
+
+	while ((void  *)event < sl_evtlog.addr + event_header->next_event_offset) {
+		size = sizeof(struct tcg_pcr_event) + event->event_size;
+
+		/*
+		 * Marker events indicate where the Secure Launch early stub
+		 * started and ended adding post launch events.
+		 */
+		if (event->event_type == TXT_EVTYPE_SLAUNCH_END) {
+			end = 1;
+			break;
+		} else if (event->event_type == TXT_EVTYPE_SLAUNCH_START) {
+			start = 1;
+			goto next;
+		}
+
+		if (start) {
+			memset(&digest.digest[0], 0, TPM_MAX_DIGEST_SIZE);
+			digest.alg_id = TPM_ALG_SHA1;
+			memcpy(&digest.digest[0], &event->digest[0],
+			       SHA1_DIGEST_SIZE);
+
+			ret = tpm_pcr_extend(tpm, event->pcr_idx, &digest);
+			if (ret) {
+				pr_err("Error extending TPM12 PCR, result: %d\n", ret);
+				slaunch_txt_reset(txt,
+					"Failed to extend TPM12 PCR\n",
+					SL_ERROR_TPM_EXTEND);
+			}
+		}
+
+next:
+		event = (struct tcg_pcr_event *)((u8 *)event + size);
+	}
+
+	if (!start || !end)
+		slaunch_txt_reset(txt,
+			"Missing start or end events for extending TPM12 PCRs\n",
+			SL_ERROR_TPM_EXTEND);
+}
+
+static void slaunch_pcr_extend(void __iomem *txt)
+{
+	struct tpm_chip *tpm;
+
+	tpm = tpm_default_chip();
+	if (!tpm)
+		slaunch_txt_reset(txt,
+			"Could not get default TPM chip\n",
+			SL_ERROR_TPM_INIT);
+	if (evtlog20)
+		slaunch_tpm20_extend(tpm, txt);
+	else
+		slaunch_tpm12_extend(tpm, txt);
+}
+
+static int __init slaunch_module_init(void)
+{
+	void __iomem *txt;
+
+	/* Check to see if Secure Launch happened */
+	if ((slaunch_get_flags() & (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)) !=
+	    (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT))
+		return 0;
+
+	txt = ioremap(TXT_PRIV_CONFIG_REGS_BASE, TXT_NR_CONFIG_PAGES *
+		      PAGE_SIZE);
+	if (!txt)
+		panic("Error ioremap of TXT priv registers\n");
+
+	/* Only Intel TXT is supported at this point */
+	slaunch_intel_evtlog(txt);
+
+	slaunch_pcr_extend(txt);
+
+	iounmap(txt);
+
+	return slaunch_expose_securityfs();
+}
+
+static void __exit slaunch_module_exit(void)
+{
+	slaunch_teardown_securityfs();
+}
+
+late_initcall(slaunch_module_init);
+
+__exitcall(slaunch_module_exit);
-- 
1.8.3.1

