Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C92C3F9AB6
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2019 21:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfKLUbZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Nov 2019 15:31:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54784 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726388AbfKLUbY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Nov 2019 15:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573590683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IByCdOcsK7z2wqcglE3nDgjbdw+hHaKusrjX1MWd/k0=;
        b=MDuaZ1exU30V3AfcizCa9CjiX4jhbmEoaNLHO8+76+2MY6jwRl8MLcKoFWHqZv1OjvpBt5
        0W0NPKDMnlfJRZIhzqySrX7Gxm0GDI/7nzSlpvSYnJfLl/PspNXLwWCFV/DtLgsUL2C7Os
        f0716C0j7AUcEGZ6rbOJ0DQiHzo0dus=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-JG09qswmMDe2mGRz8UY_HQ-1; Tue, 12 Nov 2019 15:31:21 -0500
Received: by mail-lf1-f69.google.com with SMTP id p4so4276510lfo.10
        for <linux-integrity@vger.kernel.org>; Tue, 12 Nov 2019 12:31:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aIQasmDACRm3A9ZstJoEy2oYlDFM8WAP33PBbVt6iPM=;
        b=YgZbpRUzZ65nHTwQKar5CWiFSzF+hSblw5VqDovYDUG7qmc9Zq7px0ZCAw6Lg31idO
         KxmxLSbuAbdrpOrRWD66ET81CpEnvOk4lbzUjY86wj0H7G87qrPYBivQkLxm/PfdBaL8
         c212ka6XsEe9f8abiyrA111XmZiDBubO78JYmv24KfK43sRWTPZYZB9vQVniWUXx6Rf/
         PpK6TJg1C63lp7/BD/T/jZyY8LpZ3iK8HvRVR4z2pkBSNbezDu64APGy+pnd+1tohyNo
         q/osi75idu1iCiEEJTCKe+W2oGOJiWKLEZk7Ux/gwKxl8CBp8NeMeoARV33ozFiUNJbv
         +M5g==
X-Gm-Message-State: APjAAAUVmcOVJ+GjRB6vq+GmUMfaPiLaF5kYmATo623+d9sag6cOIZ+n
        hidzRwDSrhj3hxef0uZ5w65Eo77fvMLywKWvu4bqgOqXlhxhwMTAGFcnbGwwbFz0wWh9EYI55t8
        mtqOH3D+fiBh6qRw0mhdoNruCyrDpaDUgCAawXMvWJqYm
X-Received: by 2002:ac2:46c9:: with SMTP id p9mr19116995lfo.166.1573590680206;
        Tue, 12 Nov 2019 12:31:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqyIcWFUT5nlqJEHWH82BamRW6gkAt+gP4B65DcWbI3oa48KtBNMKOyThKMcfVE1uMMHjJ0kjFclKe3d0NFpOtM=
X-Received: by 2002:ac2:46c9:: with SMTP id p9mr19116984lfo.166.1573590680032;
 Tue, 12 Nov 2019 12:31:20 -0800 (PST)
MIME-Version: 1.0
References: <20191111233418.17676-1-jsnitsel@redhat.com> <20191112200328.GA11213@linux.intel.com>
 <CALzcddtMiSzhgZv5R6xqb1Amyk7cdY4mJdYDS86KRxH4wR_EGA@mail.gmail.com>
 <20191112202623.GB5584@ziepe.ca> <CALzcddtse-4bKWaA0+ns-gVKGyQzMrYWS4n1rFpbbhKLb83z7g@mail.gmail.com>
In-Reply-To: <CALzcddtse-4bKWaA0+ns-gVKGyQzMrYWS4n1rFpbbhKLb83z7g@mail.gmail.com>
From:   Jerry Snitselaar <jsnitsel@redhat.com>
Date:   Tue, 12 Nov 2019 13:31:09 -0700
Message-ID: <CALzcddv2aLQ1krYFeNtWNOxyF3aSD0-p3j_p3CgS2Vx-__sQPA@mail.gmail.com>
Subject: Re: [PATCH] tpm_tis: turn on TPM before calling tpm_get_timeouts
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-stable@vger.kernel.org,
        Christian Bundy <christianbundy@fraction.io>
X-MC-Unique: JG09qswmMDe2mGRz8UY_HQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Nov 12, 2019 at 1:28 PM Jerry Snitselaar <jsnitsel@redhat.com> wrot=
e:
>
> On Tue, Nov 12, 2019 at 1:26 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Tue, Nov 12, 2019 at 01:23:33PM -0700, Jerry Snitselaar wrote:
> > > On Tue, Nov 12, 2019 at 1:03 PM Jarkko Sakkinen
> > > <jarkko.sakkinen@linux.intel.com> wrote:
> > > >
> > > > On Mon, Nov 11, 2019 at 04:34:18PM -0700, Jerry Snitselaar wrote:
> > > > > With power gating moved out of the tpm_transmit code we need
> > > > > to power on the TPM prior to calling tpm_get_timeouts.
> > > > >
> > > > > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > > > Cc: Peter Huewe <peterhuewe@gmx.de>
> > > > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > > > Cc: linux-kernel@vger.kernel.org
> > > > > Cc: linux-stable@vger.kernel.org
> > > > > Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_=
transmit()")
> > > > > Reported-by: Christian Bundy <christianbundy@fraction.io>
> > > > > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > > >  drivers/char/tpm/tpm_tis_core.c | 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/t=
pm_tis_core.c
> > > > > index 270f43acbb77..cb101cec8f8b 100644
> > > > > +++ b/drivers/char/tpm/tpm_tis_core.c
> > > > > @@ -974,13 +974,14 @@ int tpm_tis_core_init(struct device *dev, s=
truct tpm_tis_data *priv, int irq,
> > > > >                * to make sure it works. May as well use that comm=
and to set the
> > > > >                * proper timeouts for the driver.
> > > > >                */
> > > > > +             tpm_chip_start(chip);
> > > > >               if (tpm_get_timeouts(chip)) {
> > > > >                       dev_err(dev, "Could not get TPM timeouts an=
d durations\n");
> > > > >                       rc =3D -ENODEV;
> > > > > +                     tpm_stop_chip(chip);
> > > > >                       goto out_err;
> > > > >               }
> > > >
> > > > Couldn't this call just be removed?
> > > >
> > > > /Jarkko
> > > >
> > >
> > > Probably. It will eventually get called when tpm_chip_register
> > > happens. I don't know what the reason was for trying it prior to the
> > > irq probe.
> >
> > At least tis once needed the timeouts before registration because it
> > was issuing TPM commands to complete its setup.
> >
> > If timeouts have not been set then no TPM command should be executed.
> >
> > Jason
> >
>
> Would it function with the timeout values set at the beginning of
> tpm_tis_core_init (max values)?

I guess that doesn't set the duration values though

