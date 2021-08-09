Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8363E49F4
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Aug 2021 18:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbhHIQcN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Aug 2021 12:32:13 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:7280 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230394AbhHIQb7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Aug 2021 12:31:59 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179GCFrq013612;
        Mon, 9 Aug 2021 16:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=JrmrYv+4itrNkuyJVx9owj6FchfSRMm8+sp7P2G5ya8=;
 b=uhQPEi7R4kuCNuny6iK6wzhZUZwmfCZ9q6VeU6Vlh2yuJdXtVu+TDZvwmlavSUqVwVKQ
 E64GdfDGXBFZYpSG0x0zdFRj1io1yzEY5SZQgGTyBweD3MBW4pgvBD9wqvfsrMTevlk3
 Epuym2A8NCydzDmlrsA91ECyXwQD9fMAqv3t4qEbLKiFLPfyqShQjfAFhF7EQOch+KnK
 IhmNIAZnxSfGMQzAlEMm6qPF81JY5TMV1jwIfzBKJC8NDp6VlA43CaLVIm/tM9Q2pXoc
 3WGvxhB9n+5lvZg067g6eDr4ch2cE7VOc4SMlzxh6OeByGBp0qN79zKmNUf8AmWPoYke lw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=JrmrYv+4itrNkuyJVx9owj6FchfSRMm8+sp7P2G5ya8=;
 b=ZTeRSYNHxe95wroOa+yWSunU0Z9u4nLFLS631LgIlGD2/hDssnnmepPEZELWBs86LQov
 vIiGvCqUW0iqtoRFGLr72G2Q2fCSuIZBDuV3ySytWywWsy2r8tU882RyvjD4pyICtJS3
 pd+RXi07FDUM+X4L6KQLnxD3cilOwUcQ8OmWopo2+vcRFg6UilGMg6EMaPvkapJddR9S
 SQKmxTKRpq6fLlEtSUaCOhoi5xDDmzYQaK/MLMBHIVVndc1dmoXp7DZkZXQP5yXzdT0l
 CIESpn3V+VRvOaqzrMC/sADFZmNKhssd0oZ+ArkwYntI/ZLvCQQfR+8tG2IAuaL7t5NX Vw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aaq8a9sgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 16:31:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 179GUeF9066407;
        Mon, 9 Aug 2021 16:31:05 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by aserp3020.oracle.com with ESMTP id 3a9vv3860c-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 16:31:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnzBhEOzbfMCb/tXpLtmJXwpMWegM08TNF7eJIn3RQVmgJ4FwNEmrcylPqjGnpb/VKoADPlAZGQ53rBN9SND5VXsNXmvRKl8MnPruomVMkOfQuC19nJbxGEoPSnRNZ3lUNRtlTHZQutHKfWZfbDpikp1RXSjxbHap1gP1LtGxlpxXwI54Z7xykuCGtMQAHN7WRzSq2RpAgneM4Y1xMCR4TI60cb/4aLxcV2lTLscCykP9jiyCsKw2lU8+FE/dJGSKeYP80nSjtq4mgtf5Mi7LL8zvEFOCF1YOmwD1wA65Nx2Hj+uGVw4mIVwphZh9X5bL9igMbv3xspDR8frIBmztQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrmrYv+4itrNkuyJVx9owj6FchfSRMm8+sp7P2G5ya8=;
 b=kii5fPNj5aZyYf9q9JIdq5a8ghjMMT4yDGoEQQ4b6KdoPNSmtu5n6M+enDTBCMogYtbjUy+pXDGySHnRORi3oIG2SUL+1pJueQhmKhb7HJ8uprx9FionnGhAzGyVQ8m8oPPVZOIY2RnRZTYJ+ZB4qDKGic/FfYYLuYx7WU9ONWHQKwemRzLJDAGEWsxCUMnoWJmqBj8bjhSYIHBFQYmeUkJDa0qSswMF04mnj8Fih13y5ZDh68R9FwfGym40wYaAgoLFHQlG4ITOoMQu/KcNxvn2xpYrhXnpBkClTEs/POnuQl+2+gwuXYI9aIOqTFqGJiukzYbo7Eyp+075LKyLyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrmrYv+4itrNkuyJVx9owj6FchfSRMm8+sp7P2G5ya8=;
 b=rKM0ErxmttHhbzFn8hRT5Som/YBuCm6CMjl9+M5Loqq3Qaz3q69Z2ELpsDR+204uhmLPAbvCGD90CUEd7lF1Zwt4aQik5VJASyn9sqX5fMBt/fkY8+ZGgQMmg9SsQ7FhxowtfeEMkmboe5hreP/eLE6BYkSxomkSnjOE806upNg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BY5PR10MB3939.namprd10.prod.outlook.com (2603:10b6:a03:1f7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Mon, 9 Aug
 2021 16:31:02 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3%4]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 16:31:02 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v3 12/14] reboot: Secure Launch SEXIT support on reboot paths
Date:   Mon,  9 Aug 2021 12:38:54 -0400
Message-Id: <1628527136-2478-13-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1628527136-2478-1-git-send-email-ross.philipson@oracle.com>
References: <1628527136-2478-1-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:806:a7::26) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lateralus.us.oracle.com (209.17.40.43) by SA9PR10CA0021.namprd10.prod.outlook.com (2603:10b6:806:a7::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Mon, 9 Aug 2021 16:31:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2840464e-0ef2-4294-f1b4-08d95b53136e
X-MS-TrafficTypeDiagnostic: BY5PR10MB3939:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB3939D45652C950986854ECF9E6F69@BY5PR10MB3939.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UQhfvuSz4vwJ3hVhFTpQEhRoW+9cpUR+GqDLj19zh6W5D72uksfhIC/lV50bxhOzsTZ174T2qAEash9qCUghREtJ/wlEMqhnv/WucGS7UzWZmWTaagZ3LyvtNmNt4bYUCaoSouzmyTwd9PzHBKbfqKs1Jnp5S4DA7oHaVwPRPv9ngEzbXiFxr45oYykXrdPGSce1Cs5j7ki/h/+uwc3e0YoTCP0wyua9mwASt7Ojw/9CfpLuI+IUJZTimIemT1/qS9GtF27YqaiHwdPPbjTfz7rLO6U369Ty0pcfoFoJ5cr8tuNaMx4hIigcdYTfcWJY7i3H5khwS3mVv82raf3fJkBYoV4gT+L03Q/q5QLJMzT/592U81JJd2Vn90Qq5wbjrdU6hsWTTJIDcKhWPUjReSvtK7PF0P+jeVoiSpcIib01bQ1aZj2gTmXhg7jQEhoLvZE/XH1DxWtAnqsxh1pgPiMtN2j2eJGPHNvE/PFUoSVjQXs5FC3x0zWtSpieq1Z+3adjgAzJKQcfS/JisLDeAGwrizhObGI2DdfcU2j2E1/RdNbgEeDKdUzE2ndKN5iW818SZ7fMP/CAtixZa9pXCvA9WlE1YGokR20qNnlRz7LCljb5ABpHNTFPlbxECwtAcOuvit/uV8DxPOXCID3rnc4tW04ioU4sACxCbVA0v0LcK/ajKjJIY7DOHAc6Xy8vwpqHtIcfLYvA5W0F8wPy9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(346002)(376002)(136003)(366004)(38350700002)(478600001)(86362001)(316002)(38100700002)(52116002)(4326008)(7696005)(7416002)(2906002)(6666004)(8936002)(6486002)(186003)(5660300002)(8676002)(26005)(44832011)(2616005)(66946007)(66476007)(66556008)(956004)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YiGwWrx6HU0EM8M4paAQJt7IxPNqElcNgEkqnYfSLR7CGCSDq3+HvKYxKERP?=
 =?us-ascii?Q?HtGWgKyS5VRXVAac1AqohE2A+gIHeRz0dDi7VXM/d9082D6rgyMkf6nyhT+D?=
 =?us-ascii?Q?6O8fqw+rJQI1o6rnK5cD0qeTnUu3inhCQ8zNwRhZ1sH58ggkzAyU5WEvyaKX?=
 =?us-ascii?Q?yJe0CeetnILunA2Mv35MCbtqP4zZu7wb3J93aOdZXLnRAVvMt0e8Glj5hoUk?=
 =?us-ascii?Q?LJ7VFyuTuQjo1AHKNNiwQFOMcgSO3Sx+pCyOHRMSkuQl6XlZgVqnY3473f7O?=
 =?us-ascii?Q?/nxUEHjtfhirlOHLydxRzH+yPPX24jGFjmPCumgyXokGcyceGcUsa2KW+cXe?=
 =?us-ascii?Q?z4qPkSOyh9uYDjgvObfMf4dRs5+HzRpeDXhyCBnbRu/yZC9dgQOcRsV8D0YN?=
 =?us-ascii?Q?EbE9Prcib808utZx4O9Tse+0q6BVmJTAYctFHfT71qYjDX94vqCurcd94N+K?=
 =?us-ascii?Q?ZYosmNVByTDtreLIFlUx6GTf7ZpP0uzhnTd5M2ICOMbrOkZkEMWyjF+RrIl6?=
 =?us-ascii?Q?5CYrU7RiBLZRiTV5KH83ig9sPGBrRvrRxuociqeAUxN//PdHV7APdYM3aPQi?=
 =?us-ascii?Q?fk7nsvYkqx8SqNosudISX6zeUmTq7DaZy6O4O+QAM5gGU87KOvOFrzKDA8Qi?=
 =?us-ascii?Q?qDULWugS4O6neCkaC59gXbuop4sCk4I/Ba7PGKa/7jL9YY+jthMfrTmSamie?=
 =?us-ascii?Q?uf8LqghqRquYgkT1+s835C2d2KZ3GlSAK1r5EfxG9WYRRnOukzsuo2HoOrDH?=
 =?us-ascii?Q?bIYk/hKWfVK+WxwidhR1jDdOV0+wxuJSNRaHd3pr7B13gycxmCsJiHwx8ro+?=
 =?us-ascii?Q?n+kbXha04qYqVI8qi2zRs7Xk1FfIDDo3myXZF+n8uXz5Jts7e7iSUoMZjvG4?=
 =?us-ascii?Q?7C6UTvCqv2aQv3fSmJ7eKxM1goEzicbuqaocteVRn+l7LdH+/xlPZxmQnvOa?=
 =?us-ascii?Q?4XD81GUTV7AqJJetDX0KSKKJMO7wZmj84ZKKfcMwlI/pZVL5QuuGnyGdKFWb?=
 =?us-ascii?Q?OEwD0tWyotMzetSY+qYl6Eccoq1lKB54GNyuUZY06QlWjjDl0SQqoFvPXx6F?=
 =?us-ascii?Q?EXXmWQ4k4IcOqG6+qZpiV0zAui5NYl7SvCrQlIPwj3dJC5V9NsCqe8O9C42L?=
 =?us-ascii?Q?FWjy6ExfIp9IRhXnRUF4PUx6MY365abjYlAG+lEem5J3QLDp+gFQACM0Seu2?=
 =?us-ascii?Q?8nDb7FRucjSMjwlc3Os/Uc1dm7jVm6jf8Y2aQT6pu6tFGxMyyUdKxdOTRAcr?=
 =?us-ascii?Q?Gk88FWGV2BAGpicjR+Mgr6vTLfJEXrUeyKuVz9TUBmcUWeWEGBV1sxTW5gqp?=
 =?us-ascii?Q?g7sikQYsuqL/Pq4iAE9i77QH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2840464e-0ef2-4294-f1b4-08d95b53136e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 16:31:01.9534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4SvucfwjTBdUuCKuJ6rvx4Da4wQ/SN46wPhw9O054sdfNhswMGqFSVsnKUrg3KQH/nyk46mln6EYwjJmUU44H6TFkMcPU+lrNorY42depf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3939
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10071 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108090119
X-Proofpoint-ORIG-GUID: LTYda43IXtiaIuVmX189xikNcYVdq6NJ
X-Proofpoint-GUID: LTYda43IXtiaIuVmX189xikNcYVdq6NJ
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

If the MLE kernel is being powered off, rebooted or halted,
then SEXIT must be called. Note that the SEXIT GETSEC leaf
can only be called after a machine_shutdown() has been done on
these paths. The machine_shutdown() is not called on a few paths
like when poweroff action does not have a poweroff callback (into
ACPI code) or when an emergency reset is done. In these cases,
just the TXT registers are finalized but SEXIT is skipped.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/kernel/reboot.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index ebfb911..fe9d8cc 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/objtool.h>
 #include <linux/pgtable.h>
+#include <linux/slaunch.h>
 #include <acpi/reboot.h>
 #include <asm/io.h>
 #include <asm/apic.h>
@@ -731,6 +732,7 @@ static void native_machine_restart(char *__unused)
 
 	if (!reboot_force)
 		machine_shutdown();
+	slaunch_finalize(!reboot_force);
 	__machine_emergency_restart(0);
 }
 
@@ -741,6 +743,9 @@ static void native_machine_halt(void)
 
 	tboot_shutdown(TB_SHUTDOWN_HALT);
 
+	/* SEXIT done after machine_shutdown() to meet TXT requirements */
+	slaunch_finalize(1);
+
 	stop_this_cpu(NULL);
 }
 
@@ -749,8 +754,12 @@ static void native_machine_power_off(void)
 	if (pm_power_off) {
 		if (!reboot_force)
 			machine_shutdown();
+		slaunch_finalize(!reboot_force);
 		pm_power_off();
+	} else {
+		slaunch_finalize(0);
 	}
+
 	/* A fallback in case there is no PM info available */
 	tboot_shutdown(TB_SHUTDOWN_HALT);
 }
@@ -778,6 +787,7 @@ void machine_shutdown(void)
 
 void machine_emergency_restart(void)
 {
+	slaunch_finalize(0);
 	__machine_emergency_restart(1);
 }
 
-- 
1.8.3.1

