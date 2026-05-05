Return-Path: <linux-integrity+bounces-9423-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKliHMmy+Wld/AIAu9opvQ
	(envelope-from <linux-integrity+bounces-9423-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 11:05:13 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7914C91B3
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 11:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40E67303A90C
	for <lists+linux-integrity@lfdr.de>; Tue,  5 May 2026 09:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF473D6695;
	Tue,  5 May 2026 09:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQ+2iaMv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877613D16E9
	for <linux-integrity@vger.kernel.org>; Tue,  5 May 2026 09:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971622; cv=none; b=ty+VA7ylEmUn9LF39B3ITr3nkjcyBAhgPhN67ZHDhMlgbToXivqdYxi9yVgDVtbCj2k3ENkj7g+angSkVHNtjBWvy03j0pY0bL7n5GBwTyKe7N227UB5YYxCQur4lCHnjReKO+Quxab0xIN6EAZZheDzGmh11QHPvcHg2tPz+kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971622; c=relaxed/simple;
	bh=GtynK+QDnGUBQOJKvHqQ80Y68fNNiSCEP6oNzkZNKZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gYCuu97HTFsQ4bbvZ2iI8ZWbL2idSOHVQlb7aO02I+/n7BJSWo5OyQf4DkK4x/L/ck+7v9vMykkUzpYZ0uu6064K4w61KSv9DC8zxfjGhcWDycCF/phyv3FDwgBMGWXLurLOeuqBQjJUwDaWMunC7/zWytZzUZ2OCsFyJsQxwGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQ+2iaMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A203C2BCFC
	for <linux-integrity@vger.kernel.org>; Tue,  5 May 2026 09:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777971622;
	bh=GtynK+QDnGUBQOJKvHqQ80Y68fNNiSCEP6oNzkZNKZk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iQ+2iaMvprBkbqdSBJfABXbXXE1HirzM9Sulp25o/VrQpAqzzsXhEHB0L+k8duVoY
	 27Xi5fDo5ogec/JXicfmx0QFhfMAv6Wb1cxSX6/01tw+OZtLnsQXkOol9jtDHmnHTc
	 oWNQvyGT8giDM2N3DurQdrVQtcc+XNKlBV3f1q89L9hrx7Ponal3vKjYHKF/+hvAz0
	 fAxkEqDBRtnHCyItJ+gMbdpgc2t1nrhXldpxdv1w8MGxedg+TejZ9lIn54RHRODt79
	 LsuaeDIqSXMOTIgWcWmsNDEpvlpdkLjtseTRGTUQ9wt1JIdb6fMcKWs+Fz9KrAorCV
	 nnQvHDM5RXIEw==
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8d67a483d3eso574880585a.1
        for <linux-integrity@vger.kernel.org>; Tue, 05 May 2026 02:00:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/PNqrrrzi2unrQqq+nhjDkwJgP2c0VVWAW2KWhx4b2r5/vst3IzRRP8dA447DDRDisqjy2OK/y2yBUZn5muXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YytYf67nH09lkXyb33S0qtntJBbUjlpkOX8Azu5sDXhfq0/x0v5
	G+KxFeAyE+/kmSesHqQiigBOo9FWfktCZs2d0Ii/J1fWwc6X6aST5SAZhJ5v7iQhogIORHV3NYt
	0O2r2chHSuJlvHZAJxmAkC1rcAU8Z4Zc=
X-Received: by 2002:a05:6214:3012:b0:89c:4985:83e3 with SMTP id
 6a1803df08f44-8b6698d2a69mr214767286d6.49.1777971621057; Tue, 05 May 2026
 02:00:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503211835.16103-1-dwindsor@gmail.com> <20260503211835.16103-2-dwindsor@gmail.com>
 <CAHC9VhSy5K5nQTtFUE4BScy1Ur61v7eZW067vTcUYDQeJb13Bw@mail.gmail.com>
 <CAPhsuW6sy2cdC4B7Z48-5A-yVX6fmVWxS_fWVjQxiX95KeUguw@mail.gmail.com>
 <CAHC9VhQLN5NA_ZMMNyUdMCZVdwC3VM4PUnzka8xDK5rpR2a3sw@mail.gmail.com>
 <CAPhsuW5nDaLAV5UfAHeX6QPeF6bs-WDkFYOzYO7Q9_O6v=jEHA@mail.gmail.com> <CAHC9VhRx7L1WXYgQvWmGN0a7ssSaDKx4JPhup2E3W161sdp74A@mail.gmail.com>
In-Reply-To: <CAHC9VhRx7L1WXYgQvWmGN0a7ssSaDKx4JPhup2E3W161sdp74A@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 5 May 2026 11:00:08 +0200
X-Gmail-Original-Message-ID: <CAPhsuW5zRktottTujy_O1=8VkdJGDO71M3DVVM4ezffwT_dm+A@mail.gmail.com>
X-Gm-Features: AVHnY4JZRdCG9loGqSDCFw7FZrMfBgkgMT9QoL0A5yPckhp_yvZ1LkYDW4fZ9vI
Message-ID: <CAPhsuW5zRktottTujy_O1=8VkdJGDO71M3DVVM4ezffwT_dm+A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: Paul Moore <paul@paul-moore.com>
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
X-Rspamd-Queue-Id: CB7914C91B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9423-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,zeniv.linux.org.uk,kernel.org,iogearbox.net,google.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,schaufler-ca.com,suse.cz,linux.dev,oracle.com,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[song@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

On Tue, May 5, 2026 at 4:02=E2=80=AFAM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Mon, May 4, 2026 at 7:09=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> > On Tue, May 5, 2026 at 12:42=E2=80=AFAM Paul Moore <paul@paul-moore.com=
> wrote:
> > [...]
> > > > > Perhaps I'm simply not seeing it, but is there a check to ensure =
that
> > > > > there is only one BPF LSM calling into security_inode_init_securi=
ty()
> > > > > at any given time?  With the BPF LSM only reserving a single xatt=
r
> > > > > slot, multiple loaded BPF LSM programs providing
> > > > > security_inode_init_security() callbacks will be a problem.
> > > >
> > > > I don't think there is such a check. Also, a single BPF LSM functio=
n
> > > > may call the kfunc multiple times, which is also problematic.
> > > >
> > > > I think we will need to make the default bigger, and also introduce
> > > > some realloc mechanism for the worst case scenario. This should
> > > > work, but the code might be a bit messy.
> > >
> > > Thanks for the clarification, that is what I was afraid of when
> > > looking at the code, but I was hoping I was just missing it.
> > >
> > > Increasing the default is an option, but I don't think we want to
> > > support a dynamic reallocation scheme for the xattr slots, that will
> > > likely get extremely messy with synchronization between the LSM
> > > framework and BPF LSM hook registrations as well as special code to
> > > handle inodes with lifetimes that are disjoint from the BPF LSM
> > > programs ... I suppose there may be a way to do it, but it will surel=
y
> > > be ugly and come at a cost.
> >
> > BPF trampoline already handles all the synchronizations, such as
> > add hook, remove hook, etc. properly. So this is not that hard.
>
> How do you plan to handle the issue of disjoint lifetimes?
>
> > All we really need is to allocate a new array, copy pointers, and free
> > the old array. And we only really need this in the worst case
> > scenarios.
>
> Oh, is that all? :D
>
> Keep in mind that the code must also handle arbitrary ordering of
> LSMs; in other words, you must handle a BPF LSM that isn't at the end
> of the LSM order.  While a BPF LSM at the end of the LSM list is the
> most common, and recommended ordering for the vast majority of users,
> we've been working to make the ordering as generalized as possible.

All the BPF LSM hooks are called together, so it should be fine.
Maybe I missed some corner cases.

Either way, I agree with David that we don't need too many xattrs.
Since BPF LSM is reserved to the privileged users only, it is safe
to put a reasonable limit, say 4 or 8, and do not handle the realloc.
If the admin would like to brick a system with BPF LSM, there are
many other ways to do it.

Thanks,
Song

