Return-Path: <linux-integrity+bounces-3290-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDD7947A9B
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Aug 2024 13:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5F81C20F19
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Aug 2024 11:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8781547CC;
	Mon,  5 Aug 2024 11:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKtzYMUs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061FC1514C9
	for <linux-integrity@vger.kernel.org>; Mon,  5 Aug 2024 11:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722858854; cv=none; b=cG64/MvbfxhKlJ3osKke0dWpiJE5em5TrJZwzTl5yqndvud9Bo0TBThDu/HchWJVQDoal3t462PmieF5aIDol8spdW3DFtw56kCYiDInOiEXImyfnJ1S7DybXiF6mKWDXraGLumOkql1Wr8/oLxxkrN/MPEpI7Qtp9bkJm0LaFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722858854; c=relaxed/simple;
	bh=PHorJWkswMV4XpwyKGYh5Zh5Y8+j8tWnPFvntYvTgfQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=YI80pi+9NsrHoLoumCU4zLFLS/QMsCzr2r8ID3K36yUKV5MHprfnbgaT6s+GYdiBacQNF2Z/k4TT/8fTZyI1Kc4t5cFJiXkYmbodlYmuJyBsswzm/DFexvHy7WWUFCkUNhNfZKU41xvRdgIAUQZwT0zgnGRBpyg/veE8WpAsnLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKtzYMUs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057F3C4AF0E;
	Mon,  5 Aug 2024 11:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722858853;
	bh=PHorJWkswMV4XpwyKGYh5Zh5Y8+j8tWnPFvntYvTgfQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=uKtzYMUskByO2pCYl/dO519OQThev7zqYuzFpg/MM8mmxLZ1sz23fgW6VcTdnLttQ
	 W6QDfre5evgXg176OJerz4vCkKJ8Z1ZJEd7Sbwjlffd3JwniJh+7ne1AcLyZa1IjgQ
	 GTLQsG70+uhLQfYm/M/bQL60kDC54WsEeE4A0mHcdt78upTn8calOI/RQuH5h5c+To
	 z/AJ2mVh0HQRUnIM8XATaNgeeyyb+wKKnO/sUblCXZERGR8T4BkuqVm3G+Gjc/TIzn
	 z7hUxqJWj/VJshPgMsMF65lhSH8fHStMme7cejGB/fO8+NLOhSpDQOhmur8DZpSlxn
	 IEq/yMMg9/mXw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 Aug 2024 14:54:09 +0300
Message-Id: <D37YHOXW44O0.98DXLONUWC1F@kernel.org>
Cc: <linux-integrity@vger.kernel.org>
Subject: Re: [openssl-tpm2-engine] [PATCH v2 1/8] tss: Fix handling of
 TPM_RH_NULL in intel-tss
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <openssl-tpm2-engine@groups.io>, "Jarkko Sakkinen" <jarkko.sakkinen@iki.fi>
X-Mailer: aerc 0.17.0
References: <20240802202606.12767-1-James.Bottomley@HansenPartnership.com>
 <20240802202606.12767-2-James.Bottomley@HansenPartnership.com>
 <D36FX5RTUSEW.1LZMP91ZPPZZK@iki.fi>
 <53a91b9ebbc500e928eadf2112d3ecb5631c56c1.camel@HansenPartnership.com>
 <D36IYI5ZD4VK.2GC6CG6GIUWK9@kernel.org>
 <237c1ed926d926bfddb92a959a27543479b5f0ae.camel@HansenPartnership.com>
 <D36KI8TC0600.1OAIM33YQYMLX@kernel.org>
 <940e5cbca2cf08f7275d5e09d552a8500e18742c.camel@HansenPartnership.com>
 <D37G310H9GA0.34YJCKUIISRVS@kernel.org>
 <d0d83a418720467551faa718fd150c379a933652.camel@HansenPartnership.com>
In-Reply-To: <d0d83a418720467551faa718fd150c379a933652.camel@HansenPartnership.com>

On Mon Aug 5, 2024 at 5:48 AM EEST, James Bottomley wrote:
> On Mon, 2024-08-05 at 00:28 +0300, Jarkko Sakkinen wrote:
> [...]
> > > --- a/src/include/intel-tss.h
> > > +++ b/src/include/intel-tss.h
> > > @@ -251,14 +251,6 @@ intel_sess_helper(TSS_CONTEXT *tssContext,
> > > TPM_HANDLE auth, TPMA_SESSION flags)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TPMA_SESSION_CONTINU=
ESESSION |
> > > flags);
> > > =C2=A0}
> > > =C2=A0
> > > -static inline TPM_HANDLE
> > > -intel_handle(TPM_HANDLE h)
> > > -{
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (h =3D=3D 0)
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return ESYS_TR_NONE;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return h;
> > > -}
> > > -
> > > =C2=A0static inline void
> > > =C2=A0TSS_Delete(TSS_CONTEXT *tssContext)
> > > =C2=A0{
> > > @@ -937,8 +929,10 @@ tpm2_CreatePrimary(TSS_CONTEXT *tssContext,
> > > TPM_HANDLE primaryHandle,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0TPM2B_PUBLIC *opub;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0TPM_RC rc;
> > > =C2=A0
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* FIXME will generate wro=
ng value for NULL hierarchy */
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0primaryHandle =3D intel_ha=
ndle(primaryHandle);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* TPM_RH_NULL is mapped t=
o ESYS_TR_NONE, which won't work
> > > here */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (primaryHandle =3D=3D T=
PM_RH_NULL)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0primaryHandle =3D INT_TPM_RH_NULL;
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0outsideInfo.size =3D =
0;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0creationPcr.count =3D=
 0;
> > > @@ -993,9 +987,7 @@ tpm2_StartAuthSession(TSS_CONTEXT *tssContext,
> > > TPM_HANDLE tpmKey,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TPM_HANDLE *sessi=
onHandle,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *bindP=
assword)
> > > =C2=A0{
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bind =3D intel_handle(bind=
);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpmKey =3D intel_handle(tp=
mKey);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (bind !=3D ESYS_TR_NONE=
)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (bind !=3D TPM_RH_NULL)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0intel_auth_helper(tssContext, bind, bindPassword=
);
> >=20
> > Not blaming the patch but just have hard time coping this.
> >=20
> > The most basic question is probably this: what is the application for
> > INT_TPM_RH_NULL?
>
> Ah, well, it turns out that the Intel TSS also isn't very performant
> and part of the performance loss is using a memory database for
> translating external TPM objects into internal ones.  Some of the
> performance can be recovered by not doing this.

So INT_RH_NULL is  a flag that translates to "do not translate to
internal object if it is derived from the nulll seed?". I.e. is it
some kind of skip flag?

External presentation is any TPM object I guess, but what is
conceptually the internal representation we are talking about here?

I wonder why nobody ever got idea that all kinds of TPM daemons
could use u64 for handles, and have future-proof robustness as in
TPM2 handles are u32.

BR, Jarkko

