Return-Path: <linux-integrity+bounces-2383-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B5A8C4A91
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 02:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59FB8B218C5
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 00:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31607EC5;
	Tue, 14 May 2024 00:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8wmgnmY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AD480B;
	Tue, 14 May 2024 00:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715647699; cv=none; b=QM8RLQUUL8J7WOkWRdLy1/JViwSDe1HX0XpbbDeNblnjyChmOBwjOAOy2wh8QbGAxlMv6beox/kMOmEoQcYflkQwDgozS0LSy6hwC25c8vhmKZk6mYr/+h4jhl7xiOVZf398ofiDECqT+DEOsAfJouiABUVa46HXRvu5SnfongE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715647699; c=relaxed/simple;
	bh=NvwhydFzvnCR2FLY56Y19UMPqpBXTv0snNN2JgKkl10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rEqoXpx/xVVPXKgJfw1MBL3AwP0eAZAGQrhfMbFWzl4QiFLXYu9zpCDPAA/AYg9olYinnOmQHl5h7foQhSktBcSJsTlaGNVaOV2h7rX+AW5bZ05iTSfZME5nwj4ZkEx760qqfkEsqglzewAtaVLLnt0faY3Fb0KRgwrjyvGmXXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8wmgnmY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033CDC113CC;
	Tue, 14 May 2024 00:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715647698;
	bh=NvwhydFzvnCR2FLY56Y19UMPqpBXTv0snNN2JgKkl10=;
	h=From:To:Cc:Subject:Date:From;
	b=S8wmgnmYjHmWGfw/F1UO9Q5/amk6LiFoo7hIbhPcCsqO+Fvgg2Sf/XjqbJZ23++VY
	 rPmY4fFujv7r67cArqlSlIgO98fh0mZRPab7Z3KfZfBSaQNCvLH0r6QCLO6rrB0lEg
	 Naq1qGhxp4+xBQ5BAne5t7fBSLs6Adn1wZsHiXa3phjVsDBTi72ZgskxU68AJqmeNC
	 v7WBrLTbzgKwbDwgMZUoJ2WFoE/Fuy2iZaObk5P4GwzYhl7U2Oafui631mfe5XypXN
	 TEzEzmpTCc5+7io9CAzleQR3qYijuBOP3NJoWdLf40p6Rs+n3E3/ssbOqMorSlyJnT
	 gk3h8cMKvbH8g==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org (open list:KEYS-TRUSTED),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] KEYS: trusted: Do not use WARN when encode fails
Date: Tue, 14 May 2024 03:47:59 +0300
Message-ID: <20240514004759.6625-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.0
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
v2: Fix typos in the commit message
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
2.45.0


