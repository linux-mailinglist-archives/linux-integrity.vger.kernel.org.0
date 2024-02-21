Return-Path: <linux-integrity+bounces-1325-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B6E85DB36
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Feb 2024 14:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CA9D1F23B2D
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Feb 2024 13:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9DA78B50;
	Wed, 21 Feb 2024 13:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBym71V+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E217779DAE
	for <linux-integrity@vger.kernel.org>; Wed, 21 Feb 2024 13:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708522693; cv=none; b=GVMI+/2L4CXFAJ2FtVycta/bS07v4hxKCSAXhPSth2mXIqliTSpzccs6LT1KQFeM2gFEOjrq9iRiMw8YZpgyz4HL0ZQLCfH+UrdxmXQEg1aQkx5HqDvDKoGrMj6dWL0IEPEMUajv1b6WyG/sKbAEjpUSZ6TEiX4xWZ+z9Dm+BY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708522693; c=relaxed/simple;
	bh=rYtL2kjWBhzP75EqGS9mIUFX6wEqbEWD1/etVaUPpD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZE00EmX6jINnqeqgZhNEK3xA6aaeRFghAjMU23p5chdeCr0uUz0vq4GQFCDCfqTLmXy9c38PPyh4+eDPDxwuDlshiJ+Pbdoh1R6GQkiQVex4ZgEv5Xo2UUzH55CXj3S+sS+bg+50JoX+ZijKdnOS7DLqHha+YHTdPxkgf0rBpps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBym71V+; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6002317a427so55203597b3.2
        for <linux-integrity@vger.kernel.org>; Wed, 21 Feb 2024 05:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708522691; x=1709127491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVHa8s5sq4yb+c4Z8tcpR0FmEovVWhY4b7wZGqFM+MU=;
        b=MBym71V+XDp8e2MhTzHJNpyCYlSzj8MLP/JY+Lh6EcuhwpkrdIZXvSYfVSbKgYuorw
         MbYSNA9FYUWQg5wWemEfCj70jjZyk9YrQ639mBUxWFbbjCTsZvhzTM4YtLK460LE4OwW
         CNKI42ACZkadBfIlnFzE1ZgEURPg/b0Hxi0CpbpduTDZxmymqgd5RyDze2ch0Z8o+iow
         346GjBI8hwRB1s3Cns5S3Cr9TgnzKTZMJJyvu8QTCshNpFBSP21gcOag+S5qV0b/8cJR
         TAonueC0bdkZBHv6dOWnhVNhisR2chURjgleGpsJ/ieteHLvGoQyX3eHwohx86w7Figa
         5lIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708522691; x=1709127491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tVHa8s5sq4yb+c4Z8tcpR0FmEovVWhY4b7wZGqFM+MU=;
        b=aD7BD5fQ3/2LNOaAqX1i6jyqedyLSgoGP5xKzcVKicVlFiG0gATm0LCTTk2A4Wccvv
         +lvc+eaSwrYb/W+C6qAOqNABnGPJXESkSlXYaXa3XdtDJYObn1K7gJVHvilZlJTZnHeu
         UFje+UZgVMxYmxSyU3MGP2jZNgEqjlg+FUQB5PfmSdatwVuKvDO79pNunpgbPZCNKeAc
         6lVr3gJuifNbX2nYK8/+KRQy0PSmTcSp1g/oASSC3bX1Sl7tp9lPJojNRr8MG1/2AmOh
         UYpiXc1gqlquB+hTsRjPtScthgsw24fVpFcnRpJxCCqjMZf2RbGItlS19+bUdYfh0uAr
         MyKw==
X-Gm-Message-State: AOJu0YwXBUeufBOYgSkBNIReWE25odiZOfJMMwRtixpdrCxItjlbVifT
	dIJyoHbqWqpxj2Fiz8boPtVh6o6PkRN3rGxxKthqFFaGp8bzd7RnRGk6pEuWqeG56Dr5kSbFlXN
	EymNbj3eCFMKzrS9rPfdORZ4P0X0=
X-Google-Smtp-Source: AGHT+IF0f0yJ9nzh8PH7TGZXgiBgj2FeIkVJAqzoynKEIeZfsqpoXR7WDRhcYb/Pd2O+gPhjwjewtnTknT4nSOEvwXI=
X-Received: by 2002:a0d:cb8d:0:b0:608:1cf8:bfc1 with SMTP id
 n135-20020a0dcb8d000000b006081cf8bfc1mr10287862ywd.41.1708522690765; Wed, 21
 Feb 2024 05:38:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9205ed32da8814d8c4d9bde5a03d92c7588f1d9a.1708503094.git.dmitry.kasatkin@gmail.com>
 <9205ed32da8814d8c4d9bde5a03d92c7588f1d9a.1708503094.git.dmitry.kasatkin@gmail.com>
In-Reply-To: <9205ed32da8814d8c4d9bde5a03d92c7588f1d9a.1708503094.git.dmitry.kasatkin@gmail.com>
From: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Wed, 21 Feb 2024 15:37:59 +0200
Message-ID: <CACE9dm9z1NdGJ4i1TZAcTbhoJ-O3qwxyAWKj0r8Two0mN2oM9w@mail.gmail.com>
Subject: Re: [ima-evm-utils: PATCH v1 1/1] Change license to LGPL-2.0-or-later
 and GPL-2.0-or-later
To: Petr Vorel <pvorel@suse.cz>
Cc: linux-integrity@vger.kernel.org, James.Bottomley@hansenpartnership.com, 
	a.mardegan@omp.ru, dbaryshkov@gmail.com, ebiggers@google.com, 
	gcwilson@linux.ibm.com, git@andred.net, kgoldman@us.ibm.com, 
	mjg59@srcf.ucam.org, patrick.ohly@intel.com, patrick@puiterwijk.org, 
	petr.vorel@gmail.com, roberto.sassu@huawei.com, sorenson@redhat.com, 
	stefanb@linux.ibm.com, stephen.smalley.work@gmail.com, 
	tianjia.zhang@linux.alibaba.com, vgoyal@redhat.com, vt@altlinux.org, 
	z.jasinski@samsung.com, zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 11:28=E2=80=AFAM Petr Vorel <pvorel@suse.cz> wrote:
>
> From: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
>
> Currently libimaevm provided by this project is used by the tool evmctl,
> which is also provided by this project.
>
> An issue was reported about using libimaevm with other software. Its
> GPL2-only license makes it incompatible to use with other licenses, in
> particular GPL3-only.
>
> To address this issue, change the project license to GPL-2.0-or-later
> and libimaevm to LGPL 2.0 or later.
>
> Signed-off-by: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> ---
>  COPYING                | 339 -----------------------------------------
>  LICENSES.txt           |  13 ++
>  src/evmctl.c           |  25 +--
>  src/hash_info.gen      |  10 +-
>  src/imaevm.h           |  25 +--
>  src/libimaevm.c        |  25 +--
>  src/pcr.h              |   2 +
>  src/pcr_ibmtss.c       |   2 +-
>  src/pcr_tss.c          |  25 +--
>  src/pcr_tsspcrread.c   |  25 +--
>  src/utils.c            |   2 +-
>  src/utils.h            |   2 +
>  tests/functions.sh     |  11 +-
>  tests/gen-keys.sh      |  11 +-
>  tests/ima_hash.test    |  11 +-
>  tests/sign_verify.test |  11 +-
>  tests/test_mmap.c      |   2 +-
>  17 files changed, 30 insertions(+), 511 deletions(-)
>
> Hi Dmitry,
>
> I fully agree with this, but all files I added SUSE copyright with my ema=
il
> weren't touched. These files actually have no license. Therefore I have n=
o idea
> if my ack make sense.
>
> Acked-by: Petr Vorel <pvorel@suse.cz>
>
> Kind regards,
> Petr
>
>  delete mode 100644 COPYING
>  create mode 100644 LICENSES.txt
> ...

We thought of CC to everyone in the git log.
Indeed in the file contributed by you it was only a copyright line
without any license.
I think in this case it is according to a COPYING license file.

Thanks

-Dmitry

