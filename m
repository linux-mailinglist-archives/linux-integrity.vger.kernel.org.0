Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBEB3A426E
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Jun 2021 14:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhFKMz1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Jun 2021 08:55:27 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38666 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhFKMz1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Jun 2021 08:55:27 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1E38A20B7178;
        Fri, 11 Jun 2021 05:53:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1E38A20B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1623416009;
        bh=/cTsy8OGaEU/zCQc9L/8YrQzHcLViQBgidbXiYXlsFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g5OiGVB4m3mJcPxTG/Y/h4H/AIbequvqN042kTAxfzpbO/RnN+S9jdNuq7YXQf3SS
         cGp+pUj2THgiOumGn+Mf2YQ+kUp7ONyzL8mvLHKelSMNmh68wcE4E1CXBSupnVDbVZ
         SpvH/9rwBxHKKlNq5zxb+ZTeGAEod6vShaKQYbdU=
Date:   Fri, 11 Jun 2021 07:53:26 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
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
Message-ID: <20210611125326.GQ4910@sequoia>
References: <20210610210913.536081-1-tyhicks@linux.microsoft.com>
 <20210610210913.536081-4-tyhicks@linux.microsoft.com>
 <CAHUa44H=vJrkYYTb2T8WPfy6TznQyO8a8wnLCbJUuSE8QO4iuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHUa44H=vJrkYYTb2T8WPfy6TznQyO8a8wnLCbJUuSE8QO4iuw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2021-06-11 11:11:33, Jens Wiklander wrote:
> On Thu, Jun 10, 2021 at 11:09 PM Tyler Hicks
> <tyhicks@linux.microsoft.com> wrote:
> >
> > From: Allen Pais <apais@linux.microsoft.com>
> >
> > The following out of memory errors are seen on kexec reboot
> > from the optee core.
> >
> > [    0.368428] tee_bnxt_fw optee-clnt0: tee_shm_alloc failed
> > [    0.368461] tee_bnxt_fw: probe of optee-clnt0 failed with error -22
> >
> > tee_shm_release() is not invoked on dma shm buffer.
> >
> > Implement .shutdown() method to handle the release of the buffers
> > correctly.
> >
> > More info:
> > https://github.com/OP-TEE/optee_os/issues/3637
> >
> > Signed-off-by: Allen Pais <apais@linux.microsoft.com>
> > Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> 
> Do we really need this considering the patch "optee: Refuse to load
> the driver under the kdump kernel"?

Yes. That patch fixes boot hangs when all of the OP-TEE threads were in
the suspended state at the time of a kernel panic. The kexec into the
kdump kernel after a panic is an "emergency" kexec that doesn't even
call .shutdown hooks. There's no way for the OP-TEE driver to clean up
after itself.

This patch disables the shm cache (and unregisters the shm buffers)
during a normal kexec from one perfectly working kernel into a new
kernel. This is required because the new kernel will not be able to
handle the virtual addresses that were cached under the old kernel. The
new kernel has an entirely different memory layout and the old addresses
point to unmapped memory or memory that's mapped but probably not a TEE
shm.

Tyler

> 
> Jens
> 
