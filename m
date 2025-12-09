Return-Path: <linux-integrity+bounces-7859-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53834CAF195
	for <lists+linux-integrity@lfdr.de>; Tue, 09 Dec 2025 08:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 63271301AA65
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Dec 2025 07:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DB5265632;
	Tue,  9 Dec 2025 07:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ni7iYYOh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819B724887E;
	Tue,  9 Dec 2025 07:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765264317; cv=none; b=V/PrZ5eS1aQ+3oVPxhhRxWRHXQxCXG0ssmSHcNJBFe+ZbXpsoreHPYJ9234BjMVfbcqxbsviYd9vV8cs5WjMEBJ6OLOGVWVaQun5zIOPp9nP6wNNU3Ue34C+vwB6I/wqedJwV/76dVgJwySKbIABE7O5cLRFnSX7L08Rrj5o07k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765264317; c=relaxed/simple;
	bh=S4s6ghR336Logc+0QenWlbuBA4pwApYxxVR8R9Glv7E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hmooUgqsuTsEmvdWoi9PUbgsmS4ncTnOqRDkbohOwwID821xHvMZs1lf2mf2SGkoFiV0dselxCKK6uL4Gb+D4Cs58+X6nL+0wcKLveEjPsDd++EUL+DQ7rCwUZYMvdzZno8NL52oeMe51REO0dtwJ/Dp08t1qFLllVzgjjLaxJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ni7iYYOh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C63EC4CEF5;
	Tue,  9 Dec 2025 07:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765264317;
	bh=S4s6ghR336Logc+0QenWlbuBA4pwApYxxVR8R9Glv7E=;
	h=From:To:Cc:Subject:Date:From;
	b=ni7iYYOhv+7a9x+RZade8mn9G6Vg81IFXYqf4IAQjv8TUfMs+wDKD4DPDMHWSwxoY
	 LW9wLk51r5lu6pihX04MjLXyNGaSSkbZA+4KHtjyLbJbfvRs7OeokarPmGJtBVIcmJ
	 Q5oIsIYueTeryBVAPvB5LsYpv/AHgUZiFqlPMfZxqKtJmRkboiUJMjxX10KGpcZopw
	 7Yvx0PLnBqTzie67ME4RT2TMF0eU7rVWZFp7P6qKkTmdzwMJKM0GOuzlGsl5+hKhiq
	 GkF39+XsdXDfOdEYfWxGBx3x0iSkb9ABPl/Pya6O5qDYc+nbmh8IVcjzTQCN3yQdsv
	 XYguf0zpVsLnQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org (open list:KEYS-TRUSTED),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] KEYS: trusted: Don't use 'buf->handles'
Date: Tue,  9 Dec 2025 09:11:43 +0200
Message-Id: <20251209071144.56893-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tpm2_unseal_trusted() deduces number of handles in run-time even tho the
expected value is known at compile time. Address the issue.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/trusted-keys/trusted_tpm2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 9074ae1a5896..e78061ee2d99 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -491,7 +491,7 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 		if (tpm2_chip_auth(chip)) {
 			tpm_buf_append_hmac_session(chip, buf, TPM2_SA_ENCRYPT, NULL, 0);
 		} else  {
-			offset = buf->handles * 4 + TPM_HEADER_SIZE;
+			offset = TPM_HEADER_SIZE + 2 * sizeof(u32);
 			head = (struct tpm_header *)buf->data;
 			if (tpm_buf_length(buf) == offset)
 				head->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
-- 
2.39.5


