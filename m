Return-Path: <linux-integrity+bounces-4290-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F369E4CBB
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Dec 2024 04:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7D61280D43
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Dec 2024 03:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787011917FB;
	Thu,  5 Dec 2024 03:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LV2+lPjt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9F418E057
	for <linux-integrity@vger.kernel.org>; Thu,  5 Dec 2024 03:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733369629; cv=none; b=lsRcyyb3IH0bKZMuvAYXonOWNjq00H+8sqeXrA98xc+vFBiyV1JBPmLhaneIrfD2kqfvdm+OBvHlrfXuo5Uj81n4lhvd0cPQw1CpohfG2G+/93bKTNrDU/rqHzk/earXrl+S87olhOPNeSMDqS5MNLpCWgbzTIr2ooJWE938wxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733369629; c=relaxed/simple;
	bh=2YpfMKIZHCtC1yAwRNTrkyONKJmfX3P1Dgzh962vtHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFoZxqkWOwFxrq077GTYvj/S7AJHl2Xsu1A+S0PHoOrRN4wgCbnKxCsCGU+rQT0uier/IM/O6c/bW20s44w0kPJXJb3GU3KG6E5aVPg1xhAIkG14afEwEQy22PdjJdnak4DcfYEsutUpZHXwCrn0hrk8sKxxpSVbbZKkTxfTUvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LV2+lPjt; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e3978c00a5aso629566276.1
        for <linux-integrity@vger.kernel.org>; Wed, 04 Dec 2024 19:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733369625; x=1733974425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqqlC+ZUU04wDK2N54+0ftqA1cSI7m49jZLokKLp/0E=;
        b=LV2+lPjt4zqa+p3asLanKzH/KAN9YuOD1oGdsCw6FQtNOeq7PFsPJO8I8X4zIcUDmd
         T7VgI8gcSdFEDjzhHMWVR7vTaE3AUoKXxCkZyU2kUOgvKf7PCEhLfXL4eTFtoK0vWiQK
         L+2FhhgTocjiE17U4gEUoXEpKsSor8m7J4iMyxSJxWKvcDXhZbD2mqCO4NO0A2cluNh1
         FiG+ZH3PhYBA4UqYfQY6KA8RRUA5pW5MwMcncmhKWhzV4YcCUDef3uqhJV2JELjCbLht
         wlX1SRH8ORLTADfiIfQXcu6waSGFjC64jTXCxCh+VM02shbKnMtxlWLmPbbxnM6U3w6r
         5oVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733369625; x=1733974425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RqqlC+ZUU04wDK2N54+0ftqA1cSI7m49jZLokKLp/0E=;
        b=pn/0CnfoHXlkYSe9jlyU/MPlXKWu7zZ4+IXAvrGkGxMuDLjLsfqYJiB5xa+zvTzUwP
         4euqYKUF2hJ5yI3XopEw4OMP0/QqSqQ7LNThyNc7fKcpWKZhP9eegTuw+W13V3Stnty6
         K31Yvb6YQm3sp38V0P/97Da59cP5gsZDaP6M2A5RFb983o3+x9mc3+1VD2yWza0gbjec
         nim++icdgjDC1O3+qWfwijTDIPALWGM6sfUaF0F7aHWvaQ2DUQkJMk0z/Amuo0Egwhy1
         EDAU9i/E2u0Js2KdTrP6XpodLZ3OQb8NkMiRjk/SiG06ZAG6WuRRnRVP9XlVUspRx1FB
         QL5A==
X-Forwarded-Encrypted: i=1; AJvYcCWAtMrxmGoa71PNPHDMLu/+FM7avFBMEH3rgE7YWlFeEPKBjK6tpjxXB7G9mG/na9eJXFOlZ6UNX8x9gZpkdNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDoBpse2yBSPEANeCNBLJYA8ZFU+XMih3CrGQwuhHbWnKp3Wre
	4esjQ9Hv59nMwQ8gpS+JT/AuEjicQfD5AVTItkMOn0+Rjw1ZScxeksM/5I716+r1qycla7JSeYo
	YmSejV7XB9B2+O4afTAwc8n0enexsYrYXnbDE
X-Gm-Gg: ASbGnctMppb70nPa9f8ygRYl1XkVp+1LQwCPxa428Zptl/9PL7QXyMTIhNvshjR/e8G
	UdYSGnCwvgMN/ow+L+uV+lpUU0ZlCtA==
X-Google-Smtp-Source: AGHT+IFIW0nv4nMp+xB3hRxH7jiqJFLJ+/vbSzLjYlJYf27dkS9U79OHIOtdDmrXE95yoa1diQrswqexP0FD2HzbsL0=
X-Received: by 2002:a05:6902:10c1:b0:e2b:dbf6:34ca with SMTP id
 3f1490d57ef6-e39d43740bdmr7490115276.36.1733369625457; Wed, 04 Dec 2024
 19:33:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112191858.162021-1-mic@digikod.net> <20241112191858.162021-2-mic@digikod.net>
 <CABi2SkVRJC_7qoU56mDt3Ch7U9GnVeRogUt9wc9=32OtG6aatw@mail.gmail.com>
 <20241120.Uy8ahtai5oku@digikod.net> <CABi2SkUx=7zummB4JCqEfb37p6MORR88y7S0E_YxJND_8dGaKA@mail.gmail.com>
 <20241121.uquee7ohRohn@digikod.net>
In-Reply-To: <20241121.uquee7ohRohn@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 4 Dec 2024 22:33:34 -0500
Message-ID: <CAHC9VhT9sRXauYX+=21MUdOmfTZL4=sdGQsXojJjjTsdui+F_g@mail.gmail.com>
Subject: Re: [PATCH v21 1/6] exec: Add a new AT_EXECVE_CHECK flag to execveat(2)
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Jeff Xu <jeffxu@chromium.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Serge Hallyn <serge@hallyn.com>, Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, 
	Alejandro Colomar <alx@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Casey Schaufler <casey@schaufler-ca.com>, 
	Christian Heimes <christian@python.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Elliott Hughes <enh@google.com>, Eric Biggers <ebiggers@kernel.org>, 
	Eric Chiang <ericchiang@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	James Morris <jamorris@linux.microsoft.com>, Jan Kara <jack@suse.cz>, 
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Luca Boccassi <bluca@debian.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Scott Shell <scottsh@microsoft.com>, 
	Shuah Khan <shuah@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, 
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>, Xiaoming Ni <nixiaoming@huawei.com>, 
	Yin Fengwei <fengwei.yin@intel.com>, kernel-hardening@lists.openwall.com, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Eric Paris <eparis@redhat.com>, 
	audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 8:40=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> On Wed, Nov 20, 2024 at 08:06:07AM -0800, Jeff Xu wrote:
> > On Wed, Nov 20, 2024 at 1:42=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > > On Tue, Nov 19, 2024 at 05:17:00PM -0800, Jeff Xu wrote:
> > > > On Tue, Nov 12, 2024 at 11:22=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <=
mic@digikod.net> wrote:

...

> > > > > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > > > > index cd57053b4a69..8d9ba5600cf2 100644
> > > > > --- a/kernel/auditsc.c
> > > > > +++ b/kernel/auditsc.c
> > > > > @@ -2662,6 +2662,7 @@ void __audit_bprm(struct linux_binprm *bprm=
)
> > > > >
> > > > >         context->type =3D AUDIT_EXECVE;
> > > > >         context->execve.argc =3D bprm->argc;
> > > > > +       context->execve.is_check =3D bprm->is_check;
> > > >
> > > > Where is execve.is_check used ?
> > >
> > > It is used in bprm_execve(), exposed to the audit framework, and
> > > potentially used by LSMs.
> > >
> > bprm_execve() uses bprm->is_check, not  the context->execve.is_check.
>
> Correct, this is only for audit but not used yet.
>
> Paul, Eric, do you want me to remove this field, leave it, or extend
> this patch like this?
>
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 8d9ba5600cf2..12cf89fa224a 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1290,6 +1290,8 @@ static void audit_log_execve_info(struct audit_cont=
ext *context,
>                 }
>         } while (arg < context->execve.argc);
>
> +       audit_log_format(*ab, " check=3D%d", context->execve.is_check);
> +
>         /* NOTE: the caller handles the final audit_log_end() call */
>
>  out:

I would prefer to drop the audit changes rather than add a new field
to the audit record at this point in time.  Once we have a better
understanding of how things are actually being deployed by distros,
providers, and admins we can make a more reasoned decision on what we
should audit with respect to AT_EXECVE_CHECK.

Beyond that it looks okay to me from a LSM and audit perspective, so
feel free to add my ACK once you've dropped the audit bits.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

