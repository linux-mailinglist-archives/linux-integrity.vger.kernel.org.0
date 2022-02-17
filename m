Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483944BBCAE
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Feb 2022 16:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237279AbiBRP7G (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Feb 2022 10:59:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236522AbiBRP7F (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Feb 2022 10:59:05 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E985EDDD;
        Fri, 18 Feb 2022 07:58:49 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21IFqotD014549;
        Fri, 18 Feb 2022 15:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=ZRL6UdEzyY+gh8bqVqzol7kynd2/TWQP6xJ9fZ8Itjw=;
 b=EdlekeKOfPd9RSqS+MLUO541mNT8msBGe9Ma7rJEHKNoQq6sQV20jjSrDmbAKFm7m01g
 eR8aiYPZ6BYUwgiI0LRXzJBJoIUMSAX08KULX5sREtNaX6aKsV/5YPKgHiir3UfXOP/n
 y185eZme0A5nD0/K8aOhWZvkZtwI2WlZVn4zgXWhOeZM5zWen7HTu22XPxfYLINgvRi6
 dbsNLNoWOcCk5jQk83PxlmSshu1s4Nf4iy0atTak5o2dOEpYNTsXAzfhXy6jA+JKsQ8N
 I6rW7B6Bcpp3Ac0VUIKGLkGn2LOgBZOh2lWU1M4d3H5Q4ukzWbDBUURXKze35n136lTG /g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8ncb1y21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 15:58:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21IFueW6062751;
        Fri, 18 Feb 2022 15:58:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by aserp3030.oracle.com with ESMTP id 3e9bre21c1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 15:58:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEeFFCWRcOgbYoYHaa7XumPamz+5DbLyjG2UOLihTFkBeE7OMQ31veoqMxE4jLat7ZzufLRCJQSzzoIdX8H5D2gZTNr5RJ+AIUeckCB45rjIpFkoVMHpPi3ygHImZItqO6NxjZtczeNzMynqwbpTAX5NjPWEglz+s5YK+++UrF4Sklc9LYJEalakUmtwuKIlnMSQgl4x0QbQmskQ12L7zaptpg4hLovXdXrNzaVU+kyG6rmMTUbaxcTNd5OZ+V8hzKKRkbiL/iIeopxqLa2djjeoHi2gmPnzmxgcjgL6f7VP4njc5BaDYWa0o2Zc2x9KXhAhTsg3VcQkuvs57/W5kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRL6UdEzyY+gh8bqVqzol7kynd2/TWQP6xJ9fZ8Itjw=;
 b=O+WKpgkwYv+whC8NOU3cQsFDtgsTmWFGg0OlWnp31zYV0x3QyqdzUKDSohnSjwPb5ztEBt61s/P8lgeLfo3C4UPAxHIcND4VSPl7/8TYhX6temlxdjwGhCDw+iX3Z8c8OLsBYdosub8R9QyfJMZNjoWlKXcl6wFEb3wGmUXQT3hNSJYZhkOHkuihoarXE4o24K7HL6S3wHVeBBiy3xpVg/8TIFFkpmABOYz6IhzlN6CRFArub6VHKSDH/vqyh4YlZvIP0uG0s5gYRK0TDMKCO3AYeZBXTultVGeeuEdQZS++0u/ZRdLow7w3Di5wrOIN4UVBcODsm9b7fd6FrXBArw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRL6UdEzyY+gh8bqVqzol7kynd2/TWQP6xJ9fZ8Itjw=;
 b=NzR4TcmjUE4wwgnaNCM6ZVyGRvLkT7DUnfHnG2D1C2/M4vyljMBR4uT+HA7cYejM2Pny3KuJ5t7VdzJHDG+U+zfNftLo/BLn7XOwrCkgMeMJ6I2Z9p7W56/iNrMLuKC+aO/6xqLLwUaQJiRK68nQTXVl9soFT7XEOPBoUE+PN6A=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BY5PR10MB4226.namprd10.prod.outlook.com (2603:10b6:a03:210::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 15:58:20 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::398e:10a4:6887:4e18]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::398e:10a4:6887:4e18%5]) with mapi id 15.20.4995.022; Fri, 18 Feb 2022
 15:58:20 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org
Cc:     iommu@lists.linux-foundation.org, ross.philipson@oracle.com,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v5 08/12] x86: Secure Launch SMP bringup support
Date:   Wed, 16 Feb 2022 22:54:41 -0500
Message-Id: <1645070085-14255-9-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1645070085-14255-1-git-send-email-ross.philipson@oracle.com>
References: <1645070085-14255-1-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0288.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::23) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e295b79b-c622-4c5c-5ab1-08d9f2f77c46
X-MS-TrafficTypeDiagnostic: BY5PR10MB4226:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB4226E0968823DB7CAE376C24E6379@BY5PR10MB4226.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d2kamqFIp7r25x8KXcNlcNKao4jG5yaVwNyGMelm86BX68/ZMso6KFsNleKon+fArUvMk5WQt0ForO7cjZAFjYk1wCpQI7dWc2fU6Dub+es1gai3jNbaze9PD5cUmXhLI6rJAE92P3enP6/BNIsfbhT/nq/+EJCQFLxot0cIfEA8l6nrb7NP6TS7mbpNtynd5uYlVhjJAhwhZxrjsdIlP/3YJN8cdb2ZtsvVydY17S9U8rVmKeDdrCLeiFIpV5SJzpXDTqhjsgd72tJD32sztKTyO8Agwj3fvlkqYdmo6C/SZpMT6eRINZBEzynV7OtrXBbLyWM5H3zPkTur+abcz34yVTh2p1pEwaGPQmIH0Lue2XiEqhukLEz+KPvwe1iQov4nEQrXisMhgCi3Dnua1IM9KXp7NGrbYWKRDjhpNRtJT35JBWpUGJbLbV3GjfVh5+YEIJ2J9nUXMZ5e4xUAP23WCePwCAs3tyQnxNbi5BfIv66cuh6m/GduuTvXuq92m7jbfJ/tsjRYy1/rSKXUj2GFkgiCkR+q59euMsv2t/XxQc1jLBMgegBJ28rmhv6gEZf+hLEclA2NqKW/rGAXm5Qd3SL6X1fyomgTkM68Z6o0UiQg11WC9InYzP+MaZ70UjPoNMmFB+qG9AC8GR+IKr2qXDNqQyuDEuC5ImI/8xQAIrCzQMQeSBTIeE5fAVEDeIMtO9WYUGEmafhRK5wzLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(44832011)(86362001)(5660300002)(36756003)(6666004)(7416002)(6486002)(52116002)(8936002)(83380400001)(66946007)(66476007)(316002)(2616005)(66556008)(6512007)(38350700002)(38100700002)(186003)(4326008)(8676002)(508600001)(6506007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BV9KNkbfZ7MoDv8YI6/h3KxHzrbHB5Uw9RHzCA7D+5oZh4yjTvhHjuXFhKC8?=
 =?us-ascii?Q?SHFNYcEiYH6TUK8NFpFd//UYOqhfg+WRL/MGvy+tzm4ARCIRHlC7Mw3CAotY?=
 =?us-ascii?Q?0CfDOxYBGoxtDxbifa9CCYHfQl21iO6NfdVSDfy42rSngg/1oBo2UFuYV11v?=
 =?us-ascii?Q?1Luhq2XNqxohBCQH4m/JlbEmuUKQ3pFe6+xJp+t/zrdy5COmfWDWdN2Ti7gi?=
 =?us-ascii?Q?RLOHLRauSSkmFNEoOp31qBdEaEMGGakrEX9wP/5YleTxdIEZimyT+wx8Y43x?=
 =?us-ascii?Q?kgjuGEtTlWga+nmM+o9GEIMnSXTLO8UiV2D4Fn2tI7AJIkKTVAvCBrr07ZSg?=
 =?us-ascii?Q?OwnWBi1sQh2DDLZDh5egCHJUjY3lprM+RgPQn2u2t5JEo9MOBab35xSqwWQR?=
 =?us-ascii?Q?NuW3WJEX/Ga95kNfyKuHBJrs80lL65xt20TU4HrrjNkGCXStN2EmNfcd4Czn?=
 =?us-ascii?Q?ScP0ZoMrVkWNmeqcKbk0BeBBED3M7Pl1AmPoP6rc0Xavvr/y4FykJOwuMDSE?=
 =?us-ascii?Q?bPsP7z2V4H+3hhkPQ+y+tDOETBTadupOYRbHi6k+5M+/58QsVJN2bgBSGQtv?=
 =?us-ascii?Q?a/1RMZxUJ9kqCrmSo3yMqjzTuEFMrzI3/Ilq2l5PKPnieFSlVXfJw0U02Tb/?=
 =?us-ascii?Q?LzW7QwP/jsmX96qj/wn/zv49U4VsZwLIQ26snFexQhfiS9WVMx1DqVhZS7KO?=
 =?us-ascii?Q?7a2163nCNXGXBLttPuOhlDk4bw/rb4iujz7dujcyG6QZvLGtaMs3zjeMQWkW?=
 =?us-ascii?Q?47WhG/oOShDYr8+2m87H2wqcl9QZyF3qgjYGgFlx9IGsooDr9H031QcLN8Ut?=
 =?us-ascii?Q?95XKX/4HNVR4sL8LMrAdwDs0sjzL3j++QOX4JwA7QXRl5eZshF1Yda0Yzcxf?=
 =?us-ascii?Q?iKC675dXRVEf9v6hvSCGyXMLppD/gkkPoBPZFo3R/nkl31RgDlJkCSPslT1l?=
 =?us-ascii?Q?0yNBAQuZ8zCCFJNW+RODRo4uvpX2yyqS8OiPgC7wAGe97BpMgymaHP0LnDmr?=
 =?us-ascii?Q?Hy4DVMCRH1qKjOYNalIODxi9DiNUuHiF9pT4OqNIIRrmanafDJ1soppEcFz/?=
 =?us-ascii?Q?mDFWsQemcQWusx2km7PSGKnqeI/ySYihlz80JJ6YLPghbr+bJtoejC89SlcR?=
 =?us-ascii?Q?otVNLIsruYszMjQyfinNh4keod2SVm6U/cECrXNKWdu6YvTzE7GPY/zVI0R/?=
 =?us-ascii?Q?04sBsrYXHPurhzt268OqXDIX1dOa6qeC9RYLq/qYfhe5kyCeAiKezRF6tP7A?=
 =?us-ascii?Q?V2WuxyN8DR+smI8qKssi3789xaIKE4qJVaj23DpT1XG+gJCCTgRZz258pLM8?=
 =?us-ascii?Q?hCk0xaDuiBVh2LMSfkAN7/dLkmmTSMgBf01bdgvAZeCJu5/koXgFRJDjMy4v?=
 =?us-ascii?Q?VKZQuBAwQsmQiA+OMkiUVxff/bhXuMbk+nnSYC5POEgvdhQaohN30qtd1nc2?=
 =?us-ascii?Q?M8+MInF0FDJhhhaev7py6enecdEGvwTqhsIAJSs1jJ0yCThDMY9MOYO2vlIH?=
 =?us-ascii?Q?wQcyL9O2V0BipnbM0bWyA0VmkIPYWSQGVxahDiJnsLEkd4R5gf1GhQGM8f+l?=
 =?us-ascii?Q?5muNdMRn6FUthMJ4zCfPG1cUoERJn4EmfsByiu2F28M4cEs9B/TMbXScE/3m?=
 =?us-ascii?Q?PRQuxP06UDFCIpxkwnuybUIWrJAdb+/eYXf5adpC//DLX4IgVUqCbGRVko9K?=
 =?us-ascii?Q?eLgZ8WwIGqMCfM4R8/1+3nHWhcE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e295b79b-c622-4c5c-5ab1-08d9f2f77c46
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 15:58:20.8121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ezxXZrhTjUmLZofHGHmkXq8dNVMohFkp6O3XrAhGBvnL3lEoVrWWGioFdTtzffTSvHTbB4YlTe1iQJTfFgX8GvclxI2YJU9bVz8AzoWIhbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4226
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10261 signatures=677564
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202180103
X-Proofpoint-ORIG-GUID: NBdW8sRhn5Q3gZy5v0rqgU5IPXOn7EN5
X-Proofpoint-GUID: NBdW8sRhn5Q3gZy5v0rqgU5IPXOn7EN5
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Intel, the APs are left in a well documented state after TXT performs
the late launch. Specifically they cannot have #INIT asserted on them so
a standard startup via INIT/SIPI/SIPI cannot be performed. Instead the
early SL stub code parked the APs in a pause/jmp loop waiting for an NMI.
The modified SMP boot code is called for the Secure Launch case. The
jump address for the RM piggy entry point is fixed up in the jump where
the APs are waiting and an NMI IPI is sent to the AP. The AP vectors to
the Secure Launch entry point in the RM piggy which mimics what the real
mode code would do then jumps to the standard RM piggy protected mode
entry point.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/include/asm/realmode.h      |  3 ++
 arch/x86/kernel/smpboot.c            | 86 ++++++++++++++++++++++++++++++++++++
 arch/x86/realmode/rm/header.S        |  3 ++
 arch/x86/realmode/rm/trampoline_64.S | 37 ++++++++++++++++
 4 files changed, 129 insertions(+)

diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index 331474b..151d09a 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -37,6 +37,9 @@ struct real_mode_header {
 #ifdef CONFIG_X86_64
 	u32	machine_real_restart_seg;
 #endif
+#ifdef CONFIG_SECURE_LAUNCH
+	u32	sl_trampoline_start32;
+#endif
 };
 
 /* This must match data at realmode/rm/trampoline_{32,64}.S */
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 617012f..94b37ab 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -57,6 +57,7 @@
 #include <linux/pgtable.h>
 #include <linux/overflow.h>
 #include <linux/syscore_ops.h>
+#include <linux/slaunch.h>
 
 #include <asm/acpi.h>
 #include <asm/desc.h>
@@ -1073,6 +1074,83 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
 	return 0;
 }
 
+#ifdef CONFIG_SECURE_LAUNCH
+
+static atomic_t first_ap_only = {1};
+
+/*
+ * Called to fix the long jump address for the waiting APs to vector to
+ * the correct startup location in the Secure Launch stub in the rmpiggy.
+ */
+static int
+slaunch_fixup_jump_vector(void)
+{
+	struct sl_ap_wake_info *ap_wake_info;
+	u32 *ap_jmp_ptr = NULL;
+
+	if (!atomic_dec_and_test(&first_ap_only))
+		return 0;
+
+	ap_wake_info = slaunch_get_ap_wake_info();
+
+	ap_jmp_ptr = (u32 *)__va(ap_wake_info->ap_wake_block +
+				 ap_wake_info->ap_jmp_offset);
+
+	*ap_jmp_ptr = real_mode_header->sl_trampoline_start32;
+
+	pr_debug("TXT AP long jump address updated\n");
+
+	return 0;
+}
+
+/*
+ * TXT AP startup is quite different than normal. The APs cannot have #INIT
+ * asserted on them or receive SIPIs. The early Secure Launch code has parked
+ * the APs in a pause loop waiting to receive an NMI. This will wake the APs
+ * and have them jump to the protected mode code in the rmpiggy where the rest
+ * of the SMP boot of the AP will proceed normally.
+ */
+static int
+slaunch_wakeup_cpu_from_txt(int cpu, int apicid)
+{
+	unsigned long send_status = 0, accept_status = 0;
+
+	/* Only done once */
+	if (slaunch_fixup_jump_vector())
+		return -1;
+
+	/* Send NMI IPI to idling AP and wake it up */
+	apic_icr_write(APIC_DM_NMI, apicid);
+
+	if (init_udelay == 0)
+		udelay(10);
+	else
+		udelay(300);
+
+	send_status = safe_apic_wait_icr_idle();
+
+	if (init_udelay == 0)
+		udelay(10);
+	else
+		udelay(300);
+
+	accept_status = (apic_read(APIC_ESR) & 0xEF);
+
+	if (send_status)
+		pr_err("Secure Launch IPI never delivered???\n");
+	if (accept_status)
+		pr_err("Secure Launch IPI delivery error (%lx)\n",
+			accept_status);
+
+	return (send_status | accept_status);
+}
+
+#else
+
+#define slaunch_wakeup_cpu_from_txt(cpu, apicid)	0
+
+#endif  /* !CONFIG_SECURE_LAUNCH */
+
 /*
  * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
  * (ie clustered apic addressing mode), this is a LOGICAL apic ID.
@@ -1127,6 +1205,13 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
 	cpumask_clear_cpu(cpu, cpu_initialized_mask);
 	smp_mb();
 
+	/* With Intel TXT, the AP startup is totally different */
+	if ((slaunch_get_flags() & (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)) ==
+	   (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)) {
+		boot_error = slaunch_wakeup_cpu_from_txt(cpu, apicid);
+		goto txt_wake;
+	}
+
 	/*
 	 * Wake up a CPU in difference cases:
 	 * - Use the method in the APIC driver if it's defined
@@ -1139,6 +1224,7 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
 		boot_error = wakeup_cpu_via_init_nmi(cpu, start_ip, apicid,
 						     cpu0_nmi_registered);
 
+txt_wake:
 	if (!boot_error) {
 		/*
 		 * Wait 10s total for first sign of life from AP
diff --git a/arch/x86/realmode/rm/header.S b/arch/x86/realmode/rm/header.S
index 8c1db5b..9136bd5 100644
--- a/arch/x86/realmode/rm/header.S
+++ b/arch/x86/realmode/rm/header.S
@@ -36,6 +36,9 @@ SYM_DATA_START(real_mode_header)
 #ifdef CONFIG_X86_64
 	.long	__KERNEL32_CS
 #endif
+#ifdef CONFIG_SECURE_LAUNCH
+	.long	pa_sl_trampoline_start32
+#endif
 SYM_DATA_END(real_mode_header)
 
 	/* End signature, used to verify integrity */
diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
index cc8391f..cdfc2c2 100644
--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -104,6 +104,43 @@ SYM_CODE_END(sev_es_trampoline_start)
 
 	.section ".text32","ax"
 	.code32
+#ifdef CONFIG_SECURE_LAUNCH
+	.balign 4
+SYM_CODE_START(sl_trampoline_start32)
+	/*
+	 * The early secure launch stub AP wakeup code has taken care of all
+	 * the vagaries of launching out of TXT. This bit just mimics what the
+	 * 16b entry code does and jumps off to the real startup_32.
+	 */
+	cli
+	wbinvd
+
+	/*
+	 * The %ebx provided is not terribly useful since it is the physical
+	 * address of tb_trampoline_start and not the base of the image.
+	 * Use pa_real_mode_base, which is fixed up, to get a run time
+	 * base register to use for offsets to location that do not have
+	 * pa_ symbols.
+	 */
+	movl    $pa_real_mode_base, %ebx
+
+	/*
+	 * This may seem a little odd but this is what %esp would have had in
+	 * it on the jmp from real mode because all real mode fixups were done
+	 * via the code segment. The base is added at the 32b entry.
+	 */
+	movl	rm_stack_end, %esp
+
+	lgdt    tr_gdt(%ebx)
+	lidt    tr_idt(%ebx)
+
+	movw	$__KERNEL_DS, %dx	# Data segment descriptor
+
+	/* Jump to where the 16b code would have jumped */
+	ljmpl	$__KERNEL32_CS, $pa_startup_32
+SYM_CODE_END(sl_trampoline_start32)
+#endif
+
 	.balign 4
 SYM_CODE_START(startup_32)
 	movl	%edx, %ss
-- 
1.8.3.1

