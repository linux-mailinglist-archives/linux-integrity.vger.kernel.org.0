Return-Path: <linux-integrity+bounces-5394-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47823A6CFA8
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Mar 2025 15:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2A1E16F833
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Mar 2025 14:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBE71624C1;
	Sun, 23 Mar 2025 14:10:33 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C360F14375C
	for <linux-integrity@vger.kernel.org>; Sun, 23 Mar 2025 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742739033; cv=none; b=OgtcbpwPWOo8CWu+55QnxaOKRg6vFRqF6jpVC9VRCzwZzURO58O5KXEE+TmvDZYz9Ms3qSpxpLogc4Ce5v1s//QymYjchmfk1WcN0dEb+h3mzALfMQp3Tj9QQ3B7TGLEnpX8pTtN8KacuOVPgSaRv6l94Bktd/WkIYjygyo4aGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742739033; c=relaxed/simple;
	bh=mE1eC9HPwNvEBAaoGkNzNse2enTafjWo2svKTu4Z+SM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VshMek78i6YuQ8iT9Jxt7hms8gT9I9CHgtY5IEzc1AwC4cleeLsuglEgaHEO9x141Be77hpoJ/8+S6HHHu+2m1XM4UK1JqWzOXqHlTOaP5IaDo3tJsFxlSed7padOGHh82jDgGBqr+ubF+e/q97ge/lqQeFHMFiTN5gv23ramvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DA31E1F455;
	Sun, 23 Mar 2025 14:10:23 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8ACC1339F;
	Sun, 23 Mar 2025 14:10:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uhnFL08W4GeyPAAAD6G6ig
	(envelope-from <nstange@suse.de>); Sun, 23 Mar 2025 14:10:23 +0000
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
Subject: [RFC PATCH v2 10/13] tpm: authenticate tpm2_pcr_read()
Date: Sun, 23 Mar 2025 15:09:08 +0100
Message-ID: <20250323140911.226137-11-nstange@suse.de>
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
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: DA31E1F455
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

PCR reads aren't currently authenticated even with CONFIG_TCG_TPM2_HMAC=y
yet.

It is probably desirable though, as e.g. IMA does some PCR reads to form
the cumulative boot digest subsequently extended into PCR 10 (an operation
which *is* authenticated).

Furthermore, a subsequent patch will make IMA to skip certain PCR bank
re-invalidations (which are implemented with extensions) upon kexec based
on the value read back at boot. In order to not weaken the overall
security posture in this case, it will be required to establish the same
level of trust into PCR reads as there is already for the extensions.

Make tpm2_pcr_read() to protect the command with a HMAC auth session,
using the already existing infrastructure.

As the TPM2_PCR_Read command doesn't have any authorizations defined, and
neither of TPM2_SA_ENCRYPT/TPM2_SA_DECRYPT is needed, use TPM2_SA_AUDIT,
even though no auditing functionality is actually being required. Since
the TPM will set TPM2_SA_AUDIT_EXCLUSIVE in its response with this
single-use session, set it upfront so that tpm_buf_check_hmac_response()
would expect it for the HMAC verification.

Now that tpm2_pcr_read() depends on the driver's session infrastructure,
note that the first call to tpm2_pcr_read() at init time gets issued from
  tpm_chip_bootstrap() -> tpm_get_pcr_allocation()
  -> tpm2_get_pcr_allocation() -> tpm2_init_bank_info()
  -> tpm2_pcr_read()
after
  tpm_chip_bootstrap() -> tpm_auto_startup() -> tpm2_auto_startup()
  -> tpm2_sessions_init(),
so there won't be any issues with that.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 drivers/char/tpm/tpm2-cmd.c | 46 +++++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 23ded8ea47dc..e16772bbc5c8 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -168,6 +168,8 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 	int i;
 	int rc;
 	struct tpm_buf buf;
+	struct tpm_header *head;
+	int offset_p;
 	struct tpm2_pcr_read_out *out;
 	u8 pcr_select[TPM2_PCR_SELECT_MIN] = {0};
 	u16 digest_size;
@@ -187,9 +189,30 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 		expected_digest_size = chip->allocated_banks[i].digest_size;
 	}
 
-	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_PCR_READ);
-	if (rc)
-		return rc;
+	if (IS_ENABLED(CONFIG_TCG_TPM2_HMAC) && !disable_pcr_integrity) {
+		rc = tpm2_start_auth_session(chip);
+		if (rc)
+			return rc;
+
+		rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_READ);
+		if (rc) {
+			tpm2_end_auth_session(chip);
+			return rc;
+		}
+
+		/*
+		 * Exclusivity is not needed, but set in the response.
+		 * Set it here too, so that the HMAC verification
+		 * won't fail.
+		 */
+		tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_AUDIT
+					    | TPM2_SA_AUDIT_EXCLUSIVE,
+					    NULL, 0);
+	} else {
+		rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_PCR_READ);
+		if (rc)
+			return rc;
+	}
 
 	pcr_select[pcr_idx >> 3] = 1 << (pcr_idx & 0x7);
 
@@ -199,11 +222,24 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 	tpm_buf_append(&buf, (const unsigned char *)pcr_select,
 		       sizeof(pcr_select));
 
+	if (!disable_pcr_integrity)
+		tpm_buf_fill_hmac_session(chip, &buf);
 	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to read a pcr value");
 	if (rc)
 		goto out;
+	if (!disable_pcr_integrity) {
+		rc = tpm_buf_check_hmac_response(chip, &buf, rc);
+		if (rc)
+			goto out;
+	}
+
+	head = (struct tpm_header *)buf.data;
+	offset_p = TPM_HEADER_SIZE;
+	/* Skip the parameter size field: */
+	if (be16_to_cpu(head->tag) == TPM2_ST_SESSIONS)
+		offset_p += 4;
+	out = (struct tpm2_pcr_read_out *)&buf.data[offset_p];
 
-	out = (struct tpm2_pcr_read_out *)&buf.data[TPM_HEADER_SIZE];
 	digest_size = be16_to_cpu(out->digest_size);
 	if (digest_size > sizeof(digest->digest) ||
 	    (!digest_size_ptr && digest_size != expected_digest_size)) {
@@ -216,6 +252,8 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 
 	memcpy(digest->digest, out->digest, digest_size);
 out:
+	if (!disable_pcr_integrity)
+		tpm2_end_auth_session(chip);
 	tpm_buf_destroy(&buf);
 	return rc;
 }
-- 
2.49.0


