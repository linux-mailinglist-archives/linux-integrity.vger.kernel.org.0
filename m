Return-Path: <linux-integrity+bounces-6756-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F01D6B17879
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Jul 2025 23:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABFB15A3918
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Jul 2025 21:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACDF2690D9;
	Thu, 31 Jul 2025 21:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgoCFLKq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6DF2586C2;
	Thu, 31 Jul 2025 21:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753998844; cv=none; b=GAgSXTPeW4Cpe3JdXzBiKRXDPjzBH4AVkeJpHUKGNcuWDZSysCpNScTP0A8hXJa5e/olDmtviMFNgGHwFQ/Q282HG6Phv2eUnEj2PLRqwTNgu+qW5zbHCcO32WPMXhZFggx+fdTtMfkQ5e8DUURrP9Dr3E4DNk/4KXucRUD9V/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753998844; c=relaxed/simple;
	bh=mqPumVqdioNdsUjPC0EYQ3RlGqcjrunkflhnOEy0xsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Seq+Z67yyXgSe4X5tbhdLnkgYQeCVPmbB+Z2l3cZ0l4sL2/jEhRvn+BPu+My5w8xWRRxEg0VLVVJuCx1AU79w86+HF/cneL8UFM5R4iHKFm4nZZUmDfKS/QKADPvwouinlN6f2hkszNMzNc6I2S8b1PXj6CgaA+vVeVc7bVEFoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgoCFLKq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9203CC4CEF4;
	Thu, 31 Jul 2025 21:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753998843;
	bh=mqPumVqdioNdsUjPC0EYQ3RlGqcjrunkflhnOEy0xsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IgoCFLKqad8gK5oAo+pxxbi7Crn6SSVAxaBH+TustdmMtmK60H7MU3pG9dvm+2Poi
	 FRFEcaMrT2ippZzNmq+SpMr0BaPwpirdHX1CWHf8gCpthxny8C34RsRqpCLHXlx+QO
	 tnSv9zKxFeF+mkoipEXunYiJP/JCrLMwVYnXYr/lqf9qETw7g4uQCbkFfSyjb5EVYx
	 Qp2L7YR37Lsr3g5ZDUiHhIYsr7VppIJtYMVCubaK8NqAkfpc1vRWP3/V2mLLA+j86b
	 wdMqpgXNvPlF33slhE/6iaHZ+3jXFHXhH9noFoW3OodmIC/WR1A200KcMKOqOl9Yoj
	 zt9vRILq2QSAg==
From: Eric Biggers <ebiggers@kernel.org>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] tpm: Compare HMAC values in constant time
Date: Thu, 31 Jul 2025 14:52:54 -0700
Message-ID: <20250731215255.113897-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250731215255.113897-1-ebiggers@kernel.org>
References: <20250731215255.113897-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prevent timing attacks, HMAC value comparison needs to be constant
time.  Replace the memcmp() with the correct function, crypto_memneq().

Fixes: 1085b8276bb4 ("tpm: Add the rest of the session HMAC API")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 drivers/char/tpm/Kconfig         | 1 +
 drivers/char/tpm/tpm2-sessions.c | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index dddd702b2454a..f9d8a4e966867 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -31,10 +31,11 @@ config TCG_TPM2_HMAC
 	bool "Use HMAC and encrypted transactions on the TPM bus"
 	default X86_64
 	select CRYPTO_ECDH
 	select CRYPTO_LIB_AESCFB
 	select CRYPTO_LIB_SHA256
+	select CRYPTO_LIB_UTILS
 	help
 	  Setting this causes us to deploy a scheme which uses request
 	  and response HMACs in addition to encryption for
 	  communicating with the TPM to prevent or detect bus snooping
 	  and interposer attacks (see tpm-security.rst).  Saying Y
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index bdb119453dfbe..5fbd62ee50903 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -69,10 +69,11 @@
 #include <linux/unaligned.h>
 #include <crypto/kpp.h>
 #include <crypto/ecdh.h>
 #include <crypto/hash.h>
 #include <crypto/hmac.h>
+#include <crypto/utils.h>
 
 /* maximum number of names the TPM must remember for authorization */
 #define AUTH_MAX_NAMES	3
 
 #define AES_KEY_BYTES	AES_KEYSIZE_128
@@ -827,16 +828,15 @@ int tpm_buf_check_hmac_response(struct tpm_chip *chip, struct tpm_buf *buf,
 	sha256_update(&sctx, auth->our_nonce, sizeof(auth->our_nonce));
 	sha256_update(&sctx, &auth->attrs, 1);
 	/* we're done with the rphash, so put our idea of the hmac there */
 	tpm2_hmac_final(&sctx, auth->session_key, sizeof(auth->session_key)
 			+ auth->passphrase_len, rphash);
-	if (memcmp(rphash, &buf->data[offset_s], SHA256_DIGEST_SIZE) == 0) {
-		rc = 0;
-	} else {
+	if (crypto_memneq(rphash, &buf->data[offset_s], SHA256_DIGEST_SIZE)) {
 		dev_err(&chip->dev, "TPM: HMAC check failed\n");
 		goto out;
 	}
+	rc = 0;
 
 	/* now do response decryption */
 	if (auth->attrs & TPM2_SA_ENCRYPT) {
 		/* need key and IV */
 		tpm2_KDFa(auth->session_key, SHA256_DIGEST_SIZE
-- 
2.50.1


