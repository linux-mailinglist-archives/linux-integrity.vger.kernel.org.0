Return-Path: <linux-integrity+bounces-2408-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E738C5BD2
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 21:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 454F21C2170E
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 19:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC9C181324;
	Tue, 14 May 2024 19:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JF+Zbwi4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A677F18131D
	for <linux-integrity@vger.kernel.org>; Tue, 14 May 2024 19:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715716224; cv=none; b=nDp3tbYpwXbEbvKKVXIgheoHCXKoTeUsM3Hr4PI8rU0tM4L47qRFrQDwg3fsyhR6fnkijRnNeHP815gD+XProIrJRjdLx8xtYw4ark/0iOVOYqwoLMwj/avEIQm/o0mHnFR1N0V4gTcpeFNc/eSvFCkWKEshmxESE57Lq7NlL/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715716224; c=relaxed/simple;
	bh=xCGobSiEZZKVIGvtlb17VkXzrJav2cpynpYO5pxHsTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fs2czrxxGI0radmSkmESPLj67Hh75ERXhVQ7k38fb0cFG6SsiNcVM3ELCOmz2LrB1H+K2FjysqXKQdDwrNpvlOBKF3PBSi7aR5DfjRB1jNcHpW+7elPckJPQAqfilsHlzIlpdXe7RKzh+bOgHk3eAAxICVu1dETHb+DAQQd8V1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JF+Zbwi4; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-ddda842c399so5911755276.3
        for <linux-integrity@vger.kernel.org>; Tue, 14 May 2024 12:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1715716220; x=1716321020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkp4I1/EP34xCsXz894jXcfOHu9Xc+3+8P13l0GVrxE=;
        b=JF+Zbwi4A37UVjOELqyuSxI5XF16PnHoy/clBUi83jiG+YRodmecFW52qZKz4Kq726
         4PTOrHIBMXKsd7NPB6GCHO6oGJCvxjHHJaMw38WnlU+B/cm4WbJETzVMZ2TafdoTfo4X
         rBPSV09s7/igRv/0AE1D7RnilAUdFI2LXQQWFeHNyDVUgFRiRFPHAJLU+iEB4N2/widJ
         cASIqHwqPxifXEwwXws+q0QEDlDblFWXqGYAXJmXfXw3VXV1KCegxMxVhRx0XCksA/sB
         1VxkK02/WpwjROj2m5sVqBTGjVDYmmzXsDovMQ2t1pd4IrqPTv+jT8xruRy07h+w1pWB
         IsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715716220; x=1716321020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkp4I1/EP34xCsXz894jXcfOHu9Xc+3+8P13l0GVrxE=;
        b=CDgsQvrwLjqz7i2XwgyBy5GHjK8HPbesytCGW+NawaXUQFLTzZ/Ja36rtSa8o03a49
         aUVsm7qX8dmST0aJQu9NjUJM4ny21ALc3qc1lRgFbDuefovTd2eKRy+LkXMMJFN39m1l
         YU/VmyBSvyX8/SlYwSOiViHG5WnRH2dGyAOoY2qHGPvKPSuz2skcJYLa7glbiGwFV2Co
         lkmT91BfSlywptQiNgnR0Mr1msHwr0bD/ujQCRDJ6BdmVgWcSIoKmVXHL0PEkdz+Y/M6
         HjPtqqDw5iiY4VQbTGKd/ZUK8GQKfjPd/wRUdG4UIEtoX18d/Yl0NVCeBuFqHUqi5AgI
         rVhA==
X-Forwarded-Encrypted: i=1; AJvYcCWMvNhFkMzvVFEStSvJdtqjmJcGi5hr2W/xmSDFO9a1vQl8RyRbI4Ih3DdFSR5y6w8MAWzQlRcK/FSXyHWmC8ZGCmhMPr64C2WJL2zEUDca
X-Gm-Message-State: AOJu0YynOGTuhqIPkZpeCxKNGm2oQb3cOl2QRWQxVmlmZ+KOXu2c5S8Y
	0Aa5AVi8Y12GEq4qYv8Cb8GcTUHz5U5LGogrwSyRyU9f9/9U9ZIl5RH/4OBB/hCcIb/3VyO5ei1
	GtZ6lkjXAvMrkUrODn7Rbeew3oxvCbmsGMlud
X-Google-Smtp-Source: AGHT+IFWIy5UA2F/+z955H9aT1kkILcAstR0rQ1Z6k7ELYYSk3poMncJ+M812qPYw6M0u0TMB7AFkJo/BviRvM2KHkE=
X-Received: by 2002:a05:6902:218f:b0:dee:8da8:aeb7 with SMTP id
 3f1490d57ef6-dee8da8b092mr8719461276.25.1715716220678; Tue, 14 May 2024
 12:50:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1714775551-22384-1-git-send-email-wufan@linux.microsoft.com>
 <1714775551-22384-21-git-send-email-wufan@linux.microsoft.com>
 <ZjXsBjAFs-qp9xY4@archie.me> <ab7054cd-affd-47c3-bd98-2cf47d6a6376@linux.microsoft.com>
In-Reply-To: <ab7054cd-affd-47c3-bd98-2cf47d6a6376@linux.microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 14 May 2024 15:50:09 -0400
Message-ID: <CAHC9VhQewDL4cWXSiAgzvrHa8N5rd6TbhSCM3jRp29=Kmr3m-Q@mail.gmail.com>
Subject: Re: [PATCH v18 20/21] Documentation: add ipe documentation
To: Fan Wu <wufan@linux.microsoft.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, corbet@lwn.net, zohar@linux.ibm.com, 
	jmorris@namei.org, serge@hallyn.com, tytso@mit.edu, ebiggers@kernel.org, 
	axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org, eparis@redhat.com, 
	linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, fsverity@lists.linux.dev, 
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Deven Bowers <deven.desai@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 4, 2024 at 4:13=E2=80=AFPM Fan Wu <wufan@linux.microsoft.com> w=
rote:
> On 5/4/2024 1:04 AM, Bagas Sanjaya wrote:
> > On Fri, May 03, 2024 at 03:32:30PM -0700, Fan Wu wrote:
> >> +IPE does not mitigate threats arising from malicious but authorized
> >> +developers (with access to a signing certificate), or compromised
> >> +developer tools used by them (i.e. return-oriented programming attack=
s).
> >> +Additionally, IPE draws hard security boundary between userspace and
> >> +kernelspace. As a result, IPE does not provide any protections agains=
t a
> >> +kernel level exploit, and a kernel-level exploit can disable or tampe=
r
> >> +with IPE's protections.
> >
> > So how to mitigate kernel-level exploits then?
>
> One possible way is to use hypervisor to protect the kernel integrity.
> https://github.com/heki-linux is one project on this direction. Perhaps
> I should also add this link to the doc.

I wouldn't spend a lot of time on kernel exploits in the IPE
documentation as it is out of scope for IPE.  In face, I would say
just that in the last sentence in the paragraph above:

"As a result, kernel-level exploits are considered outside the scope
of IPE and mitigation is left to other mechanisms."

(or something similar)

--=20
paul-moore.com

