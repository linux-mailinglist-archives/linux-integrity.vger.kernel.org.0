Return-Path: <linux-integrity+bounces-2535-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9378CB612
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 00:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E8481F22350
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 22:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA6D149C7B;
	Tue, 21 May 2024 22:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNTPCUzu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8483BB21;
	Tue, 21 May 2024 22:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716331341; cv=none; b=gFrh1S762JJQFlf27y6BmrzcV+vPFeYUcMHeSfmKKtpF0JS8RTztUY8Lh7a582LGtUAcNhD5suxYpm7id95NvaZzStWQBfxPz2w7Ji6tNl2phDzW73vm2HXyPLD46uxPuR8Qq3U58T64VlmCrNOKtxdiZmeCiPq5kzlZIQJOLYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716331341; c=relaxed/simple;
	bh=IGvF/ZLOM9k1OCm5fZ83p/8+gCIoPFXgGAl3mveUSZk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=GKQvCe1jYH46xJ7qxVtX4gsoN1XMhHhRCgyLaDMERRlW5E+p5hqAW5gyQajJ81baxHRNYCFJwK2NFxkJaLnxokOR3QG3kHUasd63f8/ebPgoUEQdbPfF1O5Ahck7gSP2QZtva37ye26LRD+9SugfPn6TU7YILib39YE2QPhHJUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNTPCUzu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2291C2BD11;
	Tue, 21 May 2024 22:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716331340;
	bh=IGvF/ZLOM9k1OCm5fZ83p/8+gCIoPFXgGAl3mveUSZk=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=iNTPCUzu30RcoOTyh95mpUIKKWjWX+HNAGih+3DGc0/eSY8NdIHk2BLpOukXlOxP6
	 LXYhq7kSYdzrB18aR0IBv5wnXnyoVQySZ7bIxfCtI7r/leT38vOW4S4+QSjyKT+wpj
	 ZRxyM+46opxpZ5ydIUBCrX07ykzGMxEwhc2P6K99mk3Ply+ySg3Lt75aIEDcau73Oh
	 LB9VQIHY1MlDsFu/LTbB6ScqhnVzc6U68XMprFupVBI/d2RtskBmFfVN7ZJhTzt40c
	 JyysYQ1tUd7vG90G0uyd7gWVTmZXS9mESMKvEEV6FI8FxlS2OMrHRb53TzUHuGR+7X
	 hb0hgS4el2tOw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 May 2024 01:42:14 +0300
Message-Id: <D1FOOI70OW9N.Y2ATVMAK2QR@kernel.org>
Cc: "James Bottomley" <James.Bottomley@HansenPartnership.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, <linux-integrity@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <Andreas.Fuchs@infineon.com>, "James Prestwood"
 <prestwoj@gmail.com>, "David Woodhouse" <dwmw2@infradead.org>, "Eric
 Biggers" <ebiggers@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 "open list:CRYPTO API" <linux-crypto@vger.kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Mimi Zohar" <zohar@linux.ibm.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "open list:SECURITY SUBSYSTEM"
 <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] KEYS: trusted: Move tpm2_key_decode() to the TPM
 driver
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "David Howells" <dhowells@redhat.com>
X-Mailer: aerc 0.17.0
References: <D1FMVEJWGLEW.14QGHPAYPHQG1@kernel.org>
 <20240521031645.17008-1-jarkko@kernel.org>
 <20240521031645.17008-5-jarkko@kernel.org>
 <cc3d952f8295b52b052fbffe009b796ffb45707a.camel@HansenPartnership.com>
 <336755.1716327854@warthog.procyon.org.uk>
In-Reply-To: <336755.1716327854@warthog.procyon.org.uk>

On Wed May 22, 2024 at 12:44 AM EEST, David Howells wrote:
> Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> > On Tue May 21, 2024 at 9:18 PM EEST, James Bottomley wrote:
> > ...
> > You don't save a single byte of memory with any constant that dictates
> > the size requirements for multiple modules in two disjoint subsystems.
>
> I think James is just suggesting you replace your limit argument with a
> constant not that you always allocate that amount of memory.  What the li=
mit
> should be, OTOH, is up for discussion, but PAGE_SIZE seems not unreasonab=
le.

When the decoder for ASN.1 was part of trusted keys, the check used to
be:

	if (ctx.priv_len + ctx.pub_len > MAX_BLOB_SIZE)
		return -EINVAL;

And MAX_BLOB_SIZE is only 512 bytes, which does not fit event 2048 bit
RSA key but that 512 bytes cap seems to be just fine for trusted keys.

So the new check is:

	if (blob_len > max_key_len)
		return -E2BIG;

1. Too big value is not invalid value, thus -E2BIG. It is has also
   shown to be practically useful while testing this key type.
2. tpm2_key_rsa needs up to 8192 bytes for a blob to fit 4096-bit
   RSA key.=20

Just saying but there is also primary null key allocated by the driver.
And neither driver uses MAX_BLOB_SiZE. It uses value 8x MAX_BLOB_SIZE
i.e. 4096 bytes so not really following the idea suggested.

Finaly, there is three completely separate algorithms:

- KEYEDHASH (trusted_keys)
- RSA (tpm2_key_rsa)
- ECDSA (driver)=C2=A7
=09
With all this put together it is just common sense to have parametrized
cap value, and it would have no logic at all to treat them unified way.

For tpm2_key_rsa I will define for clarity:

#define TPM2_KEY_RSA_MAX_SIZE 8192

For tpm2_key_ecdsa you would define

#define TPM2_KEY_ECDSA_MAX_SIZE 4096

So yeah, this is how I will proceed because it is really the only
senseful way to proceed.

>
> David

BR, Jarkko

