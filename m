Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF2A277497
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Sep 2020 16:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgIXO7L (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Sep 2020 10:59:11 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55920 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbgIXO6k (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Sep 2020 10:58:40 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OEtNw4037511;
        Thu, 24 Sep 2020 14:58:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=qOx/WyIlX35flcYkRZF1E+iVsPY37zuDH5frIC2qMd0=;
 b=QOMLsak1AaK0UlwuJY54v7vqFZhJeJDEfG7OAoqaAdCwdOpo3GmutTgMAFVB7qwZLybv
 LP1GDNgDy72KIPR9c5u5zDWZNIPgY2WhFP2rz+V0blWtmy1YG0XKU+g8HJhvwNh5H3/o
 VeN40E9SUsjzYa2/loEK0YmoJ2cTLk0RKpOs9kj8RpI33Nx+9ZXsojGB5wjqYW7Z0RVH
 s8StFAWWGl3+4xAJI9P4CclJizomjyNFmrvSs0ogBG3O31dYYWs1awf3drMkPZxL4R4v
 +8M/2KuBH/LTtlGn/0bzvHXFZqssU/NjKe2Vj3LaMVbnkUUYxf7KV77I6geveHAYwhnB BQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 33q5rgq588-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Sep 2020 14:58:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OEuTdp096380;
        Thu, 24 Sep 2020 14:58:19 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 33nurw9x6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Sep 2020 14:58:19 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08OEwHYF000852;
        Thu, 24 Sep 2020 14:58:17 GMT
Received: from disposition.us.oracle.com (/10.152.32.81)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Sep 2020 07:58:17 -0700
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, trenchboot-devel@googlegroups.com
Subject: [PATCH 11/13] kexec: Secure Launch kexec SEXIT support
Date:   Thu, 24 Sep 2020 10:58:39 -0400
Message-Id: <1600959521-24158-12-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1600959521-24158-1-git-send-email-ross.philipson@oracle.com>
References: <1600959521-24158-1-git-send-email-ross.philipson@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240114
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Prior to running the next kernel via kexec, the Secure Launch code
closes down private SMX resources and does an SEXIT. This allows the
next kernel to start normally without any issues starting the APs etc.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/kernel/slaunch.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++
 kernel/kexec_core.c       |  4 +++
 2 files changed, 74 insertions(+)

diff --git a/arch/x86/kernel/slaunch.c b/arch/x86/kernel/slaunch.c
index 7bdb89e..b2221d8 100644
--- a/arch/x86/kernel/slaunch.c
+++ b/arch/x86/kernel/slaunch.c
@@ -784,3 +784,73 @@ static void __exit slaunch_exit(void)
 late_initcall(slaunch_late_init);
 
 __exitcall(slaunch_exit);
+
+static inline void smx_getsec_sexit(void)
+{
+	asm volatile (".byte 0x0f,0x37\n"
+		      : : "a" (SMX_X86_GETSEC_SEXIT));
+}
+
+void slaunch_finalize(int do_sexit)
+{
+	void __iomem *config;
+	u64 one = 1, val;
+
+	if (!(slaunch_get_flags() & (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)))
+		return;
+
+	config = ioremap(TXT_PRIV_CONFIG_REGS_BASE, TXT_NR_CONFIG_PAGES *
+			 PAGE_SIZE);
+	if (!config) {
+		pr_emerg("Error SEXIT failed to ioremap TXT private reqs\n");
+		return;
+	}
+
+	/* Clear secrets bit for SEXIT */
+	memcpy_toio(config + TXT_CR_CMD_NO_SECRETS, &one, sizeof(u64));
+	memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(u64));
+
+	/* Unlock memory configurations */
+	memcpy_toio(config + TXT_CR_CMD_UNLOCK_MEM_CONFIG, &one, sizeof(u64));
+	memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(u64));
+
+	/* Close the TXT private register space */
+	memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(u64));
+	memcpy_toio(config + TXT_CR_CMD_CLOSE_PRIVATE, &one, sizeof(u64));
+
+	/*
+	 * Calls to iounmap are not being done because of the state of the
+	 * system this late in the kexec process. Local IRQs are disabled and
+	 * iounmap causes a TLB flush which in turn causes a warning. Leaving
+	 * thse mappings is not an issue since the next kernel is going to
+	 * completely re-setup memory management.
+	 */
+
+	/* Map public registers and do a final read fence */
+	config = ioremap(TXT_PUB_CONFIG_REGS_BASE, TXT_NR_CONFIG_PAGES *
+			 PAGE_SIZE);
+	if (!config) {
+		pr_emerg("Error SEXIT failed to ioremap TXT public reqs\n");
+		return;
+	}
+
+	memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(u64));
+
+	pr_emerg("TXT clear secrets bit and unlock memory complete.");
+
+	if (!do_sexit)
+		return;
+
+	if (smp_processor_id() != 0) {
+		pr_emerg("Error TXT SEXIT must be called on CPU 0\n");
+		return;
+	}
+
+	/* Disable SMX mode */
+	cr4_set_bits(X86_CR4_SMXE);
+
+	/* Do the SEXIT SMX operation */
+	smx_getsec_sexit();
+
+	pr_emerg("TXT SEXIT complete.");
+}
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index c19c0da..6b9ac11 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -37,6 +37,7 @@
 #include <linux/compiler.h>
 #include <linux/hugetlb.h>
 #include <linux/frame.h>
+#include <linux/slaunch.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -1179,6 +1180,9 @@ int kernel_kexec(void)
 		cpu_hotplug_enable();
 		pr_notice("Starting new kernel\n");
 		machine_shutdown();
+
+		/* Finalize TXT registers and do SEXIT */
+		slaunch_finalize(1);
 	}
 
 	machine_kexec(kexec_image);
-- 
1.8.3.1

