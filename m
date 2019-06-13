Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4214143A67
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Jun 2019 17:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732106AbfFMPVA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jun 2019 11:21:00 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34235 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732104AbfFMPU7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jun 2019 11:20:59 -0400
Received: by mail-io1-f65.google.com with SMTP id k8so17767037iot.1
        for <linux-integrity@vger.kernel.org>; Thu, 13 Jun 2019 08:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+TErb3CYHjqgMEM+qQuKdZ7BSMjcTmOtVmFNFo81SDk=;
        b=a62uOnV1z+blRGCTaI2EKn0Hx0F2gnrv/5aQImnAPlBOPHV2SiuF9FursKNDDBTr3/
         nJcZDrusUGjAIzGIj2fO6uA11hZkfN3Gcqlua8GpYafI/C9tI34BuiOaNuJIYU5tihTe
         hW8CgHNrdUHnaeU7V4ONwP3YN1rzmP29eF8Jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+TErb3CYHjqgMEM+qQuKdZ7BSMjcTmOtVmFNFo81SDk=;
        b=Xq6kMZy5BZwyDNLbNhhQP1sR2nPdBo/gbgUts+P3vSI9w1SFg+DNS3ELmZNCfFyWXB
         Y9b/iWiFVRlrZad+YEB5+o11nnp0DfEFEyPNQhfoIXbJJxOmf1BrhBcEtIOiXm2n/7rI
         aA2CP1S9IWbUkxcRga2UHTik8H8XOr6UykXrz89K3xIPoqi/eE9nuAdVAW+IZ0Hxl1hv
         NxJAZabYbfQDqdFgqOfQh2Mu+3ZYelZvAPtQqFKB+r6SrPLIsGGDOpx8ebb6nx4uwe5G
         wO1SAvQ4+UqbTChQQPLvjws1aMq+4kDw5yNgx3tC7Mh6PPPiocblnyORINBfJFVFaQB4
         hvsA==
X-Gm-Message-State: APjAAAVJ9Arrz72fAiBFvIjOpflS6HISu6+2TPqhvQeGpImPQAdSiyFf
        261JXQz9mSHFGiYcajy7TUKzKLVO+vg=
X-Google-Smtp-Source: APXvYqwTyZVFE55+b5lPF8iHEYmC5tQC9YNjr/CF67cDYtRuAZdl7qIzE/k1cV6z6AuBGJ4WynM7yg==
X-Received: by 2002:a5d:860e:: with SMTP id f14mr8828505iol.242.1560439258393;
        Thu, 13 Jun 2019 08:20:58 -0700 (PDT)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com. [209.85.166.50])
        by smtp.gmail.com with ESMTPSA id z17sm233165iol.73.2019.06.13.08.20.54
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 08:20:54 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id m24so17760298ioo.2
        for <linux-integrity@vger.kernel.org>; Thu, 13 Jun 2019 08:20:54 -0700 (PDT)
X-Received: by 2002:a5e:c241:: with SMTP id w1mr1990359iop.58.1560439253994;
 Thu, 13 Jun 2019 08:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190610220118.5530-1-dianders@chromium.org> <20190612191618.GC3378@linux.intel.com>
 <20190613135858.GB12791@linux.intel.com>
In-Reply-To: <20190613135858.GB12791@linux.intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 13 Jun 2019 08:20:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UoSV9LKOTMuXKRfgFir+7_qPkuhSLN6XJEKPiRPuJJwg@mail.gmail.com>
Message-ID: <CAD=FV=UoSV9LKOTMuXKRfgFir+7_qPkuhSLN6XJEKPiRPuJJwg@mail.gmail.com>
Subject: Re: [PATCH] tpm: Fix TPM 1.2 Shutdown sequence to prevent future TPM operations
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Guenter Roeck <groeck@chromium.org>,
        Vadim Sukhomlinov <sukhomlinov@google.com>,
        apronin@chromium.org, Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Luigi Semenzato <semenzato@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On Thu, Jun 13, 2019 at 6:59 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Wed, Jun 12, 2019 at 10:16:18PM +0300, Jarkko Sakkinen wrote:
> > On Mon, Jun 10, 2019 at 03:01:18PM -0700, Douglas Anderson wrote:
> > > From: Vadim Sukhomlinov <sukhomlinov@google.com>
> > >
> > > TPM 2.0 Shutdown involve sending TPM2_Shutdown to TPM chip and disabling
> > > future TPM operations. TPM 1.2 behavior was different, future TPM
> > > operations weren't disabled, causing rare issues. This patch ensures
> > > that future TPM operations are disabled.
> > >
> > > Signed-off-by: Vadim Sukhomlinov <sukhomlinov@google.com>
> > > [dianders: resolved merge conflicts with mainline]
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >
> > Nice catch. Thank you.
> >
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>
> Applied to my master branch. I also added a fixes tag.
>
> Can you check that it looks legit to you?

Found the patch in your tree at
<http://git.infradead.org/users/jjs/linux-tpmdd.git/commit/41f15a4f02092d531fb34b42a06e9a1603a7df27>.
I'm decidedly a non-expert here, mostly just wrangling a patch that
someone else came up with.  :-)  ...but let's see...

I think you're asking if the "Fixes" looks sane.  I guess it depends
on what you're trying to accomplish.  Certainly what you've tagged in
"Fixes" marks the point where it would be easiest to backport this fix
to.  ...but I think the problem is much older than that patch.

As I understand it, this problem has existed for much longer.  I
believe that ${SUBJECT} patch evolved from an investigation that Luigi
Semenzato did back in 2013 when we got back some Chromebooks whose
TPMs claimed that they had been "attacked".  Said another way, I
believe it is an evolution of the patch <https://crrev.com/c/57988>
("CHROMIUM: workaround for Infineon TPM broken defensive timeout").

...so technically someone ought to want this on all old kernels.
Maybe keep the "Cc: stable" but remove the "Fixes"?


-Doug
