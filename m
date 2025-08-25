Return-Path: <linux-integrity+bounces-6908-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27946B34C11
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Aug 2025 22:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FED31B22C8F
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Aug 2025 20:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33071F419B;
	Mon, 25 Aug 2025 20:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPaV73yP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D870393DE3;
	Mon, 25 Aug 2025 20:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756153955; cv=none; b=oTrBiaD/S+uUkceq7FvW3EYC6CAIsx7kntty8US2bYt5SFmjTK7lJkwSzZaGMXaPRaCCRWbcQw5ujo1iMY7hD1vm+rCyFzXJ8Lmr/lZf6c9ZvMaqTw3Cnee/C8ZHBNNm7XqIe07Hbc2a4GZV/rkqZVPXjXKD+xf248AD//KQB8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756153955; c=relaxed/simple;
	bh=Ucxf6ONPWnqwGHzIJMurAJvEDHnfQwUW0d4rP7PrkbM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XxoR0kLYzkUaKXShkg51LmlTQ5vOUDAgLh+ggCxbH7rYxUt64xX44j0dOmq6hq4GXRRZyiL5KvCdoB4UecekmqTjW4W4SE8f4ojqaonc0jKqNBSVF/XTe1enkZesl7ssvsFaNqQNrQ53IdyVdv62vC7k6faWyB4a45YhWdpinG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPaV73yP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CECC4CEED;
	Mon, 25 Aug 2025 20:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756153955;
	bh=Ucxf6ONPWnqwGHzIJMurAJvEDHnfQwUW0d4rP7PrkbM=;
	h=From:To:Cc:Subject:Date:From;
	b=CPaV73yPqybMX1kBLGC5zIfe9FgKTCfYnlJ2he/y1tEcHv/LnPkByU9PHTS2778hK
	 2u9QSDSDZXr0BUtNzxXgXEPf7mFGH9J3LB2sKrdgzbLFQWQggoxkf2ZoBQ1AGx4tW/
	 5PtwmsoZ3fiE3ZCgSAaTukTvZy7xic1CP332tZN54pIhT5T5varuG6pIQvizU8rdaW
	 rNHdquu/K0tTeymVtwnBYp/43CJyr2V1CbFcFXzGlisxY7KKa4YwjPl8jrkLj8ToRw
	 n8oSKQlh+4hv4l2Hh2FzD4r9AG7l4uHk5kZHE+8G60UzSiXC0cvRVIuCGKtOIUrhML
	 mQM9ltQUDsP5Q==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.or,
	Chris Fenner <cfenn@google.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH] tpm: Disable TPM2_TCG_HMAC by default
Date: Mon, 25 Aug 2025 23:32:23 +0300
Message-Id: <20250825203223.629515-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After reading all the feedback, right now disabling the TPM2_TCG_HMAC
is the right call.

Other views discussed:

A. Having a kernel command-line parameter or refining the feature
   otherwise. This goes to the area of improvements.  E.g., one
   example is my own idea where the null key specific code would be
   replaced with a persistent handle parameter (which can be
   *unambigously* defined as part of attestation process when
   done correctly).

B. Removing the code. I don't buy this because that is same as saying
   that HMAC encryption cannot work at all (if really nitpicking) in
   any form. Also I disagree on the view that the feature could not
   be refined to something more reasoable.

Also, both A and B are worst options in terms of backporting.

Thuss, this is the best possible choice.

Cc: stable@vger.kernel.or # v6.10+
Fixes: d2add27cf2b8 ("tpm: Add NULL primary creation")
Suggested-by: Chris Fenner <cfenn@google.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
PS. I did not post this last week because that would have been most
likely the most counter-productive action to taken. It's better
sometimes to take a bit of time to think (which can be seen that
I've given also more reasonable weight to my own eaerlier
proposals).

I also accept further changes, if there is e.g., inconsistency
with TCG_TPM_HMAC setting or similar (obviously).
---
 drivers/char/tpm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index dddd702b2454..3e4684f6b4af 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -29,7 +29,7 @@ if TCG_TPM
 
 config TCG_TPM2_HMAC
 	bool "Use HMAC and encrypted transactions on the TPM bus"
-	default X86_64
+	default n
 	select CRYPTO_ECDH
 	select CRYPTO_LIB_AESCFB
 	select CRYPTO_LIB_SHA256
-- 
2.39.5


