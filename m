Return-Path: <linux-integrity+bounces-4169-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D13B9D31E9
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Nov 2024 02:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C39F21F237C4
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Nov 2024 01:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2232E12E5B;
	Wed, 20 Nov 2024 01:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ATfTvZo5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D951D555
	for <linux-integrity@vger.kernel.org>; Wed, 20 Nov 2024 01:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732066228; cv=none; b=kC/wSDQ5ZaRjqa44PuObp6eMV/Af+KVNQ+PXY8YEJei+e6bEhDe43f7IfNCXf6kRhK2AW/yY5jYUt89a2JRw/0+hyVb92m+HuzABUjKmHTA+yNdwGJYewyGEFdGX8uQQ2iFpbREHeKymZdmKJQzQwdJvpm1QaJSBOs6Sa4+niio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732066228; c=relaxed/simple;
	bh=6qdh6LBmK/398lpB9bAmtH1Pk2l1J+z9rGoUk3pd1cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KCqCXyGAAoX/9jJs8sq4SW0gfsmXpxJcsEieAK5TRQB9s9HuDwXoObehUEXh+ydaUImeUEJoyX2kyQOnOwCrGz9rNJ24+TyJJvMm4UZVp9EWj15rM3m678xXx+Vc3LbZ1zLszIy7iAm5+/e7U0/+RRTJzQ9wTAgsoBbJG7lz5Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ATfTvZo5; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5eb6aa330aeso200853eaf.2
        for <linux-integrity@vger.kernel.org>; Tue, 19 Nov 2024 17:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732066224; x=1732671024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZGR10ggWaZeO2YNn4FsP0WaRlqaBPir8LT1hMB2kek=;
        b=ATfTvZo5lFfyCEbOLWAL+akuHgKThq3xon3VJq9fL4j+T3kWGVtsE6g6bWg7AQ55l6
         vqjOUaP7cNGs12gTkXq27Z541qmK0pXmxoitIvfLxFoRNGThHGk1eQc8D950TmiRROhV
         cmVUGRnrG7MODKvu+Ggan1GevZ2dHc7Tmpu7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732066224; x=1732671024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PZGR10ggWaZeO2YNn4FsP0WaRlqaBPir8LT1hMB2kek=;
        b=JATUM4bKDrCOXnlM0ajtlALCrItZVrKkQWMelaGqWW4ba0yUNwvNbQd8RwwQ6W+MkT
         NNwxyt7sVfUjgFuNfhr7b/i4fwRYYazOXb6eYICrOsOHnq/swlv9GI0OVkKZQNRL/uic
         yGemyt9jFqV13SUsqWbgKwEf0stiMV67I4AxCpxQzKtgHcQ/NThtlJcxSOw2aDOCN+Og
         YKtDEvRIqDUopGJNAWc91I0szE6m8yWEJH5TmaE7RpXUdtuvGY1Wa/1gO4huUeW1OUVq
         ouLLjcPRUkdhc1hm6X5NxQvtl8IxGj4+2GvGjC9PXtO2jWIgWhGmOeD4/hgRvzoMUYUz
         gaWQ==
X-Forwarded-Encrypted: i=1; AJvYcCX69x7aRknx3mKv61BJioTgMa4lwqsWow3Q7auYQbfhIcOjTC2kPZy5RTSGmQQVDQrl2ImQ1ZENYJtbUlQpDws=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOt1soEzmxYN6syJa9d40S97fdpH1BcA1e8l4izKrCL/JdoY5M
	1MVOjOixFwu45XqnBBOa1fagjEraEnqlmA/ZsNCuJpB8RthzsxcUo2WWKCMP8Dd0VSiuL7eBQTf
	smtpb/lF7hJcSk07qea8OMPbuBBqbRRwMRQvy
X-Gm-Gg: ASbGncu2TDAp5/8boIOpwTfutaNOLR6Dd/4kaGBGikQqSiAHA18+WLF2bmsP/yq6iOK
	kwBIWM4VjZ7LLM50OcWizbntu0hWcZybjbs9WF4kVKT1O7pPkLB3VtJiTiYbR
X-Google-Smtp-Source: AGHT+IEbTocA9s4+2IN3QbU7bLsAOijH73JfkzpBIUOkOjyWwIfcgZEX1gKRTCOzVVroulaw37zMMPKaA4jAda4kSfw=
X-Received: by 2002:a05:6820:812:b0:5e5:c49a:b48 with SMTP id
 006d021491bc7-5eee822071dmr195128eaf.2.1732066224590; Tue, 19 Nov 2024
 17:30:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112191858.162021-1-mic@digikod.net> <20241112191858.162021-3-mic@digikod.net>
In-Reply-To: <20241112191858.162021-3-mic@digikod.net>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 19 Nov 2024 17:30:13 -0800
Message-ID: <CABi2SkWgSOx__YafOC1NXxsxLJim4dGALthy5uCFnSCrzQ4zkA@mail.gmail.com>
Subject: Re: [PATCH v21 2/6] security: Add EXEC_RESTRICT_FILE and
 EXEC_DENY_INTERACTIVE securebits
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>, 
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
	linux-security-module@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 12:06=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
>
> The new SECBIT_EXEC_RESTRICT_FILE, SECBIT_EXEC_DENY_INTERACTIVE, and
> their *_LOCKED counterparts are designed to be set by processes setting
> up an execution environment, such as a user session, a container, or a
> security sandbox.  Unlike other securebits, these ones can be set by
> unprivileged processes.  Like seccomp filters or Landlock domains, the
> securebits are inherited across processes.
>
> When SECBIT_EXEC_RESTRICT_FILE is set, programs interpreting code should
> control executable resources according to execveat(2) + AT_EXECVE_CHECK
> (see previous commit).
>
> When SECBIT_EXEC_DENY_INTERACTIVE is set, a process should deny
> execution of user interactive commands (which excludes executable
> regular files).
>
> Being able to configure each of these securebits enables system
> administrators or owner of image containers to gradually validate the
> related changes and to identify potential issues (e.g. with interpreter
> or audit logs).
>
> It should be noted that unlike other security bits, the
> SECBIT_EXEC_RESTRICT_FILE and SECBIT_EXEC_DENY_INTERACTIVE bits are
> dedicated to user space willing to restrict itself.  Because of that,
> they only make sense in the context of a trusted environment (e.g.
> sandbox, container, user session, full system) where the process
> changing its behavior (according to these bits) and all its parent
> processes are trusted.  Otherwise, any parent process could just execute
> its own malicious code (interpreting a script or not), or even enforce a
> seccomp filter to mask these bits.
>
> Such a secure environment can be achieved with an appropriate access
> control (e.g. mount's noexec option, file access rights, LSM policy) and
> an enlighten ld.so checking that libraries are allowed for execution
> e.g., to protect against illegitimate use of LD_PRELOAD.
>
> Ptrace restrictions according to these securebits would not make sense
> because of the processes' trust assumption.
>
> Scripts may need some changes to deal with untrusted data (e.g. stdin,
> environment variables), but that is outside the scope of the kernel.
>
> See chromeOS's documentation about script execution control and the
> related threat model:
> https://www.chromium.org/chromium-os/developer-library/guides/security/no=
exec-shell-scripts/
>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Paul Moore <paul@paul-moore.com>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20241112191858.162021-3-mic@digikod.net
> ---
>
> Changes since v20:
> * Move UAPI documentation to a dedicated RST file and format it.
>
> Changes since v19:
> * Replace SECBIT_SHOULD_EXEC_CHECK and SECBIT_SHOULD_EXEC_RESTRICT with
>   SECBIT_EXEC_RESTRICT_FILE and SECBIT_EXEC_DENY_INTERACTIVE:
>   https://lore.kernel.org/all/20240710.eiKohpa4Phai@digikod.net/
> * Remove the ptrace restrictions, suggested by Andy.
> * Improve documentation according to the discussion with Jeff.
>
> New design since v18:
> https://lore.kernel.org/r/20220104155024.48023-3-mic@digikod.net
> ---
>  Documentation/userspace-api/check_exec.rst | 97 ++++++++++++++++++++++
>  include/uapi/linux/securebits.h            | 24 +++++-
>  security/commoncap.c                       | 29 +++++--
>  3 files changed, 143 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/userspace-api/check_exec.rst b/Documentation/u=
serspace-api/check_exec.rst
> index ad1aeaa5f6c0..1df5c7534af9 100644
> --- a/Documentation/userspace-api/check_exec.rst
> +++ b/Documentation/userspace-api/check_exec.rst
> @@ -2,6 +2,21 @@
>  Executability check
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> +The ``AT_EXECVE_CHECK`` :manpage:`execveat(2)` flag, and the
> +``SECBIT_EXEC_RESTRICT_FILE`` and ``SECBIT_EXEC_DENY_INTERACTIVE`` secur=
ebits
> +are intended for script interpreters and dynamic linkers to enforce a
> +consistent execution security policy handled by the kernel.  See the
> +`samples/check-exec/inc.c`_ example.
> +
> +Whether an interpreter should check these securebits or not depends on t=
he
> +security risk of running malicious scripts with respect to the execution
> +environment, and whether the kernel can check if a script is trustworthy=
 or
> +not.  For instance, Python scripts running on a server can use arbitrary
> +syscalls and access arbitrary files.  Such interpreters should then be
> +enlighten to use these securebits and let users define their security po=
licy.
> +However, a JavaScript engine running in a web browser should already be
> +sandboxed and then should not be able to harm the user's environment.
> +
>  AT_EXECVE_CHECK
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> @@ -32,3 +47,85 @@ be executable, which also requires integrity guarantee=
s.
>  To avoid race conditions leading to time-of-check to time-of-use issues,
>  ``AT_EXECVE_CHECK`` should be used with ``AT_EMPTY_PATH`` to check again=
st a
>  file descriptor instead of a path.
> +
> +SECBIT_EXEC_RESTRICT_FILE and SECBIT_EXEC_DENY_INTERACTIVE
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +When ``SECBIT_EXEC_RESTRICT_FILE`` is set, a process should only interpr=
et or
> +execute a file if a call to :manpage:`execveat(2)` with the related file
> +descriptor and the ``AT_EXECVE_CHECK`` flag succeed.
> +
> +This secure bit may be set by user session managers, service managers,
> +container runtimes, sandboxer tools...  Except for test environments, th=
e
> +related ``SECBIT_EXEC_RESTRICT_FILE_LOCKED`` bit should also be set.
> +
> +Programs should only enforce consistent restrictions according to the
> +securebits but without relying on any other user-controlled configuratio=
n.
> +Indeed, the use case for these securebits is to only trust executable co=
de
> +vetted by the system configuration (through the kernel), so we should be
> +careful to not let untrusted users control this configuration.
> +
> +However, script interpreters may still use user configuration such as
> +environment variables as long as it is not a way to disable the securebi=
ts
> +checks.  For instance, the ``PATH`` and ``LD_PRELOAD`` variables can be =
set by
> +a script's caller.  Changing these variables may lead to unintended code
> +executions, but only from vetted executable programs, which is OK.  For =
this to
> +make sense, the system should provide a consistent security policy to av=
oid
> +arbitrary code execution e.g., by enforcing a write xor execute policy.
> +
> +When ``SECBIT_EXEC_DENY_INTERACTIVE`` is set, a process should never int=
erpret
> +interactive user commands (e.g. scripts).  However, if such commands are=
 passed
> +through a file descriptor (e.g. stdin), its content should be interprete=
d if a
> +call to :manpage:`execveat(2)` with the related file descriptor and the
> +``AT_EXECVE_CHECK`` flag succeed.
> +
> +For instance, script interpreters called with a script snippet as argume=
nt
> +should always deny such execution if ``SECBIT_EXEC_DENY_INTERACTIVE`` is=
 set.
> +
> +This secure bit may be set by user session managers, service managers,
> +container runtimes, sandboxer tools...  Except for test environments, th=
e
> +related ``SECBIT_EXEC_DENY_INTERACTIVE_LOCKED`` bit should also be set.
> +
> +Here is the expected behavior for a script interpreter according to comb=
ination
> +of any exec securebits:
> +
> +1. ``SECBIT_EXEC_RESTRICT_FILE=3D0`` and ``SECBIT_EXEC_DENY_INTERACTIVE=
=3D0``
> +
> +   Always interpret scripts, and allow arbitrary user commands (default)=
.
> +
> +   No threat, everyone and everything is trusted, but we can get ahead o=
f
> +   potential issues thanks to the call to :manpage:`execveat(2)` with
> +   ``AT_EXECVE_CHECK`` which should always be performed but ignored by t=
he
> +   script interpreter.  Indeed, this check is still important to enable =
systems
> +   administrators to verify requests (e.g. with audit) and prepare for
> +   migration to a secure mode.
> +
> +2. ``SECBIT_EXEC_RESTRICT_FILE=3D1`` and ``SECBIT_EXEC_DENY_INTERACTIVE=
=3D0``
> +
> +   Deny script interpretation if they are not executable, but allow
> +   arbitrary user commands.
> +
> +   The threat is (potential) malicious scripts run by trusted (and not f=
ooled)
> +   users.  That can protect against unintended script executions (e.g. `=
`sh
> +   /tmp/*.sh``).  This makes sense for (semi-restricted) user sessions.
> +
> +3. ``SECBIT_EXEC_RESTRICT_FILE=3D0`` and ``SECBIT_EXEC_DENY_INTERACTIVE=
=3D1``
> +
> +   Always interpret scripts, but deny arbitrary user commands.
> +
> +   This use case may be useful for secure services (i.e. without interac=
tive
> +   user session) where scripts' integrity is verified (e.g.  with IMA/EV=
M or
> +   dm-verity/IPE) but where access rights might not be ready yet.  Indee=
d,
> +   arbitrary interactive commands would be much more difficult to check.
> +
> +4. ``SECBIT_EXEC_RESTRICT_FILE=3D1`` and ``SECBIT_EXEC_DENY_INTERACTIVE=
=3D1``
> +
> +   Deny script interpretation if they are not executable, and also deny
> +   any arbitrary user commands.
> +
> +   The threat is malicious scripts run by untrusted users (but trusted c=
ode).
> +   This makes sense for system services that may only execute trusted sc=
ripts.
> +
> +.. Links
> +.. _samples/check-exec/inc.c:
> +   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/samples/check-exec/inc.c
> diff --git a/include/uapi/linux/securebits.h b/include/uapi/linux/secureb=
its.h
> index d6d98877ff1a..3fba30dbd68b 100644
> --- a/include/uapi/linux/securebits.h
> +++ b/include/uapi/linux/securebits.h
> @@ -52,10 +52,32 @@
>  #define SECBIT_NO_CAP_AMBIENT_RAISE_LOCKED \
>                         (issecure_mask(SECURE_NO_CAP_AMBIENT_RAISE_LOCKED=
))
>
> +/* See Documentation/userspace-api/check_exec.rst */
> +#define SECURE_EXEC_RESTRICT_FILE              8
> +#define SECURE_EXEC_RESTRICT_FILE_LOCKED       9  /* make bit-8 immutabl=
e */
> +
> +#define SECBIT_EXEC_RESTRICT_FILE (issecure_mask(SECURE_EXEC_RESTRICT_FI=
LE))
> +#define SECBIT_EXEC_RESTRICT_FILE_LOCKED \
> +                       (issecure_mask(SECURE_EXEC_RESTRICT_FILE_LOCKED))
> +
> +/* See Documentation/userspace-api/check_exec.rst */
> +#define SECURE_EXEC_DENY_INTERACTIVE           10
> +#define SECURE_EXEC_DENY_INTERACTIVE_LOCKED    11  /* make bit-10 immuta=
ble */
> +
> +#define SECBIT_EXEC_DENY_INTERACTIVE \
> +                       (issecure_mask(SECURE_EXEC_DENY_INTERACTIVE))
> +#define SECBIT_EXEC_DENY_INTERACTIVE_LOCKED \
> +                       (issecure_mask(SECURE_EXEC_DENY_INTERACTIVE_LOCKE=
D))
> +
>  #define SECURE_ALL_BITS                (issecure_mask(SECURE_NOROOT) | \
>                                  issecure_mask(SECURE_NO_SETUID_FIXUP) | =
\
>                                  issecure_mask(SECURE_KEEP_CAPS) | \
> -                                issecure_mask(SECURE_NO_CAP_AMBIENT_RAIS=
E))
> +                                issecure_mask(SECURE_NO_CAP_AMBIENT_RAIS=
E) | \
> +                                issecure_mask(SECURE_EXEC_RESTRICT_FILE)=
 | \
> +                                issecure_mask(SECURE_EXEC_DENY_INTERACTI=
VE))
>  #define SECURE_ALL_LOCKS       (SECURE_ALL_BITS << 1)
>
> +#define SECURE_ALL_UNPRIVILEGED (issecure_mask(SECURE_EXEC_RESTRICT_FILE=
) | \
> +                                issecure_mask(SECURE_EXEC_DENY_INTERACTI=
VE))
> +
>  #endif /* _UAPI_LINUX_SECUREBITS_H */
> diff --git a/security/commoncap.c b/security/commoncap.c
> index cefad323a0b1..52ea01acb453 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -1302,21 +1302,38 @@ int cap_task_prctl(int option, unsigned long arg2=
, unsigned long arg3,
>                      & (old->securebits ^ arg2))                        /=
*[1]*/
>                     || ((old->securebits & SECURE_ALL_LOCKS & ~arg2))   /=
*[2]*/
>                     || (arg2 & ~(SECURE_ALL_LOCKS | SECURE_ALL_BITS))   /=
*[3]*/
> -                   || (cap_capable(current_cred(),
> -                                   current_cred()->user_ns,
> -                                   CAP_SETPCAP,
> -                                   CAP_OPT_NONE) !=3D 0)                =
 /*[4]*/
>                         /*
>                          * [1] no changing of bits that are locked
>                          * [2] no unlocking of locks
>                          * [3] no setting of unsupported bits
> -                        * [4] doing anything requires privilege (go read=
 about
> -                        *     the "sendmail capabilities bug")
>                          */
>                     )
>                         /* cannot change a locked bit */
>                         return -EPERM;
>
> +               /*
> +                * Doing anything requires privilege (go read about the
> +                * "sendmail capabilities bug"), except for unprivileged =
bits.
> +                * Indeed, the SECURE_ALL_UNPRIVILEGED bits are not
> +                * restrictions enforced by the kernel but by user space =
on
> +                * itself.
> +                */
> +               if (cap_capable(current_cred(), current_cred()->user_ns,
> +                               CAP_SETPCAP, CAP_OPT_NONE) !=3D 0) {
> +                       const unsigned long unpriv_and_locks =3D
> +                               SECURE_ALL_UNPRIVILEGED |
> +                               SECURE_ALL_UNPRIVILEGED << 1;
> +                       const unsigned long changed =3D old->securebits ^=
 arg2;
> +
> +                       /* For legacy reason, denies non-change. */
> +                       if (!changed)
> +                               return -EPERM;
> +
> +                       /* Denies privileged changes. */
> +                       if (changed & ~unpriv_and_locks)
> +                               return -EPERM;
> +               }
> +
Is above a refactor (without functional change) or a bug fix ?
maybe a separate commit with description ?

>                 new =3D prepare_creds();
>                 if (!new)
>                         return -ENOMEM;
> --
> 2.47.0
>
>

