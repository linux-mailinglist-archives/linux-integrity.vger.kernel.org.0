Return-Path: <linux-integrity+bounces-9835-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7el9OwI6PWoazggAu9opvQ
	(envelope-from <linux-integrity+bounces-9835-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2026 16:24:03 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B56E06C697E
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2026 16:24:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Oz1c07kk;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9835-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9835-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2F4083021CA3
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2026 14:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4DE36827E;
	Thu, 25 Jun 2026 14:23:59 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BF0363084;
	Thu, 25 Jun 2026 14:23:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782397439; cv=none; b=SR2jORAgZGYM0r3eNoGHgnwTzCY5ioWuiH/b5cJKo4ebeh+ws4LD5GCSHAzJH/7fmgWTyxlf5YSd42gWcqO5tH6qyYrZKMgYeEN3bGIAXxPdlUii8ob2YzXG8RITyNLBnlewMgfNcMlMwF7ilBgZRUqUgDBu7oq5OSZgtKks39I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782397439; c=relaxed/simple;
	bh=NNO35ZyHK/r7ijYBDhwLPiIZ3wWD+t05OGJl+8ydVYA=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=UxnN9tR9EQr2G3rTkPSBW29VOWBzPoeNTsaPOP+FcUCIr0x7CIsOuyrsaLlKR5hzyDcZP3ETIh+0GxL1rIMuMMs2ZTa5RRLw9ZltyzNUlPdbfKKhefRdhpPZt6XCIKOj5vck5UGmfRz33KNEc3HWpU0w8fjdWtnaImXoq6sEOeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oz1c07kk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2082F1F000E9;
	Thu, 25 Jun 2026 14:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782397438;
	bh=6atzj4kdhKh25A+taHkGxSsDJim9lth3hiEmW+J2u/Y=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Oz1c07kkv4QRwYt9flB1pDhTg2X/Yep0XMYrVamssz5nW/L/I0I2xsAriiCamTvyG
	 DoSc0tlA4uDhI5jTx20W+bwFWzW2wiHoUTwsQxNVT25/TX7NjVMiUAhVHcN1eH7NSh
	 5vFKgIQXCYVpE6RssSuq4qedXvk7xgpIDyqja17KJsRcgpTzIxejiTxONeAUsEfN9r
	 cA0BLfTMd2o1gexGnDumcsOvZymXoyDCjFrJaohj5rl+2C9LuRZhrJ6e0ou2hXKx95
	 s87/RtdzKQmIbTx1UeZL21E9vDNZyzW39pUAiEGbfNBnetKsYblpPl+VDZhw3aeDsk
	 cxUKss8Wb1Z2w==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
From: Christian Brauner <brauner@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: David Windsor <dwindsor@gmail.com>, viro@zeniv.linux.org.uk, 
 brauner@kernel.org, jack@suse.cz, ast@kernel.org, daniel@iogearbox.net, 
 john.fastabend@gmail.com, andrii@kernel.org, eddyz87@gmail.com, 
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
 kpsingh@kernel.org, mattbobrowski@google.com, jmorris@namei.org, 
 serge@hallyn.com, zohar@linux.ibm.com, roberto.sassu@huawei.com, 
 dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
 stephen.smalley.work@gmail.com, omosnace@redhat.com, casey@schaufler-ca.com, 
 shuah@kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
 selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
In-Reply-To: <75d39fd9847cca915d704235264ab474@paul-moore.com>
References: <20260618203411.73917-2-dwindsor@gmail.com>
 <75d39fd9847cca915d704235264ab474@paul-moore.com>
Date: Thu, 25 Jun 2026 16:23:48 +0200
Message-Id: <20260625-schnabel-rennmaschine-parieren-bcb352c3cf59@brauner>
X-Mailer: b4 0.16-dev-d56bb
X-Developer-Signature: v=1; a=openpgp-sha256; l=3026; i=brauner@kernel.org;
 h=from:subject:message-id; bh=NNO35ZyHK/r7ijYBDhwLPiIZ3wWD+t05OGJl+8ydVYA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTZWn7r1/j16eqjzRyrXL/MuK516rPLuUMmqvyFT8UvL
 D8YVd58oqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAidrUM/3SmyqvdtOr1PfGz
 /ZHvK1aPr7qz7VUuOB+IOG+wX+BZmywjwxYvIfmnnx+u0J5QfoX9++O0+Xf5efbf97NgZbT48X7
 3PmYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[brauner@kernel.org,linux-integrity@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[35];
	FORGED_RECIPIENTS(0.00)[m:paul@paul-moore.com,m:dwindsor@gmail.com,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:kpsingh@kernel.org,m:mattbobrowski@google.com,m:jmorris@namei.org,m:serge@hallyn.com,m:zohar@linux.ibm.com,m:roberto.sassu@huawei.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:stephen.smalley.work@gmail.com,m:omosnace@redhat.com,m:casey@schaufler-ca.com,m:shuah@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:johnfastabend@gmail.com,m:dmitrykasatkin@gmail.com,m:stephensmalleywork@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9835-lists,linux-integrity=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-integrity@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,zeniv.linux.org.uk,kernel.org,suse.cz,iogearbox.net,linux.dev,etsalapatis.com,google.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,oracle.com,redhat.com,schaufler-ca.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,kernsec.org:url,brauner:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B56E06C697E

On 2026-06-23 20:12:32-04:00, Paul Moore wrote:
> On Jun 18, 2026 David Windsor <dwindsor@gmail.com> wrote:
> 
> > Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically set
> > xattrs via the inode_init_security hook using lsm_get_xattr_slot().
> > 
> > The inode_init_security hook previously took the xattr array and count
> > as two separate output parameters (struct xattr *xattrs, int
> > *xattr_count), which BPF programs cannot write to. Pass the xattr state
> > as a single context object (struct xattr_ctx) instead, and have
> > bpf_init_inode_xattr() take that context directly. Update the existing
> > in-tree callers of inode_init_security to take and forward the new
> > xattr_ctx.
> > 
> > A previous attempt [1] required a kmalloc string output protocol for
> > the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all LSMs to
> > provide xattrs for inode_init_security hook") [2], the xattr name is no
> > longer allocated; it is a static constant.
> > 
> > Because we rely on the hook-specific ctx layout, the kfunc is
> > restricted to lsm/inode_init_security. Restrict the xattr names that
> > may be set via this kfunc to the bpf.* namespace.
> > 
> > Link: https://kernsec.org/pipermail/linux-security-module-archive/2022-October/034878.html [1]
> > Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6bcdfd2cac55 [2]
> > Suggested-by: Song Liu <song@kernel.org>
> > Signed-off-by: David Windsor <dwindsor@gmail.com>
> > ---
> >  fs/bpf_fs_kfuncs.c                | 106 +++++++++++++++++++++++++++++-
> >  include/linux/bpf.h               |   1 +
> >  include/linux/bpf_lsm.h           |   3 +
> >  include/linux/evm.h               |   9 +--
> >  include/linux/lsm_hook_defs.h     |   4 +-
> >  include/linux/lsm_hooks.h         |  16 ++---
> >  include/linux/security.h          |   5 ++
> >  kernel/bpf/bpf_lsm.c              |  10 +++
> >  kernel/bpf/trampoline.c           |   3 +
> >  security/bpf/hooks.c              |   1 +
> >  security/integrity/evm/evm_main.c |   8 ++-
> >  security/security.c               |   7 +-
> >  security/selinux/hooks.c          |   4 +-
> >  security/smack/smack_lsm.c        |  27 ++++----
> >  14 files changed, 166 insertions(+), 38 deletions(-)
> 
> I have a few specific comments below, inline with the patch, but I wanted
> to make some general comments too.
> 
> The kfunc additions really don't belong in the VFS kfunc file, please
> create a LSM kfunc file (call it security/bpf_lsm_kfuncs.c) and add the
> kfunc code to this new file.

We expose a bunch of VFS heavy operations for various security modules
and this is really not different. For xattrs we have it all centralized
in the VFS and in general all VFS related bpf kfuncs should continue
living there and be registered there. Anything that's just bpf infra
specific can go to security/bpf/kfuncs.c instead. But anyway, it's a bpf
specific helper so it's the bpf maintainer's call. 


