Return-Path: <linux-integrity+bounces-2442-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 717C88C9073
	for <lists+linux-integrity@lfdr.de>; Sat, 18 May 2024 12:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00AEB1F21AFF
	for <lists+linux-integrity@lfdr.de>; Sat, 18 May 2024 10:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E321BC3C;
	Sat, 18 May 2024 10:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/IJ2yD5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0158914A9D;
	Sat, 18 May 2024 10:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716029809; cv=none; b=gH7LzFPxH7FBDd15PD3xQvb/KCoqn1Oh2nqZ5YU2yb/3TtN3xEEHKENWSJvPSxfVXpZ5liHvhg6J1bFNuV/R0+drnyUrwqMWP7C7rbVP/M75LMODOiYhRHh0oyV6DlApcxjfIU6OMOcKffK2Fltj7ZFElw7H5b+KpLdd02969pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716029809; c=relaxed/simple;
	bh=MqvPdrBURHBn30SfZ0XaRXnTniJYhYM73WWqxybnAJc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=jmBPNw2NbeFqOqxCeT8kVnydyaw/Ool4ghItnsZX83LiBCWnWee98L7axs5fiKqzUjiCIyzqs01B4M63dYPiSDx9P1EubOX/dAxthRoMLLQ27YqOG89ImSIQwgPPlyAXtYl4M3gfNNlibvqUkqEX3Ywt6xuZ0GMuyILb2ipq//s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/IJ2yD5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753C6C113CC;
	Sat, 18 May 2024 10:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716029808;
	bh=MqvPdrBURHBn30SfZ0XaRXnTniJYhYM73WWqxybnAJc=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=U/IJ2yD5ds6OBlnxnL1kzlMaJj5PrR6+iKIOdV5mPVTcEFBlKXV9oGs+iVxCD12Zw
	 8uh29tawsSMHKtBkqZPT7991GlwPnJtTnlljf857tEOPkZBqMnJ8VZUkJvPiDufhZw
	 YwfEjqQ4xzQntMHKeoLcy9lj/u7sAvhwKj5UVGbSc9er/Ot6XwjCeUdqBBBYM8udqs
	 56+z6BpFiaKF0JTfRGazQujXoxawn2yCdNxK7or5XOgXBYlIUt+sF7T2/6CCqTM65i
	 EH3CiaCvKolS2dVYQ9drQsu52lamBgoqai/alm7iw0PUbG+vUOdFlUoZEFG5itSWuV
	 FBe7YBD+E65YA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 18 May 2024 13:56:44 +0300
Message-Id: <D1CPSP3UHQPK.1LOE5IQ6IMHYP@kernel.org>
To: "Eric Biggers" <ebiggers@kernel.org>
Cc: =?utf-8?b?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 "James Bottomley" <James.Bottomley@hansenpartnership.com>, "Ard Biesheuvel"
 <ardb@kernel.org>, "Linux Crypto Mailing List"
 <linux-crypto@vger.kernel.org>, "Herbert Xu" <herbert@gondor.apana.org.au>,
 <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <regressions@lists.linux.dev>, <kernel@collabora.com>
Subject: Re: [PATCH v8 18/22] tpm: add session encryption protection to
 tpm2_get_random()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
 <20240429202811.13643-19-James.Bottomley@HansenPartnership.com>
 <119dc5ed-f159-41be-9dda-1a056f29888d@notapiano>
 <0f68c283ff4bbb89b8a019d47891f798c6fff287.camel@HansenPartnership.com>
 <CAMj1kXHi4r8KY9GvX573kwqvLpMfX-J=K2hWiGAKkf5bnicwYQ@mail.gmail.com>
 <0d260c2f7a9f67ec8bd2305919636678d06000d1.camel@HansenPartnership.com>
 <CAMj1kXFE_R_x10BVkU+8vrMz0RHiX0+rz-ZL+w08FH2CLQHZXA@mail.gmail.com>
 <66ec985f3ee229135bf748f1b0874d5367a74d7f.camel@HansenPartnership.com>
 <dfb0d930-7cbe-46c5-be19-d132b4906ecf@notapiano>
 <D1C2NPOBHAHK.20O4IME8OK1FH@kernel.org>
 <20240518043115.GA53815@sol.localdomain>
In-Reply-To: <20240518043115.GA53815@sol.localdomain>

On Sat May 18, 2024 at 7:31 AM EEST, Eric Biggers wrote:
> This is "normal" behavior when the crypto API instantiates a template:
>
>     1. drbg.c asks for "hmac(sha512)"
>
>     2. The crypto API looks for a direct implementation of "hmac(sha512)"=
.
>        This includes requesting a module with alias "crypto-hmac(sha512)"=
.
>
>     3. If none is found, the "hmac" template is instantiated instead.
>
> There are two possible fixes for the bug.  Either fix ecc_gen_privkey() t=
o just
> use get_random_bytes() instead of the weird crypto API RNG, or make
> drbg_init_hash_kernel() pass the CRYPTO_NOLOAD flag to crypto_alloc_shash=
().
>
> Or if the TPM driver could be changed to not need to generate an ECC priv=
ate key
> at probe time, that would also avoid this problem.

Issues:

- IMA extends PCR's. This requires encrypted communications path.
- HWRNG uses auth session (see tpm2_get_radom()).
- TPM trusted keys

Null key is required before any other legit use in initialization.

Even something like=20

--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -36,6 +36,8 @@ config TCG_TPM2_HMAC
        bool "Use HMAC and encrypted transactions on the TPM bus"
        default y
+       select CRYPTO_DRBG
        select CRYPTO_ECDH
+       select CRYPTO_HMAC
+       select CRYPTO_SHA512
        select CRYPTO_LIB_AESCFB
        select CRYPTO_LIB_SHA256
        help

would be more decent.

>
> - Eric

BR, Jarkko

