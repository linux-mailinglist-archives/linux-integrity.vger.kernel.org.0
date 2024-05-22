Return-Path: <linux-integrity+bounces-2540-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 329658CB6E0
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 02:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603451C21065
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 00:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9D017F3;
	Wed, 22 May 2024 00:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvjiXq3w"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9CDDDBD;
	Wed, 22 May 2024 00:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339191; cv=none; b=YVV37vRR1xlERXgLsKpf/eybADxQeIp9wbaPO9XKZEujypHpfHRDI+QYtxLfaMc3h6SOO0MvKWv9SWhkR5EVj6M/l/RLzD02S/9Yoh2HEL5utN+/UljQzpwq55+oML2hz4BT7Aj2ImGLVvUxmxhOuUQYXigWvBlnvmNtk5JTERY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339191; c=relaxed/simple;
	bh=h8orBF4zzRfW1mNSKt+5IoMKfbFfiHan4PWjJTDQxIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LaXTgtbjGGc8Im5H4PJXJGxHoRrOg1zIF8iPbKsXoIRoxWY1uhn3zubNXl8+kmC+bp2qtzZCm1rSXOwvrbXF8BNdTmohQvEJNs2PE1+BzphyUqQvRwB1j4cbUdxO98diRxBfZ2adQlGJv/i3TumDxlnh+MvbMNoEcsg6C+wEgsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvjiXq3w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671E5C32786;
	Wed, 22 May 2024 00:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716339190;
	bh=h8orBF4zzRfW1mNSKt+5IoMKfbFfiHan4PWjJTDQxIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jvjiXq3wwfpzOG8HbOVG43V3jWYQ3L7M9WOAz1QtWgCqZFj1HawzEuVZsGM40z/r5
	 32qNBPMnk58nZZCk7Fv2lKDLQLtZNXIyKNL7ErtE69fYBgsLf4P+J+MxfP91CESdfK
	 H/PLRgxH2y0IN1Pb9ANisnBOla5PlXG6B3PiRTib1HwXniB1mAZvDnXBHVBeBJwqhM
	 qD5CLzAy0dE6Y/YhZ1hrwyfynLToeikMNW1aARah1tFMxLencZR35+qQuCQRMsph6O
	 u+RuKIQNvTkrNPpnpoVPRbScwcLntRB3zbVXVXSYbXPKaUu+zGSBuUjZ+vUyUkO4HZ
	 t59L+V1vvuFAw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	Andreas.Fuchs@infineon.com,
	James Prestwood <prestwoj@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biggers <ebiggers@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org (open list:CRYPTO API),
	linux-kernel@vger.kernel.org (open list),
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v4 2/5] KEYS: trusted: Change -EINVAL to -E2BIG
Date: Wed, 22 May 2024 03:52:40 +0300
Message-ID: <20240522005252.17841-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240522005252.17841-1-jarkko@kernel.org>
References: <20240522005252.17841-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Report -E2BIG instead of -EINVAL when too large size for the key blob is
requested.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/trusted-keys/trusted_tpm2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 8b7dd73d94c1..06c8fa7b21ae 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -122,7 +122,7 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
 		return ret;
 
 	if (ctx.priv_len + ctx.pub_len > MAX_BLOB_SIZE)
-		return -EINVAL;
+		return -E2BIG;
 
 	blob = kmalloc(ctx.priv_len + ctx.pub_len + 4, GFP_KERNEL);
 	if (!blob)
-- 
2.45.1


