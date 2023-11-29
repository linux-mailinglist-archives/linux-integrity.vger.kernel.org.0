Return-Path: <linux-integrity+bounces-279-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E937FCC22
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Nov 2023 02:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC49D1C20E69
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Nov 2023 01:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E389E1850;
	Wed, 29 Nov 2023 01:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="afuFnskw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5FF19A7
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 17:07:07 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-db46725a531so4539362276.1
        for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 17:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1701220027; x=1701824827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jkt95eq+DL2Z8DFZ7ILb1n1z4A0zFQ9JGPcyVYsIM9c=;
        b=afuFnskwp69aI8txreRa1N8uxEmhxPu1c7pFpC3afcsUaxwmE1xhJrGgHm+CKJKmqk
         P2GdjESxY4OfPXsS6YEeULJ7i7HAPtwSbucpJ7GxxkW8XMqvt4/MFijHRc3f62WZYTPy
         j4VykxThicXgVtszZ8OBT4v+0W5hgUmDMR5lHxJGha7ioTCNNSx9LOX+eLz7O3Kh6Cmq
         DC8IkNwU1mPcGnBXwE3bU0NncGSSiNMkiecjwxwSsAQrv6mhSaJeuSup4P+SgbHJLGcq
         ERfej/p43UDxrgl4viWG+nUmPpPv9Cd71fRB9JUad7UEnQUuCIh3eEKCWMI9GKokHHQc
         4QxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701220027; x=1701824827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jkt95eq+DL2Z8DFZ7ILb1n1z4A0zFQ9JGPcyVYsIM9c=;
        b=ZQBja1rVpUpm6n18VNA9Mf3vestnZv2PcbqeKdp0eZp0Y//MlHJ9ehjWCD2g//DQ8X
         I8KZJNg6xZU49l+2ZaXOC4uAEhgxp0wZdp/aye4SPEYPovfEcIv5J9LSib2ifRRrI9KU
         cJu54bLxhdK+pMgTuCQQihy7atch0WplDQ9YK76Ogo5SRq3UtW3RQ7WV/y8dx0RRbvQL
         jgtJb1BroRdlbJC0vGqCAL4y4/mVz1TSJ/ZK0x3SlSsPF3aAzqQE5Tq3gAP6j4JJNFWM
         mguu4pwMITtLJkrYHn+gIZ4zKEZ5yIyU55I0z5ZQfUCgmPVOvzS7JRpDPW82k3aeFl/m
         U1Xw==
X-Gm-Message-State: AOJu0Yz+74FcT196A01lgFi3uDICocXnLPvdbNg8hZQjBTghR2WfVmOO
	rNluX56vU5nakSRWhZz70Dd+KTlmlLEQShXuYCaW
X-Google-Smtp-Source: AGHT+IHrFUwjcNVag5pJZmje3+cQULqNQmC5OGUeW1j6G1Cih5a/XEsyDtGSL2dYDowlJ5/Nt6bZHxk+vLu+BQ5qDoY=
X-Received: by 2002:a25:ab8b:0:b0:d9a:c4cf:a066 with SMTP id
 v11-20020a25ab8b000000b00d9ac4cfa066mr17983616ybi.34.1701220027096; Tue, 28
 Nov 2023 17:07:07 -0800 (PST)
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
 <CAHC9VhTykrsXTuWfRe3rzg2SMbzynvgwXmxVpN5T0cfY7YrkwA@mail.gmail.com> <d5e2358a0a7aaf4455b1f479483b312e98aa07d5.camel@linux.ibm.com>
In-Reply-To: <d5e2358a0a7aaf4455b1f479483b312e98aa07d5.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Nov 2023 20:06:56 -0500
Message-ID: <CAHC9VhRNLzbW++rW3Hep+3yyJZRRvZ4h7LuKcSbRRn-wqh-PAQ@mail.gmail.com>
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

On Tue, Nov 28, 2023 at 7:09=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Mon, 2023-11-27 at 17:16 -0500, Paul Moore wrote:
> > On Mon, Nov 27, 2023 at 12:08=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.co=
m> wrote:
> > > On Wed, 2023-11-22 at 09:22 -0500, Paul Moore wrote:

...

> > If we are going to have a record count, I imagine it would also be
> > helpful to maintain a securityfs file with the total size (in bytes)
> > of the in-memory measurement log.  In fact, I suspect this will
> > probably be more useful for those who wish to manage the size of the
> > measurement log.
>
> A running number of bytes needed for carrying the measurement list
> across kexec already exists.  This value would be affected when the
> measurement list is trimmed.

There we go, it should be trivial to export that information via securityfs=
.

> > > Defining other IMA securityfs files like
> > > how many times the measurement list has been trimmed might be
> > > beneficial as well.
> >
> > I have no objection to that.  Would a total record count, i.e. a value
> > that doesn't reset on a snapshot event, be more useful here?
>
> <securityfs>/ima/runtime_measurements_count already exports the total
> number of measurement records.

I guess the question is would you want 'runtime_measurements_count' to
reflect the current/trimmed log size or would you want it to reflect
the measurements since the initial cold boot?  Presumably we would
want to add another securityfs file to handle the case not covered by
'runtime_measurements_count'.

> > > Before defining a new critical-data record, we need to decide whether
> > > it is really necessary or if it is redundant.  If we define a new
> > > "critical-data" record, can it be defined such that it doesn't requir=
e
> > > pausing extending the measurement list?  For example, a new simple
> > > visual critical-data record could contain the number of records (e.g.
> > > <securityfs>/ima/runtime_measurements_count) up to that point.
> >
> > What if the snapshot_aggregate was a hash of the measurement log
> > starting with either the boot_aggregate or the latest
> > snapshot_aggregate and ending on the record before the new
> > snapshot_aggregate?  The performance impact at snapshot time should be
> > minimal as the hash can be incrementally updated as new records are
> > added to the measurement list.  While the hash wouldn't capture the
> > TPM state, it would allow some crude verification when reassembling
> > the log.  If one could bear the cost of a TPM signing operation, the
> > log digest could be signed by the TPM.
>
> Other critical data is calculated, before calling
> ima_measure_critical_data(), which adds the record to the measurement
> list and extends the TPM PCR.
>
> Signing the hash shouldn't be an issue if it behaves like other
> critical data.
>
> In addition to the hash, consider including other information in the
> new critical data record (e.g. total number of measurement records, the
> number of measurements included in the hash, the number of times the
> measurement list was trimmed, etc).

It would be nice if you could provide an explicit list of what you
would want hashed into a snapshot_aggregate record; the above is
close, but it is still a little hand-wavy.  I'm just trying to reduce
the back-n-forth :)

--=20
paul-moore.com

