Return-Path: <linux-integrity+bounces-6752-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15059B17815
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Jul 2025 23:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36BA71784A7
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Jul 2025 21:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8572C265CCB;
	Thu, 31 Jul 2025 21:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8Hb6FUM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517EF26529E;
	Thu, 31 Jul 2025 21:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753997048; cv=none; b=i+ZhOtcIqPEEy4ayFb4vxC77i9GHITNV/f7XDBBUYvk5psow4bwzYsrcqmRgj4mi1WaIekxn8I8k+B/gTjqRTMV1FJveqPbNF6Mp86izdRjJ1PBpB/9SSHxYyRI9UJYq0YCEEcGH0l7zSE5bf7+MKCB86lWXEmE3weiM++LbiqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753997048; c=relaxed/simple;
	bh=10xZrZKLy96+1t62WkYqn4As03OohTGiwGgJNIB8B4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tpi2Etus8SPb9jAYcAmk+6NfTV5JYdgKHUyJZK8b8kL+uRkY/IPeuvMSosS48WdxAkoNKLdFMSAv9b0+WE777/eF/57Jvhq5/k9pQ7Sr3/fHMRWoHrE+sLJe+qIPMQDkUShNf2LHhPXTlISMwCYxh5fRlgUNkmzxhwRXa2X81Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8Hb6FUM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72022C4CEF4;
	Thu, 31 Jul 2025 21:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753997047;
	bh=10xZrZKLy96+1t62WkYqn4As03OohTGiwGgJNIB8B4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k8Hb6FUMjgP21mHoTL9VejxjZU0DhmEzyG7xb5xkrOzrpPJoJFhQkVAcV/pUQtBgE
	 AU7VIRfGRvymEPjZxNAB1cv4g/Bw1NMuvdLQ9yp/vLS+soFkgE7DsZ5JNO/uTfV0Yy
	 vP80KVJvGB6E6gkk31AElo1emKRo56Y5+aPxLLzAOgG8uo+xTFaQsuWrTqyTQi9XE4
	 Q/y3PrcdZPvvTTAohvY3uJPMpOhdInb3UQfc4X5unCcpPTD6vJ95xow6aRJGt0/PY5
	 iFTNvhBE5sJvHydLEWKK9ESeeiTEx3KMZMYBoFgbkxCLn/YMvPXHYQjcG5vdHERODq
	 Yo6DD5f+TQOgQ==
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
Subject: [PATCH 1/3] KEYS: trusted_tpm1: Compare HMAC values in constant time
Date: Thu, 31 Jul 2025 14:23:52 -0700
Message-ID: <20250731212354.105044-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250731212354.105044-1-ebiggers@kernel.org>
References: <20250731212354.105044-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prevent timing attacks, HMAC value comparison needs to be constant
time.  Replace the memcmp() with the correct function, crypto_memneq().

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

base-commit: d6084bb815c453de27af8071a23163a711586a6c
-- 
2.50.1


