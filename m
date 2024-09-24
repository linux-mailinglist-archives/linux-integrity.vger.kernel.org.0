Return-Path: <linux-integrity+bounces-3695-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11478984D21
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 23:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2AB31F2470A
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 21:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF3713D25E;
	Tue, 24 Sep 2024 21:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTktiKHr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DE613B7BC;
	Tue, 24 Sep 2024 21:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215152; cv=none; b=JUW2dp7+mptxV2ISMFbYVCDtxKkMLTdBXVYFHSse3CatbM6I9lLxjqwYU5LVUBvaxN1y4LprTj7IlDLp1CDwptgUjodJMQj7EzIHUrQBOI08xAIOKxvumXJejeU0RvrRiGTg61XdR6jjmPRJEYwXTF3qVNEC2kdSBxZ8MLjfHxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215152; c=relaxed/simple;
	bh=F/QvxXAUbnSi1bOS2nFLFEUmzaLdLpoMAU42kIDG2i0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYTEqs5sKqmncATyGuLEXRKqNVv3mR2M0bCGwGtwwU18IV8XORE48LEnFG1VF9i1brM8LwSOMHy6bgNoy35lWDADIMDLCEgFel3q8kETAGToBdG9fAbdvD3O5wYCcCvwWVVEvNORQdW7XltTs2Y3BsIVbR2V1+Nw2sVSyrSkdJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTktiKHr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF26BC4CEC4;
	Tue, 24 Sep 2024 21:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727215152;
	bh=F/QvxXAUbnSi1bOS2nFLFEUmzaLdLpoMAU42kIDG2i0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BTktiKHr3W5tcOIZDBbVE9H4UT92w7DSGURgFikZAqarzyb1ZMHQm7Hd9/x7DTPKV
	 ZsJDDJSPFT0OEerzCHGTRPDSe6U+9PnzfQNqLCCBDIw7xEz1ZQmBq93OQC/Y37ZG/r
	 bHLTA0wNCzm7UP8u7ksSxaYlTtOTWqT2PZjTDUb51xK3yvgtx0dSRvyy2XUkf07PWs
	 3ddDiVHB0ktQ5Y0K29pAyM5wcrQ3CdCeGylCvwyzqD043l13vQIRdjmCHykGBjXUdY
	 qFmWGf0DCGbgjjWnW2HFqDJPyOsgWWzSZxCjiPrDDkNg6CGD7ZqGhKzzy/0FXvHikT
	 KFbk14mblOi3g==
Date: Tue, 24 Sep 2024 14:59:10 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>, luca.boccassi@gmail.com,
	dm-devel@lists.linux.dev, snitzer@kernel.org, serge@hallyn.com,
	wufan@linux.microsoft.com, David Howells <dhowells@redhat.com>,
	keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH] dm verity: fallback to platform keyring also if key in
 trusted keyring is rejected
Message-ID: <20240924215910.GA1585@sol.localdomain>
References: <20240922161753.244476-1-luca.boccassi@gmail.com>
 <6b3e0e45-5efe-3032-62b8-75dcd45c879c@redhat.com>
 <D4EMWUMBIM94.3PM88QAV6LG6B@kernel.org>
 <7c40c30a-5154-08eb-d44e-6598087c53e6@redhat.com>
 <D4EU6G0VR6WO.24IWJJQC997Y9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D4EU6G0VR6WO.24IWJJQC997Y9@kernel.org>

On Wed, Sep 25, 2024 at 12:36:01AM +0300, Jarkko Sakkinen wrote:
> On Tue Sep 24, 2024 at 9:27 PM EEST, Mikulas Patocka wrote:
> >
> >
> > On Tue, 24 Sep 2024, Jarkko Sakkinen wrote:
> >
> > > On Mon Sep 23, 2024 at 5:04 PM EEST, Mikulas Patocka wrote:
> > > >
> > > >
> > > > On Sun, 22 Sep 2024, luca.boccassi@gmail.com wrote:
> > > >
> > > > > From: Luca Boccassi <bluca@debian.org>
> > > > > 
> > > > > If enabled, we fallback to the platform keyring if the trusted keyring doesn't have
> > > > > the key used to sign the roothash. But if pkcs7_verify() rejects the key for other
> > > > > reasons, such as usage restrictions, we do not fallback. Do so.
> > > > > 
> > > > > Follow-up for 6fce1f40e95182ebbfe1ee3096b8fc0b37903269
> > > > > 
> > > > > Suggested-by: Serge Hallyn <serge@hallyn.com>
> > > > > Signed-off-by: Luca Boccassi <bluca@debian.org>
> > > >
> > > > Hi
> > > >
> > > > I'm not an expert in keyrings.
> > > >
> > > > I added keyring maintainers to the CC. Please review this patch and 
> > > > Ack/Nack it.
> > > >
> > > > Mikulas
> > > >
> > > > > ---
> > > > >  drivers/md/dm-verity-verify-sig.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/md/dm-verity-verify-sig.c b/drivers/md/dm-verity-verify-sig.c
> > > > > index d351d7d39c60..a9e2c6c0a33c 100644
> > > > > --- a/drivers/md/dm-verity-verify-sig.c
> > > > > +++ b/drivers/md/dm-verity-verify-sig.c
> > > > > @@ -127,7 +127,7 @@ int verity_verify_root_hash(const void *root_hash, size_t root_hash_len,
> > > > >  #endif
> > > > >  				VERIFYING_UNSPECIFIED_SIGNATURE, NULL, NULL);
> > > > >  #ifdef CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG_PLATFORM_KEYRING
> > > > > -	if (ret == -ENOKEY)
> > > > > +	if (ret == -ENOKEY || ret == -EKEYREJECTED)
> > > > >  		ret = verify_pkcs7_signature(root_hash, root_hash_len, sig_data,
> > > > >  					sig_len,
> > > > >  					VERIFY_USE_PLATFORM_KEYRING,
> > > > > -- 
> > > > > 2.39.5
> > > > > 
> > > 
> > > I know nothing about dm-verity. What does it even do?
> > > 
> > > BR, Jarkko
> >
> > dm-verity provides a read-only device with integrity checking. dm-verity 
> > stores hash for every block on the block device and checks the hash when 
> > reading the block. If the hash doesn't match, it can do one of these 
> > actions (depending on configuration):
> > - return I/O error
> > - try to correct the data using forward error correction
> > - log the mismatch and do nothing
> > - restart the machine
> > - call panic()
> >
> > dm-verity is mostly used for the immutable system partition on Android 
> > phones. For more info, see 
> > Documentation/admin-guide/device-mapper/verity.rst
> >
> > The above patch changes the way that the signature of the root hash is 
> > verified. I have no clue whether the patch can or can't subvert system 
> > security, that's why I'd like to have some more reviews of the patch 
> > before accepting it.
> 
> I guess someone who knows all this already should review it.
> 
> Doesn't dm-verity have a maintainer?
> 

This patch only affects dm-verity's in-kernel signature verification support,
which has only been present since Linux v5.4 and is not used by Android or
Chrome OS.  The whole feature seems weird to me, and it is prone to be misused;
signatures are best verified by trusted userspace code instead (e.g. initramfs).
But apparently there are people who use the dm-verity in-kernel signatures.  I
think systemd has some support for it, as does the recently-upstreamed IPE LSM.
I don't know what else.  The exact semantics of the "trusted" and "platform"
keyrings are not entirely clear to me, but given that dm-verity already trusts
keys from both keyrings this patch seems reasonable.  The people who actually
use this feature are in the best position to make that call, though.

- Eric

