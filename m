Return-Path: <linux-integrity+bounces-3509-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1669F973C13
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2024 17:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6DA9284E8D
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2024 15:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5152C193081;
	Tue, 10 Sep 2024 15:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="I15zwZNd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5965F4204D;
	Tue, 10 Sep 2024 15:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725982485; cv=none; b=homY8TL1OlR5a+FPxmTYOURoLZcF//Gz9oZNQdix28sgi22mdVL7wCswtxTeOimEYkv2bsv3AAsYki9nVe2iJIHx571Px95dAkhL4Ng5pDkZX2ZhtTX0lKkuez4Y78OdzTr+MKxpKuOO8GdVEtFR+/vm7e9D+j1khMD/ikSxCWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725982485; c=relaxed/simple;
	bh=Y7iQeD4hGzv3JM+SzFixGYto396Sd0RNqqi7OPzSN3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVNrQQ70bhxQaX71N7L8Ni6YdwybPtKZY0jOzGgkBBQUA1p4ilVS/ebEJ9YrdXvjgvS1+YWrTCf+/toouRbecziIFqNpxECFVL8FCKJORc169qC9Lr/iYM0FqcAyy5vOT+eI5tbAZe7chDaEubCIQwrVmNqYBtjitrGTuBrcfdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=I15zwZNd; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+recKoM7vFCwb1CTbRB4jGT2zAWewASBgrq/1E9M2bk=; b=I15zwZNdG7NLvGqEw2d8JTT3m8
	SD6vM1xPqI2sokjlAYGNDkWWJ3WsVIfT4FimElW0Sn5uzXIluF2jac1NtsheuMsSRIkkiXhXBBOnW
	zGpQcy5V8DGtBY6RiIDH2vFZNV2sjiLocLMxhEVpZqpzCaXyPKN2KFrlakRJLUrjsoEbwAhOzCSXx
	OXXElYSvqUVRpaI2xBxbQ7NRHA4dE7XrShuuuUhw9bRAABWvQEKBjQq8Op2WXoVSa5aIP/v4b9vPi
	B2YLbQFtNHllik3XTK+Mx5aKHQLYQEN02C5ftJMCnCYc8eZAxR6KQgqAVhz2NvC3pLh5xNwRfeFz/
	mKcSl6xw==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1so2bv-004qYZ-0A;
	Tue, 10 Sep 2024 16:16:55 +0100
Date: Tue, 10 Sep 2024 16:16:55 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: dhowells@redhat.com, dwmw2@infradead.org, herbert@gondor.apana.org.au,
	davem@davemloft.net, linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
	zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>, adrian@suse.de,
	ro@suse.de
Subject: Re: [PATCH v2 00/14] KEYS: Add support for PGP keys and signatures
Message-ID: <ZuBi56VwWxxX2Ce5@earth.li>
References: <20240818165756.629203-1-roberto.sassu@huaweicloud.com>
 <ZsNf1VdfkHqD8R4Q@earth.li>
 <f142b1c4e662d4701a2ab67fa5fc839ab7109e5e.camel@huaweicloud.com>
 <ZsSkTs4TFfx2pK8r@earth.li>
 <a9502b8097841c36ca13871b22149eadd3fde355.camel@huaweicloud.com>
 <6c7e34b65d73e9fa2ba0fd39b357b9eb42ee0449.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c7e34b65d73e9fa2ba0fd39b357b9eb42ee0449.camel@huaweicloud.com>

On Tue, Sep 10, 2024 at 04:51:22PM +0200, Roberto Sassu wrote:
> On Tue, 2024-09-10 at 16:36 +0200, Roberto Sassu wrote:
> > On Tue, 2024-08-20 at 15:12 +0100, Jonathan McDowell wrote:
> > > On Mon, Aug 19, 2024 at 05:15:02PM +0200, Roberto Sassu wrote:
> > > > On Mon, 2024-08-19 at 16:08 +0100, Jonathan McDowell wrote:
> > > > > On Sun, Aug 18, 2024 at 06:57:42PM +0200, Roberto Sassu wrote:
> > > > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > > 
> > > > > > Support for PGP keys and signatures was proposed by David long time ago,
> > > > > > before the decision of using PKCS#7 for kernel modules signatures
> > > > > > verification was made. After that, there has been not enough interest to
> > > > > > support PGP too.
> > > > > 
> > > > > You might want to update the RFC/bis references to RFC9580, which was
> > > > > published last month and updates things.
> > > > 
> > > > Yes, makes sense (but probably isn't too much hassle to support more
> > > > things for our purposes?)
> > > 
> > > I'm mostly suggesting that the comments/docs point to the latest
> > > standard rather than the draft version, not changing to support the new
> > > v6 keys.
> > > 
> > > > > Also, I see support for v2 + v3 keys, and this doesn't seem like a good
> > > > > idea. There are cryptographic issues with fingerprints etc there and I
> > > > > can't think of a good reason you'd want the kernel to support them. The
> > > > > same could probably be said of DSA key support too.
> > > > 
> > > > Uhm, if I remember correctly I encountered some old PGP keys used to
> > > > verify RPM packages (need to check). DSA keys are not supported, since
> > > > the algorithm is not in the kernel.
> > > 
> > > I would question the benefit gained from using obsolete key/signature
> > > types for verification (I was involved in the process of Debian dropping
> > > them back in *2010* which was later than it should have been). Dropping
> > > the code for that path means a smaller attack surface/maintenance
> > > overhead for something that isn't giving a benefit.
> > 
> > Removed support for v3 PGP signatures... but that broke openSUSE
> > Tumbleweed.

Is this a signature from a v3 key, or a v3 signature? Unfortunately
there are implementations which will issue a v3 signature even from a v4
key; IIRC this ambiguity has been cleared up in the updated RFC.

> > [  295.837602] PGPL: Signature packet with unhandled version 3
> 
> To add more context, this patch set adds the ability to the kernel to
> verify the PGP signature of RPM packages against Linux distributions
> PGP keys.

> The purpose of this is to verify the authenticity of such RPM packages,
> and to extract from them file digests, which are in turn used as
> reference values for integrity check (appraisal) with IMA.

I don't believe allowing a v3 *key* gives a useful verification that is
worth supporting. However unfortunately I think it sounds like support
for v3 signatures from v4 keys is necessary.

J.

-- 
Listen to the words, they tell you what to do...

