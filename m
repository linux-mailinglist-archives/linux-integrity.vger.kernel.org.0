Return-Path: <linux-integrity+bounces-9448-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKknNp71+Wk/FgMAu9opvQ
	(envelope-from <linux-integrity+bounces-9448-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 15:50:22 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA994CED02
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 15:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE4A93039894
	for <lists+linux-integrity@lfdr.de>; Tue,  5 May 2026 13:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DEF47ECE2;
	Tue,  5 May 2026 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="frbFmbFg"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6BF2E06E4
	for <linux-integrity@vger.kernel.org>; Tue,  5 May 2026 13:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777988996; cv=pass; b=eSBIiag5gVDamhvtVRxE3LAsPNW/zonok6qLecAjFUlVMllNSrTn+HTR8CtUW6i5ac6znzgdS70kgKu/1tEkW2PYoArTCqkXy0nsl/Nw+3D55aaDLEokZ+1z02cuZbBjNdLUj43Q54ULpL/fx/ljTvnhVOInu1b6HB14/Om+gVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777988996; c=relaxed/simple;
	bh=dwtJGGtWfivJTDnEUkDart9O2ukOCksxaNnx6dZ9xy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmrY5weIYHQI2xOaJbJv6NYzQUV4RaQRWyV2WPy6Kl2mWlvAMapISCNRVO0vN4InMdY52Q6kjSwP7kKxZtdeeb/mZkqOD9TCpr3ohWYId9WkYzuFOYaGgFe719olKcDpReJH8JwfPwz164bVudbO+vC4dErpdSIGKrzwqq+HT3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=frbFmbFg; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35fbca04006so2700046a91.1
        for <linux-integrity@vger.kernel.org>; Tue, 05 May 2026 06:49:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777988994; cv=none;
        d=google.com; s=arc-20240605;
        b=MDVmTZ4FcxmT/LPeasNTeLmddwuGvgMV9DIJ7VR30QmuFGoAZo5+D9B+BpBviQ/A1f
         JpDXEnhlqZu8pprXJYpZAOHj6sCo2oeHUW1Z0rqsQSkJfjuo096sZREDwvYGRP63+8t+
         Z4zRL4AxCUnzI7FvlKdhR1HfqsiFjIAo+20YpMBR+9Xw6DzJKhvS9vr2dBciRGzJukgq
         XvvozeX/qt3pMtVOCODWEZ0bTEMWeAaaf7JPF8XAkUL33V7zwn99Xp8jCUM5QIBm4Q7c
         b19lEH923OSopgZr3LGmFQ/Ie2HRuPG5kVdawMoB/0bYr2yyKzDHbe+3kjqjOPeKG/Qn
         Y9mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hqf6lIUgsNlkAq08zxsjQWbzrMpXMe/Oxc4pqEJz68g=;
        fh=l9l9qKVWgj+22Sc1cxhG0fkQBy86XSAKeeV0w/nqwew=;
        b=c3YLuNE/57RqaKRcjJnBhvlhDbv2tQh+AoHgw1/h1XygoSflgj7OZ0qw6ov/TkU0/f
         pOw+G3NjyZekKKifUzfzB4q/gy4jGfVHAZnm/k95IfLNpOGShxJ3FkyqKoVNPpLKD8dG
         cVN46JXATw/KZpm0DatRwK7Idx0IOIcphwnTlaAd5VhCQSuyjKNBC0KmqEci6bpJ9yyi
         xN3k8iW0nKI1GAjKpt+/V99eEqEHcWKcmtBSdtYuDkxv9B8NOkYitfJOCeIWPRLxO4xs
         DTrruo+/9SkR/7JtoYkGYBObljJEkq6tQfLJsxWcxZmtQ+m2w02StqXxqHtqvlA1+hS6
         Y8DA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777988994; x=1778593794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hqf6lIUgsNlkAq08zxsjQWbzrMpXMe/Oxc4pqEJz68g=;
        b=frbFmbFgOy5VDj09J4f62miUa6qVAKlhZG3/8HfPOneejt5h6GUtQh+bJQcYyVXcJy
         OmsPiOMuN59cYHOycQHeT/fex5uKz0C3c9lNgZRI5cWhWaf/YgfV3zrNKOTQvhctF7/b
         SsxJo8VaIiPaynadx4HM4POuFQY7HM3sNWB3aP6pj6djFe1joxyMQF/ThxZnKM3T5tui
         olWtUGCea0udn3tlMK8N80eYwbORI2WLMtMKL0G6v0P3OTM6azccnmnPrJCmunmrLZ93
         RPuZFY0oa1or8jPs4empxBo4YHxMqqLLDwDL19QSzLbL4rVWxUp9aOEvIlTWfpe1qw18
         Fg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777988994; x=1778593794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hqf6lIUgsNlkAq08zxsjQWbzrMpXMe/Oxc4pqEJz68g=;
        b=k4vFCZ1oLBN/XjcsyBOk+jiMpZcxaVbPme1XC4NdGwEoP1CfuIbwAqz213x/QtjPXZ
         i5DePKjAlNWyL/qZsmgnH3YJ07FntJLOJI+2CW1Obx5syUpTvBpNrqOPDvEw0jArOkvC
         FWMRfLfZ+qq6O396RwHXsHfQAepKJp8TbrbSHiePdvf9vDK7lCAjVItXf2g7zArbSfCz
         jB001QgkM9XJAuaocjGfUz+/hM+QTUppZ2djHgX+Q00F+TkT57xY+3bjM8IlvkYF8fCs
         uW1xZCoRq61U7YVgo7uWzbmLJktkcr/8t1DUwQQGo7ept58gB6G2Rfz+H7ISLCkDLG1z
         fmMQ==
X-Forwarded-Encrypted: i=1; AFNElJ/GL+rijdVp1pGJ5OSYcLxeLKkvoIx4XFx3QjezMeYIPYBJ2WGJwzC+RsOW/S7s1LHX/ptk8bKv/jy/npfQM70=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEfqxPcFK1qTshOQiURhqQRAy4kmbVXYpC+J4uouigIDvk3VL+
	mqRXDBq/9yr0/LkxRpLMKl/ozCH1zScp4/lJV5dUBCf7d2KfFM8+Qudn5PA2i8SFUtYrFjo3VxD
	BhHca1cqzNwqhBx0tdm7fmC9MgLTzaZQbmr90MsgE
X-Gm-Gg: AeBDieuP/DQ9HkTO0HHWhgteOIX8A3nXwXbzV6NM0OdT08FnDrBR3KV5wxBDbGHHD0k
	hDlIy9DOYVrk3d4K/Q+9Ii7+scYXiddwtlKiW/LDa6zVc7zzBdjJhm4BWy1PCOC/WPPjLbepNV3
	IN5hC5TJCnJfRz0Ed83+lI3JrupMFyEKeyGOkUiw+txRYVLtxQtIEqKWZuppsi0ahHoncu1WheI
	PHax9wiqNPgqtECZPJgeQrPw2unA7427xkYZXt0QUEEjAadS4ELa8iIH8SQRqzx9uQbj3Ml9eV8
	0P9KduO1srk4/m2Itw==
X-Received: by 2002:a17:90b:3a84:b0:361:4521:d311 with SMTP id
 98e67ed59e1d1-3657747cdadmr3159694a91.18.1777988993821; Tue, 05 May 2026
 06:49:53 -0700 (PDT)
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
 <CAPhsuW5nDaLAV5UfAHeX6QPeF6bs-WDkFYOzYO7Q9_O6v=jEHA@mail.gmail.com>
 <CAHC9VhRx7L1WXYgQvWmGN0a7ssSaDKx4JPhup2E3W161sdp74A@mail.gmail.com> <CAPhsuW5zRktottTujy_O1=8VkdJGDO71M3DVVM4ezffwT_dm+A@mail.gmail.com>
In-Reply-To: <CAPhsuW5zRktottTujy_O1=8VkdJGDO71M3DVVM4ezffwT_dm+A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 5 May 2026 09:49:42 -0400
X-Gm-Features: AVHnY4Kdcn8NUgT3x3TCJLSbVA7TxZZZNO16IatME0SS0-imLL4d0tdSq1ceCGU
Message-ID: <CAHC9VhTWpFbK30ueZw5zTgNfMoABLXcbny=_eWOV17+1ebFVKA@mail.gmail.com>
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
X-Rspamd-Queue-Id: 9EA994CED02
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9448-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,paul-moore.com:email,paul-moore.com:dkim,paul-moore.com:url]

On Tue, May 5, 2026 at 5:00=E2=80=AFAM Song Liu <song@kernel.org> wrote:
> On Tue, May 5, 2026 at 4:02=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Mon, May 4, 2026 at 7:09=E2=80=AFPM Song Liu <song@kernel.org> wrote=
:
> > > On Tue, May 5, 2026 at 12:42=E2=80=AFAM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > [...]
> > > > > > Perhaps I'm simply not seeing it, but is there a check to ensur=
e that
> > > > > > there is only one BPF LSM calling into security_inode_init_secu=
rity()
> > > > > > at any given time?  With the BPF LSM only reserving a single xa=
ttr
> > > > > > slot, multiple loaded BPF LSM programs providing
> > > > > > security_inode_init_security() callbacks will be a problem.
> > > > >
> > > > > I don't think there is such a check. Also, a single BPF LSM funct=
ion
> > > > > may call the kfunc multiple times, which is also problematic.
> > > > >
> > > > > I think we will need to make the default bigger, and also introdu=
ce
> > > > > some realloc mechanism for the worst case scenario. This should
> > > > > work, but the code might be a bit messy.
> > > >
> > > > Thanks for the clarification, that is what I was afraid of when
> > > > looking at the code, but I was hoping I was just missing it.
> > > >
> > > > Increasing the default is an option, but I don't think we want to
> > > > support a dynamic reallocation scheme for the xattr slots, that wil=
l
> > > > likely get extremely messy with synchronization between the LSM
> > > > framework and BPF LSM hook registrations as well as special code to
> > > > handle inodes with lifetimes that are disjoint from the BPF LSM
> > > > programs ... I suppose there may be a way to do it, but it will sur=
ely
> > > > be ugly and come at a cost.
> > >
> > > BPF trampoline already handles all the synchronizations, such as
> > > add hook, remove hook, etc. properly. So this is not that hard.
> >
> > How do you plan to handle the issue of disjoint lifetimes?
> >
> > > All we really need is to allocate a new array, copy pointers, and fre=
e
> > > the old array. And we only really need this in the worst case
> > > scenarios.
> >
> > Oh, is that all? :D
> >
> > Keep in mind that the code must also handle arbitrary ordering of
> > LSMs; in other words, you must handle a BPF LSM that isn't at the end
> > of the LSM order.  While a BPF LSM at the end of the LSM list is the
> > most common, and recommended ordering for the vast majority of users,
> > we've been working to make the ordering as generalized as possible.
>
> All the BPF LSM hooks are called together, so it should be fine.
> Maybe I missed some corner cases.

I was thinking about the LSM framework as a whole, not just the
potential for multiple BPF programs attached to the BPF LSM.

> Either way, I agree with David that we don't need too many xattrs.
> Since BPF LSM is reserved to the privileged users only, it is safe
> to put a reasonable limit, say 4 or 8, and do not handle the realloc.
> If the admin would like to brick a system with BPF LSM, there are
> many other ways to do it.

That is definitely the easier route.  However, please add code to
ensure the number of attached BPF programs is limited to the number of
requested slots.

--=20
paul-moore.com

