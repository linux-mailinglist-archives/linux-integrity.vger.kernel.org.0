Return-Path: <linux-integrity+bounces-7026-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33918B481BB
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Sep 2025 03:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAD5C17A610
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Sep 2025 01:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C606819A288;
	Mon,  8 Sep 2025 01:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Z/hhYEyk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5210D1922FD
	for <linux-integrity@vger.kernel.org>; Mon,  8 Sep 2025 01:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757293554; cv=none; b=RCozPG2gZ+3e+wmZxqebdh5FxQ3mGCgH4nE9C9VBHcxBwG+BrJUu4NJC4GcZpQWwsKk6p8wCDZ9Et8cpdhVSO0KhemxsitD3FjN9/SQu23gc45Yxzof9pBpSq26iQ0ciIWmCqaXHXHMwvSDu04hRJlWeI4Dtzsx0pSPFotgwBdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757293554; c=relaxed/simple;
	bh=Sd95bGVJ2LCjq37iOwuj1kTAjMK/OSkpeyNFM77tCGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3nXKmqlTY7lVTzxVKOIVo2jYiGgH3ziy0CU8zeV83uzB9T/zf2adkG974//vNaGDqdmuo1EbMRuPxBggi0THyjNpwX1Nfmh2ld9Qn4o2HSobXpWvuCgot0Px0kU/u2iRR+bhJeGfmdb0qOus0xCRXhla0Ft3r770tD0tQ3h5w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Z/hhYEyk; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7722f2f2aa4so4945809b3a.1
        for <linux-integrity@vger.kernel.org>; Sun, 07 Sep 2025 18:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757293552; x=1757898352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MA/mHb5FEXGBYyWzdg/cHL2BkU3EdtpScaeOnQVTYug=;
        b=Z/hhYEykrl7L3ideEihKwJUW3fSuA2qnOdXMYR7ow5/mUfPfXGiGqWUc62dmsR5HeR
         LPRyKUsp9ZQHX56DxGOhBfcKir4Frlj3Ql14g6NbXjHvTkxlg4URDoWp4GZL6jAqotI4
         3GBoX6uKvDsZVyU49GTLpFp/+MiVu8fjByx1aNuiBWIkOqPnJ2Nd3hg0wcLeu7Te6sIg
         gscha/zkw2toEm96w0EcyPFM4srYRjxn0Ldv9vkNOK2c3xSN0fMgC6Xv5P13wunfL/PJ
         dMkN5TineK7QE1xGU5cBEAhH18Ky+AYJvh79XzwCOnYjH3PYDRo/7cFCc5f868guOFii
         zacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757293552; x=1757898352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MA/mHb5FEXGBYyWzdg/cHL2BkU3EdtpScaeOnQVTYug=;
        b=iulE9+rcuFrWVjT0qJSr+tZZbRB+gUnXlwCMTHj/EG/OLyq+bC7374U21QK8fnBMKl
         FHtUH5uVcR9DvdB5rE5GDMPw00XdC48yjvBh8y+7bR5Sf2yn9GSSPufSYTgQeYAf+x+N
         lhNZvpUTudklUW3Gh3apD/b2CvZiVCffIIg2lG9qQJRm7qw0YKNwytvMV9ymr9U15cLj
         ZMN8kBQfU1UZnRgyjzZVJcz5AmiAIcYIU41LdE/DfzYYCd5CPwm2+FF9NBt4IhiomhVc
         GvbqG+MGU8A9+6GwanOPmziPTVUPSC/rDHZUp2XSVyimTi/NJ1VLTSFLIM+2PX0Lzwap
         N3Qw==
X-Forwarded-Encrypted: i=1; AJvYcCWH8Q3BxQ5fxvipHxqjd5WQEvfVgLOEY8nM9xjPuNV4LwkAi060K+V5ox3/sNTb+8gsYGb23wMbMWO4mF61qQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT9W0RxkOx+lI2Loyh3B/DOGj0GY+DXFJUNrUH7YGNKle+dSXx
	BYps7Z3+QG1RCHXQRQ3SCwXTuv0ScrNICWRwUXWfvcH4rxNtrZf4ES8VCcS1vOf8gS0GfEYNMkY
	gc+hEo9byWfGH619+Xfm7En3oadTP0TuEhROdA6zL
X-Gm-Gg: ASbGncsH1vc8uVrrHViQQRZ5oc1qbrRZvbrZgGUcOjtKxGXAv/17/ON8sme382HghqL
	K+XrdioISykFvZIZHJo6oZN+8WsBfhJc+FW73BAVwmzQe5br3esY7hkRUoAxsItTUTMF7DV6dOc
	KPMkdgcI6JUaaC0ib3jt8BD3fHfebF4532w9g3zbIDCTNge/+H4ySiXFus0qiG4BA3O71i1eKN9
	4VEGKI=
X-Google-Smtp-Source: AGHT+IG+aeOfJIJg7q6C1HPAGnnZmf8Jq1DbPyXZdBJyagmM1kTQfUSAlMxoQvlmZG+P0sAC54ZqoQ4RlJkaLRQcLG8=
X-Received: by 2002:a05:6a20:3d86:b0:24a:b9e:4a6c with SMTP id
 adf61e73a8af0-2534557cb5fmr9050598637.44.1757293552578; Sun, 07 Sep 2025
 18:05:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814225159.275901-36-paul@paul-moore.com> <20250814225159.275901-67-paul@paul-moore.com>
 <CAHC9VhS3KdVO9n-dgk1qFzTae0i+Oab8atMmt0CAsMEm1D4v5w@mail.gmail.com> <bd46c63ebb9eddfcdc8df92fe9f85473416ea8a0.camel@linux.ibm.com>
In-Reply-To: <bd46c63ebb9eddfcdc8df92fe9f85473416ea8a0.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 7 Sep 2025 21:05:41 -0400
X-Gm-Features: Ac12FXzlaCoP5e2lQTx9u2iYMRLRExgUQtlxACtm-Ptm7fDXbrkhCv7k2Om7sR0
Message-ID: <CAHC9VhTJnQ3EggEXwbW5D8xOnb+Z_02yz-Dgb7QiAoArhw1ETg@mail.gmail.com>
Subject: Re: [PATCH v3 31/34] ima,evm: move initcalls to the LSM framework
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 7, 2025 at 5:13=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wro=
te:
>
> On Fri, 2025-08-22 at 16:45 -0400, Paul Moore wrote:
> > On Thu, Aug 14, 2025 at 6:55=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > >
> > > This patch converts IMA and EVM to use the LSM frameworks's initcall
> > > mechanism.  There was a minor challenge in this conversion that wasn'=
t
> > > seen when converting the other LSMs brought about by the resource
> > > sharing between the two related, yes independent IMA and EVM LSMs.
> > > This was resolved by registering the same initcalls for each LSM and
> > > including code in each registered initcall to ensure it only executes
> > > once during each boot.
> > >
> > > It is worth mentioning that this patch does not touch any of the
> > > "platform certs" code that lives in the security/integrity/platform_c=
erts
> > > directory as the IMA/EVM maintainers have assured me that this code i=
s
> > > unrelated to IMA/EVM, despite the location, and will be moved to a mo=
re
> > > relevant subsystem in the future.
>
> The "unrelated to IMA/EVM" wording misses the point.  An exception was ma=
de to
> load the pre-boot keys onto the .platform keyring in order for IMA/EVM to=
 verify
> the kexec kernel image appended signature.  This exception was subsequent=
ly
> extended to verifying the pesigned kexec kernel image signature.  (Other
> subsystems are abusing the keys on the .platform keyring to verify other
> signatures.)
>
> Instead of saying "unrelated to IMA/EVM", how about saying something alon=
g the
> lines of "IMA has a dependency on the platform and machine keyrings, but =
this
> dependency isn't limited to IMA/EVM."
>
> Paul, this patch set doesn't apply to cleanly to Linus's tree.  What is t=
he base
> commit?

It would have been based on the lsm/dev branch since the LSM tree is
the target, however, given the scope of the patchset and the fact that
it has been several weeks since it was originally posted, I wouldn't
be surprised it if needs some fuzzing when applied on top of lsm/dev
too.

--=20
paul-moore.com

