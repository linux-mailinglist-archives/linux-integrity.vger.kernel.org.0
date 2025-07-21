Return-Path: <linux-integrity+bounces-6660-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 887BAB0CD06
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Jul 2025 23:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB5E73A7784
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Jul 2025 21:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9D023C514;
	Mon, 21 Jul 2025 21:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YwjV8zPw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB412309BE
	for <linux-integrity@vger.kernel.org>; Mon, 21 Jul 2025 21:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753135170; cv=none; b=CKiZKg3n/cw3NUm4/p/DIztq5fvsnzNf6HuxE5/+ZaI0ZuoLVzEgS3AiyLnxyam1f6AZrz/xE0mtxZll0TyYiCnJevFYjcSJA834qXNc8y7+4N3f4m5fj6WQN8Rh3+I9NjibqFkcxSC2dm/cEOqMWpKGYVegRn3DOXz41FTfLuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753135170; c=relaxed/simple;
	bh=GN/2VDE/5x9sy0SuMuAkFZFulF2F7YMdN8uaKg0YNr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CmY4CvaX670zQLmq38eH5COxvUsLMboSTpOzOGW1S6/u42L8QyLE3ZISiDOkcizbLhFyGLcA0iPjJGO8+jzlVeWJwParbd6FdUZf47jVVrJuDs8xDfYutr06nXARGrCeClEp5Of91fI47a5nNIUFVbPYVZPK0ruTQNPTQgeIGhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YwjV8zPw; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e8db917573dso172825276.1
        for <linux-integrity@vger.kernel.org>; Mon, 21 Jul 2025 14:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753135167; x=1753739967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+ppndZkAqudCa4AHUWqjkn54p+d1I1igNofPGCGnJo=;
        b=YwjV8zPw3aH95HHglQCGrMKUULeO8jldPBkl7OPSaAI1WW8AFkW+siJj7TZMgtJ48W
         L9etvhB0EOwFWPKWHEzrwhyPxlInHgiN8pOoG2nA3P5mV9koICSsMZ/5PnEkVEsrubEP
         Qg8yXWXKMIFcR3ci2JbKuGh6Yp1EA21QZmn29xmqZpdomKs+UyS0WzqVl2NRN60ZX8A7
         UNflZpP9AwgStdCc1awUDjbMcRz0s1nFYe/Q9rblEjhjit/J41UcfBcZgAaxdN6i0Fn2
         KM7tkPZM+m02645zxuWkK6IPIEF+WfeihSXJfKSDTFqyObYm4RpQApPV00GVYZf5CLgo
         Uz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753135167; x=1753739967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+ppndZkAqudCa4AHUWqjkn54p+d1I1igNofPGCGnJo=;
        b=Noau2PdOq+ZEoq5FErBag7/lGSr406jpB61rnd6iz7zglmXCK5JgBHtaKvkp/l4HuN
         9KtgpgGuDsNhf5N+da3edasXuUTpuxzP0kaiQwO7ZhpmH6nwZVmsHklUY0AChkal5b+k
         Pvyo1bUJzV552FOB426OVpQJLyWmgOQOG+D24A8n7+J1mzudoOJPTazevtaoj5SLIa29
         LpiDSXBa4uiFpTtNS0XEgQybFqWIuGqzoocOZG1fWkalZJ0c4vgPcN7ECtWRMXHGIGJJ
         2aU4B1mlikaTyNMvwmdpc/N0dzGD+IH16/XgEf4toIttPfaEVGVRR2me5ICgKc6RDuay
         rwEg==
X-Forwarded-Encrypted: i=1; AJvYcCUC2Fz8lOZMg80fUnyhjXoBuT8HSilDVmf6utuF3uB1SWNtt8UW5sMR36bTE3ODzKZik3sl9/rL83Sg8sJnNjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsOYxOG98BxU5+b5KOXlXItGWSIImvNrM3aZZjtL+s2c8hnrAi
	bbnNPCzu3IPDnOXydfP/HPRAJoqloWXyrxmhZCKXnmAsZeLeSTGs3U1RsC+t4MRia0zIt/9v3Sz
	HkVgymJHe+DBk/F53JTshxE3HR3pYKIJ6an7gXVKP
X-Gm-Gg: ASbGncsC+I9r0IFJyItc5ERWcFVKy3fKHjD5ZZQWuUD1yozpFzd2+qsNInYaX6SXNwi
	NL+23WWrhybCGF1XW2x7QY3mwNwux6GL9USu+7K+LMuc01Lch14DnPeNns1myx9fXU22GwI2BNB
	NnvRcAEqapFn/z3R3aBziTRpbGi0yKP0g2RuHIoxVptE9ocGcI3TDTwwU665u1rSk2ncTqHqkjd
	vdukNYaQjfUXcrNUQ==
X-Google-Smtp-Source: AGHT+IE1qvvx8c7K5J7JCPj9GKxpg1bKS0SyLyBqGrVR1kvAC6PumEIScnTtUQFYLL39P2IaCpRb7QubQ5VqCaV5cCE=
X-Received: by 2002:a05:6902:841:b0:e8b:3e67:b90c with SMTP id
 3f1490d57ef6-e8bc2454590mr23300713276.16.1753135167230; Mon, 21 Jul 2025
 14:59:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-56-paul@paul-moore.com>
 <12d9ea5981f5a2c33a01798311543db2e9bd4ee3.camel@linux.ibm.com>
 <CAHC9VhTfNQeu3gcWii7kUrGY+fVygXs6j4UhybodPqjuSzA-pQ@mail.gmail.com> <ae5e62722e238f55315b7ce523f7d2eb3af5e063.camel@linux.ibm.com>
In-Reply-To: <ae5e62722e238f55315b7ce523f7d2eb3af5e063.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 21 Jul 2025 17:59:15 -0400
X-Gm-Features: Ac12FXzqKIhaDFZBAQ7R-47fmnQb7MjQIOuEzggw7RCTbVzRyGOsED2sjeYEfy4
Message-ID: <CAHC9VhQPxNDeXGAa0WLJ_O7uFVQhhYO8y+KMaXDM7TJ6P8wG3w@mail.gmail.com>
Subject: Re: [RFC PATCH 25/29] ima,evm: move initcalls to the LSM framework
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Eric Snowberg <eric.snowberg@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 4:35=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Wed, 2025-06-11 at 16:27 -0400, Paul Moore wrote:
> > On Fri, May 30, 2025 at 6:04=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com=
> wrote:
> > > On Wed, 2025-04-09 at 14:50 -0400, Paul Moore wrote:
> > > > This patch converts IMA and EVM to use the LSM frameworks's initcal=
l
> > > > mechanism.  There were two challenges to doing this conversion: the
> > > > first simply being the number of initcalls across IMA and EVM, and =
the
> > > > second was the number of resources shared between the two related,
> > > > yet independent LSMs.
> > >
> > > There are a number of the initcalls under integrity/platform/, which =
load arch
> > > specific keys onto the platform and machine keyrings, which shouldn't=
 be
> > > included in this patch.
> >
> > I don't want to assume too much from your reply, but if the cert/key
> > loading under integrity/platform shouldn't be subject to the LSM
> > initcall rework, that implies that the integrity/platform cert/key
> > loading is independent of IMA/EVM and should perhaps live somewhere
> > else, e.g. security/keys?
> >
> > Or am I misunderstanding something?
>
> When the .platform keyring was upstreamed it was upstreamed for a very sp=
ecific
> purpose so that IMA could verify the kexec kernel image.  Afterwareds it =
was
> immediately used to verify the pesigned kexec image.  Now it is being (ab=
)used
> by other subsystems - ipe and dm-verity - and is being proposed by the "[=
PATCH
> RFC 0/1] module: Optionally use .platform keyring for signatures verifica=
tion".
> From an integrity perspective this is definitely not a good idea.  The
> discussion, which I'm sure you're aware of, is here:
> https://lore.kernel.org/linux-integrity/20250602132535.897944-1-vkuznets@=
redhat.com/
>
> It does not make any sense to move the code for the platform and machine
> keyrings to security/keys.  If they need to move anywhere, it would be to=
 the
> certs/ directory.

To bring some off-list discussions back on-list, and wrap up this
thread, Mimi has agreed to move the platform and machine keyring code
to the certs/ directory as they are no longer IMA/EVM-only keyrings.
I'll also be dropping them from the next revision of LSM
initialization rework patchset will be posted at some point this
evening (waiting on a testing refresh).

--=20
paul-moore.com

