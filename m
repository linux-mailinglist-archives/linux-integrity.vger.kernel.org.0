Return-Path: <linux-integrity+bounces-7389-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28019BBF976
	for <lists+linux-integrity@lfdr.de>; Mon, 06 Oct 2025 23:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B753188FFDA
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Oct 2025 21:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1616625FA13;
	Mon,  6 Oct 2025 21:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="V5ItXtRd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820C438DD8;
	Mon,  6 Oct 2025 21:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759786848; cv=none; b=JFg0n95JYLkOAeQSn+4tRKirBOyUjqZ1smXQSveoYSlBqdLn8msyrKG2nHaLkYAn1mOkbUmDo+ixg287cS/RYfVWyNJq8PayP0s6ihVCC4UqUbheAw9Q0pJvzpvvA4NLAC+xvdUwhavYO3rThZ5ITf5GQ3l8uplZX2qHL/tbFzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759786848; c=relaxed/simple;
	bh=R7XJ2TwiqWioySK4ASyyWjFauTibf7eH+Ah4O0qelOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLm5M6qLXMGkic05liJLrClpmP5RBKJ2ZGjbShKwQTDPpnxNlKlCA4ZZsGIfWIA6oUsmMirUd/6DM9zPl5f13Ku4uY32/Qtz8nkZtNJG4Gbb6ijlUOBk6pNTQsY1qEy86tz/uw3aLy2QovTXa86FC94y0CppzE3eyD9CHP9SQ5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=V5ItXtRd; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=nNVpGvBktBIV6LStDv6qPWdxU9sKQpVF+6HYIuoef9Y=; b=V5ItXtRdPH7mZRf/7Zq0xp3wum
	jBbDngG7xBpJnFvh8Q7gofz96DMetMPLcYJG5wuDQYPVTCzQE9Cw/lch2OxGuDV61WZkELaJQNH7a
	QGBQ9xLZ93BDvSB4ndIhMH/vU3Zh/NBdZek2Zi/3q+mzL6MOMei91C0KxLVj9PobkvAjpmdgCY6Hw
	mL96x7v5C2nUen2JOxnM3y/mWKH6WDGBkD5OYI1MvKRFLmIFz5BsZ8Entm8QL8p0tdJ09171jAbXi
	Z+e34steG9axVXvQ6s5CzDpA38R9EX8oKGm3wddZ0newHfmGmsSntRm/IYxaTtswn1hILG6ca03Kb
	ERRljmUA==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1v5swh-003CRO-2Q;
	Mon, 06 Oct 2025 22:40:39 +0100
Date: Mon, 6 Oct 2025 22:40:39 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan McDowell <noodles@meta.com>
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-v6.18
Message-ID: <aOQ3V6M-wWQxxCWK@earth.li>
References: <aOKTFv1vh1cvvcLk@kernel.org>
 <CAHk-=whSe9AGigVydkwo=ewE6_GFTJ_rU=XzO=v1N1sWyfVmAw@mail.gmail.com>
 <aOO3NKegSrUQ4ewg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOO3NKegSrUQ4ewg@kernel.org>

On Mon, Oct 06, 2025 at 03:33:56PM +0300, Jarkko Sakkinen wrote:
> On Sun, Oct 05, 2025 at 11:24:09AM -0700, Linus Torvalds wrote:
> > On Sun, 5 Oct 2025 at 08:47, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > The exclusive access looks debatable to me too. I think you should
> > also require that the open was done not only with O_EXCL, but as a
> > write too.
> > 
> > Exclusive reads do not make sense.
> 
> True, I agree with this.

I'm not sure _reads_ make sense for the TPM device files at all. It's a 
command + response interface.

What should we do if we get O_EXCL and O_RDONLY? Return an error? Ignore 
the O_EXCL flag?

> After reading this email I realized also another issue with these patch
> when I tested them sequentially building a VM for each commit ID.
> 
> Without "tpm: Require O_EXCL for exclusive /dev/tpm access" applied,
> there's a regression: usually a daemon of some sort opens /dev/tpm0:
> 
> COMMAND      PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
> tpm2-abrm 771444  tss    5u   CHR 10,224      0t0   94 /dev/tpm0
> 
> Without top patch this leaves /dev/tpmrm0 unusuable, which is a huge
> developer experience downgrade as it is nice and covenient device
> to try and do things. I.e. tail patch needs to be squashed and
> the whole patch set needs to be re-reviewed.

That's a fair point; I structured the patches in that fashion because I 
felt the O_EXCL patch was potentially contentious and might not be 
accepted.

> And based on this I'm happy to postpone O_EXCL changes to 6.19.
> Patch set just needs to be restructured better so that in-the
> middle of the series patches don't break things. And also it'd
> be better if this patch would be relocated as the first in the
> series: "tpm: Remove tpm_find_get_ops".

I'll spin a set with the tpm_find_get_ops removal first, then the O_EXCL 
patch, then the other two, which I think fixes all the ordering 
concerns.

J.

-- 
... Nice world. Let's make it weirder.

