Return-Path: <linux-integrity+bounces-7966-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94520CBBCD2
	for <lists+linux-integrity@lfdr.de>; Sun, 14 Dec 2025 16:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53BC530124F1
	for <lists+linux-integrity@lfdr.de>; Sun, 14 Dec 2025 15:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B3E293C44;
	Sun, 14 Dec 2025 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U35sBstP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78729280329;
	Sun, 14 Dec 2025 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765726709; cv=none; b=MVo3wN8MrXNuPMGCezlucf1ldsAYET/NpbedrQRuCvyGQbN3X20217yxj18qiQ8OXVrNfvd/LsvhgpnHXCYLsBkIcszvJ5/XgPVoWrx8/PiXSWJiUCgwAacjVJNuhIAzt1mWNWYudTcnFhvwlO5X2A2ri7TjYxywjrnlUsAmESs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765726709; c=relaxed/simple;
	bh=9z1wVQJ20sb+PyEwaOgUsDg90w63BGYT0g7MKMfuuMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qbsXlVMdNW4fRuHtRJ5USuWNN2l/h6FasE5r5x2IIYX9+wTFfo6HHi8JkFX694byKOEAqXjWFVMkJJUkHK2cGGDWJRPjIlmW4HlWj1OtDVMPtuRin3CXEcDcuC7ofR8ZtFZzrRiPQPwLM8cMqe5+MoK1u14encOW3dV5icibGoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U35sBstP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B005CC4CEF1;
	Sun, 14 Dec 2025 15:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765726709;
	bh=9z1wVQJ20sb+PyEwaOgUsDg90w63BGYT0g7MKMfuuMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U35sBstPdntIjnxi37M7zm1G/7VmYKO+rGE/2udVeQgF7Ib6jZjVZuTlc/fLHar4E
	 S035QAAMAHc3bPE7X/3LxXrUB0cjeDZGBk6rfcK4As4WmaPAGGv/EB0UIizzYcZ7W+
	 Sl25tjJB8yR99HfJcH14/4cJls8OZowgY7d4guxJqcqwf22KHzudcWOHXKmty1OGcI
	 zt5tUAWFkWYe0LccWomGVM67+YNUAtCNMyZYycob/U5fanWNWoFxptqt0FDhs2ITBW
	 5oiDqGq+ok5ioMPcdEn/Zzu/JIh6ut3eCnqzSdz1c2FNw81K1WaLEV80D3IUBebhcL
	 fJRsVE7Wv+ivw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Ross Philipson <ross.philipson@oracle.com>,
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
Subject: [PATCH v6 02/11] KEYS: trusted: Open code tpm2_buf_append()
Date: Sun, 14 Dec 2025 17:37:59 +0200
Message-Id: <20251214153808.73831-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251214153808.73831-1-jarkko@kernel.org>
References: <20251214153808.73831-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

tpm2_buf_append_auth() has a single call site and most of its parameters
are redundant. Open code it to the call site so that less cross-referencing
is required while browsing the source code.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
Reviewed-by: Jonathan McDowell <noodles@earth.li>
---
v6:
- Trimmed the patch by removing comment update as it is out of scope.
---
 security/keys/trusted-keys/trusted_tpm2.c | 40 ++++-------------------
 1 file changed, 7 insertions(+), 33 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index a7ea4a1c3bed..d3a5c5f2b926 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -190,36 +190,6 @@ int tpm2_key_priv(void *context, size_t hdrlen,
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
@@ -518,9 +488,13 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 		 * could repeat our actions with the exfiltrated
 		 * password.
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
+
 		if (tpm2_chip_auth(chip)) {
 			tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_ENCRYPT, NULL, 0);
 		} else  {
-- 
2.39.5


