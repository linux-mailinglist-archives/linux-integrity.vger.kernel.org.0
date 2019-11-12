Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16F8CF9BCF
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2019 22:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfKLVOa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Nov 2019 16:14:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47875 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727419AbfKLVOa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Nov 2019 16:14:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573593269;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KhaSq6F0boqwPJebWHU+vS4X8WSartUyEjWwqUHsPz4=;
        b=fFJb3eS7WFHslE730SbK4WoBFpT95eeg/YgnshR5MDghgJ4IpuDBnzStSuUDePCqWwRdJi
        urBOYFqBf9w9tSrjxnzgQTvFCJ3vZTcjZG5G5ezAlFHvwtmgJdwzGsqcoNKp6dhcO4/yzj
        jQLPPcoDk90xPOTFLG0dr0tARO2YAVo=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-pbCAyx3LO8ezgHSy9uNOIA-1; Tue, 12 Nov 2019 16:14:26 -0500
Received: by mail-yb1-f198.google.com with SMTP id n9so126112ybd.5
        for <linux-integrity@vger.kernel.org>; Tue, 12 Nov 2019 13:14:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=jB1CQxHZY09v+dVO/IW1sLsxw+s5h/wXvYhyMUh4nd4=;
        b=dKqFFoMIGNeIPkmxcGwAkf7c9xXYGAPOAY7Ftfd7vsI0E0rXwePoVBjeJuBIblErxt
         dsjlSLWObV6Ytn7tlg8EhUOXUffs6qQp+ansn1GLR1xOI7bFRiUANYL+cLEJvJywQffR
         mAvs+QdJtkwmWR1srlIm8JJurYvpcTz/V6E3sj2lrTc6vS6TuzyUy5r+4G49As31DMGT
         lGvi+4m6OahfUuoAhtxlheBkB8MDn8t3Ng9DOa/yOabwgmoojdVHnAxh26vFyhbO9cZu
         ItR/ejNazylkhn35fwjC9s4iGts/We/l3zR2jFQ46xXvZrtLydPIjOfMh0WqXMi3tkIu
         fIGA==
X-Gm-Message-State: APjAAAVOW6NUbkfEAMB/CW5dswTtrmszCYg2/duI+ER/z4ChUlgUfsfN
        jSt0ZH/SU02ZYaiETbAhKMOfXivOOQvR9/3KU0QYxF5E9eUhsbp/XlKXCUabqIC3k3olGRXicSl
        b4l4EfitAc4cT3ZRfN1zdryoj9cdw
X-Received: by 2002:a81:10d4:: with SMTP id 203mr49031ywq.390.1573593265498;
        Tue, 12 Nov 2019 13:14:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqwEcKNvBFCa/Pi9LABko8hxEtyRnZOUme9kRE5c2iBVZmTkmYukiWzYoyB8ZRofsuIDcutGWg==
X-Received: by 2002:a81:10d4:: with SMTP id 203mr49020ywq.390.1573593265161;
        Tue, 12 Nov 2019 13:14:25 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id v5sm128965ywi.95.2019.11.12.13.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 13:14:24 -0800 (PST)
Date:   Tue, 12 Nov 2019 14:14:23 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org,
        Christian Bundy <christianbundy@fraction.io>
Subject: Re: [PATCH] tpm_tis: turn on TPM before calling tpm_get_timeouts
Message-ID: <20191112211423.vgtervfk52txgfmm@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jason Gunthorpe <jgg@ziepe.ca>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org,
        Christian Bundy <christianbundy@fraction.io>
References: <20191111233418.17676-1-jsnitsel@redhat.com>
 <20191112200328.GA11213@linux.intel.com>
 <CALzcddtMiSzhgZv5R6xqb1Amyk7cdY4mJdYDS86KRxH4wR_EGA@mail.gmail.com>
 <20191112202623.GB5584@ziepe.ca>
 <CALzcddtse-4bKWaA0+ns-gVKGyQzMrYWS4n1rFpbbhKLb83z7g@mail.gmail.com>
 <CALzcddv2aLQ1krYFeNtWNOxyF3aSD0-p3j_p3CgS2Vx-__sQPA@mail.gmail.com>
 <20191112204623.GG5584@ziepe.ca>
MIME-Version: 1.0
In-Reply-To: <20191112204623.GG5584@ziepe.ca>
X-MC-Unique: pbCAyx3LO8ezgHSy9uNOIA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue Nov 12 19, Jason Gunthorpe wrote:
>On Tue, Nov 12, 2019 at 01:31:09PM -0700, Jerry Snitselaar wrote:
>> On Tue, Nov 12, 2019 at 1:28 PM Jerry Snitselaar <jsnitsel@redhat.com> w=
rote:
>> >
>> > On Tue, Nov 12, 2019 at 1:26 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>> > >
>> > > On Tue, Nov 12, 2019 at 01:23:33PM -0700, Jerry Snitselaar wrote:
>> > > > On Tue, Nov 12, 2019 at 1:03 PM Jarkko Sakkinen
>> > > > <jarkko.sakkinen@linux.intel.com> wrote:
>> > > > >
>> > > > > On Mon, Nov 11, 2019 at 04:34:18PM -0700, Jerry Snitselaar wrote=
:
>> > > > > > With power gating moved out of the tpm_transmit code we need
>> > > > > > to power on the TPM prior to calling tpm_get_timeouts.
>> > > > > >
>> > > > > > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>> > > > > > Cc: Peter Huewe <peterhuewe@gmx.de>
>> > > > > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
>> > > > > > Cc: linux-kernel@vger.kernel.org
>> > > > > > Cc: linux-stable@vger.kernel.org
>> > > > > > Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of t=
pm_transmit()")
>> > > > > > Reported-by: Christian Bundy <christianbundy@fraction.io>
>> > > > > > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
>> > > > > >  drivers/char/tpm/tpm_tis_core.c | 3 ++-
>> > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
>> > > > > >
>> > > > > > diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tp=
m/tpm_tis_core.c
>> > > > > > index 270f43acbb77..cb101cec8f8b 100644
>> > > > > > +++ b/drivers/char/tpm/tpm_tis_core.c
>> > > > > > @@ -974,13 +974,14 @@ int tpm_tis_core_init(struct device *dev=
, struct tpm_tis_data *priv, int irq,
>> > > > > >                * to make sure it works. May as well use that c=
ommand to set the
>> > > > > >                * proper timeouts for the driver.
>> > > > > >                */
>> > > > > > +             tpm_chip_start(chip);
>> > > > > >               if (tpm_get_timeouts(chip)) {
>> > > > > >                       dev_err(dev, "Could not get TPM timeouts=
 and durations\n");
>> > > > > >                       rc =3D -ENODEV;
>> > > > > > +                     tpm_stop_chip(chip);
>> > > > > >                       goto out_err;
>> > > > > >               }
>> > > > >
>> > > > > Couldn't this call just be removed?
>> > > > >
>> > > > > /Jarkko
>> > > > >
>> > > >
>> > > > Probably. It will eventually get called when tpm_chip_register
>> > > > happens. I don't know what the reason was for trying it prior to t=
he
>> > > > irq probe.
>> > >
>> > > At least tis once needed the timeouts before registration because it
>> > > was issuing TPM commands to complete its setup.
>> > >
>> > > If timeouts have not been set then no TPM command should be executed=
.
>> >
>> > Would it function with the timeout values set at the beginning of
>> > tpm_tis_core_init (max values)?
>>
>> I guess that doesn't set the duration values though
>
>There is no reason to use anything but the correct timeouts, as read
>from the device.
>
>Jason
>

Should there be a check in tpm1_get_timeouts and tpm2_get_timeouts:

=09if (chip->flags & TPM_CHIP_FLAG_HAVE_TIMEOUTS)
=09=09return 0;

to skip going through it again in the auto startup code if it was
already called and set?

