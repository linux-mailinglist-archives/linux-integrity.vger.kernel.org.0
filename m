Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76B64BBCE3
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Feb 2022 17:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237459AbiBRQAH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Feb 2022 11:00:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237365AbiBRP73 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Feb 2022 10:59:29 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04AB2B4045;
        Fri, 18 Feb 2022 07:58:57 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21IFqq8F027959;
        Fri, 18 Feb 2022 15:58:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=2XhOUSMzKkuSzrtk1lnsv2eT6AqjPHXFPGEs/0fE0lE=;
 b=PllZhxkRDvdMpNhb3wwHmmWgYx6xwogQNvN81UFX8sjHhaMseLlcWSFMIgjtI8Juwv9M
 eNuTwV/jXKNRL1CaHvZBLJHbMe7g1BQjNH8HEFZugPnwrupmZSUab2JNZBlMkA75JfhH
 PIA6RxW3BXI/faP299ozNOZsmLbDmrvwcLOoG36brcV4B4F2GNlgOuFYwwEHGeZQCG/2
 sdy5H1inq+n9kvYiHvYwbor4bFAO3Wa1595/I5Rsf0/YurnS+EYVN16lhL6dLZkGO4ag
 dqo1sagvtA22N30QcWBUAPmhoELDWEtdeLdRS00H02FpOh3C9r3AuU/Dg9tSEKjzs/jW 9Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8n3e1yqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 15:58:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21IFvLDx055329;
        Fri, 18 Feb 2022 15:58:30 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by userp3030.oracle.com with ESMTP id 3e8nm18845-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 15:58:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gn3EJYwigpjjIhFkWs1nyuipjVnSxOV4kGpnVq1aJmVPcsidFsoRpjYYykdAnqCmyy59HjJkFTQAJcP+7qeOkcOhRun0puZiedsz8FzAhKnbnCadaUUBjEJzse+C70v0Hi93qf4IevR0ExtDQqdoLUKNZP19Uoxp8NdWsnJd5L9gaacTNKQ7d0HxYWapzjT2HjROG5+gaHFkL088sStHXQKZJiGpH85Mf08c/LCFc818NNMXPpG13jhqy4g0SNFYi1R5ko8aCfy3YlZ6YndiIRWBM0bdeHvrq6Wrw+//C+T/vHQSssJ/W7TD/ap5ebjqKfGnV6aXSVWo4MU6YH114Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XhOUSMzKkuSzrtk1lnsv2eT6AqjPHXFPGEs/0fE0lE=;
 b=SDrJh7DoEyUGN16byg02+Vt1TQi5N+ByA+8aRAKtPlSbgBcoeMcTp8HfALfnZkKGND5m4HslaK5HSx7Iv0Dho42NZxMIaITqJLT58zTDRETkBlvlJzYY5fgJLDuZfCV1WeOqR/JgY95+CaX1Tu0uPpd/xg+a6sCVuJZwsQhKxnpFN4HiLThYY9h1NvlSA1tZVew0AHHsbBN9zY7TPfiwNOxwZrlpR7Qpx+zThyFsmyxLRcJMLy49L//TgDZNTl+VsA3YpajkaQl8HBxcEPWpZYKwSsckS32XlbXMeJczqIg3PgOaTXqfSFRjZETP8uuYli6wnvOZMaWeQqpHnKNpJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XhOUSMzKkuSzrtk1lnsv2eT6AqjPHXFPGEs/0fE0lE=;
 b=vAoU3g0q7vMeKgf7FISfuPWHdE7yWGd9LcuOU9R2uJz/K9IBEMhkTVjQx7sxMkppMtPQGsEfUQ6FNEZOs8T3ud+aVLSfI3JLKkHCg7EQbTi4UrE5SuOvuCFO2QYezCHl0dqrJf0pGS1TRCS3JSJi4Nlq5ArfI08NCY96i3zLaZE=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BY5PR10MB4226.namprd10.prod.outlook.com (2603:10b6:a03:210::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 15:58:27 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::398e:10a4:6887:4e18]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::398e:10a4:6887:4e18%5]) with mapi id 15.20.4995.022; Fri, 18 Feb 2022
 15:58:27 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org
Cc:     iommu@lists.linux-foundation.org, ross.philipson@oracle.com,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v5 11/12] x86: Secure Launch late initcall platform module
Date:   Wed, 16 Feb 2022 22:54:44 -0500
Message-Id: <1645070085-14255-12-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1645070085-14255-1-git-send-email-ross.philipson@oracle.com>
References: <1645070085-14255-1-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0288.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::23) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5918a012-847d-4589-53f4-08d9f2f78040
X-MS-TrafficTypeDiagnostic: BY5PR10MB4226:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB4226482A866677972BB9F2C8E6379@BY5PR10MB4226.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wFyV9i6nAH0a7oMNnGw4Ru4Li7Yqx+NCYLz4FD9qXlKV8MhG/rWhhvl9qlTGASPZ9ZHa8LmKeMjX+fAZi6VDQ+kYEN1ga6MgSa605evjELGC9tPb4Jh3jn4JPt+619gmfuTpDUjal+QKC8D+jOU31dNToJbbkw/9SGMmxhSAiDXHpW7orZ8o5GaH5cW0+FIt6B+BG7WT5gxiau0VUKp80GAVVlObPOs2M6FFT/+EiPGppKwMZYKGwrWqHm5R5NiU7Z4F1HfsX+Nn/6xzBo3pji6PIAOaHjt31LGeuZvCl//8kbC8kmJu+jhZ23QL3YLy8YR/CTyD3mhRUDXJrpugcFm1p6AtXOz1ufj+FCNqsZE2HEumSip2eF0cGk2+SbFwEtVJHWbh/ed/ul7bmPbU+aDb7JO5FQshiplFMmsj8U5IGSUtXG3dO7O9G5p+FFGM/DPG1FmeciTT4BMYas7tlN3e8v767bGmLpuZcpWPTtJAEF1C+GWWMJUGrLGDDy9Xvvj7/YQtC6VChcMkZ1ZFjlRv3vY73aKUdvAKCItTwLmoPlrSibKxHz9BFEgk4fAQibIaeKxkvFvsHKF0u8jM8rHSL8NVb7LvG3izqCSYrevP5m+EJFL/r7qlcf0NKV0Sv9P3QZ2M2UGVtHUnsp6BmMuP7y6hZiOWyInNfJuN57a+ZZiBq38MvoiY7h8HH433LziykGwI1y92lMCGpJDr4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(44832011)(86362001)(5660300002)(36756003)(6666004)(7416002)(6486002)(52116002)(8936002)(83380400001)(66946007)(66476007)(316002)(2616005)(66556008)(6512007)(38350700002)(38100700002)(186003)(4326008)(30864003)(8676002)(508600001)(6506007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SCeBkXygkqqsPJZvYVLd0MdfVGHxmnbLzZ1KSR/mV32xAetAgjoRFVQRrRwV?=
 =?us-ascii?Q?n9pYiHtuE7B6g1EohXGJdQKdKPcHqDO9cHfyj3FOWqvHzJWZlBB+6Ec47jN7?=
 =?us-ascii?Q?UOpzJWqQZUmfzaNHfJZtyVBe9ZtkyR/XgPuCbFcOAge+N2prI8pJULT5K1zk?=
 =?us-ascii?Q?bbDS2O6oRx5XlrBgyDOL3Ce727GrJfj2Koz7exbbOI8so3VGuO1We6+qAJ/Z?=
 =?us-ascii?Q?FdigGF3ELWk9gtoZ9JXNjS1zvlzfPC9hWrk3rvU9DMneXVneK/Ufbb4UFp2X?=
 =?us-ascii?Q?wzK9StK9rMdPyoUoxCivZKzRy7TgCb5HIkMZlFpvGOBSxwyHXj7ZWnbcPnhj?=
 =?us-ascii?Q?EOZKl5+zuH+zXh37pLLllyRPbck/cDBZiij0ANy5OE7TISKpm0sUopGQ9RIU?=
 =?us-ascii?Q?C7sIoNjUBW3WQlY9LWvLFKHIZhpOQZ5eREsyhqkGJW8VxOL5XcgG3NpVuMH5?=
 =?us-ascii?Q?frCBv2jWackKwFrFTFzeDQqry4AREd+fmXcMedjZiIBwoUCyW5oR+GckTAEO?=
 =?us-ascii?Q?SzLziintyymx6CEe2L+upbsmOKMH51XIaxQMsG1W0sT2rrsqP6PmT634MUFk?=
 =?us-ascii?Q?YgNNCk8nRJBpBVVqhBnfl+0u8ZG+0nnrP2MMUbh3+wPY8919LJ4thFy99U/2?=
 =?us-ascii?Q?dU0MafPgjdF5syCbpQl+0NRcqFqgCimkwFg2rs4dbNZO4KlGGTwtGgTYEMLP?=
 =?us-ascii?Q?/uefQuOiIu3MByYJFc5T7w3KQhlPCyHCl6yihzjERoLq+fLJ3nhtmT9UVMFS?=
 =?us-ascii?Q?0MDSVlQN9S8NG1o62gbsfczofeTYp3lNXQxJyjS6ap2xgbAmsc1q3fPKy6w8?=
 =?us-ascii?Q?DdEkk4wuohNju53Enlsk40j+eg5Kapieb30ztM/hQbAe7v3AQV95lgb7Dmt+?=
 =?us-ascii?Q?nsaCs2MC+Gmd1ku7DHNlsyfKglYadmw2Qixb2rS8c8I2x/QCHtRllf/pzi2B?=
 =?us-ascii?Q?grAQ/eZh8ABXUtQa0s+FfZhps+YFZ/Olm0HpzD9CPVgW4AJcRovOiJQVRi3E?=
 =?us-ascii?Q?Pp11hiZAiLtTGX9d/uCQGkN49CZmQQC2utMqMZ5MYl9nrDYyMirDXn0Cn7Bv?=
 =?us-ascii?Q?RmgcUCX8UBd38qfo7MUS1NG79Fuq8VIoAtE8+ikYZt3Az+5+9BngTXTMI2Hc?=
 =?us-ascii?Q?BmAF/zpufGCj5IGMZj00BXP9J8Yb7P17/VmaRy8xKiK04UqRACPmmlcVASoK?=
 =?us-ascii?Q?VlMrA9C0R+TvkfoOBixLpz1Mhbl7Zbu2CjD5DBsZPjdneWU34c4IizjzqUsl?=
 =?us-ascii?Q?YPdxzqdnzAZBRr7eBXCfPpHpuZ8VWf1ceBC8p5/gLpAp8crbQhhlsV8gRApe?=
 =?us-ascii?Q?geHGoDWCkN0rcCsNc/2vhT15vNjV55plZpCVXBOSAQMxIFX6hKy06jJtF9Fj?=
 =?us-ascii?Q?0m8Xp20UkztaQpoJPCewurFxvaqRYzy0Aq/qoh4fn0KniXuhlYzCqPl/8IL5?=
 =?us-ascii?Q?4yzcB93urS50VkR2JofhXiDTwzU6jmPawcPGsxbtXfTGyMP2DaC0vGXpcHee?=
 =?us-ascii?Q?VmG99VNtqziZ5gdK+V6/RmFB2/vZT6tLUAOIZcDQ6PQsXGDRIw/wZr877Huf?=
 =?us-ascii?Q?URXfedYHgzDOPMCqkuIb2vaHX8AcW2QW6H8UrctPze/st14NokdEbBz5bL06?=
 =?us-ascii?Q?cdI97DHCAo+Yojgb9KVKgY0db3Ki8AZFTiwtCUpLVIZ9K2h1H6+dH/tOWv3s?=
 =?us-ascii?Q?VZxPKdjx/Hz+TVumpNjah7P5L7I=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5918a012-847d-4589-53f4-08d9f2f78040
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 15:58:27.4054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EQ+LjlwhXwFXymb2TR97ciyXe7bxhoZoJzMTMKBPK/I6zzJAi2FDJphBJ+XJ/Hc1gTCl0PkNV5Xc+Cz+JEKVVIvTtMYobReX/ALKkFOjkhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4226
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10261 signatures=677564
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202180103
X-Proofpoint-ORIG-GUID: b4VxgcKbSaUZqcu5EXjwakNowI4MkihI
X-Proofpoint-GUID: b4VxgcKbSaUZqcu5EXjwakNowI4MkihI
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 arch/x86/kernel/slmodule.c | 493 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 494 insertions(+)
 create mode 100644 arch/x86/kernel/slmodule.c

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 5a189ad..8c4d602 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -84,6 +84,7 @@ obj-$(CONFIG_IA32_EMULATION)	+= tls.o
 obj-y				+= step.o
 obj-$(CONFIG_INTEL_TXT)		+= tboot.o
 obj-$(CONFIG_SECURE_LAUNCH)	+= slaunch.o
+obj-$(CONFIG_SECURE_LAUNCH)	+= slmodule.o
 obj-$(CONFIG_ISA_DMA_API)	+= i8237.o
 obj-y				+= stacktrace.o
 obj-y				+= cpu/
diff --git a/arch/x86/kernel/slmodule.c b/arch/x86/kernel/slmodule.c
new file mode 100644
index 00000000..5bb4c0c
--- /dev/null
+++ b/arch/x86/kernel/slmodule.c
@@ -0,0 +1,493 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Secure Launch late validation/setup, securityfs exposure and
+ * finalization support.
+ *
+ * Copyright (c) 2022 Apertus Solutions, LLC
+ * Copyright (c) 2021 Assured Information Security, Inc.
+ * Copyright (c) 2022, Oracle and/or its affiliates.
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
+	if (!txt)						\
+		return -EFAULT;					\
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
+	ssize_t result;
+	char *data;
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
+struct sfs_file {
+	const char *name;
+	const struct file_operations *fops;
+};
+
+#define SL_TXT_ENTRY_COUNT	7
+static const struct sfs_file sl_txt_files[] = {
+	{ "sts", &sts_ops },
+	{ "ests", &ests_ops },
+	{ "errorcode", &errorcode_ops },
+	{ "didvid", &didvid_ops },
+	{ "ver_emif", &ver_emif_ops },
+	{ "scratchpad", &scratchpad_ops },
+	{ "e2sts", &e2sts_ops }
+};
+
+/* sysfs file handles */
+static struct dentry *slaunch_dir;
+static struct dentry *event_file;
+static struct dentry *txt_dir;
+static struct dentry *txt_entries[SL_TXT_ENTRY_COUNT];
+
+static long slaunch_expose_securityfs(void)
+{
+	long ret = 0;
+	int i;
+
+	slaunch_dir = securityfs_create_dir("slaunch", NULL);
+	if (IS_ERR(slaunch_dir))
+		return PTR_ERR(slaunch_dir);
+
+	if (slaunch_get_flags() & SL_FLAG_ARCH_TXT) {
+		txt_dir = securityfs_create_dir("txt", slaunch_dir);
+		if (IS_ERR(txt_dir)) {
+			ret = PTR_ERR(txt_dir);
+			goto remove_slaunch;
+		}
+
+		for (i = 0; i < ARRAY_SIZE(sl_txt_files); i++) {
+			txt_entries[i] = securityfs_create_file(
+						sl_txt_files[i].name, 0440,
+						txt_dir, NULL,
+						sl_txt_files[i].fops);
+			if (IS_ERR(txt_entries[i])) {
+				ret = PTR_ERR(txt_entries[i]);
+				goto remove_files;
+			}
+		}
+
+	}
+
+	if (sl_evtlog.addr > 0) {
+		event_file = securityfs_create_file(
+					sl_evtlog.name, 0440,
+					slaunch_dir, NULL,
+					&sl_evtlog_ops);
+		if (IS_ERR(event_file)) {
+			ret = PTR_ERR(event_file);
+			goto remove_files;
+		}
+	}
+
+	return 0;
+
+remove_files:
+	if (slaunch_get_flags() & SL_FLAG_ARCH_TXT) {
+		while (--i >= 0)
+			securityfs_remove(txt_entries[i]);
+		securityfs_remove(txt_dir);
+	}
+remove_slaunch:
+	securityfs_remove(slaunch_dir);
+
+	return ret;
+}
+
+static void slaunch_teardown_securityfs(void)
+{
+	int i;
+
+	securityfs_remove(event_file);
+	if (sl_evtlog.addr) {
+		memunmap(sl_evtlog.addr);
+		sl_evtlog.addr = NULL;
+	}
+	sl_evtlog.size = 0;
+
+	if (slaunch_get_flags() & SL_FLAG_ARCH_TXT) {
+		for (i = 0; i < ARRAY_SIZE(sl_txt_files); i++)
+			securityfs_remove(txt_entries[i]);
+
+		securityfs_remove(txt_dir);
+
+		if (txt_heap) {
+			memunmap(txt_heap);
+			txt_heap = NULL;
+		}
+	}
+
+	securityfs_remove(slaunch_dir);
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
+	u16 *alg_id_field = (u16 *)((u8 *)event +
+				    sizeof(struct tcg_pcr_event2_head));
+	struct tpm_digest *digests;
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
+	struct tcg_pcr_event *event_header;
+	struct tcg_pcr_event2_head *event;
+	int start = 0, end = 0, size;
+
+	event_header = (struct tcg_pcr_event *)(sl_evtlog.addr +
+						evtlog20->first_record_offset);
+
+	/* Skip first TPM 1.2 event to get to first TPM 2.0 event */
+	event = (struct tcg_pcr_event2_head *)((u8 *)event_header +
+						sizeof(struct tcg_pcr_event) +
+						event_header->event_size);
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
+	struct tpm12_event_log_header *event_header;
+	struct tcg_pcr_event *event;
+	struct tpm_digest digest;
+	int start = 0, end = 0;
+	int size, ret;
+
+	event_header = (struct tpm12_event_log_header *)sl_evtlog.addr;
+	event = (struct tcg_pcr_event *)((u8 *)event_header +
+				sizeof(struct tpm12_event_log_header));
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

