Return-Path: <linux-integrity+bounces-2469-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EDB8C977A
	for <lists+linux-integrity@lfdr.de>; Mon, 20 May 2024 01:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EDAB1F211E1
	for <lists+linux-integrity@lfdr.de>; Sun, 19 May 2024 23:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0878C757F6;
	Sun, 19 May 2024 23:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3Lb2162"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC327319C;
	Sun, 19 May 2024 23:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716162700; cv=none; b=rXaSUy07TWHam0tr6IUN+EmA4/qsLcPeKbIcX8Wlla3IR1G5yiTg/3JOixhbx+8dYo0vhG52KCmeMhRgifRbj3LFNr1ovqnwk4b70pVvPLGUSahLUAAlEtttxFfBWKclHV6sNSmISgJ0PbdXp9keKUWTeffUPtulAkuXUVhzJw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716162700; c=relaxed/simple;
	bh=zjmdVHD9xhS/1n4Rw9BcJgcMBhyRpG01mLSj2X8CQ7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AfkvPHxlCk0ASx4yH5WlbhBbvG0mRmuNyVKUWj+kYfj397+xuxcf4usYAuFhdL8duhSOZPU8g4bbpJNCXTr/fG4Hc+E19ZQIurtpZcZhLTdlESO9RBiAqT6IZQIxAjRCGBQcFJDExksnDqAQKocPztbLpZIshdnwaBLm60GUfb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3Lb2162; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E683C32781;
	Sun, 19 May 2024 23:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716162700;
	bh=zjmdVHD9xhS/1n4Rw9BcJgcMBhyRpG01mLSj2X8CQ7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l3Lb2162/JhmAcr52fdxBYIVFT0E0WJqupbELbdF7J/L+4DQ1f/B9o3012H8g6c9w
	 wmzLSzMjwFDWWSduTDLjbgXWQPATveMALp4SZS9CoGD5KKynYXO/5RZjc+oUw0tcJM
	 +qGBxmFCEoN0bV8fdKxLceFd634RgcK8cxUhrZsNjLUp75m+NkuCJ0FLQQfT++0Rqd
	 owCILHuxNo0OQIyE+FPI+Rp7j5sW2ox4LFyHkMopYAkFIfvMCHQ4WyuJD5/pVsYROf
	 xOSU455i/+We96q/x+a2PtLZdZC98DgKk+zaqCjCZ/abHOJQLVG7XVHGGFs3FABQHe
	 Y9tJ0LMP5TeCw==
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
Subject: [PATCH 3/3] KEYS: trusted: Do not use WARN when encode fails
Date: Mon, 20 May 2024 02:51:21 +0300
Message-ID: <20240519235122.3380-4-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240519235122.3380-1-jarkko@kernel.org>
References: <20240519235122.3380-1-jarkko@kernel.org>
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


