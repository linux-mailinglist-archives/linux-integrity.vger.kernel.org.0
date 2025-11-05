Return-Path: <linux-integrity+bounces-7573-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AD6C36852
	for <lists+linux-integrity@lfdr.de>; Wed, 05 Nov 2025 16:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A14D5013FF
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Nov 2025 15:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6115633C52A;
	Wed,  5 Nov 2025 15:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NaXLpIL/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011CE33BBD5
	for <linux-integrity@vger.kernel.org>; Wed,  5 Nov 2025 15:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762357340; cv=none; b=XoWZdRStxfjqEmQ5mTxkim/rlO1WuOwxm4QAlmgeeZbDolbvgfZu3IxGexDNiXSy7qdcEeObpFfg9FXCWAgGNpprO3D2BuhHz5ZkLMLt6Frs8f1M06nbcMI/UoMpSxvM/tN3YMfe6aTBwzGbc/MGaupj37SYlw4agEwPpUZvz/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762357340; c=relaxed/simple;
	bh=Iba7LH/Bs8qFsrpJypki6edNxDKATUSsuPANrTlNJQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d9az4lIXByxsLSx3ORVD6qhxhsBvh1QhpJAUtqEAR3nK6jL7AncrbM1VeuEOWsrHwdHw3ujb2mC3FPs8Vr7B7GYKH8SAcYthA9ZqZXn9olNNi046IE31Ikb0KHvVGC8uGgRlPqbzkbnzJ2hww9DZS2XCoeyYfAVLTsQfjKnryoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NaXLpIL/; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29555b384acso48107615ad.1
        for <linux-integrity@vger.kernel.org>; Wed, 05 Nov 2025 07:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1762357337; x=1762962137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H32OZm73A90v3osjPzr+/wU/KyfXBz0Q5coNZvD4LuY=;
        b=NaXLpIL/zrLoL3Er2MxzYSkoT7QM/u0WS/f5teKMA4ll2lSfpq/1Eodpucp/gmBYlM
         UVDwwxunEGM9GsR5ON7K8Hh1Irjnqu2XM58JpbOMyC7M4NiLhW+3MluzY1KC5vSpMF/m
         sTP8HKxPjJDlWO+rS+hvOnGoWQ/nsyFOaBWKh6KfqOhpkNo9hO+ucd2q+ghlubbBqo0Y
         +7EhabB+DQCrSgH6Z3xlO29bcB67ogvZJLrATWbf1WEQhwmSGFnCsMRjGmgTvPbLAC/C
         o4/EfL7/pIHboOWORoQgyz7skwuwDY0bJE1XPoIb0uoA49VeyQy+FRQJEhWEe0eWMK+B
         +tZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762357337; x=1762962137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H32OZm73A90v3osjPzr+/wU/KyfXBz0Q5coNZvD4LuY=;
        b=l6215U2RynxHR7iKAJsa/BSyfwOb4y5X0og2Y3/9Uh3OXe5j9x1jCdfQo7uuhZ5YTO
         xHmT8wWr2fZM4iQraS6Cxb0ry967lWZji/M3tjlfmusjQgNYtbx8ey9/EdsRWzJ3whox
         reTP5MCF/YvoflPcRGqPr5B70YGFLWYWxKxQFlY4LEF3Hc4yCO4YdCsgc1wGFNYpDsR1
         95IZ/S1TVTnRNhaFaPExjsRH3LZzvjfJWmLYEDtMk2O97VoXzPvvA8M3mxlyhAUXDdnJ
         yO+7ap1iEXc6b/2abS+PUk14bQN6qgoWgXoROvVAVS4GpP3j/ay/OH1QdxSWjM1hDZvS
         VgmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMmK7w62GBtrmbCpS0+3HT/JaKcyVtDaeLtEN3kBo87jj5tMUvWivvyqwbkqAVh7t0BjFlyfMyK7w0FqfT6Mo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdyujWF9qgjdLgAonHbvs7Q+SYkZmlH7d8mesy/r5yIYASRdy+
	sX2gUJhgLEAxmwxyQNjXzbhMEObmMCoZWwQoeqXKeoXfskun0nFNh0mRXvweZ91ilYOfSYyo4cr
	MNwyyWTAiA0e/TBvNUyxRTdXKB26Qb+PRUTgqauGw
X-Gm-Gg: ASbGncuoS6Po+Cuc418afGCy1md71wCChsp7kcn5m+U1k6Af/mArdRrQKg/5eyba0Td
	WsUBcAJclQ4LBmkkxLwSWrvokcMOuqc1XJs24St9orzKbCTh2LEuBqQurnw5R+bQFjs4T8Op+EM
	fIGkayjmf3I23/HlffcM2SeOv4m/3fO5ZhkKPX4sCQ3OtN7b+av+rMTSOlIIoT3jnlheXd8XmeO
	w3HGkMPaA515fKe1HnLevUALDqm1MlIcTJ3N1+PGlyp7uL/MJQH82fhH61a
X-Google-Smtp-Source: AGHT+IGd/j4s18IFElpzZGFgP4ETfYaHvFGNh7TpktX+wcy4cq6aEqn3mplaYtty5v4Q54o05/rNfTw5Wcf3twZ5Giw=
X-Received: by 2002:a17:902:ef49:b0:295:4620:3e18 with SMTP id
 d9443c01a7336-2962ad2b255mr61501535ad.24.1762357337298; Wed, 05 Nov 2025
 07:42:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928030358.3873311-1-coxu@redhat.com> <20251031074016.1975356-1-coxu@redhat.com>
 <CAHC9VhRBXkW+XuqhxJvEOYR_VMxFh4TRWUtXzZky=AG_nyBYEQ@mail.gmail.com>
 <baa39fcd1b6b485f14b8f06dcd96b81359e6e491.camel@linux.ibm.com>
 <CAHC9VhToe-VNqbh6TY2iYnRvqTHRfQjnHYSRWYgt8K7NcLKMdg@mail.gmail.com>
 <fftfj4o3kqxmfu3hb655xczqcddoeqjv55llsnwkrdu5isdm4z@6sqe3k24a6kk>
 <CAHC9VhRGwXvhU64Nk5jdmtPfrt9bbkzpLVqS0LRbtN3Q3HhnCw@mail.gmail.com> <0c7e94a436a3742003e5e1155a48480d8307a9c7.camel@linux.ibm.com>
In-Reply-To: <0c7e94a436a3742003e5e1155a48480d8307a9c7.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 5 Nov 2025 10:42:05 -0500
X-Gm-Features: AWmQ_bk9pEteWi73RS9euB226vzsor-YYmPiiJS9QGZvrRveM1VMwnJqW9ds-64
Message-ID: <CAHC9VhS6xWvu5TjjS4MRGFEWxdAhg-Xsf6L+=K0k8U+fgiAtTQ@mail.gmail.com>
Subject: Re: [PATCH v2] lsm,ima: new LSM hook security_kernel_module_read_file
 to access decompressed kernel module
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Coiby Xu <coxu@redhat.com>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Karel Srot <ksrot@redhat.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:MODULE SUPPORT" <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 9:07=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> wro=
te:
> On Tue, 2025-11-04 at 21:47 -0500, Paul Moore wrote:
> > Assuming I'm understanding the problem correctly, I think you're
> > making this harder than it needs to be.  I believe something like this
> > should solve the problem without having to add more conditionals
> > around the hooks in kernel_read_file(), and limiting the multiple
> > security_kernel_post_read_file() calls to just the compressed case ...
> > and honestly in each of the _post_read_file() calls in the compressed
> > case, the buffer contents have changed so it somewhat makes sense.
>
> > Given the code below, IMA could simply ignore the
> > READING_MODULE_COMPRESSED case (or whatever it is the IMA needs to do
> > in that case) and focus on the READING_MODULE case as it does today.
> > I expect the associated IMA patch would be both trivial and small.
> >
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index c66b26184936..b435c498ec01 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -3675,17 +3675,19 @@ static int idempotent_wait_for_completion(struc=
t idempot
> > ent *u)
> >
> > static int init_module_from_file(struct file *f, const char __user * ua=
rgs, int
> > flags)
> > {
> > +       bool compressed =3D !!(flags & MODULE_INIT_COMPRESSED_FILE);
> >        struct load_info info =3D { };
> >        void *buf =3D NULL;
> >        int len;
> >
> > -       len =3D kernel_read_file(f, 0, &buf, INT_MAX, NULL, READING_MOD=
ULE);
> > +       len =3D kernel_read_file(f, 0, &buf, INT_MAX, NULL,
> > +                              compressed ? READING_MODULE_COMPRESSED :=
 READING_
> > MODULE);
> >        if (len < 0) {
> >                mod_stat_inc(&failed_kreads);
> >                return len;
> >        }
> >
> > -       if (flags & MODULE_INIT_COMPRESSED_FILE) {
> > +       if (compressed) {
> >                int err =3D module_decompress(&info, buf, len);
> >                vfree(buf); /* compressed data is no longer needed */
> >                if (err) {
> > @@ -3693,6 +3695,14 @@ static int init_module_from_file(struct file *f,=
 const ch
> > ar __user * uargs, int
> >                        mod_stat_add_long(len, &invalid_decompress_bytes=
);
> >                        return err;
> >                }
> > +
> > +               err =3D security_kernel_post_read_file(f,
> > +                                                    (char *)info.hdr, =
info.len,
> > +                                                    READING_MODULE);
>
> Without changing the enumeration here, IMA would not be able to different=
iate
> the first call to security_kernel_post_read_file() and this one.  The fir=
st call
> would result in unnecessary error messages.

Given the patch snippet above, in the case where an uncompressed
module is passed into init_module_from_file() there would be the
following checks, in this order:

 * kernel_read_file()
 -> security_kernel_read_file(READING_MODULE)
 -> security_kernel_post_read_file(READING_MODULE)
 * init_module_from_file()
 -> NONE

... this should be the same as the current behavior.

In the case where a compressed module is passed into
init_module_from_file() there would be the following checks, in this
order:

 * kernel_read_file()
 -> security_kernel_read_file(READING_MODULE_COMPRESSED)
 -> security_kernel_post_read_file(READING_MODULE_COMPRESSED)
 * init_module_from_file()
 -> security_kernel_post_read_file(READING_MODULE)

... the two differences being that the hook calls in
kernel_read_file() use the READING_MODULE_COMPRESSED id, which seems
appropriate as the data passed to the hook is the compressed
representation, and the additional _post_read_file() hook call in
init_module_from_file() using the READING_MODULE id, as the data
passed to the hook is now uncompressed.  Not only should IMA be able
to easily differentiate between the two _post_read_file() calls, but
it should have access to both the compressed and uncompressed data.

--=20
paul-moore.com

