Return-Path: <linux-integrity+bounces-6349-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 629F8AC9F3C
	for <lists+linux-integrity@lfdr.de>; Sun,  1 Jun 2025 18:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5589518930BB
	for <lists+linux-integrity@lfdr.de>; Sun,  1 Jun 2025 16:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844EB1C75E2;
	Sun,  1 Jun 2025 16:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1p+hm5e"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90F819F471;
	Sun,  1 Jun 2025 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748793795; cv=none; b=RMbKAGcHtTu1PWjF+D6Q0lZ2ELt+B2pTuTJHyi2k0YspIinuy2xDGotFnQhGEyZlke8EhB8Tpklyv14oDscKA+DP1y1BvKuAgn6aKv80mP/umER0kQn8IfdMt+TZn6QfQIqeByJY7bHxmfB0z2QVGDaF81FXT4j2XKwefT/+zyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748793795; c=relaxed/simple;
	bh=CqNu5CKNnsoXtw6eONVa+80Wv1SuCZ9WHbQ4zCxFe94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PYtVrAMoinzD+ZxTEyuOKeJSSQ/o/g8Toh5ZKggws/qv/GeyT4gRhTESOtb9tuZYzl57nRu0vxBclZLRjsdR033sHuTLAmsy3iNXWn1sVbKQ6i1Tc2066LlfuJ9v/MvLC1TXmnryPd0t9lWK/t/MGJ27pQaDb4TR4QDLjU4n1SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1p+hm5e; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-312150900afso3746251a91.1;
        Sun, 01 Jun 2025 09:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748793793; x=1749398593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UChtZ3RyAoj4ffRZRBtp2eq2BEbfTkn4axpTqzMhb2U=;
        b=b1p+hm5eugGYY/bhaVOEcA5A6lCH+4NTxmsx2rxZRDMXPntzUXLckU8Vbd6dXBClQ9
         E+keofYMGwtzgOVUOk8GwC2JawGG3B7+hUEyyBnuS0PJyzo/GKCdx5dvOTzBAKcQWxc5
         snzIGkk94XyfqwWmo4KFF6Jv/S7gs8cc/8jwc6iwA4ItJVugCoS1PfQdBdmy4/eiNJLF
         yC/F/NsUhlX9qkOJx0fGz+S4e5J+xF/mOrjSuRr1cuygcc9CbXHxmYHeeO7Jg9X83NTp
         mv+eUGhesWq36SFCHRpYjTV/QeIZ08obcyYtD/+DylwZUG0eV2yqUrAzyInrVYWxpDBL
         kOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748793793; x=1749398593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UChtZ3RyAoj4ffRZRBtp2eq2BEbfTkn4axpTqzMhb2U=;
        b=i3lRGbxoPCsLLekRWFwgOcDagWeEQpqkY5JD9FmiFOhN2wNucz6CsrpYnO4Y4+EYW5
         vIBqLHV+P+07PxV/jXcg7tqdtvKHoZSZRpyb5fMaqvqtC5exbum9ng2EVrIxMB0JQMF4
         dAj0Jvcvbdf7vqk/n4pH4VPo/ud0OftAVVcgw2FxPStwxi5UnPgzQ6FXccevw1LtmESz
         SZGBCsubllQN7OAj5flZk0ABowuMnlox0csX0JbzhtUfpvDfs3dhQC+qs+/ogqFJ4G3C
         I7q1mtkAB12u9mMIRI72sbFVvH7+9ZAr3DvlowOYfMY1PFVhqit315sreeWzKROuLBz3
         ODQA==
X-Forwarded-Encrypted: i=1; AJvYcCUAxpLk8YZJhgxtxg01joHF6jWvtsgvW7BS6soE5RJmy8b13AsFZwA8WPYQl7TM0bekjIXvQJxuciv7mf6g@vger.kernel.org, AJvYcCUjks8nV5LchdKIcYpAXEBFWaRjpp8pKV9kTuyoR9yPhWFHE26yIimLMLazvev5pSLpUBHvndbrEL5osDEttDdUgQEJ9sjA@vger.kernel.org, AJvYcCX5oseoyIUX9lKUjEiPezIGOxOXdVsHKgXyFbTgenHU1pPh+2ywwSZLBAWl5ybhICndQGw5plo+PWDeKPaV8pI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSoSSi19IpiDVxcnHQOdLrzLa5OpCfeN8wOo7i4U7fVXg64je9
	VSgFiPfITkv5Ive76CXvCluhnq/siBlkWHaZfzm6liHOj0ekoGpbEVJXtCRU2J5VO9F+TNPEQgt
	BdHLkPgKDWv6C2MeXi3lFr2ldpLtlqP0=
X-Gm-Gg: ASbGnct16piaSataTdk8dso5fUzdunX/DvPjoH58dA0r0iPdsbxvwQYitB+VeoekhhJ
	+TjdlCu0PfI+2oFj0nZ3nt5DzDyJDoW3nGbNxt+75nPPWtzbfwGMG0IkdyBCIaU7yZwzBf3Bbd2
	PnzS8gGSOpLSXFksnRPTFZJlPakoUuDB/2
X-Google-Smtp-Source: AGHT+IFSoRVqyxLbsSJrHW3HefdQnYP2eEgVJB20Dqhf3P7M5oJsVb5jw+m8e0ZWx1dIU6mfRzrN92J1oMNUIqt1Kpk=
X-Received: by 2002:a17:90b:4cce:b0:311:b0ec:1352 with SMTP id
 98e67ed59e1d1-3127c6d7762mr8573577a91.11.1748793792994; Sun, 01 Jun 2025
 09:03:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529174453.293618-1-twelho@welho.tech> <d3a0a5caa69d3af5c9e09d1d15979c9306e5ae8e.camel@ibm.com>
In-Reply-To: <d3a0a5caa69d3af5c9e09d1d15979c9306e5ae8e.camel@ibm.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Sun, 1 Jun 2025 18:03:01 +0200
X-Gm-Features: AX0GCFvXylcEbDWgCtFU2ySd1l21esyQEnZGJ4j0RJd5cUm9Lox_DNVrQXGxIIU
Message-ID: <CAOi1vP9q0LAtARP-cyLD3rkChqqQV=LfZARSySSJMGzpJRz0uw@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph: set superblock s_magic for IMA fsmagic matching:
 up to 60x speedup
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Xiubo Li <xiubli@redhat.com>, 
	"twelho@welho.tech" <twelho@welho.tech>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "zohar@linux.ibm.com" <zohar@linux.ibm.com>, 
	"roberto.sassu@huawei.com" <roberto.sassu@huawei.com>, 
	"eric.snowberg@oracle.com" <eric.snowberg@oracle.com>, 
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, 
	"dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>, "serge@hallyn.com" <serge@hallyn.com>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, 
	"jmorris@namei.org" <jmorris@namei.org>, "paul@paul-moore.com" <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 8:03=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Thu, 2025-05-29 at 17:45 +0000, Dennis Marttinen wrote:
> > The CephFS kernel driver forgets to set the filesystem magic signature =
in
> > its superblock. As a result, IMA policy rules based on fsmagic matching=
 do
> > not apply as intended. This causes a major performance regression in Ta=
los
> > Linux [1] when mounting CephFS volumes, such as when deploying Rook Cep=
h
> > [2]. Talos Linux ships a hardened kernel with the following IMA policy
> > (irrelevant lines omitted):
> >
> > # cat /sys/kernel/security/integrity/ima/policy
> > [...]
> > dont_measure fsmagic=3D0xc36400 # CEPH_SUPER_MAGIC
> > [...]
> > measure func=3DFILE_CHECK mask=3D^MAY_READ euid=3D0
> > measure func=3DFILE_CHECK mask=3D^MAY_READ uid=3D0
> > [...]
> >
> > Currently, IMA compares 0xc36400 =3D=3D 0x0 for CephFS files, resulting=
 in all
> > files opened with O_RDONLY or O_RDWR getting measured with SHA512 on ev=
ery
> > open(2):
> >
> > # cat /data/cephfs/test-file
> > # tail -1 /sys/kernel/security/integrity/ima/ascii_runtime_measurements
> > 10 69990c87e8af323d47e2d6ae4... ima-ng sha512:<hash> /data/cephfs/test-=
file
> >
> > Since O_WRONLY is rare, this results in an order of magnitude lower
> > performance than expected for practically all file operations. Properly
> > setting CEPH_SUPER_MAGIC in the CephFS superblock resolves the regressi=
on.
> >
> > Tests performed on a 3x replicated Ceph v19.3.0 cluster across three
> > i5-7200U nodes each equipped with one Micron 7400 MAX M.2 disk (BlueSto=
re)
> > and Gigabit ethernet, on Talos Linux v1.10.2:
> >
> > FS-Mark 3.3
> > Test: 500 Files, Empty
> > Files/s > Higher Is Better
> > 6.12.27-talos . 16.6  |=3D=3D=3D=3D
> > +twelho patch . 208.4 |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > FS-Mark 3.3
> > Test: 500 Files, 1KB Size
> > Files/s > Higher Is Better
> > 6.12.27-talos . 15.6  |=3D=3D=3D=3D=3D=3D=3D
> > +twelho patch . 118.6 |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > FS-Mark 3.3
> > Test: 500 Files, 32 Sub Dirs, 1MB Size
> > Files/s > Higher Is Better
> > 6.12.27-talos . 12.7 |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +twelho patch . 44.7 |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > IO500 [3] 2fcd6d6 results (benchmarks within variance omitted):
> >
> > > IO500 benchmark   | 6.12.27-talos  | +twelho patch  | Speedup   |
> > > -------------------|----------------|----------------|-----------|
> > > mdtest-easy-write | 0.018524 kIOPS | 1.135027 kIOPS | 6027.33 % |
> > > mdtest-hard-write | 0.018498 kIOPS | 0.973312 kIOPS | 5161.71 % |
> > > ior-easy-read     | 0.064727 GiB/s | 0.155324 GiB/s | 139.97 %  |
> > > mdtest-hard-read  | 0.018246 kIOPS | 0.780800 kIOPS | 4179.29 % |
> >
> > This applies outside of synthetic benchmarks as well, for example, the =
time
> > to rsync a 55 MiB directory with ~12k of mostly small files drops from =
an
> > unusable 10m5s to a reasonable 26s (23x the throughput).
> >
> > [1]: https://www.talos.dev/
> > [2]: https://www.talos.dev/v1.10/kubernetes-guides/configuration/ceph-w=
ith-rook/
> > [3]: https://github.com/IO500/io500
> >
> > Signed-off-by: Dennis Marttinen <twelho@welho.tech>
> > ---
> > It took me a year to hunt this down: profiling distributed filesystems =
is
> > non-trivial. Since the regression is associated with IMA use, I receive=
d a
> > hint to CC the folks associated with IMA code. The patch targets the 6.=
12
> > kernel series currently used by Talos Linux, but should apply on top of
> > master as well. Please note that this is an independent contribution -
> > I am not affiliated with any company or organization.
> >
> >  fs/ceph/super.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> > index 73f321b52895e..9549f97233a9e 100644
> > --- a/fs/ceph/super.c
> > +++ b/fs/ceph/super.c
> > @@ -1217,6 +1217,7 @@ static int ceph_set_super(struct super_block *s, =
struct fs_context *fc)
> >       s->s_time_min =3D 0;
> >       s->s_time_max =3D U32_MAX;
> >       s->s_flags |=3D SB_NODIRATIME | SB_NOATIME;
> > +     s->s_magic =3D CEPH_SUPER_MAGIC;
> >
>
> Yeah, makes sense. Thanks a lot for the fix. It's really non-trivial issu=
e.
>
> Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Applied.

Thanks,

                Ilya

