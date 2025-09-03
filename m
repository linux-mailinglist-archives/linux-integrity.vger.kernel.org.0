Return-Path: <linux-integrity+bounces-7009-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5E6B42B30
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Sep 2025 22:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D5E5166CBC
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Sep 2025 20:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69DA2D46CB;
	Wed,  3 Sep 2025 20:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cH97UslS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C3E302756
	for <linux-integrity@vger.kernel.org>; Wed,  3 Sep 2025 20:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756932207; cv=none; b=XUPHIfSVWlid62l5rxFAK2Lc8w81RdQlhhxq5Y52k+51+O9LNX797NmGkM7GqdWRWUA+9fXMZAyd3C+yqKq/FTKvrt7/7lzpV6H0IX3qTcDaCf5VtUbW7r1vPHzpzRcKa9lIf/bm1Z1zjrZal+v/M4b8+KLy5ZtMTUlRIXW3Psw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756932207; c=relaxed/simple;
	bh=27og5+fwLnrq84zqJxNwPwieJR4goIKuoY55Yt2xb6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cquin5qa1KVUJC95RVHEERMlRy1X+yW3cU4cIMPB+/YaeQuucNSDZl1hv+ZdQf4/hDZQyyJg8W/IbdVkXkOxZN/XU8CdWkgyqMqTRB8+HpvxjslsunKYGfPgLRExXEDRSyaJ+iTqlCLILBA+lbehaZqt/dvY5IYf5Nul6fbmAyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cH97UslS; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3298961169bso195311a91.2
        for <linux-integrity@vger.kernel.org>; Wed, 03 Sep 2025 13:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756932205; x=1757537005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4J5ZAyPuJAqt+B4efQjYgrP2z9OquwHDAuNUGWfku9Y=;
        b=cH97UslScOfryM/kMlZ5wsLXstKkAQGi+JRvHcA4eVQ7QlaEol3FbJ6SKzShOH4uq5
         X99tkyDv8wzgXvFCLXDirm2/Ne8Cd2AtlRaq8x/AEIryR4FbCxaWpcfhcFIyxYoK5j4c
         gduSY/BpKZ8uZf50Wn8575y811S/NnT2fQLvfQc30KLOS/mRk5I8MnMq7dQj67Esm31z
         EWH7ZbCwHIuJYLrvZZKwW6Q2y5H6CFtqNFqqVdugbeVoAzmv2dOvieiT7X3FoHKwId05
         fDfcF+8fUInA01ftYDism6bskgoVjZGFrHhXbFnjSkJgzMJBQb2QJjbSlinUMJfJ7BE0
         oN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756932205; x=1757537005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4J5ZAyPuJAqt+B4efQjYgrP2z9OquwHDAuNUGWfku9Y=;
        b=HZ0/g0onsJRTybMqsf0O4pHRJ1VROv4OBXMmb69ziz8yDT2dk1O2Wb2rJp4qEFn/rM
         BpcX6R2WUkiqcxIIW5euCIUCPIglZPK1jOP3Co71BEsdO1E9pLbHksEUOqtaZpvX4/W9
         hYz8pv7mxB1AwqlBDmg5/oU4dTTJb5LtNFvjV9SrJTuSQzspZNEYX5ztaanF7/tcmUfC
         wX/u2iETMBB9yualGKJxiLQ52mh4PpbWgGyJ6VTjTGSNDc630bp2kYnNbMifuUKdmRFE
         kLiEYSO4tJhBdKgPFFqJbardMdJpaGl1+9nxeLNVPFXVR4VMvMoE7b83hx/FGc+TiaMg
         /z2g==
X-Forwarded-Encrypted: i=1; AJvYcCXSHp+7h79dla1tK3Wdk0oy9pTTnSiySkl2UVv6oHWncR0RMYvqDdIHT61RXZZhPUldhEw6+0zSQ73e/VaHpsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/gENY6oryxaLZ12aeVpv/kEi0S1C2LjQke37aQxYorSMeIe2U
	yo0+dysG17lcDy68wvI1ItUcvZik6tFwAV6zXMcjFpkQvD7izrPNmmAIhQ7AV7bBhpUfiRGCT1u
	p1qgi426MD+7qb1IoqZ2PhXFzfYTV/y1RzTQO+DZR
X-Gm-Gg: ASbGncujYni2LAK97GizOGcFvpZgkO98YDvgYinf0isM3rScss1IxFjMiJ/Va8KYlYB
	i/tsqNWEjixC2S/aZ2u9H+GNMsFWJ+3rxyzHR9jlZwusgdikFGZ8cmNuWaLSjszgVLP91gSCW+4
	Hl+2pYxYlOkFs/+RsEuVkKFPhGgKZcRKgNdluzstSr9/J0dD9GINHMVqXrDVHoGsa2Q823BEFZe
	lKJL+0=
X-Google-Smtp-Source: AGHT+IEQJCaMMXRQwVvK7h5/Q6b9DGduxYynzANDDzGXPsK+5nl9MJ7jOAJpAhUnmR3pkuQpDg9Pg4o7XueiTWfhdoI=
X-Received: by 2002:a17:90b:2802:b0:32b:9506:1773 with SMTP id
 98e67ed59e1d1-32b950618b8mr55670a91.33.1756932205371; Wed, 03 Sep 2025
 13:43:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9f35539de7188c6b853c55b76958a286131f5928.camel@huaweicloud.com> <20250902125457.2689519-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20250902125457.2689519-1-roberto.sassu@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 3 Sep 2025 16:43:13 -0400
X-Gm-Features: Ac12FXxKMPsEzJAGYC2xoOwmRYoQxVIxBe63dOEJDQM6GwZfLYjmyRi68JmcOCk
Message-ID: <CAHC9VhSP=NEDd7nLUxPj95tgaHeERaJHf2KH9PDfpwNNuPRzTQ@mail.gmail.com>
Subject: Re: [PATCH] ima,evm: move initcalls to the LSM framework
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, john.johansen@canonical.com, wufan@kernel.org, 
	mic@digikod.net, kees@kernel.org, mortonm@chromium.org, 
	casey@schaufler-ca.com, penguin-kernel@i-love.sakura.ne.jp, 
	nicolas.bouchinet@oss.cyber.gouv.fr, xiujianfeng@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 8:59=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Paul Moore <paul@paul-moore.com>

We should obviously drop the 'From:' line above ;)

> This patch converts IMA and EVM to use the LSM frameworks's initcall
> mechanism. It moved the integrity_fs_init() call to ima_fs_init() and
> evm_init_secfs(), to work around the fact that there is no "integrity" LS=
M,
> and introduced integrity_fs_fini() to remove the integrity directory, if
> empty. Both integrity_fs_init() and integrity_fs_fini() support the
> scenario of being called by both the IMA and EVM LSMs.
>
> It is worth mentioning that this patch does not touch any of the
> "platform certs" code that lives in the security/integrity/platform_certs
> directory as the IMA/EVM maintainers have assured me that this code is
> unrelated to IMA/EVM, despite the location, and will be moved to a more
> relevant subsystem in the future.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/integrity/evm/evm_main.c  |  3 +--
>  security/integrity/evm/evm_secfs.c | 11 +++++++++--
>  security/integrity/iint.c          | 14 ++++++++++++--
>  security/integrity/ima/ima_fs.c    | 11 +++++++++--
>  security/integrity/ima/ima_main.c  |  4 ++--
>  security/integrity/integrity.h     |  2 ++
>  6 files changed, 35 insertions(+), 10 deletions(-)

I'm happy to replace my patch with this one, would you like me to wait
on an ACK from Mimi, or are you okay if I go ahead with this patch?

(As an aside, I'm still not entirely clear if I should wait on ACKs
from both you and Mimi on IMA/EVM changes, or if one of the two of you
is sufficient?  I'm happy to follow whatever approach the two of you
would prefer, but I don't know what that is ;) ... )

--=20
paul-moore.com

