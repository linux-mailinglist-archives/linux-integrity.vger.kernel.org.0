Return-Path: <linux-integrity+bounces-3693-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B86D5984CF1
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 23:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A7C280E1B
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 21:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB4783CD5;
	Tue, 24 Sep 2024 21:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mq9+drAL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5C917557;
	Tue, 24 Sep 2024 21:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727213765; cv=none; b=JRmXxeyhff+2RiAc9Xcgno7vbvPW6ztz9kCrqBZ7Pl4+KSKb6QnGep4YJFqHSuiBRVeO7vcBeFRnQ7aRfnArjh+xtS+j95YjZAnOqtuh3C4dfayq37UktRZbK/0jrLobvoAYE6kAxMsEO7LmjkJcWHZVOlJHLUK7CkAsPqOUqDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727213765; c=relaxed/simple;
	bh=VOPVoB96wqRQWbs2yxK7TzpMOr+HeXFcChOhv2jWSVI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=sU9OU/Agsu7YLXk9N2gAnwo6kM/KomkfPYYeCLTbPwGIkE8eM/IC5xtH2ZHq4vmMT2nKY9IuIOykzSIp/WTx0TynL+HxVuNbyBCywV4z2UX98QbuaVvVJy/ThbcdwhY2S5hVktK/KBtfQSPLZRtn0INtQTSVYZj1ppqJWZHxL8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mq9+drAL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AF8C4CEC4;
	Tue, 24 Sep 2024 21:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727213765;
	bh=VOPVoB96wqRQWbs2yxK7TzpMOr+HeXFcChOhv2jWSVI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=mq9+drALDar7F+zRNo6FUP7BXXR2ix0G0gVdGKzqsWDMYkpOVqtJLkTuaWm396hlB
	 EPXTyqFR19HVJTIB7VpVpm4gao9zxr0aSgz72GcUc5AM5uQVzysQCFQXFpioklGPI4
	 i8HHXwACJgGTLT162DHGMbFraRI2BbcCURkQvX65hQ+LeajCpG7Rx+YhBIwUHdW+j4
	 u5+Axq2QSaMTvaFOMtpSz6mYp0aNNrVK2xcbXTOKViyswNd9AYkJLWjkwCdaWJYyqU
	 Q847MFkjs2vlUpkHDGuwojEGCWRuHxptKnjuYuysnLkE1MbStPNPGx2qjmQx8kXQoh
	 cDavvKzXGn1dw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Sep 2024 00:36:01 +0300
Message-Id: <D4EU6G0VR6WO.24IWJJQC997Y9@kernel.org>
Cc: <luca.boccassi@gmail.com>, <dm-devel@lists.linux.dev>,
 <snitzer@kernel.org>, <serge@hallyn.com>, <wufan@linux.microsoft.com>,
 "David Howells" <dhowells@redhat.com>, <keyrings@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, "Mimi Zohar" <zohar@linux.ibm.com>
Subject: Re: [PATCH] dm verity: fallback to platform keyring also if key in
 trusted keyring is rejected
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Mikulas Patocka" <mpatocka@redhat.com>
X-Mailer: aerc 0.18.2
References: <20240922161753.244476-1-luca.boccassi@gmail.com>
 <6b3e0e45-5efe-3032-62b8-75dcd45c879c@redhat.com>
 <D4EMWUMBIM94.3PM88QAV6LG6B@kernel.org>
 <7c40c30a-5154-08eb-d44e-6598087c53e6@redhat.com>
In-Reply-To: <7c40c30a-5154-08eb-d44e-6598087c53e6@redhat.com>

On Tue Sep 24, 2024 at 9:27 PM EEST, Mikulas Patocka wrote:
>
>
> On Tue, 24 Sep 2024, Jarkko Sakkinen wrote:
>
> > On Mon Sep 23, 2024 at 5:04 PM EEST, Mikulas Patocka wrote:
> > >
> > >
> > > On Sun, 22 Sep 2024, luca.boccassi@gmail.com wrote:
> > >
> > > > From: Luca Boccassi <bluca@debian.org>
> > > >=20
> > > > If enabled, we fallback to the platform keyring if the trusted keyr=
ing doesn't have
> > > > the key used to sign the roothash. But if pkcs7_verify() rejects th=
e key for other
> > > > reasons, such as usage restrictions, we do not fallback. Do so.
> > > >=20
> > > > Follow-up for 6fce1f40e95182ebbfe1ee3096b8fc0b37903269
> > > >=20
> > > > Suggested-by: Serge Hallyn <serge@hallyn.com>
> > > > Signed-off-by: Luca Boccassi <bluca@debian.org>
> > >
> > > Hi
> > >
> > > I'm not an expert in keyrings.
> > >
> > > I added keyring maintainers to the CC. Please review this patch and=
=20
> > > Ack/Nack it.
> > >
> > > Mikulas
> > >
> > > > ---
> > > >  drivers/md/dm-verity-verify-sig.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/drivers/md/dm-verity-verify-sig.c b/drivers/md/dm-veri=
ty-verify-sig.c
> > > > index d351d7d39c60..a9e2c6c0a33c 100644
> > > > --- a/drivers/md/dm-verity-verify-sig.c
> > > > +++ b/drivers/md/dm-verity-verify-sig.c
> > > > @@ -127,7 +127,7 @@ int verity_verify_root_hash(const void *root_ha=
sh, size_t root_hash_len,
> > > >  #endif
> > > >  				VERIFYING_UNSPECIFIED_SIGNATURE, NULL, NULL);
> > > >  #ifdef CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG_PLATFORM_KEYRING
> > > > -	if (ret =3D=3D -ENOKEY)
> > > > +	if (ret =3D=3D -ENOKEY || ret =3D=3D -EKEYREJECTED)
> > > >  		ret =3D verify_pkcs7_signature(root_hash, root_hash_len, sig_dat=
a,
> > > >  					sig_len,
> > > >  					VERIFY_USE_PLATFORM_KEYRING,
> > > > --=20
> > > > 2.39.5
> > > >=20
> >=20
> > I know nothing about dm-verity. What does it even do?
> >=20
> > BR, Jarkko
>
> dm-verity provides a read-only device with integrity checking. dm-verity=
=20
> stores hash for every block on the block device and checks the hash when=
=20
> reading the block. If the hash doesn't match, it can do one of these=20
> actions (depending on configuration):
> - return I/O error
> - try to correct the data using forward error correction
> - log the mismatch and do nothing
> - restart the machine
> - call panic()
>
> dm-verity is mostly used for the immutable system partition on Android=20
> phones. For more info, see=20
> Documentation/admin-guide/device-mapper/verity.rst
>
> The above patch changes the way that the signature of the root hash is=20
> verified. I have no clue whether the patch can or can't subvert system=20
> security, that's why I'd like to have some more reviews of the patch=20
> before accepting it.

I guess someone who knows all this already should review it.

Doesn't dm-verity have a maintainer?

BR, Jarkko

