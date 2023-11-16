Return-Path: <linux-integrity+bounces-77-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B277EE98D
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Nov 2023 23:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E822D1C208E8
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Nov 2023 22:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0439714AAC;
	Thu, 16 Nov 2023 22:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UvJAPGer"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9C3AD
	for <linux-integrity@vger.kernel.org>; Thu, 16 Nov 2023 14:56:35 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d9abc069c8bso1368600276.3
        for <linux-integrity@vger.kernel.org>; Thu, 16 Nov 2023 14:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700175394; x=1700780194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsOeDCVHbRtCHMfzzq1TAv9cQgSIrowc6ucZqtobrEU=;
        b=UvJAPGer1rLT37Nf/reICuJdhwXv/hWEvgAUoG0GMIpqN6WArmS0x4YngdV1zOMTj0
         518yhh8ErpZxO+C5qeIIdWYNWXT2BvVYUi5l2QPBpzc6MeioDLFi3t9zA+4fQvE6CXKW
         41qWksrCZbXayWK9FsHWjoYJfhOO8wjfvBLmbSJn9mgPRAGpamnzc8bznTvo/b9xR8Wp
         r8AIhnQBxMYpfznx60A6sORf8EsiNy3gysL2QNsfgyKu5YISfoydQgiYzJc1M/ri9nhb
         CWlIM/Im18S2rFhPkxFBKjxzOgCL16l4ylNp3Y4k3KAfC1h50U9oApNBYSez5SQ9GfKb
         hR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700175394; x=1700780194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IsOeDCVHbRtCHMfzzq1TAv9cQgSIrowc6ucZqtobrEU=;
        b=gY5q3PFctG1V+dFJCvtkjCoKfaJQIJmv6y42yruHNgqWM+X4s+BG8oPS7yKRgwI+ei
         rLYk9Bh4Lq8qjX7m2iSjiMBsYpzRraQpPEOH79/TiiFRo2lcZ6QvPZb0psXTyfw/Ro86
         0w7N1OjQU6G7jMje/So7r44gq4MJfiVekLDbhLJc8D8JiQKVvCHuKygWELE5GCod5nFH
         OlKFOFFhvBM/0Sp7t6+v1PaAAvW6lU1qHzT247v7HjdNzYLJTUR3QpNMRuPxxOx8NtOJ
         7/1wZHCo5Z/HWiap186+wDakGGy4nKu2k7FTrG5SsQMHHxyVyYuRY+UI4JmKHtQOxYub
         WxUQ==
X-Gm-Message-State: AOJu0YzHVnO2QCCuPxWDs1LRoBOfKOLf1m+pxGz9aWQJWEkv0tf0ZAq/
	U7jzZOCX0ZdX3wA2Vp1YIqwpN6Ol2SldaShO/o4x
X-Google-Smtp-Source: AGHT+IE2+AcN0WJvi0/kso4DZanSDDx6lgfXDUrfRsZwb16RGMyBmQlC1nbV8aw1RFcW/pXSAxD2p1WHO1Zi2XhSD08=
X-Received: by 2002:a25:d087:0:b0:d9b:6264:b79e with SMTP id
 h129-20020a25d087000000b00d9b6264b79emr15509359ybg.53.1700175394153; Thu, 16
 Nov 2023 14:56:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
 <53db2f31-e383-445f-b746-961958a619bd@linux.ibm.com> <5dfcb0d6-8cbf-428e-b8c1-30333fc668b5@linux.microsoft.com>
 <ce2e6de7-4289-442e-8209-fb7c01f51e14@linux.ibm.com> <CAHC9VhQ2ZGxAyB0Zy=BQAyJe7ofknaXaAgsgtt5G-ENExdHA=A@mail.gmail.com>
 <1ed2d72c-4cb2-48b3-bb0f-b0877fc1e9ca@linux.ibm.com>
In-Reply-To: <1ed2d72c-4cb2-48b3-bb0f-b0877fc1e9ca@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 16 Nov 2023 17:56:23 -0500
Message-ID: <CAHC9VhTxQZ5+omZdjwtQwe7MJeAdaLAXP2d5GgyyABLRYkWkGw@mail.gmail.com>
Subject: Re: [RFC V2] IMA Log Snapshotting Design Proposal
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Sush Shringarputale <sushring@linux.microsoft.com>, 
	Tushar Sugandhi <tusharsu@linux.microsoft.com>, linux-integrity@vger.kernel.org, 
	Mimi Zohar <zohar@linux.ibm.com>, peterhuewe@gmx.de, 
	Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca, Ken Goldman <kgold@linux.ibm.com>, bhe@redhat.com, 
	vgoyal@redhat.com, Dave Young <dyoung@redhat.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, jmorris@namei.org, serge@hallyn.com, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	linux-security-module@vger.kernel.org, 
	Tyler Hicks <tyhicks@linux.microsoft.com>, 
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 5:41=E2=80=AFPM Stefan Berger <stefanb@linux.ibm.co=
m> wrote:
> On 11/16/23 17:07, Paul Moore wrote:
> > On Tue, Nov 14, 2023 at 1:58=E2=80=AFPM Stefan Berger <stefanb@linux.ib=
m.com> wrote:
> >> On 11/14/23 13:36, Sush Shringarputale wrote:
> >>> On 11/13/2023 10:59 AM, Stefan Berger wrote:
> >>>> On 10/19/23 14:49, Tushar Sugandhi wrote:
> >>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>> | Introduction |
> >>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>> This document provides a detailed overview of the proposed Kernel
> >>>>> feature IMA log snapshotting.  It describes the motivation behind t=
he
> >>>>> proposal, the problem to be solved, a detailed solution design with
> >>>>> examples, and describes the changes to be made in the clients/servi=
ces
> >>>>> which are part of remote-attestation system.  This is the 2nd versi=
on
> >>>>> of the proposal.  The first version is present here[1].
> >>>>>
> >>>>> Table of Contents:
> >>>>> ------------------
> >>>>> A. Motivation and Background
> >>>>> B. Goals and Non-Goals
> >>>>>       B.1 Goals
> >>>>>       B.2 Non-Goals
> >>>>> C. Proposed Solution
> >>>>>       C.1 Solution Summary
> >>>>>       C.2 High-level Work-flow
> >>>>> D. Detailed Design
> >>>>>       D.1 Snapshot Aggregate Event
> >>>>>       D.2 Snapshot Triggering Mechanism
> >>>>>       D.3 Choosing A Persistent Storage Location For Snapshots
> >>>>>       D.4 Remote-Attestation Client/Service-side Changes
> >>>>>           D.4.a Client-side Changes
> >>>>>           D.4.b Service-side Changes
> >>>>> E. Example Walk-through
> >>>>> F. Other Design Considerations
> >>>>> G. References
> >>>>>
> >>>>
> >>>> Userspace applications will have to know
> >>>> a) where are the shard files?
> >>> We describe the file storage location choices in section D.3, but use=
r
> >>> applications will have to query the well-known location described the=
re.
> >>>> b) how do I read the shard files while locking out the producer of t=
he
> >>>> shard files?
> >>>>
> >>>> IMO, this will require a well known config file and a locking method
> >>>> (flock) so that user space applications can work together in this ne=
w
> >>>> environment. The lock could be defined in the config file or just be
> >>>> the config file itself.
> >>> The flock is a good idea for co-ordination between UM clients. While
> >>> the Kernel cannot enforce any access in this way, any UM process that
> >>> is planning on triggering the snapshot mechanism should follow that
> >>> protocol.  We will ensure we document that as the best-practices in
> >>> the patch series.
> >>
> >> It's more than 'best practices'. You need a well-known config file wit=
h
> >> well-known config options in it.
> >>
> >> All clients that were previously just trying to read new bytes from th=
e
> >> IMA log cannot do this anymore in the presence of a log shard producer
> >> but have to also learn that a new log shard has been produced so they
> >> need to figure out the new position in the log where to read from. So
> >> maybe a counter in a config file should indicate to the log readers th=
at
> >> a new log has been produced -- otherwise they would have to monitor al=
l
> >> the log shard files or the log shard file's size.
> >
> > If a counter is needed, I would suggest placing it somewhere other
> > than the config file so that we can enforce limited write access to
> > the config file.
> >
> > Regardless, I imagine there are a few ways one could synchronize
> > various userspace applications such that they see a consistent view of
> > the decomposed log state, and the good news is that the approach
> > described here is opt-in from a userspace perspective.  If the
>
> A FUSE filesystem that stitches together the log shards from one or
> multiple files + IMA log file(s) could make this approach transparent
> for as long as log shards are not thrown away. Presumably it (or root)
> could bind-mount its files over the two IMA log files.
>
> > userspace does not fully support IMA log snapshotting then it never
> > needs to trigger it and the system behaves as it does today; on the
>
> I don't think individual applications should trigger it , instead some
> dedicated background process running on a machine would do that every n
> log entries or so and possibly offer the FUSE filesystem at the same
> time. In either case, once any application triggers it, all either have
> to know how to deal with the shards or FUSE would make it completely
> transparent.

Yes, performing a snapshot is a privileged operation which I expect
would be done and managed by a dedicated daemon running on the system.

--=20
paul-moore.com

