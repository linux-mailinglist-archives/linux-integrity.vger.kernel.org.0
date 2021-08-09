Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711133E49EE
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Aug 2021 18:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbhHIQcG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Aug 2021 12:32:06 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:7502 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233024AbhHIQbu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Aug 2021 12:31:50 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179GCTIO013086;
        Mon, 9 Aug 2021 16:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=uaDB31GsdQ6QYX6kwRtBtlkYbBLv8Aw3ThMjsV2imfI=;
 b=UN4C/ZorrWOxWvm0xdu70Na6S02HCYd1Ucq4VulheXGHskOgPswWCRYbxUW8Zp6+xtef
 8E36Akivi1MgwBnNvdms0MCVfESbee4rBjxakeXb/F365DqieTjIjqsB3VyfSA+2Fcca
 k/YZtNYEAtPzDUiUqgrb/MBngtr5OGHsCLKdT8+82TR7k4L9UotTHwO+SLSbJA1bZc2C
 R9dghWSm45ZYfV0cMm1jWnVu/luqc0W+0aseOmRYBThWAsNYB2kCO4z2l5pUj9VXaJcY
 esz/s3u2DXng8Ikbfgh5/7a2fDsDEO8rxpo+H8SZ8t0rU1Q0wVEshQ0JWJYNWnkzYznt Qw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=uaDB31GsdQ6QYX6kwRtBtlkYbBLv8Aw3ThMjsV2imfI=;
 b=mj41XRQSOVF5Xy+fw9GSMJ15xr7LzrnbmlZV9t1/8My5cey5rz92EJvRh1gOWbWZJN6P
 O3xmozlR9vyXICo5QHJLnI+VyMGnLMuKIy0JNBT1HYov088TwqhKydrqGtxk40KZnccR
 xPblagemrajn1yg5YWrvtNdnfqE1DEj2S8ybqUkndoNqM8IFoeppKGKeJk1ipu6KCa7p
 jDX5jJS+PBSkkBlB2r8uqVi/1kRpYU+2UfZ5wlkqpjHZFDN4eHf7MCHRHVdrGZM73K2M
 qFYPL2pBHPffH8sRIMmUwAQaBOH3RVwjl3CYdWsmARhO5zYh23f0PBq9wEKJs8nSfCxq SA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ab17ds2f3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 16:31:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 179GUa1G066307;
        Mon, 9 Aug 2021 16:31:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by aserp3020.oracle.com with ESMTP id 3a9vv385x7-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 16:31:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nO9PqR7pTRLDOkGrCJXno/jyA+JqyN2/k5rCT4/KvD6WDxcZ/eGIt5FEMxvU3CODiiTXD3PE9G8TlpjY+zVwGzuDNON76c2R1uX+wk7LDM4nEjsNJuNl+6bFPmdxzeFsdkU9Kjg81nvtZj7bGGd7k3OTTaCXG2N7do27k5R7PA360bFwqJvFmJIGwQvq0odcM46TK0PseDc2Ao1nTVYRyf0qmstjIIXPaoBVUt+Kky/Fvm9xAfB3ZnU2cwm3DeI+TrX/4btApKZlR17OuWIzg4jpxDqcsr7KJJNdpyVUZDe7TkuxHzm6Y7WmIK3WQYP1Qv5OjXowlls+io0VuFmZdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaDB31GsdQ6QYX6kwRtBtlkYbBLv8Aw3ThMjsV2imfI=;
 b=HvzEg3UcBmMIT29k81JdR632/49jsk85iNHdDvxF2GUF+lUDyxEMywM+8AVD7mzDo64UPo2KnUoQI4fXRVCIhbweROKtaIlizuafNENUZthXMtu/vYI1NER0LF5C75fgNb/PfNkdzy5DYMCmcxO91HiaaIvYU0yxNqsJJP4vERc2qLMid9OO2RsDsiJw63WxjXcrVqM+4xAywubJrGnbXt24Xtrd6rjdvafpvZhc9gL1ss3skBemAGuewx9RcPfurY4u7k2hwfQlgSTlJfoxwAMIHTsn3c1LsSsur3RlSLPa7MbbKuQXNp+YF6r37JBRnM4HFPhkJU6jujJqixp1HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaDB31GsdQ6QYX6kwRtBtlkYbBLv8Aw3ThMjsV2imfI=;
 b=ykPce/oh4q+gwQ4RLzccODmTwCkjXMFxBanLuqukrfmJarJ5ApAvHFmgcqGdnj7D+NIDsThjWWS6mWddD4gmsgrwPbQ3hAecPxjnCP2qrfqmaljVKvEip4wXXLRmK/lH8JmC33cuwydl0AuThi44NAOBgymPud8W7a6wE+oB47o=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BYAPR10MB2631.namprd10.prod.outlook.com (2603:10b6:a02:ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Mon, 9 Aug
 2021 16:30:44 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3%4]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 16:30:44 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v3 03/14] x86/boot: Place kernel_info at a fixed offset
Date:   Mon,  9 Aug 2021 12:38:45 -0400
Message-Id: <1628527136-2478-4-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1628527136-2478-1-git-send-email-ross.philipson@oracle.com>
References: <1628527136-2478-1-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:806:a7::26) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lateralus.us.oracle.com (209.17.40.43) by SA9PR10CA0021.namprd10.prod.outlook.com (2603:10b6:806:a7::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Mon, 9 Aug 2021 16:30:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce312637-9e76-4105-82db-08d95b530946
X-MS-TrafficTypeDiagnostic: BYAPR10MB2631:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB2631BB9E09E0B64B8B9B0F0FE6F69@BYAPR10MB2631.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YEiEnt4+wnqwsoqhZVUFcania1G/7dTpTkvBiY5TWxFv+VQ2MgkbBoAhOcRWx72wYMvPbedZVC6QIi8HtaEJ/3vqp1NsDdypQJtZv3jNlcyCBaiwmd32aTNDDiLAmxOnt3FziOnWorHO8Iz7fvQWT/OZo3doqXXHyyhLs8IQbm05tQzI+Dy5zlW1RFEF8wGjhyDcl4/+KIy8xdEnfgciiRUur95g/AgIaSYyX1dS+S/X2m4WnPG1JiVdtoqcrW/xH+z9k1RihfbA7zpxe02vAEdCrYpHei3JxF9nSxA1wGs8xyfyExRE2smOtHx2rwcf0Y/cVXKOTIcdIuIkhLmOfgYNih7yNitQ6fZsw/U/Yu7qpI/D0FSHO8AXazXyut17q9Dh7tNZLt2XSEOR8DN2RPV+qnazCI0XDV+EUDatBVye/mhrWdqyktvsGMymK2F8ZOgocllpzMzyFIjIn/4nLIrz9dv7vc6woJ9HZ9Y/+LNTe2Jz9Bs9ofH4SbLiwT09H79/ZCam5gaRgeIkYvnoFGmcWV0vaNRmvJIfVZkicZhM/9c45DXXdXrt/TNto4r+WFp53O4f1tGVwh82vQGVoYCf+YngrSHLmdF3Fg9gioe4jrlaPG6d1d9gtcrWYbAU1/CmDv21FFiGi2DSafBEsCYC2hANoMdqU1NHNrKj+Yfau7qDLACBOyW7h/I1Khy04+2V18QyOKA2+jM0CgDNGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(376002)(346002)(366004)(4326008)(7416002)(6486002)(36756003)(8936002)(478600001)(26005)(2906002)(7696005)(52116002)(8676002)(186003)(38350700002)(38100700002)(66556008)(83380400001)(66946007)(5660300002)(956004)(66476007)(2616005)(86362001)(44832011)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7dfHzeWDg4FYtE7MlzPk6TPimfp4CNOSTYxFJr+XRnoi08Whn83NxiIQIvPz?=
 =?us-ascii?Q?YilcQz/PgSqHIUyDUUC0PUdMOQyorFN1bjsxxSHAbUP1PXxAMspV1VE/S5rp?=
 =?us-ascii?Q?HThSE+ln6IOLP9Za3Uok/WUzhNr14kX879rsLS8B5EYjpZ5RZHUJ5ngz2dm1?=
 =?us-ascii?Q?xq659xJFhBSZf04TXCZktdAN2hPTKmonE0oxfg0vtwdAWlhdBfJ04r0HLdTu?=
 =?us-ascii?Q?cjvavwAZWn4PnT1P13EYQnwNTV0CQvHUs8aUwxmZbP4utmdoHs1BmCwZsTZ7?=
 =?us-ascii?Q?RnB+qnfBIlzYfzbjpeEE/jxQnA4rs97kqT8TYlZT2S3VdJHDour82Q4XMgNa?=
 =?us-ascii?Q?Pkhy8TY/Nsxy1D+cUgHx+elsTr9oXznui7YHxooHEVYdFSITx0MC1pQgylcX?=
 =?us-ascii?Q?7ea4Lo0TRwafmN8C5ifaGcJ07bcT1BA14DFMR2nHUD5t1zKgMmMrP1n+lmEx?=
 =?us-ascii?Q?i+fZA8siqdFLP8f7H8lhm7M4A3lq01eJxAd4GEeOUydfoCChQyv1lBqbrz6Z?=
 =?us-ascii?Q?Q5H1j4TUlndUTGmdrTSK+Qf5fHrK64EmB9mvhlvha2JWSnfkn/I/VDFkZV23?=
 =?us-ascii?Q?rs7JvbhM4zlbHdKWyMabDND2/nFQiXejEDk9Nd/5gowk3Ie5eO1RyM3hyIwz?=
 =?us-ascii?Q?kianibfHxaqMGXMSXxguMiH2658Rhl9Arlx4pJq8ZdwmwBoKUurlIxDgtHKx?=
 =?us-ascii?Q?zI6lqQuE4ILKn6Ga6yeP3EprIvxK/2ZYxkP/Yv7YwrnSQ36Xy215poikCnI0?=
 =?us-ascii?Q?hZ0qZ8gM7y6eeruYRuxWk9YlHFAxUfnxavU0YGjrUYl2QhySwQY2J/p983VZ?=
 =?us-ascii?Q?6gGr1uZ75qBBtHwkKxKZOPBF0rLIfszqJnTsMdEFBLfzCgo1RSSYOTgUV7Ev?=
 =?us-ascii?Q?wjMIxdZJfIU2K9ykb8FjkDX5xaEA7aTFSgTVT0aUMo+//uo+af851RccrcMS?=
 =?us-ascii?Q?l/Q1m87mq+lM6w9CvNCxj0DEkXzr7/beBJ2uPj+uTfL9hmToaD1WtHP5yvk+?=
 =?us-ascii?Q?ew+5KsVSHFGPPDajaNrGP1NKkZQJYVYYyzRMXoIo9gBHaWR9kHIaIUON9lxN?=
 =?us-ascii?Q?SJHQ4Ub1zHLPbULP3ieKvbfzqBe3LYuiL/OLEkQ7AfYMN/JASaz//kmR5jh9?=
 =?us-ascii?Q?otWWhGs45jXHRU+5o2J5dYULymDm9NsFodXW8l6Qxk/mKz5IBFFKAcPMVEXq?=
 =?us-ascii?Q?weowzyj6Qd/hyO5gk5Xnq6rsH66ElkRiAieXe4F5zKDQWe3x1+fNCmjPj0e/?=
 =?us-ascii?Q?0MFrDgMotPeC0TL6p/T0OHTyzeFacj6lKUziUml/uG5DuDjMak5XBa6itFbY?=
 =?us-ascii?Q?GxhksivVjU7BwRXjHNkME/V1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce312637-9e76-4105-82db-08d95b530946
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 16:30:44.7134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MHCXZeob+YJAn9S+hRBtR8OMuYX1qtKSdcpK+mPrrO1vqRFeVJu57NaQeHQ+JrxONu/dcRJO1B/UOhUkdmdgrzAqfHf6Io2KSSZBxXe0oRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2631
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10071 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108090119
X-Proofpoint-GUID: gmgWfc7_rk3DYu9NCFUfv9e6jwhZgBYf
X-Proofpoint-ORIG-GUID: gmgWfc7_rk3DYu9NCFUfv9e6jwhZgBYf
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

There are use cases for storing the offset of a symbol in kernel_info.
For example, the trenchboot series [0] needs to store the offset of the
Measured Launch Environment header in kernel_info.

Since commit (note: commit ID from tip/master)

  527afc212231 ("x86/boot: Check that there are no run-time relocations")

run-time relocations are not allowed in the compressed kernel, so simply
using the symbol in kernel_info, as

	.long	symbol

will cause a linker error because this is not position-independent.

With kernel_info being a separate object file and in a different section
from startup_32, there is no way to calculate the offset of a symbol
from the start of the image in a position-independent way.

To enable such use cases, put kernel_info into its own section which is
placed at a predetermined offset (KERNEL_INFO_OFFSET) via the linker
script. This will allow calculating the symbol offset in a
position-independent way, by adding the offset from the start of
kernel_info to KERNEL_INFO_OFFSET.

Ensure that kernel_info is aligned, and use the SYM_DATA.* macros
instead of bare labels. This stores the size of the kernel_info
structure in the ELF symbol table.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Ross Philipson <ross.philipson@oracle.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/boot/compressed/kernel_info.S | 19 +++++++++++++++----
 arch/x86/boot/compressed/kernel_info.h | 12 ++++++++++++
 arch/x86/boot/compressed/vmlinux.lds.S |  6 ++++++
 3 files changed, 33 insertions(+), 4 deletions(-)
 create mode 100644 arch/x86/boot/compressed/kernel_info.h

diff --git a/arch/x86/boot/compressed/kernel_info.S b/arch/x86/boot/compressed/kernel_info.S
index f818ee8..c18f071 100644
--- a/arch/x86/boot/compressed/kernel_info.S
+++ b/arch/x86/boot/compressed/kernel_info.S
@@ -1,12 +1,23 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
+#include <linux/linkage.h>
 #include <asm/bootparam.h>
+#include "kernel_info.h"
 
-	.section ".rodata.kernel_info", "a"
+/*
+ * If a field needs to hold the offset of a symbol from the start
+ * of the image, use the macro below, eg
+ *	.long	rva(symbol)
+ * This will avoid creating run-time relocations, which are not
+ * allowed in the compressed kernel.
+ */
+
+#define rva(X) (((X) - kernel_info) + KERNEL_INFO_OFFSET)
 
-	.global kernel_info
+	.section ".rodata.kernel_info", "a"
 
-kernel_info:
+	.balign	16
+SYM_DATA_START(kernel_info)
 	/* Header, Linux top (structure). */
 	.ascii	"LToP"
 	/* Size. */
@@ -19,4 +30,4 @@ kernel_info:
 
 kernel_info_var_len_data:
 	/* Empty for time being... */
-kernel_info_end:
+SYM_DATA_END_LABEL(kernel_info, SYM_L_LOCAL, kernel_info_end)
diff --git a/arch/x86/boot/compressed/kernel_info.h b/arch/x86/boot/compressed/kernel_info.h
new file mode 100644
index 0000000..c127f84
--- /dev/null
+++ b/arch/x86/boot/compressed/kernel_info.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef BOOT_COMPRESSED_KERNEL_INFO_H
+#define BOOT_COMPRESSED_KERNEL_INFO_H
+
+#ifdef CONFIG_X86_64
+#define KERNEL_INFO_OFFSET 0x500
+#else /* 32-bit */
+#define KERNEL_INFO_OFFSET 0x100
+#endif
+
+#endif /* BOOT_COMPRESSED_KERNEL_INFO_H */
diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 112b237..84c7b4d 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -7,6 +7,7 @@ OUTPUT_FORMAT(CONFIG_OUTPUT_FORMAT)
 
 #include <asm/cache.h>
 #include <asm/page_types.h>
+#include "kernel_info.h"
 
 #ifdef CONFIG_X86_64
 OUTPUT_ARCH(i386:x86-64)
@@ -27,6 +28,11 @@ SECTIONS
 		HEAD_TEXT
 		_ehead = . ;
 	}
+	.rodata.kernel_info KERNEL_INFO_OFFSET : {
+		*(.rodata.kernel_info)
+	}
+	ASSERT(ABSOLUTE(kernel_info) == KERNEL_INFO_OFFSET, "kernel_info at bad address!")
+
 	.rodata..compressed : {
 		*(.rodata..compressed)
 	}
-- 
1.8.3.1

