Return-Path: <linux-integrity+bounces-5778-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A736EA84A44
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 18:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1478E9A2BBF
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 16:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BA01EF365;
	Thu, 10 Apr 2025 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJIRTuHz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845091E8323;
	Thu, 10 Apr 2025 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744302799; cv=none; b=J45OyrOMyIWvWFulX2XwzpKvxlMi3jVFr1TqgQE/wg5LzXkf9tlDq/K9NZvB0YDNmwT3AOkdJKvs0InaLTPC+hVMj6mqm+fFrcQpm9J6dv4dIqPn2i8RONTzeW3yRzXCFHFNR/2BlJZo6n0ay8XhkPDb81TGh9HpD34oZ50yC9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744302799; c=relaxed/simple;
	bh=eoyCJgYzXs55oTDvNvlV65c/RZBE0TfItpeF8wlwoQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ScVt3aYPVoXI+D5++l6EmQjLTiCopkUNnXpBF6GBMAqeWk/D3O0SLCuYYq39h8mg4iYGj+AOrAMF8Xsb1V1K7lSRHTp2zgrcxWD6EckjwF5bRPhxqP2KF7bxQ5j/ePhXf2TMLO0MwDNkioqKXEMgWLfqoHLW9fpyXzh1fN/HT6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJIRTuHz; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-301302a328bso1038950a91.2;
        Thu, 10 Apr 2025 09:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744302797; x=1744907597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34F/kgXd/VopcAJElGms+ODL4mZ9pERk02sgiuSKvtI=;
        b=OJIRTuHznHvP91hb8z3WXTKbvMfCTT/OkaBiAFryHMhniyINtU0cqp+XFuobwW2b1U
         d5yWEz5VZRS1+n9npyitoLf6d8XsviWSBoDeRTyyCSbTglwJs0S03UTfsFIRjgRGMG0K
         E/YxTBdRff7liZ9OYZ8cBmRdNFRu0nRJKycdX2F7D1Ga9xDP1SsDTLNQIo/9YfPLP4+J
         jtis/6065K3GX1cNZ8mwGjwo76b3q7uN3t/sxcETISuO9sI06BWtp/nU/eeRtGxyBiCJ
         cTV1hlfl+tZxQyBmiqJl1sG92fFO3SXaFP4FjqbZ4n41HDGt1u/Au/7vOLoQgcv1orOI
         k9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744302797; x=1744907597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=34F/kgXd/VopcAJElGms+ODL4mZ9pERk02sgiuSKvtI=;
        b=AEBDgKlbQmghiupdgM2A9cbi/mlZFArWYb2eFkkZh2dO+39L4LxXArfN42L/vqaoc1
         3TaKYTbSByASaDaoE37kTJ9B24Qb8cUP7QiSo4q0TxRHI4FGzjRfADj5dbKWKOuujMtB
         IJWhgDMheHHQ8OzF0mJ1oy3ChpaeMoxZ74nkVzfeylVTtKJ8YuAlf67lwxhx5GPS4tSO
         d6g8BHbo1Lp9rxio6acErzBk+b6MTh2v1oj+1dA79cF+PyYmpzP5hC/TsRA+GY2qdCjS
         gSIpbDaBhPxlGQDTZBjcnikkKTq4bFYxWEz8u4TRsogAWt+Dyig1CbeF6rQGFMi/O08s
         YSSA==
X-Forwarded-Encrypted: i=1; AJvYcCVGgRqm46RCVGAxVqvfQ/toNFuK3KPCI0Ksjg6Qqkl99eMHFLDpjPDK7As5SZrykdUG99sKyAA2Ag==@vger.kernel.org, AJvYcCW1nmgcreTLpzQrLER29p8pZ2fvRGKJ8O9l3K3jZfuv4+QMylcyogj9MVVpyatwZwCbyw3AHOeJuOheySVdTPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNyEqXdxv1bkyZKm4HD2ovTZUs+tJJNh8UDY+w8IMH8Y29VBeF
	PNVXsDcscQvPMjsbNNzdFdeNVfIIkQKEvGQFY309LJK29lLHGa5QX4XykC/N5TIoHSX4oQ2XT6v
	y1GIvK067ttyoRclpBCfZVd8w+BKNERpj
X-Gm-Gg: ASbGncsZAMFSWj7PBRogsvjg0GqshjxhpcK4vDwl+1DLN5L+/2B3Z5JWFlPj8Rhd5FL
	xB5vdrEgTEFUqW0zy8dEGEnOGLPAGwEBMrtcaFqEf/sfx22qMmYgxEWZy1umd4Aiv6VbR+47WzC
	oYXrNXJl0AYuNIVjCSzLs/rE6Qd0rirR+x
X-Google-Smtp-Source: AGHT+IHYTYQpiCYWMK4DrGiCOA7v1195t7O8LBzxl0z4v6ArS+MbrlheXmr7UYW4yKvKhIfo+88rmbBczXP88poKQ3g=
X-Received: by 2002:a17:90b:2dc3:b0:2ff:69d4:6fe2 with SMTP id
 98e67ed59e1d1-307e5997dcemr5622467a91.16.1744302796620; Thu, 10 Apr 2025
 09:33:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-57-paul@paul-moore.com>
In-Reply-To: <20250409185019.238841-57-paul@paul-moore.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 10 Apr 2025 12:33:05 -0400
X-Gm-Features: ATxdqUGLKksXnfWLdkNxXvoOS2PL9wC28ArNVC-UWoB1nIM1nbkZYiIR5jZv6tU
Message-ID: <CAEjxPJ6ZUXoMzKPE6iwQpvG-_SruVr+kxU-a+nQXU=ToVr8wgA@mail.gmail.com>
Subject: Re: [RFC PATCH 26/29] selinux: move initcalls to the LSM framework
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

On Wed, Apr 9, 2025 at 2:55=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> SELinux currently has a number of initcalls so we've created a new
> function, selinux_initcall(), which wraps all of these initcalls so
> that we have a single initcall function that can be registered with the
> LSM framework.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---

> diff --git a/security/selinux/include/audit.h b/security/selinux/include/=
audit.h
> index d5b0425055e4..5989f8dd1e86 100644
> --- a/security/selinux/include/audit.h
> +++ b/security/selinux/include/audit.h
> @@ -15,6 +15,11 @@
>  #include <linux/audit.h>
>  #include <linux/types.h>
>
> +/**
> + * XXX
> + */

Assuming this will be fixed before merge.

> +int selinux_audit_rule_avc_callback(u32 event);
> +
>  /**
>   * selinux_audit_rule_init - alloc/init an selinux audit rule structure.
>   * @field: the field this rule refers to
> diff --git a/security/selinux/include/initcalls.h b/security/selinux/incl=
ude/initcalls.h
> new file mode 100644
> index 000000000000..6674cf489473
> --- /dev/null
> +++ b/security/selinux/include/initcalls.h
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SELinux initcalls
> + */
> +
> +#ifndef _SELINUX_INITCALLS_H
> +#define _SELINUX_INITCALLS_H
> +
> +int init_sel_fs(void);
> +int sel_netport_init(void);
> +int sel_netnode_init(void);
> +int sel_netif_init(void);
> +int sel_netlink_init(void);
> +int sel_ib_pkey_init(void);
> +int selinux_nf_ip_init(void);

The last two only exist if certain Kconfig options are set.

> +
> +int selinux_initcall(void);
> +
> +#endif
> diff --git a/security/selinux/initcalls.c b/security/selinux/initcalls.c
> new file mode 100644
> index 000000000000..81f01f8ad215
> --- /dev/null
> +++ b/security/selinux/initcalls.c
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SELinux initcalls
> + */
> +
> +#include <linux/init.h>
> +
> +#include "initcalls.h"
> +
> +/**
> + * selinux_initcall - Perform the SELinux initcalls
> + *
> + * Used as a device initcall in the SELinux LSM definition.
> + */
> +int __init selinux_initcall(void)
> +{
> +       int rc =3D 0, rc_tmp =3D 0;
> +
> +       rc_tmp =3D init_sel_fs();
> +       if (!rc && rc_tmp)
> +               rc =3D rc_tmp;
> +
> +       rc_tmp =3D sel_netport_init();
> +       if (!rc && rc_tmp)
> +               rc =3D rc_tmp;
> +
> +       rc_tmp =3D sel_netnode_init();
> +       if (!rc && rc_tmp)
> +               rc =3D rc_tmp;
> +
> +       rc_tmp =3D sel_netif_init();
> +       if (!rc && rc_tmp)
> +               rc =3D rc_tmp;
> +
> +       rc_tmp =3D sel_netlink_init();
> +       if (!rc && rc_tmp)
> +               rc =3D rc_tmp;
> +
> +       rc_tmp =3D sel_ib_pkey_init();

This one depends on CONFIG_SECURITY_INFINIBAND.

> +       if (!rc && rc_tmp)
> +               rc =3D rc_tmp;
> +
> +#if defined(CONFIG_NETFILTER)
> +       rc_tmp =3D selinux_nf_ip_init();
> +       if (!rc && rc_tmp)
> +               rc =3D rc_tmp;
> +#endif
> +
> +       return rc;
> +}

