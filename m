Return-Path: <linux-integrity+bounces-2273-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 293EA8B63A2
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2024 22:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95A9D1F22EB4
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2024 20:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3495115B544;
	Mon, 29 Apr 2024 20:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="KWUkM7th"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4410D15B112;
	Mon, 29 Apr 2024 20:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714422649; cv=none; b=l549IEACpam0BpCSLH17E+XMKJf4VJt/wygfNEmVsOxTUVNkboO8Tf71YjlHZgkdlo6tcIwV9aK+ejE3VBZmiyekaKFM9Fe9GHdwnjHkRmS17Ib5IbYvV10xaFc435ChK7IBHOU2Jo3BwcK+SFVjB/kG66KZrPyatsiPggqCmOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714422649; c=relaxed/simple;
	bh=slu9FUjYGHC1AlJJrB13ItEtdfsMTziqFWhPZ9f5Enc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=etOiOXM6a2oYoLjgjZLMNPFo7S+zb4nrTAEvCxluViHAlqEBPit8uLCM4evC+yii/dPY9ytW/NmjBDm2cA07JmjnGGk8iRlJZk0MkAN2i43sZVa5FntmT+pQFNAC1tVz64bftTZRVI4lOiXfIlLc+3TFgYRuMPG3L0XzFgBhEs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=KWUkM7th; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1714422646;
	bh=slu9FUjYGHC1AlJJrB13ItEtdfsMTziqFWhPZ9f5Enc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=KWUkM7thbgt3JOoK0Mz+YXM/dMbQyp9vtKqrgzTP+4CryscJoY/VEINwOJpdGrmS7
	 h+6NYWuOcKGY0Wbdqgr7bfwPNq7yoopyK2+ZKJddGqhHCFzQNSSNghEx/Phv/3BfVy
	 K9uCwMsiA5dO0MlMpF4l19wCmpz6wxDKAYNLai/k=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id D6AD61281D87;
	Mon, 29 Apr 2024 16:30:46 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id lt7_CRTMEFr1; Mon, 29 Apr 2024 16:30:46 -0400 (EDT)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3F97512819F3;
	Mon, 29 Apr 2024 16:30:46 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v8 16/22] tpm: Add the rest of the session HMAC API
Date: Mon, 29 Apr 2024 16:28:05 -0400
Message-Id: <20240429202811.13643-17-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
References: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The final pieces of the HMAC API are for manipulating the session area
of the command.  To add an authentication HMAC session
tpm_buf_append_hmac_session() is called where tpm2_append_auth() would
go. If a non empty password is passed in, this is correctly added to
the HMAC to prove knowledge of it without revealing it.  Note that if
the session is only used to encrypt or decrypt parameters (no
authentication) then tpm_buf_append_hmac_session_opt() must be used
instead.  This functions identically to tpm_buf_append_hmac_session()
when TPM_BUS_SECURITY is enabled, but differently when it isn't,
because effectively nothing is appended to the session area.

Next the parameters should be filled in for the command and finally
tpm_buf_fill_hmac_session() is called immediately prior to transmitting
the command which computes the correct HMAC and places it in the
command at the session location in the tpm buffer

Finally, after tpm_transmit_cmd() is called,
tpm_buf_check_hmac_response() is called to check that the returned
HMAC matched and collect the new state for the next use of the
session, if any.

The features of the session are controlled by the session attributes
set in tpm_buf_append_hmac_session().  If TPM2_SA_CONTINUE_SESSION is
not specified, the session will be flushed and the tpm2_auth structure
freed in tpm_buf_check_hmac_response(); otherwise the session may be
used again.  Parameter encryption is specified by or'ing the flag
TPM2_SA_DECRYPT and response encryption by or'ing the flag
TPM2_SA_ENCRYPT.  the various encryptions will be taken care of by
tpm_buf_fill_hmac_session() and tpm_buf_check_hmac_response()
respectively.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org> # crypto API parts

---

v6: split into new patch, update config variable
v7: add memzero_explicit
v8: minor updates
---
 drivers/char/tpm/tpm2-sessions.c | 400 +++++++++++++++++++++++++++++++
 include/linux/tpm.h              |  69 ++++++
 2 files changed, 469 insertions(+)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 99eb048f18c8..3c97d3d5e00e 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -54,6 +54,18 @@
  *	handles because handles have to be processed specially when
  *	calculating the HMAC.  In particular, for NV, volatile and
  *	permanent objects you now need to provide the name.
+ * tpm_buf_append_hmac_session() which appends the hmac session to the
+ *	buf in the same way tpm_buf_append_auth does().
+ * tpm_buf_fill_hmac_session() This calculates the correct hash and
+ *	places it in the buffer.  It must be called after the complete
+ *	command buffer is finalized so it can fill in the correct HMAC
+ *	based on the parameters.
+ * tpm_buf_check_hmac_response() which checks the session response in
+ *	the buffer and calculates what it should be.  If there's a
+ *	mismatch it will log a warning and return an error.  If
+ *	tpm_buf_append_hmac_session() did not specify
+ *	TPM_SA_CONTINUE_SESSION then the session will be closed (if it
+ *	hasn't been consumed) and the auth structure freed.
  */
 
 #include "tpm.h"
@@ -103,7 +115,23 @@ struct tpm2_auth {
 		/* scratch for key + IV */
 		u8 scratch[AES_KEY_BYTES + AES_BLOCK_SIZE];
 	};
+	/*
+	 * the session key and passphrase are the same size as the
+	 * name digest (sha256 again).  The session key is constant
+	 * for the use of the session and the passphrase can change
+	 * with every invocation.
+	 *
+	 * Note: these fields must be adjacent and in this order
+	 * because several HMAC/KDF schemes use the combination of the
+	 * session_key and passphrase.
+	 */
 	u8 session_key[SHA256_DIGEST_SIZE];
+	u8 passphrase[SHA256_DIGEST_SIZE];
+	int passphrase_len;
+	struct crypto_aes_ctx aes_ctx;
+	/* saved session attributes: */
+	u8 attrs;
+	__be32 ordinal;
 
 	/*
 	 * memory for three authorization handles.  We know them by
@@ -309,6 +337,230 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip)
 	crypto_free_kpp(kpp);
 }
 
+/**
+ * tpm_buf_append_hmac_session() - Append a TPM session element
+ * @chip: the TPM chip structure
+ * @buf: The buffer to be appended
+ * @attributes: The session attributes
+ * @passphrase: The session authority (NULL if none)
+ * @passphrase_len: The length of the session authority (0 if none)
+ *
+ * This fills in a session structure in the TPM command buffer, except
+ * for the HMAC which cannot be computed until the command buffer is
+ * complete.  The type of session is controlled by the @attributes,
+ * the main ones of which are TPM2_SA_CONTINUE_SESSION which means the
+ * session won't terminate after tpm_buf_check_hmac_response(),
+ * TPM2_SA_DECRYPT which means this buffers first parameter should be
+ * encrypted with a session key and TPM2_SA_ENCRYPT, which means the
+ * response buffer's first parameter needs to be decrypted (confusing,
+ * but the defines are written from the point of view of the TPM).
+ *
+ * Any session appended by this command must be finalized by calling
+ * tpm_buf_fill_hmac_session() otherwise the HMAC will be incorrect
+ * and the TPM will reject the command.
+ *
+ * As with most tpm_buf operations, success is assumed because failure
+ * will be caused by an incorrect programming model and indicated by a
+ * kernel message.
+ */
+void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
+				 u8 attributes, u8 *passphrase,
+				 int passphrase_len)
+{
+	u8 nonce[SHA256_DIGEST_SIZE];
+	u32 len;
+	struct tpm2_auth *auth = chip->auth;
+
+	/*
+	 * The Architecture Guide requires us to strip trailing zeros
+	 * before computing the HMAC
+	 */
+	while (passphrase && passphrase_len > 0
+	       && passphrase[passphrase_len - 1] == '\0')
+		passphrase_len--;
+
+	auth->attrs = attributes;
+	auth->passphrase_len = passphrase_len;
+	if (passphrase_len)
+		memcpy(auth->passphrase, passphrase, passphrase_len);
+
+	if (auth->session != tpm_buf_length(buf)) {
+		/* we're not the first session */
+		len = get_unaligned_be32(&buf->data[auth->session]);
+		if (4 + len + auth->session != tpm_buf_length(buf)) {
+			WARN(1, "session length mismatch, cannot append");
+			return;
+		}
+
+		/* add our new session */
+		len += 9 + 2 * SHA256_DIGEST_SIZE;
+		put_unaligned_be32(len, &buf->data[auth->session]);
+	} else {
+		tpm_buf_append_u32(buf, 9 + 2 * SHA256_DIGEST_SIZE);
+	}
+
+	/* random number for our nonce */
+	get_random_bytes(nonce, sizeof(nonce));
+	memcpy(auth->our_nonce, nonce, sizeof(nonce));
+	tpm_buf_append_u32(buf, auth->handle);
+	/* our new nonce */
+	tpm_buf_append_u16(buf, SHA256_DIGEST_SIZE);
+	tpm_buf_append(buf, nonce, SHA256_DIGEST_SIZE);
+	tpm_buf_append_u8(buf, auth->attrs);
+	/* and put a placeholder for the hmac */
+	tpm_buf_append_u16(buf, SHA256_DIGEST_SIZE);
+	tpm_buf_append(buf, nonce, SHA256_DIGEST_SIZE);
+}
+EXPORT_SYMBOL(tpm_buf_append_hmac_session);
+
+/**
+ * tpm_buf_fill_hmac_session() - finalize the session HMAC
+ * @chip: the TPM chip structure
+ * @buf: The buffer to be appended
+ *
+ * This command must not be called until all of the parameters have
+ * been appended to @buf otherwise the computed HMAC will be
+ * incorrect.
+ *
+ * This function computes and fills in the session HMAC using the
+ * session key and, if TPM2_SA_DECRYPT was specified, computes the
+ * encryption key and encrypts the first parameter of the command
+ * buffer with it.
+ *
+ * As with most tpm_buf operations, success is assumed because failure
+ * will be caused by an incorrect programming model and indicated by a
+ * kernel message.
+ */
+void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
+{
+	u32 cc, handles, val;
+	struct tpm2_auth *auth = chip->auth;
+	int i;
+	struct tpm_header *head = (struct tpm_header *)buf->data;
+	off_t offset_s = TPM_HEADER_SIZE, offset_p;
+	u8 *hmac = NULL;
+	u32 attrs;
+	u8 cphash[SHA256_DIGEST_SIZE];
+	struct sha256_state sctx;
+
+	/* save the command code in BE format */
+	auth->ordinal = head->ordinal;
+
+	cc = be32_to_cpu(head->ordinal);
+
+	i = tpm2_find_cc(chip, cc);
+	if (i < 0) {
+		dev_err(&chip->dev, "Command 0x%x not found in TPM\n", cc);
+		return;
+	}
+	attrs = chip->cc_attrs_tbl[i];
+
+	handles = (attrs >> TPM2_CC_ATTR_CHANDLES) & GENMASK(2, 0);
+
+	/*
+	 * just check the names, it's easy to make mistakes.  This
+	 * would happen if someone added a handle via
+	 * tpm_buf_append_u32() instead of tpm_buf_append_name()
+	 */
+	for (i = 0; i < handles; i++) {
+		u32 handle = tpm_buf_read_u32(buf, &offset_s);
+
+		if (auth->name_h[i] != handle) {
+			dev_err(&chip->dev, "TPM: handle %d wrong for name\n",
+				  i);
+			return;
+		}
+	}
+	/* point offset_s to the start of the sessions */
+	val = tpm_buf_read_u32(buf, &offset_s);
+	/* point offset_p to the start of the parameters */
+	offset_p = offset_s + val;
+	for (i = 1; offset_s < offset_p; i++) {
+		u32 handle = tpm_buf_read_u32(buf, &offset_s);
+		u16 len;
+		u8 a;
+
+		/* nonce (already in auth) */
+		len = tpm_buf_read_u16(buf, &offset_s);
+		offset_s += len;
+
+		a = tpm_buf_read_u8(buf, &offset_s);
+
+		len = tpm_buf_read_u16(buf, &offset_s);
+		if (handle == auth->handle && auth->attrs == a) {
+			hmac = &buf->data[offset_s];
+			/*
+			 * save our session number so we know which
+			 * session in the response belongs to us
+			 */
+			auth->session = i;
+		}
+
+		offset_s += len;
+	}
+	if (offset_s != offset_p) {
+		dev_err(&chip->dev, "TPM session length is incorrect\n");
+		return;
+	}
+	if (!hmac) {
+		dev_err(&chip->dev, "TPM could not find HMAC session\n");
+		return;
+	}
+
+	/* encrypt before HMAC */
+	if (auth->attrs & TPM2_SA_DECRYPT) {
+		u16 len;
+
+		/* need key and IV */
+		tpm2_KDFa(auth->session_key, SHA256_DIGEST_SIZE
+			  + auth->passphrase_len, "CFB", auth->our_nonce,
+			  auth->tpm_nonce, AES_KEY_BYTES + AES_BLOCK_SIZE,
+			  auth->scratch);
+
+		len = tpm_buf_read_u16(buf, &offset_p);
+		aes_expandkey(&auth->aes_ctx, auth->scratch, AES_KEY_BYTES);
+		aescfb_encrypt(&auth->aes_ctx, &buf->data[offset_p],
+			       &buf->data[offset_p], len,
+			       auth->scratch + AES_KEY_BYTES);
+		/* reset p to beginning of parameters for HMAC */
+		offset_p -= 2;
+	}
+
+	sha256_init(&sctx);
+	/* ordinal is already BE */
+	sha256_update(&sctx, (u8 *)&head->ordinal, sizeof(head->ordinal));
+	/* add the handle names */
+	for (i = 0; i < handles; i++) {
+		enum tpm2_mso_type mso = tpm2_handle_mso(auth->name_h[i]);
+
+		if (mso == TPM2_MSO_PERSISTENT ||
+		    mso == TPM2_MSO_VOLATILE ||
+		    mso == TPM2_MSO_NVRAM) {
+			sha256_update(&sctx, auth->name[i],
+				      name_size(auth->name[i]));
+		} else {
+			__be32 h = cpu_to_be32(auth->name_h[i]);
+
+			sha256_update(&sctx, (u8 *)&h, 4);
+		}
+	}
+	if (offset_s != tpm_buf_length(buf))
+		sha256_update(&sctx, &buf->data[offset_s],
+			      tpm_buf_length(buf) - offset_s);
+	sha256_final(&sctx, cphash);
+
+	/* now calculate the hmac */
+	tpm2_hmac_init(&sctx, auth->session_key, sizeof(auth->session_key)
+		       + auth->passphrase_len);
+	sha256_update(&sctx, cphash, sizeof(cphash));
+	sha256_update(&sctx, auth->our_nonce, sizeof(auth->our_nonce));
+	sha256_update(&sctx, auth->tpm_nonce, sizeof(auth->tpm_nonce));
+	sha256_update(&sctx, &auth->attrs, 1);
+	tpm2_hmac_final(&sctx, auth->session_key, sizeof(auth->session_key)
+			+ auth->passphrase_len, hmac);
+}
+EXPORT_SYMBOL(tpm_buf_fill_hmac_session);
+
 static int tpm2_parse_read_public(char *name, struct tpm_buf *buf)
 {
 	struct tpm_header *head = (struct tpm_header *)buf->data;
@@ -406,6 +658,154 @@ void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 		memcpy(auth->name[slot], name, name_size(name));
 }
 EXPORT_SYMBOL(tpm_buf_append_name);
+
+/**
+ * tpm_buf_check_hmac_response() - check the TPM return HMAC for correctness
+ * @chip: the TPM chip structure
+ * @buf: the original command buffer (which now contains the response)
+ * @rc: the return code from tpm_transmit_cmd
+ *
+ * If @rc is non zero, @buf may not contain an actual return, so @rc
+ * is passed through as the return and the session cleaned up and
+ * de-allocated if required (this is required if
+ * TPM2_SA_CONTINUE_SESSION was not specified as a session flag).
+ *
+ * If @rc is zero, the response HMAC is computed against the returned
+ * @buf and matched to the TPM one in the session area.  If there is a
+ * mismatch, an error is logged and -EINVAL returned.
+ *
+ * The reason for this is that the command issue and HMAC check
+ * sequence should look like:
+ *
+ *	rc = tpm_transmit_cmd(...);
+ *	rc = tpm_buf_check_hmac_response(&buf, auth, rc);
+ *	if (rc)
+ *		...
+ *
+ * Which is easily layered into the current contrl flow.
+ *
+ * Returns: 0 on success or an error.
+ */
+int tpm_buf_check_hmac_response(struct tpm_chip *chip, struct tpm_buf *buf,
+				int rc)
+{
+	struct tpm_header *head = (struct tpm_header *)buf->data;
+	struct tpm2_auth *auth = chip->auth;
+	off_t offset_s, offset_p;
+	u8 rphash[SHA256_DIGEST_SIZE];
+	u32 attrs;
+	struct sha256_state sctx;
+	u16 tag = be16_to_cpu(head->tag);
+	u32 cc = be32_to_cpu(auth->ordinal);
+	int parm_len, len, i, handles;
+
+	if (auth->session >= TPM_HEADER_SIZE) {
+		WARN(1, "tpm session not filled correctly\n");
+		goto out;
+	}
+
+	if (rc != 0)
+		/* pass non success rc through and close the session */
+		goto out;
+
+	rc = -EINVAL;
+	if (tag != TPM2_ST_SESSIONS) {
+		dev_err(&chip->dev, "TPM: HMAC response check has no sessions tag\n");
+		goto out;
+	}
+
+	i = tpm2_find_cc(chip, cc);
+	if (i < 0)
+		goto out;
+	attrs = chip->cc_attrs_tbl[i];
+	handles = (attrs >> TPM2_CC_ATTR_RHANDLE) & 1;
+
+	/* point to area beyond handles */
+	offset_s = TPM_HEADER_SIZE + handles * 4;
+	parm_len = tpm_buf_read_u32(buf, &offset_s);
+	offset_p = offset_s;
+	offset_s += parm_len;
+	/* skip over any sessions before ours */
+	for (i = 0; i < auth->session - 1; i++) {
+		len = tpm_buf_read_u16(buf, &offset_s);
+		offset_s += len + 1;
+		len = tpm_buf_read_u16(buf, &offset_s);
+		offset_s += len;
+	}
+	/* TPM nonce */
+	len = tpm_buf_read_u16(buf, &offset_s);
+	if (offset_s + len > tpm_buf_length(buf))
+		goto out;
+	if (len != SHA256_DIGEST_SIZE)
+		goto out;
+	memcpy(auth->tpm_nonce, &buf->data[offset_s], len);
+	offset_s += len;
+	attrs = tpm_buf_read_u8(buf, &offset_s);
+	len = tpm_buf_read_u16(buf, &offset_s);
+	if (offset_s + len != tpm_buf_length(buf))
+		goto out;
+	if (len != SHA256_DIGEST_SIZE)
+		goto out;
+	/*
+	 * offset_s points to the HMAC. now calculate comparison, beginning
+	 * with rphash
+	 */
+	sha256_init(&sctx);
+	/* yes, I know this is now zero, but it's what the standard says */
+	sha256_update(&sctx, (u8 *)&head->return_code,
+		      sizeof(head->return_code));
+	/* ordinal is already BE */
+	sha256_update(&sctx, (u8 *)&auth->ordinal, sizeof(auth->ordinal));
+	sha256_update(&sctx, &buf->data[offset_p], parm_len);
+	sha256_final(&sctx, rphash);
+
+	/* now calculate the hmac */
+	tpm2_hmac_init(&sctx, auth->session_key, sizeof(auth->session_key)
+		       + auth->passphrase_len);
+	sha256_update(&sctx, rphash, sizeof(rphash));
+	sha256_update(&sctx, auth->tpm_nonce, sizeof(auth->tpm_nonce));
+	sha256_update(&sctx, auth->our_nonce, sizeof(auth->our_nonce));
+	sha256_update(&sctx, &auth->attrs, 1);
+	/* we're done with the rphash, so put our idea of the hmac there */
+	tpm2_hmac_final(&sctx, auth->session_key, sizeof(auth->session_key)
+			+ auth->passphrase_len, rphash);
+	if (memcmp(rphash, &buf->data[offset_s], SHA256_DIGEST_SIZE) == 0) {
+		rc = 0;
+	} else {
+		dev_err(&chip->dev, "TPM: HMAC check failed\n");
+		goto out;
+	}
+
+	/* now do response decryption */
+	if (auth->attrs & TPM2_SA_ENCRYPT) {
+		/* need key and IV */
+		tpm2_KDFa(auth->session_key, SHA256_DIGEST_SIZE
+			  + auth->passphrase_len, "CFB", auth->tpm_nonce,
+			  auth->our_nonce, AES_KEY_BYTES + AES_BLOCK_SIZE,
+			  auth->scratch);
+
+		len = tpm_buf_read_u16(buf, &offset_p);
+		aes_expandkey(&auth->aes_ctx, auth->scratch, AES_KEY_BYTES);
+		aescfb_decrypt(&auth->aes_ctx, &buf->data[offset_p],
+			       &buf->data[offset_p], len,
+			       auth->scratch + AES_KEY_BYTES);
+	}
+
+ out:
+	if ((auth->attrs & TPM2_SA_CONTINUE_SESSION) == 0) {
+		if (rc)
+			/* manually close the session if it wasn't consumed */
+			tpm2_flush_context(chip, auth->handle);
+		memzero_explicit(auth, sizeof(*auth));
+	} else {
+		/* reset for next use  */
+		auth->session = TPM_HEADER_SIZE;
+	}
+
+	return rc;
+}
+EXPORT_SYMBOL(tpm_buf_check_hmac_response);
+
 /**
  * tpm2_end_auth_session() - kill the allocated auth session
  * @chip: the TPM chip structure
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 31c2065fcd35..dd4d6a6158c4 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -510,8 +510,25 @@ static inline void tpm_buf_append_empty_auth(struct tpm_buf *buf, u32 handle)
 int tpm2_start_auth_session(struct tpm_chip *chip);
 void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 			 u32 handle, u8 *name);
+void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
+				 u8 attributes, u8 *passphrase,
+				 int passphraselen);
+static inline void tpm_buf_append_hmac_session_opt(struct tpm_chip *chip,
+						   struct tpm_buf *buf,
+						   u8 attributes,
+						   u8 *passphrase,
+						   int passphraselen)
+{
+	tpm_buf_append_hmac_session(chip, buf, attributes, passphrase,
+				    passphraselen);
+}
+void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf);
+int tpm_buf_check_hmac_response(struct tpm_chip *chip, struct tpm_buf *buf,
+				int rc);
 void tpm2_end_auth_session(struct tpm_chip *chip);
 #else
+#include <asm/unaligned.h>
+
 static inline int tpm2_start_auth_session(struct tpm_chip *chip)
 {
 	return 0;
@@ -527,6 +544,58 @@ static inline void tpm_buf_append_name(struct tpm_chip *chip,
 	/* count the number of handles in the upper bits of flags */
 	buf->handles++;
 }
+static inline void tpm_buf_append_hmac_session(struct tpm_chip *chip,
+					       struct tpm_buf *buf,
+					       u8 attributes, u8 *passphrase,
+					       int passphraselen)
+{
+	/* offset tells us where the sessions area begins */
+	int offset = buf->handles * 4 + TPM_HEADER_SIZE;
+	u32 len = 9 + passphraselen;
+
+	if (tpm_buf_length(buf) != offset) {
+		/* not the first session so update the existing length */
+		len += get_unaligned_be32(&buf->data[offset]);
+		put_unaligned_be32(len, &buf->data[offset]);
+	} else {
+		tpm_buf_append_u32(buf, len);
+	}
+	/* auth handle */
+	tpm_buf_append_u32(buf, TPM2_RS_PW);
+	/* nonce */
+	tpm_buf_append_u16(buf, 0);
+	/* attributes */
+	tpm_buf_append_u8(buf, 0);
+	/* passphrase */
+	tpm_buf_append_u16(buf, passphraselen);
+	tpm_buf_append(buf, passphrase, passphraselen);
+}
+static inline void tpm_buf_append_hmac_session_opt(struct tpm_chip *chip,
+						   struct tpm_buf *buf,
+						   u8 attributes,
+						   u8 *passphrase,
+						   int passphraselen)
+{
+	int offset = buf->handles * 4 + TPM_HEADER_SIZE;
+	struct tpm_header *head = (struct tpm_header *) buf->data;
+
+	/*
+	 * if the only sessions are optional, the command tag
+	 * must change to TPM2_ST_NO_SESSIONS
+	 */
+	if (tpm_buf_length(buf) == offset)
+		head->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
+}
+static inline void tpm_buf_fill_hmac_session(struct tpm_chip *chip,
+					     struct tpm_buf *buf)
+{
+}
+static inline int tpm_buf_check_hmac_response(struct tpm_chip *chip,
+					      struct tpm_buf *buf,
+					      int rc)
+{
+	return rc;
+}
 #endif	/* CONFIG_TCG_TPM2_HMAC */
 
 #endif
-- 
2.35.3


