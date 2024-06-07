Return-Path: <linux-integrity+bounces-2848-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA209000B3
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jun 2024 12:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1CA31F254D3
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jun 2024 10:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25FF1C696;
	Fri,  7 Jun 2024 10:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5d7MWhE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A250746E
	for <linux-integrity@vger.kernel.org>; Fri,  7 Jun 2024 10:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717755774; cv=none; b=i+3pTPiL1zbgTNmFKYXaJB4Aq/623iy2o0LjJNl5vto56ZHjB+dD9lZ8ZfG8O9gR2HSwyVnYwY1zITUf1ORUfBSK0QTZGUIiBoXFWrnm3hFr90HvuGsJnSFnLOLeJOsprCQSwYNEokU6gnovMTFL6DLu1e6ykA9bW6nfAbL8d5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717755774; c=relaxed/simple;
	bh=nXz5EYuO2loFBrDPkymBXNFRs0atL4WhmYpYb74DJgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c95lY5pdvsDjPexjQkzQAgyETNIA3seSmo2uvolgWBtZ0yMWJbC7u+J7QcjPoKyIKleIw4Q/ZlnxNv2Tg0AD4l1dYnzqABtdeALMCplAaewIdfgPzSXIZrCDLSVCKWtPgPtZNHZmoONMHFiqY3lRL8XQ7I1uP9L5Wi97O1Noecc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5d7MWhE; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7025f4f4572so2312856b3a.1
        for <linux-integrity@vger.kernel.org>; Fri, 07 Jun 2024 03:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717755771; x=1718360571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8hEpBvVjtNfcbiEWd/gwxvmPyixaEXOK9U5WUUSHco=;
        b=N5d7MWhE5D1r86S3TxvHZQPlAwXhFj4iGKOGQt6rePMmdiPaAocu692IFcuTmViRvh
         IQ8UbmGXF5uKHstUrtXyATF3lcWPiml485Zh3inv5PxMnkuOzKn40kvbwAfUN+zZPBf3
         yIYcQRSu81sBjXv6oH9vmZXGiUCEs8q35VOosNiPmHypQK6XoacERo+cGp3Errxk7H/L
         GdF5RM1O0kguX4zNVixb3D29K+qAT1orySZlo2D+nejI+M1KflShjwOrQs1nEvrXqo/c
         F2L/iDvF5Pk9vizObj0I/7LmjbLgK+Z4xRMd9JgGcgbBJ+tJwQ4LOYW44g7vX8R3xbL+
         rCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717755771; x=1718360571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8hEpBvVjtNfcbiEWd/gwxvmPyixaEXOK9U5WUUSHco=;
        b=c3VZ8v03ID1qtLdVFkfxOqBIxNz0ZaIiwI8XEV26aF8mu+NpGZSadNHRh6Evhts1i3
         pQoyG7rRvxZMERj7mulbsXXV+MK0diUgXr/mhQNF+HnUB3nlHy8H8xuo22EFwQOz7aob
         jz6zr2cN5OVC1C6ECwc3bWtNaIwGFxncbJ2baTFKuWZ61jVeBcWlzYL+DtPjemVkVUQb
         Hw+NSW2l4gBKEvoPvB6OduIyYwGwBKAJR474g+yz6bpuygF/jM8JQvZY70OSMePrII/v
         BDlsXfjUrUxwffXBGzKu0+7sQGmipZWSrVM3fxcWrG20od4Jc61zWEswMrUjH9XOZwzg
         EenA==
X-Gm-Message-State: AOJu0YySQRR+47K9CCvGXzmeBcNAJsIXnXEG1vpgQ8CimTE4uN5nxr1T
	RaxXmO5fbf+0PoHtNcDn99tOYHo4Xq/JcYuaMDNaWUSeplg7DQxZGuKHK/93Vobx3ayOure7SgI
	s7HhqvY9t40GRMcdtxWqAVqFWKPk=
X-Google-Smtp-Source: AGHT+IGBCQstEbNPr72rld48pO1SzkpwPr6O8h08S0skOo4HPex77G8jWE5cKrxr9xhk7iPhzlkoc+91fM8TpsdggGI=
X-Received: by 2002:a17:90a:fa11:b0:2bd:47fe:6dec with SMTP id
 98e67ed59e1d1-2c29996c181mr7317734a91.5.1717755771319; Fri, 07 Jun 2024
 03:22:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <103252ffff09c607e83c887cab2e0af5404d62ff.1710774200.git.dmitry.kasatkin@gmail.com>
 <ZhlOjunocFKwYENP@black.fi.intel.com> <ZjTNEbrDZvLxzV5h@black.fi.intel.com>
In-Reply-To: <ZjTNEbrDZvLxzV5h@black.fi.intel.com>
From: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Fri, 7 Jun 2024 13:22:39 +0300
Message-ID: <CACE9dm9p0nwsKJxQE28ctv3r+b4Eqm_9iP+QNK+MBZGfxi23JQ@mail.gmail.com>
Subject: Re: [ima-evm-utils: PATCH v2 1/1] Change license to LGPL-2.0-or-later
 and GPL-2.0-or-later
To: "Svahn, Kai" <kai.svahn@linux.intel.com>
Cc: linux-integrity@vger.kernel.org, 
	Dmitry Kasatkin <dmitry.kasatkin@huawei.com>, Petr Vorel <pvorel@suse.cz>, 
	Mimi Zohar <zohar@linux.ibm.com>, Stefan Berger <stefanb@linux.ibm.com>, 
	Vitaly Chikunov <vt@altlinux.org>, Ken Goldman <kgold@linux.ibm.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Bruno Meneguele <bmeneg@redhat.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, George Wilson <gcwilson@linux.ibm.com>, 
	Tergel Myanganbayar <tergelmyanganbayar2024@u.northwestern.edu>, "Andr?? Draszik" <git@andred.net>, 
	Frank Sorenson <sorenson@redhat.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 2:40=E2=80=AFPM Svahn, Kai <kai.svahn@linux.intel.co=
m> wrote:
>
> Hi,
>
> On Fri, Apr 12, 2024 at 06:09:02PM +0300, Svahn, Kai wrote:
> > Hi,
> >
> > On Mon, Mar 18, 2024 at 05:07:24PM +0200, Dmitry Kasatkin wrote:
> > > Currently libimaevm provided by this project is used by the tool evmc=
tl,
> > > which is also provided by this project.
> > >
> > > An issue was reported about using libimaevm with other software. Its
> > > GPL2-only license makes it incompatible to use with other licenses, i=
n
> > > particular GPL3-only.
> > >
> > > To address this issue, change the project license to GPL-2.0-or-later
> > > and libimaevm to LGPL 2.0 or later.
> > >
> > > This patch includes all acks received so far.
> > >
> > > Signed-off-by: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> > > Acked-by: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
> > > Acked-by: Petr Vorel <pvorel@suse.cz>
> > > Acked-by: Mimi Zohar <zohar@linux.ibm.com>
> > > Acked-by: Stefan Berger <stefanb@linux.ibm.com>
> > > Acked-by: Vitaly Chikunov <vt@altlinux.org>
> > > Acked-by: Ken Goldman <kgold@linux.ibm.com>
> > > Acked-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> > > Acked-by: Bruno Meneguele <bmeneg@redhat.com>
> > > Acked-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > Acked-by: George Wilson <gcwilson@linux.ibm.com>
> > > Acked-by: Tergel Myanganbayar <tergelmyanganbayar2024@u.northwestern.=
edu>
> > > Acked-by: Andr?? Draszik <git@andred.net>
> > > Acked-by: Frank Sorenson <sorenson@redhat.com>
> > > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > Acked-by: Vivek Goyal <vgoyal@redhat.com>
> > > Acked-by: Eric Biggers <ebiggers@google.com>
> > > Acked-by: Alberto Mardegan <a.mardegan@omp.ru>
> > > Acked-by: Eric Biggers <ebiggers@google.com> # all Google contributio=
ns
> > > Acked-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
> > > Acked-by: Patrick Uiterwijk <patrick@puiterwijk.org>
> > > Acked-by: Mimi Zohar <zohar@linux.ibm.com>  # all IBM contributions
> > > Acked-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> > > ---
> >
> > Acked-by: Kai Svahn <kai.svahn@linux.intel.com>
>
> Acked-by: Kai Svahn <kai.svahn@linux.intel.com> # all Intel contributions
>
> Cheers,
> Kai


Hello,

I finally got consent from Samsung Corporation...

Acked-by: yh00.jung@samsung.com # all Samsung contributions
Acked-by: dmitry.kasatkin@gmail.com # all Samsung contributions with
consent from Samsung corporation

I will update patchset with all Acks..

-Dmitry

