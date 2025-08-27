Return-Path: <linux-integrity+bounces-6940-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A61AB38B04
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Aug 2025 22:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C877C2BC2
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Aug 2025 20:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861B12F60D6;
	Wed, 27 Aug 2025 20:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="GJalcVct"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3F12F39C7
	for <linux-integrity@vger.kernel.org>; Wed, 27 Aug 2025 20:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756326933; cv=none; b=Galn6+ZZJNfgT7BiDsHmy/UWph6m/8PopJHJ5uYXsAgLttL4gcSmqXu8HMk8dVTBrlZMwk8n2cObZhCvfWIDRl8yyim5bWCnlXyUcjbZXv/PGHIDStF0/BCpPNi8A68bkd8CWEwtoNQ9/XMdLUpOa8kISzmKu9armFXOK7tmnTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756326933; c=relaxed/simple;
	bh=p6ZnKcI6F1mAg5pkdsDn0kIOGkIWEzaMWKJgn7QqNeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tWHTYcSl2klytqSsBJo3Yes2UINLZLzziiQ3210qyVKk1BhtJqy7gMv5PbKbI06nGvR1OZ1UWCv6uzbTS4XOuoO9BctPuNyEsFEYcODvlJyHBCx93pZuL4dSW5geN1aZ1lvohtrzesFAMYrHXQ5mk7NMY8974/LE7Q8Cb1CFZe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=GJalcVct; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3367483097eso2367751fa.0
        for <linux-integrity@vger.kernel.org>; Wed, 27 Aug 2025 13:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1756326925; x=1756931725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wl0ljXkPyLBoAJTX9TjDS8ZEVo6BAT27dTBeN90CXWg=;
        b=GJalcVct1ylww4R06bAl1a/YAkEtNyGc/ApXVXzRUqrz0sigmC8ZNhV/T7KYq1MxEV
         fuEGCNtGIuRSX8GnpWnIq9hJ30M6m1ekxmwHqof1Jjz7jADsVFmlS4oTd0nlzZ6j0PVt
         QrZwp0Ypi3RX9o/0HCFgroQPTM/K9NCOOyjL+aN2l1Dc5r+ZGI2UW5OVJ9/jbcVVFLwa
         +Vb5Q9zDwglekmx/8z7aN719XO79/0FXhF3gT9MYCJpyuMBDI2SIeFQ2PtDVVIxvHpN8
         ijCb5Lx7q67MG8jt+zxONJ5o9Kla1DK+jezTp00pnbh3+A060Z+2pmPyKi1L1wXPQ8zq
         TJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756326925; x=1756931725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wl0ljXkPyLBoAJTX9TjDS8ZEVo6BAT27dTBeN90CXWg=;
        b=ZdHPitcn0L6sLKnoHWlMNu/DoSDjNPFz6USSxNZe7Tpr2u01mfB0ztncfAiGRoM+3X
         Rermvr1iZ/AgOFHtmFJ2z/V8ohS1XVgEKXpNmo/+VHpJr9rM13TaYZH3bTi+pnv+azyA
         B2NKLgLFoSdHQ5+1niWz0KWRr7BOXqatcjUCdiFB9BCZS5rIeaOuK47S8wQUpVR7oMVC
         lfi4xQb8wSNpmZiG1zTrgiMsTdmp1NhQ5ARQG3rFSYPUUw9GW9zZF2Y+vOlF6FCSASip
         gyk2ANdijoAJpXsm401z87qWWEXhhfI/wH1U6wBI+x76E/LGnJf4Km3AAiMr0Acg670L
         hvbg==
X-Forwarded-Encrypted: i=1; AJvYcCVkLv/mmqLRlp1xVwbA5KxZ1a5Y684PxlhZGSd75OZTCdcarQ5dC96p8gN/pKah2jGPq2AqxLCStS/lNxuERcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAXJvk7+azlqTdFK7GNyHV9i1Y0jeWnhPJf9hF5nZZxof7GbQT
	IOCPCQoKS3l+3SgqEujoCIJJXXh0xPVBoXk17pdoZp+MlzK/1y4bWmDD1jBY/8gcHgcKoud/S1z
	5LKqEnBGLQOP9UfjDVWwIWMpsfC5fVRi0lzuNIlA+
X-Gm-Gg: ASbGncukfnEcjbuhmFZ7tG303LMCGjVoHoxLuD4rufWp2S16xnsThCUqVBRp/yes7/r
	RFvI8XBbxfKfaXpYnWVzJ2gdcASmS5HMXW8ocs2gG1OElh+qb8gU8vdLt1Y9y7x1ZUOETqlxCXG
	jDiTKLhHwZdA6zCH2O2QBUfz/OORVojQ4J24ZrDqCWJUGVzXPCNFj51D/VzQMkVHBIofUueN1e2
	XR8EWagKRjULTkIXmg=
X-Google-Smtp-Source: AGHT+IGjsa20oKobGhO2nM0A+5O9r9SpySfPXdDwEkZvs/Q/UX/cGwHkgk6K1CRbBEum5T5gJOenn7JtwIEd8EnKFq0=
X-Received: by 2002:a05:651c:41cf:b0:335:4d0e:9493 with SMTP id
 38308e7fff4ca-33650f997d5mr58918271fa.28.1756326925222; Wed, 27 Aug 2025
 13:35:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822170800.2116980-1-mic@digikod.net> <20250826-skorpion-magma-141496988fdc@brauner>
 <20250826.aig5aiShunga@digikod.net> <20250826123041.GB1603531@mit.edu>
 <20250826.iewie7Et5aiw@digikod.net> <CALCETrW=V9vst_ho2Q4sQUJ5uZECY5h7TnF==sG4JWq8PsWb8Q@mail.gmail.com>
 <20250827.Fuo1Iel1pa7i@digikod.net>
In-Reply-To: <20250827.Fuo1Iel1pa7i@digikod.net>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 27 Aug 2025 13:35:13 -0700
X-Gm-Features: Ac12FXyp51op4OQBdoTDCrgv2p90HecB5l5_GBOrhFfKRX5VCL-77MvuK466l-o
Message-ID: <CALCETrVDJYK+vWOe+-NACAqQ9i4nhCz-7rMMdkRuxexgnpzZow@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/2] Add O_DENY_WRITE (complement AT_EXECVE_CHECK)
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Andy Lutomirski <luto@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <serge@hallyn.com>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Heimes <christian@python.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Elliott Hughes <enh@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jordan R Abrahams <ajordanr@google.com>, 
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Luca Boccassi <bluca@debian.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Miklos Szeredi <mszeredi@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Robert Waite <rowait@microsoft.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Scott Shell <scottsh@microsoft.com>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, 
	kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 12:07=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
>
> On Wed, Aug 27, 2025 at 10:35:28AM -0700, Andy Lutomirski wrote:
> > On Tue, Aug 26, 2025 at 10:47=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@=
digikod.net> wrote:
> > >
> > > On Tue, Aug 26, 2025 at 08:30:41AM -0400, Theodore Ts'o wrote:
> > > > Is there a single, unified design and requirements document that
> > > > describes the threat model, and what you are trying to achieve with
> > > > AT_EXECVE_CHECK and O_DENY_WRITE?  I've been looking at the cover
> > > > letters for AT_EXECVE_CHECK and O_DENY_WRITE, and the documentation
> > > > that has landed for AT_EXECVE_CHECK and it really doesn't describe
> > > > what *are* the checks that AT_EXECVE_CHECK is trying to achieve:
> > > >
> > > >    "The AT_EXECVE_CHECK execveat(2) flag, and the
> > > >    SECBIT_EXEC_RESTRICT_FILE and SECBIT_EXEC_DENY_INTERACTIVE
> > > >    securebits are intended for script interpreters and dynamic link=
ers
> > > >    to enforce a consistent execution security policy handled by the
> > > >    kernel."
> > >
> > > From the documentation:
> > >
> > >   Passing the AT_EXECVE_CHECK flag to execveat(2) only performs a che=
ck
> > >   on a regular file and returns 0 if execution of this file would be
> > >   allowed, ignoring the file format and then the related interpreter
> > >   dependencies (e.g. ELF libraries, script=E2=80=99s shebang).
> > >
> > > >
> > > > Um, what security policy?
> > >
> > > Whether the file is allowed to be executed.  This includes file
> > > permission, mount point option, ACL, LSM policies...
> >
> > This needs *waaaaay* more detail for any sort of useful evaluation.
> > Is an actual credible security policy rolling dice?  Asking ChatGPT?
> > Looking at security labels?  Does it care who can write to the file,
> > or who owns the file, or what the file's hash is, or what filesystem
> > it's on, or where it came from?  Does it dynamically inspect the
> > contents?  Is it controlled by an unprivileged process?
>
> AT_EXECVE_CHECK only does the same checks as done by other execveat(2)
> calls, but without actually executing the file/fd.
>

okay... but see below.

> >
> > I can easily come up with security policies for which DENYWRITE is
> > completely useless.  I can come up with convoluted and
> > not-really-credible policies where DENYWRITE is important, but I'm
> > honestly not sure that those policies are actually useful.  I'm
> > honestly a bit concerned that AT_EXECVE_CHECK is fundamentally busted
> > because it should have been parametrized by *what format is expected*
> > -- it might be possible to bypass a policy by executing a perfectly
> > fine Python script using bash, for example.
>
> There have been a lot of bikesheding for the AT_EXECVE_CHECK patch
> series, and a lot of discussions too (you where part of them).  We ended
> up with this design, which is simple and follows the kernel semantic
> (requested by Linus).

I recall this.  That doesn't mean I totally love AT_EXECVE_CHECK.  And
it especially doesn't mean that I believe that it usefully does
something that justifies anything like DENYWRITE.

>
> >
> > I genuinely have not come up with a security policy that I believe
> > makes sense that needs AT_EXECVE_CHECK and DENYWRITE.  I'm not saying
> > that such a policy does not exist -- I'm saying that I have not
> > thought of such a thing after a few minutes of thought and reading
> > these threads.
>
> A simple use case is for systems that wants to enforce a
> write-xor-execute policy e.g., thanks to mount point options.

Sure, but I'm contemplating DENYWRITE, and this thread is about
DENYWRITE.  If the kernel is enforcing W^X, then there are really two
almost unrelated things going on:

1. LSM policy that enforces W^X for memory mappings.  This is to
enforce that applications don't do nasty things like having executable
stacks, and it's a mess because no one has really figured out how JITs
are supposed to work in this world.  It has almost nothing to do with
execve except incidentally.

2. LSM policy that enforces that someone doesn't execve (or similar)
something that *that user* can write.  Or that non-root can write.  Or
that anyone at all can write, etc.

I think, but I'm not sure, that you're talking about #2.  So maybe
there's a policy that says that one may only exec things that are on
an fs with the 'exec' mount option.  Or maybe there's a policy that
says that one may only exec things that are on a readonly fs.  In
these specific cases, I believe in AT_EXECVE_CHECK.  *But* I don't
believe in DENYWRITE: in the 'exec' case, if an fs has the exec option
set, that doesn't change if the file is subsequently modified.  And if
an fs is readonly, then the file is quite unlikely to be modified at
all and will certainly not be modified via the mount through which
it's being executed.  And you don't need DENYWRITE.

So I think my question still stands: is there a credible security
policy *that actually benefits from DENYWRITE*?  If so, can you give
an example?

> >
> > Seriously, consider all the unending recent attacks on LLMs an
> > inspiration.  The implications of viewing an image, downscaling the
> > image, possibly interpreting the image as something containing text,
> > possibly following instructions in a given language contained in the
> > image, etc are all wildly different.  A mechanism for asking for
> > general permission to "consume this image" is COMPLETELY MISSING THE
> > POINT.  (Never mind that the current crop of LLMs seem entirely
> > incapable of constraining their own use of some piece of input, but
> > that's a different issue and is besides the point here.)
>
> You're asking about what should we consider executable.  This is a good
> question, but AT_EXECVE_CHECK is there to answer another question: would
> the kernel execute it or not?
>

That's a sort of odd way of putting it.  The kernel won't execute it
because the kernel doesn't know how to :)  But I think I understand
what you're saying.

