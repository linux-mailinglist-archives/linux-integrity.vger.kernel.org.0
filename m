Return-Path: <linux-integrity+bounces-2615-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C658CE633
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2024 15:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3592E1F21F1B
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2024 13:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9071EEE9;
	Fri, 24 May 2024 13:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPf7VTPP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6426C85933;
	Fri, 24 May 2024 13:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716557759; cv=none; b=OlOSqrllVCzSOHbWr+N5G3X/Ef0UztAM20qg4OOuBO/fghzYfLS2jGemy3WICABQ4Sr3+odWZ3qyFsCFyPU0sGVUcnAyi5Am+D4SS2T/a1tYyCFbhovNEchi2Pzukicp996RCIc8irGHO/bfhD91w6YM1e2W8FuwDa/gD9Jffow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716557759; c=relaxed/simple;
	bh=xhFUJ7ACELA27g0oj+rVK3zQCV50xQbFeSMVJScko8Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=UE6dRfZHJXyWL+ZFl6wTgR1ePX+q7kb43kyTIVl7rUt0olwBfgsuTq8KTzsqvh5HrfuFk9tbrygRqEP0gv7Ub9D1KH3OTCv89/ZCJuMJ5YmOkxF7eMJQ8w/3k9RBB5SmcBzdpwXgbTMTSDRtpdYL9tpencReeWOBjmT1/T7M6ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPf7VTPP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE367C2BBFC;
	Fri, 24 May 2024 13:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716557758;
	bh=xhFUJ7ACELA27g0oj+rVK3zQCV50xQbFeSMVJScko8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fPf7VTPPSsmTA64x8QrW39GoCrrE5FknScd1DywfRHTrBZgAx8t/zBq+s9x3VaO6x
	 LxgtonPpiwIWdR+FWAqDLgnhyvZboLkT1TQhDwlnBl/49PAOWYWuIN0btZASCmLV0h
	 +P2pny0p6xE33Y6QCnFJVPr4ISV9Fk8FEJt95gejr+w86PIGo5xiCqH3YmgmaUQP2l
	 YtQ5nJ2hh8BaNeztgwTgwL24iCU6wPoYpXHypJxct1N3KonTBJO5OSSxFbSZ9J/X4g
	 z4/nvalTIEDIABztyZTUvxsJn5RwNLS6IJmO3RPGyyirAKAaLg4tcB1uPsYtcx+dLF
	 zii7J7Qq+/ezg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 May 2024 16:35:56 +0300
Message-Id: <D1HWXUV6417K.2OLSXFURG1G3Y@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
Cc: <keyrings@vger.kernel.org>, "David Howells" <dhowells@redhat.com>
Subject: Re: [PATCH 2/3] KEYS: trusted: use encode_OID for OID encoding
X-Mailer: aerc 0.17.0
References: <20240524125955.20739-1-James.Bottomley@HansenPartnership.com>
 <20240524125955.20739-3-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20240524125955.20739-3-James.Bottomley@HansenPartnership.com>

On Fri May 24, 2024 at 3:59 PM EEST, James Bottomley wrote:
> The new routine takes the OID enum instead of needing the u32 OID
> array explicitly which reduces duplication and the potential for
> mistakes.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  security/keys/trusted-keys/trusted_tpm2.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/tr=
usted-keys/trusted_tpm2.c
> index 9c7ac2e423d3..b6f34ff0ca5c 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -19,8 +19,6 @@
>  #include "tpm2key.asn1.h"
>  #include "tpm2-policy.h"
> =20
> -static u32 tpm2key_oid[] =3D { 2, 23, 133, 10, 1, 5 };
> -
>  static int tpm2_key_encode(struct trusted_key_payload *payload,
>  			   struct trusted_key_options *options,
>  			   u8 *src, u32 len)
> @@ -31,6 +29,7 @@ static int tpm2_key_encode(struct trusted_key_payload *=
payload,
>  	u8 *end_work =3D scratch + SCRATCH_SIZE;
>  	u8 *priv, *pub;
>  	u16 priv_len, pub_len;
> +	int ret;
> =20
>  	priv_len =3D get_unaligned_be16(src) + 2;
>  	priv =3D src;
> @@ -43,8 +42,10 @@ static int tpm2_key_encode(struct trusted_key_payload =
*payload,
>  	if (!scratch)
>  		return -ENOMEM;
> =20
> -	work =3D asn1_encode_oid(work, end_work, tpm2key_oid,
> -			       asn1_oid_len(tpm2key_oid));
> +	ret =3D encode_OID(OID_TPMSealedData, work, end_work - work);
> +	if (ret < 0)
> +		return ret;
> +	work +=3D ret;
> =20
>  	if (options->blobauth_len =3D=3D 0) {
>  		unsigned char bool[3], *w =3D bool;

Yupe, it's better this way.

BR, Jarkko

