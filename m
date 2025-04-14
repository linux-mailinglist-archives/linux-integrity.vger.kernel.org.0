Return-Path: <linux-integrity+bounces-5873-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19466A88DA1
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Apr 2025 23:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 492BD7A4637
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Apr 2025 21:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05241B393A;
	Mon, 14 Apr 2025 21:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyFobZ4t"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4002DFA4E;
	Mon, 14 Apr 2025 21:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744665561; cv=none; b=Hv5vVwxglaZjLBtf2r8YyS646SAPcPtWH+q9AosK9kE/JABaQVUEpgejOp2hrr3QgUHo8pkQuhKQRG4oKWRlfcp9gvC1BlaR+Sl0rMel3VRX6jgz3OIOfvqgxQFiuwseXnkRHpGwTJLBKLnd7ILyTF/hIDLNKLgvjO4aOHU9FBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744665561; c=relaxed/simple;
	bh=j6wOhLDwJ/trz2erD0Wh0yn9GSgSP0Ggd8mJ248LGVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPzy6mufCZBQL4QXh0xs+j3dpZL2adw3e/skMaQ/sUdYnCyGHR7hdNI95NSAcqPzNF5tw9oq9eqD8eeCIhboJvGC6CKmjjokSGyObNW0G9+NjBoPERF0ul82TsxBHEkh3M20rJQ+2D/bW9UtW5HayYaX9Ax+fGm2bG8gi1OebJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyFobZ4t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7B6C4CEF0;
	Mon, 14 Apr 2025 21:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744665561;
	bh=j6wOhLDwJ/trz2erD0Wh0yn9GSgSP0Ggd8mJ248LGVE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CyFobZ4tQ/M/h7Q7aZyhdLfq0tdBqzaFkJ3xN78paogmOKmMRW/P31rXHEPlpc1/e
	 WJ8ijfy4c/KpnEZg57lW5vfp9XxwQrYcGTZBepggoS3DAcomVXyS4CPTN/u1PymPGL
	 O9vDsLvMP2sDRuGFLIQMLmqlAr+ivddYzZLFYjhxKiml9RKzPZANsCOWaGsia/lJAL
	 e11/FSEeD4VpXnDe/ccmcdyMi81nAql/NCo6M3XwQ6b5ODzeB11sFg2bEJFUJ75sh7
	 N792NX0WLygmSIdje4uCINu0r3jrUApS19Kg/D0DX7qaSvzBymh5zInIn2VrFFrNEo
	 pkNW8u/Ee1FMA==
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6fedefb1c9cso41400007b3.0;
        Mon, 14 Apr 2025 14:19:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjjlXudrFDR0fq165pDGHrR8MZkEiuIH9OQ1C6reqSODF8IpLZihMhm06kRkOK/WOOdQukfofiAA==@vger.kernel.org, AJvYcCW0jH3xA4J4tmGHsDW7mAbm1lHxfxoioH47ruYLkjc4CsFCdSH8yEqKg2Xl7XMGJa95yZhso0cPj9+tZ1cQP4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpZJayU+HdlX4rur/USdkmGPRU5sFttzPax/fqNDPYqd3YY/ql
	kvyYZJEAD0JA3P4OjbJumfTvTIM3Us/xcwraBmBajwcLITt4YOGfGN5RM8bHlt0WS0hVNZvjf1W
	syJFzVmmBbrOOmdje+iNVMWf7PcU=
X-Google-Smtp-Source: AGHT+IHjzbvj5+C9RyG4NN0z4GbdAKbWSk3tuauhpjJWEJawSM1DpohZQ8i/++eh5wF5bUG+miKrnBZwa/zCfEYWEQg=
X-Received: by 2002:a81:be19:0:b0:705:5ab0:ea06 with SMTP id
 00721157ae682-7055ab0ea6dmr194037897b3.2.1744665560291; Mon, 14 Apr 2025
 14:19:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-50-paul@paul-moore.com>
In-Reply-To: <20250409185019.238841-50-paul@paul-moore.com>
From: Fan Wu <wufan@kernel.org>
Date: Mon, 14 Apr 2025 14:19:08 -0700
X-Gmail-Original-Message-ID: <CAKtyLkG3PEwpNV55mpsntp=pbRjaZVhoYOc2wWGCsoEdqnFS_g@mail.gmail.com>
X-Gm-Features: ATxdqUEknNldTsjoVWpW9fZnE2aqd6TR4mTnfTSuNu3-1ohxgSfO_BQWVKJmM2Q
Message-ID: <CAKtyLkG3PEwpNV55mpsntp=pbRjaZVhoYOc2wWGCsoEdqnFS_g@mail.gmail.com>
Subject: Re: [RFC PATCH 19/29] ipe: move initcalls to the LSM framework
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
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/ipe/fs.c  | 4 +---
>  security/ipe/ipe.c | 1 +
>  security/ipe/ipe.h | 2 ++
>  3 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/security/ipe/fs.c b/security/ipe/fs.c
> index 5b6d19fb844a..e4437c70ed3d 100644
> --- a/security/ipe/fs.c
> +++ b/security/ipe/fs.c
> @@ -187,7 +187,7 @@ static const struct file_operations enforce_fops =3D =
{
>   * Return: %0 on success. If an error occurs, the function will return
>   * the -errno.
>   */
> -static int __init ipe_init_securityfs(void)
> +int __init ipe_init_securityfs(void)
>  {
>         int rc =3D 0;
>         struct ipe_policy *ap;
> @@ -243,5 +243,3 @@ static int __init ipe_init_securityfs(void)
>         securityfs_remove(root);
>         return rc;
>  }
> -
> -fs_initcall(ipe_init_securityfs);
> diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
> index 2426441181dc..71644748ed56 100644
> --- a/security/ipe/ipe.c
> +++ b/security/ipe/ipe.c
> @@ -95,4 +95,5 @@ DEFINE_LSM(ipe) =3D {
>         .id =3D &ipe_lsmid,
>         .init =3D ipe_init,
>         .blobs =3D &ipe_blobs,
> +       .initcall_fs =3D ipe_init_securityfs,
>  };
> diff --git a/security/ipe/ipe.h b/security/ipe/ipe.h
> index fb37513812dd..25cfdb8f0c20 100644
> --- a/security/ipe/ipe.h
> +++ b/security/ipe/ipe.h
> @@ -23,4 +23,6 @@ struct ipe_bdev *ipe_bdev(struct block_device *b);
>  struct ipe_inode *ipe_inode(const struct inode *inode);
>  #endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
>
> +int ipe_init_securityfs(void);
> +
>  #endif /* _IPE_H */
> --
> 2.49.0
>

I have run the ipe's testsuite and all passed.

Tested-by: Fan Wu <wufan@kernel.org>
Acked-by: Fan Wu <wufan@kernel.org>

