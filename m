Return-Path: <linux-integrity+bounces-2515-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F28A8CB0D2
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 16:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C314CB20C92
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 14:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CC8130A54;
	Tue, 21 May 2024 14:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="BkLcEJQC";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="BkLcEJQC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFA81E87C;
	Tue, 21 May 2024 14:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716303394; cv=none; b=nDuDVjZPn5Gzc9/Z6pPqsL0VQ1nGlT6Vh92NprsyKuvrkV9d778uiiDfQLbJ5z7xllPZXjqPYHu4ROXJKt859icKZaxSYqPIeGFLqLLMAPnz5Mc2WNZHlY3u1tt2SbBspCiYalFzOSsQVRrGpw3gaU0XQzM6rTMnkQ+bS7HQpA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716303394; c=relaxed/simple;
	bh=Sm/mlcq4N0CjbXbXms+PR2JhxxOwu8RQ4iQWhN0v6DE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rQSh1bYxH+o4DDe1/8W2qbwk53tEuGILq1ufjYEsGpoXDuud4Gi367PAWZnN7TjCZe/7ygIIYxSE7FexuoGgBlTZ0DXgbZpHn916Ac+6nDn17d0iQ3pxrZtmKS9OCRFjw21ojkfkdHFhe4Ef4P6RuHb3FlBnH1E3bRruJ7qEtLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=BkLcEJQC; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=BkLcEJQC; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716303389;
	bh=Sm/mlcq4N0CjbXbXms+PR2JhxxOwu8RQ4iQWhN0v6DE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=BkLcEJQCjQ/Tn8vfiRNAYOFowecqJtj5cpfdt5HhDPQW3fuYzexbBWDc/9e9lrDgW
	 XE8/4mjeIc+DDEGe8Pav9v+Q5XzXPFmyb7wbKanJ2ARuzaEKCV1SzptbRYr3Be3MRt
	 fWFykveWPfa6fGAq1a1J9+92QH3fjeozhsVnBQao=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id DDFC712813BC;
	Tue, 21 May 2024 10:56:29 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id R_nsAii9qvM6; Tue, 21 May 2024 10:56:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716303389;
	bh=Sm/mlcq4N0CjbXbXms+PR2JhxxOwu8RQ4iQWhN0v6DE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=BkLcEJQCjQ/Tn8vfiRNAYOFowecqJtj5cpfdt5HhDPQW3fuYzexbBWDc/9e9lrDgW
	 XE8/4mjeIc+DDEGe8Pav9v+Q5XzXPFmyb7wbKanJ2ARuzaEKCV1SzptbRYr3Be3MRt
	 fWFykveWPfa6fGAq1a1J9+92QH3fjeozhsVnBQao=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4880F1280728;
	Tue, 21 May 2024 10:56:28 -0400 (EDT)
Message-ID: <0da89df455617f4dc1c7fdb8890e3219cfce4f7b.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: enable HMAC encryption for only x86-64 and aarch64
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, Jason
 Gunthorpe <jgg@ziepe.ca>, Mimi Zohar <zohar@linux.ibm.com>, David Howells
 <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Date: Tue, 21 May 2024 10:56:26 -0400
In-Reply-To: <D1FEC6TB7660.2XD9X21W46X7V@kernel.org>
References: <20240521130921.15028-1-jarkko@kernel.org>
	 <236606947b691049c650bdf82c37324084662147.camel@HansenPartnership.com>
	 <D1FDMULT5YRK.GZOPJ9FZ325R@kernel.org>
	 <854fa2e1634eb116b979dab499243e40917c637c.camel@HansenPartnership.com>
	 <D1FE58VX0KL4.70F6U9Y6HPQC@kernel.org>
	 <D1FEC6TB7660.2XD9X21W46X7V@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2024-05-21 at 17:35 +0300, Jarkko Sakkinen wrote:
> On Tue May 21, 2024 at 5:26 PM EEST, Jarkko Sakkinen wrote:
> > On Tue May 21, 2024 at 5:13 PM EEST, James Bottomley wrote:
> > > On Tue, 2024-05-21 at 17:02 +0300, Jarkko Sakkinen wrote:
> > > > Secondly, it also roots to the null key if a parent is not
> > > > given. So it covers all the basic features of the HMAC patch
> > > > set.
> > > 
> > > I don't think that can work.  The key file would be wrapped to
> > > the parent and the null seed (and hence the wrapping) changes
> > > with every reboot.  If you want a permanent key, it has to be in
> > > one of the accessible permanent hierarchies (storage ideally or
> > > endorsement).
> > 
> > I'm fully aware that null seed is randomized per power cycle.

OK, as long as this gets documented, I'm OK with it

> > The fallback was inherited from James Prestwood's original code and
> > I decided to keep it as a testing feature, and also to test HMAC
> > changes.
> > 
> > If you look at the testing transcript in the cover letter, it
> > should beobvious that a primary key is created in my basic test.
> 
> I think what could be done to it in v3 would be to return -EOPNOTSUPP
> if parent is not defined. I.e. rationale here is that this way the
> empty option is still usable for something in future kernel releases.

You can absolutely have null derived parent keys (I use them for
testing as well).  However, the spec says the parent handle in that
case should be TPM_RH_NULL (i.e. 0x40000007) not zero:

https://www.hansenpartnership.com/draft-bottomley-tpm2-keys.html#name-parent

James


