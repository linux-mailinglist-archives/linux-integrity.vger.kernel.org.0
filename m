Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935EF4BBCDC
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Feb 2022 17:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237438AbiBRP7b (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Feb 2022 10:59:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237350AbiBRP72 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Feb 2022 10:59:28 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCED2B31B5;
        Fri, 18 Feb 2022 07:58:56 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21IFqmO4019673;
        Fri, 18 Feb 2022 15:58:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=PhYSYYiGzkkEy0NEnav+O717IGw25CFaD6EYNcOf8JE=;
 b=NHPoLdVmA/0tw5HH3kPJz8JKXT/b5y1INRDm+mA6ldyR3Eah0zp0ZgKtNu9y6pwEwQc0
 xAlIIlUczsNKcE+nDwGmYK/FYbn6mGYQKlASnp1SQbCvvAAoNMPbQyIO2G9wbq8m1nkG
 OmLkNVEF9sQNzwS690HONxGmSXWeBmGJRmqbjDiWjQBsbtwWDTfOBqbjPhPh5DAKo8Yz
 sAsHjzIcJPiULAGx24tH7rKVI2neDjg6dY0sUMypXa181JKEJD3xd/pVVLNVWQj1xCMf
 k2QmcENaKxWxvWYznXZzxoYwg6y3gWO3ogFLqDpE3h/9CpcgNfz8PxKoGQbR5D78m22g HQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8nr9a4bs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 15:58:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21IFuYno128815;
        Fri, 18 Feb 2022 15:58:21 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by userp3020.oracle.com with ESMTP id 3e8n4xqd5g-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 15:58:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aahXvI+nw0vLcKsFRNQRJBzSibHYgYDriFsMnp9uyYcjR3AB4vpDf4Tnyoaan43au1ZKIdbgXRxzVtm20pqUuoe9aamDq/U8RTJ4gT9J9sDo3lQm+GzA8DBz3/QuJhwSbqJMH9sBWgFQC27qYR8D6IMvHMqQDKEJFtkVKYebGIwD6xoGq+6LjHfYlkWBIdjy6ADZhFzY65E8FJ3zlpLalHA0R4klrXirDKPdSPwiyI4XhGivwwGGzLvZMR/JDtgp0Vz+gyLJHX6gJNtrnI7b3sBxUOFOh9aIjOiSp5dlsZDPH5YvCWPCKvneiv49LPsKK+fx4Kkzuh5uAlILsDyaZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhYSYYiGzkkEy0NEnav+O717IGw25CFaD6EYNcOf8JE=;
 b=iclOcFOclPxYS9gVDRm8Oj4Kfgr5mK2sIPYLxV2NJ7dpa0zhVNJacpvABTTJBx5kB3WMEDqocaHLCaezP788rPrPLFWGv6j/U+mTquf1rIpvROCZq2WxrSty37AE8fNxNvy/mJgFJPZP4DBGHFGDw6S2SrYbYlqNIuznx/Ckbh9YV+2dsRGpNpE7rTABnRtJwJ02hO7Oqdw4QGp6r7tdU2BG8GoSP83wMvxu5t2+CHw/8RstIo3QpE2KlnlxQKJXw75zn+o77xWqdIanPBe0T7cYrLPY7s+dOieGKQ6DeHOQ+o0KipZU1CxpfXtW7oerpHeKhxw8X4NjfrsRFbmXGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhYSYYiGzkkEy0NEnav+O717IGw25CFaD6EYNcOf8JE=;
 b=q6kclzdqIC8SdXKnQ4+7d6EbxP+vDnqBDoNqMFScWZlMkfWPvLGFx4tht1nRd3UbLfLwx+0ghFrHLkUGihWGXQCaFkEbT3rtHDtESJw92lL3UBhzuD4Ta2BI7FyAldfkO4mRVB04R9patraObqBgNpmww6MhpCNH/9m3gmeAPnc=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BY5PR10MB4226.namprd10.prod.outlook.com (2603:10b6:a03:210::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 15:58:18 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::398e:10a4:6887:4e18]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::398e:10a4:6887:4e18%5]) with mapi id 15.20.4995.022; Fri, 18 Feb 2022
 15:58:18 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org
Cc:     iommu@lists.linux-foundation.org, ross.philipson@oracle.com,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v5 07/12] x86: Secure Launch kernel late boot stub
Date:   Wed, 16 Feb 2022 22:54:40 -0500
Message-Id: <1645070085-14255-8-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1645070085-14255-1-git-send-email-ross.philipson@oracle.com>
References: <1645070085-14255-1-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0288.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::23) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79b7a9e7-c229-4572-f7fa-08d9f2f77b19
X-MS-TrafficTypeDiagnostic: BY5PR10MB4226:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB4226B0E52ACE2F5DA5510FACE6379@BY5PR10MB4226.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CL7pU4m97/9lVkLZPr4NWRVOg9hLHt+/13bwVce5EYs20FgdpD2dMMAyQBnAbEOYH7WG0/teFPTjlnnUWi9dt++ehD7fko+pO9LSQLqYw5Ye1mSn6qKB6AHO2ROoqr/rU/2XbCvj5vm+jnD/LAAxtB7wUrhbvTl1+f6AvX4il7aHQoVjyGu+mo6yph+Qr+zpmYIbo5KVwzdGIMzyeBYtXDI4gU8oLn91PkVU1lRFTkBLy0SlSx+xHLXBV3HPcM2DJeY7fiAbMeTTOcP2Au6Cyg/U0QGadYJ5i+FOuqhABFgTFZaehV3AAdyHUteuU9nOVyD6Ncg1IdkoLEJGGAAEBEvR7imPpmAbVOBvIF8G4xRTHaRiomKOLy8j1+wkOLQle46ncnbhfgW1CETaCjt5qw+r33mxedQ6V2JtE82E4Mf4CevI95Rdi9MtP+SJneWMGqeoBpD4TWjUom1TZaWmAm9wyU9Sxj8OeKoZguIL99WnfBRk5/kGs45CRL2wk+62REM3MEsxy/o6U4L9BFvtOKv6jQqBhoq0bxTVgGBR0/yGaJKS8L/V8uk5k+EbvJQMITJTPMBmayFGGnprhr3S4+wRxXPQpreJu6eYBvucTDr0kbqEBOx2hGmcmz+wH3H7uF6qeNh+K1lRGd7WH50cmNC/J9WDSR5b1urXtA6tz7xLWD/DU7nT44K0gthApwl4t3RWeifyNJcfCjrKTXdHRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(44832011)(86362001)(5660300002)(36756003)(6666004)(7416002)(6486002)(52116002)(8936002)(83380400001)(66946007)(66476007)(316002)(2616005)(66556008)(6512007)(38350700002)(38100700002)(186003)(4326008)(30864003)(8676002)(508600001)(6506007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZoyI22um0V3iscFgAHeOu/crgVLv0nQuV8+JWrdFcfB0wjKrXYe22lSoHYs/?=
 =?us-ascii?Q?gN0JRU87ivCRaid5PbWtTzWe6qCKadYOyJe8BH+PqfpjA6GyzzEKuipGcJ8C?=
 =?us-ascii?Q?59wLnvTHneYMfg4ITuMiza/xE4BhjiFB0ScggedFPldups5/XBC7r51hD6Lj?=
 =?us-ascii?Q?VE8WF8NwqGPSPBbIqgIhAr5XndLoj+QrFPiyQdzRAy010j5kk5NkESvrNGtB?=
 =?us-ascii?Q?tj6IWxsJvzi+IR1M9IaWbEiUgBrIORzow48Mx9gaEvYzZVsgnIoNE32wzLoV?=
 =?us-ascii?Q?Vqmwncw3kfT0CePhBMLQgdH04CwkaV99dD93rSYnS0L9ZT9BFpcL6l3U7q9f?=
 =?us-ascii?Q?Wxo4oa871XVswCuKPda1LG+T1X6AjYZJk5WVj9bDp0tP8iYDzw5VfQ5EjEZG?=
 =?us-ascii?Q?43Qe9zTr5tSJApbFsn2I9LpgvY5UyEpU8AYnxdYOHFPc2EDiuBwJrFXpo5Lx?=
 =?us-ascii?Q?4amaahWonSq8IhSdUTU3lIX6XYqEo7zMI/7uAgqQDL5qbeH8asVPK+Orfxwn?=
 =?us-ascii?Q?I61Ai1tag4hAoTIQYvo2+OnVoD/fLiCSjOr+DKZVHxh/IjSoB7vqqpBEuLEL?=
 =?us-ascii?Q?/3ASSP1F6rES69mMpcJ5E9s8IJWnLUEHiAHdNinaH6r9RLpDUud+URDRAKrG?=
 =?us-ascii?Q?wWzaD1sS4xV8Egek2g5CO6YgmHMpXfEAgnA1x3lfEK8PfFssI4neqVWw6MPw?=
 =?us-ascii?Q?4WDq1KoYKGTK24ftHOEG3IWcHjHckL5HyXiKSDGERlF54CEw4S2mygiAElmv?=
 =?us-ascii?Q?6PsIqxt4GBCnV9d5/wo58gSl5hWVUCKxfacdSYCDD3xj2cPX3MJsbQ6UdFXK?=
 =?us-ascii?Q?+LdDN6ONGJ+X6VAf2JL8fsYAZBF7dfe+qvbIXKEjyqM5HQu2etTVSqD1U39B?=
 =?us-ascii?Q?Ydz8k3YBW0lf1RKGxfH9/TDsk8mC9g50wb73uN5MJ9tnulUbS/JMWaYW59vT?=
 =?us-ascii?Q?EAYUyxXA1va1I39FImVB9qRlD8HOgaFjA5rSvm6+Bj4sTZR+styoCmBNk5h8?=
 =?us-ascii?Q?mPDaaC6H4+gsv6KgWcgmi8rx77ed+MGLVRCJ9vvhdFbh2e14pAf14wBr5M7B?=
 =?us-ascii?Q?HOP/YQ0FakpTTITaODx7T5isdR2BQdOr3J9xP02Cz29PooNSFDJlWWmFqOSu?=
 =?us-ascii?Q?ZBkZxOD4IXnAbCGaaFh6RAGtM0B9CStuBTLCkiQf/+dLubN/x6hOpNGF6B9f?=
 =?us-ascii?Q?708oc4eWN8Ex61O+K9E0DE9JmNxdUTZKSNMN/crS0s0cbzxpOdFPzERi11Im?=
 =?us-ascii?Q?V+AY/pai96V8sblVEcPKmhqe5oGxJ46tZP6doLglBsBqQzBDQog+XhDF2/Xv?=
 =?us-ascii?Q?nmYyVgwQYCmT9QEYfJIHgfj3jY9rcgWtnAySXO/YrrcHPuntOWjKCkbPKG4y?=
 =?us-ascii?Q?mHKCHjkWuuWgxF3Ozu4c6d/buCLNkULi1RKUmYZJx24TD4O6xePBMLrWSNnl?=
 =?us-ascii?Q?+EeiWwRIstifirqB9HFAZW2ipYLJht0emAmHb1a/EbOnZm2z1zjX4ZSqAGQc?=
 =?us-ascii?Q?ebJgGEWb2VqaSQHJ1l7dpZj4GXy7vRuePaZV6vLipKhkOKVp0/5Ail/CZ3Fv?=
 =?us-ascii?Q?VyiIVXzmjtXpOmgX5eAMY9yhyjf0QvRiZhN1Y2IWDcQowktB9xEGPlMpbZ74?=
 =?us-ascii?Q?1G7Ssv0ysAcmlaAWgvsnaDNAFThTUfWrcC0CH1YGBJihLOfj8neHb6MrBWqi?=
 =?us-ascii?Q?Gqt53g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b7a9e7-c229-4572-f7fa-08d9f2f77b19
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 15:58:18.7497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2zlxFmU46bwennUMhmRd08MNXKwMzElFaIzl+r+m7tv1Qg0WnbHTQMc1OAr30oj7zKzIu45Gx/CZXKziX8IQYqeTTARY0jZHSQh3zndb/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4226
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10261 signatures=677564
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202180103
X-Proofpoint-GUID: QetXz_Z2PaM71Vpa5xrVAGYbAwjP9KLr
X-Proofpoint-ORIG-GUID: QetXz_Z2PaM71Vpa5xrVAGYbAwjP9KLr
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 arch/x86/kernel/slaunch.c  | 467 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/dmar.c |   4 +
 4 files changed, 475 insertions(+)
 create mode 100644 arch/x86/kernel/slaunch.c

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 6aef9ee..5a189ad 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_X86_32)		+= tls.o
 obj-$(CONFIG_IA32_EMULATION)	+= tls.o
 obj-y				+= step.o
 obj-$(CONFIG_INTEL_TXT)		+= tboot.o
+obj-$(CONFIG_SECURE_LAUNCH)	+= slaunch.o
 obj-$(CONFIG_ISA_DMA_API)	+= i8237.o
 obj-y				+= stacktrace.o
 obj-y				+= cpu/
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 6e29c20..eb9e2a2 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -20,6 +20,7 @@
 #include <linux/root_dev.h>
 #include <linux/hugetlb.h>
 #include <linux/tboot.h>
+#include <linux/slaunch.h>
 #include <linux/usb/xhci-dbgp.h>
 #include <linux/static_call.h>
 #include <linux/swiotlb.h>
@@ -970,6 +971,8 @@ void __init setup_arch(char **cmdline_p)
 	early_gart_iommu_check();
 #endif
 
+	slaunch_setup_txt();
+
 	/*
 	 * partially used pages are not usable - thus
 	 * we are rounding upwards:
diff --git a/arch/x86/kernel/slaunch.c b/arch/x86/kernel/slaunch.c
new file mode 100644
index 00000000..ef6ef08
--- /dev/null
+++ b/arch/x86/kernel/slaunch.c
@@ -0,0 +1,467 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Secure Launch late validation/setup and finalization support.
+ *
+ * Copyright (c) 2022, Oracle and/or its affiliates.
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
+	u64 base, size, offset = 0;
+	void *heap;
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
+	u32 field_offset, err = 0;
+	const char *errmsg = "";
+	unsigned long last_pfn;
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
+	u64 base, size, heap_base, heap_size;
+	u32 mdrnum, mdroffset, mdrslen;
+	u32 field_offset, i;
+	void *mdrs;
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
+	mdrslen = mdrnum * sizeof(struct txt_sinit_memory_descriptor_record);
+
+	mdrs = txt_early_get_heap_table(txt, TXT_SINIT_MLE_DATA_TABLE,
+					mdroffset + mdrslen - 8);
+
+	mdr = mdrs + mdroffset - 8;
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
+	u32 field_offset, dmar_size, dmar_offset;
+	void *dmar;
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
+	u64 one = TXT_REGVALUE_ONE, val;
+	void __iomem *txt;
+
+	if (!boot_cpu_has(X86_FEATURE_SMX))
+		return;
+
+	/*
+	 * If booted through secure launch entry point, the loadflags
+	 * option will be set.
+	 */
+	if (!(boot_params.hdr.loadflags & SLAUNCH_FLAG))
+		return;
+
+	/*
+	 * See if SENTER was done by reading the status register in the
+	 * public space. If the public register space cannot be read, TXT may
+	 * be disabled.
+	 */
+	txt = early_ioremap(TXT_PUB_CONFIG_REGS_BASE,
+			    TXT_NR_CONFIG_PAGES * PAGE_SIZE);
+	if (!txt)
+		return;
+
+	memcpy_fromio(&val, txt + TXT_CR_STS, sizeof(val));
+	early_iounmap(txt, TXT_NR_CONFIG_PAGES * PAGE_SIZE);
+
+	/* SENTER should have been done */
+	if (!(val & TXT_SENTER_DONE_STS))
+		panic("Error TXT.STS SENTER_DONE not set\n");
+
+	/* SEXIT should have been cleared */
+	if (val & TXT_SEXIT_DONE_STS)
+		panic("Error TXT.STS SEXIT_DONE set\n");
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
+	if ((val & 0xffff) != 0x8086) {
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
index 915bff7..6daea97 100644
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
@@ -661,6 +662,9 @@ static inline int dmar_walk_dmar_table(struct acpi_table_dmar *dmar,
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

