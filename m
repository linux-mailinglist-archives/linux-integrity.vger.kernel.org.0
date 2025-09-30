Return-Path: <linux-integrity+bounces-7347-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEDDBAEC25
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Oct 2025 01:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7F6D1884938
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 23:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECC82D46A2;
	Tue, 30 Sep 2025 23:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGG/NGsC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E38B2D24A9;
	Tue, 30 Sep 2025 23:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759274432; cv=none; b=XruFYLg6BAtfzxQAGHu6MuidiPYQiIoG6r5qE8kcRrAq/VIWLtmvtr+LD2dmnoZcJ0AWCzb9quJ/YC0qKXMDYBxc3Xwj5TUe4BG4fIthLO86jC74pdMaQ9r5zlsSfONwBP1OOur4TO9feqBONIcbLoJKrIx4F8ZnUuUaCbQ+OGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759274432; c=relaxed/simple;
	bh=UI5WH8CIrYIT5llAyfRGyTdl+LzPe3307iquwLpl3Vc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UMJdpuHRm2DN0PhAVLAkdfedi4G79g0Tf8UB18J29RVlNF1/Emdlw93B0+OB9dOJ4QCZ7iJ23iAW35vJYZcStnaX84Pz+1uXAT1uMvGGfdFZSRzyls3z7QnHyhBEeFLaOvaqfeqr2pF80XVywuACFVWK/t3maZesJX25dTuOYeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGG/NGsC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0EFC113CF;
	Tue, 30 Sep 2025 23:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759274431;
	bh=UI5WH8CIrYIT5llAyfRGyTdl+LzPe3307iquwLpl3Vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AGG/NGsClLZOtEl3NDu/X3xRTZ/WYy8QlovupAcMeWkckcferwZDOfgp6sjp7b4PN
	 J8zNnN0M9W1Z6xS0Aq9xEWc2PJm9UTvWoP03UsQje53GlWSsgUqRmqNTqI5LJScR0a
	 sdRMsk7B3O2M4ziq9cc+oKKedE390WyRxTapKiOM95WOz3ZqErTH0nJiaKuok58hGE
	 00PI7NxfuANW5PYmXe6EDALr3VwtfBbCtly5hOQiaFgRHBxx3QMpRiDS0JkdFfoNkA
	 jj5XDkujyP+l5Ltyypp4bf4WfsIKKJwlDoz6caoGbiALCx0ehWBqPzI5u89tlEdJ5B
	 ppBeo1pPoqmmA==
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
Subject: [PATCH v5 6/9] KEYS: trusted: Open code tpm2_buf_append()
Date: Wed,  1 Oct 2025 02:19:55 +0300
Message-Id: <20250930231958.1437783-7-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250930231958.1437783-1-jarkko@kernel.org>
References: <20250930231958.1437783-1-jarkko@kernel.org>
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
v4:
- No changes:
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


