Return-Path: <linux-integrity+bounces-3307-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBD694D470
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Aug 2024 18:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEE49B25372
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Aug 2024 16:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922E3199EA4;
	Fri,  9 Aug 2024 16:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YJZcBUS5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735081991D4
	for <linux-integrity@vger.kernel.org>; Fri,  9 Aug 2024 16:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723220193; cv=none; b=Q/c6VNfIKkLVnnvIAtOtY9Hnx4KUiIFCPW8IMiXiCqLm8KMkxvCz8CYhBrfy3NXk2tBj3UYarZB8jdPEub2ig0wq3TUCv/6TUR+HQQSHScwMNSt+ncdgWIQ6T+XUePedXOEBdbILrw+UvZEYVl3Sf5XCNkiMbaCTjEFpAKm0wXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723220193; c=relaxed/simple;
	bh=vtsj5wvSoVll1YUf1x6rxnBfwekwZDkX1NKUQ+hmB/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O+11ahwv6U/mYNZcp09aLgHjtWAemYc23EqDXP+euW+G4SduS/5yjdMAAORUTv3u2Nr7f7tRVdHJu7IiTvK+vF4O7Cji8wtzVkTJzNuRgGP/WKvVIkl8+ukcgJ69f9cDjGk8V/PpEYEZB903bA4fFNula0lHWA9Upoh2lDUvsy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YJZcBUS5; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso14275a12.0
        for <linux-integrity@vger.kernel.org>; Fri, 09 Aug 2024 09:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723220189; x=1723824989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZYpvg30KBqeml0aLfdzOyX6A2jzs5hukakJb6/9ItY=;
        b=YJZcBUS5oJ58JufdRA6QfpXlO1cBY51Uf/arsSUYI2jgWkzlmTYD/TJ/W46o5/5i57
         MC2PMvlGxWttMVSfNmuFpAZ33PR40ZMFOFUh4tJTYSYkw4bHH6ze8IPUtdNeYyoIn/6q
         FsD0ckR0gLBsoB0UEfENMyqwZ65EOTYybgs/nBNxSKEBe3YplJYD7oe2Io9Ml6axQ7N1
         92pFGy6MeglYnusIntslP0zvMstIz60580+tq+Er6fp6SWgGsTtWcI3yoMeYROxITXKC
         FO6L4vOu4EOhFH6EBhbc4edvlVWvfaHLoXJaa1CBdaDbWViKrvX6cmDsA5H4eggBT2I6
         oFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723220189; x=1723824989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZYpvg30KBqeml0aLfdzOyX6A2jzs5hukakJb6/9ItY=;
        b=TnSwICGlb5E11dJx7oxgU1BMYWobtlEW1rREt9+4rOcQJo/DbZuj4cydO/99Fr9Xgm
         Kur4+4JRu0IlxQLFUtC7LL0ep6Bu+1MxOkBbQ1muQS2n5vSTBn67FibczO0jU6WCS94g
         wSo9CTvwihxO+0T8MATqSnxJd/rd0Ife0PaixprQZ/RgjDuki/3M2th2Z1CKGmNJfYhd
         +cP+yY6bkciQPDYiTT7rtcveTA3BSCMnF7OnTiQty/6uaP5p/whh8UzuTcM28L5rVBuC
         lGyIVHFVb7QHwtxzC3r53OoL8z9QdCuOloYSGl+VfBQPzhpAS5YShpzCFzMrmI7jIbqO
         /Trw==
X-Forwarded-Encrypted: i=1; AJvYcCUk8dZXNXttoQFGU2oK15J2f4BaJcONSap2NGpsDKEPfGbo26azOROCBKbCk8kiHTbTqTlX9cnM6oVyrmUKWuWz5q9fPpAFp28BBZyMq0q7
X-Gm-Message-State: AOJu0YxW0JfnN00DtbgUTTiFKknJjBOW9LhGRbkSLEX8w7qul2vnxfdI
	cQVIIdnW0o5oJ1cLvsrXQ9IeCnQP288AW9KeDL1G9QEPJ3cQWMjoaC/haWKg92jY0c3sJ8UxqaY
	P3GWWi/5FWyjYdbZi1q2OvnztlqNxnltszMVI
X-Google-Smtp-Source: AGHT+IGLV2f7xz3HiASPgoXucNkkjSY0HlUpcr+1pRB8vDlxtZCp/4YEgM5Ck/9IgOs88u6eub6Gmvxv+P8wO7+gNTA=
X-Received: by 2002:a05:6402:40cc:b0:5a7:7f0f:b70b with SMTP id
 4fb4d7f45d1cf-5bbbc38adbemr223144a12.0.1723220188246; Fri, 09 Aug 2024
 09:16:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717.neaB5Aiy2zah@digikod.net> <CALmYWFt=yXpzhS=HS9FjwVMvx6U1MoR31vK79wxNLhmJm9bBoA@mail.gmail.com>
 <20240718.kaePhei9Ahm9@digikod.net> <CALmYWFto4sw-Q2+J0Gc54POhnM9C8YpnJ44wMz=fd_K3_+dWmw@mail.gmail.com>
 <20240719.shaeK6PaiSie@digikod.net> <CALmYWFsd-=pOPZZmiKvYJ8pOhACsTvW_d+pRjG_C4jD6+Li0AQ@mail.gmail.com>
 <20240719.sah7oeY9pha4@digikod.net> <CALmYWFsAZjU5sMcXTT23Mtw2Y30ewc94FAjKsnuSv1Ex=7fgLQ@mail.gmail.com>
 <20240723.beiTu0qui2ei@digikod.net> <CALmYWFtHQY41PbRwGxge1Wo=8D4ocZfQgRUO47-PF1eJCEr0Sw@mail.gmail.com>
 <20240809.Taiyah0ii7ph@digikod.net>
In-Reply-To: <20240809.Taiyah0ii7ph@digikod.net>
From: Jeff Xu <jeffxu@google.com>
Date: Fri, 9 Aug 2024 09:15:49 -0700
Message-ID: <CALmYWFvPxWyYdGvCcTPYrUtC0DVMGcmM+JsAe0KGE+3p2Jb=Ug@mail.gmail.com>
Subject: Re: [RFC PATCH v19 1/5] exec: Add a new AT_CHECK flag to execveat(2)
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Paul Moore <paul@paul-moore.com>, "Theodore Ts'o" <tytso@mit.edu>, Alejandro Colomar <alx@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Biggers <ebiggers@kernel.org>, 
	Eric Chiang <ericchiang@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	James Morris <jamorris@linux.microsoft.com>, Jan Kara <jack@suse.cz>, 
	Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Luca Boccassi <bluca@debian.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Scott Shell <scottsh@microsoft.com>, 
	Shuah Khan <shuah@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, 
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, 
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>, Xiaoming Ni <nixiaoming@huawei.com>, 
	Yin Fengwei <fengwei.yin@intel.com>, kernel-hardening@lists.openwall.com, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Elliott Hughes <enh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 1:45=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
>
> On Mon, Aug 05, 2024 at 11:35:09AM -0700, Jeff Xu wrote:
> > On Tue, Jul 23, 2024 at 6:15=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > >
> > > On Fri, Jul 19, 2024 at 08:27:18AM -0700, Jeff Xu wrote:
> > > > On Fri, Jul 19, 2024 at 8:04=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <m=
ic@digikod.net> wrote:
> > > > >
> > > > > On Fri, Jul 19, 2024 at 07:16:55AM -0700, Jeff Xu wrote:
> > > > > > On Fri, Jul 19, 2024 at 1:45=E2=80=AFAM Micka=C3=ABl Sala=C3=BC=
n <mic@digikod.net> wrote:
> > > > > > >
> > > > > > > On Thu, Jul 18, 2024 at 06:29:54PM -0700, Jeff Xu wrote:
> > > > > > > > On Thu, Jul 18, 2024 at 5:24=E2=80=AFAM Micka=C3=ABl Sala=
=C3=BCn <mic@digikod.net> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Jul 17, 2024 at 07:08:17PM -0700, Jeff Xu wrote:
> > > > > > > > > > On Wed, Jul 17, 2024 at 3:01=E2=80=AFAM Micka=C3=ABl Sa=
la=C3=BCn <mic@digikod.net> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Tue, Jul 16, 2024 at 11:33:55PM -0700, Jeff Xu wro=
te:
> > > > > > > > > > > > On Thu, Jul 4, 2024 at 12:02=E2=80=AFPM Micka=C3=AB=
l Sala=C3=BCn <mic@digikod.net> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > Add a new AT_CHECK flag to execveat(2) to check i=
f a file would be
> > > > > > > > > > > > > allowed for execution.  The main use case is for =
script interpreters and
> > > > > > > > > > > > > dynamic linkers to check execution permission acc=
ording to the kernel's
> > > > > > > > > > > > > security policy. Another use case is to add conte=
xt to access logs e.g.,
> > > > > > > > > > > > > which script (instead of interpreter) accessed a =
file.  As any
> > > > > > > > > > > > > executable code, scripts could also use this chec=
k [1].
> > > > > > > > > > > > >
> > > > > > > > > > > > > This is different than faccessat(2) which only ch=
ecks file access
> > > > > > > > > > > > > rights, but not the full context e.g. mount point=
's noexec, stack limit,
> > > > > > > > > > > > > and all potential LSM extra checks (e.g. argv, en=
vp, credentials).
> > > > > > > > > > > > > Since the use of AT_CHECK follows the exact kerne=
l semantic as for a
> > > > > > > > > > > > > real execution, user space gets the same error co=
des.
> > > > > > > > > > > > >
> > > > > > > > > > > > So we concluded that execveat(AT_CHECK) will be use=
d to check the
> > > > > > > > > > > > exec, shared object, script and config file (such a=
s seccomp config),
> > > > > > >
> > > > > > > > > > > > I think binfmt_elf.c in the kernel needs to check t=
he ld.so to make
> > > > > > > > > > > > sure it passes AT_CHECK, before loading it into mem=
ory.
> > > > > > > > > > >
> > > > > > > > > > > All ELF dependencies are opened and checked with open=
_exec(), which
> > > > > > > > > > > perform the main executability checks (with the __FMO=
DE_EXEC flag).
> > > > > > > > > > > Did I miss something?
> > > > > > > > > > >
> > > > > > > > > > I mean the ld-linux-x86-64.so.2 which is loaded by binf=
mt in the kernel.
> > > > > > > > > > The app can choose its own dynamic linker path during b=
uild, (maybe
> > > > > > > > > > even statically link one ?)  This is another reason tha=
t relying on a
> > > > > > > > > > userspace only is not enough.
> > > > > > > > >
> > > > > > > > > The kernel calls open_exec() on all dependencies, includi=
ng
> > > > > > > > > ld-linux-x86-64.so.2, so these files are checked for exec=
utability too.
> > > > > > > > >
> > > > > > > > This might not be entirely true. iiuc, kernel  calls open_e=
xec for
> > > > > > > > open_exec for interpreter, but not all its dependency (e.g.=
 libc.so.6)
> > > > > > >
> > > > > > > Correct, the dynamic linker is in charge of that, which is wh=
y it must
> > > > > > > be enlighten with execveat+AT_CHECK and securebits checks.
> > > > > > >
> > > > > > > > load_elf_binary() {
> > > > > > > >    interpreter =3D open_exec(elf_interpreter);
> > > > > > > > }
> > > > > > > >
> > > > > > > > libc.so.6 is opened and mapped by dynamic linker.
> > > > > > > > so the call sequence is:
> > > > > > > >  execve(a.out)
> > > > > > > >   - open exec(a.out)
> > > > > > > >   - security_bprm_creds(a.out)
> > > > > > > >   - open the exec(ld.so)
> > > > > > > >   - call open_exec() for interruptor (ld.so)
> > > > > > > >   - call execveat(AT_CHECK, ld.so) <-- do we want ld.so goi=
ng through
> > > > > > > > the same check and code path as libc.so below ?
> > > > > > >
> > > > > > > open_exec() checks are enough.  LSMs can use this information=
 (open +
> > > > > > > __FMODE_EXEC) if needed.  execveat+AT_CHECK is only a user sp=
ace
> > > > > > > request.
> > > > > > >
> > > > > > Then the ld.so doesn't go through the same security_bprm_creds(=
) check
> > > > > > as other .so.
> > > > >
> > > > > Indeed, but...
> > > > >
> > > > My point is: we will want all the .so going through the same code
> > > > path, so  security_ functions are called consistently across all th=
e
> > > > objects, And in the future, if we want to develop additional LSM
> > > > functionality based on AT_CHECK, it will be applied to all objects.
> > >
> > > I'll extend the doc to encourage LSMs to check for __FMODE_EXEC, whic=
h
> > > already is the common security check for all executable dependencies.
> > > As extra information, they can get explicit requests by looking at
> > > execveat+AT_CHECK call.
> > >
> > I agree that security_file_open + __FMODE_EXEC for checking all
> > the .so (e.g for executable memfd) is a better option  than checking at
> > security_bprm_creds_for_exec.
> >
> > But then maybe execveat( AT_CHECK) can return after  calling alloc_bprm=
 ?
> > See below call graph:
> >
> > do_execveat_common (AT_CHECK)
> > -> alloc_bprm
> > ->->do_open_execat
> > ->->-> do_filp_open (__FMODE_EXEC)
> > ->->->->->->> security_file_open
> > -> bprm_execve
> > ->-> prepare_exec_creds
> > ->->-> prepare_creds
> > ->->->-> security_prepare_creds
> > ->-> security_bprm_creds_for_exec
> >
> > What is the consideration to mark the end at
> > security_bprm_creds_for_exec ? i.e. including brpm_execve,
> > prepare_creds, security_prepare_creds, security_bprm_creds_for_exec.
>
> This enables LSMs to know/log an explicit execution request, including
> context with argv and envp.
>
> >
> > Since dynamic linker doesn't load ld.so (it is by kernel),  ld.so
> > won't go through those  security_prepare_creds and
> > security_bprm_creds_for_exec checks like other .so do.
>
> Yes, but this is not an issue nor an explicit request. ld.so is only one
> case of this patch series.
>
> >
> > > >
> > > > Another thing to consider is:  we are asking userspace to make
> > > > additional syscall before  loading the file into memory/get execute=
d,
> > > > there is a possibility for future expansion of the mechanism, witho=
ut
> > > > asking user space to add another syscall again.
> > >
> > > AT_CHECK is defined with a specific semantic.  Other mechanisms (e.g.
> > > LSM policies) could enforce other restrictions following the same
> > > semantic.  We need to keep in mind backward compatibility.
> > >
> > > >
> > > > I m still not convinced yet that execveat(AT_CHECK) fits more than
> > > > faccessat(AT_CHECK)
> > >
> > > faccessat2(2) is dedicated to file permission/attribute check.
> > > execveat(2) is dedicated to execution, which is a superset of file
> > > permission for executability, plus other checks (e.g. noexec).
> > >
> > That sounds reasonable, but if execveat(AT_CHECK) changes behavior of
> > execveat(),  someone might argue that faccessat2(EXEC_CHECK) can be
> > made for the executability.
>
> AT_CHECK, as any other syscall flags, changes the behavior of execveat,
> but the overall semantic is clearly defined.
>
> Again, faccessat2 is only dedicated to file attributes/permissions, not
> file executability.
>
> >
> > I think the decision might depend on what this PATCH intended to
> > check, i.e. where we draw the line.
>
> The goal is clearly defined in the cover letter and patches: makes it
> possible to control (or log) script execution.
>
> >
> > do_open_execat() seems to cover lots of checks for executability, if
> > we are ok with the thing that do_open_execat() checks, then
> > faccessat(AT_CHECK) calling do_open_execat() is an option, it  won't
> > have those "unrelated" calls  in execve path, e.g.  bprm_stack_limits,
> > copy argc/env .
>
> I don't thing there is any unrelated calls in execve path, quite the
> contrary, it follows the same semantic as for a full execution, and
> that's another argument to use the execveat interface.  Otherwise, we
> couldn't argue that `./script.sh` can be the same as `sh script.sh`
>
It is a good point from the  "scrip.sh/exec" perspective that we want
it to go through the same execve path.
The reasoning is not obvious from the ".so" which doesn't go through
stack/env check.
Since execveat(AT_CHECK) wants to cover both cases, it is fine.

> The only difference is that user space is in charge of parsing and
> interpreting the file's content.
>
> >
> > However, you mentioned superset of file permission for executability,
> > can you elaborate on that ? Is there something not included in
> > do_open_execat() but still necessary for execveat(AT_CHECK)? maybe
> > security_bprm_creds_for_exec? (this goes back to my  question above)
>
> As explained above, the goal is to have the same semantic as a full
> execveat call, taking into account all the checks (e.g. stack limit,
> argv/envp...).
>
I'm fine with this, thanks for taking time to explain the design.

Regarding the future LSM based on this patch series:
For .so,  security_file_open is recommended for LSM.
For scripts/exec (that needs a full exec code path),
security_file_open and security_bprm_creds_for_exec can both be used.

Thanks
Best regards,
-Jeff

