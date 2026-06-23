Return-Path: <linux-integrity+bounces-9825-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wzT2JFYFOmq/0AcAu9opvQ
	(envelope-from <linux-integrity+bounces-9825-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jun 2026 06:02:30 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0661E6B3ED0
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jun 2026 06:02:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=kvfEHe85;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9825-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9825-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA0F53025C61
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jun 2026 04:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7DB39EF14;
	Tue, 23 Jun 2026 04:02:16 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E34A39D6D6
	for <linux-integrity@vger.kernel.org>; Tue, 23 Jun 2026 04:02:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782187336; cv=pass; b=F0Jak4Uw8G5el3ZYeWR9BhRFOchhS9wkBcK8P3OeDRJQstRfvBpCLdhIDJtFaD97j/yfSGKXk5QDqcIIL9Z7HG8PnEz3DJUdZq1mVaay6qwPwgKDMNUoKa7KJ9YzpQofnJC18efT8PP00fViaDnbI6t9Ta60Zd1+1pP+8Pqa++A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782187336; c=relaxed/simple;
	bh=F0wTGQkkGlxpSFeNyjD6eaC/VlWEy1Nj2KPYSgkBaLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZrPOVF17DLAmMxiOj7I8XaBHmY69yifA5goqGHqe1LSGPtKaAakEHz5AXvQqvTnNN8A3Z+XqQlezqjt7wcWxytvrR/ahHw8oRaFMDm+EXVHvQWHD9Nc8hOR4lzarxcQpbffAUlbj+2RBLxNwi/PJbyteTPLWMsLdOHUQGnBr/54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvfEHe85; arc=pass smtp.client-ip=209.85.222.179
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-9159477c893so602281485a.0
        for <linux-integrity@vger.kernel.org>; Mon, 22 Jun 2026 21:02:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782187328; cv=none;
        d=google.com; s=arc-20240605;
        b=JXANWB88FNLC5oN8QihLEkrgQrenDPM0aLIdaRMPaAIgB0WZ63TMzZ0x2oXIhGPxxP
         VUJf8sZS6W0w6MB2tbtO2cuHK2E21ZDeB/uaU0rkERew/TM3FPohTFj1qS0AuwSEZpYD
         8tan2chUT7j0X/WkxLUg2ZHjZeGDovF21QOWrLc41BTrCYiyux7W34YIOTML2CbCT5Dk
         Cj7lSyFrZA5/BRJlkrPcNBnCCn6qIECyJltJbkydDPyZWupkZ6VJSJ4qjVUu34JuQ2vu
         ZBiDqVkxVNC+lYmUNelFAlpvMVH4uEp2K9eRMSl8mj3DK/WDIt6Q5/cqzjmA72yre8il
         YlIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eW8+mqrmr6N7CBulx1m18TzlUYk2VeJ10g5AWzjPQEQ=;
        fh=f3kEMy+qv6+X7PwlkE/Mg6ObskzxgOg0S7yKrkeR2T8=;
        b=QuK9TkJbd079M+HNTVbk5F/rK4XxMiIj3t9WcVsoqbbdcu8Sq2ixL/BWrTzbEEmCZQ
         VaOYtmWL9HZp/AT1I5NmnxFxxTUlDQu0gLPYMiehauoYk5n6oxsscbsW0srFm4cnKQw/
         w24qjX0SqsccKzA3q1SBbJxFQSanjnmRBf+gl2vHFHtqP265dZDDRHSenJdFuVfp/pEF
         7lIfQY09HKA7sOBM2YE6mcE0+mYXv/zA7YF8MwhpZfP9UohvJQ3VkZItYXV1SD7Faxqq
         cLRuOjyuWxoL9EEoUfanwZt2qRwO6CXvuEHsaTPVp3tE4no5U049c6z1u3sds+7mnEzz
         OWOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782187328; x=1782792128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eW8+mqrmr6N7CBulx1m18TzlUYk2VeJ10g5AWzjPQEQ=;
        b=kvfEHe85g9lUYBp4b+HBBNOtnEXPs2FhHtjfbueg3OXE/2zsiVDDCk5Sf2KOR1lxib
         zIoQxQiskpChFQyo21WNgATlA1ZTx/GP/aSDvLer8bGK1k/DXX2aghlwkYqQv2pFkyFz
         oked1raJu7gLr0qxR3h80MSU/LFbvjxaK41XdPy0f5iGOahOso5D6brjklO00daNIfq1
         gIxALTWLg3bznUVXFcT2ZVDOgIwpidNjrhE9Sc+zhNk1C8e6f6KiwIxKTskiB6kpTBMK
         w1nNx8ay0Yr5pDD5SIS7zDfDIGIW66P2uO5D9Xu05DDJK12HXpSTUlR+6N1r5JyQ9KZc
         sUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782187328; x=1782792128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eW8+mqrmr6N7CBulx1m18TzlUYk2VeJ10g5AWzjPQEQ=;
        b=YmirqDOG3yAsjA66AALNqni2J9ncWupxAQNocWZf03j671hgnf+cqA9uhp9+kESExU
         TCY3TqUmBtaT08vSkqIK0Oubw/qW5eq2KLfPBUAJmcUHNiGqoiNWkQN70zNleSp17sXE
         udh3mE70K6q4RSH7ewX60LRPOaY85hKX4onrg6YvZWh80a7s/29rqkMdZz5bY1dGyKvv
         la7/dhI/t3xxHzt2EtGQnrMFfn7zXMduRSKmffxup/mmNF2zihPq5Z6BpYTip+iOmL0s
         cNVRY2TPfz9xV8W3UYrPuqVADte9wuV0ycr1QG+UspoDvWzOLxLxtg8huV3AXEP/qew5
         4GOw==
X-Forwarded-Encrypted: i=1; AFNElJ+Vl6wY4b2rxWzfsWWdIcUj/zGkBnf7XYm/k7c/64TEYWnv6GoiUL7eVwU0w8U1RNf4y51HmYZL5sss8t/tEP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpKOed5NjsoX1g4usUvpllr8qyNRJugO78q2pE8cW9z1ECGLtJ
	0SlrTwilZlMdPBWDcSiO7xzXqWhyI6tQv5AtlnVUJL0tn+a/IXGuB8lj8TEQYSdwbhcNzWTZ4DR
	uLYrWF4wjVsYkkdHWex2X+9vEaeA06leY6z9c
X-Gm-Gg: AfdE7ckUiJ7BbvID5kEQuliqDtBOEGIwV+IQJlc7qDDdfbzEuM6jsIMzvrj2UCLxbuX
	XYeFmkTFwNoD/VYndnpadfbyc5hELmOjML03FjoFpD1/oN8eTKvsGTfgpv2K71VfeR0HIE1ILoC
	UgZgCLcJ+xpKpi86CqIe6v0Crgsgioio/07S+I4gyXT22GRiX6iOAp5KT8S6TVQlp5Garbh7WXR
	ktrgCylX01iYCVOCBZEhNbMpv/DFJYDiL2QXOvET3aVs9kjEFtl02PJ5kjNLrS9Blz4Y5+rUcPN
	q0IOGqArpWMxtp+/m5q19cNcRQbdUJpipkG1CA==
X-Received: by 2002:a05:620a:4808:b0:915:e9c3:f1a0 with SMTP id
 af79cd13be357-9208f05c232mr2733502085a.12.1782187328229; Mon, 22 Jun 2026
 21:02:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618203411.73917-1-dwindsor@gmail.com> <20260618203411.73917-2-dwindsor@gmail.com>
 <DJFZGYZFMN73.1799LMXW49WZO@gmail.com> <CAEXv5_jVXS4JoExcd71YkXEE2WXPJ0_9STO-uCwgNF+Eia_h5w@mail.gmail.com>
 <CAADnVQJsdrL2RjxM4UE1WyWrT9KsprFP+=xLHRtFhUSccDqQcg@mail.gmail.com>
In-Reply-To: <CAADnVQJsdrL2RjxM4UE1WyWrT9KsprFP+=xLHRtFhUSccDqQcg@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Tue, 23 Jun 2026 00:01:56 -0400
X-Gm-Features: AVVi8CdBJDCEtsjZ6Cr-k5RWu5qRO4rCaGhk6aOZoAtNJHl7U-y4zrw2gKO9F3E
Message-ID: <CAEXv5_jTxeTRdWpv71=6k_VTN4ZCes30xPs746Frw96fShfe4w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
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
	TAGGED_FROM(0.00)[bounces-9825-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0661E6B3ED0

On Mon, Jun 22, 2026 at 11:59=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> >
> > > > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > > > index 1a721fc4bef5..b41b02173e24 100644
> > > > --- a/kernel/bpf/trampoline.c
> > > > +++ b/kernel/bpf/trampoline.c
> > > > @@ -859,6 +859,9 @@ static int bpf_trampoline_add_prog(struct bpf_t=
rampoline *tr,
> > > >       }
> > > >       if (cnt >=3D BPF_MAX_TRAMP_LINKS)
> > > >               return -E2BIG;
> > > > +     if (node->link->prog->aux->attach_limit &&
> > > > +         tr->progs_cnt[kind] >=3D node->link->prog->aux->attach_li=
mit)
> > > > +             return -E2BIG;
> > >
> > > No need. The check inside kfunc is enough.
> > >
> >
> > Paul wanted this check because it occurs at bpf prog attach time,
> > whereas the one in the kfunc is at inode creation time.
>
> Sorry, we're not adding redundant code to the verifier.

Thanks, will send v4 soon.

