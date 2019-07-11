Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34E7565E86
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jul 2019 19:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbfGKR2U (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Jul 2019 13:28:20 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35092 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbfGKR2Q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Jul 2019 13:28:16 -0400
Received: by mail-io1-f67.google.com with SMTP id m24so14331091ioo.2
        for <linux-integrity@vger.kernel.org>; Thu, 11 Jul 2019 10:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vlOTOKurwzR/la0b/iCejRsNnafnIihAt0zVt5OFE78=;
        b=BaihPN4bmFQ12DBMpDILNYZZCzVbZNCbYwaQW9drSZFi/rNxK3SO3tOShcsqGOQmbW
         SnfGbaFZbEXJ8Ih/5JxO+dNJu7aqvSVUTy/ZUHoOwXj8K6/QjdZT0dzc9W1qMESvbIwf
         9vVQ+4PsFvbopH7FtMIVmop3gj6s2tpQSPjEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vlOTOKurwzR/la0b/iCejRsNnafnIihAt0zVt5OFE78=;
        b=r3fngmUs6peP+OlDD9l2u1UHR+4H98nQqyQYtul8UD2FaZpsdHjhoMSVzPvfMf2vhs
         3Zuhp96nlnXycsMrwc+U5viczI/di/7EWEYdFmg6pBV7P8rdufpD7Y5vmc9HzxQO3kjj
         pAfLCSUjwIQyyF+cx/9u8kr4CVercgTQ4VjqglkQJn09Ppxh2xMTWjcXHLmembjZFYXT
         dMMI7VLm9Hk9I/+PtoFLAyxr1Y+BhtgV2+7lvmcW5QkhqGTHfFR0LHk1FpfjNMwF5IKR
         SeK7JkDf2D4mlEwhowRYv2dxQo+BG3LSKs5VBZmf35DObWEMeSmCzCj8GEqWeFJfRhMc
         lRVA==
X-Gm-Message-State: APjAAAXI2ojwMkpKNjvjQZI86uWyFcn+kS5UU2SLnxHnvS+3IIdbdzg1
        Rvn2KdUqy4e5MJ6kNL6/GOAU2Pjxdzg=
X-Google-Smtp-Source: APXvYqwGYZJRhUw+1mwR6tcVVCzyIvYz6PviCZAHwv3g3TrPFF4TYwK5APl65mudTRqjggJIAxpbQw==
X-Received: by 2002:a6b:4101:: with SMTP id n1mr5914622ioa.138.1562866095464;
        Thu, 11 Jul 2019 10:28:15 -0700 (PDT)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com. [209.85.166.52])
        by smtp.gmail.com with ESMTPSA id b20sm4682721ios.44.2019.07.11.10.28.13
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 10:28:14 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id g20so14220835ioc.12
        for <linux-integrity@vger.kernel.org>; Thu, 11 Jul 2019 10:28:13 -0700 (PDT)
X-Received: by 2002:a6b:5103:: with SMTP id f3mr1553212iob.142.1562866093394;
 Thu, 11 Jul 2019 10:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190711162919.23813-1-dianders@chromium.org> <20190711163915.GD25807@ziepe.ca>
 <20190711170437.GA7544@kroah.com> <20190711171726.GE25807@ziepe.ca> <20190711172630.GA11371@kroah.com>
In-Reply-To: <20190711172630.GA11371@kroah.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 11 Jul 2019 10:28:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U0ue_4FyS7MO+iaKQ5gr0PhuLZaTV1adPY3ZtNhKTmHA@mail.gmail.com>
Message-ID: <CAD=FV=U0ue_4FyS7MO+iaKQ5gr0PhuLZaTV1adPY3ZtNhKTmHA@mail.gmail.com>
Subject: Re: [PATCH] tpm: Fix TPM 1.2 Shutdown sequence to prevent future TPM operations
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, "# 4.0+" <stable@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Vadim Sukhomlinov <sukhomlinov@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Peter Huewe <peterhuewe@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On Thu, Jul 11, 2019 at 10:26 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jul 11, 2019 at 02:17:26PM -0300, Jason Gunthorpe wrote:
> > On Thu, Jul 11, 2019 at 07:04:37PM +0200, Greg KH wrote:
> > > On Thu, Jul 11, 2019 at 01:39:15PM -0300, Jason Gunthorpe wrote:
> > > > On Thu, Jul 11, 2019 at 09:29:19AM -0700, Douglas Anderson wrote:
> > > > > From: Vadim Sukhomlinov <sukhomlinov@google.com>
> > > > >
> > > > > commit db4d8cb9c9f2af71c4d087817160d866ed572cc9 upstream.
> > > > >
> > > > > TPM 2.0 Shutdown involve sending TPM2_Shutdown to TPM chip and disabling
> > > > > future TPM operations. TPM 1.2 behavior was different, future TPM
> > > > > operations weren't disabled, causing rare issues. This patch ensures
> > > > > that future TPM operations are disabled.
> > > > >
> > > > > Fixes: d1bd4a792d39 ("tpm: Issue a TPM2_Shutdown for TPM2 devices.")
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Vadim Sukhomlinov <sukhomlinov@google.com>
> > > > > [dianders: resolved merge conflicts with mainline]
> > > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > > > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > > > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > > > This is the backport of the patch referenced above to 4.19 as was done
> > > > > in Chrome OS.  See <https://crrev.com/c/1495114> for details.  It
> > > > > presumably applies to some older kernels.  NOTE that the problem
> > > > > itself has existed for a long time, but continuing to backport this
> > > > > exact solution to super old kernels is out of scope for me.  For those
> > > > > truly interested feel free to reference the past discussion [1].
> > > > >
> > > > > Reason for backport: mainline has commit a3fbfae82b4c ("tpm: take TPM
> > > > > chip power gating out of tpm_transmit()") and commit 719b7d81f204
> > > > > ("tpm: introduce tpm_chip_start() and tpm_chip_stop()") and it didn't
> > > > > seem like a good idea to backport 17 patches to avoid the conflict.
> > > >
> > > > Careful with this, you can't backport this to any kernels that don't
> > > > have the sysfs ops locking changes or they will crash in sysfs code.
> > >
> > > And what commit added that?
> >
> > commit 2677ca98ae377517930c183248221f69f771c921
> > Author: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Date:   Sun Nov 4 11:38:27 2018 +0200
> >
> >     tpm: use tpm_try_get_ops() in tpm-sysfs.c.
> >
> >     Use tpm_try_get_ops() in tpm-sysfs.c so that we can consider moving
> >     other decorations (locking, localities, power management for example)
> >     inside it. This direction can be of course taken only after other call
> >     sites for tpm_transmit() have been treated in the same way.
> >
> > The last sentence suggests there are other patches needed too though..
>
> So 5.1.  So does this original patch need to go into the 5.2 and 5.1
> kernels?

The patch ("Fix TPM 1.2 Shutdown sequence to prevent future TPM
operations")?  It's already done.  It just got merge conflicts when
going back to 4.19 which is why I sent the backport.

-Doug
