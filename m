Return-Path: <linux-integrity+bounces-3676-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3F89848E0
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 17:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFC86B22E3C
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 15:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715851A4F3E;
	Tue, 24 Sep 2024 15:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VD8TfQnS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0F717BA0;
	Tue, 24 Sep 2024 15:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727193267; cv=none; b=q9Gy74nz+BiZx9etSa5vvfmaxO1b9gmvOIrUGKKPB486SCRklNdWo/re7H2dOsfs1C8NIQwCm3/Q7Hz4i4fhbDOTy4k+D4xT+7MwbYv9OlHhzXHvRThhzO7P6qRrm4Uvs0iXzrTfXjFFmP2SDJdZvjBvOvBByL7sxJS6DAH5dkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727193267; c=relaxed/simple;
	bh=zEbANDlvGhsT4VvsuSPoPjBkSOIpMZlhLOoNoYw5DE0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=iOyGSSJmaRG8HaAmkNAVIOeQk0YIN1zSIL1woLFw2wtqzjjFwfAn1VM26NC0N5RaPnnJ5iKAaysqEGwMJcLxhUvZ3eLUft2NBbMiVaKfRPk6cbUoAB4dZ34bAcVuK5Y0SQWBnsmVX7H4HtCgu5cKtBdTHSh8wSlWntpKok+c2xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VD8TfQnS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44652C4CEC4;
	Tue, 24 Sep 2024 15:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727193265;
	bh=zEbANDlvGhsT4VvsuSPoPjBkSOIpMZlhLOoNoYw5DE0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=VD8TfQnS3aduUCcwavtn1qUo3w1emfcu/VudZtDPAuqvpQsZwQaovxeqi/m83ocJL
	 OTH0XAu05Awgniyec+7UIFngdecOyzhRbFYrwjViMZ1sK6npQ08nCH8rHFFqWllBGr
	 AEqAsoFJPxKtFjQT022DOvewZYnLv7g8hWi+tpEvJz7mje5ab8rs2lqmHGO8tbM6tJ
	 uagUv4kGj2De9nzmkuU17hnhqzPeNBzNHHxleOypO2WF1fSS0PUeIH/iMKJo09Awoo
	 QbY8wtP5gihGmJhFPLiJVMhACBZVLqGraqqmiz44R8W+lPBF0meBsv14j/09gFXUbB
	 E48CK4ABLXZTA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Sep 2024 18:54:21 +0300
Message-Id: <D4EMWUMBIM94.3PM88QAV6LG6B@kernel.org>
Cc: <dm-devel@lists.linux.dev>, <snitzer@kernel.org>, <serge@hallyn.com>,
 <wufan@linux.microsoft.com>, "David Howells" <dhowells@redhat.com>,
 <keyrings@vger.kernel.org>, <linux-integrity@vger.kernel.org>, "Mimi Zohar"
 <zohar@linux.ibm.com>
Subject: Re: [PATCH] dm verity: fallback to platform keyring also if key in
 trusted keyring is rejected
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Mikulas Patocka" <mpatocka@redhat.com>, <luca.boccassi@gmail.com>
X-Mailer: aerc 0.18.2
References: <20240922161753.244476-1-luca.boccassi@gmail.com>
 <6b3e0e45-5efe-3032-62b8-75dcd45c879c@redhat.com>
In-Reply-To: <6b3e0e45-5efe-3032-62b8-75dcd45c879c@redhat.com>

On Mon Sep 23, 2024 at 5:04 PM EEST, Mikulas Patocka wrote:
>
>
> On Sun, 22 Sep 2024, luca.boccassi@gmail.com wrote:
>
> > From: Luca Boccassi <bluca@debian.org>
> >=20
> > If enabled, we fallback to the platform keyring if the trusted keyring =
doesn't have
> > the key used to sign the roothash. But if pkcs7_verify() rejects the ke=
y for other
> > reasons, such as usage restrictions, we do not fallback. Do so.
> >=20
> > Follow-up for 6fce1f40e95182ebbfe1ee3096b8fc0b37903269
> >=20
> > Suggested-by: Serge Hallyn <serge@hallyn.com>
> > Signed-off-by: Luca Boccassi <bluca@debian.org>
>
> Hi
>
> I'm not an expert in keyrings.
>
> I added keyring maintainers to the CC. Please review this patch and=20
> Ack/Nack it.
>
> Mikulas
>
> > ---
> >  drivers/md/dm-verity-verify-sig.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/md/dm-verity-verify-sig.c b/drivers/md/dm-verity-v=
erify-sig.c
> > index d351d7d39c60..a9e2c6c0a33c 100644
> > --- a/drivers/md/dm-verity-verify-sig.c
> > +++ b/drivers/md/dm-verity-verify-sig.c
> > @@ -127,7 +127,7 @@ int verity_verify_root_hash(const void *root_hash, =
size_t root_hash_len,
> >  #endif
> >  				VERIFYING_UNSPECIFIED_SIGNATURE, NULL, NULL);
> >  #ifdef CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG_PLATFORM_KEYRING
> > -	if (ret =3D=3D -ENOKEY)
> > +	if (ret =3D=3D -ENOKEY || ret =3D=3D -EKEYREJECTED)
> >  		ret =3D verify_pkcs7_signature(root_hash, root_hash_len, sig_data,
> >  					sig_len,
> >  					VERIFY_USE_PLATFORM_KEYRING,
> > --=20
> > 2.39.5
> >=20

I know nothing about dm-verity. What does it even do?

BR, Jarkko

