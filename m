Return-Path: <linux-integrity+bounces-2489-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6D28CA663
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 04:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F4F281DC2
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 02:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F23C10953;
	Tue, 21 May 2024 02:53:25 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BADF1FDD;
	Tue, 21 May 2024 02:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716260005; cv=none; b=ohO2A1L80irpgISCTY1WEfLTcxUis7HFaSWPbj6qzqCsOj0NhG6NJJ1FYULGpg6so2PrixlI9ithIbvQGiC1uwLTdLqDYNoLXoyLdqCBQf+ufxqTZ8zlhgDNBK5t1qLlf3rSSwzvuJS28qeM7kH8St/I0ZMLg68hrAm4j+kv++I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716260005; c=relaxed/simple;
	bh=Z4jGxdA4J1toKgzTasm0GDN9Ngv8FeSm+rD8paoawxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KINmUwce3Kq6AeDgAhc/1f9vIC6OEm6ROX0WomA849GZgc7zRyNlsPl6GMeEBMSbxhhC7sG4/h4QAyAp/6SDH5cjMwB5vRzYTqVZVDYr6ss51gTPg/vkEWF/mM53qNSVFgpuLRprB4EUNpPiZDZFh1uUcru7AF5wJ5tyNW2SzMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s9Fcq-000M2J-2k;
	Tue, 21 May 2024 10:53:17 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 21 May 2024 10:53:18 +0800
Date: Tue, 21 May 2024 10:53:18 +0800
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
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [v2 PATCH] crypto: api - Do not load modules if called by async
 probing
Message-ID: <ZkwMnrTR_CbXcjWe@gondor.apana.org.au>
References: <0f68c283ff4bbb89b8a019d47891f798c6fff287.camel@HansenPartnership.com>
 <CAMj1kXHi4r8KY9GvX573kwqvLpMfX-J=K2hWiGAKkf5bnicwYQ@mail.gmail.com>
 <0d260c2f7a9f67ec8bd2305919636678d06000d1.camel@HansenPartnership.com>
 <CAMj1kXFE_R_x10BVkU+8vrMz0RHiX0+rz-ZL+w08FH2CLQHZXA@mail.gmail.com>
 <66ec985f3ee229135bf748f1b0874d5367a74d7f.camel@HansenPartnership.com>
 <dfb0d930-7cbe-46c5-be19-d132b4906ecf@notapiano>
 <D1C2NPOBHAHK.20O4IME8OK1FH@kernel.org>
 <20240518043115.GA53815@sol.localdomain>
 <ZkhS1zrobNwAuANI@gondor.apana.org.au>
 <00bcfa65-384d-46ae-ab8b-30f12487928b@notapiano>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00bcfa65-384d-46ae-ab8b-30f12487928b@notapiano>

On Mon, May 20, 2024 at 11:49:56AM -0400, Nícolas F. R. A. Prado wrote:
>
> Unfortunately this patch didn't work either. The warning is still there
> unchanged.

OK perhaps we can do it by calling current_is_async ourselves.
But this is really a nasty hack because it basically defeats
the whole point of loading optional algorithm by module.

Linus/Tejun, is it time perhaps to remove the warning introduced
by commit 0fdff3ec6d87856cdcc99e69cf42143fdd6c56b4 since it's
been ten years since the warning caused a real problem?

For the Crypto API, if it is called by some random driver via the
async context, this warning stops us from loading any modules
without printing a nasty warning that isn't relevant as the Crypto
API never calls async_synchronize_full.

---8<---
Do not call request_module if this is the case or a warning will
be printed.

Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reported-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 crypto/api.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/crypto/api.c b/crypto/api.c
index 22556907b3bc..7c4b9f86c1ad 100644
--- a/crypto/api.c
+++ b/crypto/api.c
@@ -10,6 +10,7 @@
  * and Nettle, by Niels Möller.
  */
 
+#include <linux/async.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/jump_label.h>
@@ -280,7 +281,8 @@ static struct crypto_alg *crypto_larval_lookup(const char *name, u32 type,
 	mask &= ~(CRYPTO_ALG_LARVAL | CRYPTO_ALG_DEAD);
 
 	alg = crypto_alg_lookup(name, type, mask);
-	if (!alg && !(mask & CRYPTO_NOLOAD)) {
+	if (!alg && !(mask & CRYPTO_NOLOAD) &&
+	    (!IS_BUILTIN(CONFIG_CRYPTO) || !current_is_async())) {
 		request_module("crypto-%s", name);
 
 		if (!((type ^ CRYPTO_ALG_NEED_FALLBACK) & mask &
-- 
2.39.2

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

