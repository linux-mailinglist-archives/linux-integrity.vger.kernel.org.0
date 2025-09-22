Return-Path: <linux-integrity+bounces-7227-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BECB9246E
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Sep 2025 18:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EC8316FEA4
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Sep 2025 16:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02313126B8;
	Mon, 22 Sep 2025 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pn6Tbe7G"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF7F3126AD;
	Mon, 22 Sep 2025 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758559426; cv=none; b=VJDPXz7ADG/5ri+Oz2tZpXZBNrWj9WK6Vd4lrzH/d6xDFh9RpuyBBmv97thx6qB5r8/DkHUT1He+2g1Hnr/uRR5gjZL10Drze5Bs3SP7UPKB9YnVdIZy7JQNFkwFAMEwVEhfLur3eXN9HsoVZtjVpxCOeA02ShzjHQk4YQJM5Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758559426; c=relaxed/simple;
	bh=270KFyPEbHS6OLAoXdrYbJe9v20NCmpKDt5TEru0MY8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ax0l4o/3NOvhT8tNBEpnnrJyPx4mK7AP+FVHpY6K5nx73qYk2L8DV8P6F2oQHgf3pdomjn0bW2Hmum85pYBoDLQY6EM37DlwzeOcX8CC9b9SMzAgw8lyMgpD7m8u/gKUYdQTdbkc1MZ0TqPJKCNbsxaNA5C2IVH63tFbw6bYIBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pn6Tbe7G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0EFC4CEF0;
	Mon, 22 Sep 2025 16:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758559426;
	bh=270KFyPEbHS6OLAoXdrYbJe9v20NCmpKDt5TEru0MY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pn6Tbe7G+ItNKCddy6m21L1z+OsXttgayE001/okN7jMXg6lvfluQRGuxMJ/NqPNI
	 LB0PmGdsmB86db8yB87aMsan/GzTyAQOYNbZvENKnvL4GynsMdk9lv+eP3Fhq2WNNV
	 Llz5P1dESoI3o4g8PL+ul9ROQchhvJ7eHBSc7mYvFE+jGzjGBScgJJsd58M2JL9P6n
	 byQfU7gyB+KfIqCweh4k6XEgQPzeyQFlSgA8/YAM4efRTgqa2WM6yhKLu0UrSL2Gli
	 wBGwjb0FJqxGqcAXJsiv/rv8jXWJicbk0TEFyC8evxJWOXdAshUhUjByJbvdg1PxMs
	 KHkAUQ1wvg/EQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/4] keys, trusted: Remove redundant helper
Date: Mon, 22 Sep 2025 19:43:17 +0300
Message-Id: <20250922164318.3540792-5-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250922164318.3540792-1-jarkko@kernel.org>
References: <20250922164318.3540792-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

tpm2_buf_append_auth has only single call site and most of its parameters
are redundant. Open code it to the call site. Remove illegit FIXME comment
as there is no categorized bug and replace it with more sane comment about
implementation (i.e. "non-opionated inline comment").

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
---
 security/keys/trusted-keys/trusted_tpm2.c | 51 ++++-------------------
 1 file changed, 9 insertions(+), 42 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index c414a7006d78..8e3b283a59b2 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -198,36 +198,6 @@ int tpm2_key_priv(void *context, size_t hdrlen,
 	return 0;
 }
 
-/**
- * tpm2_buf_append_auth() - append TPMS_AUTH_COMMAND to the buffer.
- *
- * @buf: an allocated tpm_buf instance
- * @session_handle: session handle
- * @nonce: the session nonce, may be NULL if not used
- * @nonce_len: the session nonce length, may be 0 if not used
- * @attributes: the session attributes
- * @hmac: the session HMAC or password, may be NULL if not used
- * @hmac_len: the session HMAC or password length, maybe 0 if not used
- */
-static void tpm2_buf_append_auth(struct tpm_buf *buf, u32 session_handle,
-				 const u8 *nonce, u16 nonce_len,
-				 u8 attributes,
-				 const u8 *hmac, u16 hmac_len)
-{
-	tpm_buf_append_u32(buf, 9 + nonce_len + hmac_len);
-	tpm_buf_append_u32(buf, session_handle);
-	tpm_buf_append_u16(buf, nonce_len);
-
-	if (nonce && nonce_len)
-		tpm_buf_append(buf, nonce, nonce_len);
-
-	tpm_buf_append_u8(buf, attributes);
-	tpm_buf_append_u16(buf, hmac_len);
-
-	if (hmac && hmac_len)
-		tpm_buf_append(buf, hmac, hmac_len);
-}
-
 /**
  * tpm2_seal_trusted() - seal the payload of a trusted key
  *
@@ -507,19 +477,16 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 					    options->blobauth_len);
 	} else {
 		/*
-		 * FIXME: The policy session was generated outside the
-		 * kernel so we don't known the nonce and thus can't
-		 * calculate a HMAC on it.  Therefore, the user can
-		 * only really use TPM2_PolicyPassword and we must
-		 * send down the plain text password, which could be
-		 * intercepted.  We can still encrypt the returned
-		 * key, but that's small comfort since the interposer
-		 * could repeat our actions with the exfiltrated
-		 * password.
+		 * The policy session is generated outside the kernel, and thus
+		 * the password will end up being unencrypted on the bus, as
+		 * HMAC nonce cannot be calculated for it.
 		 */
-		tpm2_buf_append_auth(&buf, options->policyhandle,
-				     NULL /* nonce */, 0, 0,
-				     options->blobauth, options->blobauth_len);
+		tpm_buf_append_u32(&buf, 9 + options->blobauth_len);
+		tpm_buf_append_u32(&buf, options->policyhandle);
+		tpm_buf_append_u16(&buf, 0);
+		tpm_buf_append_u8(&buf, 0);
+		tpm_buf_append_u16(&buf, options->blobauth_len);
+		tpm_buf_append(&buf, options->blobauth, options->blobauth_len);
 		if (tpm2_chip_auth(chip)) {
 			tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_ENCRYPT, NULL, 0);
 		} else  {
-- 
2.39.5


