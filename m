Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174952A18CC
	for <lists+linux-integrity@lfdr.de>; Sat, 31 Oct 2020 17:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgJaQqv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 31 Oct 2020 12:46:51 -0400
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21189 "EHLO
        sender4-of-o51.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbgJaQqv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 31 Oct 2020 12:46:51 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1604162693; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=TjgWLACAyRPjNFuKMjGJBD8Ob768A7xHyiSjPp01mY/ywJei/MMrvuU8ntAHrknHDp7YLc4CPEeFgij0acRYsnjoi0ZdL+qBcekkJXyD3cAbZCaYPtdudhhi0HCvuhT2Iaewjs36aZCocAaIc3gAbzRK59RKGax1Fk4YKEN8NDg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1604162693; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To; 
        bh=MNc5hhNnyvxdjdrSh1qKoTTiBZLguIykld2BP83tdm8=; 
        b=bJ67D0UGR5ySG88q9Fn+4wwAIco6aHfmF1eVHgujAcim8vUgQeLi17CtYi3l1iT4U4DgFBuIXvrDgbRUcputujPtIlcAX2gHUWtk6vX+76LfegBWXUfs8d/bcxyciYI3T1AlbZo2pEuzCJkc8Tvv2O6L+PHVo6dCAkbkr+j5cR8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=apertussolutions.com;
        spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
        dmarc=pass header.from=<dpsmith@apertussolutions.com> header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1604162693;
        s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=MNc5hhNnyvxdjdrSh1qKoTTiBZLguIykld2BP83tdm8=;
        b=Q6iTwbWZbaq+oPBUtHus6Hh5a4yJu5tK0b016yuzFW9H1/06LXwujqVeoZwHhx1F
        oD50OLil3vqbDbhwoZzGOaPq2EKdGwf5jOfrwDSR5dHAJDMFEOWAjoWEPoNtHHFy4Of
        Z5xVlhdOQsTayA2vIISMBcd/tiNrOabpiNbKJA5U=
Received: from sisyou.hme. (c-73-129-147-140.hsd1.md.comcast.net [73.129.147.140]) by mx.zohomail.com
        with SMTPS id 1604162692176785.9821963345346; Sat, 31 Oct 2020 09:44:52 -0700 (PDT)
From:   "Daniel P. Smith" <dpsmith@apertussolutions.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        jarkko.sakkinen@linux.intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, luto@amacapital.net,
        trenchboot-devel@googlegroups.com
Subject: [RFC PATCH 4/4] x86: Add early PCR extend support for Secure Launch
Date:   Sat, 31 Oct 2020 12:51:22 -0400
Message-Id: <20201031165122.21539-5-dpsmith@apertussolutions.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201031165122.21539-1-dpsmith@apertussolutions.com>
References: <20201031165122.21539-1-dpsmith@apertussolutions.com>
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Access to PCR extend functionality is needed early in the compressed
kernel so that Secure Launch can measure items into the DRTM PCRs
before these items are used. The items include the boot parameters and
associated information, the kernel command line, any external initrd
and the OS-MLE TXT heap structure.

NOTE: for the RFC, early_pcr_extend.c is built unconditionally in the
Makefile. In the full Secure Launch patch set it is conditionally built
if CONFIG_SECURE_LAUNCH is defined.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/boot/compressed/Makefile           |   2 +
 arch/x86/boot/compressed/early_pcr_extend.c | 311 ++++++++++++++++++++++++++++
 arch/x86/boot/compressed/early_pcr_extend.h |  92 ++++++++
 3 files changed, 405 insertions(+)
 create mode 100644 arch/x86/boot/compressed/early_pcr_extend.c
 create mode 100644 arch/x86/boot/compressed/early_pcr_extend.h

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 5a828fde7a42..8f0b29dce9da 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -93,6 +93,8 @@ vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
 efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
 
+vmlinux-objs-y += $(obj)/early_pcr_extend.o
+
 # The compressed kernel is built with -fPIC/-fPIE so that a boot loader
 # can place it anywhere in memory and it will still run. However, since
 # it is executed as-is without any ELF relocation processing performed
diff --git a/arch/x86/boot/compressed/early_pcr_extend.c b/arch/x86/boot/compressed/early_pcr_extend.c
new file mode 100644
index 000000000000..94ee3cc9814e
--- /dev/null
+++ b/arch/x86/boot/compressed/early_pcr_extend.c
@@ -0,0 +1,311 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 Apertus Solutions, LLC
+ *
+ * Author(s):
+ *      Daniel P. Smith <dpsmith@apertussolutions.com>
+ *
+ * The code in this file is based on the article "Writing a TPM Device Driver"
+ * published on http://ptgmedia.pearsoncmg.com.
+ *
+ * The scope of the TPM functionality here is solely to allow DRTM PCRs to be
+ * extended early in the compressed kernel.
+ */
+
+#include <linux/types.h>
+#include <linux/bits.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <asm/byteorder.h>
+#include <asm/io.h>
+
+#define COMPRESSED_KERNEL
+#include <crypto/sha.h>
+#include <linux/tpm_buffer.h>
+#include <linux/tpm_command.h>
+#include <linux/tpm_core.h>
+#include "../../../../drivers/char/tpm/tpm_tis_defs.h"
+#include "early_pcr_extend.h"
+
+#define tpm_read8(f) readb((void *)(u64)(TPM_MMIO_BASE | f))
+#define tpm_write8(v, f) writeb(v, (void *)(u64)(TPM_MMIO_BASE | f))
+#define tpm_read32(f) readl((void *)(u64)(TPM_MMIO_BASE | f));
+
+static struct tpm tpm;
+static u8 locality = TPM_NO_LOCALITY;
+
+static void tpm_io_delay(void)
+{
+	/* This is the default delay type in native_io_delay */
+	asm volatile ("outb %al, $0x80");
+}
+
+static void tpm_udelay(int loops)
+{
+	while (loops--)
+		tpm_io_delay();	/* Approximately 1 us */
+}
+
+static u32 burst_wait(void)
+{
+	u32 count = 0;
+
+	while (count == 0) {
+		count = tpm_read8(TPM_STS(locality) + 1);
+		count += tpm_read8(TPM_STS(locality) + 2) << 8;
+
+		/* Wait for FIFO to drain */
+		if (count == 0)
+			tpm_udelay(TPM_BURST_MIN_DELAY);
+	}
+
+	return count;
+}
+
+static void tis_relinquish_locality(void)
+{
+	if (locality < TPM_MAX_LOCALITY)
+		tpm_write8(TPM_ACCESS_ACTIVE_LOCALITY, TPM_ACCESS(locality));
+
+	locality = TPM_NO_LOCALITY;
+}
+
+static u8 tis_request_locality(u8 l)
+{
+	if (l > TPM_MAX_LOCALITY)
+		return TPM_NO_LOCALITY;
+
+	if (l == locality)
+		return locality;
+
+	tis_relinquish_locality();
+
+	tpm_write8(TPM_ACCESS_REQUEST_USE, TPM_ACCESS(l));
+
+	/* wait for locality to be granted */
+	if (tpm_read8(TPM_ACCESS(l)) & TPM_ACCESS_ACTIVE_LOCALITY)
+		locality = l;
+
+	return locality;
+}
+
+static size_t tis_send(struct tpm_buf *buf)
+{
+	u8 status, *buf_ptr;
+	u32 length, count = 0, burstcnt = 0;
+
+	if (locality > TPM_MAX_LOCALITY)
+		return 0;
+
+	for (status = 0; (status & TPM_STS_COMMAND_READY) == 0; ) {
+		tpm_write8(TPM_STS_COMMAND_READY, TPM_STS(locality));
+		status = tpm_read8(TPM_STS(locality));
+	}
+
+	buf_ptr = buf->data;
+	length = tpm_buf_length(buf);
+
+	/* send all but the last byte */
+	while (count < (length - 1)) {
+		burstcnt = burst_wait();
+		for (; burstcnt > 0 && count < (length - 1); burstcnt--) {
+			tpm_write8(buf_ptr[count], TPM_DATA_FIFO(locality));
+			count++;
+		}
+
+		/* check for overflow */
+		for (status = 0; (status & TPM_STS_VALID) == 0; )
+			status = tpm_read8(TPM_STS(locality));
+
+		if ((status & TPM_STS_DATA_EXPECT) == 0)
+			return 0;
+	}
+
+	/* write last byte */
+	tpm_write8(buf_ptr[length - 1], TPM_DATA_FIFO(locality));
+	count++;
+
+	/* make sure it stuck */
+	for (status = 0; (status & TPM_STS_VALID) == 0; )
+		status = tpm_read8(TPM_STS(locality));
+
+	if ((status & TPM_STS_DATA_EXPECT) != 0)
+		return 0;
+
+	/* go and do it */
+	tpm_write8(TPM_STS_GO, TPM_STS(locality));
+
+	return (size_t)count;
+}
+
+static u8 tis_init(struct tpm *t)
+{
+	locality = TPM_NO_LOCALITY;
+
+	if (tis_request_locality(0) != 0)
+		return 0;
+
+	t->vendor = tpm_read32(TPM_DID_VID(0));
+	if ((t->vendor & 0xFFFF) == 0xFFFF)
+		return 0;
+
+	return 1;
+}
+
+static u16 tpm_alg_size(u16 alg_id)
+{
+	if (alg_id == TPM_ALG_SHA1)
+		return SHA1_DIGEST_SIZE;
+	else if (alg_id == TPM_ALG_SHA256)
+		return SHA256_DIGEST_SIZE;
+	else if (alg_id == TPM_ALG_SHA512)
+		return SHA512_DIGEST_SIZE;
+
+	return 0;
+}
+
+static int tpm1_pcr_extend(struct tpm *t, u32 pcr, struct tpm_digest *d)
+{
+	struct tpm_buf buf;
+	int ret;
+
+	ret = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCR_EXTEND);
+	if (ret)
+		return ret;
+
+	tpm_buf_append_u32(&buf, pcr);
+	tpm_buf_append(&buf, d->digest, tpm_alg_size(TPM_ALG_SHA1));
+
+	if (tpm_buf_length(&buf) != tis_send(&buf))
+		ret = -EAGAIN;
+
+	return ret;
+}
+
+static int tpm2_extend_pcr(struct tpm *t, u32 pcr, struct tpm_digest *digest)
+{
+	struct tpm_buf buf;
+	u8 auth_area[NULL_AUTH_SIZE] = {0};
+	u32 *handle;
+	int ret;
+
+	ret = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
+	if (ret)
+		return ret;
+
+	tpm_buf_append_u32(&buf, pcr);
+
+	/*
+	 * The handle, the first element, is the
+	 * only non-zero value in a NULL auth
+	 */
+	handle = (u32 *)&auth_area;
+	*handle = cpu_to_be32(TPM2_RS_PW);
+
+	tpm_buf_append_u32(&buf, NULL_AUTH_SIZE);
+	tpm_buf_append(&buf, (const unsigned char *)&auth_area,
+                       NULL_AUTH_SIZE);
+
+	tpm_buf_append_u32(&buf, 1);
+
+	tpm_buf_append_u16(&buf, digest->alg_id);
+	tpm_buf_append(&buf, (const unsigned char *)digest->digest,
+		       tpm_alg_size(digest->alg_id));
+
+	if (tpm_buf_length(&buf) != tis_send(&buf))
+		ret = -EAGAIN;
+
+	return ret;
+}
+
+static void find_interface_and_family(struct tpm *t)
+{
+	struct tpm_interface_id intf_id;
+	struct tpm_intf_capability intf_cap;
+
+	/* Sort out whether if it is 1.2 */
+	intf_cap.val = tpm_read32(TPM_INTF_CAPABILITY_0);
+	if ((intf_cap.interface_version == TPM12_TIS_INTF_12) ||
+	    (intf_cap.interface_version == TPM12_TIS_INTF_13)) {
+		t->family = TPM12;
+		t->intf = TPM_TIS;
+		return;
+	}
+
+	/* Assume that it is 2.0 and TIS */
+	t->family = TPM20;
+	t->intf = TPM_TIS;
+
+	/* Check if the interface is CRB */
+	intf_id.val = tpm_read32(TPM_INTERFACE_ID_0);
+	if (intf_id.interface_type == TPM_CRB_INTF_ACTIVE)
+		t->intf = TPM_CRB;
+}
+
+struct tpm *enable_tpm(void)
+{
+	struct tpm *t = &tpm;
+
+	find_interface_and_family(t);
+
+	switch (t->intf) {
+	case TPM_TIS:
+		if (!tis_init(t))
+			return NULL;
+		break;
+	case TPM_CRB:
+		return NULL;
+	}
+
+	return t;
+}
+
+u8 tpm_request_locality(u8 l)
+{
+	return tis_request_locality(l);
+}
+
+int tpm_extend_pcr(struct tpm *t, u32 pcr, u16 algo,
+		u8 *digest)
+{
+	int ret = -EINVAL;
+
+	if (t->family == TPM12) {
+		struct tpm_digest d;
+
+		if (algo != TPM_ALG_SHA1)
+			return -EINVAL;
+
+		memcpy((void *)d.digest, digest, SHA1_DIGEST_SIZE);
+
+		ret = tpm1_pcr_extend(t, pcr, &d);
+	} else if (t->family == TPM20) {
+		struct tpm_digest *d;
+		u8 buf[MAX_TPM_EXTEND_SIZE];
+
+		d = (struct tpm_digest *) buf;
+		d->alg_id = algo;
+		switch (algo) {
+		case TPM_ALG_SHA1:
+			memcpy(d->digest, digest, SHA1_DIGEST_SIZE);
+			break;
+		case TPM_ALG_SHA256:
+			memcpy(d->digest, digest, SHA256_DIGEST_SIZE);
+			break;
+		case TPM_ALG_SHA512:
+			memcpy(d->digest, digest, SHA512_DIGEST_SIZE);
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		ret = tpm2_extend_pcr(t, pcr, d);
+	}
+
+	return ret;
+}
+
+void free_tpm(void)
+{
+	tis_relinquish_locality();
+}
diff --git a/arch/x86/boot/compressed/early_pcr_extend.h b/arch/x86/boot/compressed/early_pcr_extend.h
new file mode 100644
index 000000000000..bcd6d57d8c56
--- /dev/null
+++ b/arch/x86/boot/compressed/early_pcr_extend.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2020 Apertus Solutions, LLC
+ *
+ * Author(s):
+ *      Daniel P. Smith <dpsmith@apertussolutions.com>
+ *
+ */
+
+#ifndef BOOT_COMPRESSED_EARLY_PCR_EXTEND_H
+#define BOOT_COMPRESSED_EARLY_PCR_EXTEND_H
+
+#define TPM_MMIO_BASE		0xFED40000
+#define TPM_MAX_LOCALITY	4
+#define TPM_NO_LOCALITY		0xFF
+#define TPM_BURST_MIN_DELAY	100 /* 100us */
+#define TPM_ORD_PCR_EXTEND	20
+#define NULL_AUTH_SIZE		9
+#define MAX_TPM_EXTEND_SIZE	68 /* TPM2 SHA512 is the largest */
+
+#define TPM_INTERFACE_ID_0	0x30
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
+#define TPM_INTF_CAPABILITY_0	0x14
+#define TPM12_TIS_INTF_12	0x00
+#define TPM12_TIS_INTF_13	0x02
+#define TPM20_TIS_INTF_13	0x03
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
+enum tpm_hw_intf {
+	TPM_TIS,
+	TPM_CRB
+};
+
+enum tpm_family {
+	TPM12,
+	TPM20
+};
+
+struct tpm {
+	u32 vendor;
+	enum tpm_family family;
+	enum tpm_hw_intf intf;
+};
+
+extern struct tpm *enable_tpm(void);
+extern u8 tpm_request_locality(u8 l);
+extern int tpm_extend_pcr(struct tpm *t, u32 pcr, u16 algo,
+			  u8 *digest);
+extern void free_tpm(void);
+
+#endif
-- 
2.11.0

