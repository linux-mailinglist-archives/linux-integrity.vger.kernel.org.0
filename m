Return-Path: <linux-integrity+bounces-7298-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 752E8BAA848
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Sep 2025 21:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 353B74225C6
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Sep 2025 19:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A960254876;
	Mon, 29 Sep 2025 19:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOEC00i9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E724250BEC;
	Mon, 29 Sep 2025 19:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759175351; cv=none; b=glUYZrjuU2YqDijuN25ivBqZnma4qgs0doH7uscAgWTerF0KNZr+1v9LWqoEFA/Qh+M5b3jkGL0WGOYrrOk+x2s0oCV+8+YHdyqLSfBfC/tfLfvKZ2i0QF8OGY3onPXXERe2Ah2tizyo6MWX7MBaNl5TBG4lGAYofyOzvAkPAU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759175351; c=relaxed/simple;
	bh=gTHpJ3J6V6KDpPzbmF5P/ti2E4Wai6WfCuIW23tmr2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ke3H4L95cpLJxrkTZqKJDe3EOEUiCMdJ8TTtzSEm0tZ/Xr2AF9aU0N64c0CAnsLNWOBPkPDsgPXDUaoOC2/hBOomVNj2VCOLjm8uaWONG5NkeRgQDVmA8I741BpVM5NyPYYYmBI28AQzWzfNqEO8Z2HqGm99eOpX/kFxb4cHwkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOEC00i9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32499C4CEF4;
	Mon, 29 Sep 2025 19:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759175350;
	bh=gTHpJ3J6V6KDpPzbmF5P/ti2E4Wai6WfCuIW23tmr2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TOEC00i9KpnDb0F+OL658NqEwtqVKeGRqGk01DkJtv257Pzr6LNrhdDMeSJCm/bF5
	 M8EG4VPBDWcIJCoYBcu8YcxkXyjMyjFXKU9BWw2xNguU1BXP46C+UfhW2thNB8V3Hk
	 HUri4TKKYHiSeBvm1pFFel0o/Uc0jlxmOHwMw5VJmLS3HUT5AqJP1dTOwJKCn0OrGd
	 X2JMAetOu17TFRCQ8ESkYeYYJTOkUYsNnJOVzjhQhbydd9IPXJkFcl4I2WvgLd00ML
	 rlh3SwOv5RTJRL4dKloxy0QH5PtJSpsMcmrmN8aZB4MXJLoBdWSxScGJReC6OP0Dda
	 xefqBgZfV1uyg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: dpsmith@apertussolutions.com,
	ross.philipson@oracle.com,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Jonathan McDowell <noodles@earth.li>,
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
Subject: [PATCH v3 06/10] KEYS: trusted: Open code tpm2_buf_append()
Date: Mon, 29 Sep 2025 22:48:28 +0300
Message-Id: <20250929194832.2913286-7-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250929194832.2913286-1-jarkko@kernel.org>
References: <20250929194832.2913286-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

tpm2_buf_append_auth() has only single call site and most of its parameters
are redundant. Open code it to the call site. Remove illegit FIXME comment
as there is no categorized bug and replace it with more sane comment about
implementation (i.e. "non-opionated inline comment").

Reviewed-by: Jonathan McDowell <noodles@earth.li>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
v3:
- No changes.
v2:
- No changes.
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


