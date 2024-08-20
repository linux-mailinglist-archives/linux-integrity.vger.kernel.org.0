Return-Path: <linux-integrity+bounces-3371-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0389588B9
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Aug 2024 16:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D054B281331
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Aug 2024 14:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB53191476;
	Tue, 20 Aug 2024 14:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="sc4WoPTW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B69190063;
	Tue, 20 Aug 2024 14:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724163170; cv=none; b=Rm8Px6/3HNnEf5KFB30GwES5Nb4ALKsTz8psmGSngKM+Mycj2M/E4qvKqa0OLuAhiK2CjIa5pinJcPrxr4O8JZXJuSUV2QzEs/xd+mOiBfcwCRPdnjg/swt58mzb5Z38oSQsAqB/iDsvwU53Pjde4EQa46iEarsy6qrAoT6awiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724163170; c=relaxed/simple;
	bh=xCm+R7dWMsmwLz1zgrGme9ozbwxy6Z3x1Hpt7b5YCnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TycGp04my0IKAg3KKidGr5YqgT/KgdoITV31q0erOZ8yo8EPKv7npj3EmcmF4aw2jzK2+7S6o4H0/1p8xhTrS+rNTdmzRZvFvPJJ+W6aikLc7vfEQgapdVPLfUhwggI8qSlgEByS1OIhLnp6p4+RwOymyehW0mzW+UUsEcDfNLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=sc4WoPTW; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=1JNAEDSSBLyxH0+wmOKl5l1dFHDLY97Al/HN/F7EsE8=; b=sc4WoPTWw4MjIhwhpO0EhaSnAH
	dnC9dA4hz4Ed9SwBp5NO7Uv8UTyIF1g+8oM8hMzAT4AIEIVmUR53CjkEpemVrjWUoPpizRqwGV89y
	KGV58/PMcTzem+oFpAWqKDG4RU1ByrXb+nYoI5JIlPMUuhsYrIplvlJBxbU2KK9ttydO45w3mZyvL
	SfkizR9PV+xNUdsjVIGPVw9efhxwOkSSqTD3SSkCtYV8PNnf6Q1riWX/mJKHuvU1wGAQH7BJN87ev
	C+OWFKn01kkFzuM0dsJA5iWz1xiMUolDTtoCHroYbD/xbTHd4JpUyL40TOH5cXo9Z0LvVm/DbeVPE
	yiEYEQDQ==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1sgPb4-001ipC-24;
	Tue, 20 Aug 2024 15:12:30 +0100
Date: Tue, 20 Aug 2024 15:12:30 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: dhowells@redhat.com, dwmw2@infradead.org, herbert@gondor.apana.org.au,
	davem@davemloft.net, linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
	zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v2 00/14] KEYS: Add support for PGP keys and signatures
Message-ID: <ZsSkTs4TFfx2pK8r@earth.li>
References: <20240818165756.629203-1-roberto.sassu@huaweicloud.com>
 <ZsNf1VdfkHqD8R4Q@earth.li>
 <f142b1c4e662d4701a2ab67fa5fc839ab7109e5e.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f142b1c4e662d4701a2ab67fa5fc839ab7109e5e.camel@huaweicloud.com>

On Mon, Aug 19, 2024 at 05:15:02PM +0200, Roberto Sassu wrote:
> On Mon, 2024-08-19 at 16:08 +0100, Jonathan McDowell wrote:
> > On Sun, Aug 18, 2024 at 06:57:42PM +0200, Roberto Sassu wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > 
> > > Support for PGP keys and signatures was proposed by David long time ago,
> > > before the decision of using PKCS#7 for kernel modules signatures
> > > verification was made. After that, there has been not enough interest to
> > > support PGP too.
> > 
> > You might want to update the RFC/bis references to RFC9580, which was
> > published last month and updates things.
> 
> Yes, makes sense (but probably isn't too much hassle to support more
> things for our purposes?)

I'm mostly suggesting that the comments/docs point to the latest
standard rather than the draft version, not changing to support the new
v6 keys.

> > Also, I see support for v2 + v3 keys, and this doesn't seem like a good
> > idea. There are cryptographic issues with fingerprints etc there and I
> > can't think of a good reason you'd want the kernel to support them. The
> > same could probably be said of DSA key support too.
> 
> Uhm, if I remember correctly I encountered some old PGP keys used to
> verify RPM packages (need to check). DSA keys are not supported, since
> the algorithm is not in the kernel.

I would question the benefit gained from using obsolete key/signature
types for verification (I was involved in the process of Debian dropping
them back in *2010* which was later than it should have been). Dropping
the code for that path means a smaller attack surface/maintenance
overhead for something that isn't giving a benefit.

J.

-- 
101 things you can't have too much of : 38 - clean underwear.

