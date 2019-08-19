Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E04D9238E
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Aug 2019 14:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfHSMfb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Aug 2019 08:35:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19174 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726755AbfHSMfb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Aug 2019 08:35:31 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7JCXODp006202
        for <linux-integrity@vger.kernel.org>; Mon, 19 Aug 2019 08:35:29 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ufuepha8y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 19 Aug 2019 08:35:29 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.ibm.com>;
        Mon, 19 Aug 2019 13:35:27 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 19 Aug 2019 13:35:23 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7JCZMM751773480
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Aug 2019 12:35:22 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C49A11C054;
        Mon, 19 Aug 2019 12:35:22 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F354311C05B;
        Mon, 19 Aug 2019 12:35:19 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.80.231.242])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 19 Aug 2019 12:35:19 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linuxppc-dev@ozlabs.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Eric Ricther <erichte@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v5 1/2] powerpc: detect the secure boot mode of the system
Date:   Mon, 19 Aug 2019 08:35:07 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1566218108-12705-1-git-send-email-nayna@linux.ibm.com>
References: <1566218108-12705-1-git-send-email-nayna@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19081912-0012-0000-0000-000003405B8D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081912-0013-0000-0000-0000217A7B9C
Message-Id: <1566218108-12705-2-git-send-email-nayna@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-19_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908190142
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Secure boot on POWER defines different IMA policies based on the secure
boot state of the system.

This patch defines a function to detect the secure boot state of the
system.

The PPC_SECURE_BOOT config represents the base enablement of secureboot
on POWER.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 arch/powerpc/Kconfig               | 11 +++++
 arch/powerpc/include/asm/secboot.h | 27 ++++++++++++
 arch/powerpc/kernel/Makefile       |  2 +
 arch/powerpc/kernel/secboot.c      | 71 ++++++++++++++++++++++++++++++
 4 files changed, 111 insertions(+)
 create mode 100644 arch/powerpc/include/asm/secboot.h
 create mode 100644 arch/powerpc/kernel/secboot.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 77f6ebf97113..c902a39124dc 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -912,6 +912,17 @@ config PPC_MEM_KEYS
 
 	  If unsure, say y.
 
+config PPC_SECURE_BOOT
+	prompt "Enable PowerPC Secure Boot"
+	bool
+	default n
+	depends on PPC64
+	help
+	  Linux on POWER with firmware secure boot enabled needs to define
+	  security policies to extend secure boot to the OS.This config
+	  allows user to enable OS Secure Boot on PowerPC systems that
+	  have firmware secure boot support.
+
 endmenu
 
 config ISA_DMA_API
diff --git a/arch/powerpc/include/asm/secboot.h b/arch/powerpc/include/asm/secboot.h
new file mode 100644
index 000000000000..e726261bb00b
--- /dev/null
+++ b/arch/powerpc/include/asm/secboot.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PowerPC secure boot definitions
+ *
+ * Copyright (C) 2019 IBM Corporation
+ * Author: Nayna Jain <nayna@linux.ibm.com>
+ *
+ */
+#ifndef POWERPC_SECBOOT_H
+#define POWERPC_SECBOOT_H
+
+#ifdef CONFIG_PPC_SECURE_BOOT
+extern struct device_node *is_powerpc_secvar_supported(void);
+extern bool get_powerpc_secureboot(void);
+#else
+static inline struct device_node *is_powerpc_secvar_supported(void)
+{
+	return NULL;
+}
+
+static inline bool get_powerpc_secureboot(void)
+{
+	return false;
+}
+
+#endif
+#endif
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index ea0c69236789..d310ebb4e526 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -157,6 +157,8 @@ endif
 obj-$(CONFIG_EPAPR_PARAVIRT)	+= epapr_paravirt.o epapr_hcalls.o
 obj-$(CONFIG_KVM_GUEST)		+= kvm.o kvm_emul.o
 
+obj-$(CONFIG_PPC_SECURE_BOOT)	+= secboot.o
+
 # Disable GCOV, KCOV & sanitizers in odd or sensitive code
 GCOV_PROFILE_prom_init.o := n
 KCOV_INSTRUMENT_prom_init.o := n
diff --git a/arch/powerpc/kernel/secboot.c b/arch/powerpc/kernel/secboot.c
new file mode 100644
index 000000000000..5ea0d52d64ef
--- /dev/null
+++ b/arch/powerpc/kernel/secboot.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 IBM Corporation
+ * Author: Nayna Jain <nayna@linux.ibm.com>
+ *
+ * secboot.c
+ *      - util function to get powerpc secboot state
+ */
+#include <linux/types.h>
+#include <linux/of.h>
+#include <asm/secboot.h>
+
+struct device_node *is_powerpc_secvar_supported(void)
+{
+	struct device_node *np;
+	int status;
+
+	np = of_find_node_by_name(NULL, "ibm,secureboot");
+	if (!np) {
+		pr_info("secureboot node is not found\n");
+		return NULL;
+	}
+
+	status = of_device_is_compatible(np, "ibm,secureboot-v3");
+	if (!status) {
+		pr_info("Secure variables are not supported by this firmware\n");
+		return NULL;
+	}
+
+	return np;
+}
+
+bool get_powerpc_secureboot(void)
+{
+	struct device_node *np;
+	struct device_node *secvar_np;
+	const u64 *psecboot;
+	u64 secboot = 0;
+
+	np = is_powerpc_secvar_supported();
+	if (!np)
+		goto disabled;
+
+	/* Fail-safe for any failure related to secvar */
+	secvar_np = of_get_child_by_name(np, "secvar");
+	if (!secvar_np) {
+		pr_err("Expected secure variables support, fail-safe\n");
+		goto enabled;
+	}
+
+	if (!of_device_is_available(secvar_np)) {
+		pr_err("Secure variables support is in error state, fail-safe\n");
+		goto enabled;
+	}
+
+	psecboot = of_get_property(secvar_np, "secure-mode", NULL);
+	if (!psecboot)
+		goto enabled;
+
+	secboot = be64_to_cpup((__be64 *)psecboot);
+	if (!(secboot & (~0x0)))
+		goto disabled;
+
+enabled:
+	pr_info("secureboot mode enabled\n");
+	return true;
+
+disabled:
+	pr_info("secureboot mode disabled\n");
+	return false;
+}
-- 
2.20.1

