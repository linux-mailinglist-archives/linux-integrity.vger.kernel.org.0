Return-Path: <linux-integrity+bounces-2506-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D148CAEC5
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 15:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 839AC283402
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 13:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A189478B60;
	Tue, 21 May 2024 13:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHz5GuZd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672077641B;
	Tue, 21 May 2024 13:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716296405; cv=none; b=iMji3YxKwbZmHM2a+Bf3wxemnGsnbvThuhVNB6xHzXnEAgDprnw+wAzeyUOw5AziTZHwkemn4VKukb8K6mzsyJtLV57+kI04oeVQdQ2sH2z+i2ZTLRxnLRbSnyPKW+8MCxI6acuoc/mO7AaacgpXKfwu7s8NdA5J+poixPCN4yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716296405; c=relaxed/simple;
	bh=6A5BdKSf5VUXROgZCq8+mD3AstPzPEfZnDiuy877J4c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=hey5rYYx4pjo5MM1GDKuvc1xAWZEdkOTt+gWI5nCPVsk0isNFYwHeQXkXyofpfkhyMGPVsLtzcnuTgCdEcptHoxO2kizq9JQjBViTsej3Cky/ExOSWhce8JCjwTT52FXdLDij+0uTF1Ht/ESwGQ2YfhuBUtiU10pFcQOwLubygA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHz5GuZd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2863EC4AF09;
	Tue, 21 May 2024 13:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716296404;
	bh=6A5BdKSf5VUXROgZCq8+mD3AstPzPEfZnDiuy877J4c=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=JHz5GuZddYbH0BtYnTqA20tyssHscewyt6aWgsupQZZfnXHpOQg2gRttGOY43P3kx
	 kkbw29ThC4By0rYLNCM4HV9ejm12SDBwPpfWYpd+IRgltUZQrJqPj4wUcfJle3/3ZW
	 InF1CQ/r0vkWxXgRe3I16bM8rbIhnhq4VzhTQ3oD6Lg9IAPbWksgLLz6DEfh8/5+M/
	 HZCxopYsEPjxi8MY1JGurciTpjgTq48W4mH3aNuIOAtBNI7VvkQ1wjaEBJOZUwgd3A
	 GF6lph6r/+Its8TCtAFNhECRFDImvJAHctq2d8F6GZ3BRomYTbyQMTDidNFKSWUKwu
	 ekHHXgrRomabw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 May 2024 16:00:00 +0300
Message-Id: <D1FCAPJSYLTS.R9VC1CXDCIHH@kernel.org>
Subject: Re: [PATCH 1/3] tpm: Disable TCG_TPM2_HMAC by default
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>, "Vitor
 Soares" <ivitro@gmail.com>, <linux-integrity@vger.kernel.org>
Cc: <keyrings@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Mimi Zohar" <zohar@linux.ibm.com>, "David
 Howells" <dhowells@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 <linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240519235122.3380-1-jarkko@kernel.org>
 <20240519235122.3380-2-jarkko@kernel.org>
 <850862655008f84ef0b6ecd99750e8dc395304d1.camel@gmail.com>
 <D1F4V8NMSUNZ.2VCTEKHZZ0LB@kernel.org>
 <17dc838120b56ce342c34611596c7b46dcd9ab5a.camel@HansenPartnership.com>
In-Reply-To: <17dc838120b56ce342c34611596c7b46dcd9ab5a.camel@HansenPartnership.com>

On Tue May 21, 2024 at 3:33 PM EEST, James Bottomley wrote:
> On Tue, 2024-05-21 at 10:10 +0300, Jarkko Sakkinen wrote:
> > This benchmark could be done in user space using /dev/tpm0.
>
> Let's actually try that.  If you have the ibmtss installed, the command
> to time primary key generation from userspace on your tpm is
>
> time tsscreateprimary -hi n -ecc nistp256
>
>
> And just for chuckles and grins, try it in the owner hierarchy as well
> (sometimes slow TPMs cache this)
>
> time tsscreateprimary -hi o -ecc nistp256
>
> And if you have tpm2 tools, the above commands should be:
>
> time tpm2_createprimary -C n -G ecc256
> time tpm2_createprimary -C o -G ecc256

Thanks, I definitely want to try these in my NUC7. I can try both
stacks and it is pretty good test machine because it is old'ish
and slow ;-)

I'm also thinking differently than when I put out this pull request.
I honestly think that it must be weird use case to use TPM with
a machine that dies with a HMAC pipe. It makes no sense to me and
I think we should focus on common sense here.

I could imagine one use case: pre-production hardware that is not
yet in ASIC. But in that case you would probably build your kernel
picking exactly the right options. I mean it is only a default
after all.

I think we could add this:

	default X86 || ARM64

This pretty covers the spectrum where HMAC does make sense by
default. We can always relax it but this does not really take
away the legit user base from the feature.

It would be a huge bottleneck to make HMAC also opt-in because
the stuff it adds makes a lot of sense when build on top. E.g.
the asymmetric key patch set that I sent within early week was
made possible by all this great work that you've done.

So yeah, I'd like to send the above Kconfig changes, but that
is all I want to do this at this point.

> James

BR, Jarkko

