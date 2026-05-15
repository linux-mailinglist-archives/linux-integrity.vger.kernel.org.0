Return-Path: <linux-integrity+bounces-9566-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +E70AEmPB2rF8gIAu9opvQ
	(envelope-from <linux-integrity+bounces-9566-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:25:29 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A101F55800B
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 046B73069199
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 21:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BAC3F44C5;
	Fri, 15 May 2026 21:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEx+1FSC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA90A405869
	for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 21:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879744; cv=none; b=Po4tDZfHoUNZK71pwtBuw7LyfX6I39PXLY+rYaLKLzNWavtBqlr/Iqz+4QZO5ULc3ziZC/J1AetF49S2NFjdkVffsQmdHpue46uOrsHdpNpYDUq5YxX6LCwpZL8xuhpYlyIQ/Oo00jwAml0dGZD0AkpwL0gqum2NbFY3xhSyyBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879744; c=relaxed/simple;
	bh=e0yyIirk51jKbKjeSvwwc86YOmMN0kVT7bcodyWznw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqHVwtpFibAzqhAxbZuYsqgVeZT2tIm80MjMcgqTMuwzIReYVU3frt0Ru7XhgZdJL+wdIXONRx8FB2rqFKwnkHRzShBce9e6VspjlPFpvHmDCQkhGjNvvWMSIuifaxrKeo7RPs0sXLCpcTqrGIwjRF7o8tWYjgOyNd8pEDvK9/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEx+1FSC; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso151486eec.0
        for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 14:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879741; x=1779484541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vEqPpKnlZT3emBFthAb9OgKvlsNPtI0KrHZvILeiAis=;
        b=BEx+1FSCAC2VDyHx2jsKucZic9/qXOUxtRCWkk8iBdU5AV52bGQcBSI+8gjgO4KgQh
         BSebqAe0c4SELPulttZzYP/LsR9wjAiygJvmXW3LVXA7+vEP2X4k1gxhTfHTUx1aJWEm
         tf8tkaiXFmilx6F2X1iHHdVp/DHydvu0Yid2x+EVfn7nQOqIAqynNLHQlXYJOok0/x8S
         yZTFHZpxuiqwtDWEBXP0pfFJtftA47GFj2N7T2Ts6SLAZEKKBiv4qAGY7yLvysGE22Wi
         DDK3h4Ot0/oaTQVomg4FIjQhSlwB8rFBd7bU3O4pMRsv9p4jzCekyWosLrkhNjmaWm6J
         8SGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879741; x=1779484541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vEqPpKnlZT3emBFthAb9OgKvlsNPtI0KrHZvILeiAis=;
        b=PMYOjZC46Z/3XUD4+KhSFH/OZB0kCwz6jWnuhIw3pls5715tsTTduMx0LMVwTQImA8
         rOYNqnhFqoG6DVvjOY78LOlDKJU4ypHpwcvjtPxSj6N1FT9Mm4srNxmWfQ8qnPIueHP+
         IvMNd8rKCN9ASkYd5SqbRU3MGkMLa5zM1uI7OYPlF2MXWVBP3Hsj98+Y94/teSOkWhiS
         jOsFADxe6h8SJkfP/2CC3iqdOTj1ga3gK4/OD5+xRZ8kBbcdeuz7/9kEzF0H/D7TxFFz
         IX2HdmYik9TYfbp4hhNm3w+LjboXsh911pQcv4yAr2YAWdHVsckxRQCy8m+A0AlJ73PD
         cxkw==
X-Forwarded-Encrypted: i=1; AFNElJ8jvGC1T0FFf4vl1Ca6KTTsPjWTHiWcTZYRs+Wqrkaur7+4YGxQrodPrNnZpNH8doLwZZWc0G2F1vJ+Qs34K00=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymuf5MzOdl5lKunBQncG4TplECOr9hw1b4p6lz7LBoynqlFyII
	bJqBotev45+KNTxRKCfdSm5BCe/ips/ie27puMnCkKGVZgtMoiRV+O12RSLfe76I
X-Gm-Gg: Acq92OGxsHPdvIWP4t2k7wzk2+WY2OB/Xz11gH3yrgA8J40J8tfQCpt/mmlPjgRqu8O
	VO26uSfrkXuHqnHN5NQHIgts8uk52CahKub/X5bJhHduTfL238UGUwHu29ZXcG+9AoZOjbRcucT
	tuj94UCBs4gMfYldt8iBbM+hKbj6ze/dNoKCcoWo3Z/wJWJtl+BQ2kVFPdcw17jfb28Bc7LxDim
	c6Z2+4iflArLOhJ15hEZRPpGHHEaVX/HW2GG/ms+uJMgcyqOP4SvUHGlUOHJua0t2UhLykrhTJP
	h57vhJtJCYsW9ckqlBslhUtxEQt1eD/1QWed2aTZmnLfPhq8VmPAhrP7W4JDqsd+vLrqw7L/3gJ
	7kubm5w4ttFyoFx6WkOPbMyw07JodNnJRoCN13sUQhsrXUYpmOISNfNQ2b4DTzzTeyKDsuuD+iO
	yu9t6OSQPOxzVR6xWGd6uCuq4W4qcedBg=
X-Received: by 2002:a05:7300:d511:b0:2f9:1004:b2cd with SMTP id 5a478bee46e88-30262f3895emr5218501eec.20.1778879740764;
        Fri, 15 May 2026 14:15:40 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2e3c0sm9976142eec.3.2026.05.15.14.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:40 -0700 (PDT)
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
Subject: [PATCH v16 31/38] x86/slaunch: Secure Launch kernel early boot initialization
Date: Fri, 15 May 2026 14:14:03 -0700
Message-ID: <20260515211410.31440-32-ross.philipson@gmail.com>
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
X-Rspamd-Queue-Id: A101F55800B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9566-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apertussolutions.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,chip.family:url]
X-Rspamd-Action: no action

The sl_main() routine is responsible for measuring configuration and module
information before it is used by the kernel. An example of entities
measured on Intel x86 are the boot params, the kernel command line,
the TXT heap, any external initramfs, etc. In addition this routine
does some early setup and validation of the environment like locating
the TPM event log and validating the location of various buffers to
ensure they are protected and not overlapping.

Co-developed-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 arch/x86/boot/startup/sl_main.c | 610 ++++++++++++++++++++++++++++++++
 1 file changed, 610 insertions(+)

diff --git a/arch/x86/boot/startup/sl_main.c b/arch/x86/boot/startup/sl_main.c
index 1982cfb461dd..0110392470d0 100644
--- a/arch/x86/boot/startup/sl_main.c
+++ b/arch/x86/boot/startup/sl_main.c
@@ -15,14 +15,624 @@
 #include <linux/efi.h>
 #include <linux/slr_table.h>
 #include <linux/slaunch.h>
+#include <linux/tpm_ptp.h>
 
 #include "tpm.h"
 
+#define CAPS_VARIABLE_MTRR_COUNT_MASK	0xff
+
+#define SL_TPM_LOG		1
+#define SL_TPM2_LOG		2
+
+static void *evtlog_base;
+static u32 evtlog_size;
+static struct txt_heap_event_log_pointer2_1_element *log21_elem;
+static u32 tpm_log_ver = SL_TPM_LOG;
+static u32 tpm_num_algs;
+static struct tcg_efi_specid_event_algs *tpm_algs;
+static u8 event_buf[PAGE_SIZE];
+
+/* Simple instance of a TPM chip object */
+static struct tpm_chip chip __initdata;
+
+static struct slr_table *slrt __initdata;
+
 u32 sl_cpu_type __initdata;
 u32 sl_mle_start __initdata;
 
 void sl_main(void *bootparams);
 
+static void *txt_regs = (void *)TXT_PRIV_CONFIG_REGS_BASE;
+#define sl_txt_read(r) readq(txt_regs + r)
+#define sl_txt_write(r, v) writeq(v, txt_regs + r)
+
+static void *txt_heap __initdata;
+static struct sl_txt_heap_info txt_heap_map[TXT_SINIT_TABLE_MAX] __initdata;
+
+struct sl_txt_heap_info * __init sl_txt_get_heap_map(void);
+void * __init sl_txt_get_heap_table(void *heap, u8 index);
+
+struct sl_txt_heap_info * __init sl_txt_get_heap_map(void)
+{
+	return txt_heap_map;
+}
+
+void * __init sl_txt_get_heap_table(void *heap, u8 index)
+{
+	return heap + txt_heap_map[index].offset;
+}
+
+static void __init txt_parse_heap_map(void *heap)
+{
+	void *tmp = heap;
+
+	for (u8 i = 0; i < TXT_SINIT_TABLE_MAX; i++) {
+		txt_heap_map[i].size = *((u64 *) tmp);
+		txt_heap_map[i].offset = tmp - heap + sizeof(txt_heap_map[i].size);
+		tmp += txt_heap_map[i].size;
+	}
+}
+
+void __warn_printk(const char *fmt, ...)
+{
+}
+
+static void __noreturn __init sl_txt_reset(u64 error)
+{
+	/* Reading the E2STS register acts as a barrier for TXT registers */
+	sl_txt_write(TXT_CR_ERRORCODE, error);
+	sl_txt_read(TXT_CR_E2STS);
+	sl_txt_write(TXT_CR_CMD_UNLOCK_MEM_CONFIG, 1);
+	sl_txt_read(TXT_CR_E2STS);
+	sl_txt_write(TXT_CR_CMD_RESET, 1);
+
+	for ( ; ; )
+		asm volatile ("hlt");
+
+	unreachable();
+}
+
+static inline u64 __init sl_rdmsr(u32 reg)
+{
+	struct msr m;
+
+	raw_rdmsr(reg, &m);
+
+	return m.q;
+}
+
+static struct slr_table *__init sl_locate_and_validate_slrt(void)
+{
+	struct txt_os_mle_data *os_mle_data;
+	struct slr_table *slrt;
+
+	os_mle_data = sl_txt_get_heap_table(txt_heap, TXT_OS_MLE_DATA_TABLE);
+
+	if (!os_mle_data->slrt)
+		sl_txt_reset(SL_ERROR_INVALID_SLRT);
+
+	slrt = (struct slr_table *)os_mle_data->slrt;
+
+	if (slrt->magic != SLR_TABLE_MAGIC)
+		sl_txt_reset(SL_ERROR_INVALID_SLRT);
+
+	if (slrt->architecture != SLR_INTEL_TXT)
+		sl_txt_reset(SL_ERROR_INVALID_SLRT);
+
+	return slrt;
+}
+
+/*
+ * This is a validation routine that allows checking if a block of memory
+ * is protected from external access by being in a PMR range. If allow_hi is
+ * set, ranges above 4GB are allowed.
+ */
+static void __init sl_check_pmr_coverage(void *base, u32 size, bool allow_hi)
+{
+	struct txt_os_sinit_data *os_sinit_data;
+	void *end = base + size;
+
+	if (!(sl_cpu_type & SL_CPU_INTEL))
+		return;
+
+	os_sinit_data = sl_txt_get_heap_table(txt_heap, TXT_OS_SINIT_DATA_TABLE);
+
+	if ((u64)end >= SZ_4G && (u64)base < SZ_4G)
+		sl_txt_reset(SL_ERROR_REGION_STRADDLE_4GB);
+
+	/*
+	 * Note that the late stub code validates that the hi PMR covers
+	 * all memory above 4G. At this point the code can only check that
+	 * regions are within the hi PMR but that is sufficient.
+	 */
+	if ((u64)end > SZ_4G && (u64)base >= SZ_4G) {
+		if (allow_hi) {
+			if (end >= (void *)(os_sinit_data->vtd_pmr_hi_base +
+					    os_sinit_data->vtd_pmr_hi_size))
+				sl_txt_reset(SL_ERROR_BUFFER_BEYOND_PMR);
+		} else {
+			sl_txt_reset(SL_ERROR_REGION_ABOVE_4GB);
+		}
+	}
+
+	if (end >= (void *)os_sinit_data->vtd_pmr_lo_size)
+		sl_txt_reset(SL_ERROR_BUFFER_BEYOND_PMR);
+}
+
+/*
+ * Some MSRs are modified by the pre-launch code including the MTRRs.
+ * The early MLE code has to restore these values. This code validates
+ * the values after they are measured.
+ */
+static void __init sl_txt_validate_msrs(struct txt_os_mle_data *os_mle_data)
+{
+	struct slr_txt_mtrr_state *saved_bsp_mtrrs;
+	u64 mtrr_caps, mtrr_def_type, mtrr_var;
+	struct slr_entry_intel_info *txt_info;
+	u64 misc_en_msr;
+	u32 vcnt, i;
+
+	txt_info = (struct slr_entry_intel_info *)os_mle_data->txt_info;
+	saved_bsp_mtrrs = &txt_info->saved_bsp_mtrrs;
+
+	mtrr_caps = sl_rdmsr(MSR_MTRRcap);
+	vcnt = (u32)(mtrr_caps & CAPS_VARIABLE_MTRR_COUNT_MASK);
+
+	if (saved_bsp_mtrrs->mtrr_vcnt > vcnt)
+		sl_txt_reset(SL_ERROR_MTRR_INV_VCNT);
+	if (saved_bsp_mtrrs->mtrr_vcnt > TXT_OS_MLE_MAX_VARIABLE_MTRRS)
+		sl_txt_reset(SL_ERROR_MTRR_INV_VCNT);
+
+	mtrr_def_type = sl_rdmsr(MSR_MTRRdefType);
+	if (saved_bsp_mtrrs->default_mem_type != mtrr_def_type)
+		sl_txt_reset(SL_ERROR_MTRR_INV_DEF_TYPE);
+
+	for (i = 0; i < saved_bsp_mtrrs->mtrr_vcnt; i++) {
+		mtrr_var = sl_rdmsr(MTRRphysBase_MSR(i));
+		if (saved_bsp_mtrrs->mtrr_pair[i].mtrr_physbase != mtrr_var)
+			sl_txt_reset(SL_ERROR_MTRR_INV_BASE);
+		mtrr_var = sl_rdmsr(MTRRphysMask_MSR(i));
+		if (saved_bsp_mtrrs->mtrr_pair[i].mtrr_physmask != mtrr_var)
+			sl_txt_reset(SL_ERROR_MTRR_INV_MASK);
+	}
+
+	misc_en_msr = sl_rdmsr(MSR_IA32_MISC_ENABLE);
+	if (txt_info->saved_misc_enable_msr != misc_en_msr)
+		sl_txt_reset(SL_ERROR_MSR_INV_MISC_EN);
+}
+
+static void __init sl_find_drtm_event_log(struct slr_table *slrt)
+{
+	struct txt_os_sinit_data *os_sinit_data;
+	struct slr_entry_log_info *log_info;
+
+	log_info = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_LOG_INFO);
+	if (!log_info)
+		sl_txt_reset(SL_ERROR_SLRT_MISSING_ENTRY);
+
+	evtlog_base = (void *)log_info->addr;
+	evtlog_size = log_info->size;
+
+	/*
+	 * For TPM 2.0, the TXT event log 2.1 extended data structure has to also
+	 * be located to find the actual log.
+	 */
+	os_sinit_data = sl_txt_get_heap_table(txt_heap, TXT_OS_SINIT_DATA_TABLE);
+
+	/*
+	 * Only support version 6 and later that properly handle the
+	 * list of ExtDataElements in the OS-SINIT structure.
+	 */
+	if (os_sinit_data->version < 6)
+		sl_txt_reset(SL_ERROR_OS_SINIT_BAD_VERSION);
+
+	/* Find the TPM2.0 logging extended heap element */
+	log21_elem = txt_find_log2_1_element(os_sinit_data);
+
+	/* If found, this implies TPM2 log and family */
+	if (log21_elem)
+		tpm_log_ver = SL_TPM2_LOG;
+}
+
+static void __init sl_validate_event_log_buffer(void)
+{
+	struct txt_os_sinit_data *os_sinit_data;
+	void *mle_base, *mle_end;
+	void *evtlog_end;
+	void *txt_end;
+
+	if ((u64)evtlog_size > (LLONG_MAX - (u64)evtlog_base))
+		sl_txt_reset(SL_ERROR_INTEGER_OVERFLOW);
+	evtlog_end = evtlog_base + evtlog_size;
+
+	txt_end = txt_heap + sl_txt_read(TXT_CR_HEAP_SIZE);
+	os_sinit_data = sl_txt_get_heap_table(txt_heap, TXT_OS_SINIT_DATA_TABLE);
+
+	mle_base = (void *)(u64)sl_mle_start;
+	mle_end = mle_base + os_sinit_data->mle_size;
+
+	/*
+	 * This check is to ensure the event log buffer does not overlap with
+	 * the MLE image.
+	 */
+	if (evtlog_base >= mle_end && evtlog_end > mle_end)
+		goto pmr_check; /* above */
+
+	if (evtlog_end <= mle_base && evtlog_base < mle_base)
+		goto pmr_check; /* below */
+
+	sl_txt_reset(SL_ERROR_MLE_BUFFER_OVERLAP);
+
+pmr_check:
+	/*
+	 * The TXT heap is protected by the DPR. If the TPM event log is
+	 * inside the TXT heap, there is no need for a PMR check.
+	 */
+	if (evtlog_base > txt_heap && evtlog_end < txt_end)
+		return;
+
+	sl_check_pmr_coverage(evtlog_base, evtlog_size, true);
+}
+
+static void __init sl_find_event_log_algorithms(void)
+{
+	struct tcg_efi_specid_event_head *efi_head =
+		(struct tcg_efi_specid_event_head *)(evtlog_base +
+						     sizeof(struct tcg_pcr_event));
+	u32 i;
+
+	if (efi_head->num_algs == 0)
+		sl_txt_reset(SL_ERROR_TPM_INVALID_ALGS);
+
+	tpm_algs = &efi_head->digest_sizes[0];
+	tpm_num_algs = efi_head->num_algs;
+
+	for (i = 0; i < tpm_num_algs; i++) {
+		if (tpm_algs[i].digest_size > TPM2_MAX_DIGEST_SIZE)
+			sl_txt_reset(SL_ERROR_TPM_INVALID_ALGS);
+		/* Alg ID 0 is invalid and maps to TPM_ALG_ERROR */
+		if (tpm_algs[i].alg_id == TPM_ALG_ERROR)
+			sl_txt_reset(SL_ERROR_TPM_INVALID_ALGS);
+	}
+}
+
+static void __init sl_tpm1_extend(u32 pcr, u32 event_type,
+				  const u8 *data, u32 length,
+				  const u8 *event_data, u32 event_size)
+{
+	u8 sha1_hash[SHA1_DIGEST_SIZE] = {0};
+	struct tcg_pcr_event *pcr_event;
+	u32 total_size;
+
+	/* Clear on each use */
+	memset(event_buf, 0, PAGE_SIZE);
+
+	pcr_event = (struct tcg_pcr_event *)event_buf;
+	pcr_event->pcr_idx = pcr;
+	pcr_event->event_type = event_type;
+	if (length > 0) {
+		sha1(data, length, &sha1_hash[0]);
+		memcpy(&pcr_event->digest[0], &sha1_hash[0], SHA1_DIGEST_SIZE);
+	}
+	pcr_event->event_size = event_size;
+	if (event_size > 0)
+		memcpy((u8 *)pcr_event + sizeof(*pcr_event),
+		       event_data, event_size);
+
+	total_size = sizeof(*pcr_event) + event_size;
+
+	/* Do the TPM extend then log the event */
+	if (tpm1_pcr_extend(&chip, pcr, &sha1_hash[0]))
+		sl_txt_reset(SL_ERROR_TPM_EXTEND);
+
+	if (tpm_log_event(evtlog_base, evtlog_size, total_size, pcr_event))
+		sl_txt_reset(SL_ERROR_TPM_LOGGING_FAILED);
+}
+
+static void __init sl_tpm2_extend(u32 pcr, u32 event_type,
+				  const u8 *data, u32 length,
+				  const u8 *event_data, u32 event_size)
+{
+	struct tcg_pcr_event2_head *head;
+	struct tcg_event_field *event;
+	u8 digest[TPM2_MAX_DIGEST_SIZE];
+	u32 total_size, alg_idx;
+	u16 *alg_ptr;
+	u8 *dgst_ptr;
+	int rc;
+
+	/* Clear on each use */
+	memset(event_buf, 0, PAGE_SIZE);
+
+	head = (struct tcg_pcr_event2_head *)event_buf;
+	head->pcr_idx = pcr;
+	head->event_type = event_type;
+	total_size = sizeof(*head);
+	alg_ptr = (u16 *)(event_buf + sizeof(*head));
+
+	for (alg_idx = 0; alg_idx < tpm_num_algs; alg_idx++) {
+		memset(digest, 0, TPM2_MAX_DIGEST_SIZE);
+
+		*alg_ptr = tpm_algs[alg_idx].alg_id;
+		dgst_ptr = (u8 *)alg_ptr + sizeof(u16);
+
+		if (tpm_algs[alg_idx].alg_id == TPM_ALG_SHA256) {
+			sha256(data, length, &digest[0]);
+		} else if (tpm_algs[alg_idx].alg_id == TPM_ALG_SHA384) {
+			sha384(data, length, &digest[0]);
+		} else if (tpm_algs[alg_idx].alg_id == TPM_ALG_SHA512) {
+			sha512(data, length, &digest[0]);
+		} else if (tpm_algs[alg_idx].alg_id == TPM_ALG_SHA1) {
+			sha1(data, length, &digest[0]);
+		} else {
+			/*
+			 * If there are TPM banks in use that are not supported
+			 * in software here, the PCR in that bank will be capped with
+			 * the well-known value 1 as the Intel ACM does.
+			 */
+			digest[0] = 0x01;
+		}
+
+		memcpy(dgst_ptr, &digest[0], tpm_algs[alg_idx].digest_size);
+		total_size += tpm_algs[alg_idx].digest_size + sizeof(u16);
+		alg_ptr = (u16 *)((u8 *)alg_ptr +
+			      tpm_algs[alg_idx].digest_size + sizeof(u16));
+
+		head->count++;
+	}
+
+	event = (struct tcg_event_field *)(event_buf + total_size);
+	event->event_size = event_size;
+	if (event_size > 0)
+		memcpy((u8 *)event + sizeof(*event), event_data, event_size);
+	total_size += sizeof(*event) + event_size;
+
+	/*
+	 * Do the TPM extend then log the event. Note the digest list is packed
+	 * in the event behind the event header.
+	 */
+	rc = tpm2_pcr_extend(&chip, pcr, (struct tpm_digest *)(event_buf + sizeof(*head)),
+			     head->count);
+	if (rc)
+		sl_txt_reset(SL_ERROR_TPM_EXTEND);
+
+	if (tpm2_log_event(log21_elem, evtlog_base, evtlog_size,
+			   total_size, &event_buf[0]))
+		sl_txt_reset(SL_ERROR_TPM_LOGGING_FAILED);
+}
+
+static void __init sl_tpm_extend(u32 pcr, u32 type, const u8 *data, u32 length,
+				 const char *desc)
+{
+	if (chip.family == TPM_FAMILY_20)
+		sl_tpm2_extend(pcr, type, data, length, (const u8 *)desc, strlen(desc));
+	else
+		sl_tpm1_extend(pcr, type, data, length, (const u8 *)desc, strlen(desc));
+}
+
+static void __init sl_handle_setup_data(struct setup_data *curr,
+					struct slr_policy_entry *entry)
+{
+	struct setup_indirect *ind;
+
+	/* SETUP_INDIRECT instances have to be handled differently */
+	if (curr->type == SETUP_INDIRECT) {
+		ind = (struct setup_indirect *)((u8 *)curr +
+						offsetof(struct setup_data, data));
+
+		sl_check_pmr_coverage((void *)ind->addr, ind->len, true);
+
+		sl_tpm_extend(entry->pcr, SL_EVTYPE_SECURE_LAUNCH, (void *)ind->addr,
+			      ind->len, entry->evt_info);
+	}
+
+	sl_check_pmr_coverage(((u8 *)curr) + sizeof(*curr),
+			      curr->len, true);
+
+	sl_tpm_extend(entry->pcr, SL_EVTYPE_SECURE_LAUNCH, ((u8 *)curr) + sizeof(*curr),
+		      curr->len, entry->evt_info);
+}
+
+/*
+ * The setup_data linked list in the boot_params (if present) must be
+ * processed element by element. Indirect elements need to have their
+ * pointers followed to the actual data to measure.
+ */
+static void __init sl_extend_setup_data(struct slr_policy_entry *entry)
+{
+	struct setup_data *data = (void *)(unsigned long)entry->entity;
+
+	/*
+	 * Measure any setup_data entries including e820 extended entries.
+	 * Note that the e820 fixed entries are in the boot params structure
+	 * itself and measured there.
+	 */
+	while (data) {
+		sl_handle_setup_data(data, entry);
+		data = (void *)(unsigned long)data->next;
+	}
+}
+
+static void __init sl_extend_slrt(struct slr_policy_entry *entry)
+{
+	struct slr_table *slrt = (struct slr_table *)entry->entity;
+	struct slr_entry_intel_info *intel_info;
+	struct slr_entry_intel_info intel_tmp;
+
+	/*
+	 * In revision one of the SLRT, the only table that needs to be
+	 * measured is the Intel info table. Everything else is meta-data,
+	 * addresses and sizes. Note the size of what to measure is not set.
+	 * The flag SLR_POLICY_IMPLICIT_SIZE leaves it to the measuring code
+	 * to sort out.
+	 */
+	if (slrt->revision == 1) {
+		intel_info = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_INTEL_INFO);
+		if (!intel_info)
+			sl_txt_reset(SL_ERROR_SLRT_MISSING_ENTRY);
+
+		/*
+		 * Make a temp copy and zero out address fields since they should
+		 * not be measured.
+		 */
+		intel_tmp = *intel_info;
+		intel_tmp.boot_params_addr = 0;
+		intel_tmp.txt_heap = 0;
+
+		sl_tpm_extend(entry->pcr, SL_EVTYPE_SECURE_LAUNCH, (void *)&intel_tmp,
+			      sizeof(*intel_info), entry->evt_info);
+	}
+}
+
+static void __init sl_extend_txt_os2mle(struct slr_policy_entry *entry)
+{
+	struct txt_os_mle_data *os_mle_data;
+
+	os_mle_data = sl_txt_get_heap_table(txt_heap, TXT_OS_MLE_DATA_TABLE);
+
+	/*
+	 * Version 1 of the OS-MLE heap structure has no fields to measure. It just
+	 * has addresses and sizes and a scratch buffer.
+	 */
+	if (os_mle_data->version == 1)
+		return;
+}
+
+/*
+ * Process all policy entries and extend the measurements to the evtlog. Note
+ * that some entries need special processing which is done in subroutines.
+ */
+static void __init sl_process_extend_policy(struct slr_table *slrt)
+{
+	struct slr_entry_policy *policy;
+	u16 i;
+
+	policy = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_ENTRY_POLICY);
+	if (!policy)
+		sl_txt_reset(SL_ERROR_SLRT_MISSING_ENTRY);
+
+	for (i = 0; i < policy->nr_entries; i++) {
+		switch (policy->policy_entries[i].entity_type) {
+		case SLR_ET_SETUP_DATA:
+			sl_extend_setup_data(&policy->policy_entries[i]);
+			break;
+		case SLR_ET_SLRT:
+			sl_extend_slrt(&policy->policy_entries[i]);
+			break;
+		case SLR_ET_TXT_OS2MLE:
+			sl_extend_txt_os2mle(&policy->policy_entries[i]);
+			break;
+		case SLR_ET_UNUSED:
+			continue;
+		default:
+			sl_tpm_extend(policy->policy_entries[i].pcr,
+				      SL_EVTYPE_SECURE_LAUNCH,
+				      (void *)policy->policy_entries[i].entity,
+				      policy->policy_entries[i].size,
+				      policy->policy_entries[i].evt_info);
+		}
+	}
+}
+
+/*
+ * Process all EFI config entries and extend the measurements to the evtlog
+ */
+static void __init sl_process_extend_uefi_config(struct slr_table *slrt)
+{
+	struct slr_entry_uefi_config *uefi_config;
+	u16 i;
+
+	uefi_config = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_UEFI_CONFIG);
+
+	/* Optionally here depending on how SL kernel was booted */
+	if (!uefi_config)
+		return;
+
+	for (i = 0; i < uefi_config->nr_entries; i++) {
+		sl_tpm_extend(uefi_config->uefi_cfg_entries[i].pcr,
+			      SL_EVTYPE_SECURE_LAUNCH,
+			      (void *)uefi_config->uefi_cfg_entries[i].cfg,
+			      uefi_config->uefi_cfg_entries[i].size,
+			      uefi_config->uefi_cfg_entries[i].evt_info);
+	}
+}
+
 asmlinkage __visible __init void sl_main(void *bootparams)
 {
+	struct boot_params *bp = (struct boot_params *)bootparams;
+	struct txt_os_mle_data *os_mle_data;
+
+	/*
+	 * Ensure loadflags do not indicate a secure launch was done
+	 * unless it really was.
+	 */
+	bp->hdr.loadflags &= ~SLAUNCH_FLAG;
+
+	/*
+	 * Currently only Intel TXT is supported for Secure Launch. Testing
+	 * this value also indicates that the kernel was booted successfully
+	 * through the Secure Launch entry point and is in SMX mode.
+	 */
+	if (!(sl_cpu_type & SL_CPU_INTEL))
+		return;
+
+	txt_heap = (void *)sl_txt_read(TXT_CR_HEAP_BASE);
+	txt_parse_heap_map(txt_heap);
+
+	/* Find the SLRT setup by the pre-launch stage */
+	slrt = sl_locate_and_validate_slrt();
+
+	/* Locate the TPM event log. */
+	sl_find_drtm_event_log(slrt);
+
+	/* Validate the location of the event log buffer before using it */
+	sl_validate_event_log_buffer();
+
+	/*
+	 * Find the TPM hash algorithms used by the ACM and recorded in the
+	 * event log.
+	 */
+	if (tpm_log_ver == SL_TPM2_LOG)
+		sl_find_event_log_algorithms();
+
+	/*
+	 * Prepare the early TPM driver to do PCR extends for the DRTM
+	 * measurements. On a successful DRTM launch, TPM locality 2
+	 * should be available to open/acquire.
+	 *
+	 * Note that the early TPM driver does not use interrupts but
+	 * rather polling for command completion (there is no infrastructure
+	 * setup for servicing interrupts in the setup kernel).
+	 */
+	if (early_tpm_init(&chip, TIS_MEM_X86_LPC_BASE))
+		sl_txt_reset(SL_ERROR_TPM_INIT);
+	if (tpm_tis_request_locality(&chip, TPM_LOCALITY_2) < 0)
+		sl_txt_reset(SL_ERROR_TPM_INIT);
+	if (chip.family == TPM_FAMILY_20 && tpm_log_ver != SL_TPM2_LOG)
+		sl_txt_reset(SL_ERROR_TPM_INIT);
+	tpm_tis_disable_interrupts(&chip);
+
+	/*
+	 * Set the SLAUNCH_FLAG early since if anything fails, the system will
+	 * reset anyway.
+	 */
+	bp->hdr.loadflags |= SLAUNCH_FLAG;
+
+	sl_check_pmr_coverage(bootparams, PAGE_SIZE, false);
+
+	/*
+	 * Extend measurements into the TPM for entities specified in the
+	 * SLRT policies.
+	 */
+	sl_process_extend_policy(slrt);
+	sl_process_extend_uefi_config(slrt);
+
+	/* No PMR check is needed, the TXT heap is covered by the DPR */
+	os_mle_data = sl_txt_get_heap_table(txt_heap, TXT_OS_MLE_DATA_TABLE);
+
+	/*
+	 * Now that the OS-MLE data is measured, ensure the MTRR and
+	 * misc enable MSRs are what we expect.
+	 */
+	sl_txt_validate_msrs(os_mle_data);
 }
-- 
2.47.3


