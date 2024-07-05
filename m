Return-Path: <linux-integrity+bounces-3022-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B225928D3C
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jul 2024 20:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FE4C2848B8
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jul 2024 18:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3676AA31;
	Fri,  5 Jul 2024 18:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="vLPJ8Ots"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808B138F9A
	for <linux-integrity@vger.kernel.org>; Fri,  5 Jul 2024 18:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720202530; cv=none; b=oim/j1IaCMVF/YJ8tYCV4Pr1Hlor1xL3zuLSgrVRDulN4Sbqck8/KUBOCZzn9VXoKheEBW4iZmDZ35SVgeHIcl8YIeBZeqzfZWsurpgbMWXlhZtgPtORMklQecvrC6Pq3YCdX3/0lnizwQ+NwBf74R2ayhMuzXY7UOOj6O8Rb5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720202530; c=relaxed/simple;
	bh=1ovZsTEE4mGTjZJNE9Bn+x7nEz8rd0oYSMZQ7aLG7dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghK7pyfp2rGmQSb5iIy/vT8nP2DAV9fHvaXxTG9jLh/VhDDzJkcqE70WnZEO5iKUP0l7VTI+cMFjJqHUpEhtvOAwLXlFeOQihGJCvtOeWtBErQzxVE3w62DwgoSfaeRBYXsXizDgwE4p/fXOqn6QTjOAmqf5fcTrJwC/Wf/fJPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=vLPJ8Ots; arc=none smtp.client-ip=45.157.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WG1Mk0nY6zGDF;
	Fri,  5 Jul 2024 19:53:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1720202002;
	bh=EVA4xGWQR4aMmDX4txfboMVq0fyWNrcCv8C687hvy6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vLPJ8OtssQOlAqvXDFLxhWrIipCNWzJ6q15HW0SkxoQATmx3f9vwxO6gOmyBI0HrA
	 4PSkXXW7A+42nK65h5f5pROfqbwAEkOnDtb09VPQhRvNKvA//vbxT1YWHTEfUB9nuq
	 NcVdFfFqOavW6dvw976SzC/jNfIeam4utTzxBdMA=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WG1MY3F4nzGZx;
	Fri,  5 Jul 2024 19:53:13 +0200 (CEST)
Date: Fri, 5 Jul 2024 19:53:10 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Kees Cook <kees@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Paul Moore <paul@paul-moore.com>, Theodore Ts'o <tytso@mit.edu>, 
	Alejandro Colomar <alx@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Biggers <ebiggers@kernel.org>, 
	Eric Chiang <ericchiang@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	James Morris <jamorris@linux.microsoft.com>, Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
	Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Luca Boccassi <bluca@debian.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Scott Shell <scottsh@microsoft.com>, 
	Shuah Khan <shuah@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, 
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, Vincent Strubel <vincent.strubel@ssi.gouv.fr>, 
	Xiaoming Ni <nixiaoming@huawei.com>, Yin Fengwei <fengwei.yin@intel.com>, 
	kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v19 1/5] exec: Add a new AT_CHECK flag to execveat(2)
Message-ID: <20240705.uch1saeNi6mo@digikod.net>
References: <20240704190137.696169-1-mic@digikod.net>
 <20240704190137.696169-2-mic@digikod.net>
 <202407041656.3A05153@keescook>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202407041656.3A05153@keescook>
X-Infomaniak-Routing: alpha

On Thu, Jul 04, 2024 at 05:04:03PM -0700, Kees Cook wrote:
> On Thu, Jul 04, 2024 at 09:01:33PM +0200, Mickaël Salaün wrote:
> > Add a new AT_CHECK flag to execveat(2) to check if a file would be
> > allowed for execution.  The main use case is for script interpreters and
> > dynamic linkers to check execution permission according to the kernel's
> > security policy. Another use case is to add context to access logs e.g.,
> > which script (instead of interpreter) accessed a file.  As any
> > executable code, scripts could also use this check [1].
> > 
> > This is different than faccessat(2) which only checks file access
> > rights, but not the full context e.g. mount point's noexec, stack limit,
> > and all potential LSM extra checks (e.g. argv, envp, credentials).
> > Since the use of AT_CHECK follows the exact kernel semantic as for a
> > real execution, user space gets the same error codes.
> 
> Nice! I much prefer this method of going through the exec machinery so
> we always have a single code path for these kinds of checks.
> 
> > Because AT_CHECK is dedicated to user space interpreters, it doesn't
> > make sense for the kernel to parse the checked files, look for
> > interpreters known to the kernel (e.g. ELF, shebang), and return ENOEXEC
> > if the format is unknown.  Because of that, security_bprm_check() is
> > never called when AT_CHECK is used.
> 
> I'd like some additional comments in the code that reminds us that
> access control checks have finished past a certain point.

Where in the code? Just before the bprm->is_check assignment?

> 
> [...]
> > diff --git a/fs/exec.c b/fs/exec.c
> > index 40073142288f..ea2a1867afdc 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -931,7 +931,7 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
> >  		.lookup_flags = LOOKUP_FOLLOW,
> >  	};
> >  
> > -	if ((flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
> > +	if ((flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH | AT_CHECK)) != 0)
> >  		return ERR_PTR(-EINVAL);
> >  	if (flags & AT_SYMLINK_NOFOLLOW)
> >  		open_exec_flags.lookup_flags &= ~LOOKUP_FOLLOW;
> [...]
> > + * To avoid race conditions leading to time-of-check to time-of-use issues,
> > + * AT_CHECK should be used with AT_EMPTY_PATH to check against a file
> > + * descriptor instead of a path.
> 
> I want this enforced by the kernel. Let's not leave trivial ToCToU
> foot-guns around. i.e.:
> 
> 	if ((flags & AT_CHECK) == AT_CHECK && (flags & AT_EMPTY_PATH) == 0)
>   		return ERR_PTR(-EBADF);

There are valid use cases relying on pathnames. See Linus's comment:
https://lore.kernel.org/r/CAHk-=whb=XuU=LGKnJWaa7LOYQz9VwHs8SLfgLbT5sf2VAbX1A@mail.gmail.com

