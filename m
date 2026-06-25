Return-Path: <linux-integrity+bounces-9837-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pjk4H9CIPWrI3wgAu9opvQ
	(envelope-from <linux-integrity+bounces-9837-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2026 22:00:16 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C07446C873A
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2026 22:00:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="eaESUM/3";
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9837-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9837-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95EF83070A17
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2026 19:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF88B36494C;
	Thu, 25 Jun 2026 19:58:43 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F24F34887E
	for <linux-integrity@vger.kernel.org>; Thu, 25 Jun 2026 19:58:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782417523; cv=pass; b=OfZ07MdOAigFlLVuBl6Azrp7tcyWZSXr9C151gBsGeToh6IrfOgGLhuAUEZIkKhNZgCe7iS0TyniiU4SNb5FpOJ6KZUQJzDMJZ/6YSFkuYV73IorB83CXNdVe+BAv+jOESNpl2fV9MzbBD2FXt5K1q3q8cY8JnoIkw1bwYbw9rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782417523; c=relaxed/simple;
	bh=t01HuVJS93Se9y/xJOr+SDSuCi2qkwkLjpWQtvIuIYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ksqtEwpBXnkLNRL11/q/iB9Y+4FJS9Q90vubZqG7TJElcl/bXycBJaBkIUTchmmmy0pjr/uTSFDUxyX95HVeRv8aWDvL+dCd/9tmcwvDzIiI28bpKwvNqP3pGKvWnxWVCuAYjwz7+eGGA31eE8Rgfiutnxe5yQDLkaIYvVCog3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eaESUM/3; arc=pass smtp.client-ip=209.85.210.177
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-845b6d9bf39so118725b3a.1
        for <linux-integrity@vger.kernel.org>; Thu, 25 Jun 2026 12:58:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782417522; cv=none;
        d=google.com; s=arc-20260327;
        b=WzWkI27ugOBRGs1US1pOjEGZWd0NToAyo8wYGYPuzocc9wP/ZpYMSJss9lMYJHN0Pd
         tABUbP0bOAUJ2GsCycL6KcBe1iGyhNr/MA2xfdaQt0zyo/FEBQX20oEduQlgVpFMApin
         RSJ8ja1fYfKIruecDPUHjQjtZ7zVxh9NpYCjpD3BvdLlS5Gcygq/IciVwaRa8gWXyka+
         op+AU+GuAxhtwhQ7QHG9Drp21WwC/QV1OOotc1GbnwSJJx/r19fbhbncLbtHViXCvoXS
         Wrno/HeoUCmq0jIQ3gCnk1lA4w2JAHhdbRoYTwqxDLevU6ZNbnokBOWxpuUmD0Whuy1g
         KHpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hPszu32IdAgDeUQ2X3Ei0AlLyibH0GB2lSQN/iu5tDY=;
        fh=Bf2by7EAinOGHIv1iQBxblH7k0LItfFiajPpym9bBi4=;
        b=ktv32Mqj82wXvDJZtZkwfcVtlPT+BpSW8EatscJBk7ef0K3+qOtNasVBoZTZPJE3PL
         jXT0u3Pd/OBR19McBlI2wyK9Hhzfp0oN0Hh/tDw3COgZQIs/azLMduaQMcq5dsf2rOzP
         kr5XX/MH0nBw096FlB8QCnrTXfaY33B7hOI5FBYEkd1zprZHKCLN6tBMiMq8zTq9YAa3
         Y9LcFINL6Razr1I77wVryu/4UD3Vr8H9I2PDKYI/z4h3dj3jdJ5PWmpA0I2wKFMGD4eX
         QRAlLvKUCnAWR/Gao9T7Ouq8NmlKKFSe78IHZ7fMJ4CSb5mxzjC9WZhOJQS//npmYaB2
         pPPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782417522; x=1783022322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPszu32IdAgDeUQ2X3Ei0AlLyibH0GB2lSQN/iu5tDY=;
        b=eaESUM/3qu36XTQpaqOGJRjKaAGFJhqF0lkNADskUW0FZ5YSzZqmQQpCBGhGz/9CVZ
         3yTqnvI+Bx7woEDhrV7jxG/KIq4nb7Ybwyq8STUCdKFcVOnEBgsqaZtgwLc4IwSrvR6x
         gAVj749Xk0LvTdnJIO6EhVs1PAhCSbSiB88EoPgFP4UYmxz7F7Zyc0hoIl6K8xltNi+P
         VBGRGMT9JCYv6vh+8ZsfDNDU1ezEF+k52IKQtYr/p85BMLcP+bDoMyrU8nbOl44doxbK
         VBlYIdTR0xF5O9W/ojYmiA2Okz/K4cgU5uRDbSIknQxrKRIpZC0xQEeVGhJE8uHDz+mx
         5bCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782417522; x=1783022322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hPszu32IdAgDeUQ2X3Ei0AlLyibH0GB2lSQN/iu5tDY=;
        b=XbfWnuO4RT/Spmr+xl4Fsv8E4jwy+Y4QZwBMKHiicDJKTjiAPdsdI/Vq2f3HMMkIJZ
         qj9TE3XTmm53SEHg8UIXR9fTiKLvq+I44DtmFj6Ad6KfvYGd8Sb9Ex8ea7rfG2yikiRS
         Gl8RD0ctrZQH7g64iJ3BkYCSMXOiztFSt0BYV0g74GPCEUXjLf3U6rsYySCV2vlL4jne
         HfNkXbm5fDv4oX89O3WZrweKB3AEcuMoyQFa29RfKpe1vwkgPj01PIwGANazXkiF4ael
         vAKuWhw8X4bD7fgSVrcYNUJq2YBNCoF7jfvht7DraGZLRA/iVOWXqDMpef1pz38FGOlx
         uGeQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq3zE/cTH1SozbEcwm2C4omDJdgoQKDRGeximugqmA+tXPGyElS9MWa7d6G69RIC1LuqUnmMT7v7GCvkdXpSRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx858RoMNVCgg4zcbLdCZX/UbQAHNcTPo5PgL8dgJO+7+M1cqUF
	wvaOuabtxEedjfmXDFo8ZqS2QtwxIO+xTgnKdDn6e9pr1o2vuJdHXtUpgkehzVmnoCvOLMKX81p
	quZ4NrAGkwAr4N39pwtZOxFGFaVG+iA4=
X-Gm-Gg: AfdE7cnSbuLBmQWOmBfEFm9Ys+0fCZdaVoWSqHqh2wEFqx6Eo4h5Z/FX07Hd6ERCUHo
	Oy9OMnSrm9vj+TXZH6dRiJ/R0f5GyyCu+Kh3kGov1uqVTtwU7cx4miPQudY9Q0meuFQg1n5YXyK
	xV200D4G4nYRiiwsZ0rdXNPsWW26JbWBtZr//j1wF9Z24srB2w78oh9lSz789p6xOhxCXcASPlT
	742/YCfv3nuFxN9xAfnnDsORpFj9Tth+sEhp2hyX7GX6vOs6EjdRzZwV1AHwluxX5gHj8JQVjlY
	dFM3cp4hLeuX6FIu6zQIPUc0WffSoJV4qCQpw1AknLmuZrV3jsrnSeOB67V2FH2cqjQkOjejEcR
	pbkkR0ZBIZGh5
X-Received: by 2002:a05:6a00:b44:b0:842:614b:50dc with SMTP id
 d2e1a72fcca58-84591b767a3mr12823311b3a.13.1782417521452; Thu, 25 Jun 2026
 12:58:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618203411.73917-2-dwindsor@gmail.com> <75d39fd9847cca915d704235264ab474@paul-moore.com>
 <20260625-schnabel-rennmaschine-parieren-bcb352c3cf59@brauner>
In-Reply-To: <20260625-schnabel-rennmaschine-parieren-bcb352c3cf59@brauner>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 25 Jun 2026 12:58:29 -0700
X-Gm-Features: AVVi8CcGIc2g2XVMtMkmAY3eaT2U_sbyaP0UfCx7SkpWcEZUZelhXqYLRoruYRQ
Message-ID: <CAADnVQKKr5cCYTj8qS7tU-Aeda1iexYUp5aquTjYXMEL656cJQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: Christian Brauner <brauner@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, David Windsor <dwindsor@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	linux-integrity <linux-integrity@vger.kernel.org>, selinux@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:paul@paul-moore.com,m:dwindsor@gmail.com,m:viro@zeniv.linux.org.uk,m:jack@suse.cz,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:kpsingh@kernel.org,m:mattbobrowski@google.com,m:jmorris@namei.org,m:serge@hallyn.com,m:zohar@linux.ibm.com,m:roberto.sassu@huawei.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:stephen.smalley.work@gmail.com,m:omosnace@redhat.com,m:casey@schaufler-ca.com,m:shuah@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:johnfastabend@gmail.com,m:dmitrykasatkin@gmail.com,m:stephensmalleywork@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9837-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[alexeistarovoitov@gmail.com,linux-integrity@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,linux-integrity@vger.kernel.org];
	FREEMAIL_CC(0.00)[paul-moore.com,gmail.com,zeniv.linux.org.uk,suse.cz,kernel.org,iogearbox.net,linux.dev,etsalapatis.com,google.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,oracle.com,redhat.com,schaufler-ca.com,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kernsec.org:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C07446C873A

On Thu, Jun 25, 2026 at 7:23=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On 2026-06-23 20:12:32-04:00, Paul Moore wrote:
> > On Jun 18, 2026 David Windsor <dwindsor@gmail.com> wrote:
> >
> > > Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically s=
et
> > > xattrs via the inode_init_security hook using lsm_get_xattr_slot().
> > >
> > > The inode_init_security hook previously took the xattr array and coun=
t
> > > as two separate output parameters (struct xattr *xattrs, int
> > > *xattr_count), which BPF programs cannot write to. Pass the xattr sta=
te
> > > as a single context object (struct xattr_ctx) instead, and have
> > > bpf_init_inode_xattr() take that context directly. Update the existin=
g
> > > in-tree callers of inode_init_security to take and forward the new
> > > xattr_ctx.
> > >
> > > A previous attempt [1] required a kmalloc string output protocol for
> > > the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all LSMs =
to
> > > provide xattrs for inode_init_security hook") [2], the xattr name is =
no
> > > longer allocated; it is a static constant.
> > >
> > > Because we rely on the hook-specific ctx layout, the kfunc is
> > > restricted to lsm/inode_init_security. Restrict the xattr names that
> > > may be set via this kfunc to the bpf.* namespace.
> > >
> > > Link: https://kernsec.org/pipermail/linux-security-module-archive/202=
2-October/034878.html [1]
> > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/commit/?id=3D6bcdfd2cac55 [2]
> > > Suggested-by: Song Liu <song@kernel.org>
> > > Signed-off-by: David Windsor <dwindsor@gmail.com>
> > > ---
> > >  fs/bpf_fs_kfuncs.c                | 106 ++++++++++++++++++++++++++++=
+-
> > >  include/linux/bpf.h               |   1 +
> > >  include/linux/bpf_lsm.h           |   3 +
> > >  include/linux/evm.h               |   9 +--
> > >  include/linux/lsm_hook_defs.h     |   4 +-
> > >  include/linux/lsm_hooks.h         |  16 ++---
> > >  include/linux/security.h          |   5 ++
> > >  kernel/bpf/bpf_lsm.c              |  10 +++
> > >  kernel/bpf/trampoline.c           |   3 +
> > >  security/bpf/hooks.c              |   1 +
> > >  security/integrity/evm/evm_main.c |   8 ++-
> > >  security/security.c               |   7 +-
> > >  security/selinux/hooks.c          |   4 +-
> > >  security/smack/smack_lsm.c        |  27 ++++----
> > >  14 files changed, 166 insertions(+), 38 deletions(-)
> >
> > I have a few specific comments below, inline with the patch, but I want=
ed
> > to make some general comments too.
> >
> > The kfunc additions really don't belong in the VFS kfunc file, please
> > create a LSM kfunc file (call it security/bpf_lsm_kfuncs.c) and add the
> > kfunc code to this new file.
>
> We expose a bunch of VFS heavy operations for various security modules
> and this is really not different. For xattrs we have it all centralized
> in the VFS and in general all VFS related bpf kfuncs should continue
> living there and be registered there. Anything that's just bpf infra
> specific can go to security/bpf/kfuncs.c instead. But anyway, it's a bpf
> specific helper so it's the bpf maintainer's call.

Completely agree. This is vfs related kfunc and has to be
in fs/bpf_fs_kfuncs.c to make sure vfs maintainers review it now
and all future changes to it.

