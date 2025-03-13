Return-Path: <linux-integrity+bounces-5276-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCA6A5FDED
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Mar 2025 18:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DFA67ADB45
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Mar 2025 17:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D531EB193;
	Thu, 13 Mar 2025 17:35:13 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54DF1E9907
	for <linux-integrity@vger.kernel.org>; Thu, 13 Mar 2025 17:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741887313; cv=none; b=GFPYcbuL6DLPrZRvYXaiyDgICjphixNk0zrifyP2n3qdcXUT8HHk61kFlZue1v+R52uuC27F8Ew8YR9Vg2sSRKL1PN3sq2gVNzmubAg7BG6Xh1dr0xPnisJFlarSTw/C/dn+ZugAyncTaZXtOzHMo33MbCN1cAfyrot5CruWSvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741887313; c=relaxed/simple;
	bh=uVVTskfCompucQ0Jmp6zLdiPS5sGlOV63hkAik5gLE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMtoQD2e88g8RYlp/7YitVljBue7oLHQNcCeWqUr2IqOPSkDV/Gw6hTscowtEdRV75c0DU85rDHoaAqUBmo6fQDk7Z2TFjqr5RwWbrHBpgLN+/tHtyMXjBohKUBcZRymlyqRaji4P7N1uPE2XeN4SkqS/167fkV9EAJf7BBVRGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 56A0C21175;
	Thu, 13 Mar 2025 17:35:10 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 466BE137BA;
	Thu, 13 Mar 2025 17:35:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RaTvD04X02cdQwAAD6G6ig
	(envelope-from <nstange@suse.de>); Thu, 13 Mar 2025 17:35:10 +0000
From: Nicolai Stange <nstange@suse.de>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolai Stange <nstange@suse.de>
Subject: [RFC PATCH v1 4/7] ima: track the set of PCRs ever extended
Date: Thu, 13 Mar 2025 18:33:36 +0100
Message-ID: <20250313173339.3815589-5-nstange@suse.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250313173339.3815589-1-nstange@suse.de>
References: <20250313173339.3815589-1-nstange@suse.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 56A0C21175
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

A subsequent patch will make IMA to invalidate PCR banks associated with
unsupported hash algorithms once at a PCR's first use. To prepare for
that, make it track the set of PCRs ever extended.

Maintain the set of touched PCRs in an unsigned long bitmask,
'ima_extended_pcrs_mask'.

Amend the IMA_INVALID_PCR() #define to check that a given PCR can get
represented in that bitmask. Note that this is only for improving code
maintainablity, it does not actually constain the set of allowed PCR
indices any further.

Make ima_pcr_extend() to maintain the ima_extended_pcrs_mask, i.e.
to set the currently extented PCR's corresponding bit.

Make ima_restore_measurement_list() to restore the ima_extended_pcrs_mask
from the measurement list in order to maintain it across kexecs.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 security/integrity/ima/ima.h          | 8 ++++++--
 security/integrity/ima/ima_queue.c    | 6 ++++++
 security/integrity/ima/ima_template.c | 7 +++++++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 1158a7b8bf6b..f99b1f81b35c 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -20,6 +20,7 @@
 #include <linux/hash.h>
 #include <linux/tpm.h>
 #include <linux/audit.h>
+#include <linux/minmax.h>
 #include <crypto/hash_info.h>
 
 #include "../integrity.h"
@@ -62,6 +63,8 @@ extern int ima_hash_algo_idx __ro_after_init;
 extern int ima_extra_slots __ro_after_init;
 extern struct ima_algo_desc *ima_algo_array __ro_after_init;
 
+extern unsigned long ima_extended_pcrs_mask;
+
 extern int ima_appraise;
 extern struct tpm_chip *ima_tpm_chip;
 extern const char boot_aggregate_name[];
@@ -198,8 +201,9 @@ struct ima_iint_cache {
 	struct ima_digest_data *ima_hash;
 };
 
-#define IMA_INVALID_PCR(a) (((a) < 0) || \
-	(a) >= (sizeof_field(struct ima_iint_cache, measured_pcrs) * 8))
+#define IMA_INVALID_PCR(a) (((a) < 0) ||				    \
+	(a) >= (8 * min(sizeof_field(struct ima_iint_cache, measured_pcrs), \
+			sizeof(ima_extended_pcrs_mask))))
 
 
 extern struct lsm_blob_sizes ima_blob_sizes;
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 83d53824aa98..f00ba2222c34 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -51,6 +51,11 @@ static DEFINE_MUTEX(ima_extend_list_mutex);
  */
 static bool ima_measurements_suspended;
 
+/*
+ * Set of PCRs ever extended by IMA.
+ */
+unsigned long ima_extended_pcrs_mask;
+
 /* lookup up the digest value in the hash table, and return the entry */
 static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
 						       int pcr)
@@ -152,6 +157,7 @@ static int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr)
 	result = tpm_pcr_extend(ima_tpm_chip, pcr, digests_arg);
 	if (result != 0)
 		pr_err("Error Communicating to TPM chip, result: %d\n", result);
+	ima_extended_pcrs_mask |= BIT(pcr);
 	return result;
 }
 
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 04c49f05cb74..55d335097d85 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -525,12 +525,19 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 			}
 		}
 
+		if (IMA_INVALID_PCR(entry->pcr)) {
+			pr_err("invalid measurement PCR index");
+			ret = -EINVAL;
+			break;
+		}
+
 		entry->pcr = !ima_canonical_fmt ? *(u32 *)(hdr[HDR_PCR].data) :
 			     le32_to_cpu(*(__le32 *)(hdr[HDR_PCR].data));
 		ret = ima_restore_measurement_entry(entry);
 		if (ret < 0)
 			break;
 
+		ima_extended_pcrs_mask |= BIT(entry->pcr);
 	}
 	return ret;
 }
-- 
2.47.1


