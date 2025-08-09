Return-Path: <linux-integrity+bounces-6793-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E074AB1F591
	for <lists+linux-integrity@lfdr.de>; Sat,  9 Aug 2025 19:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C866561A69
	for <lists+linux-integrity@lfdr.de>; Sat,  9 Aug 2025 17:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C65E2BEC3A;
	Sat,  9 Aug 2025 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfYC63TP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D412BE02B;
	Sat,  9 Aug 2025 17:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754760002; cv=none; b=AY4dw/NI4tjRSdXux8BaHUwRBF2/3SQ8lyqhm8tQ1+Uogqx11ijzp9ZPe3s8HSIukIv0EZOTx+3Loj2XD9iqf03hI1ZD3pr+pU0bnSSHkq6/8odcQh30TFk2lfiI5jO3rN5bVTFZP0eXpcHNGxV7HU71D7AQwq3V0O7c7vEWfsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754760002; c=relaxed/simple;
	bh=p4VgDCfNWSwQmiD28FtKXM90bkB1udf6+XynMyDdr6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CqEJ8Emst99ysGhIsOhR3vgTDY118Dk22KkXudGQIJI2kLB/apukfIYGWFzSlf0JI4qadHM/3ebT1NEFGlnbEIo2vt3Tq7l1fqSN/hQwX7MBri30nAXtRx7yGiOakJRQblf3x/GjB6eMq/cOXeMreR1E2HTqukIjo7T+nUGdBsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfYC63TP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C7AC4CEF8;
	Sat,  9 Aug 2025 17:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754760001;
	bh=p4VgDCfNWSwQmiD28FtKXM90bkB1udf6+XynMyDdr6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CfYC63TP5BjHYMCPX8V7fJF6xx+RVIMDuEm0ItZv5xU9MPTjUwgm2AOhCJ5d7RFBp
	 Nx/wMKtaN4jWGzpsRFp7ZrxDM6vjFwl5PXUHpsv+Iuff7S8yWLRSJ2vYoOBWuVfmY+
	 FOxEf4uOOzJaKX00+wohpogDJYA0ygBg6Y/oxpAEXiaZmyyS7avHzBJbm9+vpOKpPS
	 A3Rt+eECoHhVyE22npWrIyXNLspewgl4ZpN7lHedeUtJlcR9PgPE57RDjU2Mb/kI0f
	 2AORBgshDEQkOYDNZgmePWV1vU2nWV6c5MNBpi++i0MuG4IjYVNDYKTH6csi7LBnrk
	 FND7CKwnIwqfw==
From: Eric Biggers <ebiggers@kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	keyrings@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	linux-integrity@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] KEYS: trusted_tpm1: Compare HMAC values in constant time
Date: Sat,  9 Aug 2025 10:19:39 -0700
Message-ID: <20250809171941.5497-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250809171941.5497-1-ebiggers@kernel.org>
References: <20250809171941.5497-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prevent timing attacks, HMAC value comparison needs to be constant
time.  Replace the memcmp() with the correct function, crypto_memneq().

[For the Fixes commit I used the commit that introduced the memcmp().
It predates the introduction of crypto_memneq(), but it was still a bug
at the time even though a helper function didn't exist yet.]

Fixes: d00a1c72f7f4 ("keys: add new trusted key-type")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 security/keys/trusted-keys/trusted_tpm1.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 89c9798d18007..e73f2c6c817a0 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -5,10 +5,11 @@
  *
  * See Documentation/security/keys/trusted-encrypted.rst
  */
 
 #include <crypto/hash_info.h>
+#include <crypto/utils.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/parser.h>
 #include <linux/string.h>
 #include <linux/err.h>
@@ -239,11 +240,11 @@ int TSS_checkhmac1(unsigned char *buffer,
 			  TPM_NONCE_SIZE, enonce, TPM_NONCE_SIZE, ononce,
 			  1, continueflag, 0, 0);
 	if (ret < 0)
 		goto out;
 
-	if (memcmp(testhmac, authdata, SHA1_DIGEST_SIZE))
+	if (crypto_memneq(testhmac, authdata, SHA1_DIGEST_SIZE))
 		ret = -EINVAL;
 out:
 	kfree_sensitive(sdesc);
 	return ret;
 }
@@ -332,20 +333,20 @@ static int TSS_checkhmac2(unsigned char *buffer,
 	ret = TSS_rawhmac(testhmac1, key1, keylen1, SHA1_DIGEST_SIZE,
 			  paramdigest, TPM_NONCE_SIZE, enonce1,
 			  TPM_NONCE_SIZE, ononce, 1, continueflag1, 0, 0);
 	if (ret < 0)
 		goto out;
-	if (memcmp(testhmac1, authdata1, SHA1_DIGEST_SIZE)) {
+	if (crypto_memneq(testhmac1, authdata1, SHA1_DIGEST_SIZE)) {
 		ret = -EINVAL;
 		goto out;
 	}
 	ret = TSS_rawhmac(testhmac2, key2, keylen2, SHA1_DIGEST_SIZE,
 			  paramdigest, TPM_NONCE_SIZE, enonce2,
 			  TPM_NONCE_SIZE, ononce, 1, continueflag2, 0, 0);
 	if (ret < 0)
 		goto out;
-	if (memcmp(testhmac2, authdata2, SHA1_DIGEST_SIZE))
+	if (crypto_memneq(testhmac2, authdata2, SHA1_DIGEST_SIZE))
 		ret = -EINVAL;
 out:
 	kfree_sensitive(sdesc);
 	return ret;
 }
-- 
2.50.1


