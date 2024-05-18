Return-Path: <linux-integrity+bounces-2455-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2A88C9286
	for <lists+linux-integrity@lfdr.de>; Sat, 18 May 2024 23:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28C171C2081B
	for <lists+linux-integrity@lfdr.de>; Sat, 18 May 2024 21:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163C96D1CC;
	Sat, 18 May 2024 21:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ed+nA6ka"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCA56CDC8;
	Sat, 18 May 2024 21:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716068250; cv=none; b=kWHM6l8JsCpNCZXEJrcs5aFTrolPT6OVSeS5JiGFYL+j+IVKtpgJeLo+FaWaT9+nEEOUg46slHDhjlQvBfdI8hJjjoxxCIRsw+oiuwShWDui1lZlDX6gxW41u6WHwktNuqdbpml7EOV4FzrUAhS2qTeGCkNR9iKUuWKtfsXiBbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716068250; c=relaxed/simple;
	bh=tA41U9a2wJeaKnsli+rQ8ii0Z8V5FL/JPrU6bK6Nik0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KwiOah7lL+fXq5tiVqmppfXx9eOlxIbSvqsZanoxv92nB8Iro+s7MCgbxmyTkYGheY6t5W7g6S+yTJ5b628qjlmbU4NZAw8zq5HePIIvlqErTl6VH1JTkbek/WwLpFySZABzXbsi0PKQ18DtdjaIc9a3hzdL3MSR55JYtrm4VvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ed+nA6ka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172B0C113CC;
	Sat, 18 May 2024 21:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716068249;
	bh=tA41U9a2wJeaKnsli+rQ8ii0Z8V5FL/JPrU6bK6Nik0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ed+nA6karKcB1mIgDVAhFBBO0U0GV0RiNJn9faBv9vR9wtVAbUetdW90GPR9guC/z
	 GUhJ3gJHRP4MvyroDIgA8cSML9SJ4X0iO9bTc1Ys0QJbXlFn3xgMeUYcRdCcsRgcY1
	 zuXCuB0kd9/B1UZq7pTdpegek1Aq+z6cmx8twpK1oBd9ydTWsqzSUX7OkFbXicWTom
	 S0cCTpIQqeSs121rSkOwVYzO8iQyrvVQR3JKMDBs5demkfjH/mKGgyd6aylpI89Sgv
	 +WkeKvQCSY+jVn3J6xS+YgawI0ReLuDcvk3q3w0Y/s75xpTvHr+Hg+S/fronCo9NMK
	 lsl7nPmiJN5Ng==
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
Subject: [PATCH RFC 3/5] KEYS: trusted: Do not use WARN when encode fails
Date: Sun, 19 May 2024 00:36:23 +0300
Message-ID: <20240518213700.5960-4-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240518213700.5960-1-jarkko@kernel.org>
References: <20240518213700.5960-1-jarkko@kernel.org>
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


