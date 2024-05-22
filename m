Return-Path: <linux-integrity+bounces-2545-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCDB8CBABB
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 07:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CFBE1C2160A
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 05:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4498177A1E;
	Wed, 22 May 2024 05:38:04 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96736770E6;
	Wed, 22 May 2024 05:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716356284; cv=none; b=HjEtWMNXnW1NSIrZWE2XezxCu+nMqzcWUtBuE7vk7t2cCi0vmbI9boztYvU+hyQCv9G5ul3n/E9DqtyUwuk/3OIo6zjapHE3pposU3hmY+4Y08NHTBXov3ftCiNrwW6vDa+NuEbaEyKg7JXaVkM7ctPdVeE/yS/9z2Ysw8Vs7vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716356284; c=relaxed/simple;
	bh=/95XhBabHkx9klpzhI23q0R9Gqb7kl8/396FtFx7jxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRrXkNqquK+bYzaoR15hb4l9yjlbdV0+yev8qwmh0//b+rStkp6U20+s51OI99SbI+yqmtEvPJyn/FKN/O5+Qt5i3m+lJZTToc/333a61NqJi/1Pzpzi0JWKq7uxVUI4OesLHyGcqXCMAFLYJTnxIpufJ3YsgPL3b2ODaAAy8xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s9efh-000nse-0t;
	Wed, 22 May 2024 13:37:54 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 22 May 2024 13:37:54 +0800
Date: Wed, 22 May 2024 13:37:54 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: Eric Biggers <ebiggers@kernel.org>, Jarkko Sakkinen <jarkko@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	regressions@lists.linux.dev, kernel@collabora.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kees Cook <keescook@chromium.org>
Subject: [v3 PATCH] hwrng: core - Remove add_early_randomness
Message-ID: <Zk2Eso--FVsZ5AF3@gondor.apana.org.au>
References: <0d260c2f7a9f67ec8bd2305919636678d06000d1.camel@HansenPartnership.com>
 <CAMj1kXFE_R_x10BVkU+8vrMz0RHiX0+rz-ZL+w08FH2CLQHZXA@mail.gmail.com>
 <66ec985f3ee229135bf748f1b0874d5367a74d7f.camel@HansenPartnership.com>
 <dfb0d930-7cbe-46c5-be19-d132b4906ecf@notapiano>
 <D1C2NPOBHAHK.20O4IME8OK1FH@kernel.org>
 <20240518043115.GA53815@sol.localdomain>
 <ZkhS1zrobNwAuANI@gondor.apana.org.au>
 <00bcfa65-384d-46ae-ab8b-30f12487928b@notapiano>
 <ZkwMnrTR_CbXcjWe@gondor.apana.org.au>
 <07512097-8198-4a84-b166-ef9809c2913b@notapiano>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07512097-8198-4a84-b166-ef9809c2913b@notapiano>

On Tue, May 21, 2024 at 03:37:16PM -0400, Nícolas F. R. A. Prado wrote:
>
> FWIW this patch fixes the warning. So feel free to add
> 
> Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Could you please test this patch instead?

---8<---
A potential deadlock was reported with the config file at

https://web.archive.org/web/20240522052129/https://0x0.st/XPN_.txt

In this particular configuration, the deadlock doesn't exist because
the warning triggered at a point before modules were even available.
However, the deadlock can be real because any module loaded would
invoke async_synchronize_full.

The issue is spurious for software crypto algorithms which aren't
themselves involved in async probing.  However, it would be hard to
avoid for a PCI crypto driver using async probing.

In this particular call trace, the problem is easily avoided because
the only reason the module is being requested during probing is the
add_early_randomness call in the hwrng core.  This feature is
vestigial since there is now a kernel thread dedicated to doing
exactly this.

So remove add_early_randomness as it is no longer needed.

Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reported-by: Eric Biggers <ebiggers@kernel.org>
Fixes: 1b6d7f9eb150 ("tpm: add session encryption protection to tpm2_get_random()")
Link: https://lore.kernel.org/r/119dc5ed-f159-41be-9dda-1a056f29888d@notapiano/
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index f5c71a617a99..4084df65c9fa 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -64,19 +64,6 @@ static size_t rng_buffer_size(void)
 	return RNG_BUFFER_SIZE;
 }
 
-static void add_early_randomness(struct hwrng *rng)
-{
-	int bytes_read;
-
-	mutex_lock(&reading_mutex);
-	bytes_read = rng_get_data(rng, rng_fillbuf, 32, 0);
-	mutex_unlock(&reading_mutex);
-	if (bytes_read > 0) {
-		size_t entropy = bytes_read * 8 * rng->quality / 1024;
-		add_hwgenerator_randomness(rng_fillbuf, bytes_read, entropy, false);
-	}
-}
-
 static inline void cleanup_rng(struct kref *kref)
 {
 	struct hwrng *rng = container_of(kref, struct hwrng, ref);
@@ -340,13 +327,12 @@ static ssize_t rng_current_store(struct device *dev,
 				 const char *buf, size_t len)
 {
 	int err;
-	struct hwrng *rng, *old_rng, *new_rng;
+	struct hwrng *rng, *new_rng;
 
 	err = mutex_lock_interruptible(&rng_mutex);
 	if (err)
 		return -ERESTARTSYS;
 
-	old_rng = current_rng;
 	if (sysfs_streq(buf, "")) {
 		err = enable_best_rng();
 	} else {
@@ -362,11 +348,8 @@ static ssize_t rng_current_store(struct device *dev,
 	new_rng = get_current_rng_nolock();
 	mutex_unlock(&rng_mutex);
 
-	if (new_rng) {
-		if (new_rng != old_rng)
-			add_early_randomness(new_rng);
+	if (new_rng)
 		put_rng(new_rng);
-	}
 
 	return err ? : len;
 }
@@ -544,7 +527,6 @@ int hwrng_register(struct hwrng *rng)
 {
 	int err = -EINVAL;
 	struct hwrng *tmp;
-	bool is_new_current = false;
 
 	if (!rng->name || (!rng->data_read && !rng->read))
 		goto out;
@@ -573,25 +555,8 @@ int hwrng_register(struct hwrng *rng)
 		err = set_current_rng(rng);
 		if (err)
 			goto out_unlock;
-		/* to use current_rng in add_early_randomness() we need
-		 * to take a ref
-		 */
-		is_new_current = true;
-		kref_get(&rng->ref);
 	}
 	mutex_unlock(&rng_mutex);
-	if (is_new_current || !rng->init) {
-		/*
-		 * Use a new device's input to add some randomness to
-		 * the system.  If this rng device isn't going to be
-		 * used right away, its init function hasn't been
-		 * called yet by set_current_rng(); so only use the
-		 * randomness from devices that don't need an init callback
-		 */
-		add_early_randomness(rng);
-	}
-	if (is_new_current)
-		put_rng(rng);
 	return 0;
 out_unlock:
 	mutex_unlock(&rng_mutex);
@@ -602,12 +567,11 @@ EXPORT_SYMBOL_GPL(hwrng_register);
 
 void hwrng_unregister(struct hwrng *rng)
 {
-	struct hwrng *old_rng, *new_rng;
+	struct hwrng *new_rng;
 	int err;
 
 	mutex_lock(&rng_mutex);
 
-	old_rng = current_rng;
 	list_del(&rng->list);
 	complete_all(&rng->dying);
 	if (current_rng == rng) {
@@ -626,11 +590,8 @@ void hwrng_unregister(struct hwrng *rng)
 	} else
 		mutex_unlock(&rng_mutex);
 
-	if (new_rng) {
-		if (old_rng != new_rng)
-			add_early_randomness(new_rng);
+	if (new_rng)
 		put_rng(new_rng);
-	}
 
 	wait_for_completion(&rng->cleanup_done);
 }
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

