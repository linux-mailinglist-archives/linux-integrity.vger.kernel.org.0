Return-Path: <linux-integrity+bounces-8311-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLS5DJdudmneQgEAu9opvQ
	(envelope-from <linux-integrity+bounces-8311-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Jan 2026 20:27:19 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BED821AA
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Jan 2026 20:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D770930075D2
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Jan 2026 19:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFF22F3608;
	Sun, 25 Jan 2026 19:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0/bjpmz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618392F12A5;
	Sun, 25 Jan 2026 19:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769369153; cv=none; b=Vqsl+vjQpR0N3SroPRN+xDebMlSKYKI25ZXFjnmhXGnE7Bwxr7bsYbcXvyRlkb5H6dtlUG3tZxd7DRjsmG5YCvnSGSo8Vk85t1yFY75BoOFNFNfiyqEc7Wn8XfHFmjZBLEbQSRBhZj/vzqxCRgv/VMxdPsHGfxhqpCwUPz/SPiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769369153; c=relaxed/simple;
	bh=A7Dkc+DU3z769vOotl5kpmSQoLZD3NfnQOUU5DEX3k8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UiDv08tV7s63EcNFnTme5kIhl8Eplr9wk307LQ8r47lvySFV6MSrdfVo5hgsQpdNuBB0RenjcC17fxbap5x01FtyPPUC2YuPULxivPNim4iDIn2+AB5EJe0cPjgw3x48FpBt1o9+PuUdoKO9KJS2+yKui5+MpLiKcg994W0wlBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0/bjpmz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80439C4CEF1;
	Sun, 25 Jan 2026 19:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769369153;
	bh=A7Dkc+DU3z769vOotl5kpmSQoLZD3NfnQOUU5DEX3k8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U0/bjpmzDIq0I7qnOfhxWPqVL1cJ7u5GB7xmF+NGeK6WMygBiaonoRMwPPOxbX+AT
	 ujz5TbpsM8UQn6JseNZcBC4C1Ly3WdG9OwzK9HLAanU/VlUOzulML52fJZ1ts7ct6R
	 sJ+1TOoN/YTfE03OKG0UTRQWMJiM7eKAB28zTUxUF2T1r4Kb4kX1l9MzCX0oMLfJCq
	 0WJT+vhu4H+qxkuRHoTl7zFl0p0UERQGNvb0iuy3wFSvSAr0ldIsvOEHFRyvB2D1j5
	 dtMqLRIxPoBZ675HWYbPAZ7+lUifNHeSV0K2wP+44JQTSx5x90IVPoVMW4AxA+R+RC
	 C1TyeMZwE6FIw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Biggers <ebiggers@kernel.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org (open list:KEYS-TRUSTED),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 03/11] tpm: Change tpm_get_random() opportunistic
Date: Sun, 25 Jan 2026 21:25:13 +0200
Message-ID: <20260125192526.782202-4-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260125192526.782202-1-jarkko@kernel.org>
References: <20260125192526.782202-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8311-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 71BED821AA
X-Rspamd-Action: no action

hwrng framework does not have a requirement that the all bytes requested
need to be provided. By enforcing such a requirement internally, TPM driver
can cause unpredictability in latency, as a single tpm_get_random() call
can result multiple TPM commands.

Especially, when TCG_TPM2_HMAC is enabled, extra roundtrips could have
significant effect to the system latency.

Thus, send TPM command only once and return bytes received instead of
committing to the number of requested bytes.

Cc: David S. Miller <davem@davemloft.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v9:
- Merge orchestration.
v7:
- Given that hwrng is now only caller for tpm_get_random(), remove the
  wait parameter.
v4:
- Fixed grammar mistakes.
---
 drivers/char/tpm/tpm-interface.c |  20 ++++--
 drivers/char/tpm/tpm1-cmd.c      |  66 ++++++++----------
 drivers/char/tpm/tpm2-cmd.c      | 115 +++++++++++++------------------
 3 files changed, 88 insertions(+), 113 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index f745a098908b..d44bd8c44612 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -487,18 +487,24 @@ int tpm_pm_resume(struct device *dev)
 EXPORT_SYMBOL_GPL(tpm_pm_resume);
 
 /**
- * tpm_get_random() - get random bytes from the TPM's RNG
- * @chip:	a &struct tpm_chip instance, %NULL for the default chip
- * @out:	destination buffer for the random bytes
- * @max:	the max number of bytes to write to @out
+ * tpm_get_random() - Get random bytes from the TPM's RNG
+ * @chip:	A &tpm_chip instance. When set to %NULL, the default chip is used.
+ * @out:	Destination buffer for the acquired random bytes.
+ * @max:	The maximum number of bytes to write to @out.
+ *
+ * Tries to pull bytes from the TPM. At most, @max bytes are returned.
  *
- * Return: number of random bytes read or a negative error value.
+ * Returns the number of random bytes read on success.
+ * Returns -EINVAL when @out is NULL, or @max is not between zero and
+ * %TPM_MAX_RNG_DATA.
+ * Returns tpm_transmit_cmd() error codes when the TPM command results an
+ * error.
  */
 int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
 {
 	int rc;
 
-	if (!out || max > TPM_MAX_RNG_DATA)
+	if (!out || !max || max > TPM_MAX_RNG_DATA)
 		return -EINVAL;
 
 	if (!chip)
@@ -514,7 +520,7 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
 		rc = tpm1_get_random(chip, out, max);
 
 	tpm_put_ops(chip);
-	return rc;
+	return rc != 0 ? rc : -EIO;
 }
 EXPORT_SYMBOL_GPL(tpm_get_random);
 
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index b49a790f1bd5..3fe94f596f97 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -518,63 +518,51 @@ struct tpm1_get_random_out {
 } __packed;
 
 /**
- * tpm1_get_random() - get random bytes from the TPM's RNG
- * @chip:	a &struct tpm_chip instance
- * @dest:	destination buffer for the random bytes
- * @max:	the maximum number of bytes to write to @dest
+ * tpm1_get_random() - Get random bytes from the TPM's RNG
  *
- * Return:
- * *  number of bytes read
- * * -errno (positive TPM return codes are masked to -EIO)
+ * This is an internal function for tpm_get_random(). See its documentation
+ * for more information.
  */
 int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 {
-	struct tpm1_get_random_out *out;
-	u32 num_bytes =  min_t(u32, max, TPM_MAX_RNG_DATA);
+	struct tpm1_get_random_out *resp;
 	struct tpm_buf buf;
-	u32 total = 0;
-	int retries = 5;
 	u32 recd;
 	int rc;
 
+	if (!dest || !max || max > TPM_MAX_RNG_DATA)
+		return -EINVAL;
+
 	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_GET_RANDOM);
 	if (rc)
 		return rc;
 
-	do {
-		tpm_buf_append_u32(&buf, num_bytes);
-
-		rc = tpm_transmit_cmd(chip, &buf, sizeof(out->rng_data_len),
-				      "attempting get random");
-		if (rc) {
-			if (rc > 0)
-				rc = -EIO;
-			goto out;
-		}
+	tpm_buf_append_u32(&buf, max);
 
-		out = (struct tpm1_get_random_out *)&buf.data[TPM_HEADER_SIZE];
+	rc = tpm_transmit_cmd(chip, &buf, sizeof(resp->rng_data_len), "TPM_GetRandom");
+	if (rc) {
+		if (rc > 0)
+			rc = -EIO;
+		goto out;
+	}
 
-		recd = be32_to_cpu(out->rng_data_len);
-		if (recd > num_bytes) {
-			rc = -EFAULT;
-			goto out;
-		}
+	resp = (struct tpm1_get_random_out *)&buf.data[TPM_HEADER_SIZE];
 
-		if (tpm_buf_length(&buf) < TPM_HEADER_SIZE +
-					   sizeof(out->rng_data_len) + recd) {
-			rc = -EFAULT;
-			goto out;
-		}
-		memcpy(dest, out->rng_data, recd);
+	recd = be32_to_cpu(resp->rng_data_len);
+	if (recd > max) {
+		rc = -EIO;
+		goto out;
+	}
 
-		dest += recd;
-		total += recd;
-		num_bytes -= recd;
+	if (buf.length < TPM_HEADER_SIZE + sizeof(resp->rng_data_len) + recd) {
+		rc = -EIO;
+		goto out;
+	}
 
-		tpm_buf_reset(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_GET_RANDOM);
-	} while (retries-- && total < max);
+	memcpy(dest, resp->rng_data, recd);
+	tpm_buf_destroy(&buf);
+	return recd;
 
-	rc = total ? (int)total : -EIO;
 out:
 	tpm_buf_destroy(&buf);
 	return rc;
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 3a77be7ebf4a..5f15d8a93e23 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -244,98 +244,79 @@ struct tpm2_get_random_out {
 } __packed;
 
 /**
- * tpm2_get_random() - get random bytes from the TPM RNG
+ * tpm2_get_random() - Get random bytes from the TPM's RNG
  *
- * @chip:	a &tpm_chip instance
- * @dest:	destination buffer
- * @max:	the max number of random bytes to pull
- *
- * Return:
- *   size of the buffer on success,
- *   -errno otherwise (positive TPM return codes are masked to -EIO)
+ * This is an internal function for tpm_get_random(). See its documentation
+ * for more information.
  */
 int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 {
-	struct tpm2_get_random_out *out;
+	struct tpm2_get_random_out *resp;
 	struct tpm_header *head;
 	struct tpm_buf buf;
+	off_t offset;
 	u32 recd;
-	u32 num_bytes = max;
 	int err;
-	int total = 0;
-	int retries = 5;
-	u8 *dest_ptr = dest;
-	off_t offset;
 
-	if (!num_bytes || max > TPM_MAX_RNG_DATA)
+	if (!dest || !max || max > TPM_MAX_RNG_DATA)
 		return -EINVAL;
 
 	err = tpm2_start_auth_session(chip);
 	if (err)
 		return err;
 
-	err = tpm_buf_init(&buf, 0, 0);
+	err = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_GET_RANDOM);
 	if (err) {
 		tpm2_end_auth_session(chip);
 		return err;
 	}
 
-	do {
-		tpm_buf_reset(&buf, TPM2_ST_SESSIONS, TPM2_CC_GET_RANDOM);
-		if (tpm2_chip_auth(chip)) {
-			tpm_buf_append_hmac_session(chip, &buf,
-						    TPM2_SA_ENCRYPT |
-						    TPM2_SA_CONTINUE_SESSION,
-						    NULL, 0);
-		} else  {
-			offset = buf.handles * 4 + TPM_HEADER_SIZE;
-			head = (struct tpm_header *)buf.data;
-			if (tpm_buf_length(&buf) == offset)
-				head->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
-		}
-		tpm_buf_append_u16(&buf, num_bytes);
-		err = tpm_buf_fill_hmac_session(chip, &buf);
-		if (err) {
-			tpm_buf_destroy(&buf);
-			return err;
-		}
+	if (tpm2_chip_auth(chip)) {
+		tpm_buf_append_hmac_session(chip, &buf,
+					    TPM2_SA_ENCRYPT | TPM2_SA_CONTINUE_SESSION,
+					    NULL, 0);
+	} else  {
+		head = (struct tpm_header *)buf.data;
+		head->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
+	}
+	tpm_buf_append_u16(&buf, max);
 
-		err = tpm_transmit_cmd(chip, &buf,
-				       offsetof(struct tpm2_get_random_out,
-						buffer),
-				       "attempting get random");
-		err = tpm_buf_check_hmac_response(chip, &buf, err);
-		if (err) {
-			if (err > 0)
-				err = -EIO;
-			goto out;
-		}
+	err = tpm_buf_fill_hmac_session(chip, &buf);
+	if (err) {
+		tpm_buf_destroy(&buf);
+		return err;
+	}
 
-		head = (struct tpm_header *)buf.data;
-		offset = TPM_HEADER_SIZE;
-		/* Skip the parameter size field: */
-		if (be16_to_cpu(head->tag) == TPM2_ST_SESSIONS)
-			offset += 4;
-
-		out = (struct tpm2_get_random_out *)&buf.data[offset];
-		recd = min_t(u32, be16_to_cpu(out->size), num_bytes);
-		if (tpm_buf_length(&buf) <
-		    TPM_HEADER_SIZE +
-		    offsetof(struct tpm2_get_random_out, buffer) +
-		    recd) {
-			err = -EFAULT;
-			goto out;
-		}
-		memcpy(dest_ptr, out->buffer, recd);
+	err = tpm_transmit_cmd(chip, &buf, offsetof(struct tpm2_get_random_out, buffer),
+			       "TPM2_GetRandom");
 
-		dest_ptr += recd;
-		total += recd;
-		num_bytes -= recd;
-	} while (retries-- && total < max);
+	err = tpm_buf_check_hmac_response(chip, &buf, err);
+	if (err) {
+		if (err > 0)
+			err = -EIO;
 
-	tpm_buf_destroy(&buf);
+		goto out;
+	}
+
+	head = (struct tpm_header *)buf.data;
+	offset = TPM_HEADER_SIZE;
+
+	/* Skip the parameter size field: */
+	if (be16_to_cpu(head->tag) == TPM2_ST_SESSIONS)
+		offset += 4;
+
+	resp = (struct tpm2_get_random_out *)&buf.data[offset];
+	recd = min_t(u32, be16_to_cpu(resp->size), max);
+
+	if (tpm_buf_length(&buf) <
+	    TPM_HEADER_SIZE + offsetof(struct tpm2_get_random_out, buffer) + recd) {
+		err = -EIO;
+		goto out;
+	}
+
+	memcpy(dest, resp->buffer, recd);
+	return recd;
 
-	return total ? total : -EIO;
 out:
 	tpm_buf_destroy(&buf);
 	tpm2_end_auth_session(chip);
-- 
2.52.0


