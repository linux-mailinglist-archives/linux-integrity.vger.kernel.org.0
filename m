Return-Path: <linux-integrity+bounces-9419-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EOdEEsn+Wmp6AIAu9opvQ
	(envelope-from <linux-integrity+bounces-9419-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 01:10:03 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E26794C4C05
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 01:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1856C3011596
	for <lists+linux-integrity@lfdr.de>; Mon,  4 May 2026 23:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F2E3932D4;
	Mon,  4 May 2026 23:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzq/kDMa"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51642392C25
	for <linux-integrity@vger.kernel.org>; Mon,  4 May 2026 23:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777936197; cv=none; b=oMi5wB2co/EBrVbmx4Q2+/UbmeancgKpDU1qkf68OvdSyIjdTaHjfthZME/Z3aRpfmh6j2pHn5TuTrjRbJZ82CkQVkb+sRAviSbSAn1uXLNco/GVHktBaeGCLWbiIyipFiezJV2fFy+bR6jn2p2dYSvk3tosKJQp30kO+oP5rfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777936197; c=relaxed/simple;
	bh=/3c97m+rtbalvwzEj0fQM3k4OJDBTzI/7E9Y/T/5CJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O1kA9Dv9yNiMgRdSYI4foCnb+SS9JxlYUbZw3G9POy5k8UfM4G7dBUeel4TXEG3t4nnOauYq7i3sS6KnlFFsZFhLSxDumTPyNQvqQtqiGNIsezLU8gedqnITos5rE7jNWjz49NW8RakzYgnfWMoJz+3z16lKwe2Zs+HqaTGSOQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzq/kDMa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A529C2BCC4
	for <linux-integrity@vger.kernel.org>; Mon,  4 May 2026 23:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777936197;
	bh=/3c97m+rtbalvwzEj0fQM3k4OJDBTzI/7E9Y/T/5CJ4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gzq/kDMaCEdmMmhGocKKabTCSq40g+055ppMSW8xaHsmRNq+o2iT/0O81ZGUE9S8d
	 2m5+YuyxhK64bueNaU4YAd4QzfVti3rqv4EXjsAzda7IpmQJEJIxrpa2nWpd4Z7wnI
	 9GVIG7tViSxi3cpGOcWfoo5svTomubzTVcQ+ke++n2az0XDqeVGDwubvpZFqk28FSw
	 mkAw41qR3HqIqIcZVTl6qSk1SoFBlzS61udiuXPG4cGA2q7oQUIpKoJH/pMMr6puFM
	 yXYiyBeaidwm1fZQpydikvV2FJmlKbb1WvpH7+ideT7TRiuvP7wZP0fLHFpOg/qP62
	 VRiC7A9nYIbGw==
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8b4000e51fdso44039016d6.1
        for <linux-integrity@vger.kernel.org>; Mon, 04 May 2026 16:09:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8wseO//QeIfUSKvdiKP9G58brz7wH/orIGICRHHN39fX1GU0Z0W6Ynd1r4yBoQ+ZlzQlO7OYqRaJZKRoSXYeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJSft14ZGeNrLqwTVRGB5QppguAjhUlAYQuvG+jGcvPDSr35S5
	R1TBRiKaWRy82u7xOhrU+tCDvwCJREQx/mmUHDn3h1WqaMvrkGXcHKXCcCwJE90HER2nmt9ZT9M
	a4FoAlU9EAwAS9e8b5KKKa7EZPn5VYgQ=
X-Received: by 2002:a05:6214:4d06:b0:8ac:732b:6cf1 with SMTP id
 6a1803df08f44-8b6682579b0mr177893876d6.24.1777936196061; Mon, 04 May 2026
 16:09:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503211835.16103-1-dwindsor@gmail.com> <20260503211835.16103-2-dwindsor@gmail.com>
 <CAHC9VhSy5K5nQTtFUE4BScy1Ur61v7eZW067vTcUYDQeJb13Bw@mail.gmail.com>
 <CAPhsuW6sy2cdC4B7Z48-5A-yVX6fmVWxS_fWVjQxiX95KeUguw@mail.gmail.com> <CAHC9VhQLN5NA_ZMMNyUdMCZVdwC3VM4PUnzka8xDK5rpR2a3sw@mail.gmail.com>
In-Reply-To: <CAHC9VhQLN5NA_ZMMNyUdMCZVdwC3VM4PUnzka8xDK5rpR2a3sw@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 5 May 2026 01:09:44 +0200
X-Gmail-Original-Message-ID: <CAPhsuW5nDaLAV5UfAHeX6QPeF6bs-WDkFYOzYO7Q9_O6v=jEHA@mail.gmail.com>
X-Gm-Features: AVHnY4KbucuUmnfxrM96daVxOOqJnDfF1BBq1hZ1I15QYlozTuBaoPnofTKtzcs
Message-ID: <CAPhsuW5nDaLAV5UfAHeX6QPeF6bs-WDkFYOzYO7Q9_O6v=jEHA@mail.gmail.com>
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
X-Rspamd-Queue-Id: E26794C4C05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9419-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,zeniv.linux.org.uk,kernel.org,iogearbox.net,google.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,schaufler-ca.com,suse.cz,linux.dev,oracle.com,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[song@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, May 5, 2026 at 12:42=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
[...]
> > > Perhaps I'm simply not seeing it, but is there a check to ensure that
> > > there is only one BPF LSM calling into security_inode_init_security()
> > > at any given time?  With the BPF LSM only reserving a single xattr
> > > slot, multiple loaded BPF LSM programs providing
> > > security_inode_init_security() callbacks will be a problem.
> >
> > I don't think there is such a check. Also, a single BPF LSM function
> > may call the kfunc multiple times, which is also problematic.
> >
> > I think we will need to make the default bigger, and also introduce
> > some realloc mechanism for the worst case scenario. This should
> > work, but the code might be a bit messy.
>
> Thanks for the clarification, that is what I was afraid of when
> looking at the code, but I was hoping I was just missing it.
>
> Increasing the default is an option, but I don't think we want to
> support a dynamic reallocation scheme for the xattr slots, that will
> likely get extremely messy with synchronization between the LSM
> framework and BPF LSM hook registrations as well as special code to
> handle inodes with lifetimes that are disjoint from the BPF LSM
> programs ... I suppose there may be a way to do it, but it will surely
> be ugly and come at a cost.

BPF trampoline already handles all the synchronizations, such as
add hook, remove hook, etc. properly. So this is not that hard.
All we really need is to allocate a new array, copy pointers, and free
the old array. And we only really need this in the worst case
scenarios.

Thanks,
Song

