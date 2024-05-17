Return-Path: <linux-integrity+bounces-2430-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BC58C828A
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2024 10:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87DDA1F2280A
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2024 08:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C74224D1;
	Fri, 17 May 2024 08:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFahYnI8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CFA2208F;
	Fri, 17 May 2024 08:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715934398; cv=none; b=H+WdqRjN3id96RBRXr6T0nA8iUtYib3SFAGL+QKmzOqfl7MT6t6M1W4+u/FEf42qMBGnFaz5R/rWOnp9XvPGVxTFdhQgGqInZ0HJb3ocPa/Juo2ppYUXXeMSNsyVerYAynJiulP6CJs4YYuw0EoSce1BOQHtoD6w4fFJDzM+Xhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715934398; c=relaxed/simple;
	bh=b4CzBIuUjatTBApFL7zeTDMeXO1kQQLfnt2eCZBNbLM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=D3YGooqetzZrHWFv8UCk6kmobNFfFIOpKW6d5UqKdE7NgMNZ/ELY4oTLIXPYoqE8MFTnogs1GgNAC4f8i4PH5BKd6n1cJzYwTyZBGsW44LH+wF4HYJNAj0uFAzE+8jqHqRNU+uzCixZhjezVZa5T9RhIpPLE8cSBzjbgu9MR++M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFahYnI8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A02C2BD10;
	Fri, 17 May 2024 08:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715934397;
	bh=b4CzBIuUjatTBApFL7zeTDMeXO1kQQLfnt2eCZBNbLM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=dFahYnI8viyUXccihZsL3aSFRGse+6uwl/zuok8MimuM94Hh7rpCxmCIAtgHtyXlt
	 xcG0g3GpN/eFcuJyzYLSh7HkwfGEHyqKTABf5b0nT3Lkncko9a2lrmlWmYRwUWuboM
	 ZH+IN0cYTYFwHUArujOcrtwlDpUX6CiDIeHldW/eSAL1SAjfx3RtDqhhxG5I7wY+Xf
	 ImoZq4csqGm5pann9Pq9cO3aDqXxUbeHinaPadqulcF6/6Dzlv7MbM2H4uikRFjdeR
	 1JeEKcsNoZKteDpD9c+b26YvlSQnVmARIuZrEVLS5iaLjLc1WeeatNgdDXN14MVVpG
	 EuPK2blWTRzCg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 May 2024 11:26:33 +0300
Message-Id: <D1BRZ60B9O5S.3NAT20QPQE6KH@kernel.org>
Cc: =?utf-8?b?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <regressions@lists.linux.dev>, <kernel@collabora.com>
Subject: Re: [PATCH v8 18/22] tpm: add session encryption protection to
 tpm2_get_random()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ard Biesheuvel" <ardb@kernel.org>, "James Bottomley"
 <James.Bottomley@hansenpartnership.com>, "Linux Crypto Mailing List"
 <linux-crypto@vger.kernel.org>, "Herbert Xu" <herbert@gondor.apana.org.au>
X-Mailer: aerc 0.17.0
References: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
 <20240429202811.13643-19-James.Bottomley@HansenPartnership.com>
 <119dc5ed-f159-41be-9dda-1a056f29888d@notapiano>
 <0f68c283ff4bbb89b8a019d47891f798c6fff287.camel@HansenPartnership.com>
 <CAMj1kXHi4r8KY9GvX573kwqvLpMfX-J=K2hWiGAKkf5bnicwYQ@mail.gmail.com>
In-Reply-To: <CAMj1kXHi4r8KY9GvX573kwqvLpMfX-J=K2hWiGAKkf5bnicwYQ@mail.gmail.com>

On Fri May 17, 2024 at 10:20 AM EEST, Ard Biesheuvel wrote:
> On Fri, 17 May 2024 at 03:59, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> >
> > On Thu, 2024-05-16 at 20:25 -0400, N=C3=ADcolas F. R. A. Prado wrote:
> ...
> > > KernelCI has identified a new warning and I tracked it down to this
> > > commit. It
> > > was observed on the following platforms:
> > > * mt8183-kukui-jacuzzi-juniper-sku16
> > > * sc7180-trogdor-kingoftown
> > > (but probably affects all platforms that have a tpm driver with async
> > > probe)
> > >
> > > [    2.175146] Call trace:
> > > [    2.177587]  __request_module+0x188/0x1f4
> > > [    2.181596]  crypto_alg_mod_lookup+0x178/0x21c
> > > [    2.186042]  crypto_alloc_tfm_node+0x58/0x114
> > > [    2.190396]  crypto_alloc_shash+0x24/0x30
> > > [    2.194404]  drbg_init_hash_kernel+0x28/0xdc
> > > [    2.198673]  drbg_kcapi_seed+0x21c/0x420
> > > [    2.202593]  crypto_rng_reset+0x84/0xb4
> > > [    2.206425]  crypto_get_default_rng+0xa4/0xd8
> > > [    2.210779]  ecc_gen_privkey+0x58/0xd0
> > > [    2.214526]  ecdh_set_secret+0x90/0x198
> > > [    2.218360]  tpm_buf_append_salt+0x164/0x2dc
> >
> > This looks like a misconfiguration.  The kernel is trying to load the
> > ecdh module, but it should have been selected as built in by this in
> > drivers/char/tpm/Kconfig:
> >
> > config TCG_TPM2_HMAC
> >         bool "Use HMAC and encrypted transactions on the TPM bus"
> >         default y
> >         select CRYPTO_ECDH
> >         select CRYPTO_LIB_AESCFB
> >         select CRYPTO_LIB_SHA256
> >
>
> The module request is not for ECDH itself but for the DRBG it attempts
> to use to generate the secret.
>
> Given that CRYPTO_ECDH does not strictly require a DRBG in principle,
> but does in this particular case, I think it makes sense to select
> CRYPTO_DRBG here (or depend on it being builtin), rather than updating
> the Kconfig rules for CRYPTO_ECDH itself.

I can spin a new PR if James can make a fix.

All previous 4 PR's for 6.10 were applied to Linus' tree so my queue
is empty. Need to have both fixes and stable-tags to save my bandwidth.

Maybe for transcript just two first lines denoting that it was
__request_module() will do. That and adding CONFIG_DRBG will take
it away should be enough for the full disclosure, right?

BR, Jarkko

