Return-Path: <linux-integrity+bounces-2508-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8783C8CAF13
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 15:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A85DD1C20356
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 13:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D19757F7;
	Tue, 21 May 2024 13:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4J1UUeU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23576CDA9;
	Tue, 21 May 2024 13:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716297070; cv=none; b=EFS0AJ8BkgeMWrC/vADVfO2urBH6IVfMt3au/SfLm3TPmMBuJo7PhhGDTZi7fDnb/jXZF+WR00BR6RZsjFMkGwL8qk5E0VuWQNeMq9NUijTbZK84vs0+iOK8XUGkl38/7+8YtkOhjjdjFis3Ex3T0TVivYg+h5//grALMb77Zxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716297070; c=relaxed/simple;
	bh=WnkxiH7GGIBgXGDmzcBsifOH2rh1iziAD4cjZZHAwg4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=qLmQwDIslv1pPkAY7FSD8wTyui6+mmCgheyI/wNTNNCZY5AHR0CREqjMleXqTSfpB1xaCVj4ef9tR4YPoefXa0eoJ0b7ZM0lAZE5ptasQFeQdGm2Fi1c+CyMDgfCicZ7MjGfv5eCb8UG4MHCeqGQwNC4dQ1qqI1ytBTtA5s0OKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4J1UUeU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E6AC2BD11;
	Tue, 21 May 2024 13:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716297070;
	bh=WnkxiH7GGIBgXGDmzcBsifOH2rh1iziAD4cjZZHAwg4=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=F4J1UUeU7dtRbETFzbYRF7dlisqyjxYZZiuD2vObvWg3mAXgb4xa8JTMJXQ/cfzsZ
	 4bhcz9tPF9pT8RRd8GRfZduHKhJJ9+5/lc/E0txB5XFxFvYLM/m4+tKj4bfUe9/DOV
	 Y9YGnSQ5syPqcNlU/GIvZgA/KjJ08R8ByLCr8D4rQAdn/aVkzQ0ca+RQunoG+YDMxk
	 /cBa62bkwYS1M3vNSPeYdi5+wCKI7A1nTB3lfAhkcqoNWw6UWzup+C59zcgfIkEOau
	 FYPWLzrxfw2BsrVZacpFB7P5Oqyh1mTj6DNLih+N2c+FnPRYL8HSsKzGv8ca09pTz1
	 x6EODLXI036JA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 May 2024 16:11:05 +0300
Message-Id: <D1FCJ71B0HAO.2CD8A7N7DR5DP@kernel.org>
Cc: <keyrings@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Mimi Zohar" <zohar@linux.ibm.com>, "David
 Howells" <dhowells@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 <linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 1/3] tpm: Disable TCG_TPM2_HMAC by default
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Vitor Soares" <ivitro@gmail.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240519235122.3380-1-jarkko@kernel.org>
 <20240519235122.3380-2-jarkko@kernel.org>
 <850862655008f84ef0b6ecd99750e8dc395304d1.camel@gmail.com>
 <D1F4V8NMSUNZ.2VCTEKHZZ0LB@kernel.org>
 <17dc838120b56ce342c34611596c7b46dcd9ab5a.camel@HansenPartnership.com>
 <D1FCAPJSYLTS.R9VC1CXDCIHH@kernel.org>
In-Reply-To: <D1FCAPJSYLTS.R9VC1CXDCIHH@kernel.org>

On Tue May 21, 2024 at 4:00 PM EEST, Jarkko Sakkinen wrote:
> On Tue May 21, 2024 at 3:33 PM EEST, James Bottomley wrote:
> > On Tue, 2024-05-21 at 10:10 +0300, Jarkko Sakkinen wrote:
> > > This benchmark could be done in user space using /dev/tpm0.
> >
> > Let's actually try that.  If you have the ibmtss installed, the command
> > to time primary key generation from userspace on your tpm is
> >
> > time tsscreateprimary -hi n -ecc nistp256
> >
> >
> > And just for chuckles and grins, try it in the owner hierarchy as well
> > (sometimes slow TPMs cache this)
> >
> > time tsscreateprimary -hi o -ecc nistp256
> >
> > And if you have tpm2 tools, the above commands should be:
> >
> > time tpm2_createprimary -C n -G ecc256
> > time tpm2_createprimary -C o -G ecc256
>
> Thanks, I definitely want to try these in my NUC7. I can try both
> stacks and it is pretty good test machine because it is old'ish
> and slow ;-)
>
> I'm also thinking differently than when I put out this pull request.
> I honestly think that it must be weird use case to use TPM with
> a machine that dies with a HMAC pipe. It makes no sense to me and
> I think we should focus on common sense here.
>
> I could imagine one use case: pre-production hardware that is not
> yet in ASIC. But in that case you would probably build your kernel
> picking exactly the right options. I mean it is only a default
> after all.
>
> I think we could add this:
>
> 	default X86 || ARM64
>
> This pretty covers the spectrum where HMAC does make sense by
> default. We can always relax it but this does not really take
> away the legit user base from the feature.
>
> It would be a huge bottleneck to make HMAC also opt-in because
> the stuff it adds makes a lot of sense when build on top. E.g.
> the asymmetric key patch set that I sent within early week was
> made possible by all this great work that you've done.
>
> So yeah, I'd like to send the above Kconfig changes, but that
> is all I want to do this at this point.

Patch is out (lore link was not yet available):

https://lkml.org/lkml/2024/5/21/583

BR, Jarkko

