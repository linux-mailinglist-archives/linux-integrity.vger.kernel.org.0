Return-Path: <linux-integrity+bounces-75-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 128E87EE948
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Nov 2023 23:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E041F23677
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Nov 2023 22:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B9C30652;
	Thu, 16 Nov 2023 22:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fdxma8Mj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A6819A2
	for <linux-integrity@vger.kernel.org>; Thu, 16 Nov 2023 14:28:47 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d9cbba16084so1313227276.1
        for <linux-integrity@vger.kernel.org>; Thu, 16 Nov 2023 14:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700173727; x=1700778527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y93mqvQuQ3cyR5SUPkiKyzE0itYPgBxsZ6Yl8asHxJU=;
        b=fdxma8MjCmMEs/ZtWtaUYxH3dJzFMgDqZxXna5Sn2pljOdBqnK1HtZ4IOzDfgQe7cB
         JcPb6lw9agIaoZa9A7zcCKt7pB+5pcUjvYllVXyUtWRNnV1uLt5AAlsWvjtra5XWQVb4
         8OfJdcWPpTs1nnYO2G+DkmyND8gPVT7oi02+ELvqFp25P1H39Fc+2fzHHcd2WA2zczqn
         wDo+MAr55nHp994jlR6qGd5PqYycwBtEKWNQ+XnlfzUeJkl46UnxbIGCCQGi9uvgSP+1
         Iztr9mMPsbfYCRns6WbKD/IyT/C/0bAu0atWsOYi9yPGzICJJL3+hkipX6Bk2eVQsCR/
         KwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700173727; x=1700778527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y93mqvQuQ3cyR5SUPkiKyzE0itYPgBxsZ6Yl8asHxJU=;
        b=tNZPfHNTTgXOsGwjjA5OjhlQbvSbUI8WdLwvxrxBlZeH+THaw/6qnLLLrJOsi+JY/0
         IgbWe5vFrET8vDQexDfXGYz618We9V47q8y/y5i4j4JF7S8zimBCOEYErxPzNm88OqPH
         kHvTJGdkamnIJP9DoTS/WU7wmOrvZc7od5bXGyvC3aoZwi4q8JxSwU6BuAH3oUn30i8c
         ZAh41s2Vki+wbfqAgNc9mTuoPOgPx1VxaExIRQHFE5BCZbln8OtDp/gURZzFsVMnSqN8
         OwQ/azajwZ5ZG8zMptP1mFLT57InciKmI/8cIvCoAc5xRC7eeH6RyPojZQukODfWxMCo
         B8SA==
X-Gm-Message-State: AOJu0Yw3CQChcUnTROeXueluGK3LiQos+8pIg8OxxqSTGlIGd7f52IyP
	sRTfji1bIhcFe+7iUlLNTilxtRPAFEwwHL36Ja4DgN6Ks1dPWGfqTA74
X-Google-Smtp-Source: AGHT+IFH0V8fklGmPgdOyUiaO72Xq2JkkoI8N9fz5QX6EKc/JUzxtZpHmzPeAmVX3/H+pR3wMRJkHhEUa4N1n3bO95Q=
X-Received: by 2002:a25:2106:0:b0:da3:b466:1f73 with SMTP id
 h6-20020a252106000000b00da3b4661f73mr14599148ybh.24.1700173726615; Thu, 16
 Nov 2023 14:28:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com> <8bff2bf1a4629aacec7b6311d77f233cb75b2f8a.camel@linux.ibm.com>
In-Reply-To: <8bff2bf1a4629aacec7b6311d77f233cb75b2f8a.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 16 Nov 2023 17:28:35 -0500
Message-ID: <CAHC9VhRm9Tzz3C-VTdXS4s1_-kPQQ6RXMt8JGCS4jorJ0VURyQ@mail.gmail.com>
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

On Tue, Oct 31, 2023 at 3:15=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Thu, 2023-10-19 at 11:49 -0700, Tushar Sugandhi wrote:
>
> [...]
> > -----------------------------------------------------------------------
> > | C.1 Solution Summary                                                |
> > -----------------------------------------------------------------------
> > To achieve the goals described in the section above, we propose the
> > following changes to the IMA subsystem.
> >
> >      a. The IMA log from Kernel memory will be offloaded to some
> >         persistent storage disk to keep the system running reliably
> >         without facing memory pressure.
> >         More details, alternate approaches considered etc. are present
> >         in section "D.3 Choices for Storing Snapshots" below.
> >
> >      b. The IMA log will be divided into multiple chunks (snapshots).
> >         Each snapshot would be a delta between the two instances when
> >         the log was offloaded from memory to the persistent storage
> >         disk.
> >
> >      c. Some UM process (like a remote-attestation-client) will be
> >         responsible for writing the IMA log snapshot to the disk.
> >
> >      d. The same UM process would be responsible for triggering the IMA
> >         log snapshot.
> >
> >      e. There will be a well-known location for storing the IMA log
> >         snapshots on the disk.  It will be non-trivial for UM processes
> >         to change that location after booting into the Kernel.
> >
> >      f. A new event, "snapshot_aggregate", will be computed and measure=
d
> >         in the IMA log as part of this feature.  It should help the
> >         remote-attestation client/service to benefit from the IMA log
> >         snapshot feature.
> >         The "snapshot_aggregate" event is described in more details in
> >         section "D.1 Snapshot Aggregate Event" below.
> >
> >      g. If the existing remote-attestation client/services do not chang=
e
> >         to benefit from this feature or do not trigger the snapshot,
> >         the Kernel will continue to have it's current functionality of
> >         maintaining an in-memory full IMA log.
> >
> > Additionally, the remote-attestation client/services need to be updated
> > to benefit from the IMA log snapshot feature.  These proposed changes
> >
> > are described in section "D.4 Remote-Attestation Client/Service Side
> > Changes" below, but their implementation is out of scope for this
> > proposal.
>
> As previously said on v1,
>    This design seems overly complex and requires synchronization between =
the
>    "snapshot" record and exporting the records from the measurement list.=
 [...]
>
>    Concerns:
>    - Pausing extending the measurement list.
>
> Nothing has changed in terms of the complexity or in terms of pausing
> the measurement list.   Pausing the measurement list is a non starter.

The measurement list would only need to be paused for the amount of
time it would require to generate the snapshot_aggregate entry, which
should be minimal and only occurs when a privileged userspace requests
a snapshot operation.  The snapshot remains opt-in functionality, and
even then there is the possibility that the kernel could reject the
snapshot request if generating the snapshot_aggregate entry was deemed
too costly (as determined by the kernel) at that point in time.

> Userspace can already export the IMA measurement list(s) via the
> securityfs {ascii,binary}_runtime_measurements file(s) and do whatever
> it wants with it.  All that is missing in the kernel is the ability to
> trim the measurement list, which doesn't seem all that complicated.

From my perspective what has been presented is basically just trimming
the in-memory measurement log, the additional complexity (which really
doesn't look that bad IMO) is there to ensure robustness in the face
of an unreliable userspace (processes die, get killed, etc.) and to
establish a new, transitive root of trust in the newly trimmed
in-memory log.

I suppose one could simplify things greatly by having a design where
userspace  captures the measurement log and then writes the number of
measurement records to trim from the start of the measurement log to a
sysfs file and the kernel acts on that.  You could do this with, or
without, the snapshot_aggregate entry concept; in fact that could be
something that was controlled by userspace, e.g. write the number of
lines and a flag to indicate if a snapshot_aggregate was desired to
the sysfs file.  I can't say I've thought it all the way through to
make sure there are no gotchas, but I'm guessing that is about as
simple as one can get.

If there is something else you had in mind, Mimi, please share the
details.  This is a very real problem we are facing and we want to
work to get a solution upstream.

--=20
paul-moore.com

