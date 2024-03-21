Return-Path: <linux-integrity+bounces-1823-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8110C881AC3
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Mar 2024 02:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BE6C281CE1
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Mar 2024 01:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3255110E9;
	Thu, 21 Mar 2024 01:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ap+7oJDE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18841877
	for <linux-integrity@vger.kernel.org>; Thu, 21 Mar 2024 01:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710985905; cv=none; b=gvBMuRHOT6pZjr96lTbHYAQLoDZCkm/z+XltTI7gft1ZMb3KqoqJ3A5O4SaCEQtzH5Fm0sNXE3lnC1SJyB42cuDlZeZF001ROsGNSVLKh8FJqCHfNxvWywA4dub38/EQP93aT5eN4XxSSRji6+vObse0d+D9+TVS+T22LDG+ffg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710985905; c=relaxed/simple;
	bh=N18TyZk+5FN97FhpqxU2P8gGI4l0oR2+vuUn8jj7rOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b1bxFBUH/acfQV5kDm2xKTbXadISIR8zOKGc0/QBR3ZsKimgmrQTm9vbjCWUtufL/PcgdfUXEaEDnBWLHuxhQ69zzdlv1hhfLOLHsICkIvbrAknEZe4w8AMIn/d2BTPgKYS5g4LeuTWJWbdKnjfxlDK/bWxbQvAQxZtmOFjJhWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ap+7oJDE; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a46ba938de0so59803366b.3
        for <linux-integrity@vger.kernel.org>; Wed, 20 Mar 2024 18:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710985901; x=1711590701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKvIzRuyqOk6U1xGcaoZ6LCx0BJNduwsimmCxwGiZkk=;
        b=Ap+7oJDECrDKv6EiVCunPMQUGCJQOuGz6I8IQL4t44VfBZmo0SSPGhaGHB4/HzvIY9
         zf8sm7AbcnjQYgU4fE9LsuZf1fX6m303ooMhM4bnR1XTKKwDfpcC7vUa/xtjTaP1f0Tr
         KRgxA9dTjZFoWlJrkcus3CXIuY2ooMLswHzrW6TIklnxurpCn9PJaCTo+LK1rGkqKeoM
         gsy5k0j/erAqdbIxIZS81lFFk44Ul7gAVcU6S7BCsZoQg73yPqo5A84YEuGrSmY7V+A5
         jhh7RBy0b3w7lS9cK/JTXZgoWWx8tDVqRonYPAdvVDqURd0NsYPl6qouEWR60/bx0h/4
         Qs3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710985901; x=1711590701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKvIzRuyqOk6U1xGcaoZ6LCx0BJNduwsimmCxwGiZkk=;
        b=YVDbzuiQJVMw+qceUPlM41G2kL49jPmCCKWUPEKj8InN6vpDBVZEDvkr73v7LF30Bv
         1UTWKRToUrfKuQ7kDfm0L/Se6mPqIXO7lF+wDFGvs02ysl3texGmErUiJE+F4KSzCKnL
         lkUHs3BKJvL1uFsWtypQdtigRnsxAkfooQFArcSQFFOZcrTCyI2BEodt/btfXdP1ntI9
         iOmtOj4o8RdMlgHzjcOfC7vKd0g5Ap6P3Mr3iAJ7ZWku9uLFRWsfjwKmgxUXmx787hKh
         hdIFnO43ZYbI245Sf5T62CsXvM5T/fb5o5Wbi+U/O8rEQY41gZJeRVPeGlguHPyLig0h
         /GXw==
X-Gm-Message-State: AOJu0YxNZBPf0OQyyHqGPL2OywOODhHx/kit7142XkQ2OU4fVyO7E+z4
	Q5qgioLLTCsTvnIgxH005QxO99zp397XvT3eLVKE539+5iy4U11Za7VL5SiWquYUoclDrzV+W9I
	LJXfbgy5yUVpbxXX/fQCxPcOrZWcsJd/G
X-Google-Smtp-Source: AGHT+IEaxDbjzgcipzp7ZGa2wGbMnAqp/8iwQeSFIIqM3ZonDXit7R2d8pmAUtp2hNDxmEVUkh2Nh0sEhDQc+8uvsEc=
X-Received: by 2002:a17:906:b001:b0:a46:c449:c6c5 with SMTP id
 v1-20020a170906b00100b00a46c449c6c5mr6566451ejy.20.1710985900811; Wed, 20 Mar
 2024 18:51:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <103252ffff09c607e83c887cab2e0af5404d62ff.1710774200.git.dmitry.kasatkin@gmail.com>
In-Reply-To: <103252ffff09c607e83c887cab2e0af5404d62ff.1710774200.git.dmitry.kasatkin@gmail.com>
From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Date: Thu, 21 Mar 2024 03:51:29 +0200
Message-ID: <CALT56yM_i5PRyD7QBZ3enRUH9Mok7wmR+tki0GqVcFzmTA1_uA@mail.gmail.com>
Subject: Re: [ima-evm-utils: PATCH v2 1/1] Change license to LGPL-2.0-or-later
 and GPL-2.0-or-later
To: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: linux-integrity@vger.kernel.org, 
	Dmitry Kasatkin <dmitry.kasatkin@huawei.com>, Petr Vorel <pvorel@suse.cz>, 
	Mimi Zohar <zohar@linux.ibm.com>, Stefan Berger <stefanb@linux.ibm.com>, 
	Vitaly Chikunov <vt@altlinux.org>, Ken Goldman <kgold@linux.ibm.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Bruno Meneguele <bmeneg@redhat.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, George Wilson <gcwilson@linux.ibm.com>, 
	Tergel Myanganbayar <tergelmyanganbayar2024@u.northwestern.edu>, 
	=?UTF-8?Q?Andr=C3=A9_Draszik?= <git@andred.net>, 
	Frank Sorenson <sorenson@redhat.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 18 Mar 2024 at 17:08, Dmitry Kasatkin <dmitry.kasatkin@gmail.com> w=
rote:
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
> This patch includes all acks received so far.
>
> Signed-off-by: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> Acked-by: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
> Acked-by: Petr Vorel <pvorel@suse.cz>
> Acked-by: Mimi Zohar <zohar@linux.ibm.com>
> Acked-by: Stefan Berger <stefanb@linux.ibm.com>
> Acked-by: Vitaly Chikunov <vt@altlinux.org>
> Acked-by: Ken Goldman <kgold@linux.ibm.com>
> Acked-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Acked-by: Bruno Meneguele <bmeneg@redhat.com>
> Acked-by: Roberto Sassu <roberto.sassu@huawei.com>
> Acked-by: George Wilson <gcwilson@linux.ibm.com>
> Acked-by: Tergel Myanganbayar <tergelmyanganbayar2024@u.northwestern.edu>
> Acked-by: Andr=C3=A9 Draszik <git@andred.net>
> Acked-by: Frank Sorenson <sorenson@redhat.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Acked-by: Vivek Goyal <vgoyal@redhat.com>
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
>  delete mode 100644 COPYING
>  create mode 100644 LICENSES.txt

Acked-by: Dmitry Baryshkov <dbaryshkov@gmail.com>

--
With best wishes
Dmitry

