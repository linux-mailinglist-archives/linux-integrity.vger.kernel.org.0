Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73FDF3F99CA
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Aug 2021 15:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245279AbhH0NWU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 Aug 2021 09:22:20 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:32776 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245220AbhH0NWG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Aug 2021 09:22:06 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17RC80Kb015347;
        Fri, 27 Aug 2021 13:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=lFXvnaXAliVEKN00J6JGw6FZ2uC45ziffS62j09NnHA=;
 b=eybtURGTmBWV+Fuu3+soQtebWWwBy1wnvyzlqGzF9Cx5ICOXlRvJhiv1zOvvjJ5JCN1g
 +c1wKI0XhXb6CJs6kh6rvnvVEoQ2+wjd0NvfY3BjwIRGXZlh1TEr20xrHJB5MgRUc391
 iAcf89U6MUR+qUvDHiJueyvqP4XpziWhkVvxmN0xypJv/XcATU0somsBdMdPZ/2Ai21e
 wc/1u3Py8qArJ4wDo/sbTcOOOCqlKMqA0Zi15m4JzL2KFHfjfDS4ok6uWJ1w2xdmVxbn
 TQXZP2oBFCJ8jVwG4vhzwZTPLJHGPCchx40TX10OHNjrOE7meMaGz9T2Tn98f6kbbUyA gQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=lFXvnaXAliVEKN00J6JGw6FZ2uC45ziffS62j09NnHA=;
 b=bNzk/CK7Y1r3qWO+Un5i9d6rjxCPE9HCRPTEMeQdGDBXKRHgQU+ZnQKQ0jxQsexUWqrw
 Qy03HsoOEp9DayzgrtoINAtUODRqjSeVrIvqTqGxop41JUSR5W2RcwTEpVbE307Ssp0L
 EDazArM48Pot37D1p6Pnn6T6JScpyvSilJG8Pj8A894Y+JQVQlb9kt1HYOzmdYWs+toS
 cT7xi7EhohpFR2GHMpWi4og3sAEsqgLfNRXkkD6C7ROj/2fAMdAbUGke3ZRUWLwdM6jW
 ov+Xzm8nfbeUuHKLEvBbvBd+Ef/L+svG6kxS2HSg3iTdkMiXNEzULFJ7U5JeDWE9KfD+ vw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3apvjr0kue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 13:21:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17RDBeGT013130;
        Fri, 27 Aug 2021 13:21:01 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2040.outbound.protection.outlook.com [104.47.51.40])
        by userp3020.oracle.com with ESMTP id 3akb924gn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 13:21:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7lZepQVcRpXZa8Bk9qkcX9gXHeo9LoCZ6IZVmiGVzkX0gR0ZspZkd1jSnYLtYVKa4exDv1FTmkm9eqEIns64I2xyT70JJCpxWfzdc0/Z/Q12iKhKVoOpFcbr82YVOZ+MN8CPpXRcEm3CM2Ewy9FXJY8u0m4/9G1YS1Krv7jnyf1SnxR5JJJSyhFgNlFwinDTMNVrH6Lvy5f43I3r8cAbQFiwRCOmFDraf2uPNMNT/kcBHxrFI0Y/fuWQvbsRSxB7mUYwPq+5fnZAGxSHNqvP3BzbS0eoIp4hRoZ7o7c6CdQIVrNhCYlPtw1Kz76xlNu+XAOq0uMCqX7XK98FoZcZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFXvnaXAliVEKN00J6JGw6FZ2uC45ziffS62j09NnHA=;
 b=e05sMUC43/7E10VKPj2TeC17MZk/acvyzJP0v/YftlGFGAVi2NyH2s5Lt9VgWgj/GyT9k3Qu7O+aSEy1186Bu3cTtW7lxAoKA7jtKBVoCuUrojDxpiqeJNVhy6jmAz+OF+T9oU/XNYvZLU65fIg1HCCfqzHowjeGeoKdcE7YB7KS6CzjiKG+oRPNTpPjT3VsOavkUdGgPaUdHvdwAbA2l08umEDtkcIOq5VGcrcW2bQRax0pwLFxUSPdKynHK3fSnlu2nhtXoyOGsYn8ioQxjvOcBwmjWLxOjFBR37z1mSNDhmy3A8hn1TiX31kWZA3omsDBqG6SIUbOaTsdhg2KZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFXvnaXAliVEKN00J6JGw6FZ2uC45ziffS62j09NnHA=;
 b=ewc9LLRNZMBENnXbFszpxa7/0BJ68dVbf5MvKBJAQPV8goKLQqBpxPhUXEAYLb0Mm79aqCTD6GRLMmTITdB5hKHzrQXEZ5D0LC8iBOvsmOfioqCpraTkdlAOgdTUFzxydsp0RebheAU9be6F5aPSRfuFc5j5v/DOtrvq0MIQ7wo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BYAPR10MB3237.namprd10.prod.outlook.com (2603:10b6:a03:153::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.23; Fri, 27 Aug
 2021 13:20:59 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3%4]) with mapi id 15.20.4457.020; Fri, 27 Aug 2021
 13:20:59 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v4 13/14] x86: Secure Launch late initcall platform module
Date:   Fri, 27 Aug 2021 09:28:36 -0400
Message-Id: <1630070917-9896-14-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
References: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:805:de::24) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lateralus.us.oracle.com (209.17.40.45) by SN6PR05CA0011.namprd05.prod.outlook.com (2603:10b6:805:de::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.8 via Frontend Transport; Fri, 27 Aug 2021 13:20:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9afda798-cae3-4923-4495-08d9695d823b
X-MS-TrafficTypeDiagnostic: BYAPR10MB3237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB323782DEC40D8A99924C232CE6C89@BYAPR10MB3237.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s0EY+afZOX/1DXZdOca+AWMA9w6DuD/9Gfu2kEiXzewOAdl5abmn9gr4hrQ4XbYYYE2Npm3FcthfcqVeXxvd1api5e33yIg+IDAUFI6YkTfOWnH0gFTdOpqa5kiu7LwdVnDfmcs+T9Jf0GMZo4NZgNMkBBeUISI8Y4ltwxj3UF0+irbKmphfACypxbngGMFBmphD7i7YXKr9REKZdKOtwzG63NcAHJ97gOTlPiepdrMNArba9etTQOPcROP+ZvsoAONb4uuVnFiAbb/GalqKy7yxmrqZeDDOwmCgWy7SDb4Teq/EYpvE+vQo7Qg0tpGavCXfqxyLm6ys2+l4zf3UYvG9SRPNeX+HetoYZNCLoVBv+CIptn3FyNOLPjheHDNnuLrXPGF2b9rn5MNDMA0TPFDs6FMHPilH6i2hTuxlPpGVfIWhRhjJKtxWwcBvE3VJBQ3QZXzwD9PabTkzdbgytduxmuQoXF4GKeT9X18fSQ7FGrkutsW/cg1Mlv3bl4qww4ejGZ63aQU2DApF6uD60sbHlTqcRsvzBym6Q/5y6MkuSzwiwxh11Jo2kVdKmIjiffe3pp6rMbGc9JbUT7W/bfiTAeBS5SulWyVb99zuTNOJ/agDsFizWhRTbHryfSbu1RKOu5XG4SjJW44LHRSp3TbwxFoiYZAxfT8UozN1syvTs2nyFzYFOcvQrD1XX7ExBd0HSzu65o/ILXzNpB//Wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(346002)(376002)(396003)(956004)(44832011)(2616005)(30864003)(2906002)(52116002)(26005)(7696005)(478600001)(38350700002)(38100700002)(6486002)(36756003)(186003)(83380400001)(6666004)(86362001)(8936002)(8676002)(316002)(66946007)(66556008)(4326008)(66476007)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yu4WRt8XumkJGWrF9sS3eB142Di1LJe0CxpY5j1D/YAxoQlUSs1DaY8Z6Qcr?=
 =?us-ascii?Q?gzJ21ROFDpNAnGZ0ukm+L1ZQyTFo+jKAzZETbaVrLtcvwrtcJC9gsBLAQtQt?=
 =?us-ascii?Q?NyUMpY31cImGgJnZoNkRtXeSfhfYjIX7H0WL592wAVBnThdbNhHHQ6vqum8Q?=
 =?us-ascii?Q?nycIZ5KihPyLEKswV7wJvB1A8vkN2RcsjTVKOqALOMzR8ifGSPHq/0f+VPhl?=
 =?us-ascii?Q?xvrT4esB9RYb1ezWZvOEQ6Mje8fkAoZN30RwNVpdFtsZlDes+J4O30+Slf1K?=
 =?us-ascii?Q?wEXB64lFuRGgr9qsNwibSl4P9bHK61xt/Xi0Y8uBWldjnDlrDlKQRPpvo7zK?=
 =?us-ascii?Q?+9suOdmeoqnh8zUKnn/3nTuIyCh/vrjraPh7ayR/tp+ESfhsiMr1DgyySPHr?=
 =?us-ascii?Q?H89hmkwdP2PTgyv51efFVJB5RfsXQKdRE4wV0WfJsSw+V1IqzIRVlI+rDeHc?=
 =?us-ascii?Q?VPe9NKXNmdrqvaTmAevikQ0Naim6eXA0NCszOhdzia7yh7XaKpC8YkPbXm1t?=
 =?us-ascii?Q?bqnuoIjIsl9LoS/nsDtgJMPzZvzZHM2xJLOEXExdwYPNFFraAKWZyurycFG7?=
 =?us-ascii?Q?CiPOttTSyqwYRlI31fnyg/GxBcA6C4XhbwdAX10FHGUkDqbxRhUIi8AHKUyI?=
 =?us-ascii?Q?LwyuQFIrQjEYqGg2wAItRVhWyUBdb3QXbJa/VAX9MpRYm1ID1qbotJVu1k2y?=
 =?us-ascii?Q?r36NplAJ7BTXKmzdYW/FGV9K/Uqi1fVpzVNYYpfrDGNcLVyJO+sXf1bFeA/R?=
 =?us-ascii?Q?4QQUeRr4w8wW5kX9MMrOTQnPVw5LLqNDXa2LOZki0pUVGWecjmaA1N7rrO62?=
 =?us-ascii?Q?xfo8huwu633nmRkN5EM6JAR6SniMV+khX+5eVJvTG3ksa4jDoBqHWt8PLFEd?=
 =?us-ascii?Q?ONYLSmJ71uyTYpVySQ+bsQpXpiZEJh2dipOnPGejFB11PPfSmQOeND2D6kt3?=
 =?us-ascii?Q?4xXNxDINHi+8jAbsss7glSlr5TNWtQZJptnxOiOePSjEbSntbXpFG7FuLw1i?=
 =?us-ascii?Q?62LDBJam7PvjC44GTx7AOfbeNdCXNfeqpCUZE2NzBv0eL5BLbQInMu5IC7Vf?=
 =?us-ascii?Q?DJ1V4JOnx48/0kaoG7vBGCa4YrewU6bLZ4SaAu0Lw4rQ7iqPxIEl4c1BF/UF?=
 =?us-ascii?Q?v5vghANIRXfQ+sUSi4m3r0MuTfUWl1oflhdB39UpoNvMVGhgWCLNtk7+AKHd?=
 =?us-ascii?Q?Yv1g/flq3DbMJKgRBTmho8otUpAu6tMH6Y26y86vOyW55LXDVcYQhB/gw7+m?=
 =?us-ascii?Q?l2TyD7TConN196IWQPwykBX7SJ5fOxrhfgc7hTFv0B/koX1E5ysXiOKs3rz1?=
 =?us-ascii?Q?zVJm/DNgu/rKLBL9lk3n4o0A?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9afda798-cae3-4923-4495-08d9695d823b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 13:20:58.8712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AqoCfE6/sOJZ+OWTqdOo6amqIbUWi+BHAtTQeexIr2gBZ6Yh23YCcKB8gbmbdXoESPMQRtr91QT9iW4O/G8e6Nr3gGmSpQjgSc7QoDCqvE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3237
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10088 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108270086
X-Proofpoint-GUID: vEG0ghAhCIDfoNNA2uDJ78B-8E1G0Ble
X-Proofpoint-ORIG-GUID: vEG0ghAhCIDfoNNA2uDJ78B-8E1G0Ble
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
 arch/x86/kernel/slmodule.c | 494 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 495 insertions(+)
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
index 0000000..bad50f0a
--- /dev/null
+++ b/arch/x86/kernel/slmodule.c
@@ -0,0 +1,494 @@
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
+			default:
+				break;
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

