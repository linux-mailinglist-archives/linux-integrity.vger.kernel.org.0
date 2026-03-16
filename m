Return-Path: <linux-integrity+bounces-8997-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WI4jMvlGuGmLbAEAu9opvQ
	(envelope-from <linux-integrity+bounces-8997-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Mar 2026 19:07:53 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E936229ED4D
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Mar 2026 19:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A134A3015EF0
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Mar 2026 18:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E34345734;
	Mon, 16 Mar 2026 18:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHPubJmj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E4E34321A
	for <linux-integrity@vger.kernel.org>; Mon, 16 Mar 2026 18:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773684432; cv=pass; b=RnkiFBPhWckfUbqN9DHiEKWi/Bp4EYgAoumPcvvE72dBZ4MeMp1NO+/zJUmtBg3jJD4yaMuyiN4bwg3EdGryvFwH2l3NY4TiCEOctrcs9NyUsylXPGqhLkl4+WH4IGPN7gR+YhY/8heoz2BX8+bCfy5HyAGO3oiCHe+b0Ds4pzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773684432; c=relaxed/simple;
	bh=7unitKYn8keomRHY4yq8+3PpiN6rsAq0TWo2S3hWj5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oC2Al33Ck80XnHrKKwPEpRuHCIUQWuvWuVgk0g8dnn08IOmxs/RUBu1dW4rmSteBHVKrd5VjPclFOFY4b365T3IaIvn1TKN0NIcJ3g8W3ydwZr6rcYW+aiPUkHLVLLFenV6zLRRLA0OyFqwjglqOaPUwTj6pxgWW0InvaEWUOqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHPubJmj; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a1330ac6c3so5193702e87.1
        for <linux-integrity@vger.kernel.org>; Mon, 16 Mar 2026 11:07:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773684426; cv=none;
        d=google.com; s=arc-20240605;
        b=jpaDw9MHxzIq1sTWRnm6jL7UejmoTiDYbFww8YlSNCHIy26++3mjIjXp9vQ0QW+JHl
         +oG5uIckC0cMs/UWPsIRVhfK+8KFqpZ8Ke9cjigeXr7Fxzs3rzwWxj92voQwA0OwOGcC
         xFVDnglyqkJPtMAs23DlhlBYokBWetl1A3jrEhLeuTHmbKIBXjjRRZMoB6pLp+19ZXIH
         0eZtUKPupT9ZjC+dzpHj8+6AXmRGybZdJKfioIfEpg9u8tgw3GEn0VadEqtfJol2RAZJ
         z0+X03ID6NvN4qIwjEYbwsUCPyWnvFx9x0JinhYhSj9IVevLgAFE9O2IUoHqyrmWRBhX
         T4Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fdAyIT2i4xeBkYzcRUZlVlUOW2WeACg70IfzXtqvGxA=;
        fh=DKMHVjmTJ8hkSV7WLzpqkDqo4EfEHxR6gZImKV4bUnk=;
        b=FMvOk7eHYkbzUJSl3x0iS7g/2e6UwcvvBOQND/iFrhWmGny8e/OfenSk0v+u10gYzQ
         WLE3mp4bvTVI2z/DIjxNdJVdgdSAH/5n+E027LVU0+PUI2EPDL19Sf4HQ5++KmWM2LAp
         Oa6dj+OfjIoOV8LFXG9oUDKmQ3PQ81RLtFQY5vYz4BYc0pa56QRFrE+LOxX9Q2T1LQyU
         mQRswm/NrAl7+9Fhf8X2V6U+SGXtPGTyWQzXo//Z7zDqBKS9QAxBgrXHS2JKQysb40ga
         6IMAATYdFmXimBGoxkFZx19X6w58HzJpsKtXzFiwXiYU7AiYCr0hjltfjXd8jfdU4kVs
         DMHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773684426; x=1774289226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdAyIT2i4xeBkYzcRUZlVlUOW2WeACg70IfzXtqvGxA=;
        b=dHPubJmjztMSd6n9WUVmgrc8yqkiRIKa7azepgic6RZxUqACoeiPF0UzdpNts5RD4i
         aoIF1SxlnH7KR9/nnpqyKanUsbqj9P/kryGwk8au6O89MnsmJVd/zQyLyiCBUHeFXkuI
         2CROLm9gxI6xloX2N2zNjbRdxWqUwBRq/KDlBIfch5mxUd4kUby5N6LWnUAaqgLe2zWs
         4b1UWh44zZ+VgL0Rtj/zXEHVwBd9USGJhTkufAK4S5wC4kTwhT0NUKz1U9ltk0c/T8vT
         O8TYEpJcgFC/E110kmvfJ48FuAh7+8bE4FKhYaj3fLDwl+pgKz0n4ITC4XRi8zd8mWbZ
         XCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773684426; x=1774289226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fdAyIT2i4xeBkYzcRUZlVlUOW2WeACg70IfzXtqvGxA=;
        b=c3zKKQ2VoDLEiWfAJLD5czMilwRdhc+EsrSxlJi1bKeFy9ei0RYwKGXmC44z7SO4MA
         fGoBKtIiMyC9KFDJdTQIK5x8vbNCJFW+FH/eIyAzhZ65P/sUtBipPJZ0nATsAC7qnMPv
         WP7RTs5Xthgfj6RS1OD2ivIrY4uHz1idWd6bD8+qJlAEuiZgbJbyFnbeuKqbJMWs9NNU
         0ep+TWuIs5kKa7ZdvULuB0bWDWFg8djZgzkBtZx0c3IvcqmCEyb552LJn3OoUCiyoC8e
         NnRwSENgAJgFpDsMCCPqUUPV/R5NbqGqomJ7zsXkzBjCSuoavkml5OpM5sQE3Qz1Sa2q
         S4gQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbWk59GjVuMEf09LUfO7k7nT9XBSXC5aGdlxpx7IM9pxV95TNf0xK1ySaPV/nHNcPh0hfAVDD4+KKK09iQHJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqCvx8DZCojmm/XJCO5rp5Xl0DRRodl0qX5gr2BNTgZLWuYMzo
	04snAzfXIU5xdfkKi4MO7eIuN2wCibdKXySs/K8f6lBIeKQCAdRKwxL/OdDv8pCbDvDKrn+Jkkm
	UnBkE58hhr1cI6rlONF145uTAhfI88cQ=
X-Gm-Gg: ATEYQzzVhQYNgJxlfUbGFyjsstau27C2nbngDQH2kzjFWfuwqi8TtAkm7wA53zYocOw
	tq9drKkYefvtveCSXocBgJJBm5cXLacZPmPB2tYubGdeYuAn3qTiSgaSXl+DSowijUJMRIZmpZa
	39qgKYUprzCiJhQ+Rl8ru+jEbDHRiPQl3+X1D95svDbHjBUWykCS0h+RIrdoEJ/MkphDo0kJUdV
	3ftUkVoMtT0p0pMHSCbKvPgyCKOUG8Cv3LhIZH1r9mv7fm1thmQsI4Y1KfSqIJDMqAWZeELllYh
	qXoS1ZHTAaDBZe8VGR0=
X-Received: by 2002:a05:6512:23ca:b0:5a1:3b78:17ed with SMTP id
 2adb3069b0e04-5a162b16e63mr3445752e87.40.1773684425700; Mon, 16 Mar 2026
 11:07:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313-iino-u64-v2-0-f9abda2464d5@kernel.org>
 <20260313-iino-u64-v2-1-f9abda2464d5@kernel.org> <20260314124748.1ccdf93b@pumpkin>
 <361258925536e2280ce62c5e49531af5c42aa491.camel@kernel.org>
In-Reply-To: <361258925536e2280ce62c5e49531af5c42aa491.camel@kernel.org>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Tue, 17 Mar 2026 03:06:49 +0900
X-Gm-Features: AaiRm51-JNtIyZb3PA-K-WobeTklyHQjodaAw0PHxkAwRGut69J0x6uW-2Hk1RI
Message-ID: <CAKFNMomRoq+rxF2HzzTpWhju+GCm3p3fjhm7e9mmvZKdsJHwZA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] nilfs2: fix 64-bit division operations in nilfs_bmap_find_target_in_group()
To: David Laight <david.laight.linux@gmail.com>, Jeff Layton <jlayton@kernel.org>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>, Christian Brauner <brauner@kernel.org>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-nilfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8997-lists,linux-integrity=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konishiryusuke@gmail.com,linux-integrity@vger.kernel.org];
	FREEMAIL_CC(0.00)[dubeyko.com,kernel.org,linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org,intel.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,mail.gmail.com:mid,dubeyko.com:email]
X-Rspamd-Queue-Id: E936229ED4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 9:59=E2=80=AFPM Jeff Layton wrote:
>
> On Sat, 2026-03-14 at 12:47 +0000, David Laight wrote:
> > On Fri, 13 Mar 2026 14:45:20 -0400
> > Jeff Layton <jlayton@kernel.org> wrote:
> >
> > > With the change to make inode->i_ino a u64, the build started failing=
 on
> > > 32-bit ARM with:
> > >
> > >     ERROR: modpost: "__aeabi_uldivmod" [fs/nilfs2/nilfs2.ko] undefine=
d!
> > >
> > > Fix this by using the 64-bit division interfaces in
> > > nilfs_bmap_find_target_in_group().
> > >
> > > Fixes: 998a59d371c2 ("treewide: fix missed i_ino format specifier con=
versions")
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202603100602.KPxiClIO-l=
kp@intel.com/
> > > Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
> > > Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/nilfs2/bmap.c | 9 ++++++---
> > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/fs/nilfs2/bmap.c b/fs/nilfs2/bmap.c
> > > index 824f2bd91c167965ec3a660202b6e6c5f1fe007e..abcf5252578ad24f694bf=
ccf525893674bfcb4bc 100644
> > > --- a/fs/nilfs2/bmap.c
> > > +++ b/fs/nilfs2/bmap.c
> > > @@ -455,11 +455,14 @@ __u64 nilfs_bmap_find_target_in_group(const str=
uct nilfs_bmap *bmap)
> > >  {
> > >     struct inode *dat =3D nilfs_bmap_get_dat(bmap);
> > >     unsigned long entries_per_group =3D nilfs_palloc_entries_per_grou=
p(dat);
> > > -   unsigned long group =3D bmap->b_inode->i_ino / entries_per_group;
> >
> > Are you sure entries_per_group can be more than 32 bits?
> > It looks like something that will be the same size on 32 and 64bit.
> >
>
> I'm not sure of anything here. I'm just want to get this to compile on
> all arches. FWIW, I'm not looking to optimize anything in this patch.
>
> > > +   unsigned long group;
> > > +   u32 index;
> > > +
> > > +   group =3D div_u64(bmap->b_inode->i_ino, entries_per_group);
> >
> > You don't need the full 64 by 64 divide.
> > IIRC there are both div_u64_u32() and div_u64_ulong().

Isn't the type of divisor in div_u64() u32?
Since entries_per_group cannot exceed 32 bits according to the current
specification, I think using div_u64() is fine.

> >
> > > +   div_u64_rem(bmap->b_inode->i_ino, NILFS_BMAP_GROUP_DIV, &index);
> >
> > NILFD_BMAP_GROUP_DIV is 8 (and probably has to be a power of 2).
> > So:
> >       index =3D bmap->b_inode->i_ino & (NILFS_BMAP_GROUP_DIV - 1);
> > is the same and likely much faster to calculate.
> > (The compiler will have done that optimisation before.)
> >
> >
>
> That all sounds reasonable to me. At this point though, it would be
> better if the NILFS2 folks stepped in with how they'd prefer this be
> done.

Yes, indeed.  It seems that the application of optimizations will
change, so this proposed correction is better.

Since NILFS_BMAP_GROUP_DIV is a fixed constant and cannot be anything
other than a power of 2, could you please adopt this proposed
correction with the following comment?

#define NILFS_BMAP_GROUP_DIV    8  /* must be a power of 2 */

Thanks,
Ryusuke Konishi

>
> >
> > >
> > >     return group * entries_per_group +
> > > -           (bmap->b_inode->i_ino % NILFS_BMAP_GROUP_DIV) *
> > > -           (entries_per_group / NILFS_BMAP_GROUP_DIV);
> > > +          index * (entries_per_group / NILFS_BMAP_GROUP_DIV);
> > >  }
> > >
> > >  static struct lock_class_key nilfs_bmap_dat_lock_key;
> > >
>
> --
> Jeff Layton <jlayton@kernel.org>

