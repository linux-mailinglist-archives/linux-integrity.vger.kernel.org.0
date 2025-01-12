Return-Path: <linux-integrity+bounces-4534-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5B1A0AAF4
	for <lists+linux-integrity@lfdr.de>; Sun, 12 Jan 2025 17:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E12F3A2F9B
	for <lists+linux-integrity@lfdr.de>; Sun, 12 Jan 2025 16:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA321BEF76;
	Sun, 12 Jan 2025 16:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JpyerwBh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CA11BC08B
	for <linux-integrity@vger.kernel.org>; Sun, 12 Jan 2025 16:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736699821; cv=none; b=X+2EM/kLx7AaMM5NGS5NNcmbnJJvJwoUtOf0+yiQH98MsyVn+WGYR7IPNGLQUu+TpY5T8/bZL+IvVu6cz+rF/43hyYCZdonSmSfSLyPoa3xjQfDGwcbpfa8PPn1WNRrJZtzI4NUaHQt33FWMuVjBqwxFFok35ZteiV7WLIyeV0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736699821; c=relaxed/simple;
	bh=mgdxqN0bYV7p1LBfaK8u0pPJA3FwFbTYbBJIMc8nJow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJYE7h5sNAvZewCycBZbs4mHVoqPN2Fh9Htkb8D12d30gkhefCaYq8ZAsXsq0up1M9Vs4MI/TxQ26CBjOHQOMT6EIQT5SS5lUkYnPiwDjdzg54zuyc1paNfcwBo4S/7O3ztjL3T+uWXJCaXvK2j83MUJJDzAyDFg90VnOtE/yO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JpyerwBh; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e53537d8feeso5151186276.0
        for <linux-integrity@vger.kernel.org>; Sun, 12 Jan 2025 08:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736699817; x=1737304617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vr1ktmu3cwRXhTgySXlqgLK2IZ2AAICyoWgt+rRYqSA=;
        b=JpyerwBhfrzAmHG/BYyw9E8c7TrMnB1CZ9hdbKA1/6cgCcJrDLSBusRFkkbB072uph
         DUiqIyIyPxoPnvU2zSe+wJlvdSNbOmiwL8hlfAl6Nuh9h8wgxLLHbwvLxwBiKhEVUfxL
         yl+sFRE0ZqdTp36YWl7t2g0hY8uxSi8ugDKzd15bmn68nYY0Pfe7JVFr9/FlCCmGLUE/
         qOHOl7Cd6/HvIz/lioirUAK92n0qY9b2mhERyNpjIHSXe/wQtV6kudafo9F3Djzdja4v
         16pQeHpoBGiLHmGUCNTi+YxypAOiWxZz8E+r7ehNH6KUrL60dpyessCeAXmSmQJcHuiE
         1Vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736699817; x=1737304617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vr1ktmu3cwRXhTgySXlqgLK2IZ2AAICyoWgt+rRYqSA=;
        b=qJ6XCPK+8rBKenOMgx2Xxomvvblmhu5nGiZLQRCD4611GtJ9+aJKlcCUQQfS7c9Igr
         lFGe31ZUbIfr4YrFOWVeT6fRPqJNWjOTGQlJDc+CQ8kcHOPWg93VQ93Uvub0wbT+ZTyz
         w+Zn8ty3VrswJlm3VAfzgsjvQ1cBi5AZDkQF8wQLa4Y8GOFKBIN7zQP9EIFUk/W3BAWx
         9/1YDzgV2AgZ0aBATG9jr/r/uSgXW4sklSx/qm8E4iyJoTfisZoH64MRvny/xswvcgTN
         prScS/WuoGO20H911xey5k5VHVbUtCV54gIvjIzyR0D754/weNkMSpws/5xVeJyOuNrA
         1IRg==
X-Forwarded-Encrypted: i=1; AJvYcCWnRcICvONbdBN4yvXBaJmJdkDDmRslJu+Hn3NILidycX7Y3CaYcZUyXSPOpqbGw2TlkFlKwj7qjzET88q8Fc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqVtXWBjWx+ddpKqPb9wr7D2ZknQsVdqDozS7gBgEj1tzcchyZ
	1WeYqfP2U+X70U6FdiobA5C/eF787hxdqQvVVJpJqF+nruWhXkMnrlCbJVr6R1fgBSfey7aGU+W
	1GGkRE+qXDLg74/9OsT6pOsk0UeCfcUJXcD7T
X-Gm-Gg: ASbGncuWMh4Dcnarqb6XiTRsQwYe7T8aWUPT87T6RaV3i/JFegZu8/iQyfUcqw6S3Lf
	W9s8K/WhSGzQh7T6XnqWFn2+m2KSaz8e/FvmR
X-Google-Smtp-Source: AGHT+IGIA6hMaBoWY4qF4q6O4nbIJYkuiC4pn3Ji5ObcZCNpPRu/wBbEKhJKyaUL1cf/zrWh1YtCi+h4orpQA8HPIdQ=
X-Received: by 2002:a05:6902:a09:b0:e57:31f1:9722 with SMTP id
 3f1490d57ef6-e5731f1a429mr6492655276.29.1736699816946; Sun, 12 Jan 2025
 08:36:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111.22fc32ae0729@gnoack.org> <20250112072925.1774-1-tanyaagarwal25699@gmail.com>
In-Reply-To: <20250112072925.1774-1-tanyaagarwal25699@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 12 Jan 2025 11:36:46 -0500
X-Gm-Features: AbW1kvYKYLPgf17jvvR-FCco9-QwNGcpYookaR3B9G1F3dpIui_cbJeum1-JgEY
Message-ID: <CAHC9VhRbZLtBZ8dH-kASnkQUehG4Cu=zd23A6Jj9zfnyeGOTsA@mail.gmail.com>
Subject: Re: [PATCH V2] security: fix typos and spelling errors
To: Tanya Agarwal <tanyaagarwal25699@gmail.com>
Cc: casey@schaufler-ca.com, takedakn@nttdata.co.jp, 
	penguin-kernel@i-love.sakura.ne.jp, john.johansen@canonical.com, 
	jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	mic@digikod.net, gnoack@google.com, stephen.smalley.work@gmail.com, 
	omosnace@redhat.com, linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	skhan@linuxfoundation.org, anupnewsmail@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 12, 2025 at 2:30=E2=80=AFAM Tanya Agarwal
<tanyaagarwal25699@gmail.com> wrote:
>
> From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
>
> Fix typos and spelling errors in security module comments that were
> identified using the codespell tool.
> No functional changes - documentation only.
>
> Signed-off-by: Tanya Agarwal <tanyaagarwal25699@gmail.com>
> ---
> Thanks G=C3=BCnther, for catching this error.
> The irony of having a spelling mistake in a patch that fixes spelling
> mistakes is not lost on me :)
>
> I've fixed it in V2 of the patch. Thank you for the careful review!
>
> V2: fix spelling mistake - s/beeen/been/
>
>  security/apparmor/apparmorfs.c      | 6 +++---
>  security/apparmor/domain.c          | 4 ++--
>  security/apparmor/label.c           | 2 +-
>  security/apparmor/lsm.c             | 2 +-
>  security/apparmor/policy.c          | 4 ++--
>  security/integrity/evm/evm_crypto.c | 2 +-
>  security/integrity/evm/evm_main.c   | 2 +-
>  security/integrity/ima/ima_main.c   | 6 +++---
>  security/landlock/ruleset.c         | 2 +-
>  security/selinux/avc.c              | 2 +-
>  security/smack/smack.h              | 2 +-
>  security/smack/smack_access.c       | 4 ++--
>  security/smack/smack_lsm.c          | 6 +++---
>  security/smack/smackfs.c            | 2 +-
>  security/tomoyo/domain.c            | 2 +-
>  15 files changed, 24 insertions(+), 24 deletions(-)

Hi Tanya,

Ideally this patchset would be split into into seperate, independent
patches, one for AppArmor, one for IMA/EVM, one for Landlock, one for
SELinux, one for Smack, and one for TOMOYO.  This allows for each LSM
maintainer to review and merge these fixes individually as opposed to
requiring every LSM maintainer to ACK this patch before it can be
merged.  There is also a risk, as with any cross-subsystem patch, that
this patch will cause merge conflicts in the future as there is the
possibility of multiple development trees touching the same file
region, function, etc.

As a general rule, if you have a single patch that touches multiple
kernel subsystems, and the changes in each subsystem can be applied
independently, you really should split the patch into subsystem
specific patches.  You also should post these patches independently,
and not as a single patchset, as a single patchset crossing multiple
subsystems can sometimes cause some confusion among maintainers about
who is going to be responsible for handling the patchset (even if all
the patches are split properly).

--
paul-moore.com

