Return-Path: <linux-integrity+bounces-8121-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFA3CCF2EB
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Dec 2025 10:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38113301A1C8
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Dec 2025 09:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A882EC0A7;
	Fri, 19 Dec 2025 09:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="iFK76hse"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDAE267B02;
	Fri, 19 Dec 2025 09:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766137387; cv=none; b=nw8z7/HMppwHUpDgvPdwSQJoTN4YAlA57vfB33c3STmYV/G+WrcDInpK43nhBvXkGKhks165hncQfcM/8aBKAN9mZ8j2smrkAvFFx7Z9qvXN5rBUgPT6EvvEc422iRsVMDY+ynNgddf+Vk5p/usDMAdBmYT+PFWE2o1KfTAFMx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766137387; c=relaxed/simple;
	bh=ONmLlQTHqkztKUuWEGL637w4QqLGg/4Idz77mIn2aM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wf6rdPBOHqnWpUMpgXNNLo6Ko5+B8pd6oJTFVBrucIfBIEZAzHx2a/7H5D5m71TxzTmDR2CIu74EormD8vuvpTCiOwB4vsmRcXZ7kNtI6wQh6ygGo5eORL056CPSJoNHf+uDRaDXgjifEsBhl6Chc570AYK1B+8FS6wptZLcM9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=iFK76hse; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=7NczBA1zduLJaNIycYErUiDNCKS4PEHfp/yNC1zVExQ=; b=iFK76hseK1WlCNKZeFwXHg32I8
	qXLo6MGVfyi0z6jBc5vtDaXVsRvBUig/IA4z043AeubAvXAUHJDtXlBxbDjzmDvAo9iZs2J8+4awU
	IDkGCH/vRuAHsxMezch5Pk7swCREqpnBvqtc40raqPUIDoMra/swfE4WtZU6zRWCFFltd5v3BQj5b
	8LpNgaFurm7kUHQ9QHkBe6P+AY7f8MQPCE5vQ/OZonWTX/rNnKIuZEOn4S8A2g+BS0uxo8bDIxaQi
	qmj/+kNvq+pkTnxDJH5kIF6/LjMmCQfKELC0COSA+bQZVP2maX4wAAHxBeGGnE0HUH1IE9HWeLcA6
	GlwfVUdQ==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1vWWgE-00EesW-1x;
	Fri, 19 Dec 2025 09:21:46 +0000
Date: Fri, 19 Dec 2025 09:21:46 +0000
From: Jonathan McDowell <noodles@earth.li>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 02/12] KEYS: trusted: Use get_random_bytes_wait()
 instead of tpm_get_random()
Message-ID: <aUUZKu2xaZvEdq-2@earth.li>
References: <20251216092147.2326606-1-jarkko@kernel.org>
 <20251216092147.2326606-3-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251216092147.2326606-3-jarkko@kernel.org>

On Tue, Dec 16, 2025 at 11:21:36AM +0200, Jarkko Sakkinen wrote:
>Substitute remaining tpm_get_random() calls in trusted_tpm1.c with
>get_random_bytes_wait() thus aligning random number generation for TPM 1.2
>with the removal of '.get_random' callback.

Had to double check we wouldn't end up not getting all the randomness we 
ask for, but get_random_bytes_wait does indeed DTRT.

Reviewed-by: Jonathan McDowell <noodles@meta.com>

>Cc: Eric Biggers <ebiggers@kernel.org>
>Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>---
> security/keys/trusted-keys/trusted_tpm1.c | 18 +++---------------
> 1 file changed, 3 insertions(+), 15 deletions(-)
>
>diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
>index 7ce7e31bcdfb..3d75bb6f9689 100644
>--- a/security/keys/trusted-keys/trusted_tpm1.c
>+++ b/security/keys/trusted-keys/trusted_tpm1.c
>@@ -371,13 +371,10 @@ static int osap(struct tpm_buf *tb, struct osapsess *s,
> 	unsigned char ononce[TPM_NONCE_SIZE];
> 	int ret;
>
>-	ret = tpm_get_random(chip, ononce, TPM_NONCE_SIZE);
>+	ret = get_random_bytes_wait(ononce, TPM_NONCE_SIZE);
> 	if (ret < 0)
> 		return ret;
>
>-	if (ret != TPM_NONCE_SIZE)
>-		return -EIO;
>-
> 	tpm_buf_reset(tb, TPM_TAG_RQU_COMMAND, TPM_ORD_OSAP);
> 	tpm_buf_append_u16(tb, type);
> 	tpm_buf_append_u32(tb, handle);
>@@ -464,15 +461,10 @@ static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
> 	memcpy(td->xorwork + SHA1_DIGEST_SIZE, sess.enonce, SHA1_DIGEST_SIZE);
> 	sha1(td->xorwork, SHA1_DIGEST_SIZE * 2, td->xorhash);
>
>-	ret = tpm_get_random(chip, td->nonceodd, TPM_NONCE_SIZE);
>+	ret = get_random_bytes_wait(td->nonceodd, TPM_NONCE_SIZE);
> 	if (ret < 0)
> 		goto out;
>
>-	if (ret != TPM_NONCE_SIZE) {
>-		ret = -EIO;
>-		goto out;
>-	}
>-
> 	ordinal = htonl(TPM_ORD_SEAL);
> 	datsize = htonl(datalen);
> 	pcrsize = htonl(pcrinfosize);
>@@ -575,14 +567,10 @@ static int tpm_unseal(struct tpm_buf *tb,
> 	}
>
> 	ordinal = htonl(TPM_ORD_UNSEAL);
>-	ret = tpm_get_random(chip, nonceodd, TPM_NONCE_SIZE);
>+	ret = get_random_bytes_wait(nonceodd, TPM_NONCE_SIZE);
> 	if (ret < 0)
> 		return ret;
>
>-	if (ret != TPM_NONCE_SIZE) {
>-		pr_info("tpm_get_random failed (%d)\n", ret);
>-		return -EIO;
>-	}
> 	ret = TSS_authhmac(authdata1, keyauth, TPM_NONCE_SIZE,
> 			   enonce1, nonceodd, cont, sizeof(uint32_t),
> 			   &ordinal, bloblen, blob, 0, 0);
>-- 
>2.39.5
>
>

J.

-- 
Web [         Avoid temporary variables and strange women.         ]
site: https:// [                                          ]      Made by
www.earth.li/~noodles/  [                      ]         HuggieTag 0.0.24

