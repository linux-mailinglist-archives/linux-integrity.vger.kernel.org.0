Return-Path: <linux-integrity+bounces-9809-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Lo4gDW12NGpIYwYAu9opvQ
	(envelope-from <linux-integrity+bounces-9809-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jun 2026 00:51:25 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B18036A2FE5
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jun 2026 00:51:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=CZ2E6C7p;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9809-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9809-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4135C30465C2
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2026 22:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660DD34FF78;
	Thu, 18 Jun 2026 22:51:06 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262C933F58C
	for <linux-integrity@vger.kernel.org>; Thu, 18 Jun 2026 22:51:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781823066; cv=pass; b=GmE0wq2ejRy6kwcuQUCja22msKfwXyyIT6Y+8ywBC+RPGAfFpC/2rhUPRGUfAJrVobHml/xWLmBYrLHJtAFMP68LKJv+x0Cc3bigWolF5ssNcV59sXyYldqyAYaeN5ljOvBoVVx7utHo66BJcCIx4yRmy30SkY44+9CphiD7ZaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781823066; c=relaxed/simple;
	bh=EMYr1F+PpGtSmTpfHsTm52f8sshX1D1zHOemelGKRHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OqGgpcW1PgKOeIZyhxfyoptM6LIAKxWc3OjWg5112pw9clSU44PuhBmJNn0/pBjdXhINQDjaKb9mU/FxYfwDqR+SPUryb0PpZs3pY90uLpcW8wtac3haDTeRXvO5KM+bxPC96GII/3vdl+JgZ1kolh1OYcUbDlTuE/xJ7iydxsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZ2E6C7p; arc=pass smtp.client-ip=209.85.222.176
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-9156b74006aso107225585a.0
        for <linux-integrity@vger.kernel.org>; Thu, 18 Jun 2026 15:51:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781823063; cv=none;
        d=google.com; s=arc-20240605;
        b=SelYACQUV11KD2poKfOrsjCSlBxj0YM33xpKP+TJxmYN5eMj47uHMnnrlUCT8wPQZ1
         +GcKq99Yrx4Q7S59zUaanzPh7/EDYeXkFK9YF6OsxP2AI/jRr/mk/1MRnyilnBkevfid
         qfAg0KTA2+22AFuuZ/TkuTfkCYCG7kAi2vrhDHZihXmMUmYjXn+EcLB70HRaHYvfovQR
         bXadMDQJIlI5sxxjsbllF+J/Aw/sHEq01CVs+zBi+1WidyXAThkiIYmkGWGOl2rWKiXk
         UxUk05rE2+qgjafF2H1+pWWVVe5juOlAG/29U09xt7zOaWcUjJsKsQ0jrgZEtma9jcvN
         3seA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SMwuGs+SqkOWXXKsNFJ9sJZ3Linv0hyo9Jf2noGou30=;
        fh=byqMq4HglciPxaLUBQw5M69wA1yQwr7FqpFlGqXc5P4=;
        b=MEPZSZFxQ2yccM5E7z00qCs4GpvStMZPKkaYQ0Lxv+nus6lPN1ZRCvVLQD1j3lhb6e
         KZF67uYbXCYqe5uAnkRfR5Ce0V6kcccjXeFVmvoQhb4rXtwSSuzpQVpjifg7FBcucZwt
         vjp9QM0UsCja4YmQAtUsbszM6JpHFkt3hYazvkxYijzvOG9QWTsFwYtVOacbzMQpbgZY
         rYTXYstjfP7fMzZ6y5B+EiK0IvPRlFODebYwPPPYMnTIGq9GVj8FP8ClSsEYmq462Vv+
         wm0WzQu0wOQkpS3jprqxLs4LWfOCsOjOKQVSe0yVBN1ei8x37eNcORLEVjHsyry8PE1v
         fP8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781823063; x=1782427863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMwuGs+SqkOWXXKsNFJ9sJZ3Linv0hyo9Jf2noGou30=;
        b=CZ2E6C7prhTojmgoHGdNe7OileXPbl3IdhXRahO17zU0p7sydgNazhp1YHE4kV/6eg
         /iLvrxYKEmWLRXuKoolRzvba4DUUKfRHLyiBgYpuqOcdWtg82BbySEy4qLx6HhHXP7dS
         PthIZYz4hSquO4gFZ3URQSYFja1vdkH+gSP3b9b2UHQAe+pCO5lsOGswbMvzZJQaVr3J
         LMfxXi93vOcsvLFfsN8zLILywVKhEiv9aH7ub2Wr26pPk6HXp1A+vN3Q1qU+OaSnl3td
         B+79jtylayY9plF1MJRE+jSxSw56SZl4UEYadYOtdVYwiErhIjX8wLS2AjK/RQ+xbQeP
         KzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781823063; x=1782427863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SMwuGs+SqkOWXXKsNFJ9sJZ3Linv0hyo9Jf2noGou30=;
        b=VlPrbqIM2yjjthlHILSbuFi2kuDx1Bic0Pr8BPeRDVwDobr8V/rQjX31yw2ZOslpKu
         FfdOp+IAZh/buqhpi+WNrcppQIAKM4104S0qXuP3O4zIuIsKQJhXf6GarW0+5zFovprp
         Vjdu7LiKPTu/BhR0ErK8iL8Z9B/poZ8N6uAbxdkWhpMbq4V7FsSz0hSx33qTcAA4Atgv
         GxQeU0SXlPbZHYI3cJUNiuPPCvv1AlWHt02BbOE8WCsA+rphUW1IzrzKr4TzaQrjC1ug
         iDKL8+J8TbcrdeuSd1uQ109Y+kkucKGJB8EG/kOqbr6NJQ5DOgLYqLj+uS7ffxcuAKgq
         C5iA==
X-Forwarded-Encrypted: i=1; AFNElJ+kKs5/S7Ll1MQtPlCFEjEtXCQCQrFy4l/Kgu6qgr33x8rhFB2XA/dqaasCKENLkDqAGl/Q3COtFaMzrKAxHL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk0fOvlMQKDYwXtO0mMeEEeohh6Lrhubag48N8maqXyU5LR2py
	lAZO4fCVqk9cHBPCblY9vvYSHExLc1tg8c9JiOaeffCHbNJfDjbKUqxOdwOGbvkf9BCxOR9k9Sn
	y1007zlcgXBQ4oEV/oB0nLvnU5Wh7D/g=
X-Gm-Gg: AfdE7clnDSoFu7rUNrnCDPRJQb3sX17lRkv9BRVef5r/Y2njhBeXfREK8MJBmGpMDPK
	+hfsqMUgj9Gd0AwtQoPx3G8Cl6golpOlh2OpSN/jea/Zbu9ebSg2MJQuIF6PEYWuTyyiGFit5Wy
	eBCHuVXgGaz4RZI7p6ldOCRy+MErrjUUhpw3YU8wCKTEm/lNdNeCXPc7BA00/xC4VwqURsd/7I0
	GZGRhXFbRyZR4sjQcDczpDtSt3lJWz5+/7yz1/YQEka2hpm6WE9pEsv+duHEf7LsgIc1aT+Fq8y
	bkRlOLFLqvYToOUSXqoEu9E/hpA=
X-Received: by 2002:a05:620a:19a7:b0:915:6504:2a11 with SMTP id
 af79cd13be357-9208d2f42f5mr171322285a.44.1781823063019; Thu, 18 Jun 2026
 15:51:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618203411.73917-2-dwindsor@gmail.com> <e9ec622a8a49be299cbbfd459e2fc10693bcd65c6dbf00c9e2645281564e5579@mail.kernel.org>
In-Reply-To: <e9ec622a8a49be299cbbfd459e2fc10693bcd65c6dbf00c9e2645281564e5579@mail.kernel.org>
From: David Windsor <dwindsor@gmail.com>
Date: Thu, 18 Jun 2026 18:50:50 -0400
X-Gm-Features: AVVi8Ceqq7GMU3vGf90S537LLM-Tkad05xeAgBh-3i_pTCiFmecE5-lsBfct2HY
Message-ID: <CAEXv5_hDJyZ=nY6JaSL=17Mtw+e_m1doj=KReWSNmgo6ULFKpA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: bot+bpf-ci@kernel.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	kpsingh@kernel.org, mattbobrowski@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, casey@schaufler-ca.com, 
	shuah@kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
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
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9809-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[dwindsor@gmail.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:bot+bpf-ci@kernel.org,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:kpsingh@kernel.org,m:mattbobrowski@google.com,m:paul@paul-moore.com,m:jmorris@namei.org,m:serge@hallyn.com,m:zohar@linux.ibm.com,m:roberto.sassu@huawei.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:stephen.smalley.work@gmail.com,m:omosnace@redhat.com,m:casey@schaufler-ca.com,m:shuah@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:martin.lau@kernel.org,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:bot@kernel.org,m:johnfastabend@gmail.com,m:dmitrykasat
 kin@gmail.com,m:stephensmalleywork@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,iogearbox.net,gmail.com,linux.dev,etsalapatis.com,google.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,oracle.com,redhat.com,schaufler-ca.com,vger.kernel.org,meta.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwindsor@gmail.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity,bpf-ci];
	RCPT_COUNT_TWELVE(0.00)[38];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B18036A2FE5

On Thu, Jun 18, 2026 at 5:22=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> [ ... ]
> >
> > +struct xattr_ctx {
> > +     struct xattr *xattrs;
> > +     int *xattr_count;
> > +};
> > +
>
> Paul Moore suggested in v2 renaming this to 'struct lsm_xattrs' to avoid
> overloading the term 'ctx' in the LSM space. The struct was renamed from
> 'lsm_xattr_ctx' to 'xattr_ctx' in v3, but 'ctx' is still in the name. Was
> there a reason to keep 'ctx' in the name, or would renaming to 'lsm_xattr=
s'
> as Paul suggested be preferable?
>

Indeed he did; I mistakenly inverted his original request.

Will send a fix for this, as well as converting GFP_KERNEL to GFP_NOFS
in the allocation in __bpf_init_inode_xattr.


> >  /* Default (no) options for the capable function */
> >  #define CAP_OPT_NONE 0x0
> >  /* If capable should audit the security request */
>
> [ ... ]
>
> > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > index 564071a92d7d..86a8e188b900 100644
> > --- a/kernel/bpf/bpf_lsm.c
> > +++ b/kernel/bpf/bpf_lsm.c
> > @@ -113,6 +113,9 @@ void bpf_lsm_find_cgroup_shim(const struct bpf_prog=
 *prog,
> >  }
> >  #endif
> >
> > +BTF_ID_LIST_SINGLE(bpf_lsm_inode_init_security_btf_ids, func,
> > +                bpf_lsm_inode_init_security)
> > +
> >  int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
> >                       const struct bpf_prog *prog)
> >  {
> > @@ -137,6 +140,12 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *v=
log,
> >               return -EINVAL;
> >       }
> >
> > +     /* bpf reserves a fixed number of xattr slots for itself.
> > +      * Set the attach limit so the trampoline rejects excess attaches=
.
> > +      */
>
> This isn't a bug, but a subsystem pattern flags this as potentially
> concerning: the BPF subsystem comment-style rule for files under kernel/b=
pf/
> requires multi-line comments to have the opening /* on its own line, with
> comment text starting on the next line. The preferred form would be:
>
>         /*
>          * bpf reserves a fixed number of xattr slots for itself.
>          * Set the attach limit so the trampoline rejects excess attaches=
.
>          */
>
> > +     if (btf_id =3D=3D bpf_lsm_inode_init_security_btf_ids[0])
> > +             prog->aux->attach_limit =3D BPF_LSM_INODE_INIT_XATTRS;
> > +
> >       return 0;
> >  }
> >
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/277886=
16397

