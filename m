Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D242A18C6
	for <lists+linux-integrity@lfdr.de>; Sat, 31 Oct 2020 17:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgJaQpr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 31 Oct 2020 12:45:47 -0400
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21132 "EHLO
        sender4-of-o51.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbgJaQpr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 31 Oct 2020 12:45:47 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1604162688; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Ubm2nmdUxTMXfIEsLXlDPzaINdupZ3pLGfqxxTzFaZ7GCMGdhXiDqvRQEEW6W8OM+OTci5xyWtbr1jVNq4F/azuQwgJpH9xfMwyWWppQ6P3T25lPXbFUeG377H4cSY+oa097wvJMobfMruI/9VjCwW/RBdhn21uQNCUCxresdyg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1604162688; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To; 
        bh=GXyNVpJwrKVM2JTex8htjue99BvhW00H1Vi112T3RuU=; 
        b=VwaJziKm9Y8TCiYbPy5CHqps8DDyFNpouyHiMZzauUKS0dkpMmb1GyysCaM8GEiMN4YMvuQnCdrNa9E4vAed6JY2/ccQbyC1AbYxaVo9MKtukNNscB/iy/DijCcmwJX93M7iYfur+mP5WQDivYDotJm9NawBQHXEnauOb4gQeI8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=apertussolutions.com;
        spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
        dmarc=pass header.from=<dpsmith@apertussolutions.com> header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1604162688;
        s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=GXyNVpJwrKVM2JTex8htjue99BvhW00H1Vi112T3RuU=;
        b=kpolUSnx3pFOaAy0FdLd2VcxeJLd+Z8ewzPHfp63114COjE7Mr6a5mpSfcOBmvux
        OlCiaIKW7VkdMuOYh7qa2nb1ym9KRmeRUMfafgrdD5QAF8uFS7hitF6AjHJWQrbDTx8
        pDAtcp6Bg+GHTs/caN7oAJWM3YSvmek510CUljDs=
Received: from sisyou.hme. (c-73-129-147-140.hsd1.md.comcast.net [73.129.147.140]) by mx.zohomail.com
        with SMTPS id 1604162687415461.8984600931317; Sat, 31 Oct 2020 09:44:47 -0700 (PDT)
From:   "Daniel P. Smith" <dpsmith@apertussolutions.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        jarkko.sakkinen@linux.intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, luto@amacapital.net,
        trenchboot-devel@googlegroups.com
Subject: [RFC PATCH 1/4] tpm: Move TPM TIS definitions out of TIS core header
Date:   Sat, 31 Oct 2020 12:51:19 -0400
Message-Id: <20201031165122.21539-2-dpsmith@apertussolutions.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201031165122.21539-1-dpsmith@apertussolutions.com>
References: <20201031165122.21539-1-dpsmith@apertussolutions.com>
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Move definitions from drivers/char/tpm/tpm_tis_core.h to new file
drivers/char/tpm/tpm_tis_defs.h. This allows tpm_tis_defs.h to be included
in the Secure Launch early PCR extend module. The rest of tpm_tis_core.h
cannot be included in the compressed kernel environment.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 drivers/char/tpm/tpm_tis_core.h | 60 +-----------------------------
 drivers/char/tpm/tpm_tis_defs.h | 81 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+), 59 deletions(-)
 create mode 100644 drivers/char/tpm/tpm_tis_defs.h

diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 7337819f5d7b..daf293dfc570 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -20,65 +20,7 @@
 #define __TPM_TIS_CORE_H__
 
 #include "tpm.h"
-
-enum tis_access {
-	TPM_ACCESS_VALID = 0x80,
-	TPM_ACCESS_ACTIVE_LOCALITY = 0x20,
-	TPM_ACCESS_REQUEST_PENDING = 0x04,
-	TPM_ACCESS_REQUEST_USE = 0x02,
-};
-
-enum tis_status {
-	TPM_STS_VALID = 0x80,
-	TPM_STS_COMMAND_READY = 0x40,
-	TPM_STS_GO = 0x20,
-	TPM_STS_DATA_AVAIL = 0x10,
-	TPM_STS_DATA_EXPECT = 0x08,
-};
-
-enum tis_int_flags {
-	TPM_GLOBAL_INT_ENABLE = 0x80000000,
-	TPM_INTF_BURST_COUNT_STATIC = 0x100,
-	TPM_INTF_CMD_READY_INT = 0x080,
-	TPM_INTF_INT_EDGE_FALLING = 0x040,
-	TPM_INTF_INT_EDGE_RISING = 0x020,
-	TPM_INTF_INT_LEVEL_LOW = 0x010,
-	TPM_INTF_INT_LEVEL_HIGH = 0x008,
-	TPM_INTF_LOCALITY_CHANGE_INT = 0x004,
-	TPM_INTF_STS_VALID_INT = 0x002,
-	TPM_INTF_DATA_AVAIL_INT = 0x001,
-};
-
-enum tis_defaults {
-	TIS_MEM_LEN = 0x5000,
-	TIS_SHORT_TIMEOUT = 750,	/* ms */
-	TIS_LONG_TIMEOUT = 2000,	/* 2 sec */
-};
-
-/* Some timeout values are needed before it is known whether the chip is
- * TPM 1.0 or TPM 2.0.
- */
-#define TIS_TIMEOUT_A_MAX	max_t(int, TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_A)
-#define TIS_TIMEOUT_B_MAX	max_t(int, TIS_LONG_TIMEOUT, TPM2_TIMEOUT_B)
-#define TIS_TIMEOUT_C_MAX	max_t(int, TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_C)
-#define TIS_TIMEOUT_D_MAX	max_t(int, TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_D)
-
-#define	TPM_ACCESS(l)			(0x0000 | ((l) << 12))
-#define	TPM_INT_ENABLE(l)		(0x0008 | ((l) << 12))
-#define	TPM_INT_VECTOR(l)		(0x000C | ((l) << 12))
-#define	TPM_INT_STATUS(l)		(0x0010 | ((l) << 12))
-#define	TPM_INTF_CAPS(l)		(0x0014 | ((l) << 12))
-#define	TPM_STS(l)			(0x0018 | ((l) << 12))
-#define	TPM_STS3(l)			(0x001b | ((l) << 12))
-#define	TPM_DATA_FIFO(l)		(0x0024 | ((l) << 12))
-
-#define	TPM_DID_VID(l)			(0x0F00 | ((l) << 12))
-#define	TPM_RID(l)			(0x0F04 | ((l) << 12))
-
-#define LPC_CNTRL_OFFSET		0x84
-#define LPC_CLKRUN_EN			(1 << 2)
-#define INTEL_LEGACY_BLK_BASE_ADDR	0xFED08000
-#define ILB_REMAP_SIZE			0x100
+#include "tpm_tis_defs.h"
 
 enum tpm_tis_flags {
 	TPM_TIS_ITPM_WORKAROUND		= BIT(0),
diff --git a/drivers/char/tpm/tpm_tis_defs.h b/drivers/char/tpm/tpm_tis_defs.h
new file mode 100644
index 000000000000..9979e3eeb83c
--- /dev/null
+++ b/drivers/char/tpm/tpm_tis_defs.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2005, 2006 IBM Corporation
+ * Copyright (C) 2014, 2015 Intel Corporation
+ *
+ * Authors:
+ * Leendert van Doorn <leendert@watson.ibm.com>
+ * Kylene Hall <kjhall@us.ibm.com>
+ *
+ * Maintained by: <tpmdd-devel@lists.sourceforge.net>
+ *
+ * Device driver for TCG/TCPA TPM (trusted platform module).
+ * Specifications at www.trustedcomputinggroup.org
+ *
+ * This device driver implements the TPM interface as defined in
+ * the TCG TPM Interface Spec version 1.2, revision 1.0.
+ */
+
+#ifndef __TPM_TIS_DEFS_H__
+#define __TPM_TIS_DEFS_H__
+
+enum tis_access {
+	TPM_ACCESS_VALID = 0x80,
+	TPM_ACCESS_ACTIVE_LOCALITY = 0x20,
+	TPM_ACCESS_REQUEST_PENDING = 0x04,
+	TPM_ACCESS_REQUEST_USE = 0x02,
+};
+
+enum tis_status {
+	TPM_STS_VALID = 0x80,
+	TPM_STS_COMMAND_READY = 0x40,
+	TPM_STS_GO = 0x20,
+	TPM_STS_DATA_AVAIL = 0x10,
+	TPM_STS_DATA_EXPECT = 0x08,
+};
+
+enum tis_int_flags {
+	TPM_GLOBAL_INT_ENABLE = 0x80000000,
+	TPM_INTF_BURST_COUNT_STATIC = 0x100,
+	TPM_INTF_CMD_READY_INT = 0x080,
+	TPM_INTF_INT_EDGE_FALLING = 0x040,
+	TPM_INTF_INT_EDGE_RISING = 0x020,
+	TPM_INTF_INT_LEVEL_LOW = 0x010,
+	TPM_INTF_INT_LEVEL_HIGH = 0x008,
+	TPM_INTF_LOCALITY_CHANGE_INT = 0x004,
+	TPM_INTF_STS_VALID_INT = 0x002,
+	TPM_INTF_DATA_AVAIL_INT = 0x001,
+};
+
+enum tis_defaults {
+	TIS_MEM_LEN = 0x5000,
+	TIS_SHORT_TIMEOUT = 750,	/* ms */
+	TIS_LONG_TIMEOUT = 2000,	/* 2 sec */
+};
+
+/* Some timeout values are needed before it is known whether the chip is
+ * TPM 1.0 or TPM 2.0.
+ */
+#define TIS_TIMEOUT_A_MAX	max_t(int, TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_A)
+#define TIS_TIMEOUT_B_MAX	max_t(int, TIS_LONG_TIMEOUT, TPM2_TIMEOUT_B)
+#define TIS_TIMEOUT_C_MAX	max_t(int, TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_C)
+#define TIS_TIMEOUT_D_MAX	max_t(int, TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_D)
+
+#define	TPM_ACCESS(l)			(0x0000 | ((l) << 12))
+#define	TPM_INT_ENABLE(l)		(0x0008 | ((l) << 12))
+#define	TPM_INT_VECTOR(l)		(0x000C | ((l) << 12))
+#define	TPM_INT_STATUS(l)		(0x0010 | ((l) << 12))
+#define	TPM_INTF_CAPS(l)		(0x0014 | ((l) << 12))
+#define	TPM_STS(l)			(0x0018 | ((l) << 12))
+#define	TPM_STS3(l)			(0x001b | ((l) << 12))
+#define	TPM_DATA_FIFO(l)		(0x0024 | ((l) << 12))
+
+#define	TPM_DID_VID(l)			(0x0F00 | ((l) << 12))
+#define	TPM_RID(l)			(0x0F04 | ((l) << 12))
+
+#define LPC_CNTRL_OFFSET		0x84
+#define LPC_CLKRUN_EN			(1 << 2)
+#define INTEL_LEGACY_BLK_BASE_ADDR	0xFED08000
+#define ILB_REMAP_SIZE			0x100
+
+#endif
-- 
2.11.0

