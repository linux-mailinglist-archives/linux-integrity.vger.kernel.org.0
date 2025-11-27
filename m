Return-Path: <linux-integrity+bounces-7697-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A49CC8EA34
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 14:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E9A66352736
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 13:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0523F333446;
	Thu, 27 Nov 2025 13:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZXfA8mE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF5632BF24;
	Thu, 27 Nov 2025 13:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764251734; cv=none; b=Uu7pbiO7AgSMsLueLwfdGRse9uwDJ903VHH2ByQe/3DB09Kvguehn87QMoQAKxKZInyaKj1ltVpGGWSCyjijtDNg+Vp0VCDku71c1QOJyeAJyPDpD24t42iE13YMG7fKKBGHiYtmtNNsCIhvskddMEm8TMNwFA9HDkQmoKzIAGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764251734; c=relaxed/simple;
	bh=TcKH1vXA+ppYg8yS7msBkSh0m73ZkK2EUiEzp8q2wOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+faAsnmXawz2oduP+pi6Bnd+S/cWFMmKAsD6t/ZFr1ymYTaEx1UGqGNGgRS0EMOIFUGW+yGG2nu7UyMdt8ILTWwSfe8sjFosNv5lkitdM9WEsb76cm2rTXuUlljPGGEdzc0yH8ktFbN0szGrK8EnLxg1IBR9+SCAtpTgd4thFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZXfA8mE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF1BC4CEF8;
	Thu, 27 Nov 2025 13:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764251734;
	bh=TcKH1vXA+ppYg8yS7msBkSh0m73ZkK2EUiEzp8q2wOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nZXfA8mEVSZg0MXz7Ry/l2z25Me2LYR+vhqlc0D8IVSEkbPBm7nIEecBLNfdSFaug
	 GC7swFDlkGYDqR200a3ZORdqjUhJda40BdtdcnmBOh4XJ1C2Di0v7l1blBkTJ7DkvT
	 BtMekr+SWmMklCzP1vdq2wVZDz3QVJ4iBdFHuyoIVZhFopp1WekYJrVwV2BtOUVOyd
	 elokYN/ggT333PUYcxAAec48HILk0QC4vetqoCQCMPINWRDgk3P0LYuXq9x7iKtiNP
	 6viEFbjutdyb2rmXLmino2R5GVE4mOknam4L9+ST7nZwlsA0OZ8oHFDNPp62OjucSw
	 RpFlaMr7xfNTw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: ross.philipson@oracle.com,
	Jonathan McDowell <noodles@earth.li>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 08/11] KEYS: trusted: Open code tpm2_buf_append()
Date: Thu, 27 Nov 2025 15:54:40 +0200
Message-ID: <20251127135445.2141241-9-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251127135445.2141241-1-jarkko@kernel.org>
References: <20251127135445.2141241-1-jarkko@kernel.org>
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
v6:
- No changes.
v5:
- No changes.
v4:
- No changes.
v3:
- No changes.
v2:
- No changes.
---
 security/keys/trusted-keys/trusted_tpm2.c | 51 ++++-------------------
 1 file changed, 9 insertions(+), 42 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 367bcfb59c4d..b1e2e1542ba2 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -188,36 +188,6 @@ int tpm2_key_priv(void *context, size_t hdrlen,
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
@@ -492,19 +462,16 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
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


