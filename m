Return-Path: <linux-integrity+bounces-7824-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC3FCA83B7
	for <lists+linux-integrity@lfdr.de>; Fri, 05 Dec 2025 16:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A57A53000591
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Dec 2025 15:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EA235A940;
	Fri,  5 Dec 2025 15:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxXNAJWE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5147D35A93C;
	Fri,  5 Dec 2025 15:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764948019; cv=none; b=O6trYPLslFLObdhccmPWsgntHCCabty83d8ObM+AdYr19rqJOMjFdAQ4ekec/Y1cY4wG26EmiP59PaKkygl7c8hv/Uk3c6pm8RsHV7LYmmtyg29XeGBpmH/WS9jA4JHypkXlYxlP9fUM/Y/JRUEZ0vjgwkNJSg23BzWGm16gEu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764948019; c=relaxed/simple;
	bh=0DrduLHOvQ6wuIuzL/EBUrku6LUri3yCavX2EZycS/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ep3WZ549NSMrXVV5cio6r3duyLqFzOnaNalBnuljh69AQhYrbmajck6wwE2JUfoaMxxnf6mabs+icU6bT1N+Zd0OII9mf7KOfuVX3s7M/k5j04qUhkYRiYgEgdbtrirYJaufBQSM4eNPAt27fnKWB+FmmV3XMY5EOSnGW47upac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxXNAJWE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF57C4CEF1;
	Fri,  5 Dec 2025 15:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764948018;
	bh=0DrduLHOvQ6wuIuzL/EBUrku6LUri3yCavX2EZycS/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QxXNAJWEFZAHUjCIBp4zwDBxN/VWLYBZXc3v+ZOGTOkgWbrICMArBfEBA/ZY6lRd6
	 x+YoNSr/PbmlTkUobi4YFyBJEyBSPL15BcEGW6H9IuTWYu0jFSE7OMJ7b7ktqhLRmn
	 2n1V/owewBIcqqpJVFKCfCUXgR+1LvnlGyOFEA9BzL4rkPaeUyG/WDLanWjPdMpohQ
	 aWO0qaUPgCQOM87T/WBKqojzFNG60aqgwMj7UA4NSkgAk3ED9O8stzqqsVaXeLzVmb
	 dsOJSbEd6DVYDdNHXBa0yI71zchFoIJq4eb5Db4xPpi90Cgm3ao0+AB5mPUPVoM/3Z
	 +N0PCzYWXqFIg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Jonathan McDowell <noodles@earth.li>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS-TRUSTED),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v4 3/4] KEYS: trusted: Open code tpm2_buf_append()
Date: Fri,  5 Dec 2025 17:19:52 +0200
Message-ID: <20251205151955.298182-4-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251205151955.298182-1-jarkko@kernel.org>
References: <20251205151955.298182-1-jarkko@kernel.org>
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

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
Reviewed-by: Jonathan McDowell <noodles@earth.li>
---
 security/keys/trusted-keys/trusted_tpm2.c | 51 ++++-------------------
 1 file changed, 9 insertions(+), 42 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 07f04cc010bc..3b5dbbc2d257 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -226,36 +226,6 @@ int tpm2_key_parent_name(void *context, size_t hdrlen, unsigned char tag,
 
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
@@ -549,19 +519,16 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
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
2.52.0


