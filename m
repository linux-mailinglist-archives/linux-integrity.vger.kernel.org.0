Return-Path: <linux-integrity+bounces-2461-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C408C932B
	for <lists+linux-integrity@lfdr.de>; Sun, 19 May 2024 02:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4EE01F21677
	for <lists+linux-integrity@lfdr.de>; Sun, 19 May 2024 00:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7601C2E;
	Sun, 19 May 2024 00:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYgqatHz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCB617BB4;
	Sun, 19 May 2024 00:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716078410; cv=none; b=SYv6GgtnvqtlGbKDjcva5TBN16e/XnUEcG3zwtgxETWM4kLI9K4cPc1y+ECW6VNuMlZ3Q6telDRzY9eLq61PP1NO1Ne7ZcPgv9q3h/Apmwz0Ug5QielFg4p7K+uRdnIhWJQdron4/npIWpA83WjsYQIgbKjQrHhRQisx7JDwK2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716078410; c=relaxed/simple;
	bh=tA41U9a2wJeaKnsli+rQ8ii0Z8V5FL/JPrU6bK6Nik0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ooz+4RB6qmNjDyn/IVuQAYDGlcvQboeiFDcxyKwbv8xpTqEsZTO5bY8MDHfVK9hWJV8K41vFdDxpHU+b6+Tl8EwBTU2QDHymotB3lABTGJCUaABMEZdjZJcs7CSTOGWvSClR3cBBG3Q3tHuJ1X1+Xnf2vzyD8GVVYCIZ13wsaGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYgqatHz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72F2C113CC;
	Sun, 19 May 2024 00:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716078410;
	bh=tA41U9a2wJeaKnsli+rQ8ii0Z8V5FL/JPrU6bK6Nik0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LYgqatHzz1WGjNvwpUpAVbnbC6B/NbjwS0MlenTbE2+xLJIgc0ueGxZys8RPOdghJ
	 tFJaozoUKGuicRSwMVwUIeVa3nQGYrwOuubRix9syo0imHO35dof6ooNYzLgQ50ANm
	 xo9AJQVjK3qRsLNmbXkYeFmAWMEcX8ZUWWm0G5Y3vbVE29shw4q5BeDItDgKrT26hn
	 enWAiyTwwsJ+FTUsxqN0CXK4KmZsmur8rUrrXBsn/9eBKQlanxkOUmQLhGocDzX/V7
	 7w6ngwcM53IsIn8v9gFgaRafW4hPsjI8NV6AKsO3+b/wC4CWhRU1lMKFmKGtY3yks5
	 GuzOeOrsQYcpg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	Andreas.Fuchs@infineon.com,
	James Prestwood <prestwoj@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	David Howells <dhowells@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-crypto@vger.kernel.org (open list:CRYPTO API),
	linux-kernel@vger.kernel.org (open list),
	stable@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH RFC v2 3/5] KEYS: trusted: Do not use WARN when encode fails
Date: Sun, 19 May 2024 03:25:38 +0300
Message-ID: <20240519002616.4432-4-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240519002616.4432-1-jarkko@kernel.org>
References: <20240519002616.4432-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When asn1_encode_sequence() fails, WARN is not the correct solution.

1. asn1_encode_sequence() is not an internal function (located
   in lib/asn1_encode.c).
2. Location is known, which makes the stack trace useless.
3. Results a crash if panic_on_warn is set.

It is also noteworthy that the use of WARN is undocumented, and it
should be avoided unless there is a carefully considered rationale to
use it.

Replace WARN with pr_err, and print the return value instead, which is
only useful piece of information.

Cc: stable@vger.kernel.org # v5.13+
Fixes: f2219745250f ("security: keys: trusted: use ASN.1 TPM2 key format for the blobs")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/trusted-keys/trusted_tpm2.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index dfeec06301ce..dbdd6a318b8b 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -38,6 +38,7 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 	u8 *end_work = scratch + SCRATCH_SIZE;
 	u8 *priv, *pub;
 	u16 priv_len, pub_len;
+	int ret;
 
 	priv_len = get_unaligned_be16(src) + 2;
 	priv = src;
@@ -79,8 +80,11 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 	work1 = payload->blob;
 	work1 = asn1_encode_sequence(work1, work1 + sizeof(payload->blob),
 				     scratch, work - scratch);
-	if (WARN(IS_ERR(work1), "BUG: ASN.1 encoder failed"))
-		return PTR_ERR(work1);
+	if (IS_ERR(work1)) {
+		ret = PTR_ERR(work1);
+		pr_err("ASN.1 encode error %d\n", ret);
+		return ret;
+	}
 
 	return work1 - payload->blob;
 }
-- 
2.45.1


