Return-Path: <linux-integrity+bounces-197-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3E57F48CE
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 15:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF9411C20A5F
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 14:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B825A4E1AA;
	Wed, 22 Nov 2023 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ng0gK+EC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8448618E
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 06:22:33 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-da077db5145so6259227276.0
        for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 06:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700662952; x=1701267752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4prMfUwibvSrz+SlOVCRM+XxGw8pCCbk8//pMWkdN5o=;
        b=Ng0gK+ECagWzuchmn/NAAvHkSgf1waCk5bUEG4/eUn9X5ebSJoYTlYG6aDoJSZOiJV
         JPLoA/RvLAbbgvz7wa2wsj4lXiw0ZVIKagNROvGuXhCW5gSONvo+87gQVrxOSsx01y5p
         5rqLOSy6jMHP9pnryu3IXomkuHcc70yIVsITHz6WRKh3wuHwYIaiuZzJha/tsbRI0Lu/
         HB9R991At1eWX4aUyG3mb3oDEDXPt726duSg1Y9krSQigYD8xn3fAVioIBJf6uLmzKRu
         AphLHHqe/rUAZ/zlbhCtCqSy3c3xo4Afx5INR/GcZhy4wEiBa77rFcpVMw2XExR6n5sA
         nNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700662952; x=1701267752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4prMfUwibvSrz+SlOVCRM+XxGw8pCCbk8//pMWkdN5o=;
        b=jfmtfDrU4NKNrC0Ni6dHoshUY9JIRKPTHGY/jMT294hHTHVntDzsuFVO7cmcudtTHi
         TMd0XdTOZPafuE4ftM0naPfJn1SbtEmnPmI8NGWGysxWCx0LJdmgbqIHzYiJJ6GdGX99
         PEYs66gDdtqXNrFs0U2B8JNANJnfA1Edb5gjdOajwsSz/ihK+gPK3QrSLfVbnATeV1pW
         1wDmc/AoJYodQurvAGYM5mmGC3UijUMJKhB4+lIaFiEkJZOP1+D33ho7EBzVw1C+yJSo
         q1NR71g3iM6j3G7OjHgw+Bzl/NuUDgZRvpf8IR7OdCGQrQjsZa2VfPPXszuf56IZAGEh
         lJiA==
X-Gm-Message-State: AOJu0Yxh959gnDIBxjJ3hK6avDyB5lZspZCblMHXFcj+gIsp1R8WOcKg
	N/XidrphE+nSgh9xLu3oyuMpqilPykQQe+XM7vEh
X-Google-Smtp-Source: AGHT+IEJL/YGcl1HeO8ReXDrsuqtzUGq1wd/C8C6zxLauzMEtqUmjA6ZwzH2itAh+DerMPVQukYfKcnK8Mzm9vv1cIE=
X-Received: by 2002:a25:e908:0:b0:d9a:ce53:4942 with SMTP id
 n8-20020a25e908000000b00d9ace534942mr2525742ybd.0.1700662952611; Wed, 22 Nov
 2023 06:22:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
 <8bff2bf1a4629aacec7b6311d77f233cb75b2f8a.camel@linux.ibm.com>
 <CAHC9VhRm9Tzz3C-VTdXS4s1_-kPQQ6RXMt8JGCS4jorJ0VURyQ@mail.gmail.com>
 <CAHC9VhSJ7MKNM7nMXR3xE-cNMrYB4AT+B76wzF1cKy2JM9tBrA@mail.gmail.com> <1b6853e8354af7033e6d87e77cfb175526753c38.camel@linux.ibm.com>
In-Reply-To: <1b6853e8354af7033e6d87e77cfb175526753c38.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 22 Nov 2023 09:22:21 -0500
Message-ID: <CAHC9VhSnDQ-d9dh_icqNyhpT+cTGQOqGh8+cbN3QzF_qPehvaA@mail.gmail.com>
Subject: Re: [RFC V2] IMA Log Snapshotting Design Proposal
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Tushar Sugandhi <tusharsu@linux.microsoft.com>, linux-integrity@vger.kernel.org, 
	peterhuewe@gmx.de, Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca, 
	Ken Goldman <kgold@linux.ibm.com>, bhe@redhat.com, vgoyal@redhat.com, 
	Dave Young <dyoung@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, jmorris@namei.org, 
	serge@hallyn.com, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	linux-security-module@vger.kernel.org, 
	Tyler Hicks <tyhicks@linux.microsoft.com>, 
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Sush Shringarputale <sushring@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 8:18=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Tue, 2023-11-21 at 23:27 -0500, Paul Moore wrote:
> > On Thu, Nov 16, 2023 at 5:28=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Tue, Oct 31, 2023 at 3:15=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.c=
om> wrote:
> >
> > ...
> >
> > > > Userspace can already export the IMA measurement list(s) via the
> > > > securityfs {ascii,binary}_runtime_measurements file(s) and do whate=
ver
> > > > it wants with it.  All that is missing in the kernel is the ability=
 to
> > > > trim the measurement list, which doesn't seem all that complicated.
> > >
> > > From my perspective what has been presented is basically just trimmin=
g
> > > the in-memory measurement log, the additional complexity (which reall=
y
> > > doesn't look that bad IMO) is there to ensure robustness in the face
> > > of an unreliable userspace (processes die, get killed, etc.) and to
> > > establish a new, transitive root of trust in the newly trimmed
> > > in-memory log.
> > >
> > > I suppose one could simplify things greatly by having a design where
> > > userspace  captures the measurement log and then writes the number of
> > > measurement records to trim from the start of the measurement log to =
a
> > > sysfs file and the kernel acts on that.  You could do this with, or
> > > without, the snapshot_aggregate entry concept; in fact that could be
> > > something that was controlled by userspace, e.g. write the number of
> > > lines and a flag to indicate if a snapshot_aggregate was desired to
> > > the sysfs file.  I can't say I've thought it all the way through to
> > > make sure there are no gotchas, but I'm guessing that is about as
> > > simple as one can get.
>
> > > If there is something else you had in mind, Mimi, please share the
> > > details.  This is a very real problem we are facing and we want to
> > > work to get a solution upstream.
> >
> > Any thoughts on this Mimi?  We have a real interest in working with
> > you to solve this problem upstream, but we need more detailed feedback
> > than "too complicated".  If you don't like the solutions presented
> > thus far, what type of solution would you like to see?
>
> Paul, the design copies the measurement list to a temporary "snapshot"
> file, before trimming the measurement list, which according to the
> design document locks the existing measurement list.  And further
> pauses extending the measurement list to calculate the
> "snapshot_aggregate".

I believe the intent is to only pause the measurements while the
snapshot_aggregate is generated, not for the duration of the entire
snapshot process.  The purpose of the snapshot_aggregate is to
establish a new root of trust, similar to the boot_aggregate, to help
improve attestation performance.

> Userspace can export the measurement list already, so why this
> complicated design?

The current code has no provision for trimming the measurement log,
that's the primary reason.

> As I mentioned previously and repeated yesterday, the
> "snapshot_aggregate" is a new type of critical data and should be
> upstreamed independently of this patch set that trims the measurement
> list.  Trimming the measurement list could be based, as you suggested
> on the number of records to remove, or it could be up to the next/last
> "snapshot_aggregate" record.

Okay, we are starting to get closer, but I'm still missing the part
where you say "if you do X, Y, and Z, I'll accept and merge the
solution."  Can you be more explicit about what approach(es) you would
be willing to accept upstream?

--=20
paul-moore.com

