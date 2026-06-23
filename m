Return-Path: <linux-integrity+bounces-9823-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rbvSJlECOmoT0AcAu9opvQ
	(envelope-from <linux-integrity+bounces-9823-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jun 2026 05:49:37 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 398796B3E14
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jun 2026 05:49:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=f2VXEIsq;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9823-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9823-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F4F8302D13A
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jun 2026 03:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430C738CFE8;
	Tue, 23 Jun 2026 03:49:29 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3969B27AC57
	for <linux-integrity@vger.kernel.org>; Tue, 23 Jun 2026 03:49:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782186569; cv=pass; b=GNvIGb9esZYNaD62Lx5S/SBabOVD9CBIFVAYa3QY356QQbQiK1uuMyaSNuGsHDKBig6yP6WdFoqVmCJy3nqBWqp+AeakMb+pB8nq1sJh4M1RL07kGdCIpGRjNedVaCz24vRCn4HOGzhZ5ORNQr5yL/WHBJZStlkT+X7EmwpI4ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782186569; c=relaxed/simple;
	bh=RR1hHV2J785WpEVHL0k8zZuvODXfgsvw/MD1CpAaxyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cwAbSoXelZB8JYKWpbI+fYsYNb164cktPiKpDMv+QAjNs5DH1hd7NuK0aTBNXV/c7+meRV9kW6dHLPyonomly83oPtv4C+qRUyokeScazBxd2FJT/JU42mV4ggqtH/pupD7QkfjjM6w3O7uXYCMXIC23COWh4jJGfXd5MmX5WoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2VXEIsq; arc=pass smtp.client-ip=209.85.219.45
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8df7a3a6fc3so47481376d6.0
        for <linux-integrity@vger.kernel.org>; Mon, 22 Jun 2026 20:49:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782186566; cv=none;
        d=google.com; s=arc-20240605;
        b=hjQ+bCm5sWV9eIZmDEIFxW0SAqp9DDi/UzrQA2cX7WV8RHoM7sndX//dWhBFoddR+v
         hHoiOnngQnCTYp7nIFCk5KiPNGYpYRA+up45AMjIqcX12sYIS2OD/OQl/yylRKxf+MBF
         h3OkOMCFBSiPxFzN6zUHAhWKlD0JIsqgye8Nwf7YfdzoQ/fwPJ9DBne+scyDmWRtcwyf
         5/i8MMjdQnplRTGtjUajbmuXW+r8yxWE1leyggALB3gv9VkjUx/aAoIQTyZoq93BCNjU
         9x2Eq0Gd6lzfFm744uEaLkj/ZDjdK2RrRS39ej5AU97xikj18W7Mo9oJ3/lZV/GqGRua
         y3MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hg2qvAeQyfTz4Manlgss62I8/Xh54jm/4GmfoVCRIRc=;
        fh=kLn7fzE5CrMq+pTxR1TbujNyL2RsmnqJVts4w6qq5ls=;
        b=Ym943NickBQnu0McqnvG91FccEYlnp/vzi65mXnXqNWrtu6rDtGvwE3FJT64xgMrug
         2Pqpim86HN11anD5bbyjMS+n7SNigy4zcCm78cIq8KcBuvxQ0LnjuskNURvHladFYnGk
         S5mrzq569iEozJ6oKWrIgXD+O19yexJdXpKo5Z7ggwi/B3FU2FufIM5k7wgDc9rOjy2b
         hPIyOYRFV82iRG4gHB0ZBXryCQsqV343KcynTpBCvQMJaDE4RQRYNl+WLtIZhe6hU036
         I+gATBzicUSxyBjsS9kWzZQuEyOCJctRVIUPL3YgfaF1CdIvMyJpb9L5OJ72TEmlGNiH
         Jqdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782186566; x=1782791366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hg2qvAeQyfTz4Manlgss62I8/Xh54jm/4GmfoVCRIRc=;
        b=f2VXEIsqUPpQtjzWk0AALYcAw5dv8DgPoC1lxGm4F7afw/MKVYqNjJNlgIpQXVMtgB
         dW5+xn/gyQj5jdqGUMXn+Jfp+EpOjWIh47APFF4MBi94JfvRNK62E0uyJceJpIZ8f19v
         NZAIB1LF6TxkN29Hp/30I1I+5xCSibfaWZpgPvb1wuPYAHHQ5QX1y5Bnz6TsJHlZbeec
         ufbpPfihOBmn6fcoPthWWE8D+UgNn1K1XFX8Jyfer0Y29qAdXkbr53xdgWpZ+JI1oEyX
         GB0KzvLZRKvJfuNkCb8lVZE0sn5SavxJfY1+yCEH7FZuZMAv9zqTicbx1jkwweQl5SyK
         1Cfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782186566; x=1782791366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hg2qvAeQyfTz4Manlgss62I8/Xh54jm/4GmfoVCRIRc=;
        b=qiikink93im/5Rrfc/G2HFXomhZVd70laRsD767I8wpVyfJNVa6+BBPWtTgD3QB3Wh
         uOx50oqarm36tZ52rbN/JbrdsUvMPyCFGxHbqeCI85K3sNXY+ESJ0FJc86WS2dgjjCkf
         iD3MGnR8ONlbXvfCWOfFxoKhvR8XwhkwcW50yF71Q4CvaTgRk6joM4u/uDv/p2P+wDkG
         SMTpHUaZ721jxfcoFYYSR8YT055ZLxjRYRTKzT80AnOTYBBtTovvNg52XWFAx8Dmqz/s
         C4cbHsKNr3Lvw5TGdoMDL74HjEc0iAJ/797ZgXojBJcucKCUuTBNXtJWj5Y8fZ5MYrNb
         r6yQ==
X-Forwarded-Encrypted: i=1; AHgh+RrsSScfsA6Vr0FB+oM9sj6I/4D/5lRyM10BtCUw0RjBGECeVXZyV2P60DrmUMSry3DZA4Ht5Gg+rhFAEPtlRgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9OVA8b8Mk0T0ys5zY2CFCaENCnZAYukB1kvmjUE7fBAXTS0ST
	MxgGJ8pVOxHRLvJ9+oau6YBbB7K+aHB/C+GR9yGHp0XMiv4jGWoQZqqvFtu5XaiOA7XWVCa3Gdi
	8q/+jO49scAWe3zddNLMZ4VYm9iXQ4r8=
X-Gm-Gg: AfdE7clqzQsuNjIsLclvYiuC/iAymJxooo2iPfX/DsLmQuuVDwvYDoH8FhRZUtrwQYS
	XAycaAgwud+3nSHRQB72HOMUhBC5QuG2U5KX2UkEHxp9MNEeB5j3ew6WEHIFItOCfE7prDa6MCC
	oYhB08rosPsw/7TzcqQOMHpUXkOjBAfuO+SRSbPKPYOn0kp9qfA/R8E7neQhZf74pBCupGZlKI0
	BqRpQX1p9OB349Q6ZF8eJMkGeWf+z9kDOG7kFKqmBswxVmo7a93haCa0EW4Qycy+t70gpy0Cke7
	R025wmZL1p2lOKh11xPjzW6FI/c=
X-Received: by 2002:a05:6214:c4a:b0:8dd:a358:ee8c with SMTP id
 6a1803df08f44-8df91338058mr230818586d6.23.1782186566075; Mon, 22 Jun 2026
 20:49:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618203411.73917-1-dwindsor@gmail.com> <20260618203411.73917-2-dwindsor@gmail.com>
 <DJFZGYZFMN73.1799LMXW49WZO@gmail.com>
In-Reply-To: <DJFZGYZFMN73.1799LMXW49WZO@gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Mon, 22 Jun 2026 23:49:14 -0400
X-Gm-Features: AVVi8CcisxKRwafLGJbgn3FDnILUrTQohjbGOcGFK09DM9CZwfDUyuni252s2_0
Message-ID: <CAEXv5_jVXS4JoExcd71YkXEE2WXPJ0_9STO-uCwgNF+Eia_h5w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
	linux-kselftest@vger.kernel.org
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
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:alexei.starovoitov@gmail.com,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:kpsingh@kernel.org,m:mattbobrowski@google.com,m:paul@paul-moore.com,m:jmorris@namei.org,m:serge@hallyn.com,m:zohar@linux.ibm.com,m:roberto.sassu@huawei.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:stephen.smalley.work@gmail.com,m:omosnace@redhat.com,m:casey@schaufler-ca.com,m:shuah@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:alexeistarovoitov@gmail.com,m:johnfastabend@gmail.com,m:dmitrykasatkin@gmail.com,m:stephensmalleywork@gmail.com,
 s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[dwindsor@gmail.com,linux-integrity@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-9823-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[35];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwindsor@gmail.com,linux-integrity@vger.kernel.org];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,iogearbox.net,gmail.com,linux.dev,etsalapatis.com,google.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,oracle.com,redhat.com,schaufler-ca.com,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 398796B3E14

On Mon, Jun 22, 2026 at 7:57=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu Jun 18, 2026 at 1:34 PM PDT, David Windsor wrote:
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
> > +     if (!xattrs || !xattr_count)
> > +             return -EINVAL;
> > +     if (bpf_xattrs_used(xattr_ctx) >=3D BPF_LSM_INODE_INIT_XATTRS)
> > +             return -ENOSPC;
>
> This check is good to have, but it's enough. No need to duplicate it.
> More below.
>

> > +
> >  static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc=
_id)
> >  {
> >       if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
> > -         prog->type =3D=3D BPF_PROG_TYPE_LSM)
> > +         prog->type =3D=3D BPF_PROG_TYPE_LSM) {
> > +             /* bpf_init_inode_xattr only attaches to inode_init_secur=
ity. */
> > +             if (kfunc_id =3D=3D bpf_init_inode_xattr_btf_ids[0] &&
> > +                 prog->aux->attach_btf_id !=3D bpf_lsm_inode_init_secu=
rity_btf_ids[0])
> > +                     return -EACCES;
>
> This is unnecessary. Only one hook will have xattr_ctx type.
> The normal verifier type enforcement will do its work.
>

Good point, thanks.

> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index 1a721fc4bef5..b41b02173e24 100644
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
> No need. The check inside kfunc is enough.
>

Paul wanted this check because it occurs at bpf prog attach time,
whereas the one in the kfunc is at inode creation time.


> >       if (!hlist_unhashed(&node->tramp_hlist))
> >               /* prog already linked */
> >               return -EBUSY;
> > diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> > index 40efde233f3a..d7c44c5c0e30 100644
> > --- a/security/bpf/hooks.c
> > +++ b/security/bpf/hooks.c
> > @@ -30,6 +30,7 @@ static int __init bpf_lsm_init(void)
> >
> >  struct lsm_blob_sizes bpf_lsm_blob_sizes __ro_after_init =3D {
> >       .lbs_inode =3D sizeof(struct bpf_storage_blob),
> > +     .lbs_xattr_count =3D BPF_LSM_INODE_INIT_XATTRS,
> >  };
> >
> >  DEFINE_LSM(bpf) =3D {
> > diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm=
/evm_main.c
> > index b59e3f121b8a..e0a05162accc 100644
> > --- a/security/integrity/evm/evm_main.c
> > +++ b/security/integrity/evm/evm_main.c
> > @@ -1062,14 +1062,16 @@ static int evm_inode_copy_up_xattr(struct dentr=
y *src, const char *name)
> >   * evm_inode_init_security - initializes security.evm HMAC value
> >   */
> >  int evm_inode_init_security(struct inode *inode, struct inode *dir,
> > -                         const struct qstr *qstr, struct xattr *xattrs=
,
> > -                         int *xattr_count)
> > +                         const struct qstr *qstr,
> > +                         struct xattr_ctx *xattr_ctx)
>
> the rest looks good.
> Pls split the patch. Introduce xattr_ctx first across the LSMs.
> Then another patch with a new kfunc.
>
> pw-bot: cr

