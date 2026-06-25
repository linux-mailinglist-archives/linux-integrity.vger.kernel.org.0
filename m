Return-Path: <linux-integrity+bounces-9840-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cYj4KT2UPWog4QgAu9opvQ
	(envelope-from <linux-integrity+bounces-9840-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2026 22:49:01 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4A36C89C9
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2026 22:49:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=paul-moore.com header.s=google header.b=fGKpDWF+;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9840-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9840-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=paul-moore.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E92E3041A6E
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2026 20:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1667436EA8E;
	Thu, 25 Jun 2026 20:48:06 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA5136A036
	for <linux-integrity@vger.kernel.org>; Thu, 25 Jun 2026 20:48:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782420486; cv=pass; b=euOe4RYTMEGNLjmRxhlr0PMxf+ZYUA/ik0jcnNu2B/3X52XqAHNlh86cFJqIMI7Ejj6/p3HqvgeRx+cxLJCwWna/EWnvvGGf7Qkhn1btgkV9IXbxSSxlr0ELm7kQx7JV0WvLC5FRSgSFU5QJ0Ysy4jZWpVG7LoXro851erQ+m0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782420486; c=relaxed/simple;
	bh=f0Ceifmdtd+icWZEIGznyRsCS3GvzZoATmFU82jVusM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HUNenowjZVUJMpIILM9+6OwnvEBdLJa7jjBIrJnw3n3/juAsxL2pcRDFCffjE6gxFnWkbIAVQteSbWJWFPXlIOfk5C5jrMX8or9NOKWsEAOR/quCc1weh8xNJVfB01nLPpdYS2+9CkOoNpnIiu5jVMIk3ibZpZXJV7RFZfT4Z+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fGKpDWF+; arc=pass smtp.client-ip=209.85.214.179
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c80810247dso3362995ad.1
        for <linux-integrity@vger.kernel.org>; Thu, 25 Jun 2026 13:48:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782420483; cv=none;
        d=google.com; s=arc-20260327;
        b=NE6yLaiD7cxvM43i5yoRV+LYHtmTVtsPjsnx+g40kuupfrmbY5KnA2Dx2Zcl4SE4QB
         KD/rFxuvj33YfQTe9+g5pqjwzsiU8SrYW0n3OB5lgQdSm8KePkpz8Q9Dop8dydmd0lmS
         IisTPHbh1FpaTs57ULB3Yz4yzi9thVgzigXmkTyi5+4DogbS5t5KXG4hfvEfQtQILHLd
         U4FrLcjQb4EAkts0xRP6KHil27JinJX+L3QUI1jesAh0Dp1C6UMJcR1vnEoc1AjMJLgG
         XwNgbKDVW7ZOJfve4LVrDRuxMNPzhwCDmOireGzL9wM5vFJ7/tRcjl3/ngmcdIGp2nfh
         igkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=azFpD8w+2tmcQpqU30ws2iQaaMKt3MV7jEBsuDhiaTo=;
        fh=IBTJY3NhKO/9gZ8shidct1qzRuW7XHWDweixV2XuTbs=;
        b=BBIuTCq7yf8OsJRScA5mKXInLEc0EADJq2z0K0Eknc2o6bQ3Tf5a6+MqFZdQm02NL/
         wqJN28WcJnXod2yCEo/CH372TpJFNOS2qPa25CbzTS7+qyeVRVUVQLmq38M6siYEQNzE
         Qno9XZFj5hFeIFZnzr0OlUrnKJVje0mjq6BsBF/C51Y3RilK4ZhDQWtrQyhJelWVMzYk
         0DR3hNwpvQ0GQ6dsMrDL7Bnm5fTCgKw/wM6DVxoIOYP5KLgTAQG8f82t2VyboVCkx78R
         HyAOCKfYwwvgygjPEx4jQxmil7zaRAnGD8zfkZbbGeYqJgJfiKePqpdRL79/Qu43kPY8
         czGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782420483; x=1783025283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azFpD8w+2tmcQpqU30ws2iQaaMKt3MV7jEBsuDhiaTo=;
        b=fGKpDWF+vWPIG/vytG8etsjCv8EuM35t5u73k2ZExHfdTKfjs0WH9aQUC+5SHQsTXU
         7XKkjqAFI+No2YeGYhxhXEpWdy+tkgGTMtrHEVo/P7M1ItNdX75HD6ENzdFCPDenV0mu
         sNYTvX1XnP6xn4Kg8p4s1pxGT/G7wJtrroM7U9UQTbckWpT0IgzCLsGEfFfuWLIAtaru
         NrCMb0Fk8COwaKcl6t7hrzjxdR0/6klXEduISzHACggR1j9s/V+bFEtowjy2qh6wMXJD
         WcpTH+TrEiEiseu7pBceKl7/cy/MCNUvK11lmrdpupjfNRr9LKd3wXEY57fXp2XVzWGb
         xUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782420483; x=1783025283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=azFpD8w+2tmcQpqU30ws2iQaaMKt3MV7jEBsuDhiaTo=;
        b=tQvauY3O7ooRB+GxrzCFnGS3xShpOY49JRWcrTalZgEpT6Ady5AJkNKDgp3wam9jhD
         1H7MJUrcVukKGqcqQxqXh/eHxctlpZjDD1kHoKyitGxZGDxfhvtHXVlo/rZ5ONRBh4RV
         JlHCmN13IdYkZ4anW1OwKmV/GwgcMYyQEiim6yrxRkOc+kGHlCUUiOFLx27fu8+UCLAz
         mY14TNus7oheRcxQRLC/8HUnw6BZcWw0GVgKL59x+ohDtjpHCO1hxlZcBtiiXawk+q46
         vZEB6oAiwKufYJI4vzEzEzFbJfv3vNGsd95z98yVTCU0X0DSqwmrbwkV2Sd8Z9m/nKfh
         wFTA==
X-Forwarded-Encrypted: i=1; AFNElJ+GDlThClQkxc5adrXbD+xbSPkOo3a2f9O+lLnFqWa8J4orL5vqaHb59k9U3RLnR3FmSFO4HreqFxpqbCMwoFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTvzISTBFgiHFxtNfy1hTZuqYEaT5IPVm2FeRlLOs6SNo9fsx3
	1285iqTO/ttjse1NU8bD7HwOfm/xsBpjyZ2nyMdD4Iivh0/0ej78W045UNhwLddzv7KfUo9uzjg
	yhtvMQ7a4D23UP3RC5ppcx1M5ZrNKk+T4Bqz613d2
X-Gm-Gg: AfdE7cmzRaG9V/J+aY3uwshmycpgfMJHSTl9seiAbkVayjS14Stls3T6sdoFK3RCZAA
	rPOtfOJM5klTJk01J5xWGNA3J4kBL+H8tIMoMzDmRAgFww79fGlg7NDfx2lR/wMfTfDlb3PLVzH
	hx+HSGp8HF+8CvWAd/hVx1pkJMrZIEYUnQugeivmegIxNUpvGcCG/0pqPr7v1kVrji1KdZ3k5n/
	EJmcheYhRNZtzT3HAwPhyvwkJTzhWY3yAqteounGexeGiRjfM559NCNqEK5Xqv6MjFatuph
X-Received: by 2002:a05:6a20:258f:b0:398:bda8:d8cd with SMTP id
 adf61e73a8af0-3bd4ac850b6mr4962108637.7.1782420483450; Thu, 25 Jun 2026
 13:48:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618203411.73917-2-dwindsor@gmail.com> <75d39fd9847cca915d704235264ab474@paul-moore.com>
 <20260625-schnabel-rennmaschine-parieren-bcb352c3cf59@brauner>
 <CAADnVQKKr5cCYTj8qS7tU-Aeda1iexYUp5aquTjYXMEL656cJQ@mail.gmail.com>
 <CAHC9VhSXXHGRUmJ4YjQ6uEh6dbq7+h_0TwWiV+W5dUWXCTFcfg@mail.gmail.com> <CAADnVQJM15E0PwomdTiz8zvVMGkqs9mTSjYRdPBF6fgE=tsPCQ@mail.gmail.com>
In-Reply-To: <CAADnVQJM15E0PwomdTiz8zvVMGkqs9mTSjYRdPBF6fgE=tsPCQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 25 Jun 2026 16:47:51 -0400
X-Gm-Features: AVVi8CeSCq01YuOttlTLlYK8mdjCXHKn7_tsxEH2h9SOetfWd3DVlVdhg7KLIyU
Message-ID: <CAHC9VhSm_yC7f1FRHJn0NE1-UwCOx7Nhc9dxVJXs8DFzzxNKQw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Windsor <dwindsor@gmail.com>, Christian Brauner <brauner@kernel.org>, 
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
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:alexei.starovoitov@gmail.com,m:dwindsor@gmail.com,m:brauner@kernel.org,m:viro@zeniv.linux.org.uk,m:jack@suse.cz,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:kpsingh@kernel.org,m:mattbobrowski@google.com,m:jmorris@namei.org,m:serge@hallyn.com,m:zohar@linux.ibm.com,m:roberto.sassu@huawei.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:stephen.smalley.work@gmail.com,m:omosnace@redhat.com,m:casey@schaufler-ca.com,m:shuah@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:alexeistarovoitov@gmail.com,m:johnfastabend@gmail.com,m:dmitrykasatkin@gmail.com,m:stephensmalleywork@gmail.com,s
 :lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[paul@paul-moore.com,linux-integrity@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[35];
	TAGGED_FROM(0.00)[bounces-9840-lists,linux-integrity=lfdr.de];
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
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,zeniv.linux.org.uk,suse.cz,iogearbox.net,linux.dev,etsalapatis.com,google.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,oracle.com,redhat.com,schaufler-ca.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[paul-moore.com:dkim,paul-moore.com:email,paul-moore.com:url,paul-moore.com:from_mime,vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kernsec.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4D4A36C89C9

On Thu, Jun 25, 2026 at 4:44=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Thu, Jun 25, 2026 at 1:40=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Thu, Jun 25, 2026 at 3:58=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > > On Thu, Jun 25, 2026 at 7:23=E2=80=AFAM Christian Brauner <brauner@ke=
rnel.org> wrote:
> > > > On 2026-06-23 20:12:32-04:00, Paul Moore wrote:
> > > > > On Jun 18, 2026 David Windsor <dwindsor@gmail.com> wrote:
> > > > >
> > > > > > Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomic=
ally set
> > > > > > xattrs via the inode_init_security hook using lsm_get_xattr_slo=
t().
> > > > > >
> > > > > > The inode_init_security hook previously took the xattr array an=
d count
> > > > > > as two separate output parameters (struct xattr *xattrs, int
> > > > > > *xattr_count), which BPF programs cannot write to. Pass the xat=
tr state
> > > > > > as a single context object (struct xattr_ctx) instead, and have
> > > > > > bpf_init_inode_xattr() take that context directly. Update the e=
xisting
> > > > > > in-tree callers of inode_init_security to take and forward the =
new
> > > > > > xattr_ctx.
> > > > > >
> > > > > > A previous attempt [1] required a kmalloc string output protoco=
l for
> > > > > > the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all=
 LSMs to
> > > > > > provide xattrs for inode_init_security hook") [2], the xattr na=
me is no
> > > > > > longer allocated; it is a static constant.
> > > > > >
> > > > > > Because we rely on the hook-specific ctx layout, the kfunc is
> > > > > > restricted to lsm/inode_init_security. Restrict the xattr names=
 that
> > > > > > may be set via this kfunc to the bpf.* namespace.
> > > > > >
> > > > > > Link: https://kernsec.org/pipermail/linux-security-module-archi=
ve/2022-October/034878.html [1]
> > > > > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/=
linux.git/commit/?id=3D6bcdfd2cac55 [2]
> > > > > > Suggested-by: Song Liu <song@kernel.org>
> > > > > > Signed-off-by: David Windsor <dwindsor@gmail.com>
> > > > > > ---
> > > > > >  fs/bpf_fs_kfuncs.c                | 106 ++++++++++++++++++++++=
+++++++-
> > > > > >  include/linux/bpf.h               |   1 +
> > > > > >  include/linux/bpf_lsm.h           |   3 +
> > > > > >  include/linux/evm.h               |   9 +--
> > > > > >  include/linux/lsm_hook_defs.h     |   4 +-
> > > > > >  include/linux/lsm_hooks.h         |  16 ++---
> > > > > >  include/linux/security.h          |   5 ++
> > > > > >  kernel/bpf/bpf_lsm.c              |  10 +++
> > > > > >  kernel/bpf/trampoline.c           |   3 +
> > > > > >  security/bpf/hooks.c              |   1 +
> > > > > >  security/integrity/evm/evm_main.c |   8 ++-
> > > > > >  security/security.c               |   7 +-
> > > > > >  security/selinux/hooks.c          |   4 +-
> > > > > >  security/smack/smack_lsm.c        |  27 ++++----
> > > > > >  14 files changed, 166 insertions(+), 38 deletions(-)
> > > > >
> > > > > I have a few specific comments below, inline with the patch, but =
I wanted
> > > > > to make some general comments too.
> > > > >
> > > > > The kfunc additions really don't belong in the VFS kfunc file, pl=
ease
> > > > > create a LSM kfunc file (call it security/bpf_lsm_kfuncs.c) and a=
dd the
> > > > > kfunc code to this new file.
> > > >
> > > > We expose a bunch of VFS heavy operations for various security modu=
les
> > > > and this is really not different. For xattrs we have it all central=
ized
> > > > in the VFS and in general all VFS related bpf kfuncs should continu=
e
> > > > living there and be registered there. Anything that's just bpf infr=
a
> > > > specific can go to security/bpf/kfuncs.c instead. But anyway, it's =
a bpf
> > > > specific helper so it's the bpf maintainer's call.
> > >
> > > Completely agree. This is vfs related kfunc and has to be
> > > in fs/bpf_fs_kfuncs.c to make sure vfs maintainers review it now
> > > and all future changes to it.
> >
> > *laughs*
> >
> > Okay, then split out the LSM specific stuff into
> > security/bpf_lsm_kfuncs.c; all the LSM macros/defines/calls should be
> > in the LSM kfuncs file.
>
> Paul,
>
> I'm sorry, but you didn't demonstrate the level of understanding
> of bpf to be trusted to maintain any piece of it.

Alexei,

You haven't demonstrated the understanding or decorum necessary to be
entrusted with any part of the LSM framework.

--=20
paul-moore.com

