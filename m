Return-Path: <linux-integrity+bounces-9420-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLtpNvNC+WmX7QIAu9opvQ
	(envelope-from <linux-integrity+bounces-9420-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 03:08:03 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6344C59D7
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 03:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2EC923019444
	for <lists+linux-integrity@lfdr.de>; Tue,  5 May 2026 01:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC45347BC4;
	Tue,  5 May 2026 01:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qTVpH+gh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBABC2FD69A
	for <linux-integrity@vger.kernel.org>; Tue,  5 May 2026 01:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777943279; cv=pass; b=m37FT00x5raBlUEIb4GZKOh93du5IzpISE+z18ma1zcmqbDMzX287udw3wbud6mIgl6VWcT3dET01uMohgVENAhRuZ9rfD084iI3xGv3kn32+IFgOl1iwWGVkidErmZKeEMs4QhawrhMAzplt2vrV5gUbIRnJfo7+ReF3TXpM+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777943279; c=relaxed/simple;
	bh=h25CviPPheRk/GDUJ4W9hQ0/45Mh6Y0yTtuThhLME2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ie0PD717rJzoS9V1Q/mad5erTsor0M3Q0OxUuXs7iru8N3V05yqPxegvhwweQKNtGyonCNgAxtEzpwbW1fdrUBuFQSZK68/ElvHzc0LMcMg+pwFfV45cb0SqouSCLXawu0g5T47dRJz9ysiRDzH/BpxwHR1djhLg7WaHUDkCX+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qTVpH+gh; arc=pass smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8b5cda2dab9so28269046d6.0
        for <linux-integrity@vger.kernel.org>; Mon, 04 May 2026 18:07:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777943277; cv=none;
        d=google.com; s=arc-20240605;
        b=k15kArWgq6OaTAkvLTc5HzQOdhX4BCknmWWZNzW3JtT3lHvQ/5gYsc51P0t3S1w4OP
         e3ERccK/qWNtnIllN4gnxkHGn35qRb/25pa0jUBquRbWoUb3LCPyTCpS/AtNdimKGYEY
         fl7AapgTqmqNVprdqREVu5T+I30qDM9nQBkcE0oPjJTFE+FUJ/oCTF5e3IR2vj01FB/Z
         0g/rRUzbpj+xKjeysVQkykejMRUOiHE4xGUw5QF36GkFjGkdIIUL2Zcp08ZDHgYQFHri
         +pX36RgW3c/dmzz3KGHcRbpPk7wF0+8sX5bvdkrzwpqTthrqP9F/Zot9FqV/qQc+js3c
         co2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hBjcwpnTtESMydnEYbNcBRuOTt7JQKpfxpc/oQOpx+s=;
        fh=rqY55LGv8LdGaevBnURsrb///Ol+QAmgD/+ND02sekc=;
        b=NOuaIT2iQMxJmVL/5f7eq2GRBhWDoxdFuDWQBvog/vWYnzDSVrU34q8msUfcAoGAar
         LdYkM7yzo3JBpq6bEL8oc9IodbnFCnWIGBLbSg7MTU4wTzwr3FPKFPbKYZQ6smgp40Wk
         IT/uGokG9Hf6uFmZ/3dur3r2yAx7d6FcKmfplftV+Eim/YBEHQMkMRAysT6FrxlD42uh
         iQCSYvw02xzPeXqQhJLqSY6Xhc4WhPMcBi7VPN4PNA/fy61UqAir0+jNIMavNMOA/R/+
         rh2Aza93TpruDWqLPvF0hIIs/t1T5nSgbP2e4T2VSKrHJxzuIyN6LrXFYwFQlz+7XjfS
         ATig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777943277; x=1778548077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBjcwpnTtESMydnEYbNcBRuOTt7JQKpfxpc/oQOpx+s=;
        b=qTVpH+ghIW+/XDi+RUUfZXIYXca2uui6Y3kQjl7dpab9CnbohPRqTtY61ha6Pfw0dF
         /74/B/feQnq7guYOFCAUg031sk91U/WQe+BOPqubaszqRlgYLTXnCReddRjNexwcGYLJ
         HO6jhE1QudPeuO9oMC3TGGT8AqlYW9ebmTH+cgVxpWglLLhK4W5KthSHbrrBEs6LrECG
         1BbgBA+cUOg9skzw/GjyX5Q8/FPAuHJ1QcX/fdXcFtQbyaZFE41gHp0gueQL+O1WTyun
         aZx0cKVG3YxGx6qJjsjyke0idcF5LJNhvhP7FLpiOFf0OlVwfn9NhTMMtW+8ROf9KGAz
         iUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777943277; x=1778548077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hBjcwpnTtESMydnEYbNcBRuOTt7JQKpfxpc/oQOpx+s=;
        b=gPR89uAVP7ZQcZC+fa/+JWEJEVGmCp6z4CzG4uQi368zJNN+d401f/gAdD9hL9XYmk
         AHMu5kDR4gg2kYl59suTEINoz0vt2YyjlStG5P9XBl9sRvsfG5I3SCr91Xb1u4Jfo4MY
         ytYMcN31lUHyB0YQagYFtrPUaTwK478YAFBrMQLHudMnDm+Sk34sywDoaI+ckAcPzGtb
         UDG9vB/d4YYY4ERbU75OisCC1ygdm5otATCgoKfyGvqhW5BN/PmueaeYaXQSpVTq+Fsu
         Hig2Vdz5ZJvc/h/XKRPBhNmIlT8rNYlTlFMviOy4QDfRedV+tL6Ltlwq/DeYgHDBbGuZ
         wVZQ==
X-Forwarded-Encrypted: i=1; AFNElJ/2xlWQO+txHWYfHoEPgBNB61l7Qlt/zVHrrKI6DKmiqHSv8wV5Q1AmC3CJPmf6RXjbEyMGZ055LDWYGFKLl48=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCMP9fNYbDMbHap7vRq4jQ9yl1Gbyq5waOC5ee2K7sY6HyQbvu
	OKVi3YTXCkefVXMr9b5xtixZiSkkOAnDdOFk7lOzBIiQgNrF1q3OnskH7uAKQaFr/3EirSnhb4O
	Wj/I/Q7oBBJ2gJ4/O3whcoCJao7FhbbI=
X-Gm-Gg: AeBDieuXJH4DNGkSDp+FIhTjy88cW+w4x8FfPhLiUU6jIDwX1guTc/sCD56PCvquqkl
	4gd89Z/8FgoUU8TpScBvn+QjA23uL8SRJdAlAdPwXWRY7JywLO4y46eqlgox5FO92pMf5M638hl
	syNKc/+RgmOiaWtvgRJTJ+rAVysXmmSSp5LT2n+GMTiCm78KSnEDWLBBtv5r12i4sVmoMon8V6l
	TIVrNPGpq9l3ldiLZ9CgSohhcAXyLr3dGBn0Tqj4MYrkZNrWNFFgQkhmA5EVD/qG0Eb1zA1LZbA
	eP/UFiK+9dd9K4QLB5J/3dbKktOcCPCL2t4NurM6z1r2klX3/PlgxTiPwGyapQ==
X-Received: by 2002:a05:6214:2b98:b0:8ac:dd87:b5b2 with SMTP id
 6a1803df08f44-8ba9ea852bdmr30666216d6.11.1777943276686; Mon, 04 May 2026
 18:07:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503211835.16103-1-dwindsor@gmail.com> <20260503211835.16103-2-dwindsor@gmail.com>
 <CAHC9VhSy5K5nQTtFUE4BScy1Ur61v7eZW067vTcUYDQeJb13Bw@mail.gmail.com>
 <CAPhsuW6sy2cdC4B7Z48-5A-yVX6fmVWxS_fWVjQxiX95KeUguw@mail.gmail.com>
 <CAHC9VhQLN5NA_ZMMNyUdMCZVdwC3VM4PUnzka8xDK5rpR2a3sw@mail.gmail.com> <CAPhsuW5nDaLAV5UfAHeX6QPeF6bs-WDkFYOzYO7Q9_O6v=jEHA@mail.gmail.com>
In-Reply-To: <CAPhsuW5nDaLAV5UfAHeX6QPeF6bs-WDkFYOzYO7Q9_O6v=jEHA@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Mon, 4 May 2026 21:07:45 -0400
X-Gm-Features: AVHnY4LpG15Ov5YRtOS0i0ZsEyHFvRUaNMxQ4C3yLGhd4sFsYnvO-3LzEMQWXWc
Message-ID: <CAEXv5_jp5wKgR_ZozL3n+4NgrLTg9FQ-HW1EHTtkyA_6GDMhgQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: Song Liu <song@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
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
X-Rspamd-Queue-Id: 5D6344C59D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9420-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[paul-moore.com,zeniv.linux.org.uk,kernel.org,iogearbox.net,gmail.com,google.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,schaufler-ca.com,suse.cz,linux.dev,oracle.com,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwindsor@gmail.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[paul-moore.com:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Mon, May 4, 2026 at 7:09=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Tue, May 5, 2026 at 12:42=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> [...]
> > > > Perhaps I'm simply not seeing it, but is there a check to ensure th=
at
> > > > there is only one BPF LSM calling into security_inode_init_security=
()
> > > > at any given time?  With the BPF LSM only reserving a single xattr
> > > > slot, multiple loaded BPF LSM programs providing
> > > > security_inode_init_security() callbacks will be a problem.
> > >
> > > I don't think there is such a check. Also, a single BPF LSM function
> > > may call the kfunc multiple times, which is also problematic.
> > >

bpf_xattrs_used() guards against this. The lsm_xattr_ctx is shared
between all callers, so xattr additions by another LSM (or by calling
it multiple times in the same function) will be tracked by this.

> > > I think we will need to make the default bigger, and also introduce
> > > some realloc mechanism for the worst case scenario. This should
> > > work, but the code might be a bit messy.
> >
> > Thanks for the clarification, that is what I was afraid of when
> > looking at the code, but I was hoping I was just missing it.
> >
> > Increasing the default is an option, but I don't think we want to
> > support a dynamic reallocation scheme for the xattr slots, that will
> > likely get extremely messy with synchronization between the LSM
> > framework and BPF LSM hook registrations as well as special code to
> > handle inodes with lifetimes that are disjoint from the BPF LSM
> > programs ... I suppose there may be a way to do it, but it will surely
> > be ugly and come at a cost.
>
> BPF trampoline already handles all the synchronizations, such as
> add hook, remove hook, etc. properly. So this is not that hard.
> All we really need is to allocate a new array, copy pointers, and free
> the old array. And we only really need this in the worst case
> scenarios.
>

How many bpf-lsm programs do we envision being attached at once? I'd
think that stacking of bpf-lsms would be difficult to reason about
(moreso than static LSMs) and won't work that well in practice, but
may be wrong. Most LSMs use 1 xattr, Smack is the only one who uses 2
IIRC.

> Thanks,
> Song

