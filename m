Return-Path: <linux-integrity+bounces-9824-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1EDoFpoEOmqS0AcAu9opvQ
	(envelope-from <linux-integrity+bounces-9824-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jun 2026 05:59:22 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2DE6B3E9F
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jun 2026 05:59:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ayc6Yxc9;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9824-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9824-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13CFB30262DA
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jun 2026 03:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF66539A4AA;
	Tue, 23 Jun 2026 03:59:15 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A773890E3
	for <linux-integrity@vger.kernel.org>; Tue, 23 Jun 2026 03:59:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782187155; cv=pass; b=Cf9QjGvkG6EYhbKoOqqUZTYD3VmxXrECdeCDeUpZ4JRKlh7T/zzAi63Ee4I61pivPUlXxwMooOfBB9/plbJiBvU895fnaebtYQN8H0Rh+WZLXGwVTQVJcF5t7vO4UQ+MYL3sxH8nIWuFEPhcii5JzjLvfpBXTRGFsuxBa1AcBkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782187155; c=relaxed/simple;
	bh=gG3nM6GM0xXcee7k3sO2+otJiw1n1BGZCjCkgApMqe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bum7orSfIhB/jFBcdfvfOfdyJODB4qKtRboFklU+Rj1ZEJez6Eswz5LFuom5tFb5S2Zp68o9T1ypMiIMY2NNm+un8K+ACsx4NBPFC0ETs1kCvxEtiHQ3aa3LVuOLMZ2pgxRcgUJkASsALfDog2pkMr6xhC6B0TqNltlSXEipxAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayc6Yxc9; arc=pass smtp.client-ip=209.85.214.172
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c6c101aeafso32713265ad.0
        for <linux-integrity@vger.kernel.org>; Mon, 22 Jun 2026 20:59:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782187153; cv=none;
        d=google.com; s=arc-20240605;
        b=gP/pEmGvyg0KE4zqVWhcAsyyc+gi6dSxixi1KPyPY4V+OXABk9KsTFa0biF7yU5PhA
         GKiuFQxmByh6/PnVVi5VlD6pJ+WIBTvaKHhUzblP1GVGOM1WmOBHCD45V5c7UkQywJ5T
         TpIibr2E1n36HI2KQC5rh3afBCQNJyk1bI0kZqf4e4KSH12Y8SflNeCCu6iAnUv4MmjE
         dP05DwNzW23pEDXw9p5+j0reCQ/jxtsxqvNKhD7FPp3TLI6L2OG8jIYzErYSo3Y2VSJK
         dlPAOshtG4tyLpATyHDyv3qny4u60tjXLyE6TD49lkFZjcQyVnN2YSZX8wHX13wJLYMS
         EBWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fv4+YQzwW9vJ3yUowssNEEOn5d5CfHMnYf5q6sRM4Aw=;
        fh=M4iwt+bifBcQBzecdNSNuJS4qQJFpvyGCzmUHG0/XoA=;
        b=cmJ86bka6D3PFFyVpP0DPZZw+5ZnLpAJpxXttqw1zvbWCC5yUl8NvemIKM3TDCVqey
         UmGdM5LWoEtgKa86bjIzXcmOEPgQz/r/i7g6Mk+WctNWU6+GwsYCNgDcr6WYG7Eq4grv
         LtopUInbC0e2WPDVWIy2alZ21x4mh9MLMxikBA51MCKliWyCJ0r4erz3raJ5S/oHVi+n
         /wNTEeUVQKOo+F62K/5GEeZ4a2IwnTDVTtrRErFqu0oElRH1xU00UiAzIFsLhi04s22/
         1LtEqzpQDaFTU0qtvomZSbsKw++ErmbgdlISHf2rSqm3LnLjq8Yi7zXHhnaAOAnfbh5B
         zSyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782187153; x=1782791953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fv4+YQzwW9vJ3yUowssNEEOn5d5CfHMnYf5q6sRM4Aw=;
        b=ayc6Yxc9BZ+MZUTfJWUjsUjR6/AmNZnL8Egi5GytMU1FqCvZDNwOE7s9xkQgfiztdR
         nn4jlG1gEP78vF/wMFDw8ZTiKMBvy6GjmBy58WtRFUjFfG2V+u5XAAY7w46Umife8eo4
         qgQIM+1syaO/b2udQFkxZ7jSfGNGACFkI2L+6E0oZqfxuHmPaMTbJHenO6rubQThlvf6
         IDKcvkU59HSHmQBC4k2UWtPEk2TmMMqqQhgwttGAdhfDFjuCbbnKbl/0gH7QzexsqcgP
         d0WhSZcBajAwY5rIT2/lcz1WT6GLNYVvfcU3GF7DH7yfScHes7q+viapvK0ytMpyzOXI
         YRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782187153; x=1782791953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fv4+YQzwW9vJ3yUowssNEEOn5d5CfHMnYf5q6sRM4Aw=;
        b=W7QGtl7N1XkbEKJULpGx8W6GK5UIM0Fj0tyYFs+liwMvP4UAJVvyouXFLqQBnkFGCg
         Obgv+GefVdtcQSj5u1bjEuEzzdvswSr3UnG+JZvQMyDt6ZzdS4hwUIgbBaSWa1G2BbyR
         Q9t2f4iBl38FLhkcpTY2SXkEG3JDBCLxlqSyI+wGiNwTYsKF4nmp51AbsSiuI8BmGWM0
         vZE+7Lwfi/yt3Nj4TnwV2+yRUG2+Z9mw3hdVpLTTPRZl068qDt1LMULOqSVZViEnebTZ
         12ZlpAv1yt14sTQYhxpM/ECNyPwQdAUy7+U30Gl1M3X+F1AjsxXWam/gKGM0XxhWw8yH
         4feA==
X-Forwarded-Encrypted: i=1; AHgh+Rqth6CVRpjKmVUhkYYprALsvOad8Tw/mahUql4K6K7eRHjlFbJpgGAoiz7GlFrZEMuHaMToCj76+puNWlS6ZDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCXv9ZuWDr7isnPmnUPrMWCd2QToSNSKmwv4AYUFTro+o4p3C+
	fGC+QPmfd4FuODpX1DJthwYb9vyy3qzRfjkjucRIsBBYYUwu9kWmKD11GETLDv781p1bB0TjA17
	tMOMVWAhmELeW5g+ngrsyv+G+iuLBjj4=
X-Gm-Gg: AfdE7cm79Vx7EP7FjSfzzor1Ci22IA0snEwzB00wZhKQGRDzfrXd2VXrkNgHhhPdeN+
	c9ee5QDYogeIhJa3Yv+7n/RizllnrK6sD/X2Q7zAZj0eHj/uVA3MtWMLMaj8icP0mTShMJ6CVFC
	UI5Lx2LTQLyV/sSCfGk5cK1WyjGb5UTDMUtKRSpNjh8CvXr7A0sQktAvwiqxCZ2emyHV4oeQlSY
	+3I4jXVM11ujKEzv+csxvwNQ3OKkp/PQvIP8+rho9t0l4wDTUw6/7kkJUn4DAnYPNsq/x2bzFmh
	HX62nE1XJnKrLxCLL1NkeFfl1e3BN3ctCI8U4OwaOYlDvBIzTQwesVkV7Yf4qQHM+d6DmXAz544
	AUv/rXuW7u8hhyQ==
X-Received: by 2002:a17:902:db04:b0:2c6:bb31:4564 with SMTP id
 d9443c01a7336-2c7c9ae9c89mr6495325ad.34.1782187153306; Mon, 22 Jun 2026
 20:59:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618203411.73917-1-dwindsor@gmail.com> <20260618203411.73917-2-dwindsor@gmail.com>
 <DJFZGYZFMN73.1799LMXW49WZO@gmail.com> <CAEXv5_jVXS4JoExcd71YkXEE2WXPJ0_9STO-uCwgNF+Eia_h5w@mail.gmail.com>
In-Reply-To: <CAEXv5_jVXS4JoExcd71YkXEE2WXPJ0_9STO-uCwgNF+Eia_h5w@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 22 Jun 2026 20:59:01 -0700
X-Gm-Features: AVVi8CcolJU9x8Dp8q7P56rN1jCQzLpqqLG-VPMeXHQRVjQ7aayUcNcv-uHuUCc
Message-ID: <CAADnVQJsdrL2RjxM4UE1WyWrT9KsprFP+=xLHRtFhUSccDqQcg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: David Windsor <dwindsor@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
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
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:dwindsor@gmail.com,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:kpsingh@kernel.org,m:mattbobrowski@google.com,m:paul@paul-moore.com,m:jmorris@namei.org,m:serge@hallyn.com,m:zohar@linux.ibm.com,m:roberto.sassu@huawei.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:stephen.smalley.work@gmail.com,m:omosnace@redhat.com,m:casey@schaufler-ca.com,m:shuah@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:johnfastabend@gmail.com,m:dmitrykasatkin@gmail.com,m:stephensmalleywork@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[alexeistarovoitov@gmail.com,linux-integrity@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-9824-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[35];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,linux-integrity@vger.kernel.org];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,iogearbox.net,gmail.com,linux.dev,etsalapatis.com,google.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,oracle.com,redhat.com,schaufler-ca.com,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB2DE6B3E9F

On Mon, Jun 22, 2026 at 8:49=E2=80=AFPM David Windsor <dwindsor@gmail.com> =
wrote:
>
> On Mon, Jun 22, 2026 at 7:57=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu Jun 18, 2026 at 1:34 PM PDT, David Windsor wrote:
> > > +
> > > +static int __bpf_init_inode_xattr(struct xattr_ctx *xattr_ctx,
> > > +                               const char *name__str,
> > > +                               const struct bpf_dynptr *value_p)
> > > +{
> > > +     struct bpf_dynptr_kern *value_ptr =3D (struct bpf_dynptr_kern *=
)value_p;
> > > +     size_t name_len;
> > > +     void *xattr_value;
> > > +     struct xattr *xattr;
> > > +     struct xattr *xattrs;
> > > +     int *xattr_count;
> > > +     const void *value;
> > > +     u32 value_len;
> > > +
> > > +     if (!xattr_ctx || !name__str)
> > > +             return -EINVAL;
> > > +
> > > +     xattrs =3D xattr_ctx->xattrs;
> > > +     xattr_count =3D xattr_ctx->xattr_count;
> > > +     if (!xattrs || !xattr_count)
> > > +             return -EINVAL;
> > > +     if (bpf_xattrs_used(xattr_ctx) >=3D BPF_LSM_INODE_INIT_XATTRS)
> > > +             return -ENOSPC;
> >
> > This check is good to have, but it's enough. No need to duplicate it.
> > More below.
> >
>
> > > +
> > >  static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfu=
nc_id)
> > >  {
> > >       if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
> > > -         prog->type =3D=3D BPF_PROG_TYPE_LSM)
> > > +         prog->type =3D=3D BPF_PROG_TYPE_LSM) {
> > > +             /* bpf_init_inode_xattr only attaches to inode_init_sec=
urity. */
> > > +             if (kfunc_id =3D=3D bpf_init_inode_xattr_btf_ids[0] &&
> > > +                 prog->aux->attach_btf_id !=3D bpf_lsm_inode_init_se=
curity_btf_ids[0])
> > > +                     return -EACCES;
> >
> > This is unnecessary. Only one hook will have xattr_ctx type.
> > The normal verifier type enforcement will do its work.
> >
>
> Good point, thanks.
>
> > > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > > index 1a721fc4bef5..b41b02173e24 100644
> > > --- a/kernel/bpf/trampoline.c
> > > +++ b/kernel/bpf/trampoline.c
> > > @@ -859,6 +859,9 @@ static int bpf_trampoline_add_prog(struct bpf_tra=
mpoline *tr,
> > >       }
> > >       if (cnt >=3D BPF_MAX_TRAMP_LINKS)
> > >               return -E2BIG;
> > > +     if (node->link->prog->aux->attach_limit &&
> > > +         tr->progs_cnt[kind] >=3D node->link->prog->aux->attach_limi=
t)
> > > +             return -E2BIG;
> >
> > No need. The check inside kfunc is enough.
> >
>
> Paul wanted this check because it occurs at bpf prog attach time,
> whereas the one in the kfunc is at inode creation time.

Sorry, we're not adding redundant code to the verifier.

