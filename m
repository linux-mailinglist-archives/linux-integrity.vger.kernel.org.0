Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B543B3E49DA
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Aug 2021 18:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbhHIQbz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Aug 2021 12:31:55 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:5216 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232993AbhHIQbs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Aug 2021 12:31:48 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179GCKSu013022;
        Mon, 9 Aug 2021 16:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=3mdbDIv/S/lggxNYRfzq4aRZ4D5Sk/xd9kkDvIMPGfM=;
 b=lOZEUzr5U88DANn9ExXXuYC2StFd5opBQ5tM6YgmLvW+lMDJMyYKwaIfCgVDoYM+aKpx
 LgFXJRBsx0G4dMtTxjoS8QZdPblF3xC5gzqluoNehWUi2dz7Pr0mqIp/M4ynXMks7Tfj
 Fmq4mSMl/Ax+65FO4LWWLRY5Nnl8Gk7kx6CvW4pROQ7nNzIiNoXY9gjp47PR6WwlQgES
 XVY0RuYcw8XEAyrcCKg+602pTbu8ITCESK9ZjAECrhcG3KCagTgcQ5Ug4EByVcAKAOxF
 hNv4D40wq3JR2jkf1sktEQ/mMwvvn9YVc5u9vuSCeZOVM1ddcSURPxSjllv3uYUCf7uZ hg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=3mdbDIv/S/lggxNYRfzq4aRZ4D5Sk/xd9kkDvIMPGfM=;
 b=LvLXHKV9X9mK27XoltfZuv3aE0+FWoTUvxbuuXpLSoy33TnH9qciGyVA7KJYmq2DjqLc
 SufOzuwbKvvcRIiy2ATEHcAwXJuOnxQruNY1FGdaHCz5mFAC3T8Q3coWHAkZFawJrRbw
 i5qEhb168Zvpx1jBagcxJnB4O2YP7Zc5TV1N6vQT3AW3QiGwavWVY7BlLn6XQcDSLcTj
 ktaf5pgr9p0eb37fJW47EFOPOosBPXemns16Ycg9kak6gmY/KkIbJPqjH2vtxiDVV6L3
 eRnddAg0OAaZjDGoxL/9ijHxTLz8Uf7EVsC0OfH+Ms6yinF7lNptia5+hTAsEJfm8VAG 4A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ab17ds2f7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 16:31:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 179GUeF5066407;
        Mon, 9 Aug 2021 16:31:02 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by aserp3020.oracle.com with ESMTP id 3a9vv3860c-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 16:31:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFW/oS6vGhaP660qtUnp5r33gwWDcprPK2b418S4c2mOJIviqc24QrmeMHm26PkuWfw+Durn1Its5Uhl2aRAgFnWV7fSF6yVWJkguehMNH2cGFJxMwc9Vb2DPLIdjhl6IUWh1+BVJEeIQleaTg688HXlO5bQ3Qki/b0hWxWp8KomFggws9unDM7rL63wvqTyv16kbGvjOW8K8m3+zi41bB+UoG/VCz467De6FasDIcu4I6miVXNDLfCMTTrBccLIchQufBL9enIEYEv5/F0BzlPM9lpYe34cWcI0vtH2OqI/ElhJfsqpc1pqK2/+REH4f1L3D+Vjq2gMUu6g7its+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mdbDIv/S/lggxNYRfzq4aRZ4D5Sk/xd9kkDvIMPGfM=;
 b=caoVcJD/0dhF2um7HerAgtTN/sBgTRJu6XcgJk1QGl6ZcTBCM1t8vxw7KIxF/jJtXGVPijwbwouar67mVutGlcn4QfFOwRa5BAIXzda3YH73g9m+EBYKpIr0Qh3epHFuUvEp9Ne2rtmOdZPEJ7JxNWFumQ8jdNtktGL+RQ1IEOEuTtPwtMkEQQHqDf1YmC9wh8Cjx8RGzT7xjxL7qiNfG9TISBTPN6BijDumLbLQEV/pz8JsIvaEpkWWOJKdforrZt+6gAZFa+++5ji+ErsfW5FUS5hFO3WF/TMmx3BzMrcqcmNjDRYNc0E2pq+mNraRCHragGOdPgO5F1wKfcHpew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mdbDIv/S/lggxNYRfzq4aRZ4D5Sk/xd9kkDvIMPGfM=;
 b=nyXFZoYfNy4TMkWGHAxoLuTMjNVCf5YEQjB0Kt2BGUYJAmUQ3F+BuvsIw4t9p+nM/HodOLiZb/BbGQEh5YbHeh1rCKezUtICMopC0shT83jse8zy4cPA7VrSxzjJWPWujzm3DvSGvcBekyTXxe7sQqQSJ5e79moMZs8Mnaz/NdU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BY5PR10MB3939.namprd10.prod.outlook.com (2603:10b6:a03:1f7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Mon, 9 Aug
 2021 16:30:58 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3%4]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 16:30:58 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v3 10/14] x86: Secure Launch SMP bringup support
Date:   Mon,  9 Aug 2021 12:38:52 -0400
Message-Id: <1628527136-2478-11-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1628527136-2478-1-git-send-email-ross.philipson@oracle.com>
References: <1628527136-2478-1-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:806:a7::26) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lateralus.us.oracle.com (209.17.40.43) by SA9PR10CA0021.namprd10.prod.outlook.com (2603:10b6:806:a7::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Mon, 9 Aug 2021 16:30:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fbd8d9e-33df-465f-803f-08d95b531113
X-MS-TrafficTypeDiagnostic: BY5PR10MB3939:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB3939E3D0ED4407DE87F77546E6F69@BY5PR10MB3939.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EYy8pcV9eiGK9E/wUQdH1/Fy/wwPWlqwGUhF0qQhck2tjN5C0U/uGL0MYgb/ZYMZlm+zHKxzs+b/cCdoXJX9nxiLVszKqwScnKr4Up0qzlxcoRuR5rcB5GqEN488J1BiYultDLpu+D+aWh7ht9D4aP39JSk5XVMwRmrUlOg0KXU9qyEg/RpqWtRyczOlrAJtK0oHruNjJ6OSt/hOf2Jgaa9Ujewi4hZ57tsPp8kopN/LdeWCb/gc7OOt6yWpPI98zI3C44Bf4PmfmbmcBGf6sV2s9D3+MszFRFrYmvF5A47rk/KZUZ0czQgf45V4VZKA+uq/HFL3H/N03K8jcVpKwzmluUi3syo5+jJPr0HcQShPe0bTNOj625ixsi7fWa0m4Hhkc3PLkKAjHjHsa0+wboj+DLv+0UK4UB+05XXhI+y6VzyBumXZFWt6RMnI1gN0bn0IUEu/JceP8Osmz0IOTgWqAGcoAvuf1ghlbRB7MCFj66MiPmpYFjsg/Wi/3S3v9jtb//ogoUMpVQZH2AGIXmTzT9Udoq9jT7dWKkWWuRHeiVIQKtG6N/lBF/hbtyQa7wK2glF6NfIuGg6D8pkRbGmzZZI6G53jVt7mBF235If1UXPJ9JdE2i/cLPhkKe24BrHN7qP/EQHw8G/+BfcelgRJP7alwDcQMj/DVgr7UwoY9NuJXQQ+pwzsm7stJX9hVRsjIgHHUeT33tCvRQbMYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(346002)(376002)(136003)(366004)(38350700002)(478600001)(86362001)(316002)(38100700002)(52116002)(4326008)(7696005)(7416002)(2906002)(6666004)(8936002)(83380400001)(6486002)(186003)(5660300002)(8676002)(26005)(44832011)(2616005)(66946007)(66476007)(66556008)(956004)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ei3CymM2pXg9r70Iaob0bK41wpP5lVhOGcHet/vWqKHzT58zJpwO2v4pknSu?=
 =?us-ascii?Q?rrePrSZMyMzZyBHu0av1Ex7bfQVUywfYC2Msc44GJptyC4V7+UJoE5c0DLMM?=
 =?us-ascii?Q?V5CzuLRBIzuA+iL+31w4h1EwSpP2wtr7cB2avLh4BHTE1kNSwwdlt/FPzTG5?=
 =?us-ascii?Q?+4KXVcFJV+MHu3Y0wmqpr3VMdOVAz7De1a26XKR8N/ofhBsKPi2OQmJkHwPH?=
 =?us-ascii?Q?uT3ojWzcn9XaJ8+yqyEP0/esVkXKUFT3xZvQch/kNcW809a9W8gmfZnwyWXB?=
 =?us-ascii?Q?4MWYoxD7EgSqlhQDZYyxMjT4dj2GrUHoI4by8WjIx0dYq+mNRM+xjBPoS8T2?=
 =?us-ascii?Q?lwuj0Hm8zZ0hgizXt1xRYHMHZ8+WEYmQtQdWN/I1MyMVdBCZriwLUfNbxKYK?=
 =?us-ascii?Q?BBfmrsuxgedD3S0ZVHew6daH4+AbSXfOFhRQccKXb+u9yPYACw5Eg77HjqvI?=
 =?us-ascii?Q?ynNdT3GkhU64SdW2R/eqx4mbqBDuy6dFzw0VaPGnceBIdAaUkcD3pKN35uLp?=
 =?us-ascii?Q?HJMzvvcaL1ad6rusiIQ5slDrSC/T6qhFeuJX2/y+FvNhijIU00KUiOnwzKK/?=
 =?us-ascii?Q?J8BBvm7dC7ZsHvf4jR3OLntv/TLM3COml9/ciRby3WM43/sHGZhcmg96lo6E?=
 =?us-ascii?Q?0B8F85Lin/aYGAAazCU8hM9m4/Zz495ifQvEFayK5KfcKBy+ecB+fBIfsVMs?=
 =?us-ascii?Q?oEx/YUFBzbSDIoPGc6LCEMqEpXpucXiwTarD4DTPBBw/aHULdAXjXuX04mWt?=
 =?us-ascii?Q?aSkJ9MUgqY/6eQP95+bqQ+6KCuEDuS7T9I2nJ3aatwRZBn2+NjxyNz4BOXOc?=
 =?us-ascii?Q?qFlYsWqoVuFEbB18YwEW/TB4ME5g9ZwvA/J1dD3KY0/iTT/gv2cyzmTsaNIz?=
 =?us-ascii?Q?N62Yr+j4j0ZCGeeChDsAYb/gD6koAp0PAuJSTMyQZj7q6wzoRJOy3VTw6RTO?=
 =?us-ascii?Q?0dCGFMFAsNeqB606Mcc6ZkLopV0v2PuLXKcbg42AEHj/0PUsNs/3MGixZJ+d?=
 =?us-ascii?Q?2dyXqg2xmQTZrWaSFaDfH005Sy4HPWcCDcgi7wQip0Jq31s4Ca4R0M5MpdO9?=
 =?us-ascii?Q?HRLZ6yp4t8nAP+AzAX0jOyj9OPJ5otCfQEbJa7reer/WTqn5GQdYdh+Y38wL?=
 =?us-ascii?Q?MWk+J4JlO7R5insoFhfxwIQhZKJZiU4v1N5KzhorgY4PYmJxSikZVdBAWlLg?=
 =?us-ascii?Q?8+ARA/RsFFARZUObUwnhrMSLFmrDWlAXk+1WG93TQePIMLe3+pKFxS6BBv2w?=
 =?us-ascii?Q?5eOm2iX9sg3nZ2D4Brl0PnS7IIpgbQGGIqh/Cp4XxtboPEESEEVko2yl4430?=
 =?us-ascii?Q?A/MgTOwmYw18KBRAsea9nvau?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fbd8d9e-33df-465f-803f-08d95b531113
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 16:30:57.8018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G0cVw7PAP/580Tu+TCNPZHvBzUG/aN/AnaxLmPWAozuVdO1ARw8UDikZxylXSY2XFM3sE25VbPFMb1+D853BK7w8QIrXAMQqW+yQL4wopQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3939
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10071 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108090119
X-Proofpoint-GUID: 0t4LhumDqB1Fxd4AyjDpw6gKQsb4aeK8
X-Proofpoint-ORIG-GUID: 0t4LhumDqB1Fxd4AyjDpw6gKQsb4aeK8
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
mode code would do then jumps the the standard RM piggy protected mode
entry point.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/include/asm/realmode.h      |  3 ++
 arch/x86/kernel/smpboot.c            | 86 ++++++++++++++++++++++++++++++++++++
 arch/x86/realmode/rm/header.S        |  3 ++
 arch/x86/realmode/rm/trampoline_64.S | 37 ++++++++++++++++
 4 files changed, 129 insertions(+)

diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index 5db5d08..ef37bf1 100644
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
index 9320285..aafe627 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -57,6 +57,7 @@
 #include <linux/pgtable.h>
 #include <linux/overflow.h>
 #include <linux/syscore_ops.h>
+#include <linux/slaunch.h>
 
 #include <asm/acpi.h>
 #include <asm/desc.h>
@@ -1021,6 +1022,83 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
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
+	pr_info("TXT AP long jump address updated\n");
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
@@ -1075,6 +1153,13 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
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
@@ -1087,6 +1172,7 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
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

