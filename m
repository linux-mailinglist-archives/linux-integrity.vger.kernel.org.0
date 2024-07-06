Return-Path: <linux-integrity+bounces-3030-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FAD92943E
	for <lists+linux-integrity@lfdr.de>; Sat,  6 Jul 2024 16:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01CB91C20E09
	for <lists+linux-integrity@lfdr.de>; Sat,  6 Jul 2024 14:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F6A13AA2F;
	Sat,  6 Jul 2024 14:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="QN2P3eSF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB8C7CF33
	for <linux-integrity@vger.kernel.org>; Sat,  6 Jul 2024 14:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720277773; cv=none; b=Igc/acxDay0RyMno//k6TqW1+oQwz7vK76QQMrkoxE1608Uw94xA57+VdNWWolT6KWoczz0l0aXTTu3GoEJHQgWhhw1PBvl72u6bm1H0ex/Sd4vGU1F0hZsX0UDXOBQguAI6joEaa4Gd7goJqPfbvMQr7Azl4Mgo70oD0ffGPm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720277773; c=relaxed/simple;
	bh=xubLJoupr6a+LYfRAWqyUHezcWyAzUdQWTgVMGMPIGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5hrZ5kMaYJvg4JiOUVxDmAy7lPqcbkCO6kp3ILr752rDMrIQhe6uNJt2aK0fLbt+k3RFVLSOb7pJRUBVDWgKkd/+jYbSfTAMs0utavEtWAS8g4TWsKcGdiQqRoiv66xC30OZU8NYJfizG7iAmCbYuAJSNLHRtMRo0AHBCTyIaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=QN2P3eSF; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WGYNj27fKzJ1r;
	Sat,  6 Jul 2024 16:56:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1720277765;
	bh=7uWel5mzu899dpbLYtvnqYOBClMoL9Rnhzi5iAwDfJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QN2P3eSF26sxX6l10plfQdh/LRI9/mntYv1qM+y05JO01Svn8fGnnZErGxSw1jYJS
	 u1K5IsaBLeNDRTrWQZgcHBJ58aMz+fl7eUe7XAy8wMlEo1Ja25QhZxFi/f8/SPLfII
	 aZnbhuwhUvYGOuJ7PoYSH766Ssxj6PxeBeuNajRc=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WGYNY53zczLym;
	Sat,  6 Jul 2024 16:55:57 +0200 (CEST)
Date: Sat, 6 Jul 2024 16:55:51 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Florian Weimer <fweimer@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Paul Moore <paul@paul-moore.com>, Theodore Ts'o <tytso@mit.edu>, 
	Alejandro Colomar <alx@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Biggers <ebiggers@kernel.org>, 
	Eric Chiang <ericchiang@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, James Morris <jamorris@linux.microsoft.com>, 
	Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jordan R Abrahams <ajordanr@google.com>, 
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Luca Boccassi <bluca@debian.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Matthew Garrett <mjg59@srcf.ucam.org>, 
	Matthew Wilcox <willy@infradead.org>, Miklos Szeredi <mszeredi@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, 
	Scott Shell <scottsh@microsoft.com>, Shuah Khan <shuah@kernel.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Steve Dower <steve.dower@python.org>, 
	Steve Grubb <sgrubb@redhat.com>, Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, 
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>, Xiaoming Ni <nixiaoming@huawei.com>, 
	Yin Fengwei <fengwei.yin@intel.com>, kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v19 1/5] exec: Add a new AT_CHECK flag to execveat(2)
Message-ID: <20240706.poo9ahd3La9b@digikod.net>
References: <20240704190137.696169-1-mic@digikod.net>
 <20240704190137.696169-2-mic@digikod.net>
 <87bk3bvhr1.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bk3bvhr1.fsf@oldenburg.str.redhat.com>
X-Infomaniak-Routing: alpha

On Fri, Jul 05, 2024 at 08:03:14PM +0200, Florian Weimer wrote:
> * Mickaël Salaün:
> 
> > Add a new AT_CHECK flag to execveat(2) to check if a file would be
> > allowed for execution.  The main use case is for script interpreters and
> > dynamic linkers to check execution permission according to the kernel's
> > security policy. Another use case is to add context to access logs e.g.,
> > which script (instead of interpreter) accessed a file.  As any
> > executable code, scripts could also use this check [1].
> 
> Some distributions no longer set executable bits on most shared objects,
> which I assume would interfere with AT_CHECK probing for shared objects.

A file without the execute permission is not considered as executable by
the kernel.  The AT_CHECK flag doesn't change this semantic.  Please
note that this is just a check, not a restriction.  See the next patch
for the optional policy enforcement.

Anyway, we need to define the policy, and for Linux this is done with
the file permission bits.  So for systems willing to have a consistent
execution policy, we need to rely on the same bits.

> Removing the executable bit is attractive because of a combination of
> two bugs: a binutils wart which until recently always set the entry
> point address in the ELF header to zero, and the kernel not checking for
> a zero entry point (maybe in combination with an absent program
> interpreter) and failing the execve with ELIBEXEC, instead of doing the
> execve and then faulting at virtual address zero.  Removing the
> executable bit is currently the only way to avoid these confusing
> crashes, so I understand the temptation.

Interesting.  Can you please point to the bug report and the fix?  I
don't see any ELIBEXEC in the kernel.

FYI, AT_CHECK doesn't check the content of the file (unlike a full
execve call).

Anyway, I think we should not design a new kernel interface to work
around a current user space bug.

