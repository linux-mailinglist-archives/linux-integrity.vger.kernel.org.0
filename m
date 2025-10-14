Return-Path: <linux-integrity+bounces-7431-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 80675BDA884
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Oct 2025 17:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D14624FB0E1
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Oct 2025 15:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45048302742;
	Tue, 14 Oct 2025 15:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qB6KQbPI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EB026F45A
	for <linux-integrity@vger.kernel.org>; Tue, 14 Oct 2025 15:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760457400; cv=none; b=EsWpk0DiOY4olPedJfHJzXd8V37TyjkZHS/jdmvRSIfZAHr/9YeQ20yndNDu02JugIwOSaMyLyNQkgnI35AX1ipNrh94Twj/KQ+mnWczkrau/H3o50BnnbXs5kpHfMbW6NEtOUBZRYpHk6AzhBWBT6g8mzAizyEeeFVXP3xc7k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760457400; c=relaxed/simple;
	bh=nunGWOtz+XGGBYXEFYvnFbGnmcS3tFQEGkEK14z7P9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OjSPXmv0iZhhgjxXAv0vOTmiWLlCyaHk+Qpn+7FcqJze+TY0uCiOXjCAqKhHSL1jDDuJZ/jwJ8+TOqQBPrDIRLsz8hGzlBRJFKYCBtxZEXi72lLerlhG4wCIHERcud7P2Mkpzvj87dhMyYb85SOXVboW9wdUSOHAP//j5+SNfys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qB6KQbPI; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-634cc96ccaeso24441a12.1
        for <linux-integrity@vger.kernel.org>; Tue, 14 Oct 2025 08:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760457392; x=1761062192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQ71tNRhJ1C7d7gKrHFcOSRgM5Z5VD8Gv1fa0j4u7rs=;
        b=qB6KQbPIHvGZLs6U2VSTXvr2A926tAqRLUpaFKLASC2HwebsAV4tuyhPrsvm8OzuzZ
         gTWRT+VATi7dPOcqxtkW/eYMntzFcyYJXp4tDcBlcDBk+J9XCVcdfTFY11vOLHSiixlc
         rxH/4+UmX5XMuSTqGRH0YIRaKkYNT3XXyS65j7MQZCysTDKftSi/h7z73+GTNnd6k4h6
         n4hmEi+8sO1shfNPgoGKmJajsZ4ophXkNtXWG8AbB/KxFNTkLQUB/V69pPuZ4d4WgZSL
         QLM4uMxSL3TMUGrq4JB126V3Ek1TTgzktXm9tYXFLhEpKz2qovrCfj6hLAedBwdUO64K
         K23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760457392; x=1761062192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQ71tNRhJ1C7d7gKrHFcOSRgM5Z5VD8Gv1fa0j4u7rs=;
        b=HCLdn7NHG+QxmnBbNOmKZwvBZXHRrJCAGR9i4xs6ySf3tgWY1lo3YwvGjy20u2XJcv
         agakQCGcZdEjLZxr+RYN3WEbPQhgukLov1SxxPanKIZ30yS6DRgkNzRwLe9ijtw6eK98
         u7LH5EufpSMLWAhswJ9IU6XfXR1rAF+LbgDpcWWElXqmhSHPZvfKuX/gQ2DsC7s2XBn1
         MeYgEs7nVWR0t2St+cR2RTq3e18u4g8sy4+P0TYTxJ77BEP3HWdUCcFrEJq9gI0K4V47
         Uw3ZRn05IiBxv2DLLyh03Pqo8h3GMbBe+4j/RMT40tWQJwNZH1JLD2LkLcBn0IwcUbi4
         SU8A==
X-Forwarded-Encrypted: i=1; AJvYcCXHzZTOSMc+2S5FMoZLwtpQP23F+8cC2z2rf322elQJ+rw79NnKFHCPkJcJD7AqFcKwDpKbMJqzLyQykPjcrtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNnFgSeDscguu/dwjoKlmggavxZUC8Q966dFWqJt1E+R2E34gQ
	HiUcUZTDjNq39G98TBSavPwlpwT277Djah93PQj/WQN1xFGq2948qTzYWgMvxVfLQ0Wncps4mWA
	U6UQNB3/LjBceckdGTM0YRyv/k9hP7ngc6VmrINe8
X-Gm-Gg: ASbGncsrTrp/p7BFrTFIh9B6eBe/ODM2IqRLVpimpVQEEkcRnEkU3/2IAbToOg/Q6kB
	cL8UNaDk2a6GA4+7lK0CPmTEpgvR/ZcKk60pjQWQXsP64X5b8tzAbxOXUAoT5HKDl/yt7ppz+ee
	jJ7p5Z9k5Y11BQQLgb2ZpsBSSzB6R3B01ek1NsS0+5FbjbAMEbLD9Sp3kNRwgsxB6e6n5dzc/0X
	quc1rfViC8k52nIMAlLWDNlJoqN35vUygejBXs8X3ikmClKgqXGe+d0MjiulQ==
X-Google-Smtp-Source: AGHT+IGKIV2Bi31oYcHwKI2YSzrrIbKf4rj3xHwGkR3kvGZh9Hy2J8pJL9RK0nSsdzque/SVaFFeuGeMp1gKigXmOjY=
X-Received: by 2002:a05:6402:70d:b0:62f:c78f:d0d4 with SMTP id
 4fb4d7f45d1cf-639d52ea25amr605212a12.6.1760457392068; Tue, 14 Oct 2025
 08:56:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926-ima-audit-v1-0-64d75fdc8fdc@google.com> <ef7c07585e41c8afbb2b97df98fd47c9374b15cb.camel@linux.ibm.com>
In-Reply-To: <ef7c07585e41c8afbb2b97df98fd47c9374b15cb.camel@linux.ibm.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 14 Oct 2025 17:55:55 +0200
X-Gm-Features: AS18NWC0yNNk6h0sxtRsikFqG7Y_VQHcdMiPhHyUTg2KdS5Sjowz2_Kiu9CEWCo
Message-ID: <CAG48ez1hcvhoEt8b7wTX4kFq7DXS3HLF-9C8iGcTtVBW7V4b6w@mail.gmail.com>
Subject: Re: [PATCH 0/2] ima: add dont_audit and fs_subtype to policy language
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Frank Dinoff <fdinoff@google.com>, 
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

On Tue, Sep 30, 2025 at 12:23=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> w=
rote:
> On Fri, 2025-09-26 at 01:45 +0200, Jann Horn wrote:
> > This series adds a "dont_audit" action that cancels out following
> > "audit" actions (as we already have for other action types), and also
> > adds an "fs_subtype" that can be used to distinguish between FUSE
> > filesystems.
> >
> > With these two patches applied, as a toy example, you can use the
> > following policy:
> > ```
> > dont_audit fsname=3Dfuse fs_subtype=3Dsshfs
> > audit func=3DBPRM_CHECK fsname=3Dfuse
> > ```
> >
> > I have tested that with this policy, executing a binary from a
> > "fuse-zip" FUSE filesystem results in an audit log entry:
> > ```
> > type=3DINTEGRITY_RULE msg=3Daudit([...]): file=3D"/home/user/ima/zipmou=
nt/usr/bin/echo" hash=3D"sha256:1d82e8[...]
> > ```
> > while executing a binary from an "sshfs" FUSE filesystem does not
> > generate any audit log entries.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
>
>
> Thanks, Jann.  The patches look fine.

What's the next step here - are the patches going to land in the
next-integrity branch, so that they will go into 6.19?

