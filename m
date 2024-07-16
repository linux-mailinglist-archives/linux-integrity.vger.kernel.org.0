Return-Path: <linux-integrity+bounces-3135-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DDF932A42
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 17:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AEBE1F22D83
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 15:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DAD19DFB8;
	Tue, 16 Jul 2024 15:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KuM2abcJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFA219E7D8
	for <linux-integrity@vger.kernel.org>; Tue, 16 Jul 2024 15:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721143133; cv=none; b=QBbkGc/YQDPs3PBrQkR8kT7+8Yatx0EOn7yBJEhjPX+FeFkNQ7oaBdGRnfHm2jWwHkRp7u4vPGq3142PxyhVd2kTKC7Er/EwxcqqCaP5akrCghffvx9Yo68kMV0gSxf1ch5rRRrIH0cQ1ugGd7ILky0y/5ijSTHa9zYW4aRAnWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721143133; c=relaxed/simple;
	bh=9Cy/3Y8kPlwgnsA87ATuYpWF26sXvnlcGY/yqfqbXSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IWnR1khEbRuXcW5bhhlJ3qEo1OyiFORDI0T3JrcX8zSzQ7o89OhVcN8uCdXRL3Zu9iERdYjkIIxyieiKvqnGb3nnu/7b7IMSPdYOI+jdtKnF7A2PY6g0Y4UipcZJnacUl5X04bgjgLPC34fZnDGZPDeR56IUK94Cnr/YIEw1zJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KuM2abcJ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-447f8aa87bfso462601cf.0
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jul 2024 08:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721143131; x=1721747931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWVNrxbBHDXZu/jCvfJLl2ens68sOvgHXhZ1riQlav8=;
        b=KuM2abcJKNu6Wu/Zo6y3Dila7DecYrbJ3Jt4gioQHFe2bftbtrqLfYEDx7ZvWclHS2
         HY8POeFIzuln87aKfgkH39mcSevAbp2lvfj6gWOn0n+xO+RlHMjSfV1C6jF4w89pNtQr
         6QttE9ehDZWnTJppIhMidRDOjxHwb7Hf3+IUzEn0E3AWoBclFHDTZ6BFMkoFe8yH8JhK
         2sAVJWYu0HFyYerDwucdOrwouVmkCQCCj9q4M1LdV7oe/pvY1KsFZO0YomFMX9B/uUlS
         kaNqwnZkhkKf7mBYUcm44e0sorNHWXg8mgDi5vaPxrsS45DcpgBlHTrUTBhdUYjQXn6A
         c99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721143131; x=1721747931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWVNrxbBHDXZu/jCvfJLl2ens68sOvgHXhZ1riQlav8=;
        b=iju0/tCvxxAxbgKN5A8getQ4cCCyZlwuausmBpcvgJ+A5YktQ3qhIk6DoaPvEHLlHa
         cwq2eaGnm0OZDstmRmaSnWlIXzRVmrYRE5eK8K/uYTIB9NSXq3xpV9gvMzM9MG55aaxc
         lZLCxneVjnWOk/mZSUf4IHGgs6C7rQzxAFNWumIG/V6W8BbbXixTMVwH6rPv7go8UOyJ
         9YsnbobthmrgGVtYRa3IXPJZOu5xxellXGgC+P/ymZSNhtHzl50RhQ3ZDhtIYty68VM/
         Vz23ARifgaeSTLFbEtVVOhGLjiYIVeR3Z606h9IOJ9h2JUIud/jh0MDK8wD2lhIWrQd/
         tiPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKN2F8lwxj3yVvVMmmajnuR0N3sJ3+G5InLh9ovw7wXpw3YjXWBiX53pgtT7v3r46LjsJA4MAqElIdAdgZ5xnSkTAzIpGCl11eaccBEP3V
X-Gm-Message-State: AOJu0YxTueZtwUCqvxqXo2ybzbiPNkGCEjzNg965MlEyT+Ntzx0mkJRt
	UZURVd6Vj+hfCP0H4CrIbc4vQKuD2QwhHqqD/maNEEXWmEROUdKaoed7fUCqW+N3dJVwJ2rtZKu
	z3EqtiuYdL/m8drpHCd8hTBrj/jHUpDGfgtnl
X-Google-Smtp-Source: AGHT+IHWbKj34zsRyLKiBWqdmFyKlDq6Wr5+2Wdecg/ZG3HyZU7BuDsfvRbU1vyabej6wFPdLE9jOxxXXzqK9dZsCJU=
X-Received: by 2002:a05:622a:997:b0:444:dc22:fb1d with SMTP id
 d75a77b69052e-44f7a64c7e0mr3638781cf.12.1721143130336; Tue, 16 Jul 2024
 08:18:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708.quoe8aeSaeRi@digikod.net> <CALmYWFuVJiRZgB0ye9eR95dvBOigoOVShgS9i_ESjEre-H5pLA@mail.gmail.com>
 <ef3281ad-48a5-4316-b433-af285806540d@python.org> <CALmYWFuFE=V7sGp0_K+2Vuk6F0chzhJY88CP1CAE9jtd=rqcoQ@mail.gmail.com>
 <20240709.aech3geeMoh0@digikod.net> <CALmYWFuOXAiT05Pi2rZ1nUAKDGe9JyTH7fro2EYS1fh3zeGV5Q@mail.gmail.com>
 <20240710.eiKohpa4Phai@digikod.net> <202407100921.687BE1A6@keescook>
 <20240711.sequuGhee0th@digikod.net> <CALmYWFt7X0v8k1N9=aX6BuT2gCiC9SeWwPEBckvBk8GQtb0rqQ@mail.gmail.com>
 <20240716.Zah8Phaiphae@digikod.net>
In-Reply-To: <20240716.Zah8Phaiphae@digikod.net>
From: Jeff Xu <jeffxu@google.com>
Date: Tue, 16 Jul 2024 08:18:09 -0700
Message-ID: <CALmYWFu=kdsxZwj-U5yqCUXrhvzxWCt1YjuJv0eAAaAyGFbxFQ@mail.gmail.com>
Subject: Re: [RFC PATCH v19 2/5] security: Add new SHOULD_EXEC_CHECK and
 SHOULD_EXEC_RESTRICT securebits
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Kees Cook <kees@kernel.org>, Steve Dower <steve.dower@python.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Paul Moore <paul@paul-moore.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Alejandro Colomar <alx@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Casey Schaufler <casey@schaufler-ca.com>, 
	Christian Heimes <christian@python.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Eric Biggers <ebiggers@kernel.org>, Eric Chiang <ericchiang@google.com>, 
	Fan Wu <wufan@linux.microsoft.com>, Florian Weimer <fweimer@redhat.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, James Morris <jamorris@linux.microsoft.com>, 
	Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Luca Boccassi <bluca@debian.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Scott Shell <scottsh@microsoft.com>, 
	Shuah Khan <shuah@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Steve Grubb <sgrubb@redhat.com>, 
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, 
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>, Xiaoming Ni <nixiaoming@huawei.com>, 
	Yin Fengwei <fengwei.yin@intel.com>, kernel-hardening@lists.openwall.com, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 8:15=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> On Tue, Jul 16, 2024 at 08:02:37AM -0700, Jeff Xu wrote:
> > On Thu, Jul 11, 2024 at 1:57=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > >
> > > On Wed, Jul 10, 2024 at 09:26:14AM -0700, Kees Cook wrote:
> > > > On Wed, Jul 10, 2024 at 11:58:25AM +0200, Micka=C3=ABl Sala=C3=BCn =
wrote:
> > > > > Here is another proposal:
> > > > >
> > > > > We can change a bit the semantic by making it the norm to always =
check
> > > > > file executability with AT_CHECK, and using the securebits to res=
trict
> > > > > file interpretation and/or command injection (e.g. user supplied =
shell
> > > > > commands).  Non-executable checked files can be reported/logged a=
t the
> > > > > kernel level, with audit, configured by sysadmins.
> > > > >
> > > > > New securebits (feel free to propose better names):
> > > > >
> > > > > - SECBIT_EXEC_RESTRICT_FILE: requires AT_CHECK to pass.
> > > >
> > > > Would you want the enforcement of this bit done by userspace or the
> > > > kernel?
> > > >
> > > > IIUC, userspace would always perform AT_CHECK regardless of
> > > > SECBIT_EXEC_RESTRICT_FILE, and then which would happen?
> > > >
> > > > 1) userspace would ignore errors from AT_CHECK when
> > > >    SECBIT_EXEC_RESTRICT_FILE is unset
> > >
> > > Yes, that's the idea.
> > >
> > > >
> > > > or
> > > >
> > > > 2) kernel would allow all AT_CHECK when SECBIT_EXEC_RESTRICT_FILE i=
s
> > > >    unset
> > > >
> > > > I suspect 1 is best and what you intend, given that
> > > > SECBIT_EXEC_DENY_INTERACTIVE can only be enforced by userspace.
> > >
> > > Indeed. We don't want AT_CHECK's behavior to change according to
> > > securebits.
> > >
> > One bit is good.
> >
> > > >
> > > > > - SECBIT_EXEC_DENY_INTERACTIVE: deny any command injection via
> > > > >   command line arguments, environment variables, or configuration=
 files.
> > > > >   This should be ignored by dynamic linkers.  We could also have =
an
> > > > >   allow-list of shells for which this bit is not set, managed by =
an
> > > > >   LSM's policy, if the native securebits scoping approach is not =
enough.
> > > > >
> > > > > Different modes for script interpreters:
> > > > >
> > > > > 1. RESTRICT_FILE=3D0 DENY_INTERACTIVE=3D0 (default)
> > > > >    Always interpret scripts, and allow arbitrary user commands.
> > > > >    =3D> No threat, everyone and everything is trusted, but we can=
 get
> > > > >    ahead of potential issues with logs to prepare for a migration=
 to a
> > > > >    restrictive mode.
> > > > >
> > > > > 2. RESTRICT_FILE=3D1 DENY_INTERACTIVE=3D0
> > > > >    Deny script interpretation if they are not executable, and all=
ow
> > > > >    arbitrary user commands.
> > > > >    =3D> Threat: (potential) malicious scripts run by trusted (and=
 not
> > > > >       fooled) users.  That could protect against unintended scrip=
t
> > > > >       executions (e.g. sh /tmp/*.sh).
> > > > >    =3D=3D> Makes sense for (semi-restricted) user sessions.
> > > > >
> > > > > 3. RESTRICT_FILE=3D1 DENY_INTERACTIVE=3D1
> > > > >    Deny script interpretation if they are not executable, and als=
o deny
> > > > >    any arbitrary user commands.
> > > > >    =3D> Threat: malicious scripts run by untrusted users.
> > > > >    =3D=3D> Makes sense for system services executing scripts.
> > > > >
> > > > > 4. RESTRICT_FILE=3D0 DENY_INTERACTIVE=3D1
> > > > >    Always interpret scripts, but deny arbitrary user commands.
> > > > >    =3D> Goal: monitor/measure/assess script content (e.g. with IM=
A/EVM) in
> > > > >       a system where the access rights are not (yet) ready.  Arbi=
trary
> > > > >       user commands would be much more difficult to monitor.
> > > > >    =3D=3D> First step of restricting system services that should =
not
> > > > >        directly pass arbitrary commands to shells.
> > > >
> > > > I like these bits!
> > >
> > > Good! Jeff, Steve, Florian, Matt, others, what do you think?
> >
> > For below two cases: will they be restricted by one (or some) mode abov=
e ?
> >
> > 1> cat /tmp/a.sh | sh
> >
> > 2> sh -c "$(cat /tmp/a.sh)"
>
> Yes, DENY_INTERACTIVE=3D1 is to deny both of these cases (i.e. arbitrary
> user command).
>
> These other examples should be allowed with AT_CHECK and RESTRICT_FILE=3D=
1
> if a.sh is executable though:
> * sh /tmp/a.sh
> * sh < /tmp/a.sh
That looks good. Thanks for clarifying.

