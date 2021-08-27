Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E313F9975
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Aug 2021 15:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbhH0NV7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 Aug 2021 09:21:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:23200 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231730AbhH0NV6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Aug 2021 09:21:58 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17RA9fr6025577;
        Fri, 27 Aug 2021 13:20:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=uaDB31GsdQ6QYX6kwRtBtlkYbBLv8Aw3ThMjsV2imfI=;
 b=Cv0tkcvmGdTwlHW1P/4pDEprkKyQ4vaCxNFync3+spKcN63gmNX1j9qUjqvO1Htdn/c8
 TN0HN2an5CDW76qkSBT38OA885woi5PQ65Xp1ezz+ryIyVSLlsDoq4Q4ANR8o79LYwvA
 COro6KOOXdqZnawBJ9Uq8WrOy7wVnsHqVmeyO96ie/3R3Foi72EEtSaWi4P+fDlsyBDj
 LYyPH0sDAbbYLliRJM7h21DEBgg6Vi8sr/0fj8tclv/qy1uegRgzlZiPSANwcMWcJrrd
 VGS4UGq94FqXfScdph2N/7hSPWUeZydNFI94igLHRQivLS0NifTWj9hXd40lmrS+XlWG gg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=uaDB31GsdQ6QYX6kwRtBtlkYbBLv8Aw3ThMjsV2imfI=;
 b=jcbDrC18r22P2zP4kFOEXjol+CK/clQKQZhK9fx/ExtgG98Z7ywSnghn25HNB+fI/9pI
 PAcR/3H8Gvmc5EzlpcyGsrqadVLBiCA5E08iv+gkCHgopZrecTuC6QOuuUDzMpueujkD
 y7nUrZlHvikUNAGCJoDs3+k+qJrX8w6DwwPU7wN90mSy0ctFESeGEL+RUxJ9FnX71W8E
 T7mJvdWpli6zLT6ovtxbKBZpM7KIRgTgutkMOlwzCmu357ZQbMCrrXdWmSpl40fteql6
 GfT+8Ecnagq+30VGC050+6jWjgaXSprRrjmo44uwLInSI8Vd7mOzsU1Qvbo4wnCoTeaD QQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ap3eauqkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 13:20:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17RD9omA076985;
        Fri, 27 Aug 2021 13:20:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by userp3030.oracle.com with ESMTP id 3ajpm4pq7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 13:20:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zhumlmi4aD+IbrJXd/HTJpssE1kxpgAaEdfGfhmkNRXWl4A7n2AXobFlnQGzm9VMCis/CvxgGO8CJx4E7NTOViDL7ped+qyksBQPGBaJC6qvFq6qNYYdn1yTFISkDnNZ+7PnYkAC4F3ZWU+ljaN9NYGWnXxoKhzsHpA8o7gik17pUwVrY4WX8xCFSg0t6SWo3O4y3n82ze+TmgUTG8m1cg50t3Mc+00f42memcisdWX6T3LwD9RdxKZmakQH2PSB/HArtCjMTs/W5F9QTfXoPEyP4DbFWxfwl1XKbQDCeHdRlwrBSIlnEUjbj+jXwN9cYai01XezF6zjZozwSJrqBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaDB31GsdQ6QYX6kwRtBtlkYbBLv8Aw3ThMjsV2imfI=;
 b=LymGXQ80KETCwE3bSniOE6NZQthx+6kP/UdM6Cz8Ukcq9eRCOHuEEhNfBWEoRuAqwWL8EnAZXQe+YLaSVfFWkBUtLfib/i0h2hvrgfVOa7o0gKlUuB2pR376Wl/knmq2SWNwN2ToXhaKeOU3U1JOx2aGY0K4eEo1Olf/nJgc2IH4lEKr/k1/puchz5DrOi5NrgeqQWsAR765WB10sXsRKfIGY45VcMKaDs7dmSXddcju0uhUeXj8AZVSY2HTeXxNrPppP29LEaY5spABhVoHUkttIp/A2QrirAEhQ1akuMR5lRKTTotckHtMrCQ4OilpmqQiXx97ywhtzIN1T2ABEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaDB31GsdQ6QYX6kwRtBtlkYbBLv8Aw3ThMjsV2imfI=;
 b=W+vijA/nrys3AiPBdDWxiwg43zsHr3E8h6k7xfN/Yny+QxlnQR1uDPGTqjoSCIP3KGd+L713xGHs2F17CMolCq6Hkr/kmrEKje4PeK7zOkLg58ohzpSt6EU3V9nx/LtLMka2iiSNgQ67S5Nlm/g6KAG+4Sj7M/Qu4iCgTm5ZS8A=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BYAPR10MB3432.namprd10.prod.outlook.com (2603:10b6:a03:8e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Fri, 27 Aug
 2021 13:20:42 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3%4]) with mapi id 15.20.4457.020; Fri, 27 Aug 2021
 13:20:41 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v4 03/14] x86/boot: Place kernel_info at a fixed offset
Date:   Fri, 27 Aug 2021 09:28:26 -0400
Message-Id: <1630070917-9896-4-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
References: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:805:de::24) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lateralus.us.oracle.com (209.17.40.45) by SN6PR05CA0011.namprd05.prod.outlook.com (2603:10b6:805:de::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.8 via Frontend Transport; Fri, 27 Aug 2021 13:20:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d96d3c4-2992-43b3-c00b-08d9695d7813
X-MS-TrafficTypeDiagnostic: BYAPR10MB3432:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB34329C9E3E2C34EFE2840081E6C89@BYAPR10MB3432.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vYNC3Jo0/wTN4djWpd68bj+vLAT+OO1EdJfLACs/jKmHNirJaJePgf85+5nqio4gFe2useocSE8xUuDq1C/FZY8olTRSkABhmq/KlCtV6ABiHllMgwN4/SKtksixapOqh9iiFB5Q/xl0FLPvB4867BA7qlMU5AQjHWvlECezAD5X4ALCCBtDP+FbVa4x5fmc2ToVkIjE6t1T+Hjn6RqWynAWrYeq8qbQ7q1b4e8sE4GKl2JIGxeCUzJI0t94vAJPhLuJSHe7IUddSQgijA/uz9oLkeF/CGsAuqkOIfZZ47uwEkObmDmYvDL5udzhAKJyg+y9LNhb20X7MoBeezccC9PovyacZrLVOQsBDpDPJFMKxK1xgC7aFmx5/LNi1upo83pOzG+DkQ7JO4MDSzeNh9BRr3Ic9OIUj4NaVqL6Po8bUCK5zAPMjlwplOnv+nLCNIq4uhUxh+ceJ08DVkTeDcF8e5ld+L0JnU3WlrdlUiHQZGe/xx2ppAh8Shake0qikNOk3O5vDRqvjWAJOSkXFHhVOBL3gL4rv94BOFA1OEyLJgkt1KOQX5/GFyHLRdbBTfnYLCh6Z9dKHBbrqt16lI5tojt4aej7q4hj/PvbdTWWePgvU2nilab2c4HrHvJz3JFRjuYHNMEFJcvweTursVnjlSsf1BtBZomUVYP3pZC6jbescKSbfWduG1J27tplncEDBzh2kS1emlvBLtrlyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(366004)(39860400002)(376002)(8936002)(2906002)(86362001)(478600001)(186003)(6666004)(5660300002)(36756003)(7696005)(4326008)(316002)(38350700002)(83380400001)(66946007)(6486002)(38100700002)(956004)(26005)(7416002)(8676002)(52116002)(44832011)(66556008)(66476007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MQz+RMz64S8ape6Pfht1lNgw0o6mnBhx4FEDpH3KfIMnCTj6DJHYt5NXWezR?=
 =?us-ascii?Q?tupuc4tB+Ait77x2nSeaEwWYDUTq6NIyYzgcPwmcSj7goE1zYNEZ160sp2Ei?=
 =?us-ascii?Q?uxbBfUqqJz7146wQPtVZXHtPgM0VTx17AeJEzK7yz47l5W0o44St22KQG1sA?=
 =?us-ascii?Q?DrPuy9B70VisQ9ECsKTNGF0uueV4f22bR2NEfnnd6s5+kPKW9Jc9/iJTMr6M?=
 =?us-ascii?Q?sbyHMp8yaThjlpX2ek61CC6ybOHAeLLk7Yd8Mhzfd+cMoqbOxQeqUBMqRa6y?=
 =?us-ascii?Q?eVM+LBJdfWAGMgaG/6ZGDdLD5kfSnAjdsPdzuJQPLsqAHmYgltxqt+NrSpbr?=
 =?us-ascii?Q?suyUGay7qWOxw9FL3UlfokbghefodBkS8H+8ny4KXe4aWN/uF673D38z0gKf?=
 =?us-ascii?Q?xLaeO7PY6XXNOgnP6iHBjtr/ZH7MbAt1uiPapIUUSP9NJ88mFhyrZEKmteOh?=
 =?us-ascii?Q?lNfhb0hmmbB7fZ7OPeewNjOaHbYusL6XAW5r1HbZ7FlA//jRlWvYWmh5YLnI?=
 =?us-ascii?Q?RenLlyZPcjeFZsQpp8VhRAAj5YKSzMcIYmCSgtF9qAIBxHwPHRJDrEaUDkbi?=
 =?us-ascii?Q?u5Qy8TDJggscnzd2c6IFu2NTMXpjuC7FcnwNH8hL2eYa6mmqy0xAYZU9jUQY?=
 =?us-ascii?Q?i20i+Vx0IMebkvAgrFVG9MK7IUHW0MDe5QKjwqIv81pNiW3zjulF6A6X+V6+?=
 =?us-ascii?Q?RakDDlABWK2v0WBHl8rnEftiaOmxXI361RyC0esOsDRhcmkfbVI+nmOPeS/D?=
 =?us-ascii?Q?a46HKDGnjqszhSucVx7MGsgWLFpJg0LMyeBcfBywRLY27etctu1dkP9USrDO?=
 =?us-ascii?Q?JBaTUQv6p/Z4Byl7wolYKWJ2wvNrDUjCeQxUiowXAZAjwBM3zkTQ7s1pYSVZ?=
 =?us-ascii?Q?upMGLrSXbFPCWB+1Ykg7x9xJdBQq8TX+WqE2JaQDL0AJia/KqJyWsTm7b/UR?=
 =?us-ascii?Q?qVKZJ+RTzerFUZX7SnKexRHk7cwRDNijv6FPURYnBjTdI6/k00CzE8Tkb3uJ?=
 =?us-ascii?Q?EJohG6P5Vq5APldGbGMfvW/mWSp6P8ULFO1ZUueeWqC2nFEvpksMDrV4ByBj?=
 =?us-ascii?Q?ZOS8u4319Piu8P/0JKhaVGYOx119a/O/kqKgFtEhcqZQCl//midyyNA20O+u?=
 =?us-ascii?Q?h8qz0BP3gLRGvjK4UmJdluOJCkje8XDBECB3LPH49w+81q2KhY2JMx0UGPGv?=
 =?us-ascii?Q?vVNFLVV8PIQ1Qhd3TH2oMT1buQeL3EfwsRp6Q3mNZYyWMkxCxrU9SxdUOb8S?=
 =?us-ascii?Q?QObnt2MPDU4P1oCQwwjUJKw0fZS6vn7Cj38BKwDcBvPURXo6YR/2bf5qVhiX?=
 =?us-ascii?Q?8u4udHgDXV06ngBWeRCp2AJB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d96d3c4-2992-43b3-c00b-08d9695d7813
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 13:20:41.8760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GFGH4JskyprSrSvj9Iav2CnpPY/CVaEj3FMnHAHaiUd+pK0JkTKgm+h5u2n3vTbmDyPbdPktBLfhCeY7h1p7F5VQR/RHPCjzZTx8wsNKoqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3432
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10088 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108270086
X-Proofpoint-ORIG-GUID: BFcFcHv4Wvqx--95J7R8OniCamwtENwR
X-Proofpoint-GUID: BFcFcHv4Wvqx--95J7R8OniCamwtENwR
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

