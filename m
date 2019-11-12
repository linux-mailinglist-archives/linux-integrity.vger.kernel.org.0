Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAFBF9A86
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2019 21:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfKLUXt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Nov 2019 15:23:49 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20414 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726995AbfKLUXt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Nov 2019 15:23:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573590227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sm43xd3IY5NxuGzENfU8epGVEGD0EhdYpwWq9AmG1kA=;
        b=Fzof296uzmrX4BgVeOli5nlhN57qwHjj2D6J1mVp0BBhAL7xrqzkkgCU/YMrW7d58Jrrgo
        ubs6/T23aX+nncShtn+wUSt+xuU6hdbTXcgmq1eULNdFK4x7PyRZBgwFl/BULwW8w0J+UJ
        dFgDU9QZDza6MiPEExzEMHk3EwU6gAg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-iXePpz3kMlKjPQUjKxfVUw-1; Tue, 12 Nov 2019 15:23:46 -0500
Received: by mail-lf1-f72.google.com with SMTP id x14so4279268lfq.15
        for <linux-integrity@vger.kernel.org>; Tue, 12 Nov 2019 12:23:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=huJzdqzI4XckJ8CuRctDocKEGaMJEuuYIpFJxV00rWg=;
        b=RcHJKJXEb3zDeZ7tBbc0RZgbBN21wr3D8MVIK7jpMCMK+27fxsxmcNwOrlaoVg4U41
         B+JMgJqDSkzoGuYSlTdfQMRcA9dMLYb5TW/URt+A/4mqCjK8gwy2jXPRe/r8RD5vcEGq
         mmVVasujJ2q2iF5tPL553dQBbREkMj1/FTtJ8gOAVVGq4zh7DZX63uzIPo1XEMYAqbHo
         lNwrWsH10CejdBTS3VBW0zCOxgK7MsUZ61S8bRXloDgN1n4nWF/5pmq+ngfEt5rcq8ho
         2AHbP5sxuWxCK4B622+Q5uR9MH6LXuYrXXgsaeExUS5phkN8oHDOGgmhhhEninp/tnzv
         kJTA==
X-Gm-Message-State: APjAAAWkRBK8vnbrkKOORJ0nrELV4I1o19U0+1b5OzZg3q/V4OQ5/ap4
        C+GW0rT3wZ80uzM1Kg97s0E/avjE+sT35KwdYR/wUfB1DQpazteJ9djjgNp0UEfpoUDWjsrs8jV
        Eb6vy4rpJU/hFFiAnIQcGgRYK600vh6PtjltVITfNRKX3
X-Received: by 2002:a2e:5c09:: with SMTP id q9mr20823215ljb.22.1573590225078;
        Tue, 12 Nov 2019 12:23:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqya3xfaP9CZmXxd5+77sxU7S+zzIIKgQp5UFFBbd/wwCS19AWFxN3a9aCXPF3CGUil3yJi6B2ALh/BCuiMZ0iE=
X-Received: by 2002:a2e:5c09:: with SMTP id q9mr20823200ljb.22.1573590224814;
 Tue, 12 Nov 2019 12:23:44 -0800 (PST)
MIME-Version: 1.0
References: <20191111233418.17676-1-jsnitsel@redhat.com> <20191112200328.GA11213@linux.intel.com>
In-Reply-To: <20191112200328.GA11213@linux.intel.com>
From:   Jerry Snitselaar <jsnitsel@redhat.com>
Date:   Tue, 12 Nov 2019 13:23:33 -0700
Message-ID: <CALzcddtMiSzhgZv5R6xqb1Amyk7cdY4mJdYDS86KRxH4wR_EGA@mail.gmail.com>
Subject: Re: [PATCH] tpm_tis: turn on TPM before calling tpm_get_timeouts
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-stable@vger.kernel.org,
        Christian Bundy <christianbundy@fraction.io>
X-MC-Unique: iXePpz3kMlKjPQUjKxfVUw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Nov 12, 2019 at 1:03 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Mon, Nov 11, 2019 at 04:34:18PM -0700, Jerry Snitselaar wrote:
> > With power gating moved out of the tpm_transmit code we need
> > to power on the TPM prior to calling tpm_get_timeouts.
> >
> > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Cc: Peter Huewe <peterhuewe@gmx.de>
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-stable@vger.kernel.org
> > Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transm=
it()")
> > Reported-by: Christian Bundy <christianbundy@fraction.io>
> > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > ---
> >  drivers/char/tpm/tpm_tis_core.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis=
_core.c
> > index 270f43acbb77..cb101cec8f8b 100644
> > --- a/drivers/char/tpm/tpm_tis_core.c
> > +++ b/drivers/char/tpm/tpm_tis_core.c
> > @@ -974,13 +974,14 @@ int tpm_tis_core_init(struct device *dev, struct =
tpm_tis_data *priv, int irq,
> >                * to make sure it works. May as well use that command to=
 set the
> >                * proper timeouts for the driver.
> >                */
> > +             tpm_chip_start(chip);
> >               if (tpm_get_timeouts(chip)) {
> >                       dev_err(dev, "Could not get TPM timeouts and dura=
tions\n");
> >                       rc =3D -ENODEV;
> > +                     tpm_stop_chip(chip);
> >                       goto out_err;
> >               }
>
> Couldn't this call just be removed?
>
> /Jarkko
>

Probably. It will eventually get called when tpm_chip_register
happens. I don't know what the reason was for trying it prior to the
irq probe.

