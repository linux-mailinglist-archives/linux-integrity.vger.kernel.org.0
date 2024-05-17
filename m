Return-Path: <linux-integrity+bounces-2433-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BE98C8809
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2024 16:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31BB01F277B5
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2024 14:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092355C8E2;
	Fri, 17 May 2024 14:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="auARnO1O";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="kGCYdUkV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4305820C;
	Fri, 17 May 2024 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715955945; cv=none; b=pQB8Qr+5rDT00mrsotPFJQFEXdh9hBLjlO9sdsuB3zDNPbFJXwo8Ux8mv+ghSOIxry6EIjUzvTnOgR3H3GvZNrydqOiDSWEObhKld4C3Y0NhscypZ6teJIg272f/YHjKZGsQYHUKuyRikzWSk6d3B/eE7CQR3cIKEkioVferd/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715955945; c=relaxed/simple;
	bh=/GDsyxcnuk4KfoKabKFPB5hJjhh8RMiY2Q07rk0HPiI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u7bcoaHBT42+pacy84AT3w+ZrhxZpWchajD9KzYU2bpxpWIuSY/f+rBY7zDRHIv3UzuPydRL2OR0sgeb/fsfeay/cJzv6JQTd4hoAYuVoWV3jEPpvZ1WwR13eVS9URLHBFMhQE9KYiBUAhoEprZv2KcPUSJvTVZB31uxQW0RFsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=auARnO1O; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=kGCYdUkV; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1715955943;
	bh=/GDsyxcnuk4KfoKabKFPB5hJjhh8RMiY2Q07rk0HPiI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=auARnO1OAiFcm9twU0nwxi/BOfizN/JLU+SaiY2eLenRniAwPKfZ4UgZ+QyfrPg0s
	 GT5VAaoN9tm0zcdqPyE+boyXaxP0vm495xZ1yPEUO8gahaCvgf/fNwJhM0dzWbMBHI
	 5DpQfJPpYP6hs9fiPVo8PDf+NTaY3JwarpA/yVbM=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id F383612868FD;
	Fri, 17 May 2024 10:25:42 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id keuaws0EsLHW; Fri, 17 May 2024 10:25:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1715955942;
	bh=/GDsyxcnuk4KfoKabKFPB5hJjhh8RMiY2Q07rk0HPiI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=kGCYdUkV0nczHXljjUoA7uIIS62FrtTSle+ZOSxSlqe//QvEGIRHuSCpiNQNEqg+v
	 U+F6w5vhxxXoXYK0wIW/aNLSGZYA2cJcRBSVk1mEQYD1ONuSe09S3LlLiJRkFRAIfk
	 PEIoolXY+LDtX30tmddnnxTTE9rmnv5VqURy3SI4=
Received: from [172.20.11.192] (unknown [74.85.233.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 25A891286514;
	Fri, 17 May 2024 10:25:42 -0400 (EDT)
Message-ID: <66ec985f3ee229135bf748f1b0874d5367a74d7f.camel@HansenPartnership.com>
Subject: Re: [PATCH v8 18/22] tpm: add session encryption protection to
 tpm2_get_random()
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Herbert Xu
 <herbert@gondor.apana.org.au>, =?ISO-8859-1?Q?N=EDcolas?= "F. R. A. Prado"
 <nfraprado@collabora.com>, linux-integrity@vger.kernel.org, Jarkko Sakkinen
 <jarkko@kernel.org>, keyrings@vger.kernel.org, regressions@lists.linux.dev,
  kernel@collabora.com
Date: Fri, 17 May 2024 07:25:40 -0700
In-Reply-To: <CAMj1kXFE_R_x10BVkU+8vrMz0RHiX0+rz-ZL+w08FH2CLQHZXA@mail.gmail.com>
References: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
	 <20240429202811.13643-19-James.Bottomley@HansenPartnership.com>
	 <119dc5ed-f159-41be-9dda-1a056f29888d@notapiano>
	 <0f68c283ff4bbb89b8a019d47891f798c6fff287.camel@HansenPartnership.com>
	 <CAMj1kXHi4r8KY9GvX573kwqvLpMfX-J=K2hWiGAKkf5bnicwYQ@mail.gmail.com>
	 <0d260c2f7a9f67ec8bd2305919636678d06000d1.camel@HansenPartnership.com>
	 <CAMj1kXFE_R_x10BVkU+8vrMz0RHiX0+rz-ZL+w08FH2CLQHZXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2024-05-17 at 15:43 +0200, Ard Biesheuvel wrote:
> On Fri, 17 May 2024 at 15:35, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
[...]
> > Thanks for the analysis.  If I look at how CRYPTO_ECC does it, that
> > selects CRYPTO_RNG_DEFAULT which pulls in CRYPTO_DRBG, so the fix
> > would be the attached.  Does that look right to you Ard?
> 
> No it doesn't - it's CRYPTO_RNG_DEFAULT not CRYTPO_RNG_DEFAULT :-)
> 
> With that fixed,
> 
> Acked-by: Ard Biesheuvel <ardb@kernel.org>

Erm, oops, sorry about that; so attached is the update.

James

---8>8>8><8<8<8---

From 2ac337a33e6416ef806e2c692b9239d193e8468f Mon Sep 17 00:00:00 2001
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
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 4f83ee7021d0..ecdd3db4be2b 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -31,6 +31,7 @@ config TCG_TPM2_HMAC
 	bool "Use HMAC and encrypted transactions on the TPM bus"
 	default y
 	select CRYPTO_ECDH
+	select CRYPTO_RNG_DEFAULT
 	select CRYPTO_LIB_AESCFB
 	select CRYPTO_LIB_SHA256
 	help
-- 
2.35.3



