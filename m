Return-Path: <linux-integrity+bounces-674-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C26A1826268
	for <lists+linux-integrity@lfdr.de>; Sun,  7 Jan 2024 00:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BC8F1F21E8A
	for <lists+linux-integrity@lfdr.de>; Sat,  6 Jan 2024 23:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614DB101FE;
	Sat,  6 Jan 2024 23:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KIW3rSf9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D049F101E9
	for <linux-integrity@vger.kernel.org>; Sat,  6 Jan 2024 23:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bbd1fab171so691936b6e.1
        for <linux-integrity@vger.kernel.org>; Sat, 06 Jan 2024 15:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1704583684; x=1705188484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9JaYs/iBuW3+vvOlsyG26SMcgbIMGOxrh4TLTzxUyo=;
        b=KIW3rSf9v23RDhHEgcJwUd6INwA2QDjdOrL22ureyu/UGKd41Tmlxn+rEvHo9kn+eV
         0SUuRhIm0Z00bU5QKVoz/euesYlpjcrtNkPoDrppkAiHIeaFc3P/TX91IvC5Y63j7I3l
         Own/OnOuklNCtWZ7GzqdAGyPfnKvA+Zw+kqCpC+o9bQWnJAb1H5LSCHn5M/+0rMzVLg2
         yd8OJmQMyvrlVHeHLXUFPFGslcDJTT3qqc8aIn9Pqxn8pl/IGeJN3u6FgCw6aVXU44A8
         T9EEF0yBg2Ia4Y4i2CakE/oT/wTH32jviEGrgFbeFs3itXg9PSW5FGwkGWKxH+4QjEj/
         xWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704583684; x=1705188484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9JaYs/iBuW3+vvOlsyG26SMcgbIMGOxrh4TLTzxUyo=;
        b=Cf3Z0L3tnxrYo9kZu2M2er+M7n9L8teRPf/OYdA7XPfznGpVQFkggD/TLcdwj8Iena
         /qSYwxeabz/XCc3T/dnHkdEWEwleSWshC53+LJawoxZ111SjLjeoMPfN1/lalSahsUkJ
         RTEk7Fvnn9aYRa7N1ccjDfHVLAtgSy/Erbdd6NYoIAL1kuVPnv1BaPPzjzadAluTEwmL
         hyWdSpbj6RPKc/VanX5HL1TyglUI9YnkJs08J3ataTbMVVMLackiUHrG5vfRmsTpYqKf
         gdtxMoEe0diyv79QywoKTdHlTKGP0S+OFgNVJe3akT7l7sZc7jN48dIxJ3TV2STi49aZ
         ZxZw==
X-Gm-Message-State: AOJu0YyYCCpDP7MnX55VmGy3zdIRVIlsxnswJyQvAmvn5cplA3Z8UiP4
	A3Cwel0fUgRG3SHH/CZ7cz4WmNoEEGaT3aYmzhxOdO0jQcEu
X-Google-Smtp-Source: AGHT+IE8SjipfKR+0SQZ9dpU9mjuiSISCRe1xTExjHHcaZCgkam8SzLVmGJ2K6giadt5HwjBOBvSvjl3a5cJdDtmNdE=
X-Received: by 2002:a54:440a:0:b0:3bb:be11:c1a6 with SMTP id
 k10-20020a54440a000000b003bbbe11c1a6mr1078693oiw.104.1704583683794; Sat, 06
 Jan 2024 15:28:03 -0800 (PST)
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
 <CAHC9VhRNLzbW++rW3Hep+3yyJZRRvZ4h7LuKcSbRRn-wqh-PAQ@mail.gmail.com> <d9975a7949ca49f404adc981e942f42b6f19d022.camel@linux.ibm.com>
In-Reply-To: <d9975a7949ca49f404adc981e942f42b6f19d022.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 6 Jan 2024 18:27:52 -0500
Message-ID: <CAHC9VhRd5Qi_NZJMOfHC6jTr_dn0mNFGhy18ff2YgtjQo+38dQ@mail.gmail.com>
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

On Tue, Nov 28, 2023 at 9:07=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Tue, 2023-11-28 at 20:06 -0500, Paul Moore wrote:
> > On Tue, Nov 28, 2023 at 7:09=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com=
> wrote:
> > > On Mon, 2023-11-27 at 17:16 -0500, Paul Moore wrote:
> > > > On Mon, Nov 27, 2023 at 12:08=E2=80=AFPM Mimi Zohar <zohar@linux.ib=
m.com> wrote:
> > > > > On Wed, 2023-11-22 at 09:22 -0500, Paul Moore wrote:

...

> > > > > Before defining a new critical-data record, we need to decide whe=
ther
> > > > > it is really necessary or if it is redundant.  If we define a new
> > > > > "critical-data" record, can it be defined such that it doesn't re=
quire
> > > > > pausing extending the measurement list?  For example, a new simpl=
e
> > > > > visual critical-data record could contain the number of records (=
e.g.
> > > > > <securityfs>/ima/runtime_measurements_count) up to that point.
> > > >
> > > > What if the snapshot_aggregate was a hash of the measurement log
> > > > starting with either the boot_aggregate or the latest
> > > > snapshot_aggregate and ending on the record before the new
> > > > snapshot_aggregate?  The performance impact at snapshot time should=
 be
> > > > minimal as the hash can be incrementally updated as new records are
> > > > added to the measurement list.  While the hash wouldn't capture the
> > > > TPM state, it would allow some crude verification when reassembling
> > > > the log.  If one could bear the cost of a TPM signing operation, th=
e
> > > > log digest could be signed by the TPM.
> > >
> > > Other critical data is calculated, before calling
> > > ima_measure_critical_data(), which adds the record to the measurement
> > > list and extends the TPM PCR.
> > >
> > > Signing the hash shouldn't be an issue if it behaves like other
> > > critical data.
> > >
> > > In addition to the hash, consider including other information in the
> > > new critical data record (e.g. total number of measurement records, t=
he
> > > number of measurements included in the hash, the number of times the
> > > measurement list was trimmed, etc).
> >
> > It would be nice if you could provide an explicit list of what you
> > would want hashed into a snapshot_aggregate record; the above is
> > close, but it is still a little hand-wavy.  I'm just trying to reduce
> > the back-n-forth :)
>
> What is being defined here is the first IMA critical-data record, which
> really requires some thought.

My thinking has always been that taking a hash of the current
measurement log up to the snapshot point would be a nice
snapshot_aggregate measurement, but I'm not heavily invested in that.
To me it is more important that we find something we can all agree on,
perhaps reluctantly, so we can move forward with a solution.

> For ease of review, this new critical-
> data record should be a separate patch set from trimming the
> measurement list.

I see the two as linked, but if you prefer them as separate then so be
it.  Once again, the important part is to move forward with a
solution, I'm not overly bothered if it arrives in multiple pieces
instead of one.

> As I'm sure you're aware, SElinux defines two critical-data records.
> From security/selinux/ima.c:
>
>         ima_measure_critical_data("selinux", "selinux-state",
>                                   state_str, strlen(state_str), false,
>                                   NULL, 0);
>
>         ima_measure_critical_data("selinux", "selinux-policy-hash",
>                                   policy, policy_len, true,
>                                   NULL, 0);

Yep, but there is far more to this than SELinux.

--=20
paul-moore.com

