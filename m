Return-Path: <linux-integrity+bounces-3059-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2386792B38D
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Jul 2024 11:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CA7D280EE8
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Jul 2024 09:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B57155300;
	Tue,  9 Jul 2024 09:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ZTiHpEnf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BD4154C17
	for <linux-integrity@vger.kernel.org>; Tue,  9 Jul 2024 09:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720516707; cv=none; b=UKlW6nYtFTSKefjZCaGprD3zgxuhkVsNkTyR3NyTSJJX0pcEdfBOnVE0q8UuYrNtMA0MybgDljVZxQTsPwf72C0uIXM5/ZapDRIAwqx+w6GQt9QziTvztLkYGARcJfyymyt1FNPqXL6NQeJpYt/sJBonaB+UhLLBhYGsgfs3s68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720516707; c=relaxed/simple;
	bh=eVK1yU/K1gUCeypMeHvP2ycH4mth7QtdS8bCm7eN+/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCcfvIUHJScrmwYyFZ45vgAbpA0Ll13k2ZPU1o37KpVdL0Zo43FKscX9nx9w0ttmYMzO0YMsFTgbfLs632puIUrd8KA0eBReycU98tOylqdsgCAWJDQ+TkmzgyfDV3rfdN+6Zm/7kLFWQGzm++nwk3NLODzN5ZS+XLfuoChj/fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ZTiHpEnf; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WJFlW6pv4z5T6;
	Tue,  9 Jul 2024 11:18:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1720516695;
	bh=v/JFEHCX3gZ0MVpHje3ikJ9/D0FTAcZwjQbECtZLdZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZTiHpEnfNR3mlatCxWux7y7Eu0qGDnEqSh+8W8s09JC/3VLLlbrWZwmN1jeWX5Vho
	 ndmFxLkDKg4N0dPsk7JixdJH7Olf3q4BBy/rLZ/oO3L8jaUA2xpIdzwOIgKnGlTAP3
	 N7+HAeqyif99g6G9CBVvsU6dg8SkNZKc9yNMrgvw=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WJFlH1ZZFzVjC;
	Tue,  9 Jul 2024 11:18:03 +0200 (CEST)
Date: Tue, 9 Jul 2024 11:18:00 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jeff Xu <jeffxu@google.com>
Cc: Florian Weimer <fweimer@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Paul Moore <paul@paul-moore.com>, Theodore Ts'o <tytso@mit.edu>, 
	Alejandro Colomar <alx@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Biggers <ebiggers@kernel.org>, 
	Eric Chiang <ericchiang@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, James Morris <jamorris@linux.microsoft.com>, 
	Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
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
Message-ID: <20240709.gae4cu4Aiv6s@digikod.net>
References: <20240704190137.696169-1-mic@digikod.net>
 <20240704190137.696169-2-mic@digikod.net>
 <87bk3bvhr1.fsf@oldenburg.str.redhat.com>
 <CALmYWFu_JFyuwYhDtEDWxEob8JHFSoyx_SCcsRVKqSYyyw30Rg@mail.gmail.com>
 <87ed83etpk.fsf@oldenburg.str.redhat.com>
 <CALmYWFvkUnevm=npBeaZVkK_PXm=A8MjgxFXkASnERxoMyhYBg@mail.gmail.com>
 <87r0c3dc1c.fsf@oldenburg.str.redhat.com>
 <CALmYWFvA7VPz06Tg8E-R_Jqn2cxMiWPPC6Vhy+vgqnofT0GELg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALmYWFvA7VPz06Tg8E-R_Jqn2cxMiWPPC6Vhy+vgqnofT0GELg@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Mon, Jul 08, 2024 at 10:52:36AM -0700, Jeff Xu wrote:
> On Mon, Jul 8, 2024 at 10:33 AM Florian Weimer <fweimer@redhat.com> wrote:
> >
> > * Jeff Xu:
> >
> > > On Mon, Jul 8, 2024 at 9:26 AM Florian Weimer <fweimer@redhat.com> wrote:
> > >>
> > >> * Jeff Xu:
> > >>
> > >> > Will dynamic linkers use the execveat(AT_CHECK) to check shared
> > >> > libraries too ?  or just the main executable itself.
> > >>
> > >> I expect that dynamic linkers will have to do this for everything they
> > >> map.
> > > Then all the objects (.so, .sh, etc.) will go through  the check from
> > > execveat's main  to security_bprm_creds_for_exec(), some of them might
> > > be specific for the main executable ?

Yes, we should check every executable code (including seccomp filters)
to get a consistent policy.

What do you mean by "specific for the main executable"?

> >
> > If we want to avoid that, we could have an agreed-upon error code which
> > the LSM can signal that it'll never fail AT_CHECK checks, so we only
> > have to perform the extra system call once.

I'm not sure to follow.  Either we check executable code or we don't,
but it doesn't make sense to only check some parts (except for migration
of user space code in a system, which is one purpose of the securebits
added with the next patch).

The idea with AT_CHECK is to unconditionnaly check executable right the
same way it is checked when a file is executed.  User space can decide
to check that or not according to its policy (i.e. securebits).

> >
> Right, something like that.
> I would prefer not having AT_CHECK specific code in LSM code as an
> initial goal, if that works, great.

LSMs should not need to change anything, but they are free to implement
new access right according to AT_CHECK.

> 
> -Jeff
> 
> > Thanks,
> > Florian
> >

