Return-Path: <linux-integrity+bounces-2683-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 324028D26E6
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2024 23:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF7F8B2C417
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2024 21:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2321802BA;
	Tue, 28 May 2024 21:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmkhGx7V"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4874B17F36D;
	Tue, 28 May 2024 21:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716930518; cv=none; b=AzcfZdW+v+cvreEDCqMOLCJlltOKQdpcDnu9JqrJYwI+pmf+zeRN34jcUMSVkS+1ijyfnNhrU/qlQ8jt2xhRM/JfJ364Omhg3l+2XEQJgmciCS/2Lp5HxaGrqBmuPg7JiZ6QsA+SRTtI6KI/KztzzB+ihJrVRwMwjiB3OruIFuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716930518; c=relaxed/simple;
	bh=h8orBF4zzRfW1mNSKt+5IoMKfbFfiHan4PWjJTDQxIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pL+5cP6ssRZMGIXlXJIkIsD+1g2DKGAwURuGEs/3PQv3E5yZJfm34SwenzZZJ9wCkwebXmBtbNGDkzFjKEvzl03VFJHXGuAmrGo4dEwGxcdvII+2aWgk6m6RtdEYzU41gn67quSFvtpAjz+LcZwY0LU0uUgq0tTX2hgxuDZynck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmkhGx7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF93EC32786;
	Tue, 28 May 2024 21:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716930518;
	bh=h8orBF4zzRfW1mNSKt+5IoMKfbFfiHan4PWjJTDQxIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PmkhGx7V8i6zLjttIWkdl+8o0Y5vSXsPkxD8AI5uBF0zi8KAAMZG+viURTxW6P/fa
	 l3Ftx2zJfbVW6E0/rlu5cceP7gYnl9mYX3QZF8MZICsw9z4SOLoGWqARBJvPnUtOJn
	 rXM1sgkXv/IuMaSIgX3jYcPWpHZgQ4bFarvPb/eYJf3s2om5AczldRaBVNJ8s7Mtum
	 86SAbCDdpNJuZ40qpo4aUCiIqt9lfEmXU1FA0HJlgJkq/O6JpSje82xJjagHnLMebc
	 kW+MZaYaIftO4Cd8UuadqVDEyE4lnR4fZgFCsv5UQuvtn92uXtyCwxsSZxJUZaPmq7
	 WOakhQOBYGmxA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	Andreas.Fuchs@infineon.com,
	James Prestwood <prestwoj@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biggers <ebiggers@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-crypto@vger.kernel.org,
	Stefan Berger <stefanb@linux.ibm.com>,
	Lennart Poettering <lennart@poettering.net>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org (open list),
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v7 2/5] KEYS: trusted: Change -EINVAL to -E2BIG
Date: Wed, 29 May 2024 00:08:07 +0300
Message-ID: <20240528210823.28798-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528210823.28798-1-jarkko@kernel.org>
References: <20240528210823.28798-1-jarkko@kernel.org>
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


