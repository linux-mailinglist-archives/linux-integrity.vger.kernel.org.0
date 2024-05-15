Return-Path: <linux-integrity+bounces-2419-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF668C660D
	for <lists+linux-integrity@lfdr.de>; Wed, 15 May 2024 14:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 155CE281684
	for <lists+linux-integrity@lfdr.de>; Wed, 15 May 2024 12:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C746EB4D;
	Wed, 15 May 2024 12:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5vW6wGW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F1F14AB4;
	Wed, 15 May 2024 12:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715774417; cv=none; b=sF8+xEd50IRXlbLnCQog4oigS/jnrpmBJmD+GvUeganVuWKSlNfak9Pip6raoe2TPYIAKBoiJ/ifPvp06/yXn0H7d1+IiXtUj2DbIw0IYaz7tWtewVmogUE03wWZR6CQLBkjml6Km1boblnZKp4T1pgv4a4VM/3/O5eEHiiGE6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715774417; c=relaxed/simple;
	bh=fIyxcnkjrOli+Uk3bndx9D9k4fUWSo6ZOhd9rATHI44=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Ekcmyx18sWm6zTlKqI+IJUVfRWv+Y3Y2l9boCYUjxkc4Y4i1Mn/Km0ZeO8Vd0f2q0/qFPLGoph1UBMUySVcj4vvmISbh5v1Dp1SiGRfyaBeeFbr2j3F+/UMJC8NdS1eACXUb7po6ADaOeqoDdErh4hLpXCvCVhFpjRAQdoMIQTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5vW6wGW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBCC9C116B1;
	Wed, 15 May 2024 12:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715774417;
	bh=fIyxcnkjrOli+Uk3bndx9D9k4fUWSo6ZOhd9rATHI44=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=R5vW6wGW7WwOxYDdVl1GDdN9+ti1CI9HK3NnZJ3RpfZPoQP+xkgs4ILI+ojoulmu7
	 ZkyEynJEq0gjFD3IJmou85CbPpQtQ4zsepl/0NSRZOOZebeeJSfep8lDHbeMbUsn0X
	 oBOQDir4i+VGvp/7D7fYi0h/OLclY4j3PVw0b9bT0mFOGEzk8dleEUUBJCm98pSMNF
	 Gtjinz8Tt+SSu3QxG/kDsQkft9N1ltXvQnloMMKEdoll+Cvon6zN9TXz8DHm1fwMfw
	 CmezXUBvQvlRM1oCNuigXvzQjnseIp+GDDVJcd/WxirOI93nJ29THWz8VYAFpV+W11
	 kbvpva46XCqEQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 May 2024 15:00:12 +0300
Message-Id: <D1A79NQ33IGG.OYIRO9S4YWZS@kernel.org>
Cc: "James Bottomley" <James.Bottomley@hansenpartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 <serge@hallyn.com>, <linux-integrity@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel-team@cloudflare.com>
Subject: Re: [RFC PATCH 2/2] KEYS: implement derived keys
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ignat Korchagin" <ignat@cloudflare.com>
X-Mailer: aerc 0.17.0
References: <20240503221634.44274-1-ignat@cloudflare.com>
 <20240503221634.44274-3-ignat@cloudflare.com>
 <D19QW70177QG.2YC9XL0FT7VME@kernel.org>
 <D19RM0OV7YUW.1ZEI72XQUREMQ@kernel.org>
 <CALrw=nEnqBCBQKhK9ACc7tbicqkXaDD+Bjc1d90xizMvbb--oA@mail.gmail.com>
In-Reply-To: <CALrw=nEnqBCBQKhK9ACc7tbicqkXaDD+Bjc1d90xizMvbb--oA@mail.gmail.com>

On Wed May 15, 2024 at 9:44 AM EEST, Ignat Korchagin wrote:
> On Wed, May 15, 2024 at 12:44=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.o=
rg> wrote:
> >
> > On Wed May 15, 2024 at 2:10 AM EEST, Jarkko Sakkinen wrote:
> > > On Sat May 4, 2024 at 1:16 AM EEST, Ignat Korchagin wrote:
> > > > Derived keys are similar to user keys, but their payload is derived=
 from the
> > > > primary TPM seed and some metadata of the requesting process. This =
way every
> > >
> > > What is exactly "some metadata"?
> > >
> > > > application can get a unique secret/key, which is cryptographically=
 bound to
> > >
> > > What is "cryptographically bound". Please go straight to the point an=
d
> > > cut out *all* white paper'ish phrases. We do not need it and will mak=
e
> > > painful to backtrack this commit once in the mainline.
> > >
> > > > the TPM without the need to provide the key material externally (un=
like trusted
> > > > keys). Also, the whole key derivation process is deterministic, so =
as long as
> > >
> > > Why trusted keys is inside braces. It is not important for the point
> > > you are trying to make here?
> > >
> > > > the TPM is available, applications can always recover their keys, w=
hich may
> > > > allow for easier key management on stateless systems.
> > >
> > > Please drop "stateless system" unless you provide a rigid definition
> > > what it is. I have no idea what you mean by it. Probably not that
> > > important, right?
> > >
> > > >
> > > > In this implementation the following factors will be used as a key =
derivation
> > > > factor:
> > > >   * requested key length
> > > >   * requesting process effective user id
> > > >   * either the application executable path or the application integ=
rity
> > > >     metadata (if available)
> > >
> > > NAK for path for any possible key derivation. They are racy and
> > > and ambiguous.
> > >
> > > This should have been in the beginning instead of "some data". What
> > > other implementations exist. For me "this implementation" implies
> > > that this one competing alternative to multiple implementations
> > > of the same thing.
> > >
> > > I do not like this science/white paper style at all. Just express
> > > short, open code everything right at start when you need and cut
> > > extras like "stateless system" unless you can provide exact, sound
> > > and unambiguous definiton of it.
> > >
> > > Just want to underline how this really needs a complete rewrite with
> > > clear and concise explanation :-) This won't ever work.
> > >
> > > >
> > > > Key length is used so requests for keys with different sizes result=
 in keys
> > > > with different cryptographic material.
> > >
> > > What is "key length"? Please refer the exact attribute.
> > >
> > > >
> > > > User id is mixed, so different users get different keys even when e=
xecuting the
> > >
> > > First of all it would be more clear to just s/User id/UID/
> > >
> > > And make obvious whether we are talking about ruid or euid and how
> > > this interacts with GIDs.
> > >
> > > I'll look at the code change next round if the commit message starts
> > > making any sense.
> >
> > Right and neither UIDs and GIDs are applicable for key derivation for
> > quite obvious reasons. So NAK for that too.
>
> Can you, please, clarify a bit here? Not very obvious for me. I added
> euid for two reasons:
>   * an unprivileged user might run a normally privileged application,
> for example /usr/sbin/sshd, and depending on the code could "leak" the
> key
>   * without it and with unprivileged user namespaces it is possible to
> create an unprivileged container with code at the same path as a
> privileged application
>
> Why do you think UIDs/GIDs are not applicable as mixins?

I did as much clarification as I possibly can.

Also, if you look at confidential computing platforms there's exactly
two assets that they use lock into machine:

- Binary
- CPU material

Only carved into stone immutable material for key derivation.

You can use mm_struct->exe_file binary if that will work out for you.
I'm done with this version.

BR, Jarkko

