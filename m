Return-Path: <linux-integrity+bounces-2485-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3A58CA292
	for <lists+linux-integrity@lfdr.de>; Mon, 20 May 2024 21:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69F04B22517
	for <lists+linux-integrity@lfdr.de>; Mon, 20 May 2024 19:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5B91386A5;
	Mon, 20 May 2024 19:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hul6fYn5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181B71384B4;
	Mon, 20 May 2024 19:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716231911; cv=none; b=TWQWxhbnM4K+Kw5JLnqNHDrZ2RmmYlROZ+jgs04FxNUfhwolx4meyd1gqKJq3w2BrCsCU7mGoszAQUbPYZhTtVZaafCqw2tV3i5bwoSWNb7jUMZRBeEakFj1cXiHUHfp14Z5bkfHAAGWC/aHCRSizz52L8Spwi6Y+d+efgtpwG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716231911; c=relaxed/simple;
	bh=zjmdVHD9xhS/1n4Rw9BcJgcMBhyRpG01mLSj2X8CQ7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DACh722hwMt1Qba2CwITo/wQ4m1YbjNoAGvm9KX62TdDi7SfAJ+Ic8Ldlw4IYyaPoRhwm4WsUpS2TGIWm/NaJrfv6s0n9XmolL3wUhYTIWx3jcLcUsV9GLfBItC07xkW58T0ORKLJ5DCQO55cVq4ya3VoNWnKZtKVTHU0Kc8IMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hul6fYn5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F785C32789;
	Mon, 20 May 2024 19:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716231909;
	bh=zjmdVHD9xhS/1n4Rw9BcJgcMBhyRpG01mLSj2X8CQ7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hul6fYn5E545RYZ9SafZ8CkXb8YK3/NkkOuRfr8u2cDjYHv4KwrJu6SFGSvPg89nB
	 Bdk4wkW64saAU+3uKZTpEDwliB7YmxnK2GBAgIKHe2dUR9TwVTgH+/g+GO6t6w0tn4
	 n03rOTvygXO1ibMNZuguBywXjf+EiFAZsXnqO9eUw65LWvea0tRIggZ8NyKMzV0wps
	 OtokmA8nOLpJIoGgOtPsdLWg1EdfJqlFXXJAVeplyFvr95kMzcrD4goFYyHKYE9QH6
	 VJIb2VYxcadqkGyDiYRLkFTXr/YCVaLrCt7BkuZ6uNZ4/l8oUk/Wn362Gcf2rXt5h0
	 NHLGKTLvU54zg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org,
	James.Bottomley@HansenPartnership.com,
	Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] KEYS: trusted: Do not use WARN when encode fails
Date: Mon, 20 May 2024 22:04:53 +0300
Message-ID: <20240520190454.28745-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240520190454.28745-1-jarkko@kernel.org>
References: <20240520190454.28745-1-jarkko@kernel.org>
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
 security/keys/trusted-keys/trusted_tpm2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index c6882f5d094f..8b7dd73d94c1 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -84,8 +84,9 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 	work1 = payload->blob;
 	work1 = asn1_encode_sequence(work1, work1 + sizeof(payload->blob),
 				     scratch, work - scratch);
-	if (WARN(IS_ERR(work1), "BUG: ASN.1 encoder failed")) {
+	if (IS_ERR(work1)) {
 		ret = PTR_ERR(work1);
+		pr_err("BUG: ASN.1 encoder failed with %d\n", ret);
 		goto err;
 	}
 
-- 
2.45.1


