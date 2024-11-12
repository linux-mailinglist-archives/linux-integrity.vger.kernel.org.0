Return-Path: <linux-integrity+bounces-4085-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9652F9C5F8D
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2024 18:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CA9D2843C7
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2024 17:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F7521442E;
	Tue, 12 Nov 2024 17:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDB78wQY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5721A4F21
	for <linux-integrity@vger.kernel.org>; Tue, 12 Nov 2024 17:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731434182; cv=none; b=pbyRUEhuyUctWbJmasDiPZIyN2XWTcfAmgwznSXUH9UPPf4VGnL6xQ1EPdjocaomwAMo7ATO88enOw6jCBHoS1QnS63LOnyyP05hpt+fJ2PmQNKajltCE2DCyFQy34UMu4/XEG1u9LEXOzpW1cVdH0dNV22oEz/T7ZgqWzxcGE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731434182; c=relaxed/simple;
	bh=mQonvFTOh2oSyHh2g4U98WYNpDGOrn7497n17hS8Dmk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=K4JHzzAhxVA9appVEWZPaQjK5UONve9hOC8MK3RN3b7Mponm5HwV8RpEO5wo0kd+JM1kvDjVSPl34Ex2VaYshsv69HTEOWsuDfEp05s8CgYm0M7LgqboX2rLC01M78n5y5xwE3jurrZv1J0kdOl9DENmCFzwrba/EcdhrvBIvn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDB78wQY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A36C4CECD;
	Tue, 12 Nov 2024 17:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731434182;
	bh=mQonvFTOh2oSyHh2g4U98WYNpDGOrn7497n17hS8Dmk=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=nDB78wQYBsSYNHbUDXCWbo+dObpPJAdlb06C5O3i+85HeXeS9DYDTOLcyTTFYiGls
	 MUOtodmqMQ7urFnDu+feXb+Oyn0jqjNaXjPgEBKft559NQX0iZE3xM/s1Pf3QQebTH
	 eoxBzWXorkecYgk7P4lAPX2RJx2FczRwAojKhz6E+/cPjGzPldUUCB8/hnouhh48jJ
	 nvU9qRZzEGuHcjZ3Tg3hssxsGys6uHlqlzh+tccOex8XnQW1J6dgqdOGYgsTrFAt+X
	 1kc75Cg+6WfBi9it2/zDqbx7wi8Ijpb2+77XkJxt58xF94WqbWGA8c524f3tOzObmK
	 IuTCW3+UMUBvQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Nov 2024 19:56:17 +0200
Message-Id: <D5KE6WL7C0ZW.1BRXVU03QDC0C@kernel.org>
Cc: "Stefan Berger" <stefanb@linux.ibm.com>, "Paul Menzel"
 <pmenzel@molgen.mpg.de>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, "Golmitz, Jenifer (Linux Ecosystem
 Engineering)" <jenifer.golmitz@hpe.com>
Subject: Re: [PATCH] tpm/eventlog: Use kvmalloc() for event log buffer
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Liang, Andy (Linux Ecosystem Engineering)" <andy.liang@hpe.com>,
 "Takashi Iwai" <tiwai@suse.de>
X-Mailer: aerc 0.18.2
References: <20241107112054.28448-1-tiwai@suse.de>
 <87f11490-06ab-43a5-8058-102722a3c3ba@molgen.mpg.de>
 <878qtvi5he.wl-tiwai@suse.de>
 <262eff2e-90c5-45db-81d7-30b1cc217ef4@linux.ibm.com>
 <92a9ca13-ead3-41f8-88fd-ab9540c0e9b3@linux.ibm.com>
 <875xoygml3.wl-tiwai@suse.de>
 <PH7PR84MB19575D91A43C2D4C7C842038995D2@PH7PR84MB1957.NAMPRD84.PROD.OUTLOOK.COM> <87o72qf51h.wl-tiwai@suse.de> <PH7PR84MB1957D36D4A45C385E3DF2DFF99582@PH7PR84MB1957.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <PH7PR84MB1957D36D4A45C385E3DF2DFF99582@PH7PR84MB1957.NAMPRD84.PROD.OUTLOOK.COM>

On Mon Nov 11, 2024 at 10:43 AM EET, Andy (Linux Ecosystem Engineering) Lia=
ng wrote:
> > On Fri, 08 Nov 2024 09:48:38 +0100,
> > Liang, Andy (Linux Ecosystem Engineering) wrote:
> > >=20
> > >=20
> > > > On Thu, 07 Nov 2024 20:31:37 +0100,
> > > > Stefan Berger wrote:
> > > > >=20
> > > > >=20
> > > > >=20
> > > > > On 11/7/24 2:06 PM, Stefan Berger wrote:
> > > > > >=20
> > > > > >=20
> > > > > > On 11/7/24 7:38 AM, Takashi Iwai wrote:
> > > > > >> On Thu, 07 Nov 2024 13:17:33 +0100, Paul Menzel wrote:
> > > >>  >>>
> > > >>  >>> Dear Takashi,
> > > >>  >>>
> > > >>  >>>
> > > >>  >>> Thank you for the patch.
> > > >>  >>>
> > > >>  >>> Am 07.11.24 um 12:18 schrieb Takashi Iwai:
> > > >>  >>>> The TPM2 ACPI table may request a large size for the event=
=20
> > > >> log,  >>>> and it may be over the max size of kmalloc().=C2=A0 Whe=
n this=20
> > > >> happens,  >>>> the driver  >>>  >>> What is kmalloc()=E2=80=99s ma=
ximum=20
> > > >> size?
> > > >>  >>
> > > >>  >> 128kB or so, IIRC.
> > > >>  >> And according Andy, the table can be over 4MB.
> > > >>  >
> > > >>  > Can you copy the contents of the file on that machine and tell=
=20
> > > >> us  > what size it has:
> > > >>  >
> > > >>  > cp /sys/kernel/security/tpm0/binary_bios_measurements ./
> > > >> =20
> > > >>  Actually, you may need to have the contents parsed by a user spac=
e =20
> > > >> tool since the driver does not detect where the actual end may be:
> > > >> =20
> > > >>   tsseventextend -if ./binary_bios_measurements -sim -v
> > > >> =20
> > > >>  This may give you a feeling for how much is in that file and then=
 =20
> > > >> you'd have to truncate it into half for example and see whether it=
 =20
> > > >> still parses the same. My point is that we haven't seen such =20
> > > >> excessive-sized logs so far and following the parsing above we may=
 =20
> > > >> find something like this more useful than allocating possibly larg=
e =20
> > > >> amounts of memory that a buggy ACPI table indicates (+ notify
> > > >> manufacturer):
> > > >> =20
> > > >>    if (len > MAX_TPM_LOG_SIZE) {
> > > >>        dev_err(&chip->dev, "Truncated excessive-sized TPM log of %=
d =20
> > > >> bytes\n", len);
> > > >>       len =3D MAX_TPM_LOG_SIZE;
> > > >>    }
> > > >> =20
> > > >>  If you send me the log I'd look at it.
> > >=20
> > > > It's rather a question Andy; could you check give the requested inf=
o?
> > >=20
> > >=20
> > > https://elixir.bootlin.com/linux/v6.8/source/arch/x86/include/asm/pag=
e
> > > _types.h#L10
> > > #define PAGE_SHIFT 12
> > > #define KMALLOC_SHIFT_MAX (MAX_PAGE_ORDER + PAGE_SHIFT)
> > > =20
> > > https://elixir.bootlin.com/linux/v6.8/source/include/linux/mmzone.h#L=
3
> > > 0
> > > #define MAX_PAGE_ORDER 10
> > > =20
> > > https://elixir.bootlin.com/linux/v6.8/source/include/linux/slab.h#L30=
9
> > > #define KMALLOC_MAX_SIZE (1UL << KMALLOC_SHIFT_MAX) The max size  =3D=
=20
> > > (1UL <<  MAX_PAGE_ORDER + PAGE_SHIFT) =3D ( 1UL << (10 + 12)) =3D 2^2=
2=20
> > > =3D4,194,304 (4MB)
> > >=20
> > > For the x86, the max size is 4MB.=20
> >
> > Thanks, it was already corrected by Jarkko :) But what I meant was abou=
t the requests:
> >
> > > cp /sys/kernel/security/tpm0/binary_bios_measurements ./
> >
> > and
> >
> > >   tsseventextend -if ./binary_bios_measurements -sim -v
> >
> > mentioned in the above.  Could you provide the info?
>
> Please check the attached file. The file has also been uploaded to the SU=
SE Bugzilla.
> Thank you.

Please create a bug to kernel bugzilla and attach the file on that.

BR, Jarkko

