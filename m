Return-Path: <linux-integrity+bounces-3288-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A229470B1
	for <lists+linux-integrity@lfdr.de>; Sun,  4 Aug 2024 23:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D854228019C
	for <lists+linux-integrity@lfdr.de>; Sun,  4 Aug 2024 21:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FEF47F7A;
	Sun,  4 Aug 2024 21:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4IHSJbU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E188A2A
	for <linux-integrity@vger.kernel.org>; Sun,  4 Aug 2024 21:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722806925; cv=none; b=EgsjMomzgKqNkpwBb3YVPjfcuwZuliyqEp3Yfv624ycrjn6Ku44/ixWDQLUa6BLsnjv4NcsKsnD6q2LwPgyq4gU5XNgX0EqX81SyDfFqNkMuZjkVdo3UwksDimyi5V8Pm3oOzxcBSvKRuzDj1xfpTYpjMpUthE2SZXr081tGLcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722806925; c=relaxed/simple;
	bh=bUPs55x3fnKZvu1WDtWKSzaaBc7s6aMaCTnShrPGDeQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=CicefPxw0OfLcyruTz3wS2Uh+RTJ9I0G0oOYymvw+HXFwdA7oVSihOuRzIPN85soS0KukwY6caaxK483aDcRZ/ai/tfSmccUVe3ejMlTwhTa7ZHVSvcpmTerDL7D15o9ALjLdArYcEtwmE5wooCaEoJxURtTAA2G45VUyxvsVSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4IHSJbU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED76AC32786;
	Sun,  4 Aug 2024 21:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722806924;
	bh=bUPs55x3fnKZvu1WDtWKSzaaBc7s6aMaCTnShrPGDeQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=q4IHSJbUq/raaZhRny9Z36b0MVTscPVxvA9xHjX9R9U23TbnaUhF8Qzzwl94+sJHZ
	 SqBN+j2cVTfW8BYc+hyE9a/JA1JWRmKPZw07Agg0pK3f4Qg8hGxPnMcUAwKvOeIFDD
	 yjtRJsPMKUhZQwLVX5Om0suk2f6eh02KgmqthBskKqWrT3vz+2uxBSPVsESRCCwCPq
	 9L0W2I2Yx0ttVcwGpR9kx0zyhaS2uxPAa4yqjIIMAIxVCOFJigS4KfgXdeAkwByyNY
	 aqG4rSHi7EXVAzVDPH7dBajDDygb6iBgg1SVvCMGedZ1NEYeWHCce8yahVGNIpIHg6
	 8dlc9cwF9wRMQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 Aug 2024 00:28:40 +0300
Message-Id: <D37G310H9GA0.34YJCKUIISRVS@kernel.org>
Cc: <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH v2 1/8] tss: Fix handling of TPM_RH_NULL in intel-tss
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
In-Reply-To: <940e5cbca2cf08f7275d5e09d552a8500e18742c.camel@HansenPartnership.com>

On Sun Aug 4, 2024 at 4:42 PM EEST, James Bottomley wrote:
> The design of the intel-tss shim is to hide the difference between the
> internal and the external handles by doing the internal to external
> transform on entry.  Unfortunately, the NULL handle (TPM_RH_NULL,
> 40000007) has two possible internal representations depending on
> whether it's used to indicate no session or the null hierarcy.
>
> There is a bug in the intel-tss in that it uses the wrong internal
> NULL handle to try to create the NULL seed primary (and thus fails).
> Now that we're going to be using the NULL primary to salt sessions,
> the Intel TSS shim needs fixing to cope with thi correctly.
>
> The fix is to do the correct transform to the internal hierarchy
> representation on NULL hierarchy creation and to do the session handle
> conversion everywhere else.  Additionally remove the intel_handle()
> code which was supposed to do this: it's unused because 0 is never
> passed in as a handle number.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>
> ---
> v2: reword commit message
>
> ---
>  src/include/intel-tss.h | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
>
> diff --git a/src/include/intel-tss.h b/src/include/intel-tss.h
> index 1870b4e..5b8db20 100644
> --- a/src/include/intel-tss.h
> +++ b/src/include/intel-tss.h
> @@ -251,14 +251,6 @@ intel_sess_helper(TSS_CONTEXT *tssContext,
> TPM_HANDLE auth, TPMA_SESSION flags)
>  				  TPMA_SESSION_CONTINUESESSION |
> flags);
>  }
> =20
> -static inline TPM_HANDLE
> -intel_handle(TPM_HANDLE h)
> -{
> -	if (h =3D=3D 0)
> -		return ESYS_TR_NONE;
> -	return h;
> -}
> -
>  static inline void
>  TSS_Delete(TSS_CONTEXT *tssContext)
>  {
> @@ -937,8 +929,10 @@ tpm2_CreatePrimary(TSS_CONTEXT *tssContext,
> TPM_HANDLE primaryHandle,
>  	TPM2B_PUBLIC *opub;
>  	TPM_RC rc;
> =20
> -	/* FIXME will generate wrong value for NULL hierarchy */
> -	primaryHandle =3D intel_handle(primaryHandle);
> +
> +	/* TPM_RH_NULL is mapped to ESYS_TR_NONE, which won't work
> here */
> +	if (primaryHandle =3D=3D TPM_RH_NULL)
> +		primaryHandle =3D INT_TPM_RH_NULL;
> =20
>  	outsideInfo.size =3D 0;
>  	creationPcr.count =3D 0;
> @@ -993,9 +987,7 @@ tpm2_StartAuthSession(TSS_CONTEXT *tssContext,
> TPM_HANDLE tpmKey,
>  		      TPM_HANDLE *sessionHandle,
>  		      const char *bindPassword)
>  {
> -	bind =3D intel_handle(bind);
> -	tpmKey =3D intel_handle(tpmKey);
> -	if (bind !=3D ESYS_TR_NONE)
> +	if (bind !=3D TPM_RH_NULL)
>  		intel_auth_helper(tssContext, bind, bindPassword);

Not blaming the patch but just have hard time coping this.

The most basic question is probably this: what is the application for
INT_TPM_RH_NULL?

Let's imagine that we have a flow chart describing Intel shim as a state
machine. I decide to shoot it with these three stimulus:

1. INT_TPM_RH_NULL
2. TPM_RH_NULL
3. A valid handle

What happens in each case to its state?

> =20
>  	return Esys_StartAuthSession(tssContext, tpmKey, bind,
> ESYS_TR_NONE,

BR, Jarkko

