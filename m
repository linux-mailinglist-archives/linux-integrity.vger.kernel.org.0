Return-Path: <linux-integrity+bounces-9830-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N8GjLL9KPGr+mAgAu9opvQ
	(envelope-from <linux-integrity+bounces-9830-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jun 2026 23:23:11 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 440986C1700
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jun 2026 23:23:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=raltZR9i;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9830-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9830-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4ABD7300998B
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jun 2026 21:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8A03E5EF2;
	Wed, 24 Jun 2026 21:23:09 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7BC3E5EE5
	for <linux-integrity@vger.kernel.org>; Wed, 24 Jun 2026 21:23:07 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782336189; cv=pass; b=r1DZggq84Y+2GnE0z/I21rLEA08HRXpXhphJ8R0NClgShYpPjbWclHEtr7ksPC5YEkaR4V58BQfLiV2clNU442xv+/Xl+UauCL7HIH1ichtZ4dtf2iOBUd44nbB3OnXZJ3q4RorBZOBv5IvXMHKiE9nR8IcEJcUDn+67VTOaUXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782336189; c=relaxed/simple;
	bh=e8FKnMxnQE6EcbhtFXm3u/ZDFx7rumJIKaX/xozB5Yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X2D62CjYXN5HIxHNbg4AJPeO50+9J8QMbKz8LhkIwonNtc9ldSwhbINfyqKGt9KtUnb6C+b7mx6IiBfF4oLAIUENl4UU0MlvabyROPl7Lv+npVih/3QnLlw/xeLNjOiDfpfNMU+P9RE7gcZHqwiI3e9QFNyTfU8dHL6thKwZx8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=raltZR9i; arc=pass smtp.client-ip=209.85.222.171
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-91562bf6c12so138945685a.2
        for <linux-integrity@vger.kernel.org>; Wed, 24 Jun 2026 14:23:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782336187; cv=none;
        d=google.com; s=arc-20240605;
        b=JVKelh3vK/RplVCxWBHHFZCIxmf4wjL7k7CfbNnvewQcDJfKfZrbVyzhLCrQihLbqN
         AEsMwQq4YrDgLWPOzQhVd2d3H7xUA+P8JTBl+ynXo8s9n+dp95kW+SsWh751K0ap5MZv
         zkfnKGf6UZeB5CpoVbbBwxATEfsjgq51/Ag1k+E1QJAq+upTY9mliw+RW4abJ1HwjdwC
         0ZdCKU7LfqH9ct1bO+bNdviZ3tw3lwZD/hynym1isgREIimoA9Q8HdEralnJfb/OoQH5
         65tssx21JmcEa7osABU6gN9vpeBlpRkxVhrMxdamwapLCwRZwtsf2K3sTQ/KAXieByFb
         RBSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qSoqZHCVaW6be7/8vwIAP/8yZ9kR/NSjkqmErBuSEOM=;
        fh=+Ir5RxAJzTTBtlYe+oQ9RLYGILVfAQTZaHChce2d9Qc=;
        b=IveKrtM8c/ntTjL4AnvTCGCDkzSrc0EFM18lPJSxDYZuho5awgyEPd4kixCOb29E3j
         KXjL6L7IUD4Kw4+hkBqLWMdDOzrcyEYfndJaFioj6iDq9H/0BbTzPvLcE9lR4lxNNb91
         vXYweorpJGP54YCeMOloqjfJQmlhDjhFh2vWi3e5+1muHnmWTVNanRYOqOspKtmtb+Pu
         gtDoWGp1wBfx6W+sofp+gyaOXU+fTyKV4LDJlbbUSQ7BlyFlurTCCuhb6R+iwqSHqbt7
         OVdzEeskcg93xYaDX26TrywTYvcHUCXy9JrpM3Zs7ravhskoPsDSD6hEjoCwq1do+PcG
         QcaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782336187; x=1782940987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSoqZHCVaW6be7/8vwIAP/8yZ9kR/NSjkqmErBuSEOM=;
        b=raltZR9ix+5bTVcUNHjV/cKP9ZaG1gEmiC+WOxk/Bti6+RV+yArkBmKtnOStqlTsK/
         ae0P9i68bhil7Gs4F75D7Ra/1LP5Go/rBmccFGT1/FGT3CL9Sf28c0p0p23wUlHO4TRt
         8bT8mMwUWidmP36ArLQDRrfkHJwY6KobR9od+7qm+0rMKRJMpZl1+0ZNwZaTG2+F906I
         faqY01BZpg+808056MwqrwGc+i3OLXcjjfzyCxwtH2i9+NtMhOXCQQh4i1Kx019DCs+u
         LrpW93yC6yNCe7eBQ9XrMxHxEChoF7qARpla1T2YvZlr35n1Yuk3SpCk2niUFbYZcner
         +WAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782336187; x=1782940987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qSoqZHCVaW6be7/8vwIAP/8yZ9kR/NSjkqmErBuSEOM=;
        b=Bxhqs5JJNU34vxFdBYZiRin5rdmAVQoS48TrPZFgtEC5UouIRCrGYDDBrLOTQEUbra
         Eq9DzLdch298NhJERigLXxiXO37q10EYelJGH/umI4PyKwTHeJSVgqKc8Z5zXhCq6WXZ
         BvORT2Ob2jlkigqOwp42FWByHEk/gdErJnj5/wbdBAwWqa4Lk4dO8Wi3kXK+0FOY6428
         vyvkRj5WdpH0fc0qjm1w+sYPpfy1y+p+whE4eJZ/g8kJScdyjVo5ma15i9az/RlJOnxs
         e9ZOAni7iDrV1AQd03ccsVR+t5AKcSb8SvCqf+aCyk94rXt/KQOfBbJBN+kAHRtWy/Yj
         CLGg==
X-Forwarded-Encrypted: i=1; AHgh+Rpw0T89HdCSxXeOAZ2/dTREDyumnWBCJu4yHAc27WOolyzBpBHo4dC3pROCKr09bBhAYEv58uZd++OJFdTmgZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp2szl8+2lc2K3xRL5wDqLI0fbwrYvjIpSNmFftdkSkfE3NaS+
	7cd+AJ3swnhKNd05hje8lMuRwNL0vRBpNK0bHn2X/FDdDigdseAI6Bke7eh+rGF5iXXNpZ2hvA5
	9n7Kx9f7WaL+LK+b6D8/jOjAV/1gGU+c=
X-Gm-Gg: AfdE7ck9OBXO/TJRJ3xTNxba2+DiAVxyViZqBm3Em8wm/+yQDlW7KrCIJb2Th4rGm/W
	1l8m6olRBG5WryJXY0/8q1/ZPFw1p5DHFUV922s2pbFqtMom56RTU1ebjUd+YScMQUN9Gs1RKCn
	ECObXztwSHslD2gWttMIBOBlMg/XUcAMucICD7Mhq5Igbs5sOaWGmgTG9n/LH6Ic25RArWkrtXn
	2wveD35BMjML88ckvL7eZoZ+G21KwB6XSGfHZLUUFFvpzOn9NDZ4SFDGqcLw11HCU02oZqYyKiB
	RflD/5N2/oJL5o7NZSyK+XVXyTQ=
X-Received: by 2002:a05:6214:cc7:b0:8db:736b:b2fd with SMTP id
 6a1803df08f44-8e402a51b48mr148834946d6.26.1782336186403; Wed, 24 Jun 2026
 14:23:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618203411.73917-2-dwindsor@gmail.com> <75d39fd9847cca915d704235264ab474@paul-moore.com>
In-Reply-To: <75d39fd9847cca915d704235264ab474@paul-moore.com>
From: David Windsor <dwindsor@gmail.com>
Date: Wed, 24 Jun 2026 17:22:54 -0400
X-Gm-Features: AVVi8CdrIOcn7xbcClmMBTsg427tmja6_i0WQl1k6YwRkJtqaPChbJXPc9S5D7w
Message-ID: <CAEXv5_gSOoHnVn9bKsCdHB5aR_tNHRZ+m2trVcYNmbtS-K=4fQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: Paul Moore <paul@paul-moore.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	kpsingh@kernel.org, mattbobrowski@google.com, jmorris@namei.org, 
	serge@hallyn.com, zohar@linux.ibm.com, roberto.sassu@huawei.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, casey@schaufler-ca.com, 
	shuah@kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:paul@paul-moore.com,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:kpsingh@kernel.org,m:mattbobrowski@google.com,m:jmorris@namei.org,m:serge@hallyn.com,m:zohar@linux.ibm.com,m:roberto.sassu@huawei.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:stephen.smalley.work@gmail.com,m:omosnace@redhat.com,m:casey@schaufler-ca.com,m:shuah@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:johnfastabend@gmail.com,m:dmitrykasatkin@gmail.com,m:stephensmalleywork@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-9830-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[dwindsor@gmail.com,linux-integrity@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwindsor@gmail.com,linux-integrity@vger.kernel.org];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,iogearbox.net,gmail.com,linux.dev,etsalapatis.com,google.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,oracle.com,redhat.com,schaufler-ca.com,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[paul-moore.com:email,vger.kernel.org:from_smtp,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 440986C1700

On Tue, Jun 23, 2026 at 8:12=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> I have a few specific comments below, inline with the patch, but I wanted
> to make some general comments too.
>
> The kfunc additions really don't belong in the VFS kfunc file, please
> create a LSM kfunc file (call it security/bpf_lsm_kfuncs.c) and add the
> kfunc code to this new file.
>

Makes sense. I will also do similarly for the selftests.

> While moving the kfunc additions to a LSM kfunc file does sort of convert
> the VFS changes into LSM changes, Christian's comment about splitting
> this patch two patches, one with the LSM hook changes and one with the
> BPF additions, is still reasonable and a good suggestion.  I would still
> CC the VFS folks on these patches and I would encourage reviews from the
> VFS folks as there is a VFS component here, albeit a somewhat small one.
>

v4 will contain 3 patches: one to introduce struct lsm_xattrs, next to
introduce the kfunc, and finally the selftests.

> > +
> > +static int __bpf_init_inode_xattr(struct xattr_ctx *xattr_ctx,
> > +                               const char *name__str,
> > +                               const struct bpf_dynptr *value_p)
> > +{
> > +     struct bpf_dynptr_kern *value_ptr =3D (struct bpf_dynptr_kern *)v=
alue_p;
> > +     size_t name_len;
> > +     void *xattr_value;
> > +     struct xattr *xattr;
> > +     struct xattr *xattrs;
> > +     int *xattr_count;
> > +     const void *value;
> > +     u32 value_len;
> > +
> > +     if (!xattr_ctx || !name__str)
> > +             return -EINVAL;
> > +
> > +     xattrs =3D xattr_ctx->xattrs;
> > +     xattr_count =3D xattr_ctx->xattr_count;
>
> I'm not sure why the "xattrs" and "xattrs_count" local variables are
> necessary, especially since they only appear to be used in the sanity
> check below.  I would suggest just using the values in the struct
> directly.
>

Leftover from the previous implementation, will fix.

> > +/**
> > + * bpf_init_inode_xattr - set an xattr on a new inode from inode_init_=
security
> > + * @xattr_ctx: inode_init_security xattr state from the hook context
> > + * @name__str: xattr name (e.g., "bpf.file_label")
> > + * @value_p: dynptr containing the xattr value
> > + *
> > + * Only callable from lsm/inode_init_security programs.
> > + *
> > + * Return: 0 on success, negative error on failure.
> > + */
> > +__bpf_kfunc int bpf_init_inode_xattr(struct xattr_ctx *xattr_ctx,
> > +                                  const char *name__str,
> > +                                  const struct bpf_dynptr *value_p)
> > +{
> > +     return __bpf_init_inode_xattr(xattr_ctx, name__str, value_p);
> > +}
>
> I'm sure there is a reason why you split the code out into
> __bpf_init_inode_xattr() as opposed to just putting it directly in this
> kfunc, can you help me understand?

Not sure, perhaps prior convention, or something with the verifier
perhaps. I've removed it in -v4 and everything works.

> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index 153e9043058f..1f8e84e7dd7e 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -68,6 +68,11 @@ struct watch;
> >  struct watch_notification;
> >  struct lsm_ctx;
> >
> > +struct xattr_ctx {
> > +     struct xattr *xattrs;
> > +     int *xattr_count;
> > +};
>
> I see the bots already pointed this out, and you acknowledged it, but
> since I'm looking at this I felt obliged to remind you once again about
> the rename to "struct lsm_xattrs" :)
>

Yeah, sorry about that. =3D)

> Also, looking at this closer, is there a reason why the "xattr_count"
> field is an integer pointer and not just an integer?  We're passing
> the entire struct by reference to the individual LSMs so we shouldn't
> need this to get an updated count in the caller and having it as a
> regular integer should simplify things slightly (you could also
> make it an unsigned int while you are it).
>

Copy/paste from v2. Will change xattr_count's type to unsigned int.

> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> > @@ -859,6 +859,9 @@ static int bpf_trampoline_add_prog(struct bpf_tramp=
oline *tr,
> >       }
> >       if (cnt >=3D BPF_MAX_TRAMP_LINKS)
> >               return -E2BIG;
> > +     if (node->link->prog->aux->attach_limit &&
> > +         tr->progs_cnt[kind] >=3D node->link->prog->aux->attach_limit)
> > +             return -E2BIG;
>
> Re: Alexei's comments about this - if you look back at my previous
> comments, my concern was around BPF LSMs using too many slots in the
> xattr array and causing issues.  If the BPF folks want to do that check
> in the kfunc located in the LSM framework I'm okay with that; the
> important part is that the BPF LSMs don't use more space than they
> previously requested.
>

Ack, will remove this attach-time check.

> > diff --git a/security/security.c b/security/security.c
> > index 71aea8fdf014..8f82a1352356 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -1334,6 +1334,7 @@ int security_inode_init_security(struct inode *in=
ode, struct inode *dir,
> >  {
> >       struct lsm_static_call *scall;
> >       struct xattr *new_xattrs =3D NULL;
> > +     struct xattr_ctx xattr_ctx;
> >       int ret =3D -EOPNOTSUPP, xattr_count =3D 0;
>
> Since we have the xattr array/pointer and count in the new "lsm_xattrs"
> struct, I think we can remove the "new_xattrs" and "xattr_count" local
> variables in favor of the fields in the new struct.
>

Thanks! These will be eliminated in v4.

Best,
David

