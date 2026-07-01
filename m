Return-Path: <linux-integrity+bounces-9868-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zRuaEzMXRWpS6woAu9opvQ
	(envelope-from <linux-integrity+bounces-9868-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Jul 2026 15:33:39 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 499BC6EE2BE
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Jul 2026 15:33:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=paul-moore.com header.s=google header.b=XJOeGYL2;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9868-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9868-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=paul-moore.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8DCFF3020BBB
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Jul 2026 12:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202F94968E7;
	Wed,  1 Jul 2026 12:55:34 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776824963DD
	for <linux-integrity@vger.kernel.org>; Wed,  1 Jul 2026 12:55:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782910534; cv=pass; b=aJsi2pjm59v7wZvdEpVk5EpfX+YiJdmek5JuLTrUgi4ZiJoYiQyS/GPUvEPnRfwXgCB4vz/ccBOB7cxwnULI69j6zTG3xS/k56zGxK0OIT8BLYcStVXt5PUTpf0NMSCw9JaNZ4LN+tNVdMuNPC5hkMsSav5/iUsXimW9+FXWD5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782910534; c=relaxed/simple;
	bh=wA34yog5D3zzm0E4fzCRQgoVkgu33TRvDEqJe+rugrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xc9yjA1+5sqA55wPPgZNgblk6p7wZaukClLL/MuNvXbbYGm3KPeo+NJgDGL2PZVe4+nlcP9ZbKzninLTC5FZLIwFsc1u+GEI799urDPpzf/J40fHgrlstM1VjJnXDV7NpIJ3aLQszsLYLy+cI75XDFVeaJaZm+m6gmzDKaCK8iI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XJOeGYL2; arc=pass smtp.client-ip=209.85.216.52
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-37de961d1bfso387331a91.0
        for <linux-integrity@vger.kernel.org>; Wed, 01 Jul 2026 05:55:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782910532; cv=none;
        d=google.com; s=arc-20260327;
        b=FX+s87kv792eOj8wCGRmAlb+0mqkmX2/6tP1ngZoaBNjtBTvdpCJ06DWWN4ekNYSks
         4CuEDmTHA4JO4ij9SWLOgO8StQa2ssdBABaue34t15+vSXNeO54vWPs4vVQYpA27X/S+
         Gj0Ix7zPc4ZyhPNV8XvoThfzrroveP4PL74pOe+YsMbyq+OL4luAW5+Yb8s9Od2qLtPv
         twdq/Ix94zfv2Iscu/oNkZ6WAi6RtijA/2wmu9LoHDT2gECd3DMhq5eiwsdNwl4ZwQ4e
         v/JYEJCXyf4MbDkMhMLgJY4Kdpc2AORk4olhUlR06RTULdE7samJWP9qdFK1FPgsQHI3
         xW4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h90qlgRkzmvvEIOKUZmmGycJu0XT3aZbSOeN9EPvQ6Q=;
        fh=lvBeg/xdVYV6dxXfWVUvY59ROVXECaBrieZzbB1RASU=;
        b=BIOOXS2+KaUiPAw+L/kj9/u0C72BI/xH92PfDmzRF3LFzeGx67KXoY7Nz7N8lGB4Yw
         jOkoQyN62jAuu4q5Tg6ESu9JJgzMWGoLH0ZGg5eqKksWNhzFOQkWRTBAJZn35u1UU/nO
         4h42gNFGJWxn9mFcJftftNBOOsIDqajMSO2YiaaowET6hHmfs/dOlfo8ow9Dlyv8J8Ek
         ov0eXsa6XztTFJKQvfr0YX6lMm6VGkFXBNmBXWLUgMObWUVrhf0Jv67YjRO9xxPElrvs
         GfDFj4nklcP6cV20r/QvJNpMBtZm6aC2TADSzJ3H44vo/doC/RPuShHXgeDCN8xeyHr2
         OqkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782910532; x=1783515332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h90qlgRkzmvvEIOKUZmmGycJu0XT3aZbSOeN9EPvQ6Q=;
        b=XJOeGYL2vnZ3JRE/Es/sxl+AEl6mmciMEHV8WocRMoqDSpvCRiZLTHCKfagxX0jsjp
         rZ1/Pgg440tx5WIodjMLHp7WFDhpKee6Cw3+MyK+IVYRb5y4DJnUwVWwH2Ykvu0mYEMa
         UuS9z2EawbiuzRBLbcZfqMtjyEMAQ5o9EFYqKgmvlM7vjk1h0rNIvCKNT9iTouvpeSO/
         Ix89Eab4y1vxTcJV/c3YpT8YkT5/p3wXGdYJ8OsgLpf1ypdvzdGRwpjDjpeFcm3F9OxG
         ZrGRMLWMXUdNaN6PvZXcRLBPym5egq3X+PWeqsoM+e4sTqOxKToNcgGXWhzthx5NPnD6
         BdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782910532; x=1783515332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h90qlgRkzmvvEIOKUZmmGycJu0XT3aZbSOeN9EPvQ6Q=;
        b=pWZiLtaveTw4bD9Gv0pnanfrTVSbvM7iwLl+SIXAfQh+FZCBK7bkK8UZLMliDYqw6x
         aBcfQj0E6rUGx1x7O18JwPKq/H5N4QqHGoSV9BEU9gY7uORHZzbM598Bbs7llpWrrK2G
         ddxZRjGnP4nXc6fUlz1p+102br+qqvHtOZvhHueDUSbIithJdCPZ3Phz8RqYnkauxH40
         rMlUQfd9g9x3g4of6en0leYsA3IzkWYqgp8KVk3XofU56+BxLQScFKTK/4fGZqVggFOY
         D5RGOkRVzxsPeyky3y7BBIeye3+XOsSsNzDiMwtqSIHzx8iZeW12HSl3bw5fdgNdlpxr
         B0zg==
X-Forwarded-Encrypted: i=1; AHgh+RroTZQmf3fLuKpllLGIjvTDKk3mWOL36K7t1RKuuz4ko0QeHkA0Pn0sY8aZeDMyeObdkxJFYSr4f3Q6PhlC4Mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMtwZu0fItaL6QRG12TI6IWTS/dPMfaqa/c69EEGcCAAa1VJ+R
	KEKC+C7rPR1zD3cu/9OQC5MLzMPk4gzoqD39oziyHjcSbdaExpiMqN6qOhcijdjgi9e1dmXUxkg
	1T4QW6cPXI2bp8t3FgKYCPzVpkVEBXfz8DTJQkD8s
X-Gm-Gg: AfdE7ckYjGEgv0XcOeAM4kCd6zJ4EIKt024v8fGSWgL+x5AQBZwtl2uuSbmPhbwTA+q
	Nf+P0WgBIzk++deE4WpQOcbpezFZTIEwdyJCh8XkOJUaN7vf2EJalMGBiLapC/YKuOpHTO9kYy6
	NgKCvhggbNufRjYGpK3j/Hf4MBhB2SOpEHFRV79aB+b3fu07OSLbCEIyUc8Od/fO2OvvNnUzKC9
	U++GPtxEy1ZSVUKxigaOuYk0Ju4iR9tTvfVsNI0JABE/N9m7qqzMePymewJ9ytxwHd2EbFT
X-Received: by 2002:a17:90b:2d90:b0:380:9d0d:7af4 with SMTP id
 98e67ed59e1d1-380ba86979fmr662539a91.12.1782910531759; Wed, 01 Jul 2026
 05:55:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630183956.281293-1-dwindsor@gmail.com> <20260630183956.281293-3-dwindsor@gmail.com>
 <CAHC9VhSYNF=_Tfe-D99rHy70EXQVr1ES0arxT09Bidey4zOFdg@mail.gmail.com> <DJN0EPROS056.3RY0R6W1XZHNZ@gmail.com>
In-Reply-To: <DJN0EPROS056.3RY0R6W1XZHNZ@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 1 Jul 2026 08:55:19 -0400
X-Gm-Features: AVVi8CflgdtI8eLFled3oYp6VOVsv_lBHqIjUE5-aLf2A4hxkcukFfwR6m0D7v8
Message-ID: <CAHC9VhT37f5TwgksE_i0Yttpy3i7niBr6QrNVVmpwe_eGX428g@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:alexei.starovoitov@gmail.com,m:dwindsor@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:john.fastabend@gmail.com,m:kpsingh@kernel.org,m:jolsa@kernel.org,m:memxor@gmail.com,m:emil@etsalapatis.com,m:mattbobrowski@google.com,m:jmorris@namei.org,m:serge@hallyn.com,m:casey@schaufler-ca.com,m:stephen.smalley.work@gmail.com,m:omosnace@redhat.com,m:zohar@linux.ibm.com,m:roberto.sassu@huawei.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:shuah@kernel.org,m:bpf@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:alexeistarovoitov@gmail.com,m:johnfastabend@gmail.com,m:stephensmalleywork@gmail.com,m:dmitrykasatkin@gmail.com,s
 :lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[paul@paul-moore.com,linux-integrity@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[35];
	TAGGED_FROM(0.00)[bounces-9868-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,paul-moore.com:dkim,paul-moore.com:url,paul-moore.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 499BC6EE2BE

On Wed, Jul 1, 2026 at 2:09=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Tue Jun 30, 2026 at 12:20 PM PDT, Paul Moore wrote:
> >> +__bpf_kfunc int bpf_init_inode_xattr(struct lsm_xattrs *xattrs,
> >> +                                    const char *name__str,
> >> +                                    const struct bpf_dynptr *value_p)
> >> +{
> >> +       struct bpf_dynptr_kern *value_ptr =3D (struct bpf_dynptr_kern =
*)value_p;
> >> +       size_t name_len;
> >> +       void *xattr_value;
> >> +       struct xattr *xattr;
> >> +       const void *value;
> >> +       u32 value_len;
> >> +
> >> +       if (!xattrs || !xattrs->xattrs || !name__str)
> >> +               return -EINVAL;
> >> +       if (bpf_xattrs_used(xattrs) >=3D BPF_LSM_INODE_INIT_XATTRS)
> >> +               return -ENOSPC;
> >> +
> >> +       name_len =3D strlen(name__str);
> >> +       if (name_len =3D=3D 0 || name_len > XATTR_NAME_MAX)
> >> +               return -EINVAL;
> >> +       if (strncmp(name__str, XATTR_BPF_LSM_SUFFIX,
> >> +                   sizeof(XATTR_BPF_LSM_SUFFIX) - 1))
> >> +               return -EPERM;
> >> +
> >> +       value_len =3D __bpf_dynptr_size(value_ptr);
> >> +       if (value_len =3D=3D 0 || value_len > XATTR_SIZE_MAX)
> >> +               return -EINVAL;
> >> +
> >> +       value =3D __bpf_dynptr_data(value_ptr, value_len);
> >> +       if (!value)
> >> +               return -EINVAL;
> >> +
> >> +       /* Combine xattr value + name into one allocation. */
> >> +       xattr_value =3D kmalloc(value_len + name_len + 1, GFP_NOFS);
> >> +       if (!xattr_value)
> >> +               return -ENOMEM;
> >> +
> >> +       memcpy(xattr_value, value, value_len);
> >> +       memcpy(xattr_value + value_len, name__str, name_len);
> >> +       ((char *)xattr_value)[value_len + name_len] =3D '\0';
> >> +
> >> +       xattr =3D lsm_get_xattr_slot(xattrs);
> >> +       if (!xattr) {
> >> +               kfree(xattr_value);
> >> +               return -ENOSPC;
> >> +       }
> >> +
> >> +       xattr->value =3D xattr_value;
> >> +       xattr->name =3D (const char *)xattr_value + value_len;
> >> +       xattr->value_len =3D value_len;
> >> +
> >> +       return 0;
> >> +}
> >
> > This is not a generic VFS function, it is a LSM specific function, it
> > belongs under security/, please move the code as discussed previously.
>
> Paul,
> Not quite. It's all about xattrs.
> Having "struct lsm_xattrs" in the arguments doesn't make it lsm related.
> You needs to study existing kfuncs and tracepoints.
> A bunch of them have "*lsm*" in the arguments.

Alexei,

I'm sorry you don't understand the basics of the LSM concept, but
please look at evm_inode_init_security(), xattr_dupval(), and
selinux_inode_init_security() for some background.  There should not
be any usage of lsm_get_xattr_slot() or BPF_LSM_INODE_INIT_XATTRS
outside of security/; you argued a similar idea to justify your NACK
of Hornet, I'm simply applying the same logic here.  We also have the
very recent security issue caused by the BPF subsystem which failed to
acknowledge that the admin disabled the BPF LSM and then walked all
over kernel memory when it shouldn't.  Moving LSM internals outside of
the LSM creates an environment where flaws like this can go
undetected.

As I said previously, if you absolutely insist on the kfunc being in
the VFS kfunc file, the LSM specific bits need to be abstracted out
into an LSM function.

  kfunc bpf_init_inode_xattr(...)
  {
    /* sanity check params */
    if (!xattrs ...)
      return -EINVAL;

   /* get value/len from bpf dynptr */

   /* hook will check for LSM specific xattr count/limits, allocate,
copy value*/
   rc =3D security_lsmxattr_add(xattrs, LSM_ID_BPF, value, value_len);
   if (rc)
     return rc;
  }

David, if you like I can provide you a patch that implements the
security_lsmxattr_add() hook above if you aren't comfortable writing
that, but if you want to give it a shot that's all the better :)

--=20
paul-moore.com

