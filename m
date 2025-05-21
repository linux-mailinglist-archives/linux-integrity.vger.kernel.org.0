Return-Path: <linux-integrity+bounces-6288-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7600AABFEF5
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 23:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B4DD188814D
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 21:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5894E134AC;
	Wed, 21 May 2025 21:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KBpH34HJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE644B1E76
	for <linux-integrity@vger.kernel.org>; Wed, 21 May 2025 21:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747863092; cv=none; b=TSRghO2LvzKifnJmIznFTdVjXBPojMbXfXu98DgXJ8Q15FlZLh5L74fYItb+1ArNsLFowcUhS0f2I15aVhcZH5uu05HpFG+NZUcri5fssflK46xv5DyKYJp55l8bfPylMuQa2F+jwnPAaeHxMsaAAhE5qLoQjKF3REmSduH6wEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747863092; c=relaxed/simple;
	bh=744hrUQyQaJMNhXZ+MAkzT2DXCCzspRedhlx+Q/u6bY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kd/1ZOlyk/q5HoN758RV9/34ejaMEhy1u+5H3qp35FfCp085/3aN0L0YmuNOO+b8yhkwUBSZW7DSYD0gZIZHzWMwhicGGhPebCqYge1XKJkFEjwm4BFpmYt9gh/KGunNdjamyUtOl972lex2NtV2OvQqM8b8eGvtLBaz5TRMTNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KBpH34HJ; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e7d6cbd3a82so110818276.3
        for <linux-integrity@vger.kernel.org>; Wed, 21 May 2025 14:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747863089; x=1748467889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GXwy1kEW0JPOOxOeszLkv5sZ9JO5M8aq65wgnslF0c=;
        b=KBpH34HJOdXHJLvqmWENXqJJ9nfjfOunsY4+KIg4hS5DuGnPwbb5URdzt0bgIClDET
         M4gPV9RkLGx4W0Y7M5QS8XwBwA/H0fGWCCT4zGh9eFV8auRDqeZyiY7CA4IpN6/xjWcO
         /lYBb6pUt1aRmAwfbW485TfYuFljyzc1CSySp3TpNXrqfNsEKqRJq9ReSErL3pQLaDTE
         uK+uOrEeGuxWrS0zl1UAI2+xkaqIWe90q0pveoqb8cHuHMMGOnIjRP3/vmw+SBXie2+B
         tA6H6hPS5IXkLP/omAsQYq3MTfrYzKgc+HHxkYtpLO/Fw/hxS2r14vUPh0chtZVUlGvc
         lLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747863089; x=1748467889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GXwy1kEW0JPOOxOeszLkv5sZ9JO5M8aq65wgnslF0c=;
        b=UolN7H2rczKBqH5pp0nuwTEmwHAQr09Z7/A8esvlLPlE7eFziN03+BrqLhP76vX7TT
         5whtvfxx37jXRYsbdYiFoY4sQ40Zz3GHtNkxH7v/VJ5ky6pm5HB+hGoNRX+ywiWtnRj+
         RH96AbtnePOKLD5BwwAkALzaU/HsBX4CMaM7hRXQZKPFUWSwq+DgpWPBk61vcQfPECUI
         i29WufGMKG79odS1Sogki5UcGZNo5qXBslNigczIlTi/8qSVC8/zW50p81EeYhP5NX3l
         qE0DsW1gSbEQWfWD8uW7re0hXV0tGwEoYnX3Hw2e5I0uQeFGfDtcisHug7dHUU2EdIc3
         +YOw==
X-Forwarded-Encrypted: i=1; AJvYcCUZE6HPHtwSS6yi+4zTjfhYn1OvvWyBh/UHf6J02imP6xCl9QSxzNtPQlMerb35+8rb28dN/qveoysim0vTy08=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhiAa9mzfR8Hw0Qm0u57wGhAyedr2bJllVcP672PBs2BqvENU0
	GDWEgInjvcmdnP4H+QQ/bannBsrkKYTZYEGUZJqqerbsKbrLsoyXVJDAdGvwRuIrRtZuwKNB+nN
	h3LJ/SROqElSATEHzX2Joetppc3jDdxOEabmlQEFM
X-Gm-Gg: ASbGncsiH65o30ziQnHMw9iOJjYgXcY7W6Vbhy8MaNht3VScHzUwD93LPCEL/DV6DlO
	UJtqxqzTCPQfa++M3dtfU3b/YkguhIChMbRRwiqunum7fzC6cJPG73t1lm0R7YTSqkMI968D725
	Frol4LwBEsuNJHVGBkbrQ7arxZDFd7Vfvv3+e9kDT3q8M=
X-Google-Smtp-Source: AGHT+IFsYU17SnFlApxMikYlVjFydencW9RzKNz42GYdg5TTQEnzoKQH5AwgNW/rQbr1eW4h8yf43+YFkMVJaFGJLCM=
X-Received: by 2002:a05:6902:2411:b0:e7b:6768:1d4c with SMTP id
 3f1490d57ef6-e7b6a1fd6e3mr28236771276.36.1747863089482; Wed, 21 May 2025
 14:31:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521140121.591482-1-git@nightmared.fr> <20250521140121.591482-10-git@nightmared.fr>
In-Reply-To: <20250521140121.591482-10-git@nightmared.fr>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 21 May 2025 17:31:18 -0400
X-Gm-Features: AX0GCFvNcVqRgFYOLi4D9FncLR4G0u1aE30z5MYv_qx60lOm2NGbhIkb6anmQLY
Message-ID: <CAHC9VhR-80zxgo+q07Aw8HqK+qiPdnuXC0axONGac0e9JxXvmw@mail.gmail.com>
Subject: Re: [RFC PATCH 9/9] Loadpol LSM: add a minimal documentation
To: Simon THOBY <git@nightmared.fr>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 10:03=E2=80=AFAM Simon THOBY <git@nightmared.fr> wr=
ote:
>
> Introduce a minimal documentation for Loadpol, presenting the policy
> format and the two user interfaces: the securityfs policy file and the
> sysctl.
>
> Signed-off-by: Simon THOBY <git@nightmared.fr>
> ---
>  Documentation/admin-guide/LSM/Loadpol.rst | 81 +++++++++++++++++++++++
>  Documentation/admin-guide/LSM/index.rst   |  1 +
>  2 files changed, 82 insertions(+)
>  create mode 100644 Documentation/admin-guide/LSM/Loadpol.rst
>
> diff --git a/Documentation/admin-guide/LSM/Loadpol.rst b/Documentation/ad=
min-guide/LSM/Loadpol.rst
> new file mode 100644
> index 000000000000..0aa24a8d393c
> --- /dev/null
> +++ b/Documentation/admin-guide/LSM/Loadpol.rst
> @@ -0,0 +1,81 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D
> +Loadpol
> +=3D=3D=3D=3D=3D=3D=3D
> +
> +Loadpol is a Linux Security Module that enforces a user-provided policy
> +when decided whether a dynamic module can be loaded or not.

Considering the relatively small scope of Loadpol, I have to ask if
you've considered augmenting other LSMs to meet your needs?  While
LoadPin is different from what you are proposing here, it does
similarly limit its scope to kernel module load operations, and given
the current simplicity of LoadPin I imagine one could find a creative
way to extend it to support what you are trying to do.

> +The policy can be read and rewritten at ``/sys/kernel/security/loadpol/p=
olicy``.
> +
> +A default policy is created that contains the current list of blackliste=
d modules,
> +and a catch-all entry that allow loading any module.
> +
> +Policy format
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The policy is defined as a set of line-separated entries.
> +Each entry define the conditions for a match (the origin of the load req=
uest and
> +the name of the kernel module), and the action to take when the load req=
uest
> +matches the entry.
> +
> +
> +Entry syntax: ``[origin=3D(userspace|kernel|kernel,userspace)] [module=
=3D<module_name>] action=3D(allow|deny)``
> +
> +There are two matching conditions:
> +
> +``origin``:
> +    Load Requests can come from two origins:
> +
> +    * ``userspace`` (ie. a program in userspace called modprobe/insmod)
> +    * ``kernel`` (the kernel requested the module directly by calling
> +      ``request_module(...)``, e.g. loading a filesystem when performing=
 a
> +      ``-o loop`` mount).
> +
> +    When unspecified, the condition defaults to ``kernel,userspace`` (wh=
ich means
> +    that both origins match).
> +
> +``module``:
> +    Name of the kernel module being matched. The name can contain wilcar=
ds.
> +    Beware, module aliases do not work!

It would be good to have a section in the documentation where you
discuss how the risks inherent to filtering on the module name, and
approaches that can be used to ensure that a malicious module is not
simply "borrowing" a known good module's name.

> +There are two possible actions:
> +
> +* ``allow``: permit the load of the kernel module.
> +* ``deny``: reject the load of the kernel module and emit an audit log.
> +
> +The policy is not greedy: as soon as a match is found, the evaluation te=
rminates
> +with the result of that match. So be very careful with the order of your=
 entries.
> +
> +The main use cases of the policy will probably be to define an allowlist
> +(here, we allow ``module_a`` and any module starting with ``module_b`` l=
oaded
> +by the user)::
> +
> +       module=3D=3Dmodule_a action=3Dallow
> +       origin=3D=3Duser module=3D=3Dmodule_b* action=3Ddeny
> +       action=3Ddeny
> +
> +But other mechanisms are possible, like a denylist
> +(here we block ``module_a``, ``module_b`` if it is loaded by the kernel =
and
> +any module starting with ``module_c`` loaded by the user)::
> +
> +       module=3D=3Dmodule_a action=3Ddeny
> +       origin=3D=3Dkernel module=3D=3Dmodule_b action=3Ddeny
> +       origin=3D=3Duser module=3D=3Dmodule_c* action=3Ddeny
> +       action=3Dallow
> +
> +Policy lock
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +In order to protect the policy from tampering, a sysctl is provided to
> +lock-in-place the currently-loaded policy.
> +
> +The ``security.loadpol.locked`` can take 2 values:
> +
> +0 - default:
> +    the policy can be reloaded at runtime by any administrator.
> +
> +1 - locked:
> +    the policy cannot be updated or modified, and loadpol cannot be disa=
bled
> +    without rebooting.
> diff --git a/Documentation/admin-guide/LSM/index.rst b/Documentation/admi=
n-guide/LSM/index.rst
> index b44ef68f6e4d..01d36670d8ad 100644
> --- a/Documentation/admin-guide/LSM/index.rst
> +++ b/Documentation/admin-guide/LSM/index.rst
> @@ -42,6 +42,7 @@ subdirectories.
>
>     apparmor
>     LoadPin
> +   Loadpol
>     SELinux
>     Smack
>     tomoyo
> --
> 2.49.0

--=20
paul-moore.com

