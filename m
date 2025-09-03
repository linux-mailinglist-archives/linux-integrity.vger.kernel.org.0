Return-Path: <linux-integrity+bounces-7008-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E96B42B07
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Sep 2025 22:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 295A63AAD11
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Sep 2025 20:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C222DECBF;
	Wed,  3 Sep 2025 20:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="L7Pkqrzi"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E127E2C3770
	for <linux-integrity@vger.kernel.org>; Wed,  3 Sep 2025 20:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756931665; cv=none; b=slV3I6/cKunBabmbNl2kkwkhS6HZ/H0BzQErdW8BsTjswPhfCpWnEtjPjxGFcO7Qpbz6qK3582PcJ4qzUWKeICjEcUbpmDVXYUu4oc5Wn2ELpoH1TuRGHC8g+1K0Gd6gDYcgmcF+14nUIcca0PEiQpwDXWbAQrxt0ZMBliExd+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756931665; c=relaxed/simple;
	bh=2dJ4wVZWHR6SNDFqVHMH20qiCxmtcCXamo4FZ9w5AwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VvKxxP6Q83Wm14+TZilCvc8ia5EXwa1GrN17fB7r1Q7xkTXBEcWa75VUby+jRzcJIobrT6ADz/C6RXsBCMUIANMVXhu/mMgno/OHiSLqSHL9rnYRvExOtqzynwrNFMeb+krCc7LKKP5Ei40/qfKRkD9muNDNq0Ld3QAS3VeoYqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=L7Pkqrzi; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-321cfa7ad29so1168999a91.1
        for <linux-integrity@vger.kernel.org>; Wed, 03 Sep 2025 13:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756931663; x=1757536463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKuS2L0/vmX3rxAXLNvWCNOXpsnJOZVVR4o3kLtMnfY=;
        b=L7PkqrziBPflkgatgylXdKBUQ4upULh1sJIJwT+CTf6WFsEueeAaCaUsgOBtgGzsUY
         srTB30Ic0fuvP+F4H7HsRgiwcFhjCdBqd3I3QtOmn6bPbDmgg1piWf5PbJPGuxgY2hhz
         n5yRxhtcCr25+q+toruUvTyFwOajGV6Fwt4LjcTJT0xhLgZyAWTxITZel5SXPyeaR7oS
         EefvmH0Anzo+q1+nUfVlfv0Ldt3CZFm9Zwh3LU5rCUmE5cwK8k6pLSFC2hNmotMpV7Pg
         WUXhcp3FMStuNmQ3lrg9dffrAbYsaHAs2FhEi6eyCT6TmdMHo58gStBIp7yVdClib6w4
         4h4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756931663; x=1757536463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OKuS2L0/vmX3rxAXLNvWCNOXpsnJOZVVR4o3kLtMnfY=;
        b=n2sYjA2UhGglr/uP84GEV77IFVnwN+8+1w0uvolxJIzScVDFNAe8noqWxlVgSZqWx/
         MtoPpDQMVWIbyrrJFBegLC/BszIudHPt16KbQIZHRDDkJbKD0t4EX975CaijKeid/VKr
         Z9Iyn3cyR+NVQf5xyIUNwy/d9xiJfjtUuVg6Nb5+eDz+b/fTVVFxMCDp6NRb+KXSZgDc
         wNKpToW5EeviT2U6kmIOfpscugrpXvuY03Frcw1tFqWv8TUaJCPxy1xqsBm8Z/FOVD1h
         c8Z3C2QC9rfqmgdqGRkwCspPY785E6S/VuM6+tKLAlcARECnY7fht516ga3Cu1+WtAtD
         Sd9g==
X-Forwarded-Encrypted: i=1; AJvYcCVcAolUJ7DFLKh2TD01HnYREhE0s2hk18vxbxJVZAIHUFnhjTV48hEpxq2+kpryyNkBDhHKJSoFt8NeGsOth5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAKqXrFh3oxmUcTA4IZrYKi62PGBsa6zzuzYBjZzctJZl5NKtK
	OT2Tvit8XAKwn6mnyv9f4KGrnHNKqNrWO4UL2ewbqu7dCwCBzReOq9LyBfmv+TlwPBYrw50gREJ
	OoA6T7fWBeEc6yircRe8TBJDXBIXlcif6erhAC+nG
X-Gm-Gg: ASbGncuKhCHuuT4TRSYeSOzlbajXFdllG1t4uyQx8GdkNr/syCGG99Gtw8r/DjSFsBp
	xeQV2TZQaepD3SAyXBT499iyOR7nJZUORdygEBxifx0gckq1XFpVhmQ11jnVL6GiBjZxUWu+qR6
	x7HuZmu37xbW67fXzdznEln02kI2ixRtAOfMg2JCHFWMiVBlwJQR7OfaD1xgAVAaeqrJkHDH+kf
	URgNiGJ5HO7TVpS2g==
X-Google-Smtp-Source: AGHT+IEFLg1wpJq5pyU1LGh4Wr6CPwyupsyNccgShcQvryln1Jz7AGVyZxhEQWAvcBic6u01hJcW8/G4oGrprGeNYvA=
X-Received: by 2002:a17:90b:42:b0:32b:94a2:b0c4 with SMTP id
 98e67ed59e1d1-32b94a2b115mr96135a91.16.1756931663039; Wed, 03 Sep 2025
 13:34:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814225159.275901-36-paul@paul-moore.com> <20250814225159.275901-65-paul@paul-moore.com>
In-Reply-To: <20250814225159.275901-65-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 3 Sep 2025 16:34:11 -0400
X-Gm-Features: Ac12FXz345nbIqqkWqKXBOb42bIq1XutdnzyZsarLlogck_vQlNUOoEFFMA51pw
Message-ID: <CAHC9VhRwHLaWP-qUCEVC7-6hEWf0K1H9DwbxWMW9c3a5uUF94w@mail.gmail.com>
Subject: Re: [PATCH v3 29/34] apparmor: move initcalls to the LSM framework
To: John Johansen <john.johansen@canonical.com>
Cc: selinux@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 6:54=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Reviewed-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/apparmor/apparmorfs.c         | 4 +---
>  security/apparmor/crypto.c             | 3 +--
>  security/apparmor/include/apparmorfs.h | 2 ++
>  security/apparmor/include/crypto.h     | 1 +
>  security/apparmor/lsm.c                | 9 ++++++++-
>  5 files changed, 13 insertions(+), 6 deletions(-)

Thanks for reviewing all the other patches John.  Assuming you are
okay with this patch, can I get an ACK?

> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorf=
s.c
> index 391a586d0557..ee04c1ac9d6e 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -2649,7 +2649,7 @@ static const struct inode_operations policy_link_io=
ps =3D {
>   *
>   * Returns: error on failure
>   */
> -static int __init aa_create_aafs(void)
> +int __init aa_create_aafs(void)
>  {
>         struct dentry *dent;
>         int error;
> @@ -2728,5 +2728,3 @@ static int __init aa_create_aafs(void)
>         AA_ERROR("Error creating AppArmor securityfs\n");
>         return error;
>  }
> -
> -fs_initcall(aa_create_aafs);
> diff --git a/security/apparmor/crypto.c b/security/apparmor/crypto.c
> index 227d47c14907..d8a7bde94d79 100644
> --- a/security/apparmor/crypto.c
> +++ b/security/apparmor/crypto.c
> @@ -53,10 +53,9 @@ int aa_calc_profile_hash(struct aa_profile *profile, u=
32 version, void *start,
>         return 0;
>  }
>
> -static int __init init_profile_hash(void)
> +int __init init_profile_hash(void)
>  {
>         if (apparmor_initialized)
>                 aa_info_message("AppArmor sha256 policy hashing enabled")=
;
>         return 0;
>  }
> -late_initcall(init_profile_hash);
> diff --git a/security/apparmor/include/apparmorfs.h b/security/apparmor/i=
nclude/apparmorfs.h
> index 1e94904f68d9..dd580594dfb7 100644
> --- a/security/apparmor/include/apparmorfs.h
> +++ b/security/apparmor/include/apparmorfs.h
> @@ -104,6 +104,8 @@ enum aafs_prof_type {
>  #define prof_dir(X) ((X)->dents[AAFS_PROF_DIR])
>  #define prof_child_dir(X) ((X)->dents[AAFS_PROF_PROFS])
>
> +int aa_create_aafs(void);
> +
>  void __aa_bump_ns_revision(struct aa_ns *ns);
>  void __aafs_profile_rmdir(struct aa_profile *profile);
>  void __aafs_profile_migrate_dents(struct aa_profile *old,
> diff --git a/security/apparmor/include/crypto.h b/security/apparmor/inclu=
de/crypto.h
> index 636a04e20d91..f3ffd388cc58 100644
> --- a/security/apparmor/include/crypto.h
> +++ b/security/apparmor/include/crypto.h
> @@ -13,6 +13,7 @@
>  #include "policy.h"
>
>  #ifdef CONFIG_SECURITY_APPARMOR_HASH
> +int init_profile_hash(void);
>  unsigned int aa_hash_size(void);
>  char *aa_calc_hash(void *data, size_t len);
>  int aa_calc_profile_hash(struct aa_profile *profile, u32 version, void *=
start,
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 45b3a304d525..647c13e13e63 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -32,6 +32,7 @@
>  #include "include/audit.h"
>  #include "include/capability.h"
>  #include "include/cred.h"
> +#include "include/crypto.h"
>  #include "include/file.h"
>  #include "include/ipc.h"
>  #include "include/net.h"
> @@ -2426,7 +2427,6 @@ static int __init apparmor_nf_ip_init(void)
>
>         return 0;
>  }
> -__initcall(apparmor_nf_ip_init);
>  #endif
>
>  static char nulldfa_src[] __aligned(8) =3D {
> @@ -2557,4 +2557,11 @@ DEFINE_LSM(apparmor) =3D {
>         .enabled =3D &apparmor_enabled,
>         .blobs =3D &apparmor_blob_sizes,
>         .init =3D apparmor_init,
> +       .initcall_fs =3D aa_create_aafs,
> +#if defined(CONFIG_NETFILTER) && defined(CONFIG_NETWORK_SECMARK)
> +       .initcall_device =3D apparmor_nf_ip_init,
> +#endif
> +#ifdef CONFIG_SECURITY_APPARMOR_HASH
> +       .initcall_late =3D init_profile_hash,
> +#endif
>  };
> --
> 2.50.1

--=20
paul-moore.com

