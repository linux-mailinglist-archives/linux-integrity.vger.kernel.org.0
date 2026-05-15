Return-Path: <linux-integrity+bounces-9540-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HfwNpSNB2rB8AIAu9opvQ
	(envelope-from <linux-integrity+bounces-9540-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:18:12 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4878A557C62
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69BC9304F2E3
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 21:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DE03ED135;
	Fri, 15 May 2026 21:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+aYs+sS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE343ED5A8
	for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 21:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879669; cv=none; b=b3iV1VMrioCYqvTdZVm9jMQdwdyvHjm7pvg+VrPJUBxFPqJ4Cf6MS2ETgdEHryzi/mL65fKi2Njb1hJzMbpBLMyO2VDlMv770votMtr+GgaUgZDU1O+sMfcKk4yOq2ZuBDkWTL852n8cRAo0vOdNcaUdKeLLI3YKtu7cicJDDl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879669; c=relaxed/simple;
	bh=iZx+Ma9ZLO27Qd1OSFPbIPI91crZcyGUmYYOTAyaGV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqUd7fNod8EAKJ18lpm8pA2XlovXYfKRGysntxPLJGmBiPcbx3IO/FJ4rFJaGcdS0dDdQGecsPHQL2D64P5B0aU6AIFxiSHA+OudybtROMrqx2OlqICjrEA/nXXg56AFGKNEGhYfwc9DEWy5Teer65JGngZyqTlII4LFD5IOpXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+aYs+sS; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2ee1054627bso1071545eec.1
        for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 14:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879667; x=1779484467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvhJ+ydmVFUO/FtDIG83CBk7wY0hq1hCXhxrxXZ6CzE=;
        b=V+aYs+sS8kXrENeJEYszeay1jLDUpy8kXTjVEGtORS5QflQnwyXwrVZZf6AWM3KSrH
         p3loYQh1cSwdAH/ClG38n2IltMK+e+QOktZ38/7Y61DNR3BjE4PCfA70fYeMWoObIYQK
         /p9MxXRFQJNWOpsVpYiTDEpWiImZO33lHIadpJUJZByA8Z99pwIYnt7mHy0EyH59Kk7x
         fgijEtE5LZNrecyVn1qopbBriufmCDUELfAUlJycyuOY9klZvELHtlqwnqr5gPv2clmN
         XbwhCSWJxy5i6rnS69hSWFvNrp6n+ExzeVaF9t6zyjEBan8Q0DvbKV98dDCXMuGLjW6j
         xVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879667; x=1779484467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zvhJ+ydmVFUO/FtDIG83CBk7wY0hq1hCXhxrxXZ6CzE=;
        b=g5jJvCgAoqNS8l8WDk1V1Nw9AmgViwetzHdJ4Gayv4aFdZJ/wYELjaFwDN0xT2EzZS
         Yd3xBmy0oCVLKWcJXOLQvKcBxtgFyOW/tB0KxucHbWsuaLVjyXWC5IgY+WK8qxyz0jJ5
         utFAhY22lJQqZ8f9vmXcPMhGanVwpb14xUp4ERV/HzplQpeB7bY1v4ZRcjOtUIzc6dIE
         M+d3L6IpzmAqTaYjkUOlU2Ih2NV16UHNPj/9TBuaDwIXTwBL8MeFACvX3oOCUYxgM9F5
         kvURe1MMRQldhX1j8j4+fniiybaCOJ264R9LGrqbMW3i3xu6J+528TX88cJlP5ap3+NW
         L/lw==
X-Forwarded-Encrypted: i=1; AFNElJ+nURWlLKJ3CgqukrVHANOMiU1whTSMYayeR2dLKqASQd5MHHs7ToeexTrRDaRD46wixEag4jvghiCJRTR1Bzk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/QHMm3rMcGUzd5gJ9jalAj6nZoWtnusE7uKHTo6R0NuqPvW73
	CW/FF8KFyZo9jwUHR1NojtWGG9G3u1KVDK12ADjbeU+ExqWTERT4xD9n
X-Gm-Gg: Acq92OETf7dxX3z5BEyCuXuFIu4VtK+b8UYsP8nLuFuXGG+xKCbhdWu4yPZlLoWrOHZ
	vE4e4rx8/MA0d9AOW/vWX18OCIJt4t0sOO9f8QcNseg98lO5NIwyaJo1tcY9yUhBimajcpM+bho
	XcgUmrYJ4JkEHEdHr+O0Yf03izXg53zGQ/iKeX3FRcp4bWbdGELKXSmvYfxe6eLOHXEGamQi06E
	jhFzoSnhZwj0MXlCCw+mUbuKcwpdf3GmGwor/E7sSSQ74sMfkLSDbe9Ats3W2+NE6IMq+5PgWoV
	gVeA8EO9pvgYc8z9YCADzLMC7hQt7i0N04WobpHE/hPX38a/KujStw9FvnLQL2KzYr2qcfxnGx5
	RhUnVV7IVy9G/8syxmmf2+OmozRMFATqDWWIsoVHzAqhtGm4hWfFfftFbwYR2cKFAEzhE9ZwLjA
	R+d4xx6Ud9IiqJd/FTDSBu/Y9OeWpFoVjQkJca477bvQ==
X-Received: by 2002:a05:7301:2a02:b0:2c1:67e1:61a9 with SMTP id 5a478bee46e88-303979af82emr2367379eec.13.1778879666828;
        Fri, 15 May 2026 14:14:26 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcb6f6sm9726668eec.17.2026.05.15.14.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:14:26 -0700 (PDT)
From: Ross Philipson <ross.philipson@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-efi@vger.kernel.org,
	iommu@lists.linux.dev
Cc: ross.philipson@gmail.com,
	dpsmith@apertussolutions.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	ardb@kernel.org,
	mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com,
	peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	luto@amacapital.net,
	nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	corbet@lwn.net,
	ebiederm@xmission.com,
	dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	kanth.ghatraju@oracle.com,
	daniel.kiper@oracle.com,
	andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: [PATCH v16 05/38] tpm: Move platform specific definitions to the new PTP header
Date: Fri, 15 May 2026 14:13:37 -0700
Message-ID: <20260515211410.31440-6-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4878A557C62
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9540-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,apertussolutions.com,linutronix.de,redhat.com,alien8.de,zytor.com,linux.intel.com,kernel.org,srcf.ucam.org,hansenpartnership.com,gmx.de,ziepe.ca,amacapital.net,alum.mit.edu,gondor.apana.org.au,davemloft.net,lwn.net,xmission.com,infradead.org,oracle.com,citrix.com,googlegroups.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	FROM_NEQ_ENVFROM(0.00)[rossphilipson@gmail.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,trustedcomputinggroup.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,apertussolutions.com:email]
X-Rspamd-Action: no action

These are definitions for TPM 2.0 interface and interactions with
the platform as defined in the TCG specification:

These definitions are located here in a separate file to avoid conflicts
with vendor specific TIS/FIFO definition (e.g. STMicroelectronics,
Infineon Technologies, etc). This allows the TCG defined TIS/FIFO
interface to be in a public header while the former chip specific
implementations contain their own definitions. TPM 1.x family chips
that adhere to the TCG specifications use the TIS/FIFO interface as
defined here.

TCG PC Client Platform TPM Profile (PTP) Specification
 - https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-profile-ptp-specification/

Co-developed-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Co-developed-by: Alec Brown <alec.r.brown@oracle.com>
Signed-off-by: Alec Brown <alec.r.brown@oracle.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 drivers/char/tpm/tpm_tis_core.h |  64 +-------------
 include/linux/tpm_ptp.h         | 151 ++++++++++++++++++++++++++++++++
 2 files changed, 152 insertions(+), 63 deletions(-)
 create mode 100644 include/linux/tpm_ptp.h

diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 6c3aa480396b..be68883ed399 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -19,71 +19,9 @@
 #ifndef __TPM_TIS_CORE_H__
 #define __TPM_TIS_CORE_H__
 
+#include <linux/tpm_ptp.h>
 #include "tpm.h"
 
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
-	TPM_STS_RESPONSE_RETRY = 0x02,
-	TPM_STS_READ_ZERO = 0x23, /* bits that must be zero on read */
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
-	TIS_LONG_TIMEOUT = 4000,	/* 4 secs */
-	TIS_TIMEOUT_MIN_ATML = 14700,	/* usecs */
-	TIS_TIMEOUT_MAX_ATML = 15000,	/* usecs */
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
-
 enum tpm_tis_flags {
 	TPM_TIS_ITPM_WORKAROUND		= 0,
 	TPM_TIS_INVALID_STATUS		= 1,
diff --git a/include/linux/tpm_ptp.h b/include/linux/tpm_ptp.h
new file mode 100644
index 000000000000..143e887599bb
--- /dev/null
+++ b/include/linux/tpm_ptp.h
@@ -0,0 +1,151 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Following copyright information was take from the original file
+ * <drivers/char/tpm/tpm_tis_core.h> where the definitions were moved
+ * from:
+ *
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
+#ifndef __LINUX_TPM_PTP_H__
+#define __LINUX_TPM_PTP_H__
+
+/*
+ * TCG PC Client Platform TPM Profile (PTP) Specification
+ * https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-profile-ptp-specification/
+ */
+
+/* TIS/FIFO macros and definitions */
+
+enum tis_access {
+	TPM_ACCESS_VALID		= 0x80,
+	TPM_ACCESS_ACTIVE_LOCALITY	= 0x20,	/* (R) */
+	TPM_ACCESS_RELINQUISH_LOCALITY	= 0x20, /* (W) */
+	TPM_ACCESS_REQUEST_PENDING	= 0x04,	/* (W) */
+	TPM_ACCESS_REQUEST_USE		= 0x02,	/* (W) */
+};
+
+enum tis_status {
+	TPM_STS_VALID		= 0x80, /* (R) */
+	TPM_STS_COMMAND_READY	= 0x40, /* (R) */
+	TPM_STS_DATA_AVAIL	= 0x10, /* (R) */
+	TPM_STS_DATA_EXPECT	= 0x08, /* (R) */
+	TPM_STS_GO		= 0x20, /* (W) */
+	TPM_STS_RESPONSE_RETRY	= 0x02, /* (R) */
+	TPM_STS_READ_ZERO	= 0x23, /* bits that must be zero on read */
+};
+
+enum tis_int_flags {
+	TPM_GLOBAL_INT_ENABLE		= 0x80000000,
+	TPM_INTF_BURST_COUNT_STATIC	= 0x100,
+	TPM_INTF_CMD_READY_INT		= 0x080,
+	TPM_INTF_INT_EDGE_FALLING	= 0x040,
+	TPM_INTF_INT_EDGE_RISING	= 0x020,
+	TPM_INTF_INT_LEVEL_LOW		= 0x010,
+	TPM_INTF_INT_LEVEL_HIGH		= 0x008,
+	TPM_INTF_LOCALITY_CHANGE_INT	= 0x004,
+	TPM_INTF_STS_VALID_INT		= 0x002,
+	TPM_INTF_DATA_AVAIL_INT		= 0x001,
+};
+
+enum tis_defaults {
+	TIS_MEM_LEN		= 0x5000,
+	TIS_SHORT_TIMEOUT	= 750,   /* ms */
+	TIS_LONG_TIMEOUT	= 4000,  /* 4 secs */
+	TIS_TIMEOUT_MIN_ATML	= 14700, /* usecs */
+	TIS_TIMEOUT_MAX_ATML	= 15000, /* usecs */
+};
+
+enum tis_x86_defaults {
+	TIS_MEM_X86_LPC_BASE		= 0xFED40000,
+	TIS_MEM_X86_LEN			= 0x5000,
+	INTEL_LEGACY_BLK_BASE_ADDR	= 0xFED08000,
+	ILB_REMAP_SIZE			= 0x100,
+	LPC_CNTRL_OFFSET		= 0x84,
+	LPC_CLKRUN_EN			= (1 << 2),
+};
+
+/*
+ * Some timeout values are needed before it is known whether the chip is
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
+#define	TPM_INTF_ID(l)			(0x0030 | ((l) << 12))
+
+#define	TPM_DID_VID(l)			(0x0F00 | ((l) << 12))
+#define	TPM_RID(l)			(0x0F04 | ((l) << 12))
+
+/* TPM HW Interface and Capabilities */
+#define TPM_TIS_INTF_ACTIVE	0x00
+#define TPM_CRB_INTF_ACTIVE	0x01
+
+struct tpm_interface_id {
+	union {
+		u32 val;
+		struct {
+			u32 interface_type:4;
+			u32 interface_version:4;
+			u32 cap_locality:1;
+			u32 reserved1:4;
+			u32 cap_tis:1;
+			u32 cap_crb:1;
+			u32 cap_if_res:2;
+			u32 interface_selector:2;
+			u32 intf_sel_lock:1;
+			u32 reserved2:4;
+			u32 reserved3:8;
+		};
+	};
+} __packed;
+
+#define TPM_TIS_INTF_12		0x00
+#define TPM_TIS_INTF_13		0x02
+#define TPM2_TIS_INTF_13	0x03
+
+struct tpm_intf_capability {
+	union {
+		u32 val;
+		struct {
+			u32 data_avail_int_support:1;
+			u32 sts_valid_int_support:1;
+			u32 locality_change_int_support:1;
+			u32 interrupt_level_high:1;
+			u32 interrupt_level_low:1;
+			u32 interrupt_edge_rising:1;
+			u32 interrupt_edge_falling:1;
+			u32 command_ready_int_support:1;
+			u32 burst_count_static:1;
+			u32 data_transfer_size_support:2;
+			u32 reserved1:17;
+			u32 interface_version:3;
+			u32 reserved2:1;
+		};
+	};
+} __packed;
+
+#endif
-- 
2.47.3


