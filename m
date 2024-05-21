Return-Path: <linux-integrity+bounces-2499-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8133C8CA7F6
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 08:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3999D1F21746
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 06:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9AD446B4;
	Tue, 21 May 2024 06:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zk6wIy05"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714382F873;
	Tue, 21 May 2024 06:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716272479; cv=none; b=m5KGJW9XPMcotqgb+7MMK2nl/ozZqgFi/qdDeO9JTbR5iD64waPj/pQuNwqyH18c1icjzjStU/oZOG5ezOa05MQ7gBGkh2z1pXFrbiEat/GzKmUWuFLk0pWxPRy3XbYZ0Ox5fMxZItjSqk8yQATBR3k5ftSM8VseLtTzXq1iY6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716272479; c=relaxed/simple;
	bh=QyUpE9XMBlIHRQI24cofeK5f6AJE0q3j683mGK5cjDY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=kJ1LW1FEAO6obSAZnQhd235kSPdukWAcGCE9e//h51ofpJkKijoFMS9yOKAdNNnUeDHsBVUxximAhB/btsKauRaocmJ790V0FIDhqvto1G2lb2qLg91JUnpZfS67TYXO2jXRwlsJlb05hzSUDdLiCfPFe5CR6Vx5nMC5Rqoiem8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zk6wIy05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164CBC2BD11;
	Tue, 21 May 2024 06:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716272479;
	bh=QyUpE9XMBlIHRQI24cofeK5f6AJE0q3j683mGK5cjDY=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Zk6wIy05euOzmcXyJOhTEMXSwUCBLLbNmutx4DJWeQKgDBCsGHTdgJ2ye40xhT7Bx
	 E7tEs0ICA6UnoPtZidAmJxR96tVEtqw24CCfjv1adGEOR/xwiPFEhgF8pMWYvuD4fn
	 +Ftd7ZLD2YAeivD+WrNUfCbSwlAea0diZhY67GXE9g4LzIOoGU8JAHVzv7/ZCWFgTu
	 V0UVpqskI52zf4oDajPygkppndTTDdoKh5vOLY3CleXkGNugG2kKf6YWD8BFCC9APH
	 rKAJPHN19uITBasQD8Id7qIkJY2krieGpzuHRpuwIB4Hx2vylCiM8myEHLudLfkCiy
	 LCmB8FfKRf3ww==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 May 2024 09:21:13 +0300
Message-Id: <D1F3TDIAMTW0.2X7QDQ6TSUAGT@kernel.org>
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
 "Andreas.Fuchs@infineon.com" <Andreas.Fuchs@infineon.com>, "James
 Prestwood" <prestwoj@gmail.com>, "David Woodhouse" <dwmw2@infradead.org>,
 "Eric Biggers" <ebiggers@kernel.org>, "James Bottomley"
 <James.Bottomley@hansenpartnership.com>, "David S. Miller"
 <davem@davemloft.net>, "open list:CRYPTO API"
 <linux-crypto@vger.kernel.org>, "open list" <linux-kernel@vger.kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "open list:SECURITY SUBSYSTEM"
 <linux-security-module@vger.kernel.org>
Subject: Re: [EXTERNAL] [PATCH v2 2/6] lib: Expand asn1_encode_integer() to
 variable size integers
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Bharat Bhushan" <bbhushan2@marvell.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>
X-Mailer: aerc 0.17.0
References: <20240521031645.17008-1-jarkko@kernel.org>
 <20240521031645.17008-3-jarkko@kernel.org>
 <SN7PR18MB5314CFBD18B011F292809EBFE3EA2@SN7PR18MB5314.namprd18.prod.outlook.com>
In-Reply-To: <
 <SN7PR18MB5314CFBD18B011F292809EBFE3EA2@SN7PR18MB5314.namprd18.prod.outlook.com>

On Tue May 21, 2024 at 8:36 AM EEST, Bharat Bhushan wrote:
> > -	data_len -=3D 2;
> > +	(*data++) =3D _tag(UNIV, PRIM, INT);
>
> Just for my clarification:=20
> 	First index of "data" is updated here with tag and data pointer incremen=
ted.
> 	Next comment for continuation
>
> > +	data_len--;
> >=20
> > -	data[0] =3D _tag(UNIV, PRIM, INT);
> > -	if (integer =3D=3D 0) {
> > -		*d++ =3D 0;
> > -		goto out;
> > +	if (!memchr_inv(integer, 0, integer_len)) {
> > +		data[1] =3D 1;
> > +		data[2] =3D 0;
> > +		return &data[2];
>
> Here we are effectively setting second and third index of original
> "data" pointer as "data" pointer was incremented earlier.
> So second index of original "data" pointer is not touched. Also
> returning 3rd index pointer of original data pointer
>
> Is that intentional?

No! I read the diff few times, and I think you have a point.

Indices should be 0 (length) and 1 (value). I.e. it forms an encoded
version of zero. The last index what it should be, i.e. return address
of the next byte after the encoded integer.

Thanks for pointing this out.

> Thanks
> -Bharat

BR, Jarkko

