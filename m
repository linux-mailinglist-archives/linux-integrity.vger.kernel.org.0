Return-Path: <linux-integrity+bounces-2410-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4A48C5DE1
	for <lists+linux-integrity@lfdr.de>; Wed, 15 May 2024 00:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36DB5B21A3E
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 22:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9471182CB4;
	Tue, 14 May 2024 22:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebmnjwnD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9561E182CAB;
	Tue, 14 May 2024 22:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715727115; cv=none; b=p2s5q38rY2CwkiR5SbQlt3zHCZLfl2kgsSgM27op/5Im2xXS6XIctOlleyCChyuZr/H6sytRLEZE6BAuAoAsUYMriWZlnD+yZs6vSRCbQ+wX/8Sx37j1xHXC0THptivriaLtnYx1zbNJMApHLSr3GIi/bbpVmhXrZnXyxK8pfRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715727115; c=relaxed/simple;
	bh=m/grOBSTVdvoTG3X6mB7X/hKOmk/rZQ5XUynZJUpfk0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=cV71RIytvzuYOcmDkOq2tj+FdPmxh3pjk2Z9HFCj9F5ErNT3P3CO9W0QUbVVpaJs1nlwLaSNypIVJn948EWT5/pGx8pIJcB5HfeLCDSwC4kJ+7fOjzclFb85FBNUPB0gV5R0Lel1BbtGKap0lT71ZFHEtQcbSuzIkMxtMhQCO14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebmnjwnD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027D3C4AF07;
	Tue, 14 May 2024 22:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715727115;
	bh=m/grOBSTVdvoTG3X6mB7X/hKOmk/rZQ5XUynZJUpfk0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ebmnjwnDamLLx8Es5WxWRMeGllPUR3i0tETeOq9KTJV7cGi5wBFlUqsgTRq3I6h7c
	 ayaJvuNQbZiC+6mV/Ozo9c/eH/263EcUvhV6XInCyL+F37gPjckMM22JEpUoITsn2V
	 /ben97VR/zqp62XfcME9l2RbOrupivPbXswx92cpFPXCNq8eIh8ALw4J02Ew7oIHp+
	 7C7quAv3ye24nqFJvH9xg5WgoZQqX6LYhWTkhr/kPSiBL4JUnvfk+lZiU+cqXMZSHf
	 ATIHekPqX8XzmBy5X8+2HsV2+IY7BSrn2Q171bL+NTsmXeECJlVW+XPJZhuHKWxOAQ
	 cKOh3ITpRwbNw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 May 2024 01:51:50 +0300
Message-Id: <D19QI1MDD734.3FA17QYMV3TD3@kernel.org>
Cc: <kernel-team@cloudflare.com>
Subject: Re: [RFC PATCH 1/2] tpm: add some algorithm and constant
 definitions from the TPM spec
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ignat Korchagin" <ignat@cloudflare.com>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 <serge@hallyn.com>, <linux-integrity@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240503221634.44274-1-ignat@cloudflare.com>
 <20240503221634.44274-2-ignat@cloudflare.com>
In-Reply-To: <20240503221634.44274-2-ignat@cloudflare.com>

I'll go through the code changes. I've barely skimmed them because I
needed to understand the gist of the cover letter first and was busy
with 6.10 release and asymmetric keys.

On Sat May 4, 2024 at 1:16 AM EEST, Ignat Korchagin wrote:
> In preparation for implementing TPM derived keys we need to use some new =
TPM
> functionality in the kernel, so add relevant constant definitions.

Define "TPM derived key" what is. It is *undefined* at this point of the
Git history.

>
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> ---
>  include/linux/tpm.h | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 4ee9d13749ad..5be0808b1b91 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -35,6 +35,7 @@ struct trusted_key_options;
>  enum tpm_algorithms {
>  	TPM_ALG_ERROR		=3D 0x0000,
>  	TPM_ALG_SHA1		=3D 0x0004,
> +	TPM_ALG_HMAC		=3D 0x0005,
>  	TPM_ALG_KEYEDHASH	=3D 0x0008,
>  	TPM_ALG_SHA256		=3D 0x000B,
>  	TPM_ALG_SHA384		=3D 0x000C,

I had a point after all when asking for split and it was about this
patch. This should be a separate comment and with a clear rationale what
for this is required for the new key type.

It is a logically separate change [1].

> @@ -209,6 +210,7 @@ enum tpm2_return_codes {
>  	TPM2_RC_DISABLED	=3D 0x0120,
>  	TPM2_RC_UPGRADE		=3D 0x012D,
>  	TPM2_RC_COMMAND_CODE    =3D 0x0143,
> +	TPM2_RC_OBJECT_MEMORY	=3D 0x0902,
>  	TPM2_RC_TESTING		=3D 0x090A, /* RC_WARN */
>  	TPM2_RC_REFERENCE_H0	=3D 0x0910,
>  	TPM2_RC_RETRY		=3D 0x0922,

Ditto.

> @@ -227,6 +229,7 @@ enum tpm2_command_codes {
>  	TPM2_CC_CREATE		        =3D 0x0153,
>  	TPM2_CC_LOAD		        =3D 0x0157,
>  	TPM2_CC_SEQUENCE_UPDATE         =3D 0x015C,
> +	TPM2_CC_SIGN		        =3D 0x015D,
>  	TPM2_CC_UNSEAL		        =3D 0x015E,
>  	TPM2_CC_CONTEXT_LOAD	        =3D 0x0161,
>  	TPM2_CC_CONTEXT_SAVE	        =3D 0x0162,

Ditto.

> @@ -234,6 +237,7 @@ enum tpm2_command_codes {
>  	TPM2_CC_VERIFY_SIGNATURE        =3D 0x0177,
>  	TPM2_CC_GET_CAPABILITY	        =3D 0x017A,
>  	TPM2_CC_GET_RANDOM	        =3D 0x017B,
> +	TPM2_CC_HASH	        	=3D 0x017D,
>  	TPM2_CC_PCR_READ	        =3D 0x017E,
>  	TPM2_CC_PCR_EXTEND	        =3D 0x0182,
>  	TPM2_CC_EVENT_SEQUENCE_COMPLETE =3D 0x0185,


Ditto.

> @@ -243,7 +247,8 @@ enum tpm2_command_codes {
>  };
> =20
>  enum tpm2_permanent_handles {
> -	TPM2_RS_PW		=3D 0x40000009,
> +	TPM2_RH_OWNER =3D 0x40000001,

Ditto.

> +	TPM2_RS_PW    =3D 0x40000009,
>  };
> =20
>  enum tpm2_capabilities {
> @@ -312,9 +317,12 @@ struct tpm_buf {
>  };
> =20
>  enum tpm2_object_attributes {
> -	TPM2_OA_FIXED_TPM		=3D BIT(1),
> -	TPM2_OA_FIXED_PARENT		=3D BIT(4),
> -	TPM2_OA_USER_WITH_AUTH		=3D BIT(6),
> +	TPM2_OA_FIXED_TPM 		=3D BIT(1),
> +	TPM2_OA_FIXED_PARENT 		=3D BIT(4),
> +	TPM2_OA_SENSITIVE_DATA_ORIGIN	=3D BIT(5),
> +	TPM2_OA_USER_WITH_AUTH 		=3D BIT(6),
> +	TPM2_OA_RESTRICTED 		=3D BIT(16),
> +	TPM2_OA_SIGN 			=3D BIT(18),
>  };
> =20
>  enum tpm2_session_attributes {

Ditto.

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#=
separate-your-changes

BR, Jarkko

