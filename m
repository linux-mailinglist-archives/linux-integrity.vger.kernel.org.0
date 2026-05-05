Return-Path: <linux-integrity+bounces-9422-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJqIA2ZQ+Wlm7wIAu9opvQ
	(envelope-from <linux-integrity+bounces-9422-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 04:05:26 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2534C5E6E
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 04:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5F8103007A5E
	for <lists+linux-integrity@lfdr.de>; Tue,  5 May 2026 02:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401642E091B;
	Tue,  5 May 2026 02:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Iu4pHGTE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01CB175A98
	for <linux-integrity@vger.kernel.org>; Tue,  5 May 2026 02:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777946719; cv=pass; b=T2e++BKqgJkHn7HNGU2DAiUNI7sxRnp9gFkey47J/obxkJP47cY6PJuVPZ6CUV8wMQAcc71G89xs20BwqZeqXKszAYp7fmTGkV9DgnFRCsAFqQciYGy+OzRfzLsA1PkKiYlGt+mALsYrphc1u9NvzfXUw/S2913CqR4w9Nz9jCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777946719; c=relaxed/simple;
	bh=gvTcP/QSZduWlO+YM2pkz7nb/ZWzyRFB9ciWkWgUHB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJn7nYZrYJcNmyBq+BCdtkrvPvZ6+biRTg/xDOUIdqUUP825HNGz5DB0K6xLRB/r7Ch866xjDiYmwojIXhzLaUNrpcmDV641Ng4TWxQoLsMQbGZtnzmpC8gqFGFm/fhCHx88oYxODcllapqlRw7fM3SiH0ZPUB9Dplye41PyD90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Iu4pHGTE; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3651fa24c6bso1628677a91.2
        for <linux-integrity@vger.kernel.org>; Mon, 04 May 2026 19:05:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777946717; cv=none;
        d=google.com; s=arc-20240605;
        b=DQ/j9GF//Af+77BBSVmpnicN5hq2mpoIIpg6EkICAIX9iJWN4oC4QU/glJCnrrw8K9
         RGgSilWIQVfCoJBmcgIpBKHPqwDyit/harFDWBKbqg5iKYogg1lFaYVcdCZ0MdCrtocW
         9EYvayK91m4jMw37x0tj8aRFG6tlrTubdwZ60Oxh52uZqBv5gFUeLEg5tEtLBUKbkz+Y
         68BVwqb0n3tK02IEuJ61UZEqa8Ec5cgYoxvlezOQ8jIJaLSdpAyQy3TMs90l8N1XDqRP
         xrBfxGafDGga/RTlXU18Pl4DR+LHpiMX/Z3DRkccxc6kFv5f7S0x8U0Rxy5TaQrUN1M3
         C7fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ds8VPZ8XGFRCMSYoTIFK4J9AmphYV1vVpSWFXmoaOPI=;
        fh=CiWLd/g2MuR707N0t6rDU/RD/UovzXO0E+LM3c0v65o=;
        b=JeE38PmXO6Ho81ZxPrcOf+7JhqVEobAuXPvMHrM6ARpmk92e7h8DwjvxURVa9O63XE
         8GJP57uKf5FqQ80AzmeyNcYjXF+5HZhk0JIuVPwDmQ0ezAgOaio+hEU9+hIjHUXzW15L
         0pRQvrydPhLMWipirLM/DjMDi5pW8h32kw9n9/ars4WLVR9HDeFuJCs0RK9vsxW9mTH3
         TCdDmi/u9Oe89+xGuT3s0/jSZ51mLs1qHgScF6qjSBNLHZyGwL5gldUhzny9Jb3DTw4F
         iAyeyuVRXJgpuNUcglhfBiB8ZHd269hfcAk17IZ6D0YPG5RocF5kq0iXyQ0muB5DdGOF
         YkIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777946717; x=1778551517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ds8VPZ8XGFRCMSYoTIFK4J9AmphYV1vVpSWFXmoaOPI=;
        b=Iu4pHGTEUaOLJwNoK6YkG3q0ITunicSOQ9GLJSqAZshyOtEqzWrx20esi7hYXfWjLS
         Ku7ucBmg80OyUDoA4XpZjPwA2+U33YY71h0OKr1hkn0n0eWGJWPw7vRTo9pNEkeUUy32
         W87BEB2psIcxaVJNpzgC+PUsNMKSKZ56NTumpArcoKSPLlj5tzHG6FrLVoyHjP6Qzfim
         8e6LE7bCXySDpMs23fKlu6L3bUasxX0AhJCPo1b6EAyXhne/WRGl0RwqTGRm9wycbohN
         53MU5QDes5YHyYQSiwfbTdSd4gG0kf/iFWA8IWJXM1lrA4sUmSmmK5DDJHCi/4jXt/ya
         50Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777946717; x=1778551517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ds8VPZ8XGFRCMSYoTIFK4J9AmphYV1vVpSWFXmoaOPI=;
        b=g/yxs74XtByOJ2JBcECFRijNVZ5X/3picOhFti68sf0Uz86sbnq6Es4qNP7yn6Ntfc
         KO1z+naYOIHaKtKRjNiui5UCRn7YtFwOuBUEFIvZZwnSj3DvqJ36DkcqMqWUa0BcVVX9
         dCf2Yn+ipWx652pQk5EGCqQpFQvraoUgAuk2sQmmu2Q27Sojg6xGUb93/MlUsiO7iMEV
         DngWAh7iKlaC86N3lHtHxdrulgIid8Euioh1jfhdpCtpC6FNNE4VTps1XxpuyUP0K3Gm
         njTpasC3U5VlTLuxw6IwhuZFuA+mN44on7uaNaFNwovhic66aPq3seriE/ZKpJvJAebD
         uQbg==
X-Forwarded-Encrypted: i=1; AFNElJ+cYuurZAe1ByyeFosaXjAivh950F/3JnSKnY3qLy8ShfhdxizAVaso2pG9HTLvjf8kThUHacvarR/7PSBqOe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YygkKbz3B6ZMtBkU73O3bc4ar4QSFDRCX5EM9pYtaPr039VquAf
	mziRNgQB+0+q3YQI/3ZOjbBbMTJsWxbscz2OIFUFkbgUBFVCiueQJWX7YpJVaP5zra7oWLsdQIQ
	421r1EweRJ4m3CPF5of+I+EyTi66W6hEX4iga5Rpb
X-Gm-Gg: AeBDiev0g2xCvjIYp0xZomP4Sj/XeVt5Pcs/2wgAHsXCCf6WrdJ2/btBC2TLho6QqfD
	bSIF0Zcw7iZqvIwB8cnlUXYfhsNH/wd7HxmnQ+fMiw8PRX6CUZUSMMWT2aOoTAz6XLRV/YQvNMx
	XQt9BZE/yimfT/bOLX7T5c+niVYlNSK7xS+r7Dk9dvnIzoM2Z16MVJAIeB1ovXKOkYIHwmbgeP9
	4VENiM6NCMKU7nmQEX1Q5BlLEKbF9xhrZzToLvYawXDWDK2RXXCSK4szbwfmnMJF712kVRJaVAI
	ypdK+zkL02jgu5hrLmVOvF/abNFr
X-Received: by 2002:a17:90b:578b:b0:35b:e51a:ec77 with SMTP id
 98e67ed59e1d1-3657747c6b0mr1240269a91.16.1777946717425; Mon, 04 May 2026
 19:05:17 -0700 (PDT)
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
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 4 May 2026 22:05:04 -0400
X-Gm-Features: AVHnY4IXddbw6Xna7rtOXW0Z3iNQtqb02aaSWmZldIVvVUPK0DOCzTg7J5JMJqs
Message-ID: <CAHC9VhSkBsUDKoQArjyPLTgSfc4GVinphyJmNv=-UwnQp97qCg@mail.gmail.com>
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
X-Rspamd-Queue-Id: 4C2534C5E6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9422-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[gmail.com,zeniv.linux.org.uk,kernel.org,iogearbox.net,google.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,schaufler-ca.com,suse.cz,linux.dev,oracle.com,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,paul-moore.com:email,paul-moore.com:dkim,paul-moore.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Mon, May 4, 2026 at 10:02=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
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

I just realized I probably wasn't as clear as I should have been ... I
really don't like telling people not to go experiment with things and
play with the code as that feels wrong for many reasons, but I do want
to warn you that if the code to handle this ends up looking like I
think it will, I'm not going to want to support it in the LSM
framework.

--=20
paul-moore.com

