Return-Path: <linux-integrity+bounces-2388-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EB98C56AA
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 15:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 495DCB20EB3
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 13:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E112213FD8D;
	Tue, 14 May 2024 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="DBNufP83"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B7213E02A
	for <linux-integrity@vger.kernel.org>; Tue, 14 May 2024 13:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692317; cv=none; b=gIDkfI0wz4XUJBgF0L31jRFQ9yKti1TKwCc3lkr2RNhMXJO0FL5HmjGZhCOHydbVX8NFhrBlTQuc8nZBDTYE88PTzEltCJqRuBx2gBbQhkqxbJErDmmInONBDXqU+K9U9WDWEYsiRl418ftEGZXKxm9Hr+5tF33guf0qB1F8i+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692317; c=relaxed/simple;
	bh=i78nag7VwGIylmXT7ULMgiXTvq5zZgYQxOsCzHqZVSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DIohW/hXKngpcVGUxHv5/WmR6AKd1Gy5pTc60W6GazT/jmy5p+jGo1GblTtBLlHuLfEzqHPNjLPj7iTobdyl6M3Lu+Gl0AlePMK7Ct1nVbqn4SfEoIExCvPtsm6Hj48z6gEn7POwiKzzWrJOO+a1knDWxE1TGwWbrTKGweED6ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=DBNufP83; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-64e93d9b14bso337637a12.1
        for <linux-integrity@vger.kernel.org>; Tue, 14 May 2024 06:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1715692316; x=1716297116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqd1UzTZmwcZdR5n3AwIksJ+CVAmV+O8oPVTGzelpbU=;
        b=DBNufP83dAzL6zfzTWNDg7DHZcF88tPmTl1W1NZphcsmMNdzvDzBw3uOUrXx8r7iM4
         p+FP0OH5mpcoWUql52bZb4IkMbeSUt9Eq4e61q3QpdYxRIpdRpDHu+Nc4hBqFERUbNT5
         M9OJWXO/kK8Zf6AyQqISQDcUrOhRHUi3wEcaJd5HODaVxC75gYbaPUxDZQyNUfjGjmap
         GOAlhOFK5AB+Al5MMZzdfpKBZujTlNwBrGEzGvkH+cI3EvA1wy8yMjw1NnYRVqnExRS7
         NDbq6Bo6V0b0qBmHepRXkrvniQ14vH6ased/ZtkXXKmU1poBh45iGK+KfcBu9Ngru/kT
         Qz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715692316; x=1716297116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gqd1UzTZmwcZdR5n3AwIksJ+CVAmV+O8oPVTGzelpbU=;
        b=aMy1LfNf+0tT9+PfgGfsqDGJ84b+Zg0o9GQZUMa57np0yK3jQRNA+PHm5W2xEBd8Ea
         ueRkVgipOrp4L+VbbdFw50bWHCf4gwrDtXO3HjN3KU+2HkzLqj4AmsWRVYZyCXJ6Ehgw
         ZC8HA5mvXpGHtIJ81JY3XBU62V6qUOnUDL6IZGJ2tAqN3VkULJn+8qEKZYDeseSzMnAD
         xz8NzuojIhHpfD5S83VFA9tVJzVT+ie/XJ/3XUIqvydwhBpQsFSmXowapAM3tJIK+9t4
         frZBwR872/gveLnklXnTuYsE+W3TxLI+tl6hLoOR3rT000B2XZEpt8lZMiNq5i/twRCL
         n0mQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYxPrjSgU3D9Uodc+ujJyYsNhjDapRaaBd1GvSLxhb2p4qTlIQXv3Cy27fJNxwltQw5TazQVQEpVs8igSFkWnfI/SbQq97x6yGcmx9t7Jl
X-Gm-Message-State: AOJu0YxLIuQUA7Iqyn8hd9C0IOoTdPehvoTDJAFV5nzW3heMUVBMY7UD
	ajtZMJfnLYKdaqBEIq6eHeSXkN+MQy++I6InO+zFbAM2sFcI3fDnlVyf2fwIHNhxtQQbMw2jnGF
	8xv5JP6TLp6Sv6csp8OtO83lND+u1+SsK1FtNhA==
X-Google-Smtp-Source: AGHT+IG3Q9tqDRCoXBSygpP82QqE4qbQOWBmSo9N1FXn0IoBGpcE1d3eSJXcfEiHJ+CEwcufUqu40IQOtB1Md0pSaVI=
X-Received: by 2002:a17:90a:630c:b0:2b2:6de2:cdc7 with SMTP id
 98e67ed59e1d1-2b6cc3429f7mr10099479a91.20.1715692315282; Tue, 14 May 2024
 06:11:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503221634.44274-1-ignat@cloudflare.com> <CALrw=nGhgRrhJ5mWWC6sV2WYWoijvD9WgFzMfOe6mHmqnza-Hw@mail.gmail.com>
 <D18XXJ373C2V.2M6AOMKD1B89W@kernel.org> <CALrw=nHGLN=dn3fbyAcXsBufw0tAWUT1PKVHDK5RZkHcdd3CUw@mail.gmail.com>
 <D19CUF0H9Q3S.3L5Y5S9553S5@kernel.org>
In-Reply-To: <D19CUF0H9Q3S.3L5Y5S9553S5@kernel.org>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Tue, 14 May 2024 14:11:44 +0100
Message-ID: <CALrw=nEZ07U9VhbGsnpchOYw1icUZCnuoHHXkJLzhFqSPe9_fQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] TPM derived keys
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, serge@hallyn.com, linux-integrity@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 1:09=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Tue May 14, 2024 at 1:05 PM EEST, Ignat Korchagin wrote:
> > On Tue, May 14, 2024 at 1:28=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.=
org> wrote:
> > >
> > > On Mon May 13, 2024 at 8:11 PM EEST, Ignat Korchagin wrote:
> > > > On Fri, May 3, 2024 at 11:16=E2=80=AFPM Ignat Korchagin <ignat@clou=
dflare.com> wrote:
> > > > I would like to point out to myself I was wrong: it is possible to =
ask
> > > > the kernel to generate a trusted key inside the kernel locally with
> > > > "keyctl add trusted kmk "new 32" @u"
> > >
> > > Not in a full-time kernel position ATM as I'm working as contract
> > > researcher up until beginning of Oct (took some industry break after
> > > a startup went down of business), so please, politely asking, write
> > > a bit more compact descriptions ;-) I'm trying to find a new position=
 by
> > > the beginning of Oct but right now I'd appreciate a bit more thought =
out
> > > text descriptions.
> > >
> > > I'm working out a small patch set with James Prestwood to add asymmet=
ric
> > > TPM2 keys based on his old patch set [1] but laid out on top of the
> > > existing baseline.
> > >
> > > I did already the key type shenanigans etc. for it and James P is lay=
ing
> > > his pre-existing RSA code and new ECDSA on top of that. So this will
> >
> > This is great. Perhaps we can finally have ECDSA software signature
> > support as well, which I have been trying to get in for some time now
> > [1]
>
> Yes exactly both.
>
> >
> > > give x.509 compatibility [2]. This patch set will be out soon and lik=
ely
> > > part of 6.11 (or almost guaranteed as most of it is done).
> > >
> > > So by plain guess this might be along the lines what you might want?
> >
> > I don't think so. I have seen this patchset, but unless the new
> > version is fundamentally different, it looks to me that the asymmetric
> > TPM keys are the same as trusted keys except they are asymmetric
> > instead of being symmetric. That is, they are still of limited use on
> > stateless systems and are subject to the same restrictions I described
> > in my revised cover description.
>
> OK, hmm... can you an "apples and oranges" example what would be
> most trivial use case where these don't cut?

For example, a cheap NAS box with no internal storage (disks connected
externally via USB). We want:
  * disks to be encrypted and decryptable only by this NAS box
  * if someone steals one of the disks - we don't want them to see it
has encrypted data (no LUKS header)

Additionally we may want to SSH into the NAS for configuration and we
don't want the SSH server key to change after each boot (regardless if
disks are connected or not).

>
> > On top of that I'm not sure they would be widely used as "leaf" keys
> > by applications, maybe more as root/intermediate keys in some kind of
> > key hierarchy. TPMs are slow and I don't see a high-performance
> > web-server, for example, using asymmetric TPM keys for TLS operations.
> > Also, as we learned the hard way operating many TPMs in production,
> > some TPMs are quite unreliable and fail really fast, if you "spam"
> > them with a lot of crypto ops. I understand this is a HW/TPM vendor
> > problem, but in practice we're trying to build systems, where TPM is
> > used to protect/generate other keys, but most of the "leaf" crypto
> > operations are done in software, so we don't make the TPM do too much
> > crypto.
>
> So what about SGX/SNP/TDX?

In theory yes, but I have chased the tech for a while on commodity HW
and it keeps having problems.

> TPM is definitely not made for workloads :-)
>
> > Just to clarify - I'm not arguing about the usefulness of TPM
> > asymmetric keys in the kernel. I would really want to see this
> > building block available as well, but I think it just serves a
> > different purpose/use case from what I'm trying to figure out in this
> > RFC thread.
>
> Got it :-) NP
>
> BR, Jarkko

