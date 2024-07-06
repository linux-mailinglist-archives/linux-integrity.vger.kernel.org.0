Return-Path: <linux-integrity+bounces-3029-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1434929208
	for <lists+linux-integrity@lfdr.de>; Sat,  6 Jul 2024 10:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DA78281FB5
	for <lists+linux-integrity@lfdr.de>; Sat,  6 Jul 2024 08:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508D342AB6;
	Sat,  6 Jul 2024 08:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOagrRxJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EBB41A80
	for <linux-integrity@vger.kernel.org>; Sat,  6 Jul 2024 08:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720255999; cv=none; b=MrPE7iUy5CA9Oypi6ZcIB5aYDKezJAiR7jegBcitbv+re3PhypeL6fMpy7W1dCkZue5/G67Tt6KhoTYtAO+Izqq6o1dlw7js8x9inw4F8JjfvMSYxAWn54M5wn/TCRJW3IRqVTUgjOM4aJ/Vmk1Q9bx/MGjjh8yUqhHKIuo/v7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720255999; c=relaxed/simple;
	bh=yGiFlwK+Xw/rrB/nlj2FnyAjmvDNJoEUvBd9S/bCJLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MdQGNAsdQH7P1y7Jy2Gv+UayDt2IRmQm0BaqGq7tU7RzG9GmZ1PeidpcPS2H2df2kpn+b/geP5WKxOvqEgXqYLbH39s6/1EY+vAgeyIf2HUlNIcyvx6GxvZIbgefCRiaU6GOxWX5HALViudJfHVyse4UrDozZ//DESUTSc7QvgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOagrRxJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B9CC4AF11
	for <linux-integrity@vger.kernel.org>; Sat,  6 Jul 2024 08:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720255999;
	bh=yGiFlwK+Xw/rrB/nlj2FnyAjmvDNJoEUvBd9S/bCJLI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eOagrRxJtG0LnDZ7TBefbgwFkGj4onb3oAS19euP3Q0eaAmLtHaLfuywMhaQJ+GiS
	 3TIaOMjl50DT04MhA6/Ct0JtjJ/bFvKUrgN/TXOWr6HQajpoE3Qrglb/QlIK90ufLl
	 k6Bl2wTfidGxSfDMtCjaCD7oNygE7RfWYlzOSSkoMN0LtT/xR2Wj0Vc2aiGKGa8l4x
	 sylq39anqfIvL6dac8Y0eP/TJBVDsgEsMoZnHiP9Zip95NnB4RU3UwEEm/49JYZyVy
	 JRFWs4U/AZ8Js4A+2JZHUrzFx/NsxIBVKWegKogYn/V8Yew3TZ9ALTv61bXXkbxKb/
	 39Xq1SdRfKclA==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-58b0dddab63so3571952a12.3
        for <linux-integrity@vger.kernel.org>; Sat, 06 Jul 2024 01:53:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWfKaO55wtPLkZRu+r6AU1g4mgQBaKSLsD+PpJn4LCRDrLBvAPiKJcNJ821VUWjetNP8QYTVUK85l+T9GE3EJqUnn0DlF9qNAXbg2RiACQ4
X-Gm-Message-State: AOJu0Yzv0HCZGiPEaJXadGAsRc6ePZhxDgrCRTxaULQ3pFDeadMxFGFq
	/mzx80jECk96nYyseNMHF8cXPNAYFvB6ls3YOKcUlhbS1hUcdDY2ihs0BE0oT9MlAXKbeF3op8C
	pJyX9PJj48mwnEzirjZ1lC/jjTsKEaP7BKFrQ
X-Google-Smtp-Source: AGHT+IG6qm2LEVFPDInWtM8uLwi7DUyNLBYYlcj/M9Ftz1Yp5Blf0TQ/9w9jf2A+wl/ieaHJzuQUlPFaKvDk+XKulEg=
X-Received: by 2002:a17:906:f1d0:b0:a77:deb2:8af8 with SMTP id
 a640c23a62f3a-a77deb2b909mr113538966b.77.1720255976572; Sat, 06 Jul 2024
 01:52:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704190137.696169-1-mic@digikod.net> <20240704190137.696169-2-mic@digikod.net>
In-Reply-To: <20240704190137.696169-2-mic@digikod.net>
From: Andy Lutomirski <luto@kernel.org>
Date: Sat, 6 Jul 2024 16:52:42 +0800
X-Gmail-Original-Message-ID: <CALCETrWYu=PYJSgyJ-vaa+3BGAry8Jo8xErZLiGR3U5h6+U0tA@mail.gmail.com>
Message-ID: <CALCETrWYu=PYJSgyJ-vaa+3BGAry8Jo8xErZLiGR3U5h6+U0tA@mail.gmail.com>
Subject: Re: [RFC PATCH v19 1/5] exec: Add a new AT_CHECK flag to execveat(2)
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Paul Moore <paul@paul-moore.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Alejandro Colomar <alx.manpages@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Casey Schaufler <casey@schaufler-ca.com>, 
	Christian Heimes <christian@python.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Eric Biggers <ebiggers@kernel.org>, Eric Chiang <ericchiang@google.com>, 
	Fan Wu <wufan@linux.microsoft.com>, Florian Weimer <fweimer@redhat.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, James Morris <jamorris@linux.microsoft.com>, 
	Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jordan R Abrahams <ajordanr@google.com>, 
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Luca Boccassi <bluca@debian.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, 
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
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 3:03=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
>
> Add a new AT_CHECK flag to execveat(2) to check if a file would be
> allowed for execution.  The main use case is for script interpreters and
> dynamic linkers to check execution permission according to the kernel's
> security policy. Another use case is to add context to access logs e.g.,
> which script (instead of interpreter) accessed a file.  As any
> executable code, scripts could also use this check [1].
>

Can you give a worked-out example of how this is useful?

I assume the idea is that a program could open a file, then pass the
fd to execveat() to get the kernel's idea of whether it's permissible
to execute it.  And then the program would interpret the file, which
is morally like executing it.  And there would be a big warning in the
manpage that passing a *path* is subject to a TOCTOU race.

This type of usage will do the wrong thing if LSM policy intends to
lock down the task if the task were to actually exec the file.  I
personally think this is a mis-design (let the program doing the
exec-ing lock itself down, possibly by querying a policy, but having
magic happen on exec seems likely to do the wrong thing more often
that it does the wright thing), but that ship sailed a long time ago.

So maybe what's actually needed is a rather different API: a way to
check *and perform* the security transition for an exec without
actually execing.  This would need to be done NO_NEW_PRIVS style for
reasons that are hopefully obvious, but it would permit:

fd =3D open(some script);
if (do_exec_transition_without_exec(fd) !=3D 0)
  return;  // don't actually do it

// OK, we may have just lost privileges.  But that's okay, because we
meant to do that.
// Make sure we've munmapped anything sensitive and erased any secrets
from memory,
// and then interpret the script!

I think this would actually be straightforward to implement in the
kernel -- one would need to make sure that all the relevant
no_new_privs checks are looking in the right place (as the task might
not actually have no_new_privs set, but LSM_UNSAFE_NO_NEW_PRIVS would
still be set), but I don't see any reason this would be
insurmountable, nor do I expect there would be any fundamental
problems.


> This is different than faccessat(2) which only checks file access
> rights, but not the full context e.g. mount point's noexec, stack limit,
> and all potential LSM extra checks (e.g. argv, envp, credentials).
> Since the use of AT_CHECK follows the exact kernel semantic as for a
> real execution, user space gets the same error codes.
>
> With the information that a script interpreter is about to interpret a
> script, an LSM security policy can adjust caller's access rights or log
> execution request as for native script execution (e.g. role transition).
> This is possible thanks to the call to security_bprm_creds_for_exec().
>
> Because LSMs may only change bprm's credentials, use of AT_CHECK with
> current kernel code should not be a security issue (e.g. unexpected role
> transition).  LSMs willing to update the caller's credential could now
> do so when bprm->is_check is set.  Of course, such policy change should
> be in line with the new user space code.
>
> Because AT_CHECK is dedicated to user space interpreters, it doesn't
> make sense for the kernel to parse the checked files, look for
> interpreters known to the kernel (e.g. ELF, shebang), and return ENOEXEC
> if the format is unknown.  Because of that, security_bprm_check() is
> never called when AT_CHECK is used.
>
> It should be noted that script interpreters cannot directly use
> execveat(2) (without this new AT_CHECK flag) because this could lead to
> unexpected behaviors e.g., `python script.sh` could lead to Bash being
> executed to interpret the script.  Unlike the kernel, script
> interpreters may just interpret the shebang as a simple comment, which
> should not change for backward compatibility reasons.
>
> Because scripts or libraries files might not currently have the
> executable permission set, or because we might want specific users to be
> allowed to run arbitrary scripts, the following patch provides a dynamic
> configuration mechanism with the SECBIT_SHOULD_EXEC_CHECK and
> SECBIT_SHOULD_EXEC_RESTRICT securebits.

Can you explain what those bits do?  And why they're useful?

>
> This is a redesign of the CLIP OS 4's O_MAYEXEC:
> https://github.com/clipos-archive/src_platform_clip-patches/blob/f5cb330d=
6b684752e403b4e41b39f7004d88e561/1901_open_mayexec.patch
> This patch has been used for more than a decade with customized script
> interpreters.  Some examples can be found here:
> https://github.com/clipos-archive/clipos4_portage-overlay/search?q=3DO_MA=
YEXEC

This one at least returns an fd, so it looks less likely to get
misused in a way that adds a TOCTOU race.

