Return-Path: <linux-integrity+bounces-1324-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF9F85DB0A
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Feb 2024 14:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B91C11F21086
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Feb 2024 13:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E6A78B50;
	Wed, 21 Feb 2024 13:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9iSCpwA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9516EB77
	for <linux-integrity@vger.kernel.org>; Wed, 21 Feb 2024 13:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708522564; cv=none; b=Okg4hjF4Nm2pyZV6zDOTjgJQDnP2EJfxweEDOFjQ6tPPPz+cJVCaCAlPV3ivFuUCbZze92jgzUJ3aFGBO7SmeKsk4WyT0bu66n+Wi2oieYZCZrZfVSiLFDqjkdETGF8xy7Fflmp/nqn0+VoMs2wPjON9WdL5ZNiK//6l5MdZHDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708522564; c=relaxed/simple;
	bh=JC0Te2NOoXzfQLxyBDygIaV3nbt4IjIkerDDATB7eOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fnbk9XdAV0p7GB4zSfDL9nn7eP2BfJLdpFp3gt5XHgJYuNBAjcGUPQ0goZCFQR/UQuY18Zna/rE7vzf0AU5iLeMuT6nqzmOH92DlYFtTE2nGHA6yntzmsyQjOYrb9viV4DVe+Q2/K3fJT1nNN8H8PO3IDZXjNIbnny6KLmjYTk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9iSCpwA; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6087192b092so6054357b3.0
        for <linux-integrity@vger.kernel.org>; Wed, 21 Feb 2024 05:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708522560; x=1709127360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOYJlaPkAPNaxahsCsPAOBrhQoBselR6nPXPCA4vlBQ=;
        b=L9iSCpwAQMsIWLolzEhdRBwfxUWsWQrN5AS3tdCqM1IfJ0D+eEYWckZb1xdyoMnVxp
         lb6qSejfHwCE0liHSY9Sai+tIhz/qzd+v5l1WOPK2my97MxgNmmBi5EFzm2no7+yXMV4
         ssXrn4pr+IL0QTT9BYYAwqOOsKMOcVxt6tJE4oIWxpOFr+3nFNer+4sqICHDYc8xfZs8
         OPeT9nL7caOYEGaTZm++WgpX2ukRFLXPYuhlMKGuPP9T/bvjST/SwE+vnkfY17/auubX
         dtdpJ9oIW8aLX2eumB/UCrpAJO4Igf9oae2VIhwF6zCCoxHNmDvBFkxQzCZtgq8Cm4sI
         4lhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708522560; x=1709127360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qOYJlaPkAPNaxahsCsPAOBrhQoBselR6nPXPCA4vlBQ=;
        b=UqHco3DrCQqY1/MSiRYImZlI/S7CdYqGCTF7WF2Dd5bzYvk+PAjD6zEZ/W7PG+8O0Y
         IU05ag7ARBrCUNzuHluyjVUmnW7Z2KCeipGfu6F4UopxQ2z7Xv3lm0qN9dbMDwNPIq42
         SobxOu5FXF4mcBtsTj3UfLFAcAOCIpIwTf2UUorE8SF7c8xvHWCKz/QCUVbTQI3KIlBg
         hgn+tNXMdfffF527O69Gy+UbaDDblSucVTGPN13c6UPnZc7w8mYuDN8GpSo6hcKvyNLY
         f9W7DfyZ8q4Y5XnUX/hcdmLvqYcd1zC3RabKC7dwsoiN7hndwl0GRaWlZjBp+Hs2XmoN
         W1gw==
X-Gm-Message-State: AOJu0YxumGQgGFNsr9RhXjHggY5/eZ1TNcz0rt2Y4C200cFf4PGN6glh
	rnav6JykMVEajvYPfOiMv6pf8y/p0GpjLbLBpcyF1OxjLvLW4tvMI4eMoAdR2VuR8C3a2pXPvWZ
	hQ9zQFh9q4u0/DZ6rXuq+32v8KlTtiP9mO88KwHkeIjw=
X-Google-Smtp-Source: AGHT+IEzr4AAXE+S9C0m4LykfSH2qyms+1NiveBGYRzOwDOROgh5Z0A70w+4MeSj1lL8SuVKEZIzDgARiPk3NDRLTKI=
X-Received: by 2002:a81:4cd2:0:b0:602:ca0c:fea3 with SMTP id
 z201-20020a814cd2000000b00602ca0cfea3mr16315007ywa.10.1708522560042; Wed, 21
 Feb 2024 05:36:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9205ed32da8814d8c4d9bde5a03d92c7588f1d9a.1708503094.git.dmitry.kasatkin@gmail.com>
 <ZdWx4CyUrnsMlzwA@srcf.ucam.org>
In-Reply-To: <ZdWx4CyUrnsMlzwA@srcf.ucam.org>
From: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Wed, 21 Feb 2024 15:35:48 +0200
Message-ID: <CACE9dm9dCoukm1_JzC9CDyqZP_pv-fb3hxDHgwRpLH55JJWN8A@mail.gmail.com>
Subject: Re: [ima-evm-utils: PATCH v1 1/1] Change license to LGPL-2.0-or-later
 and GPL-2.0-or-later
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-integrity@vger.kernel.org, a.mardegan@omp.ru, git@andred.net, 
	dbaryshkov@gmail.com, ebiggers@google.com, sorenson@redhat.com, 
	gcwilson@linux.ibm.com, James.Bottomley@hansenpartnership.com, 
	kgoldman@us.ibm.com, zohar@linux.ibm.com, patrick.ohly@intel.com, 
	patrick@puiterwijk.org, petr.vorel@gmail.com, roberto.sassu@huawei.com, 
	stefanb@linux.ibm.com, stephen.smalley.work@gmail.com, 
	tianjia.zhang@linux.alibaba.com, vt@altlinux.org, vgoyal@redhat.com, 
	z.jasinski@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 10:18=E2=80=AFAM Matthew Garrett <mjg59@srcf.ucam.o=
rg> wrote:
>
> On Wed, Feb 21, 2024 at 10:11:34AM +0200, Dmitry Kasatkin wrote:
> > Currently libimaevm provided by this project is used by the tool evmctl=
,
> > which is also provided by this project.
> >
> > An issue was reported about using libimaevm with other software. Its
> > GPL2-only license makes it incompatible to use with other licenses, in
> > particular GPL3-only.
> >
> > To address this issue, change the project license to GPL-2.0-or-later
> > and libimaevm to LGPL 2.0 or later.
>
> I'm completely supportive of this, but do you need explicit permission
> from every copyright holder? I don't think I have any code in the
> library, but if I did it probably technically belongs to a former
> employer and I'd need to figure out who's still employed in the relevant
> office to get them to agree.

git whatchanged  --author mjg59@google.com

It gives the tool only: evmctl.c

I am not sure actually if this requires permission from every copyright hol=
der.
We thought of CC to everyone in the git log.

-Dmitry

