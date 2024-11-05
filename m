Return-Path: <linux-integrity+bounces-4024-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C40D09BD242
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Nov 2024 17:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 887D32814DB
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Nov 2024 16:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222BC1D417C;
	Tue,  5 Nov 2024 16:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q65m6nwA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE932762D2;
	Tue,  5 Nov 2024 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730823908; cv=none; b=LmtlywK3bvBYKSAMFWUZCs3Ghzw8tlpZN04Qbhi3Uj5WvlU7iigaTnizPviuX16sXIiUHoFcTY6OszfoHDmxH6j2P8f/5oONuiB/AbhiVvk+gI8MtQFoZsOdUjWqO7h+OdN8F2UQsN2HHVOQOSa/cvwOQ9u6/rK2ORazsaYCAuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730823908; c=relaxed/simple;
	bh=X6hnPBQt+8HTgI3uJRzEl3eK39nOSFWfaoz4yYn3PcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zvx9OtM9MWOxA68hzJIT03o8rZT9u5IcF7CfL8m3+2uF6xpZU9N6tyOtfsS55Seh+Pne5gRv2Fk9QLGu7GyxJhDIkbkAJfUWCnyRWklKdo0Ly/pe5qm2KdOxdCd2tcpwIQ64fx4Y22YqIt74LZQ8VWyh2e1ZAijNmOMb+asUF08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q65m6nwA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B047C4CECF;
	Tue,  5 Nov 2024 16:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730823907;
	bh=X6hnPBQt+8HTgI3uJRzEl3eK39nOSFWfaoz4yYn3PcE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=q65m6nwAhT2ctJcDcMmKExKTcdaQa/F4wMTiHJkiyxYe9CHnY3Q7Yghwv1KnMLvCb
	 vkapIXB8/EbLpJflfFBCUHtwT8519uBht7kUH+01e+Q40+wbuJ7w7sesJBqi/ynzCf
	 BUE0nfTjYD7zAKhLUa8b5dXQuc2U4G83MF2vZhA+KINbgEnWkN2j0FcLTgt3QlBTKR
	 T42C+Ad5QOmnPW8w2HXx2M0tNdxjK/dWaC8TTSEa5UvzvPNGMh8evLFr0HIHn2LBBQ
	 sdWXWGZJZMbSTsrTbYQFukn+c9/XcrSKXIeWNYnT3eOyIna79KgEhgzZ8ZKDH/qDL6
	 5SgUJ0n0Og7eg==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb599aac99so48867141fa.1;
        Tue, 05 Nov 2024 08:25:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVlg9iZdPig4nTy58nYJ1akIK/8GXjXoxDIehkuOPWRwK/QRGT1VFSv+JU+EA/fRGR52O6FtgQ6vvGumILfPVE=@vger.kernel.org, AJvYcCX59IZQMZrVe9dDiVs8UFU+g7XT6XyNAI7JIjtNkRNwuot+6rGqb1ynMFI/hcqZsIQjlARQyFhxpgfz0agG@vger.kernel.org
X-Gm-Message-State: AOJu0YyWwxDFNcDhYxBcco9XfoX5Jv4qCx0NGWpNn5lyOGQolbKGZhDJ
	6gFqPqfdiwccRaXU6YDy4p4k+Tyf7js4suc1IbCh8Q9NTiWRkV8VR3qb4F/a0uGfwvz4kp4FVD/
	bWtiyvRhjkPnQKnBLrNEvKf/SpV8=
X-Google-Smtp-Source: AGHT+IGJo6o9pe1aLrExbhfH3DXR7QWPhzL0NEgcJSdIPQfVgkOLnH6NNTX5qS4aLm+8OGhFyJLqs3a6l+Bizrd09Is=
X-Received: by 2002:a05:651c:b13:b0:2fc:9622:794b with SMTP id
 38308e7fff4ca-2fedb7ce02emr76218921fa.24.1730823906003; Tue, 05 Nov 2024
 08:25:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241102152226.2593598-1-jarkko@kernel.org> <7412e1e0-0e28-41a6-a4aa-a3fc97d36468@oracle.com>
In-Reply-To: <7412e1e0-0e28-41a6-a4aa-a3fc97d36468@oracle.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 5 Nov 2024 17:24:54 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGwwLycnUdEXJ0kobYYgNxNMxDZJf+aqYQZdXgB5hhLyw@mail.gmail.com>
Message-ID: <CAMj1kXGwwLycnUdEXJ0kobYYgNxNMxDZJf+aqYQZdXgB5hhLyw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Alternative TPM patches for Trenchboot
To: ross.philipson@oracle.com
Cc: Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org, 
	"Daniel P. Smith" <dpsmith@apertussolutions.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	"open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Nov 2024 at 01:52, <ross.philipson@oracle.com> wrote:
>
> On 11/2/24 8:22 AM, Jarkko Sakkinen wrote:
> > This is my alternative patch set to the TPM patches included into
> > Trenchboot series v11. I don't mind to which tree these are
> > picked in the end. All the patches also have my sob's, so in that
> > sense things are also cleared up.
> >
> > At least slmodule needs to be patched in the series given that
> > tpm_chip_set_locality() returns zero on success.
> >
> > It is not really my problem but I'm also wondering how the
> > initialization order is managed. What if e.g. IMA happens to
> > initialize before slmodule?
> >
> > Cc: Daniel P. Smith <dpsmith@apertussolutions.com>
> > Cc: Ross Philipson <ross.philipson@oracle.com>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> >
> > Daniel P. Smith (2):
> >    tpm, tpm_tis: Close all localities
> >    tpm, tpm_tis: Address positive localities in
> >      tpm_tis_request_locality()
> >
> > Ross Philipson (2):
> >    tpm, tpm_tis: allow to set locality to a different value
> >    tpm: sysfs: Show locality used by kernel
> >
> >   drivers/char/tpm/tpm-chip.c     | 33 ++++++++++++++++++++++++++++++++-
> >   drivers/char/tpm/tpm-sysfs.c    | 10 ++++++++++
> >   drivers/char/tpm/tpm_tis_core.c | 18 ++++++++++++++++--
> >   include/linux/tpm.h             | 10 ++++++++++
> >   4 files changed, 68 insertions(+), 3 deletions(-)
> >
>
> Jarkko,
>
> We have tested with this latest RFC patch set and it does what we need.
> Things also functioned correctly when we closed down the TXT DRTM and
> brought up a follow on kernel with kexec. So we are good with dropping
> our TPM patches and adopting these. The last question is do you want to
> take these in directly as a standalone patch set or do you want us to
> submit them with our next patch set (v12)?
>
> And for what it is worth if you want it:
>
> Tested-by: Ross Philipson <ross.philipson@oracle.com>
>

If the patches as proposed work for you, please incorporate them into your v12.

