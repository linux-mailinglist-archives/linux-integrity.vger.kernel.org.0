Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCDF3F9976
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Aug 2021 15:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245191AbhH0NWC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 Aug 2021 09:22:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:24184 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232220AbhH0NV6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Aug 2021 09:21:58 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17RAFI2e015048;
        Fri, 27 Aug 2021 13:20:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=3mdbDIv/S/lggxNYRfzq4aRZ4D5Sk/xd9kkDvIMPGfM=;
 b=Y7b2fw0ClhgxXcmvQ8h0dayz2aqc9XPQpGAZmftbrHAyByoIlGOnz6Z5SmYt0vtiCX3a
 VJINjrBbsZ8npRnxxce+M0W7cBP31aUrILM8u8x0dVLzXBh2GBiNJtT1xAcjLuqdwuHU
 ZjZmrcojAkvgXXSH4/X0OHVyPT8doKo2FNiOsmn07XZmI1xWyVOcDbvENkqcMdfeU6ln
 M8QHVfmu8ID/luzwoIC5iHzKE+9Xn8oPZLG9SUd3cA6alqak21jxFLTrVyawZ9pnE5i7
 5A3cLHNUfYMqlVeLlO7Uv8t2HMREC6dH2Y5iAdtUzqXN/Q5yQB4ojp/xbbguxozINET5 kw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=3mdbDIv/S/lggxNYRfzq4aRZ4D5Sk/xd9kkDvIMPGfM=;
 b=CKvss5LwyT5N9SrHEQIWm9FNIKY+/qRciGMCDm/k7Yhc/ZbX2Bb9C5MPfPrBma20p5yI
 T4U2HCZNoy0L9BfetpIFF6cAe8wkaUFD9on0WBLvq+cUubk/jLuOJY80x/IrgE32cFQQ
 mrh1TQx8tOcf1tTJiv6CJ6CDhA3Edi8sSwjJ9EcbfocngTD0lhR/cMOw0O+x/6qmHlEH
 CKqKRPL/fiNLaQ0KWm+/FLF8EoCcA/+xwCmpb61Uuiij3+x2aouN6KZZ+GRB9x1Eqqgw
 QPntTr6D8FNWl24wUFY8+S4fEq5EP2OQpHN08WG6VpipKTqTroH8j/xsf7Za3mEONz9g tA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ap4xv3gy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 13:20:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17RD9nxI076969;
        Fri, 27 Aug 2021 13:20:56 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2044.outbound.protection.outlook.com [104.47.51.44])
        by userp3030.oracle.com with ESMTP id 3ajpm4pqdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 13:20:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXXRoHhiFjJzrVS0jy7ldSWiAcibiAOXr+Jl7KAjeNgoZNSweQbyMiPcA0Z57PSnLN+6e3bx+Bc6p/1gRGUKamhOW+Qsop48I2FRZrLamBjnXjPdPrkBAmZsBMsiuxbk8uS5EIXAuxCiGiLZW+ollW+3upOsoQKgtl0Fk4sFaRSsnjQGfyMI9XeetKmdZjnTZZay+3cs/pFLJ+efg+Ths9gnYekjW3f0hZyW6pmEM5Z/F8HlJaODWhU2tC6Esj5vaTUhBB9yA4znLTPM7vgan7+jzbcLxhwinhYdNpzAw0yq9twraJPZ2fsy+5TKbLGAO73mJkpXdfce9wap4gA6cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mdbDIv/S/lggxNYRfzq4aRZ4D5Sk/xd9kkDvIMPGfM=;
 b=ZrYsptW97TUS52j3jndTIK6s8FUP1AGq82eJMD128+ZMTm4AF0EK3Bastd0X6VlTmF4rM1RxMQvjen+SPQ9xIxZg8asRbfWL74AZB+NLWN8XE4cJR84FZl5sJ0M/mhSwkf8ICLMrtZ9rbecK6eeumMFrJPt3IjdfqD/GDFow0h8ejBh6TNeM4O5TEomdxunIyzspJONOauKPn5KfrKFYFEcqISYBgc/HJ8OfS0zkgUhcxTyPeGJBBwqIMbI/CYOSopyvwEWRJCjM7Pt3HnqWhFzIQtcilVHmaLAQ7BDwaa2b/0DZGrYNaGjlP5Ow+jXd2QouJPAuO7rrEZ4Jlm1Gpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mdbDIv/S/lggxNYRfzq4aRZ4D5Sk/xd9kkDvIMPGfM=;
 b=RTh5ieozoT66RDDMQUakKFnYvZpCD6GM4Hc3MOnQVggnNx11SE4AfJCXNNCZiCamN0L2rGn7RWHisrs8lmqxGjBJVtP+0rtNa5NJJcf8p0C9W/7foqsgzDT7JqzAmiWpAVDtv8TXqB0TKH5zhbE5M8Zemkl4JCFv1TWBaZJXykQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BYAPR10MB3237.namprd10.prod.outlook.com (2603:10b6:a03:153::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.23; Fri, 27 Aug
 2021 13:20:53 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3%4]) with mapi id 15.20.4457.020; Fri, 27 Aug 2021
 13:20:53 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v4 10/14] x86: Secure Launch SMP bringup support
Date:   Fri, 27 Aug 2021 09:28:33 -0400
Message-Id: <1630070917-9896-11-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
References: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:805:de::24) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lateralus.us.oracle.com (209.17.40.45) by SN6PR05CA0011.namprd05.prod.outlook.com (2603:10b6:805:de::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.8 via Frontend Transport; Fri, 27 Aug 2021 13:20:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30344e5e-0645-4f3c-3aca-08d9695d7f2f
X-MS-TrafficTypeDiagnostic: BYAPR10MB3237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB323742D99EEC81A66C090422E6C89@BYAPR10MB3237.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wSlf+AwXNdZ3BOAIKX2C48GHe33DwqC70wgwJIn230r0IuMVM84aSaqb3b64A9gicBZgAYgy9ZSpaQF/rObTpgUYfyN0FS5POu++9w+tqOrKTeOwvCxjHA2KuQsPQbcsMH/5LKO9meV67FqyWXtYl08s/DiC8yGG1J/po0rWehnTC7DUm01YKROAJ1t6jfyVElnP2RulXA946LrUZjoUuVVkJPyhOM1XdeDbQK+FQLZLoahOPkkjgEzNwVMXb0wn9dS9++cRvIJ0JuLGNmPkZyWnTdHnpp+UXRXHLAFmJRtxpfcie3yh8CBCcLwPCe0kJVNtmE5vE4xvWVPfXjuf6q40qzm40DCVZyQtnJZ+AKwxBEpY90biBcrLvKOR5bd80f90uNAejDr/SbNhGXZGFap/dB34bApRpdbxLP0yQNQhyg6hLSDV/R//wLOBwhbaYDv18X7L3a2RpK1WVap6rA1VUNGRKbQLfo6vKBHVllMbAt87YImdyti1KXSHvPDpqLpQQVyiNxsUCxMKzFowpYgdFM26cG/xSCnZU+44JODagiQNKlceo10dQXfgEiQvWDVGvfDSYAdPvSDP5642SAJ9dM3CcgZGQl1+WBSBmht/Gwm5f00HuXEHsBRs3/rnxLvSTHex0n7OX9TKI+lVmHqJEttvYtnEx26NLCgAAumZ51Ca6yOcEZ0lVyeNA4rVCZuNajoIQpwsKa0X1oTFPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(346002)(376002)(396003)(956004)(44832011)(2616005)(2906002)(52116002)(26005)(7696005)(478600001)(38350700002)(38100700002)(6486002)(36756003)(186003)(83380400001)(6666004)(86362001)(8936002)(8676002)(316002)(66946007)(66556008)(4326008)(66476007)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PI210alAE6hhx5BSVADkeg6UMDw6eRId92rWG4bhFAUt6MJrmuyAAPAKL8B8?=
 =?us-ascii?Q?bHNb0uWJ3doYY100jkRdFO47bLQbzhom46qau9T2+JrVNexiXBqdCjrjlW6w?=
 =?us-ascii?Q?UIP2oHS0nFrRLchdiREE3eSklYX+cdYgLh+w9M1rd9R7eBO8mi7XJlNhUlAW?=
 =?us-ascii?Q?5yhncmXskfiIhWK3w24/pEM3GWsZdTocgmvPaAx+fJnaQfWzqvgMcu9qC8mk?=
 =?us-ascii?Q?ZGmvyLZTa3MVE9gUazNv46WuZYV9xTRvTsPME27rT74ctsu33AT5G92+NV7n?=
 =?us-ascii?Q?AXZO53BVKtFBNpEVHSfydvbS/rt5M0BPqQpxnFkWv9FmZFkiGuVcaJScA2W4?=
 =?us-ascii?Q?3Us8cE80tsYnxfCnPJnSjSNblDqpNcqOwZGGTwH4lEzGvw0v4JAmf9h95Vek?=
 =?us-ascii?Q?DH2WKyAVVyMhExMfyBBgvSq9Qlw5vt4TEpYKzN5gLGVZqzN/+ukC33MyQcrZ?=
 =?us-ascii?Q?/Xqcg8KjEimZmYX4hBxUWWgE3VmtaIxDfcDBbapRdpMJR68whIo5iIpNm0TV?=
 =?us-ascii?Q?ZFp6eGxHFjzQsQnV7cCvNnflz7kOEEXU6pU+sRMuSu3bPC0fSaOfEE6Is2ef?=
 =?us-ascii?Q?cEt+dJzrbYvBPWwmSmvRF28/uc6rdqj4vuIt3n2nMDn0queDbvmB+GRj5zJX?=
 =?us-ascii?Q?1fdUJv/87ozdz8wHOEJu9EDh+lFGXXSi05zE/al5elWl7yv0LSjaSVtHkwg0?=
 =?us-ascii?Q?mDT9CU3o4Z5pkP83EaU/exR0tUEwFLej0tUfV/eu50Gc236XR0tXTl17Itdj?=
 =?us-ascii?Q?JP5TT71grsu95rmQtHqhrtT62aiz60GPpqe8CmG3FgLPdDCt8yiSRauD6MvS?=
 =?us-ascii?Q?S/SeAQRYAy8x8blIPPswGdIQvqUSnMsOhcQvVWJvyLVshyPt9/Lu5lSOxby2?=
 =?us-ascii?Q?U8GN7B6/JhdMvZ5CdDbaXL7dbB9ECJvrGmZnNizUnQZSRvc6pKENi2JjzxNB?=
 =?us-ascii?Q?DZFWvQes2aMiXgnKfI0omsloSnd9CXAaP+bIdIJhCbaHdmim0QYvBdvBEBnU?=
 =?us-ascii?Q?CRb9gDbNEfqt7JpbN/ejYPc6o3mQ+ApXK/9Xj80C6N54ZoMOFMLtnYCJYdO1?=
 =?us-ascii?Q?fP1zNwrFDNxJ90vPlvmhCn6D7qsRhtRRVLf1M4ulZ2OUQwVZU1Jx2rghqme1?=
 =?us-ascii?Q?WIuLga2BgIRPHArcxyGBKvzb5Mx8jFFjK7HiAZF7HGnZMAr8Bb0tvzaJijf3?=
 =?us-ascii?Q?wp3aqiqrWQhx8SLJHGy9FL44St+V/8/Fpiosqad9BOUdDITTthQDhqfrzhAw?=
 =?us-ascii?Q?hmO1Hl/7FsY4/hjBRXvB4r+1poUX5Q1RNyAQ1rwvP/pAoMOyU7BFeN4RFr/K?=
 =?us-ascii?Q?BzFZ0zSnPYi1EyzJ217RjDQW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30344e5e-0645-4f3c-3aca-08d9695d7f2f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 13:20:53.7641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vV/zrwafi2I1ehU/MCVRcNXnvztVkWFqdL0VGDOLYY89sgsQSnr9c6bFV7QEHNXIgmfk9mtD/pqvC9myYtWsRSDd9WOJVMVnJ4/z37O6kwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3237
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10088 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108270086
X-Proofpoint-ORIG-GUID: JHwHtlovlIysZaQk4R5kZXmJwe-6siw9
X-Proofpoint-GUID: JHwHtlovlIysZaQk4R5kZXmJwe-6siw9
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

