Return-Path: <linux-integrity+bounces-7007-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B56B42AF4
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Sep 2025 22:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B7D41899127
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Sep 2025 20:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF472D7DDC;
	Wed,  3 Sep 2025 20:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FpdG7/vk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8EB2C18A
	for <linux-integrity@vger.kernel.org>; Wed,  3 Sep 2025 20:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756931540; cv=none; b=M7wfu7OWUt4jflp0sKZg6MqOiBAE+oTRTvgBOhGMXWMgdNacS4lQEQ0TwiHj9BlrsoPHycEazjYk36IawCEt1RHaHoFMa/clkxfjOjks0d/bZWL6GDrrfYue89BIQr3clfHYrxE0FMNCu5MJvFFe+wwgqbhgTdkYQiW/YenM75M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756931540; c=relaxed/simple;
	bh=JUqQcth+48yfR5IRsTgNIhgR29SjLMaLxedyYS8m8CQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kNW8f5zV+WCEYStFGPMOnS5WEUmDWBNTveSaD+aKlknPbC9498h8UsJjB3D0CpaZJ+xj6uuChkgQRfQL6K7uj86awZMDCRWuI/7TUs8KgN2knpWlgqEpM9n7hg5n+1YBSlZ02S3F69PVbyiuCu9G///sfiGjbO+Y26mwY+fu4I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FpdG7/vk; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-327ceef65afso285168a91.0
        for <linux-integrity@vger.kernel.org>; Wed, 03 Sep 2025 13:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756931538; x=1757536338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJ5BuvO47PQ9ewZ74GpkgcMd6NO4tOTKv4Zu027LJSk=;
        b=FpdG7/vkPJMDuRMoiyqqOtBKQA9SZW1OxJAtE1GdU0vLThwnowuKC/8CtZHGqPBsLS
         t4lvf98l7b09+9vZhwGme0okqRdsoqWQqpnkbidWzTQZpWEyxii9RSDTlHxASRB9/rL0
         8U+GcYLZK+68QwJymxDV2eRSmNRgaLjjQsqeZdbGgoiA9vTnSxAl5ZOSarIm5fxobgjm
         iNMHOy12Hj8oHOHMX476MAIiRA88HmdbjsTD5fH8R0Blu66wMX52SSIPoChdsjrywg04
         dmSmlVGn1AflS50XjrTt/vLJmD/mwKny3km76YWtdMrQFw8y4t8pyhIxu+oTmZBg3WVB
         tPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756931538; x=1757536338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJ5BuvO47PQ9ewZ74GpkgcMd6NO4tOTKv4Zu027LJSk=;
        b=vSIftIPRDS3oWymJHhIxg6jbODBuuBAuN6o5kIT7Toa1UJKiEkiibDALSub0clknnm
         3xBe9er2F3HL38sdjhtmVuPujz+EXzekHxhKVzJXd7S+tYMtHSw38pqO7n/1K6eWPhZZ
         Y3DwWGjnL4ENUWlWbrnx+8xBi41ZSc986emyNo9jaOQTKyEDU1cVti/6VGiQzVlt6KA4
         aMec5z2ZQcTgeGyNmh99WGxKObOLTt/KKlobWcbKIiZY2rtClZFmj9yoFMsxmzl/wkgV
         AI0svGVbuC0/8JCqyrhjwvLigYvDxJzn1shTXJdh+jDPYu4RVpk3kNDR9vdMA6wNCSzD
         CPoA==
X-Forwarded-Encrypted: i=1; AJvYcCVqCs+ZiZpZWSX51RgXdDpmyM8WxypX92VfEH1o6HxSjPKThiA6qWo4+qTSSDOEpHqnHEr0WiEEAuIOWfuPpqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnvj6MbTlY15pM621VMVdoK/MhExHE3ryRuxiQ8+e3Q7yAEKDo
	z14AmwxdRkzNOXGSa4FvKDTu8q9+AamNPD3HC/53mBLRGWfdrJBgzw8KO0YyDIAWy8pER+uFmj3
	V13LJIriP9XZHLIjHP7Lf00fAccKB1D4hbnVuaRW/
X-Gm-Gg: ASbGncv1V0dfBt8GM8RbtwpYB0lLD4bgAlnYgzztKGJnYZZhAciWMVDKxP+qDCBVRS8
	NpfAAyqsuxSCg3WcAB8y3GwR5rD1VXEjaoLXeiFFl/YuDbmjbdKFyVXw36pnfenjBq3wF8McvtG
	yDiTWUVLetcV2QmW7uzZYQ34/nMMg/23rq/FRye/lZA3+5R2fJPz1CSt/q6MQq++SCO9AjCUZ5W
	6ipgyk=
X-Google-Smtp-Source: AGHT+IHWOotiu9t3J3R4HLk+zVm85x2J3ZLURGCvKo08zpnUTB2Nq7s2ZiHCnKKIbSxlGxWk4FiAQSQ6hXeX5qsrKUQ=
X-Received: by 2002:a17:90b:5865:b0:328:a89:3dc8 with SMTP id
 98e67ed59e1d1-3281543cc5emr21520105a91.14.1756931538487; Wed, 03 Sep 2025
 13:32:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814225159.275901-36-paul@paul-moore.com> <20250814225159.275901-63-paul@paul-moore.com>
In-Reply-To: <20250814225159.275901-63-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 3 Sep 2025 16:32:06 -0400
X-Gm-Features: Ac12FXyNJitgpL2yinQCFeDyrkKRUyO_0xYJ9X1mCNjeHnVb6sYzdHeJtz7l_1U
Message-ID: <CAHC9VhSf=zo0BkTc_=Qqq59OMVHsMUs_OqcmSUK501LYpAdMYg@mail.gmail.com>
Subject: Re: [PATCH v3 27/34] tomoyo: move initcalls to the LSM framework
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-security-module@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 6:54=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Reviewed-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/tomoyo/common.h        | 2 ++
>  security/tomoyo/securityfs_if.c | 4 +---
>  security/tomoyo/tomoyo.c        | 1 +
>  3 files changed, 4 insertions(+), 3 deletions(-)

Tetsuo, does this look okay to you?

> diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
> index 0e8e2e959aef..3b2a97d10a5d 100644
> --- a/security/tomoyo/common.h
> +++ b/security/tomoyo/common.h
> @@ -924,6 +924,8 @@ struct tomoyo_task {
>
>  /********** Function prototypes. **********/
>
> +int tomoyo_interface_init(void);
> +
>  bool tomoyo_address_matches_group(const bool is_ipv6, const __be32 *addr=
ess,
>                                   const struct tomoyo_group *group);
>  bool tomoyo_compare_number_union(const unsigned long value,
> diff --git a/security/tomoyo/securityfs_if.c b/security/tomoyo/securityfs=
_if.c
> index 7e69747b2f77..33933645f5b9 100644
> --- a/security/tomoyo/securityfs_if.c
> +++ b/security/tomoyo/securityfs_if.c
> @@ -233,7 +233,7 @@ static void __init tomoyo_create_entry(const char *na=
me, const umode_t mode,
>   *
>   * Returns 0.
>   */
> -static int __init tomoyo_interface_init(void)
> +int __init tomoyo_interface_init(void)
>  {
>         struct tomoyo_domain_info *domain;
>         struct dentry *tomoyo_dir;
> @@ -269,5 +269,3 @@ static int __init tomoyo_interface_init(void)
>         tomoyo_load_builtin_policy();
>         return 0;
>  }
> -
> -fs_initcall(tomoyo_interface_init);
> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> index ed0f7b052a85..a015cf0c4a00 100644
> --- a/security/tomoyo/tomoyo.c
> +++ b/security/tomoyo/tomoyo.c
> @@ -617,4 +617,5 @@ DEFINE_LSM(tomoyo) =3D {
>         .flags =3D LSM_FLAG_LEGACY_MAJOR,
>         .blobs =3D &tomoyo_blob_sizes,
>         .init =3D tomoyo_init,
> +       .initcall_fs =3D tomoyo_interface_init,
>  };
> --
> 2.50.1

--=20
paul-moore.com

