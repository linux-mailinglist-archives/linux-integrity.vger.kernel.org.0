Return-Path: <linux-integrity+bounces-2431-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E1F8C874C
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2024 15:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1E08B21651
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2024 13:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7C85491A;
	Fri, 17 May 2024 13:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ZgxYItp/";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ZgxYItp/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C62548F1;
	Fri, 17 May 2024 13:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715952927; cv=none; b=k1ggTGDITZEVjFJu4e50UnVSuT6RwxPWETrEvysf0IgDQfGChQItI60M61pIs++iNU2FQY1tXXL/ScUtgLgqBYIMuThv32JahegexqtCQVJDJMNTYyFscjA0dsBdEqP0J2xpcHsiKRm6WjOaw7nt7eXIaVJNJlQMRhVfYMpdNvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715952927; c=relaxed/simple;
	bh=B23H46bZ0sNOR/VWR/eO/NPiZCjxNTMRlXuXjaE6+KY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=POcAFAMG5XhjyMQa0Pg2TnU82SoNLXeyzFlatT6CQvCc2cZ5pIs1xjG9xjHzYgzoqID6urxFIQp+q10Jj8Uzrq1HxYX9jE1msONg4AJ9M/678k4ai0uOYu/zcnIrKZPAgq7Ke4wZSyuusZnrEDtiNtcvOalMN1M1IrRRJRmtsHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=ZgxYItp/; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=ZgxYItp/; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1715952924;
	bh=B23H46bZ0sNOR/VWR/eO/NPiZCjxNTMRlXuXjaE6+KY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=ZgxYItp/N7Uy7m58E6Qg1Zxg7qoQWv9Pl5nG4AjD36YrAh/O2PzplZe4vtSyvSIB8
	 dFhj+pe4BpIxQGD7n6lBFGazUz6AS9PnLjfEWVbC3UJ6iEhxsinGOLmdeVL5U2S9m+
	 nHU3L6wVAGp8Tcbgd5JLHA95t9QvHzaPpGuRGCnI=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 869091287657;
	Fri, 17 May 2024 09:35:24 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 1k4m3KJ9dkEh; Fri, 17 May 2024 09:35:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1715952924;
	bh=B23H46bZ0sNOR/VWR/eO/NPiZCjxNTMRlXuXjaE6+KY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=ZgxYItp/N7Uy7m58E6Qg1Zxg7qoQWv9Pl5nG4AjD36YrAh/O2PzplZe4vtSyvSIB8
	 dFhj+pe4BpIxQGD7n6lBFGazUz6AS9PnLjfEWVbC3UJ6iEhxsinGOLmdeVL5U2S9m+
	 nHU3L6wVAGp8Tcbgd5JLHA95t9QvHzaPpGuRGCnI=
Received: from [172.20.11.192] (unknown [74.85.233.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id EFB3E1287631;
	Fri, 17 May 2024 09:35:23 -0400 (EDT)
Message-ID: <0d260c2f7a9f67ec8bd2305919636678d06000d1.camel@HansenPartnership.com>
Subject: Re: [PATCH v8 18/22] tpm: add session encryption protection to
 tpm2_get_random()
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Ard Biesheuvel <ardb@kernel.org>, Linux Crypto Mailing List
	 <linux-crypto@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: =?ISO-8859-1?Q?N=EDcolas?= "F. R. A. Prado" <nfraprado@collabora.com>, 
	linux-integrity@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>, 
	keyrings@vger.kernel.org, regressions@lists.linux.dev, kernel@collabora.com
Date: Fri, 17 May 2024 06:35:22 -0700
In-Reply-To: <CAMj1kXHi4r8KY9GvX573kwqvLpMfX-J=K2hWiGAKkf5bnicwYQ@mail.gmail.com>
References: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
	 <20240429202811.13643-19-James.Bottomley@HansenPartnership.com>
	 <119dc5ed-f159-41be-9dda-1a056f29888d@notapiano>
	 <0f68c283ff4bbb89b8a019d47891f798c6fff287.camel@HansenPartnership.com>
	 <CAMj1kXHi4r8KY9GvX573kwqvLpMfX-J=K2hWiGAKkf5bnicwYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2024-05-17 at 09:20 +0200, Ard Biesheuvel wrote:
> On Fri, 17 May 2024 at 03:59, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > On Thu, 2024-05-16 at 20:25 -0400, Nícolas F. R. A. Prado wrote:
> ...
> > > KernelCI has identified a new warning and I tracked it down to
> > > this
> > > commit. It
> > > was observed on the following platforms:
> > > * mt8183-kukui-jacuzzi-juniper-sku16
> > > * sc7180-trogdor-kingoftown
> > > (but probably affects all platforms that have a tpm driver with
> > > async
> > > probe)
> > > 
> > > [    2.175146] Call trace:
> > > [    2.177587]  __request_module+0x188/0x1f4
> > > [    2.181596]  crypto_alg_mod_lookup+0x178/0x21c
> > > [    2.186042]  crypto_alloc_tfm_node+0x58/0x114
> > > [    2.190396]  crypto_alloc_shash+0x24/0x30
> > > [    2.194404]  drbg_init_hash_kernel+0x28/0xdc
> > > [    2.198673]  drbg_kcapi_seed+0x21c/0x420
> > > [    2.202593]  crypto_rng_reset+0x84/0xb4
> > > [    2.206425]  crypto_get_default_rng+0xa4/0xd8
> > > [    2.210779]  ecc_gen_privkey+0x58/0xd0
> > > [    2.214526]  ecdh_set_secret+0x90/0x198
> > > [    2.218360]  tpm_buf_append_salt+0x164/0x2dc
> > 
> > This looks like a misconfiguration.  The kernel is trying to load
> > the
> > ecdh module, but it should have been selected as built in by this
> > in
> > drivers/char/tpm/Kconfig:
> > 
> > config TCG_TPM2_HMAC
> >         bool "Use HMAC and encrypted transactions on the TPM bus"
> >         default y
> >         select CRYPTO_ECDH
> >         select CRYPTO_LIB_AESCFB
> >         select CRYPTO_LIB_SHA256
> > 
> 
> The module request is not for ECDH itself but for the DRBG it
> attempts
> to use to generate the secret.
> 
> Given that CRYPTO_ECDH does not strictly require a DRBG in principle,
> but does in this particular case, I think it makes sense to select
> CRYPTO_DRBG here (or depend on it being builtin), rather than
> updating the Kconfig rules for CRYPTO_ECDH itself.

Thanks for the analysis.  If I look at how CRYPTO_ECC does it, that
selects CRYPTO_RNG_DEFAULT which pulls in CRYPTO_DRBG, so the fix would
be the attached.  Does that look right to you Ard?  And does it work
Nicolas?

James

---8>8>8><8<8<8---

From 8c60ffd959eaa65627aca6596c35bb9cbfd9bee6 Mon Sep 17 00:00:00 2001
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Fri, 17 May 2024 06:29:31 -0700
Subject: [PATCH] tpm: Fix sessions cryptography requirement for Random Numbers
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The ECDH code in tpm2-sessions.c requires an initial random number
generator to generate the key pair.  If the configuration doesn't have
CONFIG_RNG_DEFAULT, it will try to pull this in as a module (which is
impossible for the early kernel boot where the TPM starts).  Fix this
by selecting the required RNG.

Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Fixes: 1b6d7f9eb150 ("tpm: add session encryption protection to tpm2_get_random()")
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 4f83ee7021d0..12065eddb922 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -31,6 +31,7 @@ config TCG_TPM2_HMAC
 	bool "Use HMAC and encrypted transactions on the TPM bus"
 	default y
 	select CRYPTO_ECDH
+	select CRYTPO_RNG_DEFAULT
 	select CRYPTO_LIB_AESCFB
 	select CRYPTO_LIB_SHA256
 	help
-- 
2.35.3



