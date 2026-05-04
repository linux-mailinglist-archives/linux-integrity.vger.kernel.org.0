Return-Path: <linux-integrity+bounces-9418-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDFkFvIg+Wmz5wIAu9opvQ
	(envelope-from <linux-integrity+bounces-9418-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 00:42:58 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4FC4C4805
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 00:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84F683025A43
	for <lists+linux-integrity@lfdr.de>; Mon,  4 May 2026 22:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA62338B14D;
	Mon,  4 May 2026 22:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UGi3Z9fJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8060C389473
	for <linux-integrity@vger.kernel.org>; Mon,  4 May 2026 22:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777934562; cv=pass; b=X8uYdxgCPiCrfPN9+OkhRidxXhQ61h8tz+F+xPvvRY1x/dsL9wPsghx4bMrBuGco1CaYfzd0v9KZ8nhMH3mdiobv+Me47Rg9mOK4ZCJU95JHchLWFpd6I6bFzDAN4OBJSbIUrsqwxMQdXAk/byQRe52aUp7ooamesIjo3uHMvEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777934562; c=relaxed/simple;
	bh=jrK/HiPlfROzpLQwuaupLlvkZBTy1nkn4zGH4/MZ46M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iyaKfvgvDFU39WStUWYrPh9y3kfkr44Bm8dzWYRkSOCuKlDxVNt9shG5I9wEl64/N3+we4HVq9FNOoBT1TK2OZ/GZZfTVmaS6eKsz0Y6+oSbsIKtYGVyMuN//Gm6QZBUA4d0xxfv+ox6VeKgdnHl9qAIjAyRbm1+DDu4HMiwnR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UGi3Z9fJ; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c822652f82aso883305a12.3
        for <linux-integrity@vger.kernel.org>; Mon, 04 May 2026 15:42:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777934560; cv=none;
        d=google.com; s=arc-20240605;
        b=hWPktSzRyFVDyNvMftQzwm/9762tJYv474n2TWC6nLG0xZkXbehlRR2lgJqYNfAT1/
         0GKLlFGE1xG4wqSQRqzTbRRxDqK5peLKik49R6KvG45oMbGlhXdfqB4bK+rH9MYqz9Ga
         gIf7ZUctQPMO67qw/mSawrQYGBJlwm97FggWCRXdrw+yJxDrE49wqsPD9m/swwt0cbxH
         7o7p2U31ZRrMrb4z3H1xcv+wEpf0l692ffzU2ouUOtIzDgtB/CIhxFPIknKgHLTnwA3E
         sza7+T2SV3zvZMB42oGWwVMzogarhIlrHqHOIqnMOey5fotHqKggVYyf+iFSD6M9Fc8R
         TlHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IXBRZAGpUpDHDZmPqiOWgzQrVjT26h5rDl2WnSWzU/8=;
        fh=CLV/XgXoHDF2YWkwk7afRR9LSOkww7ny9KTKGKYjL5E=;
        b=P0ivp7Vsl4uwYFwWL1lhdMXOGuuXD4AHI7yNMfNZEAPV3wze2t/JNWpiaV4p1IpvHN
         wp/24IhzedgrWCOoiFta4dUybAL1/TLkQThbwNHdiJbMPhgnE6LRbIWfGcc1VtD9TINK
         OataWN52adAPszUK2y0uB7PRXUG5xJ52hfZmmc2UiE+f3mpC5/UoEvLvgpWjlCEIBcWB
         dbPK9YDb1L33nq6JUzSW6zwfv3SmBeBVmmj17dq/kF91hVVMwHqZFbCZEafJLq+W3TzH
         XVmw0Nl2aXblHTibETeLK0Ndt03E698zjNeh8AhmWOPiS0udCZ2U4V35VXs86QIv6m/F
         yBng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777934560; x=1778539360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXBRZAGpUpDHDZmPqiOWgzQrVjT26h5rDl2WnSWzU/8=;
        b=UGi3Z9fJLfezyp0OJDVLLNFuIoLRa1wo0OTjff6UNOlY3ZRdPTNMPdO5YcjAc9iyOl
         agb1F/QUPJpTdLppeZa1vhhJ9CJWO6vuQAz0W6fnIwxs5/92na+qXx0bY7Z5CTFYp03C
         R6WaF18KHUojniaVITwSsnJ5fWLuAfuz1zDC+ZAacmzaXr7bNbFx7ZunXCjlp4VWhZ1l
         EfeBeF12UbEmxFtdekM345BWt6iU0Hf51Fujf50LqcFVmZoiCpoNsAgG6AojobDbZAxh
         x8ZpGDJ5PU+eN39u6K/ADsd6KozqsTsvdp6jpJI3RZbXjlm3X+o0N1H1nwDGuQonit9Y
         0kww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777934560; x=1778539360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IXBRZAGpUpDHDZmPqiOWgzQrVjT26h5rDl2WnSWzU/8=;
        b=E5YI9EgS9vKQwzbxkOLlBB91fOBJpMeTGKMgkddK9kBmcJy9D4dqUYCsoGhcYFOgkA
         VsD88GFaNajWtdANkKYgTA4r8VtWsNSUtoBg0ps7Ra6MT08wSlye9aLRlodgFPShgKdo
         R4v+HBUHZ3E2PV1ONxVPAXT0A0g+MRXlHTWauTepRWdPsw7HE5uQjJA8sHY9VXp8uOSH
         9op/mgGy+hUf7O3MQC5tbH5jyMW0t8VHZL2CJaqhAqc88DQ3BAb6I82ZLzwiMMDo+MOd
         4Dd2SqRCHV833m4nvpxY0NYvpg/Y2osiOojusAv7psUBjek6FZNWAfsmIPhg7fJQee/s
         XdVA==
X-Forwarded-Encrypted: i=1; AFNElJ98+jf+GRIJphr0pXcuTpwSp7E5gboSKIcXnFXYsMff339i9zmZKHO5ibPveqzkEgzlmnaC3tcCrmtpI5hvK1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCxtByEiP8xSiR4TqdyTBhE3Yv0/BzydNW2U4a8/RMOy86hDes
	l+exoi/ZJOgBRtTHWXK1zftHWSVn30eze8DhJwOSPsaPqIBWYqDKZra3/Zi02gQi0aVDbiAjofA
	7JL9mzIU2C37hM7a4sG54YP63eB4t81j4/8JDZ97y
X-Gm-Gg: AeBDiev4E4N8LRxrZBaLbwF0QdJz/TBGhgCGCdLN2k0G1kzauboo/W9/z9pqJnirI8s
	lFD+56ZD6i4P6Lpom2waGYJWBo9S1q2/k+4P0fY0bqc6bJDbDbFTptXrmPH485XnEtbPR4LlKCY
	h2W2YhQUciSWBuvVjhpbmG4RDiSN14fKXi+xsZjY+gYz8oovWdPvY+fvfBhUIk4qTYMTPg6tgEN
	fCNkuZhTzZ0czuYkXtFmf8xIxvMzPfJI6NFf/+zcaDecs2/8G4vzB+yc33qJ/1Yg/AKsAbDGgY4
	+1uMYY4ZW4Pr0LDapw==
X-Received: by 2002:a05:6a20:7350:b0:398:7792:3882 with SMTP id
 adf61e73a8af0-3a7f1ad975cmr12466464637.16.1777934559848; Mon, 04 May 2026
 15:42:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503211835.16103-1-dwindsor@gmail.com> <20260503211835.16103-2-dwindsor@gmail.com>
 <CAHC9VhSy5K5nQTtFUE4BScy1Ur61v7eZW067vTcUYDQeJb13Bw@mail.gmail.com> <CAPhsuW6sy2cdC4B7Z48-5A-yVX6fmVWxS_fWVjQxiX95KeUguw@mail.gmail.com>
In-Reply-To: <CAPhsuW6sy2cdC4B7Z48-5A-yVX6fmVWxS_fWVjQxiX95KeUguw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 4 May 2026 18:42:27 -0400
X-Gm-Features: AVHnY4JwC15TGqrqFYxmzxatkMEXynJIr-3OCdScUP6s2DMx5Fh0pwblgffVK-0
Message-ID: <CAHC9VhQLN5NA_ZMMNyUdMCZVdwC3VM4PUnzka8xDK5rpR2a3sw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: Song Liu <song@kernel.org>
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
X-Rspamd-Queue-Id: 1A4FC4C4805
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9418-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-integrity@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,zeniv.linux.org.uk,kernel.org,iogearbox.net,google.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,schaufler-ca.com,suse.cz,linux.dev,oracle.com,redhat.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,paul-moore.com:email,paul-moore.com:dkim,paul-moore.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Mon, May 4, 2026 at 5:40=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> On Mon, May 4, 2026 at 10:14=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> [...]
> > > diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> > > index 9d27be058494..193accc00796 100644
> > > --- a/fs/bpf_fs_kfuncs.c
> > > +++ b/fs/bpf_fs_kfuncs.c
> > > @@ -10,6 +10,7 @@
> > >  #include <linux/fsnotify.h>
> > >  #include <linux/file.h>
> > >  #include <linux/kernfs.h>
> > > +#include <linux/lsm_hooks.h>
> > >  #include <linux/mm.h>
> > >  #include <linux/xattr.h>
> > >
> > > @@ -353,6 +354,97 @@ __bpf_kfunc int bpf_cgroup_read_xattr(struct cgr=
oup *cgroup, const char *name__s
> > >  }
> > >  #endif /* CONFIG_CGROUPS */
> > >
> > > +static int bpf_xattrs_used(const struct lsm_xattr_ctx *ctx)
> > > +{
> > > +       const size_t prefix_len =3D sizeof(XATTR_BPF_LSM_SUFFIX) - 1;
> > > +       int i, n =3D 0;
> > > +
> > > +       for (i =3D 0; i < *ctx->xattr_count; i++) {
> > > +               const char *name =3D ctx->xattrs[i].name;
> > > +
> > > +               if (name && !strncmp(name, XATTR_BPF_LSM_SUFFIX, pref=
ix_len))
> > > +                       n++;
> > > +       }
> > > +       return n;
> > > +}
> [...]
> > > +
> > >  static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfu=
nc_id)
> > >  {
> > >         if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
> > > -           prog->type =3D=3D BPF_PROG_TYPE_LSM)
> > > +           prog->type =3D=3D BPF_PROG_TYPE_LSM) {
> > > +               /* bpf_init_inode_xattr only attaches to inode_init_s=
ecurity. */
> > > +               if (kfunc_id =3D=3D bpf_init_inode_xattr_btf_ids[0] &=
&
> > > +                   prog->aux->attach_btf_id !=3D bpf_lsm_inode_init_=
security_btf_ids[0])
> > > +                       return -EACCES;
>
> We need to mark bpf_init_inode_xattr with KF_RCU (requires a trusted
> pointer), then we can remove this check above.
>
> > >                 return 0;
> > > +       }
> > >         return -EACCES;
> > >  }
> >
> > Perhaps I'm simply not seeing it, but is there a check to ensure that
> > there is only one BPF LSM calling into security_inode_init_security()
> > at any given time?  With the BPF LSM only reserving a single xattr
> > slot, multiple loaded BPF LSM programs providing
> > security_inode_init_security() callbacks will be a problem.
>
> I don't think there is such a check. Also, a single BPF LSM function
> may call the kfunc multiple times, which is also problematic.
>
> I think we will need to make the default bigger, and also introduce
> some realloc mechanism for the worst case scenario. This should
> work, but the code might be a bit messy.

Thanks for the clarification, that is what I was afraid of when
looking at the code, but I was hoping I was just missing it.

Increasing the default is an option, but I don't think we want to
support a dynamic reallocation scheme for the xattr slots, that will
likely get extremely messy with synchronization between the LSM
framework and BPF LSM hook registrations as well as special code to
handle inodes with lifetimes that are disjoint from the BPF LSM
programs ... I suppose there may be a way to do it, but it will surely
be ugly and come at a cost.

--=20
paul-moore.com

