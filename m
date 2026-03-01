Return-Path: <linux-integrity+bounces-8692-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPb/OV6do2k3IQUAu9opvQ
	(envelope-from <linux-integrity+bounces-8692-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 01 Mar 2026 02:58:54 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B56181CC797
	for <lists+linux-integrity@lfdr.de>; Sun, 01 Mar 2026 02:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C85C0306CE56
	for <lists+linux-integrity@lfdr.de>; Sun,  1 Mar 2026 01:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C012D308F07;
	Sun,  1 Mar 2026 01:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMSEbp5v"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8B3302779;
	Sun,  1 Mar 2026 01:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329931; cv=none; b=YmxHDmaOXdAmeI/0Cts+wczke5V9+xW7v1rw6h3SpdD71P/U6mwRqDgklKU3LTthWpnlCRczWurpjbdyFjlaNW11XKruO7IRuqjOhcMBDboZQICJ9I4oZtWwhdCw/6CZh84BVfArs+527NHk4QEKX2+2kB82apY1NshK/bi947o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329931; c=relaxed/simple;
	bh=Nw1EeV+g4V1IczrQgKHIeaJciH2dqCdwotGsG/MlDPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TZ8VWEUoATGV70JhICcLNqhZnAQyhPxBBTt+4Qvx3hePDwwFp/mMJUfzx7bAdk8WADDZ950bSt1vFNH4iPLwjO94IpBeVInHZYdwEWEGnsDUbppqNSsgOaRDFYcdiR48Q0M/ZMv8HGfOEalNIysfUawetf/N1hhtswCzuQL933w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMSEbp5v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B228C19421;
	Sun,  1 Mar 2026 01:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329931;
	bh=Nw1EeV+g4V1IczrQgKHIeaJciH2dqCdwotGsG/MlDPg=;
	h=From:To:Cc:Subject:Date:From;
	b=CMSEbp5vNJ+3fPOApzGcQAvZKskjGRJr0y0jDtLXZSroE58GTnXw1A0y7RrcHz+eS
	 cX+r/Mqm9MSceM0Tjcs24Im112usUQcqqkc16NVzJDMKj4ORxNyqL+jD2H57/Nf9Ti
	 5CRNFx9aKU4NC/KwviJilYhkYImuNeDcFVzuZaWoE4QgMzQ6A1rYCwG8mOZA0DKkqT
	 pE1CVkaPyDsDT3wrMgv2U7mToMS4YTkrXc8+Pb2vpKkD5n1eZ/qbcoQ4+Mc11snG7Q
	 3SpzYmHloN4get1TJPmIkZeGYBa+g8gMAEol3FExeIB9ZXeQN5Lefwq/WJ6i8765tI
	 5+WEV8rvoFCuw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	harshit.m.mogalapalli@oracle.com
Cc: Mimi Zohar <zohar@linux.ibm.com>,
	Alexander Graf <graf@amazon.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Borislav Betkov <bp@alien8.de>,
	guoweikang <guoweikang.kernel@gmail.com>,
	Henry Willard <henry.willard@oracle.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Bohac <jbohac@suse.cz>,
	Joel Granados <joel.granados@kernel.org>,
	Jonathan McDowell <noodles@fb.com>,
	Mike Rapoport <rppt@kernel.org>,
	Paul Webb <paul.x.webb@oracle.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Thomas Gleinxer <tglx@linutronix.de>,
	Yifei Liu <yifei.l.liu@oracle.com>,
	Baoquan He <bhe@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: FAILED: Patch "ima: verify the previous kernel's IMA buffer lies in addressable RAM" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:52:07 -0500
Message-ID: <20260301015208.1718603-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,amazon.com,kernel.org,alien8.de,gmail.com,oracle.com,zytor.com,redhat.com,suse.cz,fb.com,intel.com,linutronix.de,linux-foundation.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-8692-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B56181CC797
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 10d1c75ed4382a8e79874379caa2ead8952734f9 Mon Sep 17 00:00:00 2001
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Date: Tue, 30 Dec 2025 22:16:07 -0800
Subject: [PATCH] ima: verify the previous kernel's IMA buffer lies in
 addressable RAM

Patch series "Address page fault in ima_restore_measurement_list()", v3.

When the second-stage kernel is booted via kexec with a limiting command
line such as "mem=<size>" we observe a pafe fault that happens.

    BUG: unable to handle page fault for address: ffff97793ff47000
    RIP: ima_restore_measurement_list+0xdc/0x45a
    #PF: error_code(0x0000)  not-present page

This happens on x86_64 only, as this is already fixed in aarch64 in
commit: cbf9c4b9617b ("of: check previous kernel's ima-kexec-buffer
against memory bounds")


This patch (of 3):

When the second-stage kernel is booted with a limiting command line (e.g.
"mem=<size>"), the IMA measurement buffer handed over from the previous
kernel may fall outside the addressable RAM of the new kernel.  Accessing
such a buffer can fault during early restore.

Introduce a small generic helper, ima_validate_range(), which verifies
that a physical [start, end] range for the previous-kernel IMA buffer lies
within addressable memory:
	- On x86, use pfn_range_is_mapped().
	- On OF based architectures, use page_is_ram().

Link: https://lkml.kernel.org/r/20251231061609.907170-1-harshit.m.mogalapalli@oracle.com
Link: https://lkml.kernel.org/r/20251231061609.907170-2-harshit.m.mogalapalli@oracle.com
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Cc: Alexander Graf <graf@amazon.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Borislav Betkov <bp@alien8.de>
Cc: guoweikang <guoweikang.kernel@gmail.com>
Cc: Henry Willard <henry.willard@oracle.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Bohac <jbohac@suse.cz>
Cc: Joel Granados <joel.granados@kernel.org>
Cc: Jonathan McDowell <noodles@fb.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Paul Webb <paul.x.webb@oracle.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Thomas Gleinxer <tglx@linutronix.de>
Cc: Yifei Liu <yifei.l.liu@oracle.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/ima.h                |  1 +
 security/integrity/ima/ima_kexec.c | 35 ++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 8e29cb4e6a01d..abf8923f8fc51 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -69,6 +69,7 @@ static inline int ima_measure_critical_data(const char *event_label,
 #ifdef CONFIG_HAVE_IMA_KEXEC
 int __init ima_free_kexec_buffer(void);
 int __init ima_get_kexec_buffer(void **addr, size_t *size);
+int ima_validate_range(phys_addr_t phys, size_t size);
 #endif
 
 #ifdef CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 5beb69edd12fd..36a34c54de58b 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -12,6 +12,8 @@
 #include <linux/kexec.h>
 #include <linux/of.h>
 #include <linux/ima.h>
+#include <linux/mm.h>
+#include <linux/overflow.h>
 #include <linux/reboot.h>
 #include <asm/page.h>
 #include "ima.h"
@@ -294,3 +296,36 @@ void __init ima_load_kexec_buffer(void)
 		pr_debug("Error restoring the measurement list: %d\n", rc);
 	}
 }
+
+/*
+ * ima_validate_range - verify a physical buffer lies in addressable RAM
+ * @phys: physical start address of the buffer from previous kernel
+ * @size: size of the buffer
+ *
+ * On success return 0. On failure returns -EINVAL so callers can skip
+ * restoring.
+ */
+int ima_validate_range(phys_addr_t phys, size_t size)
+{
+	unsigned long start_pfn, end_pfn;
+	phys_addr_t end_phys;
+
+	if (check_add_overflow(phys, (phys_addr_t)size - 1, &end_phys))
+		return -EINVAL;
+
+	start_pfn = PHYS_PFN(phys);
+	end_pfn = PHYS_PFN(end_phys);
+
+#ifdef CONFIG_X86
+	if (!pfn_range_is_mapped(start_pfn, end_pfn))
+#else
+	if (!page_is_ram(start_pfn) || !page_is_ram(end_pfn))
+#endif
+	{
+		pr_warn("IMA: previous kernel measurement buffer %pa (size 0x%zx) lies outside available memory\n",
+			&phys, size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
-- 
2.51.0





