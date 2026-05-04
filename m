Return-Path: <linux-integrity+bounces-9417-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHP2LEYS+Wmz5AIAu9opvQ
	(envelope-from <linux-integrity+bounces-9417-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 04 May 2026 23:40:22 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8264C42AB
	for <lists+linux-integrity@lfdr.de>; Mon, 04 May 2026 23:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B30B30160C6
	for <lists+linux-integrity@lfdr.de>; Mon,  4 May 2026 21:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C785361DC0;
	Mon,  4 May 2026 21:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GInbEMaN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1882B3603E1
	for <linux-integrity@vger.kernel.org>; Mon,  4 May 2026 21:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777930818; cv=none; b=UlIcEUKyHQL2uggYmoUJbxwlzEoDzY665VFlJOTFoWeqUs9jLA5DL+qF0RJKHuQEyIEXMLSKgTpV1f8BK1W3SBZjcRafIiR976MHoFs2QkcdWFjboDxxAUtEAPszuMsowt+XdKmbdCHxC2T2wzG7Gw5jqU6etj49LliZNEit/qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777930818; c=relaxed/simple;
	bh=Y50nOL3Ll7Oblxb0C4m3AvGvJOmWeDTR/15bG4Rwt+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5avd8v8ZKjmRWe+9z2lxXp3ERh+RvFy77VW6vniuCSDXMmBw5kTXZG13tVmQGwNZ69t+kG4Mo5jJ6G+MTvhq5inTTJk9aoD5+JTFcuZpAaExkqGLHsP+gokAv8NabIEyckUbUwb/JKwQTQcvOQvZKXjCiuqjSjgyXMxV0+4z0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GInbEMaN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22FAC2BD04
	for <linux-integrity@vger.kernel.org>; Mon,  4 May 2026 21:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777930817;
	bh=Y50nOL3Ll7Oblxb0C4m3AvGvJOmWeDTR/15bG4Rwt+8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GInbEMaNBddNYam4nEQhGN9wFDIVXpZOLXn7Eo6EYf33iaZxZr9lh6pefmy7ZZsh0
	 NV9Ln8cVNWOFmS1TVfuEoLpSxV32594TyHxKW7df7UblgAdDt9Va9i54iSZkNrlfbV
	 Lqzo9fWkmQoEvP4IaZ7RSsQbFSUD7pGOVWXfmXlvroS9Ev0Me7ITDD1HO1j68Ja/8L
	 2AmOgp84Q2fnoic5JcAZYjCqIWFlxNw4nDdKLAPVNG0g+dLLfHC91dm/QQ0oda5evR
	 6qePQHil8ubYNqCSR6JM0reNjME6b+BUO1uBjhI5n8S/qZ3M7TeDqvoEVrUBfyRf9N
	 U/oLzIeNNxTVQ==
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8a4b8c3a30bso48064966d6.3
        for <linux-integrity@vger.kernel.org>; Mon, 04 May 2026 14:40:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+Wf+I7wvelMwbq8f+AD/vudIvKvWu23WjXVh5HMxBZnL0tpMX8b66R3hzNMIv2SbeyUqreFfcZGoAT3mEE4zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIDz3yc2EFFwzIt/mbvg5WOMMLQ4P8tNZk+iErEh1KG19WtC5f
	PRQiCp9cN/NV+LNPbdtjaPQx9Eg5ro2CAsy4CrU0VskjpByIvORK4nrAC68LL6V7b6GZHu9Krqh
	rXgQLR1vtALSIuw4ySvUZlufQHgHVW+o=
X-Received: by 2002:a05:6214:3d85:b0:8ac:a57e:ec1f with SMTP id
 6a1803df08f44-8b6682578c9mr199893326d6.29.1777930816774; Mon, 04 May 2026
 14:40:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503211835.16103-1-dwindsor@gmail.com> <20260503211835.16103-2-dwindsor@gmail.com>
 <CAHC9VhSy5K5nQTtFUE4BScy1Ur61v7eZW067vTcUYDQeJb13Bw@mail.gmail.com>
In-Reply-To: <CAHC9VhSy5K5nQTtFUE4BScy1Ur61v7eZW067vTcUYDQeJb13Bw@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Mon, 4 May 2026 23:40:04 +0200
X-Gmail-Original-Message-ID: <CAPhsuW6sy2cdC4B7Z48-5A-yVX6fmVWxS_fWVjQxiX95KeUguw@mail.gmail.com>
X-Gm-Features: AVHnY4J0bS_HHPQgD6P5PhrQ2PHNLPsmkZlDK5-_kikrw0qSIAQXpt5kgUuK21Y
Message-ID: <CAPhsuW6sy2cdC4B7Z48-5A-yVX6fmVWxS_fWVjQxiX95KeUguw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: Paul Moore <paul@paul-moore.com>
Cc: David Windsor <dwindsor@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Jan Kara <jack@suse.cz>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2D8264C42AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9417-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,zeniv.linux.org.uk,kernel.org,iogearbox.net,google.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,schaufler-ca.com,suse.cz,linux.dev,oracle.com,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[song@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Mon, May 4, 2026 at 10:14=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
[...]
> > diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> > index 9d27be058494..193accc00796 100644
> > --- a/fs/bpf_fs_kfuncs.c
> > +++ b/fs/bpf_fs_kfuncs.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/fsnotify.h>
> >  #include <linux/file.h>
> >  #include <linux/kernfs.h>
> > +#include <linux/lsm_hooks.h>
> >  #include <linux/mm.h>
> >  #include <linux/xattr.h>
> >
> > @@ -353,6 +354,97 @@ __bpf_kfunc int bpf_cgroup_read_xattr(struct cgrou=
p *cgroup, const char *name__s
> >  }
> >  #endif /* CONFIG_CGROUPS */
> >
> > +static int bpf_xattrs_used(const struct lsm_xattr_ctx *ctx)
> > +{
> > +       const size_t prefix_len =3D sizeof(XATTR_BPF_LSM_SUFFIX) - 1;
> > +       int i, n =3D 0;
> > +
> > +       for (i =3D 0; i < *ctx->xattr_count; i++) {
> > +               const char *name =3D ctx->xattrs[i].name;
> > +
> > +               if (name && !strncmp(name, XATTR_BPF_LSM_SUFFIX, prefix=
_len))
> > +                       n++;
> > +       }
> > +       return n;
> > +}
[...]
> > +
> >  static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc=
_id)
> >  {
> >         if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
> > -           prog->type =3D=3D BPF_PROG_TYPE_LSM)
> > +           prog->type =3D=3D BPF_PROG_TYPE_LSM) {
> > +               /* bpf_init_inode_xattr only attaches to inode_init_sec=
urity. */
> > +               if (kfunc_id =3D=3D bpf_init_inode_xattr_btf_ids[0] &&
> > +                   prog->aux->attach_btf_id !=3D bpf_lsm_inode_init_se=
curity_btf_ids[0])
> > +                       return -EACCES;

We need to mark bpf_init_inode_xattr with KF_RCU (requires a trusted
pointer), then we can remove this check above.

> >                 return 0;
> > +       }
> >         return -EACCES;
> >  }
>
> Perhaps I'm simply not seeing it, but is there a check to ensure that
> there is only one BPF LSM calling into security_inode_init_security()
> at any given time?  With the BPF LSM only reserving a single xattr
> slot, multiple loaded BPF LSM programs providing
> security_inode_init_security() callbacks will be a problem.

I don't think there is such a check. Also, a single BPF LSM function
may call the kfunc multiple times, which is also problematic.

I think we will need to make the default bigger, and also introduce
some realloc mechanism for the worst case scenario. This should
work, but the code might be a bit messy.

Thanks,
Song

>
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index 41d7367cf403..a2fc72e63ada 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -68,6 +68,11 @@ struct watch;
> >  struct watch_notification;
> >  struct lsm_ctx;
> >
[...]

