Return-Path: <linux-integrity+bounces-74-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7791E7EE91B
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Nov 2023 23:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D046280F71
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Nov 2023 22:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF9245000;
	Thu, 16 Nov 2023 22:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="I+ByHDZl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6555F189
	for <linux-integrity@vger.kernel.org>; Thu, 16 Nov 2023 14:07:28 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d9ac3b4f42cso2165568276.0
        for <linux-integrity@vger.kernel.org>; Thu, 16 Nov 2023 14:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700172447; x=1700777247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=McWLK0Erh20b4c0w4AHhfY135hMZXUKuEa1U628p59w=;
        b=I+ByHDZl7O1bS5T23yOnMkTOUF2NjpW7FPshYmiaOFgk4A08f/GZ9oFYW6S5vl6mpd
         PmnoXxXTSNN0jKugKGAYviuziey8wqaKAP2gwxip2eet8ObO4a/Wyal3bOOTJVkpXLU5
         ms9JvZtSHZKqMIs/Y+AVP7ribP2k2xr0x6OdHEkR7+s7SjlMVAa9tE3G0h64gCeX3eMF
         fHsYvIAaAdTq2LgLyxb2NGDX8E1/K9inFVwBIWStjFVS3GLb/5K6JY4fz2/5cAyssSKo
         xT7luT0bpyudmG+mM9IoC4+8CPCAhAeXkeZHTRKQaWLljd8TrH/tSMCjCthfy5kJpp6w
         J1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700172447; x=1700777247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=McWLK0Erh20b4c0w4AHhfY135hMZXUKuEa1U628p59w=;
        b=uePFryjPrcDlHjAiPP7u09oYfUW0U9h+Awksr68uS4z81A+mOzeuk5Wft2xl7tpy0o
         4MPgfXlMv6dgDroksrpJDiULwOzUwXZkX78WDknC6EVq4NqNH1Bx48ZtzK13K3kC8Pft
         Jsf01kaZkZFACWJKJ0e7PYevnqzGbhwXnrWyaw9Z+ze0kxfNKSBOaXu1yTbZrYaYyXR/
         vNrxKl28gvqRYFE5pxchQzjyIXCCarHTK1LG1n+mjHRo/6sXljYVDwkYKH3aS3EP/C4S
         9rDJkGnd2YiPeX50z3fQ/wDVWTWOryGrm+ecLT/LuydeUKiEpCRnf7gn+kvrkGQYrMsN
         PE6w==
X-Gm-Message-State: AOJu0YzoVhDTqgAT5Tq+MSop4lzLtX8inJWt9KGnVky3z4BExId4GvyQ
	QAjxvgMP/HnJvrRCB9DUt+AiTqjOls80NUU20Obu
X-Google-Smtp-Source: AGHT+IHED5b06hwidP35hDGIWSIQ9u3imhXraRogqXkH7N0Totrcom3GLJDKwPINv/bKKOTrKwcA+sef6an7q3F/l3w=
X-Received: by 2002:a25:74cb:0:b0:daf:1ab5:e454 with SMTP id
 p194-20020a2574cb000000b00daf1ab5e454mr2458374ybc.7.1700172447508; Thu, 16
 Nov 2023 14:07:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
 <53db2f31-e383-445f-b746-961958a619bd@linux.ibm.com> <5dfcb0d6-8cbf-428e-b8c1-30333fc668b5@linux.microsoft.com>
 <ce2e6de7-4289-442e-8209-fb7c01f51e14@linux.ibm.com>
In-Reply-To: <ce2e6de7-4289-442e-8209-fb7c01f51e14@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 16 Nov 2023 17:07:16 -0500
Message-ID: <CAHC9VhQ2ZGxAyB0Zy=BQAyJe7ofknaXaAgsgtt5G-ENExdHA=A@mail.gmail.com>
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

On Tue, Nov 14, 2023 at 1:58=E2=80=AFPM Stefan Berger <stefanb@linux.ibm.co=
m> wrote:
> On 11/14/23 13:36, Sush Shringarputale wrote:
> > On 11/13/2023 10:59 AM, Stefan Berger wrote:
> >> On 10/19/23 14:49, Tushar Sugandhi wrote:
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> | Introduction |
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> This document provides a detailed overview of the proposed Kernel
> >>> feature IMA log snapshotting.  It describes the motivation behind the
> >>> proposal, the problem to be solved, a detailed solution design with
> >>> examples, and describes the changes to be made in the clients/service=
s
> >>> which are part of remote-attestation system.  This is the 2nd version
> >>> of the proposal.  The first version is present here[1].
> >>>
> >>> Table of Contents:
> >>> ------------------
> >>> A. Motivation and Background
> >>> B. Goals and Non-Goals
> >>>      B.1 Goals
> >>>      B.2 Non-Goals
> >>> C. Proposed Solution
> >>>      C.1 Solution Summary
> >>>      C.2 High-level Work-flow
> >>> D. Detailed Design
> >>>      D.1 Snapshot Aggregate Event
> >>>      D.2 Snapshot Triggering Mechanism
> >>>      D.3 Choosing A Persistent Storage Location For Snapshots
> >>>      D.4 Remote-Attestation Client/Service-side Changes
> >>>          D.4.a Client-side Changes
> >>>          D.4.b Service-side Changes
> >>> E. Example Walk-through
> >>> F. Other Design Considerations
> >>> G. References
> >>>
> >>
> >> Userspace applications will have to know
> >> a) where are the shard files?
> > We describe the file storage location choices in section D.3, but user
> > applications will have to query the well-known location described there=
.
> >> b) how do I read the shard files while locking out the producer of the
> >> shard files?
> >>
> >> IMO, this will require a well known config file and a locking method
> >> (flock) so that user space applications can work together in this new
> >> environment. The lock could be defined in the config file or just be
> >> the config file itself.
> > The flock is a good idea for co-ordination between UM clients. While
> > the Kernel cannot enforce any access in this way, any UM process that
> > is planning on triggering the snapshot mechanism should follow that
> > protocol.  We will ensure we document that as the best-practices in
> > the patch series.
>
> It's more than 'best practices'. You need a well-known config file with
> well-known config options in it.
>
> All clients that were previously just trying to read new bytes from the
> IMA log cannot do this anymore in the presence of a log shard producer
> but have to also learn that a new log shard has been produced so they
> need to figure out the new position in the log where to read from. So
> maybe a counter in a config file should indicate to the log readers that
> a new log has been produced -- otherwise they would have to monitor all
> the log shard files or the log shard file's size.

If a counter is needed, I would suggest placing it somewhere other
than the config file so that we can enforce limited write access to
the config file.

Regardless, I imagine there are a few ways one could synchronize
various userspace applications such that they see a consistent view of
the decomposed log state, and the good news is that the approach
described here is opt-in from a userspace perspective.  If the
userspace does not fully support IMA log snapshotting then it never
needs to trigger it and the system behaves as it does today; on the
other hand, if the userspace has been updated it can make use of the
new functionality to better manage the size of the IMA measurement
log.

--=20
paul-moore.com

