Return-Path: <linux-integrity+bounces-5397-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37418A6CFB4
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Mar 2025 15:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB75F3B624F
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Mar 2025 14:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969B7502B1;
	Sun, 23 Mar 2025 14:10:50 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D49813B29B
	for <linux-integrity@vger.kernel.org>; Sun, 23 Mar 2025 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742739050; cv=none; b=rDW2ckMUy0sqw09hxYdOr2xTZz4/lFaZs6kufOW4GQIB5R5mK88KrKfJleqCz83queW6lCK3tT5EhNfwI9uItumRHlYQYCqqz962+A+eWBrc1UODQiFWiy2lCa33UmSOO8KPA/6PNOkr836QDwBwnKdthNNZtMXaIjywwDa/tXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742739050; c=relaxed/simple;
	bh=0Nt9HZ9wCJFanHsxL0NL0Mf8URg62LPUrJzWZX4vW9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZtZ1iB9AR7Kmv+DCOVCjB6g2X7Vja2uARSkNwM1oDHWwpyfd0ynGZvOOX+ufnspy23RA3Ie08bbMtqqa5Psp4dmj5WwW9WfAoCqA8qUFh+hBp/sFwbi47ID+e8Kw0H0/OTv0pdHPcEeSgNM26adc2PvUvX7c0DZrrWsYtTIYuaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 28376211BA;
	Sun, 23 Mar 2025 14:10:38 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 153951339F;
	Sun, 23 Mar 2025 14:10:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id USQKBF4W4GfOPAAAD6G6ig
	(envelope-from <nstange@suse.de>); Sun, 23 Mar 2025 14:10:38 +0000
From: Nicolai Stange <nstange@suse.de>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolai Stange <nstange@suse.de>
Subject: [RFC PATCH v2 13/13] ima: don't re-invalidate unsupported PCR banks after kexec
Date: Sun, 23 Mar 2025 15:09:11 +0100
Message-ID: <20250323140911.226137-14-nstange@suse.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250323140911.226137-1-nstange@suse.de>
References: <20250323140911.226137-1-nstange@suse.de>
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
X-Rspamd-Queue-Id: 28376211BA
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

Currently, IMA would invalidate a PCR bank corresponding to an unsupported
hash algorithm by extending it with 0xfe ... fe exactly once.

The idea is, that banks corresponding to such algorithms would be readily
recognizable by comparing against HASH(0x00 ... 00 | fe ... fe), i.e. the
value they'd have if extended once when in their initial state after
reset.

However, PCRs don't get reset at kexec, yet each kernel in a kexec chain
would do the (re-)invalidation again. That means that a PCR's bank would
have a value of e.g. HASH(HASH(0x00 ... 00 | fe ... fe) | fe ... fe)
after a re-invalidation from the second kernel in the chain and so on.
In this scenario, it's not anymore immediate from the PCR bank value
alone whether an invalidation has happened or not.

Don't re-invalidate banks found to have a value of
HASH(0x00 ... 00 | fe ... fe) again after kexec.

Note that the assumption implicit to the example above was that all
kernels in a kexec chain wouldn't have support for a given hash algorithm.
However, as it's pointless to start extending some already invalidated
bank somewhere in the middle of a kexec chain, an even more general
approach is possible: don't /extend/ banks found to have a value of
HASH(0x00 ... 00 | fe ... fe) ever again after kexec.

With that, any bank corresponding to a hash algorithm not supported by the
initial kernel in a kexec chain will retain its
HASH(0x00 ... 00 | fe ... fe) value, independent of whether subsequent
kernels do or do not support the algorithm in question (assuming all
kernels in the chain implement this logic, of course).

If some bank's hash algorithm is initially supported by one or more
kernels at the head of the kexec chain, but ceases to do so at a certain
later point, it necessarily must get invalidated then. As the PCR bank
cannot get moved to the magic of HASH(0x00 ... 00 | fe ... fe) by design
of how PCRs work anyway, it doesn't matter how many times it's getting
invalidated, as long as it's being done at least once. For practicality
reasons, the choice has been made to re-invalidate such "discontinued"
banks for every new measurement list entry over and over again.
(Otherwise, if those banks were e.g. to get invalidated exactly once from
 each kernel not supporting their hashes, the information to get tracked
 per PCR would become a tristate: never extended before, extended by a
 previous kernel or extended by the current one already -- the sets of
 banks to invalidate upon measurement list entry addition would
 potentially all be different for each case.)

So in summary:
- don't touch banks not supported by the initial kernel ever again and
  keep them at their magic HASH(0x00 ... 00 | fe ... fe) values,
- (re-)invalidate any additional bank not supported by the current kernel
  over and over again for each new measurement list entry added.

Regarding the implementation:
- Make ima_restore_measurement_list() to determine the set of banks in
  magic HASH(0x00 ... 00 | fe ... fe) state for each PCR referenced from
  any entry in the preexisting measurement list after kexec. This is being
  done by reading back via the ima_pcr_invalidated_banks() helper
  introduced with a previous patch. The result of this step is the set
  of banks found invalidated for all the PCRs referenced, kept in the
  local always_invalidated_pcrs_banks_mask bitmask.

  While walking the measurement list, make
  ima_restore_measurement_list() to also update the already existing
  global ima_extended_pcrs_mask to record every PCR seen.

- After walking through the measurement list,
  always_invalidated_pcrs_banks_mask represents the set of banks whose
  associated hash algorithms had not been supported by the first kernel
  in the kexec chain and thus, not been updated by any subsequent kernel
  between the first and the current one accordingly.

  At that point, ima_unsupported_pcr_banks_mask corresponds to the set of
  banks whose associated hash algorithms aren't supported by the current
  kernel, as per the initialization in ima_init_crypto().

  The set difference between the two, i.e.
    ima_unsupported_pcr_banks_mask & ~always_invalidated_pcrs_banks_mask
  represents the set of "discontinued" banks, i.e. banks that had been
  supported and extended before, but which the current kernel cannot
  maintain any further. As explained above, this set of banks will be
  subject to re-invalidation upon each new measurement list entry
  addition. Store it away in new global ima_discontinued_pcr_banks_mask.

- After ima_unsupported_pcr_banks_mask has been computed, update
  ima_unsupported_pcr_banks_mask to the union of itself (the algorithms
  not supported by the current kernel) with the set of algorithms found to
  not have been supported by the first kernel in the kexec chain, as
  represented by the always_invalidated_pcrs_banks_mask from above.

  At this point, the set banks to not extend any further (for any PCR
  already encountered before) is
    ima_unsupported_pcr_banks_mask & ~ima_discontinued_pcr_banks_mask.

  For clarification: for the first kernel in a kexec chain
  ima_discontinued_pcr_banks_mask is zero and the result of the
  expression above is ima_unsupported_pcr_banks_mask. For a subsequent
  kernel however, this effectively evaluates to the
  always_invalidated_pcrs_banks_mask found above, which should in turn
  likewise match the set of algorithms not supported by the initial
  kernel.

  Either way, make ima_pcr_extend() to skip over banks in the set
  represented by the above expression, instead of over the plain
  ima_unsupported_pcr_banks_mask as before.

- The last missing piece is to handle PCRs never encountered before
  correctly. When subsequently extended for the first time, these must
  get all their banks in ima_unsupported_pcr_banks_mask invalidated,
  hence extended with 0xfe ... fe. IMA's template hash computation
  primitives (more specifically ima_calc_field_array_hash() and
  ima_init_digests()) would substitute 0xfe ... fe for a bank iff the
  associated ima_algo_array[]'s entry's ->tfm is NULL.

  Make ima_restore_measurement_list() to reset any ->tfm potentially
  non-NULL but in ima_unsupported_pcr_banks_mask. That is, make it reset
  ->tfm's for which the current kernel does have an implementation
  available, but the first kernel in the kexec chain did not.

  As a welcomed side-effect this will also suppress the creation of the
  {binary,ascii}_runtime_measurements_<hash> sysfs files for any bank
  never maintained throughout the kexec chain.

- Lastly, while iterating over the banks and resetting ->tfm's as
  appropriate, log some useful information:
  - inform about banks found unsupported throughout the kexec chain, i.e.
    in magic HASH(0x00 ... 00 | fe ... fe) state,
  - print an error if the bank associated with ima_hash is among those
  - and warn about discontinued banks.

  With that, any unsupported bank will leave a trace at least once in a
  kernel log somewhere in the kexec chain (assuming all the kernels
  are implementing this logic, of course).

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 security/integrity/ima/ima.h          |  1 +
 security/integrity/ima/ima_crypto.c   |  6 ++
 security/integrity/ima/ima_queue.c    |  9 ++-
 security/integrity/ima/ima_template.c | 84 ++++++++++++++++++++++++++-
 4 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 9bfe045ac9d5..2b5351cbf6bd 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -63,6 +63,7 @@ extern int ima_hash_algo_idx __ro_after_init;
 extern int ima_extra_slots __ro_after_init;
 extern struct ima_algo_desc *ima_algo_array __ro_after_init;
 extern unsigned long ima_unsupported_pcr_banks_mask __ro_after_init;
+extern unsigned long ima_discontinued_pcr_banks_mask __ro_after_init;
 
 extern unsigned long ima_extended_pcrs_mask;
 
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 716bb302e75d..58829c98a69b 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -69,6 +69,12 @@ struct ima_algo_desc *ima_algo_array __ro_after_init;
 
 unsigned long ima_unsupported_pcr_banks_mask __ro_after_init;
 
+/*
+ * Subset of unsupported banks that had (possibly) been supported and
+ * maintained by some previous kernel in a kexec chain.
+ */
+unsigned long ima_discontinued_pcr_banks_mask __ro_after_init;
+
 static int __init ima_init_ima_crypto(void)
 {
 	long rc;
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 83d5c7034919..4aa94584957e 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -156,7 +156,14 @@ static int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr)
 		return 0;
 
 #if !IS_ENABLED(CONFIG_IMA_COMPAT_FALLBACK_TPM_EXTEND)
-	pcr_banks_skip_mask = ima_unsupported_pcr_banks_mask;
+	/*
+	 * Don't invalidate unsupported PCR banks more than once in
+	 * general, with the exception of discontinued banks possibly
+	 * maintained by a previous kernel in a kexec chain and now in
+	 * indeterminate state.
+	 */
+	pcr_banks_skip_mask = ima_unsupported_pcr_banks_mask &
+		~ima_discontinued_pcr_banks_mask;
 	if (!(ima_extended_pcrs_mask & BIT(pcr))) {
 		/*
 		 * Invalidate unsupported banks once upon a PCR's
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 04c49f05cb74..4584cfc416f4 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -428,7 +428,9 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 	struct ima_template_desc *template_desc;
 	DECLARE_BITMAP(hdr_mask, HDR__LAST);
 	unsigned long count = 0;
-	int ret = 0;
+	unsigned long always_invalidated_pcrs_banks_mask = ~0UL;
+	unsigned long ever_invalidated_pcrs_banks_mask = 0;
+	int i, ret = 0;
 
 	if (!buf || size < sizeof(*khdr))
 		return 0;
@@ -527,10 +529,90 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 
 		entry->pcr = !ima_canonical_fmt ? *(u32 *)(hdr[HDR_PCR].data) :
 			     le32_to_cpu(*(__le32 *)(hdr[HDR_PCR].data));
+		if (IMA_INVALID_PCR(entry->pcr)) {
+			pr_err("invalid measurement PCR index");
+			ret = -EINVAL;
+			break;
+		}
+
 		ret = ima_restore_measurement_entry(entry);
 		if (ret < 0)
 			break;
 
+#if !IS_ENABLED(CONFIG_IMA_COMPAT_FALLBACK_TPM_EXTEND)
+		if (ima_tpm_chip &&
+		    !(ima_extended_pcrs_mask & BIT(entry->pcr))) {
+			unsigned long invalidated_pcr_banks_mask;
+
+			invalidated_pcr_banks_mask =
+				ima_pcr_invalidated_banks(entry->pcr);
+			always_invalidated_pcrs_banks_mask &=
+				invalidated_pcr_banks_mask;
+			ever_invalidated_pcrs_banks_mask |=
+				invalidated_pcr_banks_mask;
+		}
+		ima_extended_pcrs_mask |= BIT(entry->pcr);
+#endif
 	}
+
+	always_invalidated_pcrs_banks_mask &= ever_invalidated_pcrs_banks_mask;
+	/*
+	 * Banks that had (possibly) been maintained by a previous
+	 * kernel in the kexec chain, but aren't anymore now, are
+	 * considered "discontinued" and in indeterminate
+	 * state. Re-invalidate unconditionally at each PCR extend.
+	 */
+	if (ima_extended_pcrs_mask != 0) {
+		ima_discontinued_pcr_banks_mask = ima_unsupported_pcr_banks_mask
+			& ~always_invalidated_pcrs_banks_mask;
+	}
+
+	/*
+	 * Banks consistently found invalidated for having been
+	 * unsupported before, are kept in the "unsupported" state and
+	 * never re-invalidated again, so that they retain their
+	 * easily recognizable, well-known digest value.
+	 */
+	ima_unsupported_pcr_banks_mask |= always_invalidated_pcrs_banks_mask;
+
+	for (i = 0; i < NR_BANKS(ima_tpm_chip); ++i) {
+		if (i >= BITS_PER_LONG)
+			break;
+
+		/*
+		 * Don't clutter the logs with unrecognized algos,
+		 * these would always get reported as "discontinued"
+		 * otherwise.
+		 */
+		if (ima_algo_array[i].algo == HASH_ALGO__LAST)
+			continue;
+
+		if (ima_discontinued_pcr_banks_mask & BIT(i)) {
+			pr_warn("Discontinuing unsupported TPM %s PCR bank\n",
+				hash_algo_name[ima_algo_array[i].algo]);
+		} else if (i == ima_hash_algo_idx &&
+			   ever_invalidated_pcrs_banks_mask & BIT(i)) {
+			pr_err("Continuing on stale ima_hash TPM PCR bank\n");
+
+			/* Force back to supported. */
+			ima_unsupported_pcr_banks_mask &= ~BIT(i);
+		} else if (always_invalidated_pcrs_banks_mask & BIT(i)) {
+			struct crypto_shash *tfm;
+
+			pr_info("Masking previously unsupported TPM %s PCR bank\n",
+				hash_algo_name[ima_algo_array[i].algo]);
+
+			/*
+			 * Remove the ->tfm so that any not yet
+			 * extended PCRs will get their corresponding
+			 * bank invalidated as well upon first use.
+			 */
+			tfm = ima_algo_array[i].tfm;
+			ima_algo_array[i].tfm = NULL;
+			if (tfm)
+				ima_free_tfm(tfm);
+		}
+	}
+
 	return ret;
 }
-- 
2.49.0


