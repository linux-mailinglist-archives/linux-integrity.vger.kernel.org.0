Return-Path: <linux-integrity+bounces-9421-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PzGL7JP+WkV7wIAu9opvQ
	(envelope-from <linux-integrity+bounces-9421-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 04:02:26 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6618F4C5E2C
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 04:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C301C3008D77
	for <lists+linux-integrity@lfdr.de>; Tue,  5 May 2026 02:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602B11CBEB9;
	Tue,  5 May 2026 02:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YTbCd1hY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE69A3176E4
	for <linux-integrity@vger.kernel.org>; Tue,  5 May 2026 02:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777946543; cv=pass; b=LdWb8cCkZkU1lJq/9OC0GOyVjQB8lllPsGs9NcxVZNzs8HMVZ/8wXH+H2G36LpWTCXsQ4Eus4bjiubGZuhv6Ym2jlGCJCRjy1DdIqq+32TZE34206dmbijenhHDYcXxlrcj0YJCv+SRBqKRc8/9oI6Np5wakR0OioGP4loCh+Dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777946543; c=relaxed/simple;
	bh=QBGR4uo4ZBFT94adMzS0OW2smvVOxlZjnZ8xICFbg8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YxxpFfvX1yoJUoazjAm1C3HtvTjekQ+1GdBcV5nZeoASO5n9235B4gMWhWBUGYY830dpfFJOW67giHl8Lrnw5eiI0bIDNFPl9Fg3OJbHVJtxnfto56ienJ8wnglEqylf5EE6I4kjKxlAq51N8Cv3eodoTsYw1McM6ypsZIGamGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YTbCd1hY; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82735a41920so1692605b3a.2
        for <linux-integrity@vger.kernel.org>; Mon, 04 May 2026 19:02:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777946541; cv=none;
        d=google.com; s=arc-20240605;
        b=jVe5nmFZiDYc0w9tGQ/RfC/Wfr4zE3LKiXFqQKjIQtK9yCiHQWBxOdAgFfpn+Y+r8A
         B3E5mtXgqoefxLgWpTvJWG3HB+mxeYdj1zgherbvoT2FcSpnk/QbeOJPzDo0bsPWez4S
         L5M2z0m9allah3Qsm9AwRTsQzgCLsPLVjttmXSD55gf1AObecC5cKOK29FLheP8KA0Bh
         z/WyOJ7lL8xBwk7CtmevxxGA79mABAeeIUJMwqiCdhWYOlkkmTINDB50uDoYuCBIpzwJ
         4BlGMiQANjnVT1lM1y2fsGMPqubzQNcRv/HuLMZPAVnLkUGxVRtciEfEyZrtWg2/kj3C
         Cr8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=miwU/ecb6g7PnqI2pTJ+Cbe7pB50VxWGMEGUDTC3cfc=;
        fh=3gqZLC75lJE3T+gheVUBhm7BWIqFvRciYEWyoWyi+0E=;
        b=iFJ6vHrN5ainjR/G23WOQxLg/wm2W/Xe01KsRLtABU3aFJJYeTy3cJZYoj4SCf0kcn
         MrQKrsCNRLGb2V806hSgzGvj48Ojq7j3KZCiVytNNK1BaNXgbYBP5gcSMIkLB6gYQSLQ
         WVqxi++1LOAGoAdxatDKPp3ko8zZBz8x2HRHw7XHHVNgIwOLN1Ci0cFyiyFZWpalayUI
         RgUdGDSbgTVGxZwSS/ASFYsRM+S6O4dvjF0tzK9rCaAxRGY2vdQJ4i3l145tWgsC/w7X
         9PJGYZAFy3mW7ILaAHnOHWQwrmKGjALyNnQgtkZB7fYlNWraprFQ3DjkhrVw8PfgtnKb
         fhOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777946541; x=1778551341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miwU/ecb6g7PnqI2pTJ+Cbe7pB50VxWGMEGUDTC3cfc=;
        b=YTbCd1hY7l9lEBVl0w/wv2iueY9Opq9b60f7gr2EYiXALDYdLGnZJNSYxDZ0gUoU59
         FMCsZV0oEDLmwq8QmKiq6ZrYbHSIkov7begKRKjolVzKn/Oil7irs72AOeksYKDtp9VR
         YuwulX7d9aXBeLa+Wc/5nCX0JrLstVSyHXMorJS/6TpVxwRBKCiGLdXgduORSKD9peKm
         IxtN9zOWg76wwIk5EqHMeQFD0waWhunj5eTWSRCXG+bSqvwfShcV64kApLLJJR1Unj21
         TykSnnpDFKZJpGpvz1+BdXWgiSGPTOXMjAGTmUNnuwpzVvMVYF7GmH0vfMgNX15+ItD/
         23Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777946541; x=1778551341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=miwU/ecb6g7PnqI2pTJ+Cbe7pB50VxWGMEGUDTC3cfc=;
        b=D/xf5En5gwjThX3DaF1hconM7izYwJaeybXGmuqy9Ie5BpdsG5EcJv2QMmgJ7VcvAN
         fOa01oE3cpbXWnujxMTVXfc3ouxOllP4Q8ITjiKCme+yAVbYq2p4p8Uis8C2euvkMNqe
         7o5LhbR1967UG6MXkU1JTCerMQBVH7gp4c+p/rCXFSL35dg1aYhM0HbTM8sY1tq8o3Wh
         wnbU7NXTzObm9/zG/H6mYaMRCWo71b/Qm6VsfSw2/jovPi7a7ceqDrBbMccbMgmOSQVb
         oM7sb3jq9219aW3unkjB0jhE7NSBLuQX6xxggnUxDsgCuN6Ee01vPYEr0c7tmiMRkEw+
         MuGw==
X-Forwarded-Encrypted: i=1; AFNElJ85ib4tQOBxUmNOe3UzQ8GQ7SLT5aXKtMPo/GW1P9bMbv7mFPTB2V1l+3doEiFMlj7x/9iwTdYfFnjKlQGgfWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoYOCztB+xsiuemiqw6iLYwzS+EnePOQSXciFOAsHqAsoCpwv+
	37eBW1/Yf2OaEHxjjTHoAsquFeu4fp7ezD7hifYz/JWMOHIsZPJZ4rt0rC5PtE06KpHa2paKZbZ
	xF7Kq3KMQu6pNl8Lp51ru/7sONU55L7iiyDs19xRA+8ZWZupl/jbYQA==
X-Gm-Gg: AeBDievJNIAe5zTRw4tsGQehFWM6fQhthljROMwE+VMuyBW9WXIRStTyjCTbxJC5VYf
	pyEc9VqR9/NXfI5XNURY/YiZ8+vuGA8E3oedzJ5GbQpskxKbSr6IQTALqv7wJPSTNUuRQraJJlg
	yWQug1g5fQrx/ylSjIHebQ/pMdf5qrYa+Oa+i1CFURNYJeOWjo/aLy29bwx5mjMftlhjmsnVX4i
	aPG6aCN1Fo6qfBR4PB9rJ4v7k5RCSh37adfxxT/7Cb+vgXM6jSFcjJaVn7RY8cV1EVvvcVojF2f
	hoZBy5seKl0jOepeCA==
X-Received: by 2002:a05:6a00:9512:b0:82c:e692:1f91 with SMTP id
 d2e1a72fcca58-8352d281ba7mr11640208b3a.39.1777946541290; Mon, 04 May 2026
 19:02:21 -0700 (PDT)
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
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 4 May 2026 22:02:09 -0400
X-Gm-Features: AVHnY4JNEAGbbhruN9w4Ua7naDL1XKHAY7HZ8pKFMVGcMz5B9Ok6DLP24wok8oc
Message-ID: <CAHC9VhRx7L1WXYgQvWmGN0a7ssSaDKx4JPhup2E3W161sdp74A@mail.gmail.com>
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
X-Rspamd-Queue-Id: 6618F4C5E2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9421-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,paul-moore.com:email,paul-moore.com:dkim,paul-moore.com:url]

On Mon, May 4, 2026 at 7:09=E2=80=AFPM Song Liu <song@kernel.org> wrote:
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

How do you plan to handle the issue of disjoint lifetimes?

> All we really need is to allocate a new array, copy pointers, and free
> the old array. And we only really need this in the worst case
> scenarios.

Oh, is that all? :D

Keep in mind that the code must also handle arbitrary ordering of
LSMs; in other words, you must handle a BPF LSM that isn't at the end
of the LSM order.  While a BPF LSM at the end of the LSM list is the
most common, and recommended ordering for the vast majority of users,
we've been working to make the ordering as generalized as possible.

--
paul-moore.com

