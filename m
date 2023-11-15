Return-Path: <linux-integrity+bounces-56-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BED967ED5FC
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Nov 2023 22:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF9821C209AB
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Nov 2023 21:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4564F29CF1;
	Wed, 15 Nov 2023 21:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqxWumEH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181BD45BE6;
	Wed, 15 Nov 2023 21:24:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04363C433C8;
	Wed, 15 Nov 2023 21:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700083479;
	bh=ozkO9Pw7MrmqVhdNfFB/XT1lNJNymTQrXyWvzxaXj4s=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=UqxWumEH0m2fdEquDZaKkRIbRzbH2AkcKxY7EXBhGv/l6dwVXR5r8AATojnri5Lkz
	 bMWVyQJSP20xXP4ud5yM28bO+jCp0s1O5KoKGDNgvkRyyzgRC8kSUHNC4LUPyydEF0
	 UDuzicn1SjWdoAne0kUP/RrP73CX8TMpqU5XpjTTfNGTRffEUu37gkX4vf898Zpnh3
	 wm0X1hZZlV1746CUxgCboamxmTQZMQC1M8UIHJ4eJJxA87Wer6cb+3M5YLgs6bZ+HV
	 dHukM+sf1qHNmQEWTPLBCwhel6OCSLWNMQYcd50Wn8FqciyFtKtzgPC1mV6AvRH7Oz
	 Af07p+j0+ojqQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Nov 2023 23:24:34 +0200
Message-Id: <CWZPAM33DYND.1OEHYEHGBGBI7@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>, "James
 Bottomley" <James.Bottomley@hansenpartnership.com>, "William Roberts"
 <bill.c.roberts@gmail.com>, "Stefan Berger" <stefanb@linux.ibm.com>, "David
 Howells" <dhowells@redhat.com>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Mimi
 Zohar" <zohar@linux.ibm.com>, "Peter Huewe" <peterhuewe@gmx.de>, "James
 Bottomley" <jejb@linux.ibm.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, "Julien Gomes"
 <julien@arista.com>, "open list" <linux-kernel@vger.kernel.org>, "open
 list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 4/6] tpm: Support TPM2 sized buffers (TPM2B)
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jerry Snitselaar" <jsnitsel@redhat.com>
X-Mailer: aerc 0.15.2
References: <20231024011531.442587-1-jarkko@kernel.org>
 <20231024011531.442587-5-jarkko@kernel.org>
 <nwbyc2al5msr7d2wqvqcfdm75osrestjncuhjgxxigm773a6k5@bc7hjv5srjxv>
In-Reply-To: <nwbyc2al5msr7d2wqvqcfdm75osrestjncuhjgxxigm773a6k5@bc7hjv5srjxv>

On Tue Nov 7, 2023 at 7:20 PM EET, Jerry Snitselaar wrote:
> On Tue, Oct 24, 2023 at 04:15:22AM +0300, Jarkko Sakkinen wrote:
> > Add boolean parameters @alloc and @sized to tpm_buf_init():
> >=20
> > * If @alloc is set to false, buf->data is assumed to be pre-feeded and
> >   owned by the caller.
> > * If @sized is set to true, the buffer represents a sized buffer
> >   (TPM2B).
> >=20
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> >  drivers/char/tpm/tpm-buf.c                | 32 ++++++++++++++++-------
> >  drivers/char/tpm/tpm-sysfs.c              |  2 +-
> >  drivers/char/tpm/tpm1-cmd.c               | 14 +++++-----
> >  drivers/char/tpm/tpm2-cmd.c               | 22 ++++++++--------
> >  drivers/char/tpm/tpm2-space.c             |  4 +--
> >  drivers/char/tpm/tpm_vtpm_proxy.c         |  2 +-
> >  include/linux/tpm.h                       |  3 ++-
> >  security/keys/trusted-keys/trusted_tpm1.c |  4 +--
> >  security/keys/trusted-keys/trusted_tpm2.c |  6 ++---
> >  9 files changed, 51 insertions(+), 38 deletions(-)
> >=20
> > diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> > index fa9a4c51157a..f1d92d7e758d 100644
> > --- a/drivers/char/tpm/tpm-buf.c
> > +++ b/drivers/char/tpm/tpm-buf.c
> > @@ -7,22 +7,32 @@
> >  #include <linux/tpm.h>
> > =20
> >  /**
> > - * tpm_buf_init() - Initialize from the heap
> > + * tpm_buf_init() - Initialize a TPM buffer
> >   * @buf:	A @tpm_buf
> > + * @sized:	Represent a sized buffer (TPM2B)
> > + * @alloc:	Allocate from the heap
> >   *
> >   * Initialize all structure fields to zero, allocate a page from the h=
eap, and
>
> Depending on what the decision ends up being on the bools, flags,
> separate functions, or wrappers possibly an "if needed" should be
> tacked on to the end of "allocate a page from the heap" here.
>
>
> Flags would be better when coming across calls to the routine in the
> code than the bools, but I think switching to wrappers around
> a __tpm_buf_init for the different types would be good.

Yeah, I'll bake something based on this discussion.

BR, Jarkko

