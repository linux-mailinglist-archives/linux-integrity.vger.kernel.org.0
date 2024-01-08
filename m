Return-Path: <linux-integrity+bounces-687-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4B182761C
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jan 2024 18:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383C81C2171F
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jan 2024 17:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDEE54729;
	Mon,  8 Jan 2024 17:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="E848Eykr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5A25467C
	for <linux-integrity@vger.kernel.org>; Mon,  8 Jan 2024 17:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso902521276.2
        for <linux-integrity@vger.kernel.org>; Mon, 08 Jan 2024 09:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1704734134; x=1705338934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VObJMmtss80pjOMFY/ul+U3iSObFgwr/Elfnq2O3o8=;
        b=E848Eykrg/z/K/7bXVmiWZAl4QUpBINIPK5qSQv/G+7CmwSGMmXTtzcnmVK1+foMmG
         bIm69DwilKhYXUDF+YlMTTNn+a2KorwUmswvSo8/iBDEDzQZ9eldTi05cNn0Qi1yCwD3
         FcEHyVYWvaOM62s5yhpis9KGlIoGC8hY0oozpfWmnHk0dh6+lCwMj0RV7YxI6quQBTIv
         Tl4bXjWDYA9MQCYyeVFgmE811fWopPPal35P+GIz51JK5151dH/OB6BHk80vH6JYx3Uc
         VzZTZ2U+mAkL3DZ5LyaA4rsk3Ait2iFjvg9nIQVgmcKCRUcc8JW5WNWHDXsCaTC7DdTm
         bXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704734134; x=1705338934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1VObJMmtss80pjOMFY/ul+U3iSObFgwr/Elfnq2O3o8=;
        b=tS1lFyWZWFo0M3+3Oe3+6md9p/Mxeo40VMHMkbvkwYTgRO+bdjh0EmWqKhrea4LAZK
         3DvKbFymppPEKXWEUcC/QCFFICW6fHcq/EsKeCVYalgg8PeNAz1ZaN764vHIIpq7B3Os
         qe4XSNzBzsNw+gALYhgGedA2lK7GlBV8Os/SU3yAzieFliKPeviryXVn/Z70SYL2Ksqm
         +jAkmOqI3evU7queeF7fhrOLpK9sRBn/PlIxQzid3p8enHIVvmxtQr310WtRWGu56KEr
         10WIs9Fs07R+RpuYj1TeZbMK/GHqoPT65yNej+MO8PtfEFL3s1OKLhKJXSpwMEjAwKPO
         pMNg==
X-Gm-Message-State: AOJu0Yypq1TrXktHw2HDCSrO6joMFEtvu+aOuX3iLAop0MRxruBkR+2G
	V3i8a8bsafwmBdiXOsGyAIoMWXfuRxdjO9qn6WyrqbCbhLmd
X-Google-Smtp-Source: AGHT+IGiA947EQsCfPMLWj6zh9yvcmV9aJXNrg3MW32J+xLvFQb7c0x0GKQzXB1t/mYp8dYwnjJMYU/4htqd7pGLBOw=
X-Received: by 2002:a25:1087:0:b0:dbe:ab15:2ffc with SMTP id
 129-20020a251087000000b00dbeab152ffcmr1175630ybq.108.1704734134429; Mon, 08
 Jan 2024 09:15:34 -0800 (PST)
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
 <CAHC9VhSnDQ-d9dh_icqNyhpT+cTGQOqGh8+cbN3QzF_qPehvaA@mail.gmail.com>
 <28c4136d0fe360a7fcf6a6547120dc244be0edc3.camel@linux.ibm.com>
 <CAHC9VhTykrsXTuWfRe3rzg2SMbzynvgwXmxVpN5T0cfY7YrkwA@mail.gmail.com>
 <d5e2358a0a7aaf4455b1f479483b312e98aa07d5.camel@linux.ibm.com>
 <CAHC9VhRNLzbW++rW3Hep+3yyJZRRvZ4h7LuKcSbRRn-wqh-PAQ@mail.gmail.com>
 <d9975a7949ca49f404adc981e942f42b6f19d022.camel@linux.ibm.com>
 <CAHC9VhRd5Qi_NZJMOfHC6jTr_dn0mNFGhy18ff2YgtjQo+38dQ@mail.gmail.com>
 <5faa2b81b550d44f0a02917f11c4838d11cbda00.camel@linux.ibm.com>
 <CAHC9VhRYLLtdOD1GTtigTrgsALdBqUikiNhdBNSaLYxD1iN8bw@mail.gmail.com> <b915f194c9024233d9f6f6ccbf417c26600ee261.camel@linux.ibm.com>
In-Reply-To: <b915f194c9024233d9f6f6ccbf417c26600ee261.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 8 Jan 2024 12:15:23 -0500
Message-ID: <CAHC9VhR0yuiixQpMLspjxmke5xhg6jOOBodJg5BgHngp+XshnA@mail.gmail.com>
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

On Mon, Jan 8, 2024 at 6:48=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> wro=
te:
> On Sun, 2024-01-07 at 21:58 -0500, Paul Moore wrote:
> > On Sun, Jan 7, 2024 at 7:59=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com>=
 wrote:
> > > On Sat, 2024-01-06 at 18:27 -0500, Paul Moore wrote:
> > > > On Tue, Nov 28, 2023 at 9:07=E2=80=AFPM Mimi Zohar <zohar@linux.ibm=
.com> wrote:
> > > > > On Tue, 2023-11-28 at 20:06 -0500, Paul Moore wrote:
> > > > > > On Tue, Nov 28, 2023 at 7:09=E2=80=AFAM Mimi Zohar <zohar@linux=
.ibm.com> wrote:
> > > > > > > On Mon, 2023-11-27 at 17:16 -0500, Paul Moore wrote:
> > > > > > > > On Mon, Nov 27, 2023 at 12:08=E2=80=AFPM Mimi Zohar <zohar@=
linux.ibm.com> wrote:
> > > > > > > > > On Wed, 2023-11-22 at 09:22 -0500, Paul Moore wrote:
> > > >
> > > > ...
> > > >
> > > > > > > > > Before defining a new critical-data record, we need to de=
cide whether
> > > > > > > > > it is really necessary or if it is redundant.  If we defi=
ne a new
> > > > > > > > > "critical-data" record, can it be defined such that it do=
esn't require
> > > > > > > > > pausing extending the measurement list?  For example, a n=
ew simple
> > > > > > > > > visual critical-data record could contain the number of r=
ecords (e.g.
> > > > > > > > > <securityfs>/ima/runtime_measurements_count) up to that p=
oint.
> > > > > > > >
> > > > > > > > What if the snapshot_aggregate was a hash of the measuremen=
t log
> > > > > > > > starting with either the boot_aggregate or the latest
> > > > > > > > snapshot_aggregate and ending on the record before the new
> > > > > > > > snapshot_aggregate?  The performance impact at snapshot tim=
e should be
> > > > > > > > minimal as the hash can be incrementally updated as new rec=
ords are
> > > > > > > > added to the measurement list.  While the hash wouldn't cap=
ture the
> > > > > > > > TPM state, it would allow some crude verification when reas=
sembling
> > > > > > > > the log.  If one could bear the cost of a TPM signing opera=
tion, the
> > > > > > > > log digest could be signed by the TPM.
> > > > > > >
> > > > > > > Other critical data is calculated, before calling
> > > > > > > ima_measure_critical_data(), which adds the record to the mea=
surement
> > > > > > > list and extends the TPM PCR.
> > > > > > >
> > > > > > > Signing the hash shouldn't be an issue if it behaves like oth=
er
> > > > > > > critical data.
> > > > > > >
> > > > > > > In addition to the hash, consider including other information=
 in the
> > > > > > > new critical data record (e.g. total number of measurement re=
cords, the
> > > > > > > number of measurements included in the hash, the number of ti=
mes the
> > > > > > > measurement list was trimmed, etc).
> > > > > >
> > > > > > It would be nice if you could provide an explicit list of what =
you
> > > > > > would want hashed into a snapshot_aggregate record; the above i=
s
> > > > > > close, but it is still a little hand-wavy.  I'm just trying to =
reduce
> > > > > > the back-n-forth :)
> > > > >
> > > > > What is being defined here is the first IMA critical-data record,=
 which
> > > > > really requires some thought.
> > > >
> > > > My thinking has always been that taking a hash of the current
> > > > measurement log up to the snapshot point would be a nice
> > > > snapshot_aggregate measurement, but I'm not heavily invested in tha=
t.
> > > > To me it is more important that we find something we can all agree =
on,
> > > > perhaps reluctantly, so we can move forward with a solution.
> > > >
> > > > > For ease of review, this new critical-
> > > > > data record should be a separate patch set from trimming the
> > > > > measurement list.
> > > >
> > > > I see the two as linked, but if you prefer them as separate then so=
 be
> > > > it.  Once again, the important part is to move forward with a
> > > > solution, I'm not overly bothered if it arrives in multiple pieces
> > > > instead of one.
> > >
> > > Trimming the IMA measurement list could be used in conjunction with t=
he new IMA
> > > critical data record or independently.  Both options should be suppor=
ted.
> > >
> > > 1. trim N number of records from the head of the in kernel IMA measur=
ement list
> > > 2. intermittently include the new IMA critical data record based on s=
ome trigger
> > > 3. trim the measurement list up to the (first/last/Nth) IMA critical =
data record
> > >
> > > Since the two features could be used independently of each other, the=
re is no
> > > reason to upstream them as a single patch set.  It just makes it hard=
er to
> > > review.
> >
> > I don't see much point in recording a snapshot aggregate if you aren't
> > doing a snapshot, but it's not harmful in any way, so sure, go for it.
> > Like I said earlier, as long as the functionality is there, I don't
> > think anyone cares too much how it gets into the kernel (although
> > Tushar and Sush should comment from the perspective).
>
> Paul, there are two features:
> - trimming the measurement list
> - defining and including an IMA critical data record
>
> The original design doc combined these two features making them an "atomi=
c"
> operation and referred to it as a snapshot.  At the time the term "snapsh=
ot" was
> an appropriate term for the IMA critical record.  Now not so much.
>
> These are two separate, independent features.  Trimming the measurement l=
ist
> should not be dependent on the IMA critical data record.  The IMA critica=
l data
> record should not be dependent on trimming the measurement list.  Trimmin=
g the
> measurement list up to the (first/last/Nth) critical data record should b=
e
> optional.

Mimi, do you keep missing the part in my replies where I mention that
I don't really care as long as the trimming and aggregate both make it
into the kernel?  I don't agree with your assertion that the two
pieces of functionality are independent, but it doesn't really matter
as long as the functionality is in place, userspace can be made to do
what Tushar and Sush need to do.

> > > > > As I'm sure you're aware, SElinux defines two critical-data recor=
ds.
> > > > > From security/selinux/ima.c:
> > > > >
> > > > >         ima_measure_critical_data("selinux", "selinux-state",
> > > > >                                   state_str, strlen(state_str), f=
alse,
> > > > >                                   NULL, 0);
> > > > >
> > > > >         ima_measure_critical_data("selinux", "selinux-policy-hash=
",
> > > > >                                   policy, policy_len, true,
> > > > >                                   NULL, 0);
> > > >
> > > > Yep, but there is far more to this than SELinux.
> > >
> > > Only if you conflate the two features.
> >
> > If that is a clever retort, you'll need to elaborate a bit as it
> > doesn't make much sense to me.  The IMA measurement log snapshot is
> > independent from SELinux; the only connection is that yes, IMA does
> > measure SELinux "things" but that is no different from any other
> > system attribute that is measured by IMA.
>
> The IMA critical data record should not be that different or more difficu=
lt,
> than the SELinux critical data record.  Only if you conflate the two feat=
ures
> being discussed - trimming the IMA measurement list and the IMA critical =
data
> record - does it become "far more".

I still don't understand why you've brought SELinux into this, it
makes no sense from my perspective as the two are "separate,
independent features".  Are you trying to draw some odd parallel
between snapshotting and IMA/SELinux?  I guess I'd suggest just
dropping this comparison and focusing on more concrete things like
"the aggregate should contain X, Y, and Z", etc. as that is something
we can all understand and use as a starting point to continue to make
forward progress.

--=20
paul-moore.com

