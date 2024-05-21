Return-Path: <linux-integrity+bounces-2536-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ADF8CB620
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 00:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EB5F282A50
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 22:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4530B6BB54;
	Tue, 21 May 2024 22:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5xisYrY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2DA168BD;
	Tue, 21 May 2024 22:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716331520; cv=none; b=B0uKuGUWUuuvNCd5IyO6Q51SG1fcH9biOkbIOMniM2McUZtQcHGA0EfWbOwBh0yO1vTZvHVdFrZ0t3+xXXACJttmYoMi16pVeD5PYLj6sK4aifJJtJRZdgAVwPVn/rnUx8EYfPMoNPTKLwguOmltfyQA7Yy9W9HmJsFFSXIaaS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716331520; c=relaxed/simple;
	bh=48kAszKzTfCBos6Qet3oVdY1gVv3I049U7CcY8p3F0k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=a+b5QRa6I1dtWT+rYyR5WfJHIbroPX1HqY0f6YPl8k3Io5q4nC7r0CCmgkRUMwK8AsjbeE6n5xx+2rYl8qbNkiytcRhV38m/RR09xhyb0cptrSMjDO9oGpauFMmTvWvucdgGZoE/jla4t113Lzvs6neuwnYQOwAgeCBnI2s182Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5xisYrY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DA2C2BD11;
	Tue, 21 May 2024 22:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716331519;
	bh=48kAszKzTfCBos6Qet3oVdY1gVv3I049U7CcY8p3F0k=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=j5xisYrYk4Z3Yz1WJ6Hq5lRGNQtJz0s65kjPsgKzPyBm6JFe/YX6hciCUaU/Qt9fH
	 sJfL25lp6nC1+PKiLr+WBADs27TEMpKw6+6nyMfajkMiIMS4jHWeHokivANgsuDUsF
	 8HkE1GvABrY8uxeS8FY7j9FWTIr5DwU1nBjivZX1ZiUur0boWq0XpYlf6bxW5UXEIt
	 rEveUwq2QuFvWEIyiaiRKHMNUQX3mjZFi12odPKMsQMgqZR+36pj6ppodN4Rw4HOT8
	 OX5vyxah0/OWh0DZwy3RMyRNFx9G9XeDTQwP51lUgMvzt5q5PyUTFV5qXSl+m/+o5V
	 ajYkwmRfo902g==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 May 2024 01:45:13 +0300
Message-Id: <D1FOQSFNZ794.23R2JV1SD8X8W@kernel.org>
Cc: "Herbert Xu" <herbert@gondor.apana.org.au>,
 <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <Andreas.Fuchs@infineon.com>, "James Prestwood" <prestwoj@gmail.com>,
 "David Woodhouse" <dwmw2@infradead.org>, "Eric Biggers"
 <ebiggers@kernel.org>, "David S. Miller" <davem@davemloft.net>, "open
 list:CRYPTO API" <linux-crypto@vger.kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Mimi Zohar" <zohar@linux.ibm.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "open list:SECURITY SUBSYSTEM"
 <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] KEYS: trusted: Move tpm2_key_decode() to the TPM
 driver
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>, "David
 Howells" <dhowells@redhat.com>
X-Mailer: aerc 0.17.0
References: <D1FMVEJWGLEW.14QGHPAYPHQG1@kernel.org>
 <20240521031645.17008-1-jarkko@kernel.org>
 <20240521031645.17008-5-jarkko@kernel.org>
 <cc3d952f8295b52b052fbffe009b796ffb45707a.camel@HansenPartnership.com>
 <336755.1716327854@warthog.procyon.org.uk>
 <239a52eb5ed3a6c891382b63d08fe7b264850d38.camel@HansenPartnership.com>
In-Reply-To: <239a52eb5ed3a6c891382b63d08fe7b264850d38.camel@HansenPartnership.com>

On Wed May 22, 2024 at 12:59 AM EEST, James Bottomley wrote:
> On Tue, 2024-05-21 at 22:44 +0100, David Howells wrote:
> > Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >=20
> > > On Tue May 21, 2024 at 9:18 PM EEST, James Bottomley wrote:
> > > ...
> > > You don't save a single byte of memory with any constant that
> > > dictates the size requirements for multiple modules in two disjoint
> > > subsystems.
> >=20
> > I think James is just suggesting you replace your limit argument with
> > a constant not that you always allocate that amount of memory.
>
> Exactly.  All we use it for is the -E2BIG check to ensure user space
> isn't allowed to run away with loads of kernel memory.

Not true.

It did return -EINVAL. This patch changes it to -E2BIG.

>
> > What the limit should be, OTOH, is up for discussion, but PAGE_SIZE
> > seems not unreasonable.
>
> A page is fine currently (MAX_BLOB_SIZE is 512).  However, it may be
> too small for some of the complex policies when they're introduced.=20
> I'm not bothered about what it currently is, I just want it to be able
> to be increased easily when the time comes.

MAX_BLOB_SIZE would be used to cap key blob, not the policy.

And you are ignoring it yourself too in the driver.


> James


BR, Jarkko

