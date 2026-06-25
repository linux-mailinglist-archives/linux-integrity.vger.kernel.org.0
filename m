Return-Path: <linux-integrity+bounces-9839-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QLElJNKTPWoK4QgAu9opvQ
	(envelope-from <linux-integrity+bounces-9839-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2026 22:47:14 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A928A6C8994
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2026 22:47:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cVt9QOH8;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9839-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9839-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3971303259F
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2026 20:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA7F2BEC34;
	Thu, 25 Jun 2026 20:44:57 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEF433F586
	for <linux-integrity@vger.kernel.org>; Thu, 25 Jun 2026 20:44:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782420297; cv=pass; b=iyG24+cD/4mnoTlsgDg+a1n7P8OKPZBbk4B15EyGNxk4+YYgEfLYGSpxpNjgP/Wm1y2/F0RrRDcbQuVdTSR+Zkmntdb8tZ2JpNpL8gy8zx6Ebi7H592uropTkyJMT9sAUnvo8L/MocwlpNzZoPbr42h7rEtd5pGN+LRBBY4bCho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782420297; c=relaxed/simple;
	bh=N9Dq4DwFj346OsehhL6Mi2d0QMKVNJTttDz0kqTp1YI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nn/CFvdcl45raJRmD4D9a4VdGiX0kSCeLQGFc73CGP/5ojCvaS4V7Sl7P+3CBgSqJRGzWwcC0fCQUWGKVUDnaUlDKy8xvv7ocIkjuEIpGg/i9Z4qD8ThipdSJcCBhIRb/cxPsbgfWMznB4wBsHKRleI7GF65/lL31r6ke16Gy+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVt9QOH8; arc=pass smtp.client-ip=209.85.215.176
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c8ce8f2e235so193550a12.2
        for <linux-integrity@vger.kernel.org>; Thu, 25 Jun 2026 13:44:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782420295; cv=none;
        d=google.com; s=arc-20260327;
        b=fa84BMuQsvJpDjbldBSvaAjjBrhxb0pFO2ENSvdWSYN/gfj9btDbSbfYp2WxS9QQ+I
         AjquKOTivvwFcpiMF44vbaqjqb95ay2JGKNPEzRbYfFcK/KvWxD9eWjfkzBUTZTjgcZ3
         H4T1K+E7ZHu+SDSDynIAavd4oQyNGW4FFkkb/xFVjc8tDrtx/LhcjwRZ398s1orW0PTj
         IghI4hc9d+w4OsdR96CIsuK1JlG5q9yzNsC2GzugJB80cuU5NAEkD8yHpdxh2n3IKdSj
         9RnnJsH+fbZmYu8u1Mrh7V27EiBJmcuZ1ciCVLr0g0NHqqwyTEDqcKt066Lh46rAZ0JF
         gasw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p4nuJamRLnRW/kvnyuggLvvM8UuA505yMAZohH7ph0w=;
        fh=PYytkLOkCrbNhrLO3w/eiWe0XJSv1Gk7WaYe4/ln/DM=;
        b=NKadsbJfahN3Rwyp/vK97DQlaMREAU3wFtUh04Nv4r4lZU36DLAkKdLazyNZVYf54p
         TeqAdLBECeAFeZhRqAx4sQhCcoBdz9mu2OUMoNCbqcxCMkZ1Byy1I8TK+4bAXIL37cZg
         O4e+cqSMhsrgK/oQnIcuPnBgD2n8KA7aq1cNBN4+QDBvpqdhkQQfjUYBBqy399u62KU4
         GcRuXkc4OysJCGM3jZG9JjkqD4sbhCkVhraXRBhxWuk5E5EOAl0W1o/qhbH/ATR5pjCp
         bKCJvG1DyAycfleYQsUDGsRDEAYnjzqN0tPtmnMxPQLe3rcjleyr6OwsGqVs9nWdrpDe
         GyGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782420295; x=1783025095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4nuJamRLnRW/kvnyuggLvvM8UuA505yMAZohH7ph0w=;
        b=cVt9QOH85TZczzIKAW32WQbCke6oi2BzExTRrguWXJ53mLBPCyqikD/7rXtPYAYUE4
         RY0xEqimDJNhH/F/QZxsbtL2c/8Zct/VDrSkf17c/4VgQ518x5S+ao6WHbl6O8raGuVc
         IvuFjmRU97QWlC4wwkKSWHn0qi2wzUNT8Oe0hRoz3jXa/PAVLo7mYg1WKMfa0FrjHSuZ
         NCuOFwoRtUN2p/TrQ+uIoNs3dx7lNlnfIihxVAujVQ3NavHtOhH1KnY14YIV0RPZP371
         bDc3BlbBqVKeTW4+R9tCFGpP5eEVSBDqSQlZ+3MD17Rk14y9t75m1fL393UV1vgHlc0g
         6lOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782420295; x=1783025095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p4nuJamRLnRW/kvnyuggLvvM8UuA505yMAZohH7ph0w=;
        b=FqC59TjfqF2DoMnEOvqydGcvrO1Imt/X35HzNYCKDhqD0rSKflx/DU0MqvDJEhyotC
         rlTC714MtZTjJKV+2FjXoO8zKm17a+gwMlHJHnnszKd/lL3rhQuK9oEEGEITl0wtR31+
         9q8SfTrY3cL9ogxl8mnLqjJ9ar69OV1+Ishs1pjdznBnixQ+VSjkWnfBGaZwR9DWirke
         a6hOsmNSqbXSbeh2sAi0tscV+XlLMpFrdj5fafG7/6iBfRutha2QI94ES+Y10YxFQRFw
         /asPxzdbvrDYoxDqRLtKSL9lIPpW6IxMMXo7TGWp/6GKx2O7uI8mCmV1EyxSt2BD+B8L
         dy9Q==
X-Forwarded-Encrypted: i=1; AFNElJ866f4d2s3xY2ZLaCaez0kj12GHutJvH41EkJNF2zLp6+Rbqp8jy6AdRF3Vc/pKbajftjFa3W9cnfC7wORNDdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAH5yMKPwELU7tG5Ym6WR+KAeLSTX+y87UZ1wjcc/4BH2FDyZ9
	h9Agt2x+UXBmF3j+eOP9ji1Q+Nuz2PJkEYWExkXGoU5W3kkgoDgVAYAeUXjKBkR/tQOGkqiT31C
	P6jpdoU1Seb7Dfkz7Eow9T4GOfNO4FO8=
X-Gm-Gg: AfdE7cmJ2NOo5wfa3DHNO9VwACI0e5UTvV0R2ovbP3/OS4SuQo0DJJZ2aIxbXvyU4Ap
	Sdx+PMPEbvx8slQ4l2eDjFbE51UCaX5rvNNjNiJLZo2XpUXyQ6bBgyPVfgPF/h9jU39uzTuxPqe
	pvzoM4R1l+KcbSsbv3Jm8Xhu6xO9iXkIGkv8P36RRbZDJuZ1lRCrunvUE60RfN/NIgl7zv6waO+
	Nrx7upthhh8YKC8B6oRU9qpqYzOeLA6Sg/WhcoTIzQyX23F1q7oxzsXtcDQWZG2STUZoLkK4iJO
	SFWk6XJEvW+GXSqCSfrYNh4qyuKL/428dAdTsd5S+cTQTGFHA5KltXMPzZQgThmSQNfYbx4e6cq
	vI/M5jmBga2B0
X-Received: by 2002:a05:6a20:144f:b0:3b4:84de:aa79 with SMTP id
 adf61e73a8af0-3bd4b064fcdmr5342275637.44.1782420294988; Thu, 25 Jun 2026
 13:44:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618203411.73917-2-dwindsor@gmail.com> <75d39fd9847cca915d704235264ab474@paul-moore.com>
 <20260625-schnabel-rennmaschine-parieren-bcb352c3cf59@brauner>
 <CAADnVQKKr5cCYTj8qS7tU-Aeda1iexYUp5aquTjYXMEL656cJQ@mail.gmail.com> <CAHC9VhSXXHGRUmJ4YjQ6uEh6dbq7+h_0TwWiV+W5dUWXCTFcfg@mail.gmail.com>
In-Reply-To: <CAHC9VhSXXHGRUmJ4YjQ6uEh6dbq7+h_0TwWiV+W5dUWXCTFcfg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 25 Jun 2026 13:44:42 -0700
X-Gm-Features: AVVi8Cd1aiwx-Wi0FGOZBeYqi53u50Be8i1kd9zEsWrT9afz6qquacMnoCzNbM8
Message-ID: <CAADnVQJM15E0PwomdTiz8zvVMGkqs9mTSjYRdPBF6fgE=tsPCQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: Paul Moore <paul@paul-moore.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:paul@paul-moore.com,m:dwindsor@gmail.com,m:brauner@kernel.org,m:viro@zeniv.linux.org.uk,m:jack@suse.cz,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:kpsingh@kernel.org,m:mattbobrowski@google.com,m:jmorris@namei.org,m:serge@hallyn.com,m:zohar@linux.ibm.com,m:roberto.sassu@huawei.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:stephen.smalley.work@gmail.com,m:omosnace@redhat.com,m:casey@schaufler-ca.com,m:shuah@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:johnfastabend@gmail.com,m:dmitrykasatkin@gmail.com,m:stephensmalleywork@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9839-lists,linux-integrity=lfdr.de];
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
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,zeniv.linux.org.uk,suse.cz,iogearbox.net,linux.dev,etsalapatis.com,google.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,oracle.com,redhat.com,schaufler-ca.com,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[paul-moore.com:email,kernsec.org:url,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A928A6C8994

On Thu, Jun 25, 2026 at 1:40=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Jun 25, 2026 at 3:58=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Thu, Jun 25, 2026 at 7:23=E2=80=AFAM Christian Brauner <brauner@kern=
el.org> wrote:
> > > On 2026-06-23 20:12:32-04:00, Paul Moore wrote:
> > > > On Jun 18, 2026 David Windsor <dwindsor@gmail.com> wrote:
> > > >
> > > > > Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomical=
ly set
> > > > > xattrs via the inode_init_security hook using lsm_get_xattr_slot(=
).
> > > > >
> > > > > The inode_init_security hook previously took the xattr array and =
count
> > > > > as two separate output parameters (struct xattr *xattrs, int
> > > > > *xattr_count), which BPF programs cannot write to. Pass the xattr=
 state
> > > > > as a single context object (struct xattr_ctx) instead, and have
> > > > > bpf_init_inode_xattr() take that context directly. Update the exi=
sting
> > > > > in-tree callers of inode_init_security to take and forward the ne=
w
> > > > > xattr_ctx.
> > > > >
> > > > > A previous attempt [1] required a kmalloc string output protocol =
for
> > > > > the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all L=
SMs to
> > > > > provide xattrs for inode_init_security hook") [2], the xattr name=
 is no
> > > > > longer allocated; it is a static constant.
> > > > >
> > > > > Because we rely on the hook-specific ctx layout, the kfunc is
> > > > > restricted to lsm/inode_init_security. Restrict the xattr names t=
hat
> > > > > may be set via this kfunc to the bpf.* namespace.
> > > > >
> > > > > Link: https://kernsec.org/pipermail/linux-security-module-archive=
/2022-October/034878.html [1]
> > > > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git/commit/?id=3D6bcdfd2cac55 [2]
> > > > > Suggested-by: Song Liu <song@kernel.org>
> > > > > Signed-off-by: David Windsor <dwindsor@gmail.com>
> > > > > ---
> > > > >  fs/bpf_fs_kfuncs.c                | 106 ++++++++++++++++++++++++=
+++++-
> > > > >  include/linux/bpf.h               |   1 +
> > > > >  include/linux/bpf_lsm.h           |   3 +
> > > > >  include/linux/evm.h               |   9 +--
> > > > >  include/linux/lsm_hook_defs.h     |   4 +-
> > > > >  include/linux/lsm_hooks.h         |  16 ++---
> > > > >  include/linux/security.h          |   5 ++
> > > > >  kernel/bpf/bpf_lsm.c              |  10 +++
> > > > >  kernel/bpf/trampoline.c           |   3 +
> > > > >  security/bpf/hooks.c              |   1 +
> > > > >  security/integrity/evm/evm_main.c |   8 ++-
> > > > >  security/security.c               |   7 +-
> > > > >  security/selinux/hooks.c          |   4 +-
> > > > >  security/smack/smack_lsm.c        |  27 ++++----
> > > > >  14 files changed, 166 insertions(+), 38 deletions(-)
> > > >
> > > > I have a few specific comments below, inline with the patch, but I =
wanted
> > > > to make some general comments too.
> > > >
> > > > The kfunc additions really don't belong in the VFS kfunc file, plea=
se
> > > > create a LSM kfunc file (call it security/bpf_lsm_kfuncs.c) and add=
 the
> > > > kfunc code to this new file.
> > >
> > > We expose a bunch of VFS heavy operations for various security module=
s
> > > and this is really not different. For xattrs we have it all centraliz=
ed
> > > in the VFS and in general all VFS related bpf kfuncs should continue
> > > living there and be registered there. Anything that's just bpf infra
> > > specific can go to security/bpf/kfuncs.c instead. But anyway, it's a =
bpf
> > > specific helper so it's the bpf maintainer's call.
> >
> > Completely agree. This is vfs related kfunc and has to be
> > in fs/bpf_fs_kfuncs.c to make sure vfs maintainers review it now
> > and all future changes to it.
>
> *laughs*
>
> Okay, then split out the LSM specific stuff into
> security/bpf_lsm_kfuncs.c; all the LSM macros/defines/calls should be
> in the LSM kfuncs file.

Paul,

I'm sorry, but you didn't demonstrate the level of understanding
of bpf to be trusted to maintain any piece of it.

