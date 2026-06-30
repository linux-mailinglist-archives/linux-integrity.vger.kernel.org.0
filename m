Return-Path: <linux-integrity+bounces-9856-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4zFNOs4PRGpwnwoAu9opvQ
	(envelope-from <linux-integrity+bounces-9856-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Jun 2026 20:49:50 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7276E6E750D
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Jun 2026 20:49:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=EQSgW7XY;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9856-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9856-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CEC53004F41
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Jun 2026 18:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8173D9049;
	Tue, 30 Jun 2026 18:46:52 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41742366564
	for <linux-integrity@vger.kernel.org>; Tue, 30 Jun 2026 18:46:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782845212; cv=pass; b=p6HhP8Xx5JTDr6ke+rDW1t4T4rSBPg7TGLSz9IbfFLy8Q+uceqUmwZSIlgtv9hqXF0T+XMymg9behvYN0AXMHrIwjMmKScWz2c3JJq/tvA/sGG0mspt3IaO8p78DJcmIAQYhJNWyjuIKxuRWQeWw6/pBRf2TrNZ3AsMXJ1emXJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782845212; c=relaxed/simple;
	bh=/mr0mxcymU+YTx8PbSVH8xKSeGb4CtbjDq3BsjMlcFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oagPiu/M8JJzhHGRma+PV2v45T1fNxXfnq6PXyf8AACB0pzum4dwzFPP5oZDsNDk49Nnx/kAjUNjukI3CWDyw2kOk4OkfP9yPQaCitOrusikFsfaB9zKEZ4P0ixR7V0L8D/ZiHIjpYimoyQFo198NMemIu0uYzcJyiweryqTvzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQSgW7XY; arc=pass smtp.client-ip=209.85.219.48
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8f0d6853360so18022416d6.0
        for <linux-integrity@vger.kernel.org>; Tue, 30 Jun 2026 11:46:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782845210; cv=none;
        d=google.com; s=arc-20260327;
        b=WAr6Zp47GdT7Sc/lkLWI5FQX0XKjS46j9eWJpYc5YGo6dg4jd4a9buM4EmpcJJr6TV
         0O9Iq5wLt9N7bTuzwJK4r8X+eGwUBr+32HywUPNV1bna9iPPttBeIj6Q6Od26+mju2j/
         swtt7pocEyUh/MZkEqx2FPFUlKGfXISm+Y5FgzEYRd9CXBHLYjLcwJV9NJMonI17bzJU
         7pDvSDcPTvhaQm/WU52H0l5u4Kyorlt/JTwAQRE+fbFH6q8srTA8hiNh4NFjC+tC2FUH
         Sm94TaJWiV/hZteOBa6vsaReWxvZj37LfFuoDbxrym+yhoeKsj6v7MhoBtlS3wOu20Wh
         1RaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/mr0mxcymU+YTx8PbSVH8xKSeGb4CtbjDq3BsjMlcFI=;
        fh=WG5zreT2Dnxd/t6YwRYK1ENVRaZCJLpyCCTLr8HdfYo=;
        b=grTIYXzvdXLRuHoUiSN90VDEaLWi0Ncn63pLFnsSGVNCvQqSvGE0CPeeT+GCaMgRc4
         5pxLYA9jE+XK5o15KgIys7sUJS9RIOF4GXYWylqvAzCzZWyKcMtQT9/zsZ/Su9Uh2R7P
         GdTkk+H8r2LhQfxmteuBh9MxQ1R/+ZLhNQwDXupNOf5O8uL+YTnphzXpGLhByNT7d45s
         Gf32Zi14dOBqBpTA/+syRrllP8I3HwsiZGupwv2nZdtdmVUQRmacb7ASaQJkJaOydWna
         XeHldMXk9IEqXZC+eTuiZiDihNMqfdtCFFUelsEp4uxYMuxWFrSNNJf0hib5J9b437wm
         aosg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782845210; x=1783450010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mr0mxcymU+YTx8PbSVH8xKSeGb4CtbjDq3BsjMlcFI=;
        b=EQSgW7XYwFqpR2UhR5oIjGjz1p7Sl5z7prkaHtU62QYm16o5fwYNMZbZzXDw4N1o7w
         TjaTc8/oiqjtm0zKD8i/CcS95pH2dm+43MADe2rn9aMf1hKPGLdSdl+rh7nEvSKdwdWb
         QjR+GW8xwXjKE83wXgRxXBKZFIbpxBvEorTFKDTnaw6FQqAGR1E6nY0qU6hw6SonOJ6f
         UnNgIa6B4mckZ2hxw1SIudwaouFYge5A1ubJndzfYxye9NPihpkUAmXXjBYL0RLjqY1x
         hVUSvSmtURF36OOyxm9jT4L44uwrOo02x0k956HPazkIOlQs3pQRuCDykMIY8f+Jh/HA
         PW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782845210; x=1783450010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/mr0mxcymU+YTx8PbSVH8xKSeGb4CtbjDq3BsjMlcFI=;
        b=G3JhZwMxywLRApukrNmIreOgiU1EF9FQhgO3FpA0jCfbdXd//qcBTWdXLwYP/R9Qgg
         FJxpNsWZENHIVdRF6l8GX1Z7XWvfUz2aKXxpemjW/JrcAJPKnTM+ys01QaHWzSfcYlpV
         VV+Y+aQebJbT/D92MMdQvh2YfBNMexbxZjGWDJAkXqRAYSSL9JzOK/XUDlUMfwutHayq
         Nyz8wDu8Xesj5MoGy7vxg7KvMwQCFOUP85bGysWyMnpNblPpUFvBqd9UCmFwUPH5LOjI
         GTPJqX3f5wb0RWVNmlvCQ7P5rWlms3dkY2yzVs8zYs3dTgxCqC2gRZS8jYHhOWzcbtM8
         Yvbw==
X-Forwarded-Encrypted: i=1; AHgh+RoD3wuazAfZnDwXqnwECejn3PQgcxtDQeyWLuJ40UXXtcbVw2CuISekQlgO9tmk2I3exwoDoWVJDQy7kIBaRHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr5XJzF+7h8A7iNPM05IiuzjDKVIB/TIvulYN88KAHqxtL5We7
	uwSFTLOLN6WO91g8PskJjYF7utDydj/s7ogV+1Bst0whxnV1kwszLTwrVcSM9tNQQ7whMLJ+CKG
	iT8PYpYGfvOAePvQAeuKOTfr1pmCFNXA=
X-Gm-Gg: AfdE7cmXa0BETCTZBjuuJf2Cm0O8+FwlTssrzsdvZc7bKohUhO46UNll/RFvaGzAxdS
	NUr551R+gorQG+BsHx4MZHA81veTNLSSXN9mkF2Kcay5+o3ti1Iiq9dvYq/jpH9z95XMRZ0FrIm
	dLEJltnPWKl+5GmzGhkTeS+idOUvPj9nZmA135EJLcYK2D3agZI/p6fKmSWJYRmV3snD4HAPX6Z
	JysA+z5Cmf9uWMmx1oF7EnxCz18K0OMg+UyhbiiKCV1D9acBx2c2KkpRAEWugljiKAbbbI9gczy
	FdjM6ssjO6tZ17/M+NJ89YqMTmsX9jKFLxULyA==
X-Received: by 2002:a05:6214:4d01:b0:8f0:b08d:1327 with SMTP id
 6a1803df08f44-8f1bab7325amr66906576d6.20.1782845210237; Tue, 30 Jun 2026
 11:46:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630183956.281293-1-dwindsor@gmail.com> <20260630183956.281293-3-dwindsor@gmail.com>
In-Reply-To: <20260630183956.281293-3-dwindsor@gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Tue, 30 Jun 2026 14:46:38 -0400
X-Gm-Features: AVVi8CeaiheJ3F5i-jO4LvtVLGlRB5U5ReoDcpDUEtFteA-6-xXjOCWxSS0LCkE
Message-ID: <CAEXv5_jCoYbs63RRukH44CMCxiOFzvWWraBOunKrgTVw+inUPg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/3] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
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
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:john.fastabend@gmail.com,m:kpsingh@kernel.org,m:jolsa@kernel.org,m:memxor@gmail.com,m:emil@etsalapatis.com,m:mattbobrowski@google.com,m:paul@paul-moore.com,m:jmorris@namei.org,m:serge@hallyn.com,m:casey@schaufler-ca.com,m:stephen.smalley.work@gmail.com,m:omosnace@redhat.com,m:zohar@linux.ibm.com,m:roberto.sassu@huawei.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:shuah@kernel.org,m:bpf@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,m:stephensmalleywork@gmail.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,etsalapatis.com,google.com,paul-moore.com,namei.org,hallyn.com,schaufler-ca.com,redhat.com,linux.ibm.com,huawei.com,oracle.com,zeniv.linux.org.uk,suse.cz];
	FORGED_SENDER(0.00)[dwindsor@gmail.com,linux-integrity@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9856-lists,linux-integrity=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwindsor@gmail.com,linux-integrity@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7276E6E750D

On Thu, Jun 25, 2026 at 7:23=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
<snip>
>
> We expose a bunch of VFS heavy operations for various security modules
> and this is really not different. For xattrs we have it all centralized
> in the VFS and in general all VFS related bpf kfuncs should continue
> living there and be registered there. Anything that's just bpf infra
> specific can go to security/bpf/kfuncs.c instead. But anyway, it's a bpf
> specific helper so it's the bpf maintainer's call.

After Alexei's requested changes removing the attach-time checks,
there's really not much left to go in an LSM-specific kfuncs file. The
bpf infra plumbing for registering the kfunc and bpf_xattrs_used()
seem to be the only LSM-specific bits aside from the kfunc.

I am willing to put this code anywhere. I've tried to CC all involved
in all 3 patches, even though there's some split in concerns.

