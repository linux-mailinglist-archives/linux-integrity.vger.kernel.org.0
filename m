Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A9C3A5D9E
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Jun 2021 09:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbhFNHYY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Jun 2021 03:24:24 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:40841 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbhFNHYX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Jun 2021 03:24:23 -0400
Received: by mail-lf1-f53.google.com with SMTP id k40so19418193lfv.7
        for <linux-integrity@vger.kernel.org>; Mon, 14 Jun 2021 00:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5jRGcJHTiG11neoPHXUv36GnpvlTeRnUszQDb6yQd7o=;
        b=bgtvZq4zv7MwlB4Sryfox6og15pTfRc5ZDO8AQ+3IuzoLGNa3Mb96UIlb8kDoC0GU6
         O/2LnLlz0s30Pdse44EOriQkIkHFnYo/pcETCkBkH/RWCMmvAQnP0mFSs/XMvI/75Qc2
         XkMT0mqwH6lOvvO/kzqG/tRpdbUE+xzp3NqV3C9bhtEK0kOqwRGtbKn9DJy4G46o9N5P
         UBoJKiFux8RcyLdjYhLXHDCGdRPPdMmezpf5zgoNiM6kq/akmIQxXteXo7ClTUMRb7Gu
         6rcduJwVvZK0vNhbH0llqwT72tyqqCZRr689LmXffHlFlbHfE+5qtTaUG1PqDs8R3oou
         +Rpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5jRGcJHTiG11neoPHXUv36GnpvlTeRnUszQDb6yQd7o=;
        b=mmyAgbNSu5LSu/581viuQrYV/mEsTUiTeYB/gJtS2/cxvgb6XlurGvNthcaD7s6Nf6
         E0pzznG7GKupDEmQxbtovItq2KZxvUshN4DhZT4JTs7eFe0vjHuTe5ZPVJBflUO7HfCd
         hCbrKdp2NnTvDko0SXl2MDgevhG9SUf1hxGhzQiJ7abAzuO/CzSwHWI9RPDgyrmhEbPO
         Aidxrvj7OI62dAYQImTpSuxIf1a2HYqGSOO25I2/3iLF0fttYSyY0nWDZyGeYiGNGUsJ
         aWFAyp+gg8M1U+drOrrb8ugZvvJVf2TF4If/JYNbVpbVdugnKnzeHaj01xWKjxaJQY9J
         lLNw==
X-Gm-Message-State: AOAM531oMOtL2cNWZfIUfmcr+Lq0Msq64ARu8uu7lqMez0qWOAWP905F
        T0UkCbNFVum3kNWfILFVsZJOlg==
X-Google-Smtp-Source: ABdhPJxl3I0HAdphRK+J8BXDpJEi7jxjV4hz1J7QYraHABDZ8YrDz/GroBgSVJ8bYaYf0pSIZIM/gg==
X-Received: by 2002:a05:6512:3f17:: with SMTP id y23mr10687281lfa.412.1623655269462;
        Mon, 14 Jun 2021 00:21:09 -0700 (PDT)
Received: from jade (h-79-136-85-3.A175.priv.bahnhof.se. [79.136.85.3])
        by smtp.gmail.com with ESMTPSA id o14sm1388113lfi.193.2021.06.14.00.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 00:21:09 -0700 (PDT)
Date:   Mon, 14 Jun 2021 09:21:07 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Allen Pais <apais@linux.microsoft.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/8] optee: fix tee out of memory failure seen during
 kexec reboot
Message-ID: <20210614072107.GA1033436@jade>
References: <20210610210913.536081-1-tyhicks@linux.microsoft.com>
 <20210610210913.536081-4-tyhicks@linux.microsoft.com>
 <CAHUa44H=vJrkYYTb2T8WPfy6TznQyO8a8wnLCbJUuSE8QO4iuw@mail.gmail.com>
 <20210611125326.GQ4910@sequoia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210611125326.GQ4910@sequoia>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 11, 2021 at 07:53:26AM -0500, Tyler Hicks wrote:
> On 2021-06-11 11:11:33, Jens Wiklander wrote:
> > On Thu, Jun 10, 2021 at 11:09 PM Tyler Hicks
> > <tyhicks@linux.microsoft.com> wrote:
> > >
> > > From: Allen Pais <apais@linux.microsoft.com>
> > >
> > > The following out of memory errors are seen on kexec reboot
> > > from the optee core.
> > >
> > > [    0.368428] tee_bnxt_fw optee-clnt0: tee_shm_alloc failed
> > > [    0.368461] tee_bnxt_fw: probe of optee-clnt0 failed with error -22
> > >
> > > tee_shm_release() is not invoked on dma shm buffer.
> > >
> > > Implement .shutdown() method to handle the release of the buffers
> > > correctly.
> > >
> > > More info:
> > > https://github.com/OP-TEE/optee_os/issues/3637
> > >
> > > Signed-off-by: Allen Pais <apais@linux.microsoft.com>
> > > Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > 
> > Do we really need this considering the patch "optee: Refuse to load
> > the driver under the kdump kernel"?
> 
> Yes. That patch fixes boot hangs when all of the OP-TEE threads were in
> the suspended state at the time of a kernel panic. The kexec into the
> kdump kernel after a panic is an "emergency" kexec that doesn't even
> call .shutdown hooks. There's no way for the OP-TEE driver to clean up
> after itself.
> 
> This patch disables the shm cache (and unregisters the shm buffers)
> during a normal kexec from one perfectly working kernel into a new
> kernel. This is required because the new kernel will not be able to
> handle the virtual addresses that were cached under the old kernel. The
> new kernel has an entirely different memory layout and the old addresses
> point to unmapped memory or memory that's mapped but probably not a TEE
> shm.

Got it, thanks.

Jens
