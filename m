Return-Path: <linux-integrity+bounces-9857-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oBTqOfoXRGqioQoAu9opvQ
	(envelope-from <linux-integrity+bounces-9857-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Jun 2026 21:24:42 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 564E46E7890
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Jun 2026 21:24:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=paul-moore.com header.s=google header.b=X5MxhvYP;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9857-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9857-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=paul-moore.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF973308BE93
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Jun 2026 19:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A213B4EAC;
	Tue, 30 Jun 2026 19:20:53 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54D6382379
	for <linux-integrity@vger.kernel.org>; Tue, 30 Jun 2026 19:20:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782847253; cv=pass; b=k4zWlyR7VLvJmyNh9IxXXBDNu5EbbI3vztHpHTVGCDz4At9D5hEryrDmUqXyKTn8c8u4EfZhXaMSRN12KS5BH2IfAUjSSLmlGe5moC+aO+AED9MsHpwzzYGLe9vvhI2cvojD/2U2VaLgcc6fdT5x2Jv7RQl9VqNDzW3P9DCodXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782847253; c=relaxed/simple;
	bh=65J+i3G6p5lcoZBTC4phByocAAxY190VmOFW7omB01o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e1siwer2mFUgMYN86RtACed3MkrtsD2C9xEwKmzhcqtkbq38OZtOs+FrhK6J+lba1EOB7xGDUB4nHNR4qPqYQIGntE2kHK4MsV+tPDDWK58pEMBttEqh97vYzU9PBlTJLbGQ84AamHK1Ko6ifslrjM5dJOneXsj58yVBAdJ23M4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=X5MxhvYP; arc=pass smtp.client-ip=209.85.216.54
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-37cab825ec9so4089533a91.1
        for <linux-integrity@vger.kernel.org>; Tue, 30 Jun 2026 12:20:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782847250; cv=none;
        d=google.com; s=arc-20260327;
        b=h5SC12VAThbBxaqt03g95fSEK9Asigpsw7ug9/dnSZG3F6MmT0hcoDzCJ06+dVBcgV
         aA1r76ym6iTxJwGXMzFUWFu3+NVVlzj1O7ndsoE0HdpWbMBxd6iF4wwJSoG+BDvJRU98
         fgft3wCLQXTcHBzGvK1126BRVr9Ph5Cf4DqneVaY9Wz8O8d86onmn9STBMbgFW+WB7k8
         mzXDOiV4t+eDlgt6voMWnbuwnLqRRRJ+GrCYxFf2KGAdnsKO/zuNEHtWAm7AciqSxmy5
         FniF31BYFUA4COZSNyieTlN4jE++fFL/DZEtJfbWai20D975kIyyvaQgjsrukDQCZnsF
         vnWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HnheX6+q3F7lhzv+8WY9jgB+q1sOgaN80kpX4FHTGh8=;
        fh=5JCVSBXPdI8BL1TDG4jhJVOYkSvUkE8XVli5JNu3hu4=;
        b=dXV1wVdvoFoqbBp3lo0va5YGPNcCgeS7WKVtRsOi4edi0sunARTO8VIex80/t6fa6Q
         ebKGR6OGyAHgAk2NGhEWXhFA2VSA5KUbOe7V8R3nDeo95rfZoFdixAofHYtR5RlOdBzX
         4TTu1GSncEqFwiZ2tuCoz9bShRU5kzkeGATq2TG5Mr8wS8adjoP8MWsPGkCkSTAwg7ky
         IPEmgTfN+gRGH/mPoTy9l4KSWpxBsV3dsU+OjTehf0KNTmlgkfCfsm5wn6YMmuJ/4JKm
         KyfaMjUudsH6w0kAVyWhTZK/zR/YJabDYYsMj11sumitci5TAfuvyzxYM34ttLIh3ySy
         csLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782847250; x=1783452050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnheX6+q3F7lhzv+8WY9jgB+q1sOgaN80kpX4FHTGh8=;
        b=X5MxhvYPRN3WA2wN8tL/ZYk9NZEiQbt3zp7jjJgltzxvrPhMcgDbMg5S+ghGO6JFrV
         O1yiHUL8HLKhu//+JGJnCXi8eneIZaFMBhsfmu5xEyywT94F+72Bu6ykex5UZwL8hC7Y
         x9DHn2EONIrEHKr+zJRocw3ZO6DRVypGamAqAhU47sT6463F2xW51r6rTRektZ8qZs58
         e7c7/MJZFGQ2SLMW7XGcoPsGAHxHtixGOMzTpbI6bkqY+TSgjJ8aoDaBdqw5170xOh/K
         C7n1uxfzAR1/ftJDft78tixUKOMmdPxBEu5FgTwR1H8tgsPowu45eEy5Gat235dRyPTg
         EeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782847250; x=1783452050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HnheX6+q3F7lhzv+8WY9jgB+q1sOgaN80kpX4FHTGh8=;
        b=bCp6ZxAFb+rz8zTaY84NBnU/XbHc7sXU8L+8J4oM3bPh76puJYNmO6pU9tc98AtSeg
         h+Z2+lQN2QRhxKcaVaBbJfyo7GsEo+yRTXW8eQOrR4enq/lcr2eknDk2OiAwNqeDoByP
         lEfmqSR+Pk5x2DlXLHQCO64nlc2iql30+BzdnNXvwVRFqoinUBd77EHo3ZA2mfb7G3RT
         rjXxe6844u9ymNmiSOVwitYyL/tC77dd0PBR48k6ANMEKkQEo4MTgGTCAZFT7+vnPM3Q
         k4yeKeiMhZYlSuYIvwdco8GyMAyeya7N9UYMfSdZEeJDoTZYw7c7dpw+XUHYDdCtYY2J
         J9iA==
X-Forwarded-Encrypted: i=1; AFNElJ+f8AWhvbU+NkT81dt6uQmcSYKW/xLpLCGEvd3L7lM6LL4ttEv5Aey1PSO4Mn9QmrCvr9NkBdyHWVt5VwxiEOs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoss0ws/penXSG2Idgk00QNaYIWwW12puOO2P1SXL3numvsdgp
	zbEgY5EK93AVTvKm/AkaIwEiPJPm09iCEkyvpGt+/XAW9/d0jMDSsgxscfAMbICny0ollhwP9W0
	AAjiZj6xZ04NMfzP34XkKD0vPC4HlUxSDxqkxRHVh
X-Gm-Gg: AfdE7claERIQRWw2Jj+CVsAny0uP+DRn5+dcOXWBA1I+HR+Z1qV2hWiHUc57O1rX+Nj
	576xWCGDMID637rsbTdyG85AI1ne0gCqCAJBKg9NPCTHZJrCyle+W6ELdfaS9TgvvCN50m8bMqU
	EzRlExeHQZEi+MfiURxZXaj3BOOyHyR5OUDM7QPCuvnIUgmFDJtX1wg2ppRkB8hRaOTWtRjZALX
	Wf4HifD5SDOFBO/BB5+5pZA4EDcDL7Ru0kfNqWuyLQo82ShMqjItPnN5IAPvoFGqqmkBVEn
X-Received: by 2002:a05:6a21:62c2:b0:3ba:cd5b:3dcd with SMTP id
 adf61e73a8af0-3bfdc69589emr1376925637.36.1782847249974; Tue, 30 Jun 2026
 12:20:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630183956.281293-1-dwindsor@gmail.com> <20260630183956.281293-3-dwindsor@gmail.com>
In-Reply-To: <20260630183956.281293-3-dwindsor@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 30 Jun 2026 15:20:36 -0400
X-Gm-Features: AVVi8CeUWBZtqtU3wWufhJ35rf7KN-O35V57TZRDwEyvAO9h530GFJE7-OayBpg
Message-ID: <CAHC9VhSYNF=_Tfe-D99rHy70EXQVr1ES0arxT09Bidey4zOFdg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/3] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: David Windsor <dwindsor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:dwindsor@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:john.fastabend@gmail.com,m:kpsingh@kernel.org,m:jolsa@kernel.org,m:memxor@gmail.com,m:emil@etsalapatis.com,m:mattbobrowski@google.com,m:jmorris@namei.org,m:serge@hallyn.com,m:casey@schaufler-ca.com,m:stephen.smalley.work@gmail.com,m:omosnace@redhat.com,m:zohar@linux.ibm.com,m:roberto.sassu@huawei.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:shuah@kernel.org,m:bpf@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,m:stephensmalleywork@gmail.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[paul@paul-moore.com,linux-integrity@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[34];
	TAGGED_FROM(0.00)[bounces-9857-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-integrity@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,etsalapatis.com,google.com,namei.org,hallyn.com,schaufler-ca.com,redhat.com,linux.ibm.com,huawei.com,oracle.com,zeniv.linux.org.uk,suse.cz,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,paul-moore.com:dkim,paul-moore.com:url,paul-moore.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kernsec.org:url,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 564E46E7890

On Tue, Jun 30, 2026 at 2:40=E2=80=AFPM David Windsor <dwindsor@gmail.com> =
wrote:
>
> Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically set
> xattrs via the inode_init_security hook using lsm_get_xattr_slot(). The
> hook now passes its xattr state as a single struct lsm_xattrs object,
> which the kfunc takes directly.
>
> The kfunc is only usable from lsm/inode_init_security programs: no other
> hook exposes a struct lsm_xattrs argument, so the verifier rejects calls
> from elsewhere. Restrict the xattr names that may be set via this kfunc
> to the bpf.* namespace.
>
> BPF reserves BPF_LSM_INODE_INIT_XATTRS slots via lbs_xattr_count, and the
> kfunc enforces that BPF never consumes more slots than it reserved,
> returning -ENOSPC once the budget is exhausted.
>
> A previous attempt [1] required a kmalloc string output protocol for
> the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all LSMs to
> provide xattrs for inode_init_security hook") [2], the xattr name is no
> longer allocated; it is a static constant.
>
> Link: https://kernsec.org/pipermail/linux-security-module-archive/2022-Oc=
tober/034878.html [1]
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D6bcdfd2cac55 [2]
> Signed-off-by: David Windsor <dwindsor@gmail.com>
> ---
>  fs/bpf_fs_kfuncs.c      | 79 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/bpf_lsm.h |  3 ++
>  kernel/bpf/bpf_lsm.c    |  1 +
>  security/bpf/hooks.c    |  1 +
>  4 files changed, 84 insertions(+)
>
> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 768aca2dc0f0..c4023c82f21e 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -10,6 +10,7 @@
>  #include <linux/fsnotify.h>
>  #include <linux/file.h>
>  #include <linux/kernfs.h>
> +#include <linux/lsm_hooks.h>
>  #include <linux/mm.h>
>  #include <linux/xattr.h>
>
> @@ -374,6 +375,83 @@ __bpf_kfunc struct inode *bpf_real_inode(struct dent=
ry *dentry)
>         return d_real_inode(dentry);
>  }
>
> +static int bpf_xattrs_used(const struct lsm_xattrs *ctx)
> +{
> +       const size_t prefix_len =3D sizeof(XATTR_BPF_LSM_SUFFIX) - 1;
> +       unsigned int i, n =3D 0;
> +
> +       for (i =3D 0; i < ctx->xattr_count; i++) {
> +               const char *name =3D ctx->xattrs[i].name;
> +
> +               if (name && !strncmp(name, XATTR_BPF_LSM_SUFFIX, prefix_l=
en))
> +                       n++;
> +       }
> +       return n;
> +}
> +
> +/**
> + * bpf_init_inode_xattr - set an xattr on a new inode from inode_init_se=
curity
> + * @xattrs: inode_init_security xattr state from the hook context
> + * @name__str: xattr name (e.g., "bpf.file_label")
> + * @value_p: dynptr containing the xattr value
> + *
> + * Only callable from lsm/inode_init_security programs.
> + *
> + * Return: 0 on success, negative error on failure.
> + */
> +__bpf_kfunc int bpf_init_inode_xattr(struct lsm_xattrs *xattrs,
> +                                    const char *name__str,
> +                                    const struct bpf_dynptr *value_p)
> +{
> +       struct bpf_dynptr_kern *value_ptr =3D (struct bpf_dynptr_kern *)v=
alue_p;
> +       size_t name_len;
> +       void *xattr_value;
> +       struct xattr *xattr;
> +       const void *value;
> +       u32 value_len;
> +
> +       if (!xattrs || !xattrs->xattrs || !name__str)
> +               return -EINVAL;
> +       if (bpf_xattrs_used(xattrs) >=3D BPF_LSM_INODE_INIT_XATTRS)
> +               return -ENOSPC;
> +
> +       name_len =3D strlen(name__str);
> +       if (name_len =3D=3D 0 || name_len > XATTR_NAME_MAX)
> +               return -EINVAL;
> +       if (strncmp(name__str, XATTR_BPF_LSM_SUFFIX,
> +                   sizeof(XATTR_BPF_LSM_SUFFIX) - 1))
> +               return -EPERM;
> +
> +       value_len =3D __bpf_dynptr_size(value_ptr);
> +       if (value_len =3D=3D 0 || value_len > XATTR_SIZE_MAX)
> +               return -EINVAL;
> +
> +       value =3D __bpf_dynptr_data(value_ptr, value_len);
> +       if (!value)
> +               return -EINVAL;
> +
> +       /* Combine xattr value + name into one allocation. */
> +       xattr_value =3D kmalloc(value_len + name_len + 1, GFP_NOFS);
> +       if (!xattr_value)
> +               return -ENOMEM;
> +
> +       memcpy(xattr_value, value, value_len);
> +       memcpy(xattr_value + value_len, name__str, name_len);
> +       ((char *)xattr_value)[value_len + name_len] =3D '\0';
> +
> +       xattr =3D lsm_get_xattr_slot(xattrs);
> +       if (!xattr) {
> +               kfree(xattr_value);
> +               return -ENOSPC;
> +       }
> +
> +       xattr->value =3D xattr_value;
> +       xattr->name =3D (const char *)xattr_value + value_len;
> +       xattr->value_len =3D value_len;
> +
> +       return 0;
> +}

This is not a generic VFS function, it is a LSM specific function, it
belongs under security/, please move the code as discussed previously.

--
paul-moore.com

