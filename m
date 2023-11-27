Return-Path: <linux-integrity+bounces-255-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DD67FAD3B
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Nov 2023 23:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDB0B281CE6
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Nov 2023 22:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7574C48CC7;
	Mon, 27 Nov 2023 22:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CXrbAC4a"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A27319AD
	for <linux-integrity@vger.kernel.org>; Mon, 27 Nov 2023 14:16:24 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-db048181cd3so4556018276.3
        for <linux-integrity@vger.kernel.org>; Mon, 27 Nov 2023 14:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1701123383; x=1701728183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTXtOQ06AyJD+S/3ZuEjq3dS8iIU8CK5Q8QDa1uxM6Y=;
        b=CXrbAC4aPtlhuP4AYuuVLxsy+Ag7TmGrxs1IZgyBrWZOPgmuw5d9WOC0d/QL5BCT67
         eU69C+tPT0bwhmEK5gh+zRSefiAb8wD8rmu++Jv6Ay9wpASp9OKgeU3qH3cFAqNJcXUS
         ZBRJ3t/aFpL6DUmRIIaQOdwjenFr3rSsUhbVRSrNGKu5CeBONqZ8mg0ZbK9FZ/knO/Sw
         gs2rRBDgeP4hLMe2UX+O8eDAb6vYAcD2+g21Vq9I7flT1TyloQH9/n76GqmElV1mMhGs
         fCFR7dHJ0Gs5mR1iLXtAkoElqKJipj7TvF2N/r3yuLFCqiYlFXy6mO4JaxZUeM6ljF8s
         ePww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701123383; x=1701728183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTXtOQ06AyJD+S/3ZuEjq3dS8iIU8CK5Q8QDa1uxM6Y=;
        b=bcKMtZ4JfhxvFboU9dxzXEqxdJ6oFJvwq4N63T5SKnwQM7oD0X7ZqyuUxH+6kTZDwV
         p4WasqZt7T75Q38MHpG2Ar8Z9akF+pPxrdXoTL+ybLltk57I4BYy0pAzGyBOZeE40rSf
         qtsRH+anCGy2bQ9Nng25pRf+FkmSIjZrnND/MQuF9+0oMg382V8vXSWk9SkyTdYebBOJ
         dPqpHbJRy5PzuVRVO1uTICEdXqENv882uwALz7pIrGTa8Wbyon/2k4N2fZQ2FDW5xtGM
         d/XcRSYJ2VxDx1wTGKMRfoa4DMvBG+7hsTkmN1Ff0aHKjEX3noXRA6bT72sWyTvXarn+
         ZVuA==
X-Gm-Message-State: AOJu0Yz4zdKNiKGkVxavPTCE/J6TcHp9UdBzokEa1jcNKyi/5oljfxY/
	TEvrlDrmPXloAZ68Lp7wxHZJB8HHrV0mD8lE1g/p
X-Google-Smtp-Source: AGHT+IHT/uujwb4aLiR9oamAow6VMBCwqTDyAseQWPVGHc7HKJrLQ1qRdJzOPHyQiiNjlQfnDWkBV7v9+pDw/Ob1SC0=
X-Received: by 2002:a25:1541:0:b0:da0:6cf3:c629 with SMTP id
 62-20020a251541000000b00da06cf3c629mr9988242ybv.41.1701123383283; Mon, 27 Nov
 2023 14:16:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
 <8bff2bf1a4629aacec7b6311d77f233cb75b2f8a.camel@linux.ibm.com>
 <CAHC9VhRm9Tzz3C-VTdXS4s1_-kPQQ6RXMt8JGCS4jorJ0VURyQ@mail.gmail.com>
 <CAHC9VhSJ7MKNM7nMXR3xE-cNMrYB4AT+B76wzF1cKy2JM9tBrA@mail.gmail.com>
 <1b6853e8354af7033e6d87e77cfb175526753c38.camel@linux.ibm.com>
 <CAHC9VhSnDQ-d9dh_icqNyhpT+cTGQOqGh8+cbN3QzF_qPehvaA@mail.gmail.com> <28c4136d0fe360a7fcf6a6547120dc244be0edc3.camel@linux.ibm.com>
In-Reply-To: <28c4136d0fe360a7fcf6a6547120dc244be0edc3.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 27 Nov 2023 17:16:12 -0500
Message-ID: <CAHC9VhTykrsXTuWfRe3rzg2SMbzynvgwXmxVpN5T0cfY7YrkwA@mail.gmail.com>
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

On Mon, Nov 27, 2023 at 12:08=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> w=
rote:
> On Wed, 2023-11-22 at 09:22 -0500, Paul Moore wrote:

...

> > Okay, we are starting to get closer, but I'm still missing the part
> > where you say "if you do X, Y, and Z, I'll accept and merge the
> > solution."  Can you be more explicit about what approach(es) you would
> > be willing to accept upstream?
>
> Included with what is wanted/needed is an explanation as to my concerns
> with the existing proposal.
>
> First we need to differentiate between kernel and uhserspace
> requirements.  (The "snapshotting" design proposal intermixes them.)
>
> From the kernel persective, the Log Snapshotting Design proposal "B.1
> Goals" is very nice, but once the measurement list can be trimmed it is
> really irrelevant.  Userspace can do whatever it wants with the
> measurement list records.  So instead of paying lip service to what
> should be done, just call it as it is - trimming the measurement list.

Fair enough.  I personally think it is nice to have a brief discussion
of how userspace might use a kernel feature, but if you prefer to drop
that part of the design doc I doubt anyone will object very strongly.

> -----------------------------------------------------------------------
> | B.1 Goals                                                           |
> -----------------------------------------------------------------------
> To address the issues described in the section above, we propose
> enhancements to the IMA subsystem to achieve the following goals:
>
>   a. Reduce memory pressure on the Kernel caused by larger in-memory
>      IMA logs.
>
>   b. Preserve the system's ability to get remotely attested using the
>      IMA log, even after implementing the enhancements to reduce memory
>      pressure caused by the IMA log. IMA's Integrity guarantees should
>      be maintained.
>
>   c. Provide mechanisms from Kernel side to the remote attestation
>      service to make service-side processing more efficient.

That looks fine to me.

> From the kernel perspective there needs to be a method of trimming N
> number of records from the head of the measurement list.  In addition
> to the existing securityfs "runtime measurement list",  defining a new
> securityfs file containing the current count of in memory measurement
> records would be beneficial.

I imagine that should be trivial to implement and I can't imagine
there being any objection to that.

If we are going to have a record count, I imagine it would also be
helpful to maintain a securityfs file with the total size (in bytes)
of the in-memory measurement log.  In fact, I suspect this will
probably be more useful for those who wish to manage the size of the
measurement log.

> Defining other IMA securityfs files like
> how many times the measurement list has been trimmed might be
> beneficial as well.

I have no objection to that.  Would a total record count, i.e. a value
that doesn't reset on a snapshot event, be more useful here?

> Of course properly document the integrity
> implications and repercussions of the new Kconfig that allows trimming
> the measurement list.

Of course.

> Defining a simple "trim" marker measurement record would be a visual
> indication that the measurement list has been trimmed.  I might even
> have compared it to the "boot_aggregate".  However, the proposed marker
> based on TPM PCRs requires pausing extending the measurement list.

...

> Before defining a new critical-data record, we need to decide whether
> it is really necessary or if it is redundant.  If we define a new
> "critical-data" record, can it be defined such that it doesn't require
> pausing extending the measurement list?  For example, a new simple
> visual critical-data record could contain the number of records (e.g.
> <securityfs>/ima/runtime_measurements_count) up to that point.

What if the snapshot_aggregate was a hash of the measurement log
starting with either the boot_aggregate or the latest
snapshot_aggregate and ending on the record before the new
snapshot_aggregate?  The performance impact at snapshot time should be
minimal as the hash can be incrementally updated as new records are
added to the measurement list.  While the hash wouldn't capture the
TPM state, it would allow some crude verification when reassembling
the log.  If one could bear the cost of a TPM signing operation, the
log digest could be signed by the TPM.

> The new critical-data record and trimming the measurement list should
> be disjoint features.  If the first record after trimming the
> measurement list should be the critical-data record, then trim the
> measurement list up to that point.

I disagree about the snapshot_aggregate record being disjoint from the
measurement log, but I suspect Tushar and Sush are willing to forgo
the snapshot_aggregate if that is a blocker from your perspective.
Once again, the main goal is the ability to manage the size of the
measurement log; while having a snapshot_aggregate that can be used to
establish a root of trust similar to the boot_aggregate is nice, it is
not a MUST have.

> From a userspace perspective, trimming the measurement list is a major
> change and will break existing attestation requests, unless the change
> is transparent.  Removing "snapshots"/"shards" will of course break
> attestation requests.  Refer to Stefan's suggestions:
> https://lore.kernel.org/linux-integrity/1ed2d72c-4cb2-48b3-bb0f-b0877fc1e=
9ca@linux.ibm.com/

You will note that Sush and I replied to Stefan two weeks ago.

--=20
paul-moore.com

