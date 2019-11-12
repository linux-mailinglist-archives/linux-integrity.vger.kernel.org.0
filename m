Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D05EF9AA6
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2019 21:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKLU3D (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Nov 2019 15:29:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40820 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726953AbfKLU3D (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Nov 2019 15:29:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573590542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gFJkukgipNbKWN+ICsYni15SDtbEI/aVJQySVn2TvCo=;
        b=dVUe26Z0y5fFsgjXw6qr2XIfCun4xJbSQ2OAH2/q2/TObWj92CGwodofBK30jriz95a27D
        fyOS0uBwu2BdpGE/vV6jMF11+9ecVFI6K7g/rejf1FND0st/lI72FHfhcltqg3Q1sJTxsT
        pRlocFAbeqZ6OHJg4vB9BEy8ow5BG6Q=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-cJDRj5ZMNQSqeuemhtgiiw-1; Tue, 12 Nov 2019 15:29:01 -0500
Received: by mail-lj1-f197.google.com with SMTP id l12so3365989lji.10
        for <linux-integrity@vger.kernel.org>; Tue, 12 Nov 2019 12:29:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QhteZ3MuQobJDpOEwpP4Wab9K3xVn23HLOglEOIOc04=;
        b=reFsjJQK0XbfwGEVUjsfFRIh/RIQAS1qGqlWO0JIcUgly3EtQtX13XUsUb3SOZtnCo
         E+q5wRKsdoAYkUBdtEwq4KitKgFKrG3p35zGCOGGabyKW33G0EI/HUvB7O0MU6/94qoG
         FJN38w7SNroazOtBEcdLYDG7dh60hmWV8MYCa4wng1dcvLHhEbIlym7Eb0v7EOn/jHuu
         tl5BxGgeBo5b+ePLAp+/qtdDJ4Gc5qPjrJgMRdBvgBD4IZ+tReVtD9b+ZXaQUHRoscPu
         Yivohd98j1o5gOm1Snwk9N+7hEy4pEzAyjKLR3EijYVWnTOW+UTLkfAFGlTlzY1o3Ks9
         NugQ==
X-Gm-Message-State: APjAAAUzhg307+eufZAA65d2zPjL/MH0vKdZIGc07Wj37GIdiOXdwgxa
        4mgBzFoCvGRR9QT7Zl8TV9pfURKEodlGHBxJ3kVykMM5IbKSyczhGXs9dpF3dA7b3pw1APTBbf8
        W3eNthCDbgY3eMiUYAUqqT9rzE27LukLxdJsE1lA9tEjz
X-Received: by 2002:a2e:9a55:: with SMTP id k21mr19244264ljj.85.1573590540215;
        Tue, 12 Nov 2019 12:29:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqybXyS9y5RP5SjBRQINrW6nR2l2GW8c5yxSjUhGbQvK4JUfyEtuPFq0YyWeM2TvaVLDqvoS1yQv/md3ymu9/ZQ=
X-Received: by 2002:a2e:9a55:: with SMTP id k21mr19244251ljj.85.1573590540042;
 Tue, 12 Nov 2019 12:29:00 -0800 (PST)
MIME-Version: 1.0
References: <20191111233418.17676-1-jsnitsel@redhat.com> <20191112200328.GA11213@linux.intel.com>
 <CALzcddtMiSzhgZv5R6xqb1Amyk7cdY4mJdYDS86KRxH4wR_EGA@mail.gmail.com> <20191112202623.GB5584@ziepe.ca>
In-Reply-To: <20191112202623.GB5584@ziepe.ca>
From:   Jerry Snitselaar <jsnitsel@redhat.com>
Date:   Tue, 12 Nov 2019 13:28:49 -0700
Message-ID: <CALzcddtse-4bKWaA0+ns-gVKGyQzMrYWS4n1rFpbbhKLb83z7g@mail.gmail.com>
Subject: Re: [PATCH] tpm_tis: turn on TPM before calling tpm_get_timeouts
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-stable@vger.kernel.org,
        Christian Bundy <christianbundy@fraction.io>
X-MC-Unique: cJDRj5ZMNQSqeuemhtgiiw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Nov 12, 2019 at 1:26 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Nov 12, 2019 at 01:23:33PM -0700, Jerry Snitselaar wrote:
> > On Tue, Nov 12, 2019 at 1:03 PM Jarkko Sakkinen
> > <jarkko.sakkinen@linux.intel.com> wrote:
> > >
> > > On Mon, Nov 11, 2019 at 04:34:18PM -0700, Jerry Snitselaar wrote:
> > > > With power gating moved out of the tpm_transmit code we need
> > > > to power on the TPM prior to calling tpm_get_timeouts.
> > > >
> > > > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > > Cc: Peter Huewe <peterhuewe@gmx.de>
> > > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > > Cc: linux-kernel@vger.kernel.org
> > > > Cc: linux-stable@vger.kernel.org
> > > > Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_tr=
ansmit()")
> > > > Reported-by: Christian Bundy <christianbundy@fraction.io>
> > > > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > >  drivers/char/tpm/tpm_tis_core.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm=
_tis_core.c
> > > > index 270f43acbb77..cb101cec8f8b 100644
> > > > +++ b/drivers/char/tpm/tpm_tis_core.c
> > > > @@ -974,13 +974,14 @@ int tpm_tis_core_init(struct device *dev, str=
uct tpm_tis_data *priv, int irq,
> > > >                * to make sure it works. May as well use that comman=
d to set the
> > > >                * proper timeouts for the driver.
> > > >                */
> > > > +             tpm_chip_start(chip);
> > > >               if (tpm_get_timeouts(chip)) {
> > > >                       dev_err(dev, "Could not get TPM timeouts and =
durations\n");
> > > >                       rc =3D -ENODEV;
> > > > +                     tpm_stop_chip(chip);
> > > >                       goto out_err;
> > > >               }
> > >
> > > Couldn't this call just be removed?
> > >
> > > /Jarkko
> > >
> >
> > Probably. It will eventually get called when tpm_chip_register
> > happens. I don't know what the reason was for trying it prior to the
> > irq probe.
>
> At least tis once needed the timeouts before registration because it
> was issuing TPM commands to complete its setup.
>
> If timeouts have not been set then no TPM command should be executed.
>
> Jason
>

Would it function with the timeout values set at the beginning of
tpm_tis_core_init (max values)?

