Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097BB4BBCD7
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Feb 2022 17:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbiBRQBL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Feb 2022 11:01:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237411AbiBRP7a (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Feb 2022 10:59:30 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910412B5209;
        Fri, 18 Feb 2022 07:59:07 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21IFqqNH014987;
        Fri, 18 Feb 2022 15:58:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=Ywiq9wjQNR8Tn833pUzniiGhN552HVsVGiXd8WWQTSE=;
 b=tEo/tGYI0US7R/wqaheNlwy5n5uW1D/U01OjnSQj8i4ErwApdy27vllOCxX6QGP2nDTb
 mt+v5EmidxDQEI+rNBeOAoW4hb8oc/joI06UdcexEXfV15ZzUtkH1p7zFq+UWvO3RU1c
 nZm7CCtkKpvqSfzRGXofXN7/VRUjLNtAlhEd70MEK5kJ8y1fShuZ5pl59odZS67BOElx
 H2rgBVw0zZ6dRz2Aslpu4wiK6OAhHrOJ6Y+Rdax89jrgAYsB8+4h2mKTtdljcHmlmlne
 nhI53Tiup1HsRuF1qJRrcuC4W7x9E0zQ87NL0yZYP6SCAYAjFFkkmM8JX2OEC0hJeJSp YQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8n3fh6wk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 15:58:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21IFuYJ2128831;
        Fri, 18 Feb 2022 15:58:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by userp3020.oracle.com with ESMTP id 3e8n4xqcwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 15:58:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=US4h8tnhDxtCog6Sh1uKfJchk1Vh0QRUJ0Cc5J4Os9MRuzDLF1Lc6I1JhjasjyLc7kdfeQcCiAGiX4vu1sXjHKGzuaknTuLK/6rKRlYuUupfQaGMJ7tsWLoeGz7P39C6zRQ8SqbAvtO3o1fEWbe+LHcYhPccBV19OO+ZkYKbA6sJXNjU5N6iZowqOt6QLA3eFrq08eSZeHpMYKvDlqvcBWYmoKh5PnL7xU8695T1gdgdCJjZZKjTKXxrbXg2R436w4PnIN0wTi1IkCl1xOS9qfxMKwHc+AGoG9i/mGmpwks7xf8xEd6to/Vdj9vchlSAER7UUGSn2gB27ThGG7laoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ywiq9wjQNR8Tn833pUzniiGhN552HVsVGiXd8WWQTSE=;
 b=jdUjVKvoSflnQGtcHUn2Uy+EqGiU/CbcjHVmyIcaisXkIxPA9r2Yh3bNV6FVE1oybOC1+nO2qBxEDYACutw9HE+OYCQez3cznQi8mfGecNK28GkPv+iAjjI0CTmj98adO5+Di66ODfCeF6no2HANJ2HG6Oiz167yMEKzkgx/lkfM4jg4F89g95M4ISPwhUaSxpS58xYL77Rhde3ZSFjIyI09RcjsvngeMPLVBDw1unevwMqDJoP/QdYspmQYlRDwfMvxyTRHSGmGZvPqhgJcCBq8Eg5MqcdVioZr28+xR8p/TJUC6B6Pd/qasHzh6EWfL7PlcWxAh6dd4W354w9MOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ywiq9wjQNR8Tn833pUzniiGhN552HVsVGiXd8WWQTSE=;
 b=Uwp3TSLc3Emk/pC1XmhbJrXeOZIbRqcCZiDwizJrC6FO/tpj2ZJ9CLNBP6zc1Z6VrBH0h+QZ/7InbQqTMepkp3w2jk05/CnQvQKn5zkRPS4WJ6aoNu+irRFtIn0RJXuqcbW9ceEVfMOiwZdYhmAV6eqXYn6Z3kv++UWP9a2+s3c=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by DS7PR10MB5312.namprd10.prod.outlook.com (2603:10b6:5:3a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 15:58:06 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::398e:10a4:6887:4e18]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::398e:10a4:6887:4e18%5]) with mapi id 15.20.4995.022; Fri, 18 Feb 2022
 15:58:06 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org
Cc:     iommu@lists.linux-foundation.org, ross.philipson@oracle.com,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v5 01/12] x86/boot: Place kernel_info at a fixed offset
Date:   Wed, 16 Feb 2022 22:54:34 -0500
Message-Id: <1645070085-14255-2-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1645070085-14255-1-git-send-email-ross.philipson@oracle.com>
References: <1645070085-14255-1-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0288.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::23) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32985ca0-aa08-4445-61c5-08d9f2f77385
X-MS-TrafficTypeDiagnostic: DS7PR10MB5312:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB53127D6EC42CC211F490C922E6379@DS7PR10MB5312.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R8nwkEmy7sE+fCRe5nKKeEckI/g7onwxPhES+KHCLFDjJmOTn4MMExy/2gJi2qdSZHKACDh/mX8HmkhshVmH5l4CIOf1/xg+v57Kp7JM/XnMFOTSuWKvL0O84DZYlVBj7LsEQ7uT5d2AfI95ni8IRYE1v4x3Zuz3zSejLZteCmn8A6A+t29a4arikSkNzBm5JvbE3CRhDqI7/SEyXtTLpk7HIuljqQCyZCH7dYMh4aZXryIU/oXMlyVo0iSOwG+6PIDl0ocRvI2KtR+1+sfVxztwS3LBGFybcAREA3FoXPwLRzNiZb7Zf/gTxjNO+nPKHCdWIHpet8Ye83CfM3Lvll/h9ttMT6paQarT1yYKSbODB2R0VI2XiP5YAZGWLzv6211B0sQfggg9MpWkqq2/BRcfj4BjWRnJjRwjK/y6ms2QwxRXDYc6lfE2GIASnV0Dx+XhSwhuiHxcoPDk7+z2/9HRqLGbmAOyim1EurjbSN2tSaS1f1fzyJonBpISGKZhTaYOVJbxYc5pXESxuqHmEkFTK5Ujtb/XA++slKD+3PbVLpewGSGIqQqkIPV7FVugJQ06m2qbZy0Nk1FqGYU240VXc2NauqV/jxe+0bR8xas63DncHXtEDvMt8SOtjYvrX/bA7U8TjFxS9uEkM1iwUcGYOcfM+GjJfFyZMAXEe5ShtTI/pYmbV3MKbvO7dcceUf/lfUmxU0BDcyOj2+csyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(26005)(186003)(8676002)(4326008)(38350700002)(38100700002)(66476007)(66946007)(66556008)(508600001)(2616005)(6486002)(316002)(7416002)(36756003)(6666004)(5660300002)(8936002)(83380400001)(2906002)(6512007)(6506007)(52116002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wjFYc38vnzsQoaOBVdBJdFYDL5Kz+WFMb2pwNc5TAITYwYoiyBQ19tdlTJmy?=
 =?us-ascii?Q?1sEbS+FWXJWVhthjJu5eKJIKD41MKiyPaOBiuSi9GZPSZabd1ALQ6ZDErKH5?=
 =?us-ascii?Q?jFToSKQIrg780x4rSSe1b9ZuL7MNh4CqZGiwluGsC1PAEzjjVbJ9R1DmK+io?=
 =?us-ascii?Q?O8wAciO9KDzldwPrhA1GbsFCr16KdF+3gtRHrqm+gzp2qXiCqaR1twjLuXMg?=
 =?us-ascii?Q?+WB35DxpkMLQ3s89bZMUjf1sju8RlpXPQk+nFkIr44E74qwPx1NFFRgkBZIk?=
 =?us-ascii?Q?OW/BvgfXiBgi7vISybE4vGTcK22XKgXliqb2fexiuZUbrbB3xWU/hUpBoj8U?=
 =?us-ascii?Q?UX5p2e+dpfG87rw8Cd0whEEwQml7Ynps+6oPPkUJ5IE5Mn5WIbqMU8pEwlfj?=
 =?us-ascii?Q?Hn/LaKvQjEolnt+zpwB8p2ux1qaM+zIr72ixw0LEn1ivl1JeQcL12pfmroU7?=
 =?us-ascii?Q?SKQlb7NJ+Hc9MK+FTbM3BEA4HrqUiA4D4Npqh/FaKb++FJ3AT+XSSmgqQbI5?=
 =?us-ascii?Q?sTZQYMnB3gO5BLyKOCO6TMJYFEJElW1ZnNL9Wi4WiuSLtHyjZfZYadU9f8De?=
 =?us-ascii?Q?VZ54oBm3RoMJmInZ4F8c8mka+ZznGUXLjVH5a44GXZdnhjYXJ46WEahShHjc?=
 =?us-ascii?Q?7O6oiqPYu1TotT8ZciOOYyS7ivzeIBHVCQLDI3Xj9xMeFYGPuguGuZQYTkph?=
 =?us-ascii?Q?HlkIrvvs6sEi4/d+m6UgplDrNg8q41dJh81EML19AiDgxCUoAdSMUnFrSSSQ?=
 =?us-ascii?Q?Tf6ZhESPHgvF5/K45+I2P3wo04XF5PezLejV1As8JwjiktazmcvBQc1U7jpm?=
 =?us-ascii?Q?Lgev2t1FIUy5epp9bt+x+y61tNNmwDZhJueh5zFE5GvA1uuwkk1uAwuzcBVF?=
 =?us-ascii?Q?zEK24zFt9SoORPYDbMWXVesgpd2VCHGhOxi8426bWFrGOqQpXFzkYleoKvZ8?=
 =?us-ascii?Q?G00Fwof1DGurGT5ZemvfqPy5SDBurVEZQcevcpGL5h4fwMyfX/5vH9nBGRET?=
 =?us-ascii?Q?a35RQlxiGI/Gc6rzcFB8FZ5qJqwpCRrITYEydOEKnKFuhjY+F5E10SWqSAbn?=
 =?us-ascii?Q?/173hlm6nM06howE416aQxQxhLBolaOdpQ/jXQ9+m+ROeDPawIrnG0VSUY19?=
 =?us-ascii?Q?jy8Ofz5QK4rFt3kuH0Wagnsicu6ps2XO7dFYJz3RCmUSWs+m/nmlIAuA5ZQw?=
 =?us-ascii?Q?N4oMn4Ksf0zOF05jLFKxQ/HeiaBS1trXd3WSPVBe4OgIDMUHdKW8Hh1KeBvG?=
 =?us-ascii?Q?xWUQya0E2GKm8ldlOIaJh7d8JcYrHMFlAj4xr8QhL5mGI6pRP7cbq0n58HUP?=
 =?us-ascii?Q?eI0bsZwvXvtVxs5BUz5F+Lib2Erk0eaKKPjmnu+00vnfBFqZgPApWfIZhI5y?=
 =?us-ascii?Q?I5m2fMeyTSrqsZAEtBGJy8/HVxyK9u51AVSsf37xuJGKEBo4DxUnHCfvnVji?=
 =?us-ascii?Q?E/wov6DKw44AT1Wk7L/NfhvttB5nwdmlokquARaP/upwkzp6ocjlhgcvEEkj?=
 =?us-ascii?Q?S3SWADhbKtFUuLAJRzisiDX/tw98q0KxhzFBBjiroBIp4KEwdb/2OhE0QHrs?=
 =?us-ascii?Q?Zkr22lArrmXFLtRRQdwLcavPI2GKn8vV0vLkQFqu+QZPFrruDbaVHD3Tz9+5?=
 =?us-ascii?Q?J0rhZnXtTEWD30LZSd9eEnp+NRR4oRgrgtE1dwge07Cs61u3lsPS/Pvfi9Z7?=
 =?us-ascii?Q?oosUew=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32985ca0-aa08-4445-61c5-08d9f2f77385
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 15:58:06.0632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SUwVtTg75kFfihV0rW9Bos2+rnT+nj5xUnPOehtMSGC1d//Zf0e5dTL/slLE+kpfeLQvFqkvVx70PQufimNtKqAYyWKecS50dlwPIkarucA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5312
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10261 signatures=677564
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202180103
X-Proofpoint-GUID: aKR9YWRguXanlm0_fUxFf0JwjTqU8bky
X-Proofpoint-ORIG-GUID: aKR9YWRguXanlm0_fUxFf0JwjTqU8bky
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

There are use cases for storing the offset of a symbol in kernel_info.
For example, the trenchboot series [0] needs to store the offset of the
Measured Launch Environment header in kernel_info.

Since commit (note: commit ID from tip/master)

commit 527afc212231 ("x86/boot: Check that there are no run-time relocations")

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
index 00000000..c127f84
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

