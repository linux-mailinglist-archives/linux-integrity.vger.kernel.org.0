Return-Path: <linux-integrity+bounces-5939-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D353A94112
	for <lists+linux-integrity@lfdr.de>; Sat, 19 Apr 2025 04:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63FB93B4E38
	for <lists+linux-integrity@lfdr.de>; Sat, 19 Apr 2025 02:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F1F6A33F;
	Sat, 19 Apr 2025 02:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+nHox6+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E183594F;
	Sat, 19 Apr 2025 02:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745030585; cv=none; b=kXYaScEMYkuEvlUo3FtCRqudD0zanVi+SwNdFxd9LoMwOiHlQC21oG5CzkvhH1HTPVglbSJdrJoP0dqFC6BL6ceE8cExrmR1OpiBIOIrjSmHHlDaphp+wjJnq+wJvM172fw5AD4oZmOmg2Okg/UK1Pl7mHYjuDdF4syfyrnKoMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745030585; c=relaxed/simple;
	bh=ZlkSq5Td6WYYbF+F+e+FXuqnAmKdgsTD1oTyXzFrM48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iG1h4PX9IAOu9K+vj48+scbA7c3shIifMEJaEPwofX+TAi46Znky0DH0BcDy3mwBm4UFTTBjnu+B7qc+sllQL4UpYx2nae8C6tVb/8i1EnSPmknWXIGSFsQ+51egBrwVRLixioxb7nLxTrvlcDCo3Aj5QupH8K8EPEKSnSt8v2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+nHox6+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDB9C4AF09;
	Sat, 19 Apr 2025 02:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745030585;
	bh=ZlkSq5Td6WYYbF+F+e+FXuqnAmKdgsTD1oTyXzFrM48=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b+nHox6+aLlwYSX+ok3rJWbzoMhFNVlr3PyqhFldr0YB2CtJJm6p8uB3/whFmrBsZ
	 czBPq2+pML2KWkAoGBDJ2bor14NZ7uueOn20XQfoFV5Qj3K4ZHkmOdUdK3JWcvYYqs
	 AO0cqeZ/3St1eC7h0icuga9HIs7/sSCQYE2cCqwvAFhCBIRnm9C4PMxze0DZPPcbkE
	 BSklgmi848wJ1g0735g3Kpg/lZlpzYmT5rtYgxc7bj7735aYGwKddimm5ztndMpUpE
	 LI7nDjuY+aql5qTutuwiaPW5fslPgntg7TeMFuPfUOTjgqFDPkO1Ok/RgRqeBuD+lP
	 0pC/g9a0jsG+A==
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-703cd93820fso21447507b3.2;
        Fri, 18 Apr 2025 19:43:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUyclHgTHTrrNHXDYMWdjLaEm/twy5LtaZ9in579Cr9KWqbYUGt2WYgvhS+7RVBGQ1QtpsI7RkRHg==@vger.kernel.org, AJvYcCXdGFP8KnFn2nftS17QRBoHys8bOZ6tuAOdmT7OkCvUGh8KgQ8ku5qmkGb7+T5H6PtrxcOYg3RR/lFpYC2U3VM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvyTPd3NL7cLhH36c9fwDa2OkZiL3Pslds63fdtAlJvp/CBVKm
	eZw1FXTk4hltqfvacVa29JJd4N93lk3kovuupqRBMuvTi90o72czuyt59qGWH6yp+fTUtIV5Ndc
	9gCr9N4yYr2zSIybD0A24xoDiC88=
X-Google-Smtp-Source: AGHT+IFtrN2IG9k3zHXRKl+p7dZrpWB/qfzB9Z94kJ0h6i96vvuhHrQr+YtGSk9tA6iZRIm3DeD4tZXRPfktA0y0nWw=
X-Received: by 2002:a05:690c:7109:b0:6fb:1e5a:fcdd with SMTP id
 00721157ae682-706ccd28033mr62513067b3.17.1745030584292; Fri, 18 Apr 2025
 19:43:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-41-paul@paul-moore.com>
In-Reply-To: <20250409185019.238841-41-paul@paul-moore.com>
From: Fan Wu <wufan@kernel.org>
Date: Fri, 18 Apr 2025 19:42:52 -0700
X-Gmail-Original-Message-ID: <CAKtyLkEzie5dg2sVETdZ6NZwwN0Ni7SY4Za5mDCMWRJkUtYh=w@mail.gmail.com>
X-Gm-Features: ATxdqUFfUvXpOZ9Oh5rBNORPGL_yQNsMXbrYKVfXmJaqxlF6oIdZhIhto4spysg
Message-ID: <CAKtyLkEzie5dg2sVETdZ6NZwwN0Ni7SY4Za5mDCMWRJkUtYh=w@mail.gmail.com>
Subject: Re: [RFC PATCH 10/29] lsm: cleanup the LSM blob size code
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 11:53=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Convert the lsm_blob_size fields to unsigned integers as there is no
> current need for them to be negative, change "lsm_set_blob_size()" to
> "lsm_blob_size_update()" to better reflect reality, and perform some
> other minor cleanups to the associated code.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  include/linux/lsm_hooks.h | 28 +++++++++++-----------
>  security/lsm_init.c       | 50 +++++++++++++++++++++++----------------
>  2 files changed, 43 insertions(+), 35 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index bc477fb20d02..a7ecb0791a0f 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -102,20 +102,20 @@ struct security_hook_list {
>   * Security blob size or offset data.
>   */
>  struct lsm_blob_sizes {
> -       int lbs_cred;
> -       int lbs_file;
> -       int lbs_ib;
> -       int lbs_inode;
> -       int lbs_sock;
> -       int lbs_superblock;
> -       int lbs_ipc;
> -       int lbs_key;
> -       int lbs_msg_msg;
> -       int lbs_perf_event;
> -       int lbs_task;
> -       int lbs_xattr_count; /* number of xattr slots in new_xattrs array=
 */
> -       int lbs_tun_dev;
> -       int lbs_bdev;
> +       unsigned int lbs_cred;
> +       unsigned int lbs_file;
> +       unsigned int lbs_ib;
> +       unsigned int lbs_inode;
> +       unsigned int lbs_sock;
> +       unsigned int lbs_superblock;
> +       unsigned int lbs_ipc;
> +       unsigned int lbs_key;
> +       unsigned int lbs_msg_msg;
> +       unsigned int lbs_perf_event;
> +       unsigned int lbs_task;
> +       unsigned int lbs_xattr_count; /* num xattr slots in new_xattrs ar=
ray */
> +       unsigned int lbs_tun_dev;
> +       unsigned int lbs_bdev;
>  };

Can we use size_t here?

-Fan

