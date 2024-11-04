Return-Path: <linux-integrity+bounces-4013-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D46619BB3EF
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2024 12:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D441C20C4F
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2024 11:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2591B392C;
	Mon,  4 Nov 2024 11:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9TchSO2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D334430;
	Mon,  4 Nov 2024 11:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730721331; cv=none; b=YjfoZOMiCv6LshEzXVjHXE4CsoJfwYMKo+Z2vbRbYHagu1QXVJQFj8hYMv1/nCFqp/tbUYxi0nNSBxwKb8G3t4zO6JNcPbsLqIyfvCJVtFq54Wj9P+51I/ZOETNosQuMtMxWp7y6O8VamCFbEtpYM40W+6F7xOI8xxM3MIWxbbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730721331; c=relaxed/simple;
	bh=dSvQG2gdzCgovIp1SHu/ZXST84or/Z8UQImA0c+6RSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PT0UjWBaVOUZVBo1/VO5FIrFyHYMAMGdx9Fbzv/rdM3v2HbOWkQHCIHTZtQ3BKgXDxMzQXiAHe39hMTT6l6fkL3kmI0AmZpYSdL3QqxiP8WfxIfY6LoDVDujlruhFVOQvz6mN7Gimczc53sluqKkZfXxc9LxbSw2OiKRLhbavYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9TchSO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F169EC4CED7;
	Mon,  4 Nov 2024 11:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730721331;
	bh=dSvQG2gdzCgovIp1SHu/ZXST84or/Z8UQImA0c+6RSo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Z9TchSO2UHJQ3yUH/sJK/2qP6ZVzbwA/1OacZC0bMtWpsuVBJR7yHmXDUakGq1Bmd
	 yLdot0+LveoyHfLKN7Zw0oBw4wqKf7Vx79Qj12nJ2r77BboJjhTDBtqG7PEM8tcPhI
	 Xthuq5LsnRja3j4s4hH1uKlOVSjJ5jOc6CYsCC0q1ZTmvEItuN9+CKGhgIOGOhTP1m
	 6ysmw2utTZi7WIWhIRmFM17BcihOdkW2uOkgauimFBI0wNnCsFTKPeh9K/McQNnKY4
	 sHf6Mme91LQAVp9GZZFw+8SnC4wBNoxbHMKttMUC+gwQVORoanEpqZLM0uv9dFBbu1
	 7y0H5uyErPDkg==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb599aac99so34205381fa.1;
        Mon, 04 Nov 2024 03:55:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWY2ADCYQi/TCNwdGpgaKKMjmayg515V/PolJh1qIpBpObW5PEZhSUCgJU7n9t7RH2qPH1e7mH7442QHVi4@vger.kernel.org, AJvYcCXS+FeD8L8h7D0S3JYrdtWDYeMUraM45HoeP08AeUM6GTe4c8FaCHW4fIsauEIgL4szWyzS6YVDz13HqlNtIDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJThTWMr/dXv91taPdp46qFwHTz+J6hg0/SMkcWtH3ojL81a4+
	dATXDlWHdT/2wDB1b5KR5vLbXSR/imq8RJPjlIXXLzg7vt/YTyWN8eZIoxOSiKRC0Dt1KVjyzWw
	y08usoJykARmh5agetUehtp4Sz+0=
X-Google-Smtp-Source: AGHT+IGrVfNMKT4eiJ9enlaTFPJYd4xEefhHhklhSnDylaakCVK1O+Ad9dgJHMb5IsefHr8JaEq26sQU7EDdMqX4g54=
X-Received: by 2002:a2e:b8c5:0:b0:2fc:9afe:1157 with SMTP id
 38308e7fff4ca-2fedb794dc0mr51085401fa.2.1730721329211; Mon, 04 Nov 2024
 03:55:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241102152226.2593598-1-jarkko@kernel.org> <D5BW0P0HH0QL.7Y4HBLJGEDL8@kernel.org>
 <e745226d-4722-43ed-86ad-89428f56fcba@apertussolutions.com>
 <D5DCPWBQ2M7H.GAUEVUKGC3G0@kernel.org> <CAMj1kXGd5KAXiFr3rEq3cQK=_970b=eRT4X6YKVSj2PhN6ACrw@mail.gmail.com>
 <97d4e1a0-d86e-48a9-ad31-7e53d6885a96@apertussolutions.com>
In-Reply-To: <97d4e1a0-d86e-48a9-ad31-7e53d6885a96@apertussolutions.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 4 Nov 2024 12:55:17 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFEJYVs7p6QLEAU-T+xfoWhkFi=PE9QpJ4Oo4oh3eM38Q@mail.gmail.com>
Message-ID: <CAMj1kXFEJYVs7p6QLEAU-T+xfoWhkFi=PE9QpJ4Oo4oh3eM38Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Alternative TPM patches for Trenchboot
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org, 
	Ross Philipson <ross.philipson@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	"open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Nov 2024 at 12:52, Daniel P. Smith
<dpsmith@apertussolutions.com> wrote:
>
> On 11/4/24 06:27, Ard Biesheuvel wrote:
> > On Mon, 4 Nov 2024 at 12:18, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >>
> >> On Mon Nov 4, 2024 at 12:57 PM EET, Daniel P. Smith wrote:
> >>> On 11/2/24 14:00, Jarkko Sakkinen wrote:
> >>>> On Sat Nov 2, 2024 at 5:22 PM EET, Jarkko Sakkinen wrote:
> >>>>> It is not really my problem but I'm also wondering how the
> >>>>> initialization order is managed. What if e.g. IMA happens to
> >>>>> initialize before slmodule?
> >>>>
> >>>> The first obvious observation from Trenchboot implementation is that it
> >>>> is 9/10 times worst idea ever to have splitted root of trust. Here it
> >>>> is realized by an LKM for slmodule.
> >>>
> >>> First, there is no conflict between IMA and slmodule. With your change
> >>> to make locality switching a one shot, the only issue would be if IMA
> >>> were to run first and issue a locality switch to Locality 0, thus
> >>> blocking slmodule from switching to Locality 2. As for PCR usage, IMA
> >>> uses the SRTM PCRs, which are completely accessible under Locality 2.
> >>
> >> Just pointing out a possible problem (e.g. with  TPM2_PolicyLocality).
> >>
> >>> Honestly, a better path forward would be to revisit the issue that is
> >>> driving most of that logic existing, which is the lack of a TPM
> >>> interface code in the setup kernel. As a reminder, this issue is due to
> >>> the TPM maintainers position that the only TPM code in the kernel can be
> >>> the mainline driver. Which, unless something has changed, is impossible
> >>> to compile into the setup kernel due to its use of mainline kernel
> >>> constructs not present in the setup kernel.
> >>
> >> I don't categorically reject adding some code to early setup. We have
> >> some shared code EFI stub but you have to explain your changes
> >> proeprly. Getting rejection in some early version to some approach,
> >> and being still pissed about that years forward is not really way
> >> to go IMHO.
> >>
> >
> > Daniel has been nothing but courteous and patient, and you've waited
> > 11 revision to come up with some bikeshedding patches that don't
> > materially improve anything.
> >
> > So commenting on Daniel's approach here is uncalled for.
> >
> > Can we please converge on this?
> >
> > Daniel - if no component can be built as a module, there should be no
> > reason for the set_default_locality() hook to be exported to modules
> > right? And do we even need a sysfs node to expose this information?
>
> Hi Ard,
>
> The only reason off the top of my head of why it was exported was to
> support the fact that the tpm module itself could be built as a module,
> not that we were looking for it to be done so.
>

But the inclusion of the secure launch module will force the TPM
module to be builtin too, surely.

> As to sysfs, there is the TXT register content that we would like to
> have exposed, and they should be readonly. For context to contrast with,
> tboot user space utility txt-stat worked by trying to read the TXT
> register address space via /dev/mem, think enough is said there. The
> other purpose we used sysfs was management of the DRTM log. We used it
> to provide a means to ensure the DRTM eventlog is extended when
> measurements are sent to the DRTM PCRs and then to be able to retrieve
> the final log.
>

I was referring specifically to the read-write sysfs node that permits
user space to update the default TPM locality. Does it need to be
writable? And does it need to exist at all?

