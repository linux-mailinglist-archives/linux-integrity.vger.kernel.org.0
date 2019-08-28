Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9B8C9F9D2
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Aug 2019 07:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbfH1F2Z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Aug 2019 01:28:25 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40095 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfH1F2Y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Aug 2019 01:28:24 -0400
Received: by mail-lj1-f194.google.com with SMTP id e27so1363502ljb.7
        for <linux-integrity@vger.kernel.org>; Tue, 27 Aug 2019 22:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wuD+47oBthIHQumcqd0YN679T72WGLTDD4hOsKbpLxE=;
        b=JxQ/DhDP05PNcJhHPHt2GrZ/B8VfZ53oE6THwxTahk32Tsn0TFdadeMPol+lFd4P1A
         ZSNr/mSN4jHxlMDbHl9zDZxG22Ec4vfh7ClgirOkCZvTjA6NTfc7GF6QpnMJoq3yf1Tf
         jZJPmiBUgmxrpi3fZHzpuAAhDEbJIGpkDmyqW77n0f4dC+Kdoog+2dPGysHFHolJFQYJ
         dKWrRA+dbT0VHyb3+C39xtvli41mc53RQaVl4B3RnrOVhuH3KUKlLJ1X9oNXIVZroUOV
         ysRIXcz2GlsRxWYVmoX0DOS+xB7rY3Uuf0nRqv9lrREvMrwVG+NiTKs3C3JiDAFCeUsa
         253w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wuD+47oBthIHQumcqd0YN679T72WGLTDD4hOsKbpLxE=;
        b=oBbvHnqwCDNwjJGmls5ciCajPVb7afLdWpUhVysLYDF6BXe22G8mooWchT1ch0fzgH
         1yBANlYAo31Fud3CPaLybdwLUxGMVlXBJvS57lkcArsrWqaIonTEIOCekN4W/az8O7z1
         C4Q14KkC1l8gljAICId7/gVP7jk6TxcNbo0Xg1g/95TRrG1ODuOJVzMCKHIj7VvOMw3F
         E5qhhLKIT3K3k7lLg+9bsbeR4OrAF/F1igWng13UeU1XnyfWOgTISFCBWzJE0AhJeXK8
         suvBQm0H/IQv/0PjLAYDq/7u8u5Bd+SrFqmD5bykPkM27D+eosu/+MNW44T9pc2hKvpX
         iFBg==
X-Gm-Message-State: APjAAAWCQJO3nv168v61VQ/uPAbWaK3ThpLvzPs304uhfTSj0PuOOvwO
        p9mxazZXvESSj5EP6Xh1IT3go59jTVIZHzJDhu834Q==
X-Google-Smtp-Source: APXvYqzP6WVBc3SIpSbwvH+PA6Ta0a7UKTqmsXsZbvFWOoRZR8d2RevgeN/WfpPSOG2xP4CPkCq1nfyajuFEu/pawkk=
X-Received: by 2002:a2e:819:: with SMTP id 25mr987414lji.142.1566970102465;
 Tue, 27 Aug 2019 22:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <1566392345-15419-1-git-send-email-sumit.garg@linaro.org>
 <1566392345-15419-5-git-send-email-sumit.garg@linaro.org> <20190827141742.6qxowsigqolxaod4@linux.intel.com>
In-Reply-To: <20190827141742.6qxowsigqolxaod4@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 28 Aug 2019 10:58:11 +0530
Message-ID: <CAFA6WYPnoDoMWd=PT4mgXPhg1Wp0=AFDnWd_44UMP7sijXzAZA@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] KEYS: trusted: move tpm2 trusted keys code
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        peterhuewe@gmx.de, jgg@ziepe.ca, jejb@linux.ibm.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 27 Aug 2019 at 19:47, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Wed, Aug 21, 2019 at 06:29:05PM +0530, Sumit Garg wrote:
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2004 IBM Corporation
> > + * Copyright (C) 2014 Intel Corporation
>
> Everything below can be dropped from this new file. Git has the most
> accurate authority information.
>
> I'm not sure why I added the authors-list in the first place to the
> header when I implemented these functions as none of those folks have
> contributed to this particular piece of work.
>
> > + * Authors:
> > + * Leendert van Doorn <leendert@watson.ibm.com>
> > + * Dave Safford <safford@watson.ibm.com>
> > + * Reiner Sailer <sailer@watson.ibm.com>
> > + * Kylene Hall <kjhall@us.ibm.com>
> > + *
> > + * Maintained by: <tpmdd-devel@lists.sourceforge.net>
> > + *
> > + * Trusted Keys code for TCG/TCPA TPM2 (trusted platform module).
> > + */
>
> To summarize, I think this would be sufficient:
>
> // SPDX-License-Identifier: GPL-2.0-only
> /*
>  * Copyright (C) 2004 IBM Corporation
>  * Copyright (C) 2014 Intel Corporation
>  */

Sounds good to me.

>
> I think there should never be such a rush that acronym could not be
> written with the correct spelling. I'm referring to 'tpm2' in the short
> summary.

So you mean to say we should use upper-case letters for 'TPM2' acronym?

> I'm sorry, I had to say it, just can't help myself with those
> kind of details :-) I can take care of fixing those once I apply these
> patches.
>
> You've done an awesome job. Thank you.
>

You are welcome.

> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>

Thanks for your review.

-Sumit

> Unfortunately I'm not yet sure if I have time to test these before going
> to Linux Plumbers but these would be anyway too close to the next merge
> window to be added to the v5.4 PR.
>
> /Jarkko
