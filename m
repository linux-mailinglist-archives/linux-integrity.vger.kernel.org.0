Return-Path: <linux-integrity+bounces-2548-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9EA8CC0C1
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 14:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE5AF1C218AA
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 12:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC057E576;
	Wed, 22 May 2024 12:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aM8i1leH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBFF3F8C7;
	Wed, 22 May 2024 12:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716379265; cv=none; b=nDw7g8pxWmyJK3KI5kcgCQjwEQ6mxbYaEibFeHQgggcCu0moiU1VfHCMPRUq9q//hMkgEQDTkYl2oWYiiZV7cLeAkTRpAYc0AtM7lWw2gBRHooi5PlTJR5ieKbxI2jPq09P/f39K384IlEi5YU9jdBmv4kaEmF7SLwyGjPxVc98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716379265; c=relaxed/simple;
	bh=yJHTZScxmQkM5iwZ0RN3k60aeHqAG8E5DyXxOJ9hn7M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=VGDz6NS0FKSiwNrrKaiWWzo9PSRfEbDCNJQIXbA8GsvtnOt+a2sz6HQm/7HiCXu0lWMftPVZDx56mDv6cwYKRn93mkyAR33SPTXDXO58OWPJw+0vaxw+vD0VOeOFYNiW8zzXehqIAFeyEBOeAE5LhnJpRCXUQXRt4FLoel6Y3eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aM8i1leH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B1FC2BD11;
	Wed, 22 May 2024 12:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716379264;
	bh=yJHTZScxmQkM5iwZ0RN3k60aeHqAG8E5DyXxOJ9hn7M=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=aM8i1leHbjTmwswydcW4TBsnV14OGuJgpKtrP8rqWidYB33tlDMOjHZxKWUeUFisd
	 kHJa+l1yIXjZKTKel7rCwk/ysaez7fTofRgHZb2OG7MoYVU07Ewbx31RGlITvwDdd/
	 DtXbHXkyu7Q8ZuYjgVxx4GBtCZ+fZ7VlrbkIiqaR66JfnopKmcvJa8AXqfmbjHWPFG
	 /6Uxda/Vk8cBzgu1vLrLYRAWBVuBP0s8NWgdkzcGlZ+An9bSQ6Gg7QsLxTFPK2dzGI
	 srm26X25B7nd5NN1HYfGM1kBEb5Rrh5F/BvAkWrZWQoLFft76ob+frDw9uVzYnybrr
	 P5wNmmPR8CY6g==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 May 2024 15:01:00 +0300
Message-Id: <D1G5O2Z86E4W.2DHG4QZE2W2JG@kernel.org>
Cc: <keyrings@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Mimi Zohar" <zohar@linux.ibm.com>, "David
 Howells" <dhowells@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 <linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 1/3] tpm: Disable TCG_TPM2_HMAC by default
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Vitor Soares" <ivitro@gmail.com>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240519235122.3380-1-jarkko@kernel.org>
 <20240519235122.3380-2-jarkko@kernel.org>
 <850862655008f84ef0b6ecd99750e8dc395304d1.camel@gmail.com>
 <D1F4V8NMSUNZ.2VCTEKHZZ0LB@kernel.org>
 <17dc838120b56ce342c34611596c7b46dcd9ab5a.camel@HansenPartnership.com>
 <2dd8d49516ec9c7cb8c1182b5b8537b1e82d7067.camel@gmail.com>
In-Reply-To: <2dd8d49516ec9c7cb8c1182b5b8537b1e82d7067.camel@gmail.com>

On Wed May 22, 2024 at 11:18 AM EEST, Vitor Soares wrote:
> On Tue, 2024-05-21 at 08:33 -0400, James Bottomley wrote:
> > On Tue, 2024-05-21 at 10:10 +0300, Jarkko Sakkinen wrote:
> > > This benchmark could be done in user space using /dev/tpm0.
> >=20
> > Let's actually try that.=C2=A0 If you have the ibmtss installed, the co=
mmand
> > to time primary key generation from userspace on your tpm is
> >=20
> > time tsscreateprimary -hi n -ecc nistp256
> >=20
> >=20
> > And just for chuckles and grins, try it in the owner hierarchy as well
> > (sometimes slow TPMs cache this)
> >=20
> > time tsscreateprimary -hi o -ecc nistp256
> >=20
> > And if you have tpm2 tools, the above commands should be:
> >=20
> > time tpm2_createprimary -C n -G ecc256
> > time tpm2_createprimary -C o -G ecc256
> >=20
> > James
> >=20
> >=20
>
> Testing on an arm64 platform I get the following results.

OK, appreciate these results. I try to get mine this week, if I can
allocate some bandwidth but latest early next week. The Intel CPU
I'll be testing is Intel Celeron J4025:

https://www.intel.com/content/www/us/en/products/sku/197307/intel-celeron-p=
rocessor-j4025-4m-cache-up-to-2-90-ghz/specifications.html

So if things work reasonably fast with this, then I think we can
enable the feature at least on X86_64 by default, and make it
opt-in for other arch's.

I sent already this patch but holding with PR up until rc1 is
out so that there is some window to act:

https://lore.kernel.org/linux-integrity/20240521130921.15028-1-jarkko@kerne=
l.org/

If I need to send an updated patch ("default X86_64") and rip
transcrip from below results.

But to do that correctly I'd need to know at least:

1. What is the aarch64 platform you are using?
2. What kind of TPM you are using and how is it connect?

Obviously if I make this decision, I'll put you as "Reported-by".

>
> hmac disabled:
>   time modprobe tpm_tis_spi
>   real    0m2.776s
>   user    0m0.006s
>   sys     0m0.015s
>
>   time tpm2_createprimary -C n -G ecc256
>   real    0m0.686s
>   user    0m0.044s
>   sys     0m0.025s
>
>   time tpm2_createprimary -C o -G ecc256
>   real    0m0.638s
>   user    0m0.048s
>   sys     0m0.009s
>
>
> hmac enabled:
>   time modprobe tpm_tis_spi
>   real    8m5.840s
>   user    0m0.005s
>   sys     0m0.018s
>
>
>   time tpm2_createprimary -C n -G ecc256
>   real    5m27.678s
>   user    0m0.059s
>   sys     0m0.009s
>
>   (after first command)
>   real    0m0.395s
>   user    0m0.040s
>   sys     0m0.015s
>
>   time tpm2_createprimary -C o -G ecc256
>   real    0m0.418s
>   user    0m0.049s
>   sys     0m0.009s
>
> hmac enabled + patches applied
>   time modprobe tpm_tis_spi
>   real    8m6.663s
>   user    0m0.000s
>   sys     0m0.021s
>
>
>   time tpm2_createprimary -C n -G ecc256
>   real    7m24.662s
>   user    0m0.048s
>   sys     0m0.022s
>
>   (after first command)
>   real    0m0.395s
>   user    0m0.047s
>   sys     0m0.009s
>
>   time tpm2_createprimary -C o -G ecc256
>   real    0m0.404s
>   user    0m0.046s
>   sys     0m0.012s
>
>
> Regards,
> Vitor Soares

BR, Jarkko

