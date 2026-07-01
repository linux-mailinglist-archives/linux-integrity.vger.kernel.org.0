Return-Path: <linux-integrity+bounces-9869-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4gTnAgUwRWqg8QoAu9opvQ
	(envelope-from <linux-integrity+bounces-9869-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Jul 2026 17:19:33 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 846F76EF306
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Jul 2026 17:19:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=paul-moore.com header.s=google header.b=EA1350GK;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9869-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9869-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=paul-moore.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE3963198406
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Jul 2026 15:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872813F485E;
	Wed,  1 Jul 2026 15:09:41 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D7A48A2D5
	for <linux-integrity@vger.kernel.org>; Wed,  1 Jul 2026 15:09:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782918581; cv=pass; b=DfSuLwZmDGkYeOYV7kDRDO9quXw1eq32oF1YU52AAy9+PD4/0tub2/jgOr6ewnxNrahva9tudEhowMrqOcXXHYEQ8SfzCFqPwUb9V0eLIGtS6P0qzNy6tJ3Qny9PZPJG5NlXUgIVsLMn3CSuX4pPDMWGGsTlSBfG8Nj7VpXP9QA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782918581; c=relaxed/simple;
	bh=7M2c8VTJCknMV3dlvitg2YbEGnXAzIGFFQtNc7mfEiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=plYR3kPxzdCbI6yUkqCq+C/Ipa5h7MN483sSk7BAfJxZxNGZAOFsP0fvgA1eLmhH7H7lqEVGv/CFUWINLpTlsYd2hGSLlj6+F4v2BBpkxIrQ8NYH8ftjzwuqziOD4eZB6y5UCQ5QI6PDsDuCE0EwjUwvhc7uSaRwPdEkhFhO/zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EA1350GK; arc=pass smtp.client-ip=209.85.216.52
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-37d46e0d246so368850a91.2
        for <linux-integrity@vger.kernel.org>; Wed, 01 Jul 2026 08:09:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782918576; cv=none;
        d=google.com; s=arc-20260327;
        b=A09u9sNcEhjSvwjA+ugs2w9mpOUo+FzqU0VHFibo7sK4AZa49JVYfC4nLrRybpmTZq
         l8FeS/Bxeq9U9N5gnhpdPuOBoxiLv02Zlxo58+p//ZoNVj2BhEa+YBxsiJuANJTxc/Ef
         NifnfRKgyqxJCbnFG0vSUlBVV4hC0A1L40/2wtb1YARCABG6cLBDiLfPRuw/ZkXzhlQR
         3Bkj3TgwQbm8hThp9J9ViOD94X+dEz8lUZy48YgpgSPbfwq+3/nch0d8EI1Q9HcBiQz9
         tw45p6gmOlud5Ex3m7s5UdN/XUID6tVBDWywotxeMmJDkSMkG2c691ClwUjNJEGSHtFO
         Mxow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EiDHBob2ABPUTvdRmOeqDRgvjmRDWIfShl42n0T52g0=;
        fh=XXgIqRsNdflDxwrtlSSEV9y0o8+TmqRd0eTYYDMEpkY=;
        b=ePb7ZYBj1udbPIcQdayHOIbLjDzDn+R9xB4PIWf0gYNtA2thdtVkHCaiooJbGgRjTk
         2m0HlbVZT4vsE1akGxtgSvziP2zur8Y6y0dS32uH2KnYY4a9G2tC007kUjyDBabJLqu4
         Rr0gvuBYr1zrJZfpBQ+Jdl3dif4U9k0KDjf7GM8tSQ5a4bh8Eyt9CxwQBpShSPY95Pgx
         Q8XddMulNVgQtZnJhxR/hcw88V0NNTirxQeh1nFnfdbcn/WaDy39kfVcLbNSvCsvU0ZB
         MZ85VmKTRPREGMr/d8YAhp0KY3pjlOpsD8vSph5wLANI7kBQqN3HMLm5oROrsC36Ln42
         anEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782918576; x=1783523376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EiDHBob2ABPUTvdRmOeqDRgvjmRDWIfShl42n0T52g0=;
        b=EA1350GK7TBvwQjRPxtTmy0xOLK6+1ocpKMN/s3yCUZoPqzoI1izrKktlLbr4iMk9r
         xbGaco5NJ8ZuRerWfuse4SrvNb5yFm8Wo/2Nt+QWaXbdqQjFqLgl3ZG3z89t5q1tM7o7
         0IqWZQtts8lxFuW1JoOO0sQAvVCB9VnGnXrUUdj1qf7/5lyF8yBzIHENte4XHZ0sFsGw
         t5xrgXNaYYtAD/T8Mes8p8dOs2aTw6uMpS5uQpHKMHLxOohxaGfh2f6ImPT4LrHlT69m
         HgLjt1hlyv5scAn6JaJA0j0yiAc8615T+lyCM/MV+UVxx94HslHRYXLMzviaxTXuIwQG
         reow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782918576; x=1783523376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EiDHBob2ABPUTvdRmOeqDRgvjmRDWIfShl42n0T52g0=;
        b=DFhOeZBRzsVx7CN81kPe7kPyIo5OJoL6sT9AIIUeFxOGTojbCzQvGKrNifZvW4U+lP
         WI8nch2PEWh5OheFUHGQ7piu16rvIubLUxJvRZeneY+5Axrjx5bm8vcdu6BEGNHNeYH4
         Ys39ePzV6SET66/g7JblrX3byJxQchR3kU+GjGBKRFZ0o0MtMkuShkZ6iDxAm1jRs4Tb
         uSzug07+/ZrOMQRZTb1O7Vlj4UxOyPkAjP2yufy/H6t79tEOokk/VOB6KrmAIC5+Svw7
         jDw4oRf0h2YThA+y96n2Jhk/PTBrm6x+Cy5L9lhePSFIim3g4BUMguMomeBZ7UpWw2O3
         0HxQ==
X-Forwarded-Encrypted: i=1; AHgh+RrKkUOjLNGVT4aF1P6vmZ9yDJ4ZlW5hzRfugyo9Ad3WlO5G6M1+BRGtDLNZGVsWfu9wYDegYZG61I9lNXoBfD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2s5lnFn+rsLMhsL2I0xrDLkFmdKaKEccSO7G6ob7Ai/LKVags
	6DNbzAQfY5ubyyxXwGh+pjeNGtgY48JC3GslTfRvmGcA27wIaU7MQfVoXrq/PQP8lLEswNniKAm
	brY+JN8+Mr1FhSgFoRIbUu4bkG2CmU+TkBky/6qUZ
X-Gm-Gg: AfdE7clfYaONkP0axwV3wr6bQniJvHHlUP6YaEGqQf+o3ZSDqOIBGv73hSqy7Zlz4zY
	bXiA7iJ40AvHzM8ft6qsvNfSAr1AGtxy82Xmuj+Ga8IAQehy9R2o2fQwrNXdSI4719ULRpUFAVD
	Iz5ncQl9hXRpkXgQghE8zkKGa4EnmxpirRdMrj3lIoNk1X5Bv+wvbLBdxInbaz8jwyFjOnhg2Of
	i7o2CRbk8IY2yoOV9ABUaJotFgzNtUU7hdVmq4jOWd/fD3x+qcEB/s9RCynZelqB31Y30UP
X-Received: by 2002:a17:90b:4f4b:b0:37f:fb1d:63fa with SMTP id
 98e67ed59e1d1-380aa1427e9mr2152660a91.15.1782918575927; Wed, 01 Jul 2026
 08:09:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630183956.281293-1-dwindsor@gmail.com> <20260630183956.281293-3-dwindsor@gmail.com>
 <CAHC9VhSYNF=_Tfe-D99rHy70EXQVr1ES0arxT09Bidey4zOFdg@mail.gmail.com>
 <DJN0EPROS056.3RY0R6W1XZHNZ@gmail.com> <CAHC9VhT37f5TwgksE_i0Yttpy3i7niBr6QrNVVmpwe_eGX428g@mail.gmail.com>
In-Reply-To: <CAHC9VhT37f5TwgksE_i0Yttpy3i7niBr6QrNVVmpwe_eGX428g@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 1 Jul 2026 11:09:24 -0400
X-Gm-Features: AVVi8CcBAyyRDQX1axrqRUEsD0mhbBnmDeJwn8TvqCnNRpyrxWdbtlabDC-kdt0
Message-ID: <CAHC9VhQd0-N1g=g8gspeV7bhLz0LA6DF5HZyB7mW6VW_7oSt2w@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/3] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Windsor <dwindsor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:alexei.starovoitov@gmail.com,m:dwindsor@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:john.fastabend@gmail.com,m:kpsingh@kernel.org,m:jolsa@kernel.org,m:memxor@gmail.com,m:emil@etsalapatis.com,m:mattbobrowski@google.com,m:jmorris@namei.org,m:serge@hallyn.com,m:casey@schaufler-ca.com,m:stephen.smalley.work@gmail.com,m:omosnace@redhat.com,m:zohar@linux.ibm.com,m:roberto.sassu@huawei.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:shuah@kernel.org,m:bpf@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:alexeistarovoitov@gmail.com,m:johnfastabend@gmail.com,m:stephensmalleywork@gmail.com,m:dmitrykasatkin@gmail.com,s
 :lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[paul@paul-moore.com,linux-integrity@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[35];
	TAGGED_FROM(0.00)[bounces-9869-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-integrity@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iogearbox.net,linux.dev,etsalapatis.com,google.com,namei.org,hallyn.com,schaufler-ca.com,redhat.com,linux.ibm.com,huawei.com,oracle.com,zeniv.linux.org.uk,suse.cz,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[paul-moore.com:dkim,paul-moore.com:email,paul-moore.com:url,paul-moore.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 846F76EF306

On Wed, Jul 1, 2026 at 8:55=E2=80=AFAM Paul Moore <paul@paul-moore.com> wro=
te:
> On Wed, Jul 1, 2026 at 2:09=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Tue Jun 30, 2026 at 12:20 PM PDT, Paul Moore wrote:
> > >> +__bpf_kfunc int bpf_init_inode_xattr(struct lsm_xattrs *xattrs,
> > >> +                                    const char *name__str,
> > >> +                                    const struct bpf_dynptr *value_=
p)
> > >> +{
> > >> +       struct bpf_dynptr_kern *value_ptr =3D (struct bpf_dynptr_ker=
n *)value_p;
> > >> +       size_t name_len;
> > >> +       void *xattr_value;
> > >> +       struct xattr *xattr;
> > >> +       const void *value;
> > >> +       u32 value_len;
> > >> +
> > >> +       if (!xattrs || !xattrs->xattrs || !name__str)
> > >> +               return -EINVAL;
> > >> +       if (bpf_xattrs_used(xattrs) >=3D BPF_LSM_INODE_INIT_XATTRS)
> > >> +               return -ENOSPC;
> > >> +
> > >> +       name_len =3D strlen(name__str);
> > >> +       if (name_len =3D=3D 0 || name_len > XATTR_NAME_MAX)
> > >> +               return -EINVAL;
> > >> +       if (strncmp(name__str, XATTR_BPF_LSM_SUFFIX,
> > >> +                   sizeof(XATTR_BPF_LSM_SUFFIX) - 1))
> > >> +               return -EPERM;
> > >> +
> > >> +       value_len =3D __bpf_dynptr_size(value_ptr);
> > >> +       if (value_len =3D=3D 0 || value_len > XATTR_SIZE_MAX)
> > >> +               return -EINVAL;
> > >> +
> > >> +       value =3D __bpf_dynptr_data(value_ptr, value_len);
> > >> +       if (!value)
> > >> +               return -EINVAL;
> > >> +
> > >> +       /* Combine xattr value + name into one allocation. */
> > >> +       xattr_value =3D kmalloc(value_len + name_len + 1, GFP_NOFS);
> > >> +       if (!xattr_value)
> > >> +               return -ENOMEM;
> > >> +
> > >> +       memcpy(xattr_value, value, value_len);
> > >> +       memcpy(xattr_value + value_len, name__str, name_len);
> > >> +       ((char *)xattr_value)[value_len + name_len] =3D '\0';
> > >> +
> > >> +       xattr =3D lsm_get_xattr_slot(xattrs);
> > >> +       if (!xattr) {
> > >> +               kfree(xattr_value);
> > >> +               return -ENOSPC;
> > >> +       }
> > >> +
> > >> +       xattr->value =3D xattr_value;
> > >> +       xattr->name =3D (const char *)xattr_value + value_len;
> > >> +       xattr->value_len =3D value_len;
> > >> +
> > >> +       return 0;
> > >> +}
> > >
> > > This is not a generic VFS function, it is a LSM specific function, it
> > > belongs under security/, please move the code as discussed previously=
.
> >
> > Paul,
> > Not quite. It's all about xattrs.
> > Having "struct lsm_xattrs" in the arguments doesn't make it lsm related=
.
> > You needs to study existing kfuncs and tracepoints.
> > A bunch of them have "*lsm*" in the arguments.
>
> Alexei,
>
> I'm sorry you don't understand the basics of the LSM concept, but
> please look at evm_inode_init_security(), xattr_dupval(), and
> selinux_inode_init_security() for some background.  There should not
> be any usage of lsm_get_xattr_slot() or BPF_LSM_INODE_INIT_XATTRS
> outside of security/; you argued a similar idea to justify your NACK
> of Hornet, I'm simply applying the same logic here.  We also have the
> very recent security issue caused by the BPF subsystem which failed to
> acknowledge that the admin disabled the BPF LSM and then walked all
> over kernel memory when it shouldn't.  Moving LSM internals outside of
> the LSM creates an environment where flaws like this can go
> undetected.
>
> As I said previously, if you absolutely insist on the kfunc being in
> the VFS kfunc file, the LSM specific bits need to be abstracted out
> into an LSM function.
>
>   kfunc bpf_init_inode_xattr(...)
>   {
>     /* sanity check params */
>     if (!xattrs ...)
>       return -EINVAL;
>
>    /* get value/len from bpf dynptr */
>
>    /* hook will check for LSM specific xattr count/limits, allocate,
> copy value*/
>    rc =3D security_lsmxattr_add(xattrs, LSM_ID_BPF, value, value_len);
>    if (rc)
>      return rc;
>   }
>
> David, if you like I can provide you a patch that implements the
> security_lsmxattr_add() hook above if you aren't comfortable writing
> that, but if you want to give it a shot that's all the better :)

One other thing - as this patchset is primarily LSM related, it needs
to be merged via the LSM tree.  If Alexei can't tolerate the LSM tree
merging a minor BPF patch he can either choose to pull from an LSM
tree topic branch or we can merge the LSM infrastructure bits now and
he can merge the BPF changes when the LSM bits hit Linus' tree.

--=20
paul-moore.com

