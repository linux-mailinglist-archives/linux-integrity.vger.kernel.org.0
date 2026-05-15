Return-Path: <linux-integrity+bounces-9564-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OG4EKCOPB2oe8wIAu9opvQ
	(envelope-from <linux-integrity+bounces-9564-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:24:51 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4101F557FDD
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 571493033199
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 21:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B623405849;
	Fri, 15 May 2026 21:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmB9JnH5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70643F1667
	for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 21:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879738; cv=none; b=fq/k060vDGQo+nHy/YT5daXs09tCdgESjAArni/S3mPHe/+67dNlUP0biyuUPo22kUq/Tz37p4LmunyebSuWqhLg7AkHCOdHsfHbr3edwr0Ni5CKm5oG62Z4mUDvXI0jXfFiHq8zksxVyro4bubzz+28O4Mpar4i0cjgoNRn6AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879738; c=relaxed/simple;
	bh=rNdJJ8YVhFpY/mOFackrLIoznhga5VyceHpT+Iq/eqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HR+gNlBTfCLA42+TkcHAErvrG6Mi/dxs1zBC51OU6UW1D+sJLAgZb/qfiYUeLbr9klb5FTkVd8ei+Cep6ELVTYYxeLbzBnF0MkmUw1wXRipRr5R2ra/eKzz6MgAZ0XYpTOX6mWH4VPNkdOnxPcC3nzMvnYx+sLmvJ58Rd8uF5N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmB9JnH5; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2f0d3e07e30so1354424eec.0
        for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 14:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879735; x=1779484535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViurL0csUM0y6zC2/BziEDI+4nTSab4FjJtc7RqXPgw=;
        b=HmB9JnH5XAg7V69IaDFpgbuA/suif2QUJJW+6W5xc3WvGjHRvnpxz6EBZNyt6/0rSt
         z8dbwurgr0wGbbh8vM+u4VwTc+aH0Wzch5Y6SW9yq4fCQQKTqhwwvrsjhBdWWaIZZsMB
         RlNTf+6rl3a1J+G0LRUcq+nPijGBBczTHqFUZltsOM0wM6Vvzp6wuvVirFzQC7J0SRzM
         jQj2mG1quOE0vJkdGgm5U2dqWncdxcoWrFVoYCrnlakxfIQBWBTbBD9Krl9GDyavLAY8
         GFmcx7UXo1o7oLtVH0WxHrkxXd4B5NFwdnAf5jXzygs8ufHHiOGnD0gK2w8CijzHsquj
         spYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879735; x=1779484535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ViurL0csUM0y6zC2/BziEDI+4nTSab4FjJtc7RqXPgw=;
        b=Hy/sq1bvb4/DOCA1siXQr1HVqT4dwBAs4LaAGG2SYUpBNmGQUc8yi0GL2qxxpIDHVC
         xkfb6uzOvEmHvwmsNo73L0f6RY74jpXNVcRSr3laqANU3W8pIhNt6LlbGbdFTpUchwvX
         AfPMymhZRAe2v7TJN+p5pPZct/qcjX1jN2d/0MndVtdBVPwwN/gttjeBAYjl8N2Zgb/+
         CmrcPLoK2hnf0oi7R/BDUps0L+cHbhTqFJ07bqgl3IT2vhfQRTgqr+84Jx/3U1FD19rL
         2Yz74y0pu6aFDauAc/pqGjoHYZgWKfHXBWPf2kVekzUtqfrwextFTvt0Z+gNypTbXTSX
         wLiA==
X-Forwarded-Encrypted: i=1; AFNElJ8vkBqkr4NUs3G34JCESYTBWoijvgNsAypJ2m04oo635J4W/zZoJtilLKBuuF2JS7jq4MBgCkvnI/XZ4P+WkJc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx3Q0XVNgnv9qW9lKSHErW7QF8FeLBARHCDLGUJSuaCzhkTxAX
	3lpwCV7TPE1sLcl3pFvcWLwykHKT8BUE18+LL3vJE+2wmjddUh0W39xf
X-Gm-Gg: Acq92OGlf0HIvFoYVNRyz6aCkN/SK+WvHBh45KQ/PGSmdcMAvDJS5ypSqUkfL2rUW8M
	lzZomokywt5aH5kUCcUNdP8kxuz82GQvpo8z+cUHQIZmoJeJs2ZQSpbFklGd/CqzY6nUI4yFC2k
	Vp7W/6OKaE1zyW9vbBWiLUPCl10/qk3z7cfQoRKcAjbGMGl0gSaG7H3pT06HL6iWyCaToMml4ah
	/HZRr0YpU5dFbgerGeFsjwR90s6GI5YMStto2Cz1F4LdDrs8RcN1uSIOGDiNKvUlWCjMtrEOUwR
	W5cSKDE8jGIkwnGNxugx+8uFvk/CfEM/6TrUwzsiIbDFKKw/acrCHGFYvQj2iftlo93IXho431T
	a5iJLsTMRbyYNvEQWzDz73k+HFtuanijfYeXHcIdzpq7vDv9S0jAw9cQyctMEsE/VQitdDySUTj
	8Fcv63OkNhYhGP/dYXjKa6XktxQYOtctLCaAoPV/GeDg==
X-Received: by 2002:a05:7300:510:b0:2c1:7b61:8731 with SMTP id 5a478bee46e88-303982be4d0mr3180070eec.10.1778879734916;
        Fri, 15 May 2026 14:15:34 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302944ffb85sm8214358eec.7.2026.05.15.14.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:34 -0700 (PDT)
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
Subject: [PATCH v16 29/38] x86/tpm: Early startup TPM PCR extending driver
Date: Fri, 15 May 2026 14:14:01 -0700
Message-ID: <20260515211410.31440-30-ross.philipson@gmail.com>
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
X-Rspamd-Queue-Id: 4101F557FDD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9564-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trustedcomputinggroup.org:url,apertussolutions.com:email,oracle.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Introduce a driver that can interact minimally with the TPM. This
allows the Secure Launch startup code to extend measurement values
into the TPM's DRTM PCR banks early in the launch process.

The driver implementation only currently supports basic initialization
and PCR extend commands. An extend command can be sent to both TPM 2.0 or
1.2 chip but only the TIS/FIFO interface is currently supported. The TCG
specs for these interface can be found here:

https://trustedcomputinggroup.org/resource/pc-client-work-group-pc-client-specific-tpm-interface-specification-tis/
https://trustedcomputinggroup.org/resource/tpm-2-0-mobile-command-response-buffer-interface-specification/

Note this TPM driver implementation relies as much as possible on
existing mainline kernel TPM code.

Co-developed-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Co-developed-by: Alec Brown <alec.r.brown@oracle.com>
Signed-off-by: Alec Brown <alec.r.brown@oracle.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 arch/x86/boot/startup/Makefile  |   1 +
 arch/x86/boot/startup/exports.h |   7 +
 arch/x86/boot/startup/tpm.h     |  47 +++
 arch/x86/boot/startup/tpm_drv.c | 567 ++++++++++++++++++++++++++++++++
 4 files changed, 622 insertions(+)
 create mode 100644 arch/x86/boot/startup/tpm.h
 create mode 100644 arch/x86/boot/startup/tpm_drv.c

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index 527cba7e4560..ecf86ce5ebf7 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= sme.o sev-startup.o
 slaunch-objs			+= lib-sha1.o
 slaunch-objs			+= lib-sha256.o
 slaunch-objs			+= lib-sha512.o
+slaunch-objs			+= tpm_drv.o
 obj-$(CONFIG_SECURE_LAUNCH)	+= $(slaunch-objs)
 
 pi-objs				:= $(patsubst %.o,$(obj)/%.o,$(obj-y))
diff --git a/arch/x86/boot/startup/exports.h b/arch/x86/boot/startup/exports.h
index 01d2363dc445..4b82ddbd62a8 100644
--- a/arch/x86/boot/startup/exports.h
+++ b/arch/x86/boot/startup/exports.h
@@ -12,3 +12,10 @@ PROVIDE(snp_cpuid			= __pi_snp_cpuid);
 PROVIDE(snp_cpuid_get_table		= __pi_snp_cpuid_get_table);
 PROVIDE(svsm_issue_call			= __pi_svsm_issue_call);
 PROVIDE(svsm_process_result_codes	= __pi_svsm_process_result_codes);
+
+#ifdef CONFIG_SECURE_LAUNCH
+__pi_bcmp				= bcmp;
+__pi_memcmp				= memcmp;
+__pi_strlen				= strlen;
+__pi___WARN_trap			= __WARN_trap;
+#endif
diff --git a/arch/x86/boot/startup/tpm.h b/arch/x86/boot/startup/tpm.h
new file mode 100644
index 000000000000..1a11396b68c6
--- /dev/null
+++ b/arch/x86/boot/startup/tpm.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * TPM early extend header file.
+ *
+ * Copyright (c) 2026 Apertus Solutions, LLC
+ * Copyright (c) 2026, Oracle and/or its affiliates.
+ */
+
+#ifndef BOOT_COMPRESSED_TPM_H
+#define BOOT_COMPRESSED_TPM_H
+
+enum early_tis_defaults {
+	TPM_TIMEOUT		= 5, /* ms */
+	TIS_DURATION		= 120000, /* 120 secs in ms */
+};
+
+enum tpm_family {
+	TPM_FAMILY_INVALID	= 0,
+	TPM_FAMILY_12		= 1,
+	TPM_FAMILY_20		= 2
+};
+
+struct tpm_chip {
+	enum tpm_family family;
+	u64 baseaddr;
+	int locality;
+	int did;
+	int vid;
+
+	/* in ms */
+	ktime_t timeout_a;
+	ktime_t timeout_b;
+	ktime_t timeout_c;
+	ktime_t timeout_d;
+};
+
+bool tpm_tis_check_locality(struct tpm_chip *chip, int loc);
+void tpm_tis_release_locality(struct tpm_chip *chip);
+int tpm_tis_request_locality(struct tpm_chip *chip, int loc);
+void tpm_tis_disable_interrupts(struct tpm_chip *chip);
+int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash);
+int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
+		    struct tpm_digest *digests, u32 digest_count);
+int early_tpm_init(struct tpm_chip *chip, u64 baseaddr);
+int early_tpm_fini(struct tpm_chip *chip);
+
+#endif /* BOOT_COMPRESSED_TPM_H */
diff --git a/arch/x86/boot/startup/tpm_drv.c b/arch/x86/boot/startup/tpm_drv.c
new file mode 100644
index 000000000000..99971b06f768
--- /dev/null
+++ b/arch/x86/boot/startup/tpm_drv.c
@@ -0,0 +1,567 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Based of the original tpm_tis.c implementation as found in the
+ * Linux 2.6 code base.
+ *
+ * Copyright (C) 2005, 2006 IBM Corporation
+ *
+ * Authors:
+ * Leendert van Doorn <leendert@watson.ibm.com>
+ * Kylene Hall <kjhall@us.ibm.com>
+ */
+
+#include <crypto/sha2.h>
+#include <asm/io.h>
+
+#include <linux/tpm_command.h>
+#include <linux/tpm_ptp.h>
+#include <linux/tpm_buf.h>
+
+#include "tpm.h"
+
+static u8 tpm_buf_page[PAGE_SIZE];
+
+/*
+ * Single threaded environment only running on BSP. Use a single shared
+ * page for all TPM extend operations.
+ */
+static inline struct tpm_buf *tpm_buf_alloc_page(void)
+{
+	memset(tpm_buf_page, 0, PAGE_SIZE);
+	return (struct tpm_buf *)tpm_buf_page;
+}
+
+static inline void tpm_buf_free_page(void)
+{
+	memset(tpm_buf_page, 0, PAGE_SIZE);
+}
+
+/* Pull in TPM buffer management support */
+#include "../../../../drivers/char/tpm/tpm-buf.c"
+
+static u32 __init tpm_get_alg_size(u16 alg_id)
+{
+	switch (alg_id) {
+	case TPM_ALG_SHA1:
+		return TPM_DIGEST_SIZE;
+	case TPM_ALG_SHA256:
+	case TPM_ALG_SM3_256:
+		return SHA256_DIGEST_SIZE;
+	case TPM_ALG_SHA384:
+		return SHA384_DIGEST_SIZE;
+	case TPM_ALG_SHA512:
+	default:
+		return SHA512_DIGEST_SIZE;
+	};
+}
+
+static inline u8 tpm_read8(struct tpm_chip *chip, u32 field)
+{
+	return readb((void *)(chip->baseaddr | field));
+}
+
+static inline void tpm_write8(struct tpm_chip *chip, u32 field, u8 val)
+{
+	writeb(val, (void *)(chip->baseaddr | field));
+}
+
+static inline u32 tpm_read32(struct tpm_chip *chip, u32 field)
+{
+	return readl((void *)(chip->baseaddr | field));
+}
+
+static inline void tpm_write32(struct tpm_chip *chip, u32 field, u32 val)
+{
+	writel(val, (void *)(chip->baseaddr | field));
+}
+
+/*
+ * In the setup kernel environment, it is far too early to calibrate time.
+ * Assume a 5GHz processor (the upper end of the Fam19h range), allowing
+ * reasonable timeouts on slower systems.
+ */
+static unsigned long ticks_per_ms = (5UL * 1000 * 1000 /* CPU in KHz */);
+
+static inline ktime_t tpm_now_ms(void)
+{
+	return rdtsc()/ticks_per_ms;
+}
+
+static inline void tpm_mdelay(unsigned int msecs)
+{
+	unsigned long ticks = msecs * ticks_per_ms;
+	unsigned long s, e;
+
+	s = rdtsc();
+	do {
+		cpu_relax();
+		e = rdtsc();
+	} while ((e - s) < ticks);
+}
+
+static inline u8 __tis_status(struct tpm_chip *chip)
+{
+	return tpm_read8(chip, TPM_STS(chip->locality));
+}
+
+static inline void __tis_cancel(struct tpm_chip *chip)
+{
+	/* This causes the current command to be aborted */
+	tpm_write8(chip, TPM_STS(chip->locality), TPM_STS_COMMAND_READY);
+}
+
+static int __init __tis_get_burstcount(struct tpm_chip *chip)
+{
+	ktime_t stop;
+	int burstcnt;
+
+	stop = tpm_now_ms() + chip->timeout_d;
+	do {
+		burstcnt = tpm_read8(chip, (TPM_STS(chip->locality) + 1));
+		burstcnt += tpm_read8(chip, TPM_STS(chip->locality) + 2) << 8;
+
+		if (burstcnt)
+			return burstcnt;
+
+		tpm_mdelay(TPM_TIMEOUT);
+	} while (tpm_now_ms() < stop);
+
+	return -EBUSY;
+}
+
+static int __init __tis_wait_for_stat(struct tpm_chip *chip, u8 mask, ktime_t timeout)
+{
+	ktime_t stop;
+	u8 status;
+
+	if ((__tis_status(chip) & mask) == mask)
+		return 0;
+
+	stop = tpm_now_ms() + timeout;
+	do {
+		tpm_mdelay(TPM_TIMEOUT);
+
+		status = __tis_status(chip);
+		if ((status & mask) == mask)
+			return 0;
+	} while (tpm_now_ms() < stop);
+
+	return -ETIME;
+}
+
+static int __init __tis_recv_data(struct tpm_chip *chip, u8 *buf, int count)
+{
+	int size = 0;
+	int burstcnt;
+
+	while (size < count &&
+	       __tis_wait_for_stat(chip,
+				   TPM_STS_DATA_AVAIL | TPM_STS_VALID,
+				   chip->timeout_c) == 0) {
+		burstcnt = __tis_get_burstcount(chip);
+
+		for ( ; burstcnt > 0 && size < count; --burstcnt)
+			buf[size++] = tpm_read8(chip, TPM_DATA_FIFO(chip->locality));
+	}
+
+	return size;
+}
+
+/**
+ * tpm_tis_check_locality - Check if the given locality is the active one
+ * @chip:	The TPM chip instance
+ * @loc:	The locality to check
+ *
+ * Return: true - locality active, false - not active
+ */
+bool __init tpm_tis_check_locality(struct tpm_chip *chip, int loc)
+{
+	u8 res = tpm_read8(chip, TPM_ACCESS(loc));
+
+	if ((res & (TPM_ACCESS_ACTIVE_LOCALITY | TPM_ACCESS_VALID)) ==
+		   (TPM_ACCESS_ACTIVE_LOCALITY | TPM_ACCESS_VALID)) {
+		chip->locality = loc;
+		return true;
+	}
+
+	return false;
+}
+
+/**
+ * tpm_tis_release_locality - Release the active locality
+ * @chip:	The TPM chip instance
+ */
+void __init tpm_tis_release_locality(struct tpm_chip *chip)
+{
+	u8 res = tpm_read8(chip, TPM_ACCESS(chip->locality));
+
+	if ((res & (TPM_ACCESS_REQUEST_PENDING | TPM_ACCESS_VALID)) ==
+		   (TPM_ACCESS_REQUEST_PENDING | TPM_ACCESS_VALID))
+		tpm_write8(chip, TPM_ACCESS(chip->locality), TPM_ACCESS_RELINQUISH_LOCALITY);
+
+	chip->locality = 0;
+}
+
+/**
+ * tpm_tis_request_locality - Request to make the given locality the active one
+ * @chip:	The TPM chip instance
+ * @loc:	The locality to make active/set as current
+ *
+ * Return:
+ *  >= 0 - Success, new active locality returned or locality already active
+ *  < 0  - Error occurred
+ */
+int __init tpm_tis_request_locality(struct tpm_chip *chip, int loc)
+{
+	ktime_t stop;
+
+	if (tpm_tis_check_locality(chip, loc))
+		return loc;
+
+	/* Set the new locality */
+	tpm_write8(chip, TPM_ACCESS(loc), TPM_ACCESS_REQUEST_USE);
+
+	stop = tpm_now_ms() + chip->timeout_b;
+	do {
+		if (tpm_tis_check_locality(chip, loc))
+			return loc;
+
+		tpm_mdelay(TPM_TIMEOUT);
+	} while (tpm_now_ms() < stop);
+
+	return -1;
+}
+
+/**
+ * tpm_tis_disable_interrupts - Disable interrupts for the TPM, use polling mode only
+ * @chip:	The TPM chip instance
+ */
+void __init tpm_tis_disable_interrupts(struct tpm_chip *chip)
+{
+	u32 intmask;
+
+	intmask = tpm_read32(chip, TPM_INT_ENABLE(chip->locality));
+	/* Disable everything to make sure it is in a consistent state */
+	intmask &= ~(TPM_GLOBAL_INT_ENABLE | TPM_INTF_CMD_READY_INT |
+		     TPM_INTF_LOCALITY_CHANGE_INT | TPM_INTF_STS_VALID_INT |
+		     TPM_INTF_DATA_AVAIL_INT);
+	tpm_write32(chip, TPM_INT_ENABLE(chip->locality), intmask);
+}
+
+/**
+ * tpm_tis_recv - Receive response data from TPM via TIS FIFO
+ * @chip:	The TPM chip instance
+ * @buf:	The response buffer
+ * @count:	Length of the response buffer
+ *
+ * Return:
+ *  = 0 - Success, no response data
+ *  > 0 - Success, value is the response data length
+ *  < 0 - Error occurred
+ */
+static int __init tpm_tis_recv(struct tpm_chip *chip, u8 *buf, int count)
+{
+	int expected, status, size = 0, rc = -EIO;
+
+	if (count < TPM_HEADER_SIZE)
+		goto out;
+
+	/* Read first 10 bytes, including tag, paramsize, and result */
+	size = __tis_recv_data(chip, buf, TPM_HEADER_SIZE);
+	if (size < TPM_HEADER_SIZE)
+		goto out;
+
+	expected = be32_to_cpu(*((u32 *)(buf + 2)));
+	if (expected > count)
+		goto out;
+
+	size += __tis_recv_data(chip, &buf[TPM_HEADER_SIZE], expected - TPM_HEADER_SIZE);
+	if (size < expected) {
+		rc = -ETIME;
+		goto out;
+	}
+
+	__tis_wait_for_stat(chip, TPM_STS_VALID, chip->timeout_c);
+
+	status = __tis_status(chip);
+	if (status & TPM_STS_DATA_AVAIL) {
+		rc = -EIO;
+		goto out;
+	}
+
+	/* Done with receive, move to Command Ready state */
+	__tis_cancel(chip);
+
+	return size;
+out:
+	__tis_cancel(chip);
+	tpm_tis_release_locality(chip);
+	return rc;
+}
+
+/**
+ * tpm_tis_send - Send command to TPM via TIS FIFO
+ * @chip:	The TPM chip instance
+ * @buf:	The command buffer
+ * @len:	Length of the command buffer to send
+ *
+ * Return:
+ *  = len - Success, all data sent
+ *  < 0	  - Error occurred
+ */
+static int __init tpm_tis_send(struct tpm_chip *chip, u8 *buf, int len)
+{
+	int status, burstcnt = 0;
+	int count = 0;
+	int rc = 0;
+
+	status = __tis_status(chip);
+	if ((status & TPM_STS_COMMAND_READY) == 0) {
+		__tis_cancel(chip);
+		if (__tis_wait_for_stat(chip, TPM_STS_COMMAND_READY, chip->timeout_b) < 0) {
+			rc = -ETIME;
+			goto out_err;
+		}
+	}
+
+	while (count < len - 1) {
+		burstcnt = __tis_get_burstcount(chip);
+		for ( ; burstcnt > 0 && count < len - 1; --burstcnt)
+			tpm_write8(chip, TPM_DATA_FIFO(chip->locality), buf[count++]);
+
+		__tis_wait_for_stat(chip, TPM_STS_VALID, chip->timeout_c);
+		status = __tis_status(chip);
+		if ((status & TPM_STS_DATA_EXPECT) == 0) {
+			rc = -EIO;
+			goto out_err;
+		}
+	}
+
+	/* Write last byte */
+	tpm_write8(chip, TPM_DATA_FIFO(chip->locality), buf[count]);
+	__tis_wait_for_stat(chip, TPM_STS_VALID, chip->timeout_c);
+	status = __tis_status(chip);
+	if ((status & TPM_STS_DATA_EXPECT) != 0) {
+		rc = -EIO;
+		goto out_err;
+	}
+
+	/* Go and do it */
+	tpm_write8(chip, TPM_STS(chip->locality), TPM_STS_GO);
+
+	return len;
+
+out_err:
+	__tis_cancel(chip);
+	tpm_tis_release_locality(chip);
+	return rc;
+}
+
+/**
+ * tpm_tis_transmit - Transmit a TPM FIFO command
+ * @chip:	The TPM chip instance
+ * @buf:	The request and response buffer object
+ * @bufsize:	Entire size available in buffer
+ *
+ * Return:
+ *  = 0 - Success, no returned data
+ *  > 0 - Success, value is the return data length
+ *  < 0 - Error occurred
+ */
+static int __init tpm_tis_transmit(struct tpm_chip *chip, u8 *buf, u32 bufsize)
+{
+	ktime_t stop;
+	u32 count;
+	u8 status;
+	int rc;
+
+	count = be32_to_cpu(*((u32 *) (buf + 2)));
+	if (count == 0)
+		return -ENODATA;
+
+	if (count > bufsize)
+		return -E2BIG;
+
+	rc = tpm_tis_send(chip, buf, count);
+	if (rc < 0)
+		goto out;
+
+	stop = tpm_now_ms() + TIS_DURATION;
+	do {
+		status = __tis_status(chip);
+		if ((status & (TPM_STS_DATA_AVAIL | TPM_STS_VALID)) ==
+			      (TPM_STS_DATA_AVAIL | TPM_STS_VALID))
+			goto out_recv;
+
+		if (status == TPM_STS_COMMAND_READY) {
+			rc = -ECANCELED;
+			goto out;
+		}
+
+		tpm_mdelay(TPM_TIMEOUT);
+		rmb();
+	} while (tpm_now_ms() < stop);
+
+	/* Cancel the command */
+	__tis_cancel(chip);
+	rc = -ETIME;
+	goto out;
+
+out_recv:
+	rc = tpm_tis_recv(chip, buf, bufsize);
+	if (rc >= 0) {
+		if (rc > 0 && rc < TPM_HEADER_SIZE)
+			return -EFAULT;
+		return rc;
+	}
+	/* Else return was an error, nothing to receive */
+
+out:
+	return rc;
+}
+
+/**
+ * tpm_find_interface_and_family - interface FIFO/CRB, family 2.0 or 1.2
+ * @chip:	The TPM chip instance
+ *
+ * Return: TPM family ID enum
+ */
+static enum tpm_family __init tpm_find_interface_and_family(struct tpm_chip *chip)
+{
+	struct tpm_intf_capability intf_cap;
+	struct tpm_interface_id intf_id;
+
+	/* Sort out whether it is 1.x */
+	intf_cap.val = tpm_read32(chip, TPM_INTF_CAPS(0));
+	if ((intf_cap.interface_version == TPM_TIS_INTF_12) ||
+	    (intf_cap.interface_version == TPM_TIS_INTF_13))
+		return TPM_FAMILY_12; /* Always TIS */
+
+	/* Assume that it is 2.0 but check if the interface is CRB */
+	intf_id.val = tpm_read32(chip, TPM_INTF_ID(0));
+	if (intf_id.interface_type == TPM_CRB_INTF_ACTIVE)
+		return TPM_FAMILY_INVALID;
+
+	/* Else TPM 2.0 with TIS interface */
+	return TPM_FAMILY_20;
+}
+
+/**
+ * tpm1_pcr_extend - send a TPM1 extend command to the device
+ * @chip:	a TPM chip to use
+ * @pcr_idx:	the PCR index to extend for the current locality
+ * @hash:	the SHA1 hash digest to extend
+ *
+ * Return:
+ * * 0		- OK
+ * * -errno	- A system error
+ * * TPM_RC	- A TPM error
+ */
+int __init tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash)
+{
+	struct tpm_buf *buf = tpm_buf_alloc_page();
+	int rc = 0;
+
+	tpm_buf_init(buf, TPM_BUFSIZE);
+	tpm_buf_reset(buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCR_EXTEND);
+
+	tpm_buf_append_u32(buf, pcr_idx);
+	tpm_buf_append(buf, hash, TPM_DIGEST_SIZE);
+
+	rc = tpm_tis_transmit(chip, buf->data, PAGE_SIZE);
+
+	/* Ignoring output */
+	if (rc > 0)
+		rc = 0;
+
+	tpm_buf_free_page();
+
+	return rc;
+}
+
+/**
+ * tpm2_pcr_extend() - send a TPM2 extend command to the device
+ *
+ * @chip:		TPM chip to use.
+ * @pcr_idx:		index of the PCR.
+ * @digests:		list of PCR banks and corresponding digest values to extend.
+ * @digest_count:	count of digests to extend
+ *
+ * Return:
+ * * 0		- OK
+ * * -errno	- A system error
+ * * TPM_RC	- A TPM error
+ */
+int __init tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
+			   struct tpm_digest *digests, u32 digest_count)
+{
+	struct tpm_buf *buf = tpm_buf_alloc_page();
+	int rc = 0, i;
+
+	tpm_buf_init(buf, TPM_BUFSIZE);
+	tpm_buf_reset(buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
+
+	tpm_buf_append_u32(buf, pcr_idx);
+
+	/* Setup a NULL auth session for the command */
+	tpm_buf_append_u32(buf, 9);
+	/* auth handle */
+	tpm_buf_append_u32(buf, TPM2_RS_PW);
+	/* nonce */
+	tpm_buf_append_u16(buf, 0);
+	/* attributes */
+	tpm_buf_append_u8(buf, 0);
+	/* passphrase */
+	tpm_buf_append_u16(buf, 0);
+
+	tpm_buf_append_u32(buf, digest_count);
+
+	for (i = 0; i < digest_count; i++) {
+		tpm_buf_append_u16(buf, digests[i].alg_id);
+		tpm_buf_append(buf, (const unsigned char *)&digests[i].digest,
+			       tpm_get_alg_size(digests[i].alg_id));
+	}
+
+	rc = tpm_tis_transmit(chip, buf->data, PAGE_SIZE);
+
+	/* Ignoring output */
+	if (rc > 0)
+		rc = 0;
+
+	tpm_buf_free_page();
+
+	return rc;
+}
+
+int __init early_tpm_init(struct tpm_chip *chip, u64 baseaddr)
+{
+	u32 didvid;
+
+	memset(chip, 0, sizeof(*chip));
+	chip->baseaddr = baseaddr;
+
+	chip->family = tpm_find_interface_and_family(chip);
+	if (chip->family == TPM_FAMILY_INVALID)
+		return TPM_ERR_INVALID_FAMILY;
+
+	/* Set default timeouts */
+	chip->timeout_a = TIS_SHORT_TIMEOUT;
+	chip->timeout_b = TIS_LONG_TIMEOUT;
+	chip->timeout_c = TIS_SHORT_TIMEOUT;
+	chip->timeout_d = TIS_SHORT_TIMEOUT;
+
+	/* Get the vendor and device ids */
+	didvid = tpm_read32(chip, TPM_DID_VID(0));
+	chip->did = didvid >> 16;
+	chip->vid = didvid & 0xFFFF;
+
+	return TPM_SUCCESS;
+}
+
+int __init early_tpm_fini(struct tpm_chip *chip)
+{
+	tpm_tis_release_locality(chip);
+	memset(chip, 0, sizeof(*chip));
+
+	return TPM_SUCCESS;
+}
-- 
2.47.3


