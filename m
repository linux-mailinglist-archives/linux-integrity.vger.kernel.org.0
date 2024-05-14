Return-Path: <linux-integrity+bounces-2387-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 436028C55D2
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 14:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E132D282692
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 12:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CE23B79C;
	Tue, 14 May 2024 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VP6Bb2sJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EE5320F;
	Tue, 14 May 2024 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715688589; cv=none; b=TSUXWxyGY2IQWfikHSVk92xiTUPmb/9VlGl7VqKZpzdiAN/tdrnI3+d4C9nNylQWHvVgi9/VcDgm65KLZXdgc4AsRkVuEdusqyJG+65xmfRHFNgRjeeLk8n3MLqFG6iU0uy3QmoiG0YqVG23lbKvqP6dQInv7cuAJO83YYu5n58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715688589; c=relaxed/simple;
	bh=PuWBAAEHgLpq0nAuoPCaOMZZyQFaKwKkvo6IpNy8dVE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=f/MVEHeIZL7fAlQf8UzwKx0sjdVRYBscqd+xMxV/OppvaNLeXAqHfxnV1iiYW0iMCLl6Vn8UM0BMUPDZjJgu1vsgcO70VrUdzMPu+4KKgdBgNRvPKllE7Hewnziw0u8CTy3yegn9Bp1ze6IypBdW6yoNgVIkq3qXv/ObwviAS7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VP6Bb2sJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5376C2BD10;
	Tue, 14 May 2024 12:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715688589;
	bh=PuWBAAEHgLpq0nAuoPCaOMZZyQFaKwKkvo6IpNy8dVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VP6Bb2sJrzOT8ZmlDTi0e5gJtis7Gxs3DXFDB45xqbo//QzdZbfLBrZTTGJlVRgoU
	 B5rsM9D2HQIcJRzeGRcNJAPeeJPnYFpISE1RD5SMmyq02+mws5U7KjdAgkYNV8a8VI
	 rvMUP5UMSY74MJr60GmIZSRhdj9aPOBI9Ikp1uSjo5TL8zfei4Kv9yFTjhVekWxJRj
	 l+t7081FGpBt9VT502qVhsZ9ehWQzkBOCBpYEBEispj++KlxEzlv+qa+2koE3lbI9r
	 76XiwsqWq5zvXo4xhbxpIRlbgapvECRFTvSYybEwpzVQ7KIfVJkqPRTAYDPWlM7ixT
	 7DKTkhx/cKQ7A==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 May 2024 15:09:44 +0300
Message-Id: <D19CUF0H9Q3S.3L5Y5S9553S5@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ignat Korchagin" <ignat@cloudflare.com>
Cc: "James Bottomley" <James.Bottomley@hansenpartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 <serge@hallyn.com>, <linux-integrity@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel-team@cloudflare.com>
Subject: Re: [RFC PATCH 0/2] TPM derived keys
X-Mailer: aerc 0.17.0
References: <20240503221634.44274-1-ignat@cloudflare.com>
 <CALrw=nGhgRrhJ5mWWC6sV2WYWoijvD9WgFzMfOe6mHmqnza-Hw@mail.gmail.com>
 <D18XXJ373C2V.2M6AOMKD1B89W@kernel.org>
 <CALrw=nHGLN=dn3fbyAcXsBufw0tAWUT1PKVHDK5RZkHcdd3CUw@mail.gmail.com>
In-Reply-To: <CALrw=nHGLN=dn3fbyAcXsBufw0tAWUT1PKVHDK5RZkHcdd3CUw@mail.gmail.com>

On Tue May 14, 2024 at 1:05 PM EEST, Ignat Korchagin wrote:
> On Tue, May 14, 2024 at 1:28=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.or=
g> wrote:
> >
> > On Mon May 13, 2024 at 8:11 PM EEST, Ignat Korchagin wrote:
> > > On Fri, May 3, 2024 at 11:16=E2=80=AFPM Ignat Korchagin <ignat@cloudf=
lare.com> wrote:
> > > I would like to point out to myself I was wrong: it is possible to as=
k
> > > the kernel to generate a trusted key inside the kernel locally with
> > > "keyctl add trusted kmk "new 32" @u"
> >
> > Not in a full-time kernel position ATM as I'm working as contract
> > researcher up until beginning of Oct (took some industry break after
> > a startup went down of business), so please, politely asking, write
> > a bit more compact descriptions ;-) I'm trying to find a new position b=
y
> > the beginning of Oct but right now I'd appreciate a bit more thought ou=
t
> > text descriptions.
> >
> > I'm working out a small patch set with James Prestwood to add asymmetri=
c
> > TPM2 keys based on his old patch set [1] but laid out on top of the
> > existing baseline.
> >
> > I did already the key type shenanigans etc. for it and James P is layin=
g
> > his pre-existing RSA code and new ECDSA on top of that. So this will
>
> This is great. Perhaps we can finally have ECDSA software signature
> support as well, which I have been trying to get in for some time now
> [1]

Yes exactly both.

>
> > give x.509 compatibility [2]. This patch set will be out soon and likel=
y
> > part of 6.11 (or almost guaranteed as most of it is done).
> >
> > So by plain guess this might be along the lines what you might want?
>
> I don't think so. I have seen this patchset, but unless the new
> version is fundamentally different, it looks to me that the asymmetric
> TPM keys are the same as trusted keys except they are asymmetric
> instead of being symmetric. That is, they are still of limited use on
> stateless systems and are subject to the same restrictions I described
> in my revised cover description.

OK, hmm... can you an "apples and oranges" example what would be
most trivial use case where these don't cut?


> On top of that I'm not sure they would be widely used as "leaf" keys
> by applications, maybe more as root/intermediate keys in some kind of
> key hierarchy. TPMs are slow and I don't see a high-performance
> web-server, for example, using asymmetric TPM keys for TLS operations.
> Also, as we learned the hard way operating many TPMs in production,
> some TPMs are quite unreliable and fail really fast, if you "spam"
> them with a lot of crypto ops. I understand this is a HW/TPM vendor
> problem, but in practice we're trying to build systems, where TPM is
> used to protect/generate other keys, but most of the "leaf" crypto
> operations are done in software, so we don't make the TPM do too much
> crypto.

So what about SGX/SNP/TDX?

TPM is definitely not made for workloads :-)

> Just to clarify - I'm not arguing about the usefulness of TPM
> asymmetric keys in the kernel. I would really want to see this
> building block available as well, but I think it just serves a
> different purpose/use case from what I'm trying to figure out in this
> RFC thread.

Got it :-) NP

BR, Jarkko

