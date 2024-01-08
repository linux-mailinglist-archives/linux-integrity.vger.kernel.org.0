Return-Path: <linux-integrity+bounces-679-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0249A82674E
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jan 2024 03:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82C7C281803
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jan 2024 02:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C872A5B;
	Mon,  8 Jan 2024 02:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="T+ij6OwW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE6810E9
	for <linux-integrity@vger.kernel.org>; Mon,  8 Jan 2024 02:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6808c3938afso15183016d6.1
        for <linux-integrity@vger.kernel.org>; Sun, 07 Jan 2024 18:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1704682724; x=1705287524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlIIC5u/eTGl34/V75N+OsotTMr0HSydl9c69RMzHn0=;
        b=T+ij6OwWAMQP/mc4k9lMxGeN62LBh+RdvFs1i2WnB8XUWOtGOboO5e089V5qplp6Hs
         5/erGEklFdbh5CRtTzpidb0pY3wBOvvYIbAguwnNbL+/Cy4VlZC+dbZZ4FcWf0buYEg+
         1JJmYQ4AGOPzdFtfBIIn34DUQwcryPZRRumLzunRdbj3rae8Nl9GB2A7RxJnKuLMgwdr
         fXkNC/0ceHS5TwcOhDxgK8Jsgq9vBzTRH0XfgTw3RbJowvtmcAMLDAOqfaeZDqxM4PQm
         LFXSDO9Hp2UjWgRG0CacQY+rGjRRg/ZqYPtd8idtJZpq+PMWfCBsRqRLsA+AgPCJp5R3
         QEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704682724; x=1705287524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlIIC5u/eTGl34/V75N+OsotTMr0HSydl9c69RMzHn0=;
        b=MGDAG2l6Dlf3aiYOKO1MjzzIq0Hn35Rs/EWKoWI8MsFTScMyusEZVp3RACdURU0JVi
         TPPosBStE20T+uhjllPiG1va0uYp9qfyNYS6ukK5IXv3mtJBepCycaWh+GkfT9lncTMf
         IQB8dxj5+5iAA3eosQwDufxkNxILlqPKB+zVk1OVSoSW6r3lWDUl9/h4UFJg5bFgNTM8
         qTohVaj+SVFUsZOE7mjssAkKflbOsxB2Lkkb4cz6G/XHvdn7vjIfW2cmw5jlSFm43gi1
         AwKhNrSE0tXRoExadBThzar9l9u5ZUpDDBhAeSSI8r8isz6J5TmobJRvKdgNh2sVw+Eh
         vB6g==
X-Gm-Message-State: AOJu0YxZx2VWIqawLNyVcmNXrJan8zAfjBMi59b8BbyrwmLHz+mYKhOM
	rcL3gwYX6YCkQb3ntlW89UW3uqemVa5tpGKed+UI4Pvn+Ohl
X-Google-Smtp-Source: AGHT+IGACtAKjaMoPGc2k72C9NOma3jMrbB56JAYTw6ZeHqXVo0kVYSoHxnrmj+UtkF+odAAWzpMyPA6aAiB4Bhd9dQ=
X-Received: by 2002:a05:6214:401:b0:680:b79f:736e with SMTP id
 z1-20020a056214040100b00680b79f736emr4710723qvx.125.1704682724585; Sun, 07
 Jan 2024 18:58:44 -0800 (PST)
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
 <CAHC9VhRd5Qi_NZJMOfHC6jTr_dn0mNFGhy18ff2YgtjQo+38dQ@mail.gmail.com> <5faa2b81b550d44f0a02917f11c4838d11cbda00.camel@linux.ibm.com>
In-Reply-To: <5faa2b81b550d44f0a02917f11c4838d11cbda00.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 7 Jan 2024 21:58:33 -0500
Message-ID: <CAHC9VhRYLLtdOD1GTtigTrgsALdBqUikiNhdBNSaLYxD1iN8bw@mail.gmail.com>
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

On Sun, Jan 7, 2024 at 7:59=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> wro=
te:
> On Sat, 2024-01-06 at 18:27 -0500, Paul Moore wrote:
> > On Tue, Nov 28, 2023 at 9:07=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com=
> wrote:
> > > On Tue, 2023-11-28 at 20:06 -0500, Paul Moore wrote:
> > > > On Tue, Nov 28, 2023 at 7:09=E2=80=AFAM Mimi Zohar <zohar@linux.ibm=
.com> wrote:
> > > > > On Mon, 2023-11-27 at 17:16 -0500, Paul Moore wrote:
> > > > > > On Mon, Nov 27, 2023 at 12:08=E2=80=AFPM Mimi Zohar <zohar@linu=
x.ibm.com> wrote:
> > > > > > > On Wed, 2023-11-22 at 09:22 -0500, Paul Moore wrote:
> >
> > ...
> >
> > > > > > > Before defining a new critical-data record, we need to decide=
 whether
> > > > > > > it is really necessary or if it is redundant.  If we define a=
 new
> > > > > > > "critical-data" record, can it be defined such that it doesn'=
t require
> > > > > > > pausing extending the measurement list?  For example, a new s=
imple
> > > > > > > visual critical-data record could contain the number of recor=
ds (e.g.
> > > > > > > <securityfs>/ima/runtime_measurements_count) up to that point=
.
> > > > > >
> > > > > > What if the snapshot_aggregate was a hash of the measurement lo=
g
> > > > > > starting with either the boot_aggregate or the latest
> > > > > > snapshot_aggregate and ending on the record before the new
> > > > > > snapshot_aggregate?  The performance impact at snapshot time sh=
ould be
> > > > > > minimal as the hash can be incrementally updated as new records=
 are
> > > > > > added to the measurement list.  While the hash wouldn't capture=
 the
> > > > > > TPM state, it would allow some crude verification when reassemb=
ling
> > > > > > the log.  If one could bear the cost of a TPM signing operation=
, the
> > > > > > log digest could be signed by the TPM.
> > > > >
> > > > > Other critical data is calculated, before calling
> > > > > ima_measure_critical_data(), which adds the record to the measure=
ment
> > > > > list and extends the TPM PCR.
> > > > >
> > > > > Signing the hash shouldn't be an issue if it behaves like other
> > > > > critical data.
> > > > >
> > > > > In addition to the hash, consider including other information in =
the
> > > > > new critical data record (e.g. total number of measurement record=
s, the
> > > > > number of measurements included in the hash, the number of times =
the
> > > > > measurement list was trimmed, etc).
> > > >
> > > > It would be nice if you could provide an explicit list of what you
> > > > would want hashed into a snapshot_aggregate record; the above is
> > > > close, but it is still a little hand-wavy.  I'm just trying to redu=
ce
> > > > the back-n-forth :)
> > >
> > > What is being defined here is the first IMA critical-data record, whi=
ch
> > > really requires some thought.
> >
> > My thinking has always been that taking a hash of the current
> > measurement log up to the snapshot point would be a nice
> > snapshot_aggregate measurement, but I'm not heavily invested in that.
> > To me it is more important that we find something we can all agree on,
> > perhaps reluctantly, so we can move forward with a solution.
> >
> > > For ease of review, this new critical-
> > > data record should be a separate patch set from trimming the
> > > measurement list.
> >
> > I see the two as linked, but if you prefer them as separate then so be
> > it.  Once again, the important part is to move forward with a
> > solution, I'm not overly bothered if it arrives in multiple pieces
> > instead of one.
>
> Trimming the IMA measurement list could be used in conjunction with the n=
ew IMA
> critical data record or independently.  Both options should be supported.
>
> 1. trim N number of records from the head of the in kernel IMA measuremen=
t list
> 2. intermittently include the new IMA critical data record based on some =
trigger
> 3. trim the measurement list up to the (first/last/Nth) IMA critical data=
 record
>
> Since the two features could be used independently of each other, there i=
s no
> reason to upstream them as a single patch set.  It just makes it harder t=
o
> review.

I don't see much point in recording a snapshot aggregate if you aren't
doing a snapshot, but it's not harmful in any way, so sure, go for it.
Like I said earlier, as long as the functionality is there, I don't
think anyone cares too much how it gets into the kernel (although
Tushar and Sush should comment from the perspective).

> > > As I'm sure you're aware, SElinux defines two critical-data records.
> > > From security/selinux/ima.c:
> > >
> > >         ima_measure_critical_data("selinux", "selinux-state",
> > >                                   state_str, strlen(state_str), false=
,
> > >                                   NULL, 0);
> > >
> > >         ima_measure_critical_data("selinux", "selinux-policy-hash",
> > >                                   policy, policy_len, true,
> > >                                   NULL, 0);
> >
> > Yep, but there is far more to this than SELinux.
>
> Only if you conflate the two features.

If that is a clever retort, you'll need to elaborate a bit as it
doesn't make much sense to me.  The IMA measurement log snapshot is
independent from SELinux; the only connection is that yes, IMA does
measure SELinux "things" but that is no different from any other
system attribute that is measured by IMA.

--=20
paul-moore.com

