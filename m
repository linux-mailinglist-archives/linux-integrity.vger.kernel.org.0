Return-Path: <linux-integrity+bounces-6954-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8876BB3E0FE
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Sep 2025 13:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A68D201A57
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Sep 2025 11:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2603115AC;
	Mon,  1 Sep 2025 11:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zhHF+ZPQ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAFD3112DA
	for <linux-integrity@vger.kernel.org>; Mon,  1 Sep 2025 11:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756724757; cv=none; b=dteXhuUC7v5P46r3NPsJapGJpln9cNcpxuLDOICbI5RhLzPG9D2c8WFDl63Dgj/hugCbIrX+AslwP46YoJK5EnACZ4n7kycQbJXcVYnBHnr+0X2OIcwxx8w5KHgvwYub97tzwgt0+7uRZAoTs4XmhYb96+lsbkSlS5ZIxEWVnO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756724757; c=relaxed/simple;
	bh=p5+1izTU/BboUNRpObEumq/hltcsExWIGEz2Tq4Mlo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fgBtyrU97pXRAk635q4uS/GA/gAqiHy/l/rTibeR4jf29/MMQToE14mWdZxaZOBVhr/lS3+n3Rv1yKbYVW8MOzw3grNEY0Ex8CZPTuLyV6O4BsGKyfPGBKZaNT+I8ABbk2ILzUGTFcloE9ISApBXGnDR6Iq8SwK56d75O4+bACE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zhHF+ZPQ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61d14448c22so10900a12.1
        for <linux-integrity@vger.kernel.org>; Mon, 01 Sep 2025 04:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756724754; x=1757329554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2Gn0F3UVjDM2gGMhXQsx0gqpBNXUu+/C4/628F9+6w=;
        b=zhHF+ZPQQ/cdUNcvWh9wRQxdLj+Q5qvDkcVdB4GsJu8w4TG/Sx7VpadW/u2+VM90kD
         MWZ7KefcoVJDE66nFlxhSUWnTyKzQ6+8DGPWC0YAb+M7J3SMBjcPUa9fac/4kqFdiRZN
         bmh8xPNpN356jqTIFE3lvh5rIAIDMSHzPKvvSRz8b1sP/z2gjnf/aYTzUszPpz4eo4Rc
         Ek7LC+xd7MHhUINzM69dKqVr0ImvVRnaxDNJB100uSTNhQTz98goiqH6BFPo4v+fgMsJ
         0/sASHjaxJbup7ylconpLxJdRZRsJhpr3kDIQ6pv6z18H/VYgUcwY36BQHszM9smF9JM
         GKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756724754; x=1757329554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2Gn0F3UVjDM2gGMhXQsx0gqpBNXUu+/C4/628F9+6w=;
        b=AVyu/tzM/7qvyQqrm0UqgkuKqRryh5r68C+ppMekYMQZ934sLtjiT504ztqopZyS9O
         Rms5w/BICZofvx7dHEXCR/co0fMWe6HvxmvNLdfu6wCuP5MBrLDL6LTByJHCx9VncIOi
         KMDSg2LuczkuFEX2H4YU3cWezNpTlL7m57um6Wq2rQVs2HmIqzxx+Ra3OrcRMKkJ1Cjs
         p1mS8lBPOD/TGcqzgLnICewRyyDLDsgPQX/s9xkzG3hPo0gLHnE9kUObzhWHpKMSMpcr
         rhlNUlNmf76dGbnoCwX+nM7bYidXNHbA0fbfUl8TFICM0t95/M0p7iRnUza6EGoLMptB
         hRAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2RhP/zmz4mPcxiuivNNxiNXIFIFW2AfFsXHKKbzXHZJmRAgcf/W5pxS4y1XV/ZqABzRTHiyKdIwacJjvwAHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfvtYQAC2un4/LKmJ3jZCHVNGGcbvVFPO6GT5nKKM1AqYmH1aF
	ZJKzO5fpE5YMiwPtkMm3zJQQfS2M7M3UL3/pyC9UxgH7/RtLuTWJHe2S8BOpUsPJ+ja23e46BzY
	U1hjPNb/m48ts8E8pF63+W2cXZUvKHi06bqXadDRJ
X-Gm-Gg: ASbGncs1uMpTAmLXdYm+Fptgr31evD0dhRCP8Z7Xeb9h1bNF9txPqVtX+cbXQgYjUwt
	BY1hUYJTyUXQbw08Iae3MATO8b5Lql4Ca9Cce0AztdthrlBEW+IVmDDuypGuxpdKL5pqH27eaCA
	hidrosplkcvZUAM/uUf/x+rQP0Mazfg9YEq4QBc+fRN3wM28gbIQGjtkKUbZZl+xbDeiPw59qe3
	93GwH/jaKiEwhY3TlDbJvmHEmCezixNTRQVEK99dw==
X-Google-Smtp-Source: AGHT+IEX9I7U3nv8ZNRMUsZz4F6PIX/KTn5ofQX/L8rVN2zWLtQUH9G0KmEck4019L1pfWH3sn8LvwP06awvWqA6Rb8=
X-Received: by 2002:a05:6402:14ca:b0:61e:a896:de87 with SMTP id
 4fb4d7f45d1cf-61ea896df66mr30742a12.2.1756724753434; Mon, 01 Sep 2025
 04:05:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822170800.2116980-1-mic@digikod.net> <20250826-skorpion-magma-141496988fdc@brauner>
 <20250826.aig5aiShunga@digikod.net> <2025-08-27-obscene-great-toy-diary-X1gVRV@cyphar.com>
 <CALCETrWHKga33bvzUHnd-mRQUeNXTtXSS8Y8+40d5bxv-CqBhw@mail.gmail.com> <aLDDk4x7QBKxLmoi@mail.hallyn.com>
In-Reply-To: <aLDDk4x7QBKxLmoi@mail.hallyn.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 1 Sep 2025 13:05:16 +0200
X-Gm-Features: Ac12FXz5pCbJNirecqxwiyEggxW7kJ9K_j8hu8U2LuwZM19I7qdULHA6wz1yLJg
Message-ID: <CAG48ez0p1B9nmG3ZyNRywaSYTtEULSpbxueia912nVpg2Q7WYA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/2] Add O_DENY_WRITE (complement AT_EXECVE_CHECK)
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Andy Lutomirski <luto@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>, 
	Arnd Bergmann <arnd@arndb.de>, Christian Heimes <christian@python.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Elliott Hughes <enh@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Luca Boccassi <bluca@debian.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Robert Waite <rowait@microsoft.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Scott Shell <scottsh@microsoft.com>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, 
	kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 11:01=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com>=
 wrote:
> On Wed, Aug 27, 2025 at 05:32:02PM -0700, Andy Lutomirski wrote:
> > On Wed, Aug 27, 2025 at 5:14=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com=
> wrote:
> > >
> > > On 2025-08-26, Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> wrote:
> > > > On Tue, Aug 26, 2025 at 11:07:03AM +0200, Christian Brauner wrote:
> > > > > Nothing has changed in that regard and I'm not interested in stuf=
fing
> > > > > the VFS APIs full of special-purpose behavior to work around the =
fact
> > > > > that this is work that needs to be done in userspace. Change the =
apps,
> > > > > stop pushing more and more cruft into the VFS that has no busines=
s
> > > > > there.
> > > >
> > > > It would be interesting to know how to patch user space to get the =
same
> > > > guarantees...  Do you think I would propose a kernel patch otherwis=
e?
> > >
> > > You could mmap the script file with MAP_PRIVATE. This is the *actual*
> > > protection the kernel uses against overwriting binaries (yes, ETXTBSY=
 is
> > > nice but IIRC there are ways to get around it anyway).
> >
> > Wait, really?  MAP_PRIVATE prevents writes to the mapping from
> > affecting the file, but I don't think that writes to the file will
> > break the MAP_PRIVATE CoW if it's not already broken.
> >
> > IPython says:
> >
> > In [1]: import mmap, tempfile
> >
> > In [2]: f =3D tempfile.TemporaryFile()
> >
> > In [3]: f.write(b'initial contents')
> > Out[3]: 16
> >
> > In [4]: f.flush()
> >
> > In [5]: map =3D mmap.mmap(f.fileno(), f.tell(), flags=3Dmmap.MAP_PRIVAT=
E,
> > prot=3Dmmap.PROT_READ)
> >
> > In [6]: map[:]
> > Out[6]: b'initial contents'
> >
> > In [7]: f.seek(0)
> > Out[7]: 0
> >
> > In [8]: f.write(b'changed')
> > Out[8]: 7
> >
> > In [9]: f.flush()
> >
> > In [10]: map[:]
> > Out[10]: b'changed contents'
>
> That was surprising to me, however, if I split the reader
> and writer into different processes, so

Testing this in python is a terrible idea because it obfuscates the
actual syscalls from you.

> P1:
> f =3D open("/tmp/3", "w")
> f.write('initial contents')
> f.flush()
>
> P2:
> import mmap
> f =3D open("/tmp/3", "r")
> map =3D mmap.mmap(f.fileno(), f.tell(), flags=3Dmmap.MAP_PRIVATE, prot=3D=
mmap.PROT_READ)
>
> Back to P1:
> f.seek(0)
> f.write('changed')
>
> Back to P2:
> map[:]
>
> Then P2 gives me:
>
> b'initial contents'

Because when you executed `f.write('changed')`, Python internally
buffered the write. "changed" is never actually written into the file
in your example. If you add a `f.flush()` in P1 after this, running
`map[:]` in P2 again will show you the new data.

