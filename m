Return-Path: <linux-integrity+bounces-3690-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A508984AD6
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 20:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23EADB2186C
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 18:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6165B1AB6F9;
	Tue, 24 Sep 2024 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gG/UXIpW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA4911CA0
	for <linux-integrity@vger.kernel.org>; Tue, 24 Sep 2024 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727202490; cv=none; b=Y+97iPgE2VmgQUyEqq1VXZ1IqnCKv37gpENNyUIOgh+jdR1AHSxEGBAJ1YFobjxMEb5nfgmcmnJt467B6drVxu7L1UhLbs6Bg+GL2RBkaUYrH2StIg7hfTDusRvCrN5ugiRSVqoXsfJC9b2mxInAKhgC4WX2rD0JV9EW6SzdzDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727202490; c=relaxed/simple;
	bh=5SMjsrCjECPHKcC2m2WAYi0i4UBAszysMeFbCiUs5Yg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=i/Pq7c70NWgcSXkOQaSu3XJ32erRY/g/voxoKcuqy+QelTngc2aLvMScampcbkO0YFEQuGhf+UXwQrtvvYdMO3jl3KF4SC20NkLjwehHZSOOChqF1Q99i6Kr8YOCYegtu5k2Jp/KSu8kYxJ9FMiQe8nPkRUOJ3lcIthDErnP8wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gG/UXIpW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727202487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QP+1N8REoRxKBdYYuKpBVw7Tf3FYIj+GVn6G4LuDBlI=;
	b=gG/UXIpW4OCvXI7vPIvaM5INx36+sSEZlaTR2u6oAPSwGtaziEChrF0icY3cOwH0ICWNt2
	KNeghXC9DiolgWawCWDub9EG65owQFAHxZRrsCNxMRZQJJm49EGZGHhnB4JWLtfmM/men/
	C8zY9Wk4z2VleKPPvjp5MTAPvpaHDMc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-qR6R8Ya_MzyQ87w8Qac1vQ-1; Tue,
 24 Sep 2024 14:28:04 -0400
X-MC-Unique: qR6R8Ya_MzyQ87w8Qac1vQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 34FD218F94D3;
	Tue, 24 Sep 2024 18:27:53 +0000 (UTC)
Received: from [10.45.226.79] (unknown [10.45.226.79])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0FFF01956054;
	Tue, 24 Sep 2024 18:27:49 +0000 (UTC)
Date: Tue, 24 Sep 2024 20:27:47 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
cc: luca.boccassi@gmail.com, dm-devel@lists.linux.dev, snitzer@kernel.org, 
    serge@hallyn.com, wufan@linux.microsoft.com, 
    David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, 
    linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH] dm verity: fallback to platform keyring also if key in
 trusted keyring is rejected
In-Reply-To: <D4EMWUMBIM94.3PM88QAV6LG6B@kernel.org>
Message-ID: <7c40c30a-5154-08eb-d44e-6598087c53e6@redhat.com>
References: <20240922161753.244476-1-luca.boccassi@gmail.com> <6b3e0e45-5efe-3032-62b8-75dcd45c879c@redhat.com> <D4EMWUMBIM94.3PM88QAV6LG6B@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40



On Tue, 24 Sep 2024, Jarkko Sakkinen wrote:

> On Mon Sep 23, 2024 at 5:04 PM EEST, Mikulas Patocka wrote:
> >
> >
> > On Sun, 22 Sep 2024, luca.boccassi@gmail.com wrote:
> >
> > > From: Luca Boccassi <bluca@debian.org>
> > > 
> > > If enabled, we fallback to the platform keyring if the trusted keyring doesn't have
> > > the key used to sign the roothash. But if pkcs7_verify() rejects the key for other
> > > reasons, such as usage restrictions, we do not fallback. Do so.
> > > 
> > > Follow-up for 6fce1f40e95182ebbfe1ee3096b8fc0b37903269
> > > 
> > > Suggested-by: Serge Hallyn <serge@hallyn.com>
> > > Signed-off-by: Luca Boccassi <bluca@debian.org>
> >
> > Hi
> >
> > I'm not an expert in keyrings.
> >
> > I added keyring maintainers to the CC. Please review this patch and 
> > Ack/Nack it.
> >
> > Mikulas
> >
> > > ---
> > >  drivers/md/dm-verity-verify-sig.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/md/dm-verity-verify-sig.c b/drivers/md/dm-verity-verify-sig.c
> > > index d351d7d39c60..a9e2c6c0a33c 100644
> > > --- a/drivers/md/dm-verity-verify-sig.c
> > > +++ b/drivers/md/dm-verity-verify-sig.c
> > > @@ -127,7 +127,7 @@ int verity_verify_root_hash(const void *root_hash, size_t root_hash_len,
> > >  #endif
> > >  				VERIFYING_UNSPECIFIED_SIGNATURE, NULL, NULL);
> > >  #ifdef CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG_PLATFORM_KEYRING
> > > -	if (ret == -ENOKEY)
> > > +	if (ret == -ENOKEY || ret == -EKEYREJECTED)
> > >  		ret = verify_pkcs7_signature(root_hash, root_hash_len, sig_data,
> > >  					sig_len,
> > >  					VERIFY_USE_PLATFORM_KEYRING,
> > > -- 
> > > 2.39.5
> > > 
> 
> I know nothing about dm-verity. What does it even do?
> 
> BR, Jarkko

dm-verity provides a read-only device with integrity checking. dm-verity 
stores hash for every block on the block device and checks the hash when 
reading the block. If the hash doesn't match, it can do one of these 
actions (depending on configuration):
- return I/O error
- try to correct the data using forward error correction
- log the mismatch and do nothing
- restart the machine
- call panic()

dm-verity is mostly used for the immutable system partition on Android 
phones. For more info, see 
Documentation/admin-guide/device-mapper/verity.rst

The above patch changes the way that the signature of the root hash is 
verified. I have no clue whether the patch can or can't subvert system 
security, that's why I'd like to have some more reviews of the patch 
before accepting it.

Mikulas


