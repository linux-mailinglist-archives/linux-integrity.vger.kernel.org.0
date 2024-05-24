Return-Path: <linux-integrity+bounces-2616-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B82218CE639
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2024 15:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1111F21FA0
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2024 13:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A540C85C6C;
	Fri, 24 May 2024 13:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rxk3ngRc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAD91EEE9;
	Fri, 24 May 2024 13:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716557799; cv=none; b=or40afcC63rnOH2LCO9BovYUHXizv2JXkM7ttZRrwfgCLcRSpaX48i9mIWijJ3Pc7C7QTRFklU3zTuWshJqfH3HoyQg2sWXixquNWf2CUF2oq4iBRtmCCCI05KNJHtckXExVaG/AvU8XnqGevcuM9N8fDejhiQbJ7be+IKiyRhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716557799; c=relaxed/simple;
	bh=FtEAemUtjsfVtrnf/dndIkNJYf7ABSYOe9TvL7t1G8k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rcnoPubvZFH4kCATp5oykDMv+siz+d35LnUvbI6YUAO+GtYuseHh919dO29nnpwGTpF6vE4sZk0MM7FkeTT1I0LdEB3MMlx3MTR2GPQ69DjlicK/BLx3Wic+5Kenl91hAWL91nFEVrRiD1K0QXUkU12hg1cNYcd669+MlWMkUm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rxk3ngRc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F329C2BBFC;
	Fri, 24 May 2024 13:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716557799;
	bh=FtEAemUtjsfVtrnf/dndIkNJYf7ABSYOe9TvL7t1G8k=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Rxk3ngRcNYX/tBMiEbekupwuTx6xPQPDMIpy2j/TFC+s1ff8grBH361Tp3sEH0pVa
	 qTSxVE8R7AG0nn7CSwuV/lvqicIGDeUN4CBVRvzRlGoeN7vcbfi7lPJyeN9T/dmSwZ
	 Bd6yP/QMfjqxAConXl28jhpXrBr6TXBhcWfNFoPIikkZFSWBftx6KjrEp+LwaRisbz
	 Vma2U0+Va0gSZwmmpc1dYkNwIrE0b4xGPznLDl7KEa6TeK9UJw2da2ovU8vidPAtnA
	 +X5aPiSnYIB2UgtrQ4nAAHNSawgtvZ1q+6ko03h2TI5dvne/FbnV648pzgFR0Vd4KA
	 ddt9TJgJtQTng==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 May 2024 16:36:36 +0300
Message-Id: <D1HWYD30PATS.2RPJ8RD2CU67O@kernel.org>
Cc: <keyrings@vger.kernel.org>, "David Howells" <dhowells@redhat.com>
Subject: Re: [PATCH 3/3] lib: asn1_encode: remove obsolete asn1_encode_oid
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240524125955.20739-1-James.Bottomley@HansenPartnership.com>
 <20240524125955.20739-4-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20240524125955.20739-4-James.Bottomley@HansenPartnership.com>

On Fri May 24, 2024 at 3:59 PM EEST, James Bottomley wrote:
> This has been replaced by encode_OID from the OID_registry.  To use,
> consumers must make sure the OID is present in enum OID in
> oid_registry.h and then use encode_OID with the enum.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  include/linux/asn1_encoder.h |  3 --
>  lib/asn1_encoder.c           | 91 ------------------------------------
>  2 files changed, 94 deletions(-)
>
> diff --git a/include/linux/asn1_encoder.h b/include/linux/asn1_encoder.h
> index 08cd0c2ad34f..5f8cf47ede59 100644
> --- a/include/linux/asn1_encoder.h
> +++ b/include/linux/asn1_encoder.h
> @@ -13,9 +13,6 @@ unsigned char *
>  asn1_encode_integer(unsigned char *data, const unsigned char *end_data,
>  		    s64 integer);
>  unsigned char *
> -asn1_encode_oid(unsigned char *data, const unsigned char *end_data,
> -		u32 oid[], int oid_len);
> -unsigned char *
>  asn1_encode_tag(unsigned char *data, const unsigned char *end_data,
>  		u32 tag, const unsigned char *string, int len);
>  unsigned char *
> diff --git a/lib/asn1_encoder.c b/lib/asn1_encoder.c
> index 0fd3c454a468..c0db3cbebe89 100644
> --- a/lib/asn1_encoder.c
> +++ b/lib/asn1_encoder.c
> @@ -85,97 +85,6 @@ asn1_encode_integer(unsigned char *data, const unsigne=
d char *end_data,
>  }
>  EXPORT_SYMBOL_GPL(asn1_encode_integer);
> =20
> -/* calculate the base 128 digit values setting the top bit of the first =
octet */
> -static int asn1_encode_oid_digit(unsigned char **_data, int *data_len, u=
32 oid)
> -{
> -	unsigned char *data =3D *_data;
> -	int start =3D 7 + 7 + 7 + 7;
> -	int ret =3D 0;
> -
> -	if (*data_len < 1)
> -		return -EINVAL;
> -
> -	/* quick case */
> -	if (oid =3D=3D 0) {
> -		*data++ =3D 0x80;
> -		(*data_len)--;
> -		goto out;
> -	}
> -
> -	while (oid >> start =3D=3D 0)
> -		start -=3D 7;
> -
> -	while (start > 0 && *data_len > 0) {
> -		u8 byte;
> -
> -		byte =3D oid >> start;
> -		oid =3D oid - (byte << start);
> -		start -=3D 7;
> -		byte |=3D 0x80;
> -		*data++ =3D byte;
> -		(*data_len)--;
> -	}
> -
> -	if (*data_len > 0) {
> -		*data++ =3D oid;
> -		(*data_len)--;
> -	} else {
> -		ret =3D -EINVAL;
> -	}
> -
> - out:
> -	*_data =3D data;
> -	return ret;
> -}
> -
> -/**
> - * asn1_encode_oid() - encode an oid to ASN.1
> - * @data:	position to begin encoding at
> - * @end_data:	end of data pointer, points one beyond last usable byte in=
 @data
> - * @oid:	array of oids
> - * @oid_len:	length of oid array
> - *
> - * this encodes an OID up to ASN.1 when presented as an array of OID val=
ues
> - */
> -unsigned char *
> -asn1_encode_oid(unsigned char *data, const unsigned char *end_data,
> -		u32 oid[], int oid_len)
> -{
> -	int data_len =3D end_data - data;
> -	unsigned char *d =3D data + 2;
> -	int i, ret;
> -
> -	if (WARN(oid_len < 2, "OID must have at least two elements"))
> -		return ERR_PTR(-EINVAL);
> -
> -	if (WARN(oid_len > 32, "OID is too large"))
> -		return ERR_PTR(-EINVAL);
> -
> -	if (IS_ERR(data))
> -		return data;
> -
> -
> -	/* need at least 3 bytes for tag, length and OID encoding */
> -	if (data_len < 3)
> -		return ERR_PTR(-EINVAL);
> -
> -	data[0] =3D _tag(UNIV, PRIM, OID);
> -	*d++ =3D oid[0] * 40 + oid[1];
> -
> -	data_len -=3D 3;
> -
> -	for (i =3D 2; i < oid_len; i++) {
> -		ret =3D asn1_encode_oid_digit(&d, &data_len, oid[i]);
> -		if (ret < 0)
> -			return ERR_PTR(ret);
> -	}
> -
> -	data[1] =3D d - data - 2;
> -
> -	return d;
> -}
> -EXPORT_SYMBOL_GPL(asn1_encode_oid);
> -
>  /**
>   * asn1_encode_length() - encode a length to follow an ASN.1 tag
>   * @data: pointer to encode at

Obvious change but I skip R-y's before the first patch has been
fixed (no use for anyone to tag them).

BR, Jarkko

