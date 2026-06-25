Return-Path: <linux-integrity+bounces-9838-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dNHhK0eSPWrF4AgAu9opvQ
	(envelope-from <linux-integrity+bounces-9838-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2026 22:40:39 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 373E66C88ED
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2026 22:40:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=paul-moore.com header.s=google header.b=MFsW9Q5c;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9838-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9838-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=paul-moore.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A876D304349F
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2026 20:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4475136DA13;
	Thu, 25 Jun 2026 20:40:37 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF19346E56
	for <linux-integrity@vger.kernel.org>; Thu, 25 Jun 2026 20:40:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782420037; cv=pass; b=i87RFfbrPMFcO9dJKQHZucta6Et4EIYVj6XnmvtU7XhHtiW9b3cLUdcKnHVad26vpG+c5Y9YT6Y55VCtobKGc+vmStSinYYt3a7LL+H4BS7qGyafgOLOPalNSRcYr+lFedj4dEAojgNsfiwmNebe8gHKUARjwHP/YLpweRLaMPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782420037; c=relaxed/simple;
	bh=RyZsVwgwp6SsDCHuEWnfop0rVpAHFJuENw+MxHAhUEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iuQalpCPszrDPVk2JrE4drTpRPjpHOhuOjFNEOg35W5NN+Tve+BKs6m9cwwEmKH4jw2ta7GF0P86xZmqiHFRdk2TtQgmuNf2WFsSl6wgqK4K7I01dQ1GewzNpQrC7xOxleqOssuE5nQqsK838G2MKe7wbXd4ok3z+U2n2Ks2VDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MFsW9Q5c; arc=pass smtp.client-ip=209.85.216.50
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-37de8c6a2b6so198267a91.0
        for <linux-integrity@vger.kernel.org>; Thu, 25 Jun 2026 13:40:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782420035; cv=none;
        d=google.com; s=arc-20260327;
        b=qU51Qt0lWI910+Yk0Qe92+WlSlpTt2IOkr0T2B+kt0iqLw0z86+xkSFKcuNMzt4li4
         zMoqLzZPQIvHe0iOK1OyJBxIsf14bg+A6MUaNQkorBEsftaEJ5AJdCl4hYEUlYWjTSsu
         +Hscz3IfAqqib3TRHrC6Dze+vdo5p+Fo3nawWDDcA0MCsahvPGbhnivjF2qrEZajjcQ5
         SJYjV+C1VTSoGwa8i7bcT6UKpm0EyL0P3EKtQUxuV8Z1dPZa3rIuZdr4EAVoYuuQQqOA
         ISerGi4t4YsuOQvMa7Ck19CnUzYgPR9jp1aULu5kmOUZa6f1Z43MwIVjTVSBF8P+9zld
         XNyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+yx21f/fYo8TQI0aGf8AWSMgWBwIVqC4ciRZnA/Tpso=;
        fh=cI3VeDzNNGvdJfgs68IJV8WtQQbrTCfZTskgaQuwvpE=;
        b=lqrlRxkI4xOHYmhhT/U68EpQhwGW7U4myitAXOFmmo5i3vIquwLXqn2gS/kAe3IMNa
         gWuOXmVjB3/YiFURiY6tsFSB+KOWDygGhJCpGaWA7v036Emd3tMH+ugjfyKEb/KNEE/6
         NqOlQf3xwKCQv3PBQt/J6q1SOUFE/0dlVkYcUeqoZJMqeOErWv9QcFCvQOQ/593wejaj
         YWEy4fldNgAwPUXbVpctz3jtOGLSs0+SK2pzLfcksTTIBUk4/Yxy02bQ02MEZKQqtv3M
         lNePf0R3H/vi5JygZboTahKaKcrVLEZl8LNQ7JZUxz4hS/QDk4vihPlPH8EXvj6Q51Ta
         NpOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782420035; x=1783024835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yx21f/fYo8TQI0aGf8AWSMgWBwIVqC4ciRZnA/Tpso=;
        b=MFsW9Q5cwGycDxFIv1uTpQRDOXbfcxY/EiDTQvSiLgo4ZYkMuB9Pmrc1+YsaqzfH1D
         9DCVPc+P0+adZtcH0x5OgqmsneY6rOu7C2xAeoz/m5QpVGfAmlgr5Iee/asJtZJjXFAP
         r2GIk8tOPNWGes2h8n+EIxfyWX9EI6UVGbOzfyCdzq4CverDDtos7ZVd/N+qmyeNUhB6
         nicRrE0+AYncynkQN7d8+DJlEjFaSRja+6yT8gnVcgP1ncGULueRNJ0sWt3PhrYfNkkv
         pJZZwkZCknfioGQTu+A6NaXExUgbBzpoRp7vSMmkhMueQW1rgIM/ept+nhUYO7dUyuhF
         1HBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782420035; x=1783024835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+yx21f/fYo8TQI0aGf8AWSMgWBwIVqC4ciRZnA/Tpso=;
        b=amXBVy6xuddeCmZCor3LBXrMyct9Y4qmeoFCB1Q1FhnC/3jOimulx+5VmABEwOBo1h
         M7qiRnlsobMJYzwuxOrFWD0+RhQ/yWiA9YkCbnYRLS5HY116wP1nw9U3QqUPV6Oo8oHW
         IHme8q6vvI+JZhfII0nR08jYMFGs62GBe0WXjcBz16oeQXu5yEXFpmi7hqhaYsMlHVND
         JnEpae9CPKy+g2i/bkisAS7AA2F3DbZCRfL7CHs/+5TE/jxpdjsXCJOsTMrUyZmFYkA0
         Nrf00kW1usC7kXtf85yn4Qg+WV2veoipaKZmaG7oh6wlH68tg1ngLFfspPmn4r4Z/e1s
         TjfQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpy7PooMlVcI6cNQk6X+Mscnzmx8pHt4NBkKqNZsMV4DFiFY254J2w2IbaR2fkc1hXob1M0a6ResYa0nkFj200=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaoTzrgi2YdItj7mHk3UJ7M8+Cf7G/CeB14QLxoCS1WhX4OMxv
	UF7VMuVfiWkcBQd+FbkPxOHv/OiKt0tnjUaX3hzAWFbqKA5qgcitoK97yhkKJHQPmt9A0vOmHeN
	82D9Gtppo16ueD+76WgxbX8XhPa/uBHpFDwD0Z4jH
X-Gm-Gg: AfdE7cnRIbfCmyoKpq7O1muOIjL/MgYDNKa/0OaULLPywhesfc3F2nqIVDhlYfBlBeu
	4XYfyaF2F+9XpTupPBeM8CbefJb1yomyMPlnjwTHL93cGYmXnSxKHdzPdp/BA4Mdzy5Ce8Y3uao
	Esk1hHmOPJHXVgB87rGf85reUMq8fnNkwcBkTciQxTcfrxo+l8yVOKphkfRtNF6BK+WouwkRZDY
	MjvZL6/xltgSfGUrIRDL0jK5KhcDwGkoOa8QkT3dhwsav5vfKZJz0JwOvDdvoLh2xYLvYkV
X-Received: by 2002:a17:90b:5288:b0:35b:8d89:719b with SMTP id
 98e67ed59e1d1-37dfa1739fdmr3601231a91.1.1782420034987; Thu, 25 Jun 2026
 13:40:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618203411.73917-2-dwindsor@gmail.com> <75d39fd9847cca915d704235264ab474@paul-moore.com>
 <20260625-schnabel-rennmaschine-parieren-bcb352c3cf59@brauner> <CAADnVQKKr5cCYTj8qS7tU-Aeda1iexYUp5aquTjYXMEL656cJQ@mail.gmail.com>
In-Reply-To: <CAADnVQKKr5cCYTj8qS7tU-Aeda1iexYUp5aquTjYXMEL656cJQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 25 Jun 2026 16:40:21 -0400
X-Gm-Features: AVVi8CcDIUi3TCDxMODHgBDj-5EqkoBML23qr5aVxuP34LM8Xdw4wwqiCZTY1ss
Message-ID: <CAHC9VhSXXHGRUmJ4YjQ6uEh6dbq7+h_0TwWiV+W5dUWXCTFcfg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: David Windsor <dwindsor@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Christian Brauner <brauner@kernel.org>, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:dwindsor@gmail.com,m:alexei.starovoitov@gmail.com,m:brauner@kernel.org,m:viro@zeniv.linux.org.uk,m:jack@suse.cz,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:kpsingh@kernel.org,m:mattbobrowski@google.com,m:jmorris@namei.org,m:serge@hallyn.com,m:zohar@linux.ibm.com,m:roberto.sassu@huawei.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:stephen.smalley.work@gmail.com,m:omosnace@redhat.com,m:casey@schaufler-ca.com,m:shuah@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:alexeistarovoitov@gmail.com,m:johnfastabend@gmail.com,m:dmitrykasatkin@gmail.com,m:stephensmalleywork@gmail.com,s
 :lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9838-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[paul@paul-moore.com,linux-integrity@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	RCPT_COUNT_TWELVE(0.00)[35];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-integrity@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,zeniv.linux.org.uk,suse.cz,iogearbox.net,linux.dev,etsalapatis.com,google.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,oracle.com,redhat.com,schaufler-ca.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 373E66C88ED

On Thu, Jun 25, 2026 at 3:58=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Thu, Jun 25, 2026 at 7:23=E2=80=AFAM Christian Brauner <brauner@kernel=
.org> wrote:
> > On 2026-06-23 20:12:32-04:00, Paul Moore wrote:
> > > On Jun 18, 2026 David Windsor <dwindsor@gmail.com> wrote:
> > >
> > > > Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically=
 set
> > > > xattrs via the inode_init_security hook using lsm_get_xattr_slot().
> > > >
> > > > The inode_init_security hook previously took the xattr array and co=
unt
> > > > as two separate output parameters (struct xattr *xattrs, int
> > > > *xattr_count), which BPF programs cannot write to. Pass the xattr s=
tate
> > > > as a single context object (struct xattr_ctx) instead, and have
> > > > bpf_init_inode_xattr() take that context directly. Update the exist=
ing
> > > > in-tree callers of inode_init_security to take and forward the new
> > > > xattr_ctx.
> > > >
> > > > A previous attempt [1] required a kmalloc string output protocol fo=
r
> > > > the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all LSM=
s to
> > > > provide xattrs for inode_init_security hook") [2], the xattr name i=
s no
> > > > longer allocated; it is a static constant.
> > > >
> > > > Because we rely on the hook-specific ctx layout, the kfunc is
> > > > restricted to lsm/inode_init_security. Restrict the xattr names tha=
t
> > > > may be set via this kfunc to the bpf.* namespace.
> > > >
> > > > Link: https://kernsec.org/pipermail/linux-security-module-archive/2=
022-October/034878.html [1]
> > > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git/commit/?id=3D6bcdfd2cac55 [2]
> > > > Suggested-by: Song Liu <song@kernel.org>
> > > > Signed-off-by: David Windsor <dwindsor@gmail.com>
> > > > ---
> > > >  fs/bpf_fs_kfuncs.c                | 106 ++++++++++++++++++++++++++=
+++-
> > > >  include/linux/bpf.h               |   1 +
> > > >  include/linux/bpf_lsm.h           |   3 +
> > > >  include/linux/evm.h               |   9 +--
> > > >  include/linux/lsm_hook_defs.h     |   4 +-
> > > >  include/linux/lsm_hooks.h         |  16 ++---
> > > >  include/linux/security.h          |   5 ++
> > > >  kernel/bpf/bpf_lsm.c              |  10 +++
> > > >  kernel/bpf/trampoline.c           |   3 +
> > > >  security/bpf/hooks.c              |   1 +
> > > >  security/integrity/evm/evm_main.c |   8 ++-
> > > >  security/security.c               |   7 +-
> > > >  security/selinux/hooks.c          |   4 +-
> > > >  security/smack/smack_lsm.c        |  27 ++++----
> > > >  14 files changed, 166 insertions(+), 38 deletions(-)
> > >
> > > I have a few specific comments below, inline with the patch, but I wa=
nted
> > > to make some general comments too.
> > >
> > > The kfunc additions really don't belong in the VFS kfunc file, please
> > > create a LSM kfunc file (call it security/bpf_lsm_kfuncs.c) and add t=
he
> > > kfunc code to this new file.
> >
> > We expose a bunch of VFS heavy operations for various security modules
> > and this is really not different. For xattrs we have it all centralized
> > in the VFS and in general all VFS related bpf kfuncs should continue
> > living there and be registered there. Anything that's just bpf infra
> > specific can go to security/bpf/kfuncs.c instead. But anyway, it's a bp=
f
> > specific helper so it's the bpf maintainer's call.
>
> Completely agree. This is vfs related kfunc and has to be
> in fs/bpf_fs_kfuncs.c to make sure vfs maintainers review it now
> and all future changes to it.

*laughs*

Okay, then split out the LSM specific stuff into
security/bpf_lsm_kfuncs.c; all the LSM macros/defines/calls should be
in the LSM kfuncs file.

--=20
paul-moore.com

