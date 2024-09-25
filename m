Return-Path: <linux-integrity+bounces-3698-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3B6985492
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Sep 2024 09:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C1EE287CC3
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Sep 2024 07:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D5F155301;
	Wed, 25 Sep 2024 07:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pi+6W0lP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED59B147C9B;
	Wed, 25 Sep 2024 07:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727250699; cv=none; b=qdGsGqwrBYPIrtUCneh0uMK1uECv0/VEakUgbJuOzoNSMZjMaXKWkQaIozRg8Rbmc1csMJ28igXnOHtaUEg6Ij69k1Xx0vaJBXwq7bmsdBTnge3YhLOV3+96pAh7V9Z+qovA2X9gUgsyO/C/YZEpWS9C6OticHGoS6nE9ZfCXbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727250699; c=relaxed/simple;
	bh=aPtVdD4i0rp8fodPzF3sa54QtUAHnu1iyH03WYgopBI=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=qiMvE2W5weV/OVgoY6/rLj66yQhrsi3dAEEwJkHP0jI3iCS9xqK2p/aWIGVSNTcZ2UM7vj/Ru/1+ftRAkKlYCUzrx0gGKpcx07rCNYX2B56bWo6w/jTenkgfqg3VlRs1T+StebdP6zDUkGPaHjJcAiXm3pVDzsZYCLrJhASjOxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pi+6W0lP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A2DC4CEC3;
	Wed, 25 Sep 2024 07:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727250698;
	bh=aPtVdD4i0rp8fodPzF3sa54QtUAHnu1iyH03WYgopBI=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=pi+6W0lPzek1C6yVSuL84U2YtH57tS0hAFiDfswg9Exx3/bOa/fnKRu1kL6+4+uSx
	 7NcY0g1eQ4k1EFF+MTZL/y+yZGygdNQ8LgpkguZCOBnKW71sv8x1YralZs2bFkQnLi
	 pjD+G6c3H7jg66SywQuTHaSDFSUQ39OAuNaOiUCJkd9mh5wDV6CcKa8oLl+DEYMXBx
	 BIsBQ2c5YwvCgt57V3FQV+GISygznS/sseRB33sAA2KApQ3LuRQiW9iBIBbytuQR+T
	 erFRZREvOD0uYtE/cHlrg6TbSwTWxDe/FWMHcmMoU3RtjyPBmypcfZfgS65qAH55+F
	 aViRMNQv+rbzQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Sep 2024 10:51:34 +0300
Message-Id: <D4F79QY76VNH.2VA0SMMNTXUR@kernel.org>
To: "Eric Biggers" <ebiggers@kernel.org>
Cc: "Mikulas Patocka" <mpatocka@redhat.com>, <luca.boccassi@gmail.com>,
 <dm-devel@lists.linux.dev>, <snitzer@kernel.org>, <serge@hallyn.com>,
 <wufan@linux.microsoft.com>, "David Howells" <dhowells@redhat.com>,
 <keyrings@vger.kernel.org>, <linux-integrity@vger.kernel.org>, "Mimi Zohar"
 <zohar@linux.ibm.com>
Subject: Re: [PATCH] dm verity: fallback to platform keyring also if key in
 trusted keyring is rejected
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.18.2
References: <20240922161753.244476-1-luca.boccassi@gmail.com>
 <6b3e0e45-5efe-3032-62b8-75dcd45c879c@redhat.com>
 <D4EMWUMBIM94.3PM88QAV6LG6B@kernel.org>
 <7c40c30a-5154-08eb-d44e-6598087c53e6@redhat.com>
 <D4EU6G0VR6WO.24IWJJQC997Y9@kernel.org>
 <20240924215910.GA1585@sol.localdomain>
In-Reply-To: <20240924215910.GA1585@sol.localdomain>

On Wed Sep 25, 2024 at 12:59 AM EEST, Eric Biggers wrote:
> On Wed, Sep 25, 2024 at 12:36:01AM +0300, Jarkko Sakkinen wrote:
> > On Tue Sep 24, 2024 at 9:27 PM EEST, Mikulas Patocka wrote:
> > >
> > >
> > > On Tue, 24 Sep 2024, Jarkko Sakkinen wrote:
> > >
> > > > On Mon Sep 23, 2024 at 5:04 PM EEST, Mikulas Patocka wrote:
> > > > >
> > > > >
> > > > > On Sun, 22 Sep 2024, luca.boccassi@gmail.com wrote:
> > > > >
> > > > > > From: Luca Boccassi <bluca@debian.org>
> > > > > >=20
> > > > > > If enabled, we fallback to the platform keyring if the trusted =
keyring doesn't have
> > > > > > the key used to sign the roothash. But if pkcs7_verify() reject=
s the key for other
> > > > > > reasons, such as usage restrictions, we do not fallback. Do so.
> > > > > >=20
> > > > > > Follow-up for 6fce1f40e95182ebbfe1ee3096b8fc0b37903269
> > > > > >=20
> > > > > > Suggested-by: Serge Hallyn <serge@hallyn.com>
> > > > > > Signed-off-by: Luca Boccassi <bluca@debian.org>
> > > > >
> > > > > Hi
> > > > >
> > > > > I'm not an expert in keyrings.
> > > > >
> > > > > I added keyring maintainers to the CC. Please review this patch a=
nd=20
> > > > > Ack/Nack it.
> > > > >
> > > > > Mikulas
> > > > >
> > > > > > ---
> > > > > >  drivers/md/dm-verity-verify-sig.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >=20
> > > > > > diff --git a/drivers/md/dm-verity-verify-sig.c b/drivers/md/dm-=
verity-verify-sig.c
> > > > > > index d351d7d39c60..a9e2c6c0a33c 100644
> > > > > > --- a/drivers/md/dm-verity-verify-sig.c
> > > > > > +++ b/drivers/md/dm-verity-verify-sig.c
> > > > > > @@ -127,7 +127,7 @@ int verity_verify_root_hash(const void *roo=
t_hash, size_t root_hash_len,
> > > > > >  #endif
> > > > > >  				VERIFYING_UNSPECIFIED_SIGNATURE, NULL, NULL);
> > > > > >  #ifdef CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG_PLATFORM_KEYRING
> > > > > > -	if (ret =3D=3D -ENOKEY)
> > > > > > +	if (ret =3D=3D -ENOKEY || ret =3D=3D -EKEYREJECTED)
> > > > > >  		ret =3D verify_pkcs7_signature(root_hash, root_hash_len, sig=
_data,
> > > > > >  					sig_len,
> > > > > >  					VERIFY_USE_PLATFORM_KEYRING,
> > > > > > --=20
> > > > > > 2.39.5
> > > > > >=20
> > > >=20
> > > > I know nothing about dm-verity. What does it even do?
> > > >=20
> > > > BR, Jarkko
> > >
> > > dm-verity provides a read-only device with integrity checking. dm-ver=
ity=20
> > > stores hash for every block on the block device and checks the hash w=
hen=20
> > > reading the block. If the hash doesn't match, it can do one of these=
=20
> > > actions (depending on configuration):
> > > - return I/O error
> > > - try to correct the data using forward error correction
> > > - log the mismatch and do nothing
> > > - restart the machine
> > > - call panic()
> > >
> > > dm-verity is mostly used for the immutable system partition on Androi=
d=20
> > > phones. For more info, see=20
> > > Documentation/admin-guide/device-mapper/verity.rst
> > >
> > > The above patch changes the way that the signature of the root hash i=
s=20
> > > verified. I have no clue whether the patch can or can't subvert syste=
m=20
> > > security, that's why I'd like to have some more reviews of the patch=
=20
> > > before accepting it.
> >=20
> > I guess someone who knows all this already should review it.
> >=20
> > Doesn't dm-verity have a maintainer?
> >=20
>
> This patch only affects dm-verity's in-kernel signature verification supp=
ort,
> which has only been present since Linux v5.4 and is not used by Android o=
r
> Chrome OS.  The whole feature seems weird to me, and it is prone to be mi=
sused;
> signatures are best verified by trusted userspace code instead (e.g. init=
ramfs).
> But apparently there are people who use the dm-verity in-kernel signature=
s.  I
> think systemd has some support for it, as does the recently-upstreamed IP=
E LSM.
> I don't know what else.  The exact semantics of the "trusted" and "platfo=
rm"
> keyrings are not entirely clear to me, but given that dm-verity already t=
rusts
> keys from both keyrings this patch seems reasonable.  The people who actu=
ally
> use this feature are in the best position to make that call, though.

https://lwn.net/Articles/459420/

Isn't Netflix using FreeBSD these days? :-)

Right, and Chromebooks also mentioned in the same article (from 2011).

For me this looks almost like abaddonware...

>
> - Eric

BR, Jarkko

