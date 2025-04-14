Return-Path: <linux-integrity+bounces-5872-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FA9A88D8A
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Apr 2025 23:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 575EA189A7F6
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Apr 2025 21:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D606F1E1E19;
	Mon, 14 Apr 2025 21:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q854v39l"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CED1DF962;
	Mon, 14 Apr 2025 21:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744664660; cv=none; b=gg0tdbUM3gnksf6A3qf6rA57YRdgpaIAQf5d61WzVWFpZS9HYRDX0QR9LAgMkyLdh8E2OjizQFLBZtllgmOJLxweGyz41+s1t6goaCvgnKykfePHsugKD5R9azSNno0ZPBlYH81NJegQeW9QEO+eMADqxGSkdzYLzKnei8/7GR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744664660; c=relaxed/simple;
	bh=/kMmR3/aCBr6gqrr9IbjWqrz3oTfnW6UJ3YNWHF6aNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QAg3ITT4xWAapcW7BF8aiRFTOj9S6n6HpHcqWti7ZhDNfzHe41QWiTUu/T4roJhrpq4iEQNzMbskox3br9CUYwQFgEBHZJuJgnhz5KfEvvxkmmrjGYriQeKNKvqYAcMI8mPdYRXR3ZLBHh1xe+kkNASmDkr1LCM5enPMJAOxLSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q854v39l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24AABC4CEE5;
	Mon, 14 Apr 2025 21:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744664660;
	bh=/kMmR3/aCBr6gqrr9IbjWqrz3oTfnW6UJ3YNWHF6aNM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=q854v39lOHRFCRldRR5okc2pYWSToevpLynlcxSzkWx+ixgvzbv11cSJTu7KX0AVm
	 D9vXue0YCPXtoxY50bLSG6udSV5nQmMj89hlKDociv5R820cNtNyKoCQyO/X72G6kX
	 L843omoegemhu9OKbFjCxlDXW4ZLUKy26kmVNyaGrocOc+coDMz/JJiKPTgpXG44Dr
	 8LwFVKlrUsqa5VeMNBAUcqhm1OpEJKpPA5/fe14JoI9cCgpE45jUXx7VtcEjp88mhl
	 aFlYgYSW1mpeCanzO9W7QfIpFhGz3SDQcnc/Rw9+Xx7iKTAfAgc6F5fEEP+EisUA8f
	 PHKxFKeimrx8A==
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e53ef7462b6so4613310276.3;
        Mon, 14 Apr 2025 14:04:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6Y4+jkyDVSoWGuBtMwMxmOojPHpNuRc2bwqaHRN2V9VEkTmkKOo50Cggjjn77cJNcBS6aTXDhWjBslMld2y0=@vger.kernel.org, AJvYcCXnkXgFeuY7QhhlxI1HbAFzq3lIF6qCcWzZexNwOfV7gmeK7vknGL87yEn0KjO2HULbYLFxOkGf0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqLtlwupm1tKGMSOp0wb4zOQCHK8v0Qm+k0qVnI5oNFBeiT9ZN
	86bHWIAYo5nZ0cGJ81cMvn8HPXTHlTX7xbo5GVM6gr4GHhSaeVOI5IJ7kFUNWDPacfHxAU99KPD
	HeUfzFO6g+78h/8CVhBNvrUKP2k8=
X-Google-Smtp-Source: AGHT+IHt4YRN2kpPHFLSp4blfMyhlknml4TGUKUN/WIObMEJdiJ6sBZcaltdRF3A1GpTp8dpeOVHfFZtVLz3TFY8+ZA=
X-Received: by 2002:a25:3f81:0:b0:e6e:1d4c:b34d with SMTP id
 3f1490d57ef6-e704deee80cmr16743790276.4.1744664659451; Mon, 14 Apr 2025
 14:04:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-51-paul@paul-moore.com>
In-Reply-To: <20250409185019.238841-51-paul@paul-moore.com>
From: Fan Wu <wufan@kernel.org>
Date: Mon, 14 Apr 2025 14:04:07 -0700
X-Gmail-Original-Message-ID: <CAKtyLkGWtiRRcxvA9vJSuwnS+bmikKpwHYOWkSYiFOToPFAt0g@mail.gmail.com>
X-Gm-Features: ATxdqUF3ZOFosRk8lZl6cthQpodOGpWi1kcGkYEBFVIm0bmEIdnTgAsfPKxXAbs
Message-ID: <CAKtyLkGWtiRRcxvA9vJSuwnS+bmikKpwHYOWkSYiFOToPFAt0g@mail.gmail.com>
Subject: Re: [RFC PATCH 20/29] smack: move initcalls to the LSM framework
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
> As the LSM framework only supports one LSM initcall callback for each
> initcall type, the init_smk_fs() and smack_nf_ip_init() functions were
> wrapped with a new function, smack_initcall() that is registered with
> the LSM framework.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/smack/smack.h           |  6 ++++++
>  security/smack/smack_lsm.c       | 16 ++++++++++++++++
>  security/smack/smack_netfilter.c |  4 +---
>  security/smack/smackfs.c         |  4 +---
>  4 files changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index bf6a6ed3946c..709e0d6cd5e1 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -275,6 +275,12 @@ struct smk_audit_info {
>  #endif
>  };
>
> +/*
> + * Initialization
> + */
> +int init_smk_fs(void);
> +int smack_nf_ip_init(void);
> +
>  /*
>   * These functions are in smack_access.c
>   */
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index e09b33fed5f0..80b129a0c92c 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -5277,6 +5277,21 @@ static __init int smack_init(void)
>         return 0;
>  }
>
> +static int smack_initcall(void)
> +{
> +       int rc, rc_tmp;
> +
> +       rc_tmp =3D init_smk_fs();
> +       if (rc_tmp)
> +               rc =3D rc_tmp;
> +
> +       rc_tmp =3D smack_nf_ip_init();
> +       if (!rc && rc_tmp)
> +               rc =3D rc_tmp;
> +
> +       return rc;
> +}
> +
>  /*
>   * Smack requires early initialization in order to label
>   * all processes and objects when they are created.
> @@ -5286,4 +5301,5 @@ DEFINE_LSM(smack) =3D {
>         .flags =3D LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
>         .blobs =3D &smack_blob_sizes,
>         .init =3D smack_init,
> +       .initcall_device =3D smack_initcall,
>  };
> diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netf=
ilter.c
> index 8fd747b3653a..17ba578b1308 100644
> --- a/security/smack/smack_netfilter.c
> +++ b/security/smack/smack_netfilter.c
> @@ -68,7 +68,7 @@ static struct pernet_operations smack_net_ops =3D {
>         .exit =3D smack_nf_unregister,
>  };
>
> -static int __init smack_nf_ip_init(void)
> +int __init smack_nf_ip_init(void)
>  {
>         if (smack_enabled =3D=3D 0)
>                 return 0;
> @@ -76,5 +76,3 @@ static int __init smack_nf_ip_init(void)
>         printk(KERN_DEBUG "Smack: Registering netfilter hooks\n");
>         return register_pernet_subsys(&smack_net_ops);
>  }
> -
> -__initcall(smack_nf_ip_init);
> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index 90a67e410808..d33dd0368807 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -2980,7 +2980,7 @@ static struct vfsmount *smackfs_mount;
>   * Returns true if we were not chosen on boot or if
>   * we were chosen and filesystem registration succeeded.
>   */
> -static int __init init_smk_fs(void)
> +int __init init_smk_fs(void)
>  {
>         int err;
>         int rc;
> @@ -3023,5 +3023,3 @@ static int __init init_smk_fs(void)
>
>         return err;
>  }
> -
> -__initcall(init_smk_fs);
> --
> 2.49.0
>

I'm getting the following WARNING:

WARNING: modpost: vmlinux: section mismatch in reference:
smack_initcall+0xb (section: .text) -> init_smk_fs (section:
.init.text)
WARNING: modpost: vmlinux: section mismatch in reference:
smack_initcall+0x16 (section: .text) -> smack_nf_ip_init (section:
.init.text)
WARNING: modpost: vmlinux: section mismatch in reference:
smack_initcall+0x27 (section: .text) -> smack_nf_ip_init (section:
.init.text)

I guess "__init" is missed for smack_initcall?

-Fan

