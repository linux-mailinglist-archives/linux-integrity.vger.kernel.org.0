Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7E583365
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Aug 2019 15:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbfHFNz3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Aug 2019 09:55:29 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33217 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfHFNzZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Aug 2019 09:55:25 -0400
Received: by mail-lf1-f66.google.com with SMTP id x3so61317654lfc.0
        for <linux-integrity@vger.kernel.org>; Tue, 06 Aug 2019 06:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=416ovtRseB2pZqvtmfp0MPISej3Ly1ggyhuXKFA1TSc=;
        b=gDftQyU1sPLNDej0wqOudB1zkk8RWR8GaBumdUmuN1ITOuIMv6D184qQCjXC2BONd5
         5vqAH8nQ1i61o5WZKQqN3Ed4at81eZcE6pSsx1nf/ywXDy1Q/9CGHvZKHuIodIOfBuWx
         VwQ19fUMCt8gIbT1VdEX7+mvkWYJuO9qJ4cz9kRNbfF7ufzFj9CsH6Wv2vvnpqWCl/24
         e7FaiAo+HHBnWEvkt2QsYiXs/P25XMi38nnDymc7XFlY2NiOXo6uTcCd9Aud+bq08rgH
         31Z/k5NNVcW4wN+P3YtazLFd82nhrnIqxbwG+nhaDOO2bY0OaoEi77I/o7bKQFyhCg2L
         IAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=416ovtRseB2pZqvtmfp0MPISej3Ly1ggyhuXKFA1TSc=;
        b=qo18IWrWnCkDNbWppmzPxege8vksGevaTEWCLu5RpTOfzYhGIA4VdVCozvQTMzP4BS
         0QVlJ6oK9IICCETxIg7Q3vQt8AvvrgXS+izfL0ofKqWyPX13QBX/SiCxBhpK/SpsEEF0
         n3jvzCgHqvIZTop8zQ5rTMSVP1D2DrhSgXAKItWuwbYQ2q1+j53Hz5l+u1ANKbowUqny
         oiDdor2vrZjXH0Cc+egNLtcih7suDSWsqNSN/YezqHJlJiVISAZ3dlolhIvWnAb4Dm4O
         xQMdpJ035hSPjsDi0uaztNI6+Cg0S3RVyma/cC3fsRBlc7gFner/+phi2HTL7+VbfEWl
         gbrw==
X-Gm-Message-State: APjAAAVo8Wgq0ZWUdBUdQAtB/TuJKOhwmIneZ5XM/I0Y0S3lER9cNpTa
        Mg/hqKfwPpwggEYqCDQvnG2U/z4wIesxR2/dSJ1PNA==
X-Google-Smtp-Source: APXvYqyDhk3mM2mXFVY+5NaLG5MnfeslEX98rS822FuxZkz+Chdgp4KVCeTC7L8SPh116s2rDNgHQ7ixop5FDBZ38Q4=
X-Received: by 2002:ac2:5637:: with SMTP id b23mr2634100lff.186.1565099723639;
 Tue, 06 Aug 2019 06:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <1565098640-12536-1-git-send-email-sumit.garg@linaro.org>
 <1565098640-12536-3-git-send-email-sumit.garg@linaro.org> <20190806134322.GA10783@kroah.com>
In-Reply-To: <20190806134322.GA10783@kroah.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 6 Aug 2019 19:25:12 +0530
Message-ID: <CAFA6WYPVc_0dm2=w0Ec-Y0Sr9SipukGSJcjond-FrHREHQXTrQ@mail.gmail.com>
Subject: Re: [RFC/RFT v3 2/3] KEYS: trusted: move tpm2 trusted keys code
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        peterhuewe@gmx.de, jgg@ziepe.ca, jejb@linux.ibm.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
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

On Tue, 6 Aug 2019 at 19:13, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Aug 06, 2019 at 07:07:19PM +0530, Sumit Garg wrote:
> > Move TPM2 trusted keys code to trusted keys subsystem.
> >
> > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  drivers/char/tpm/tpm-interface.c          |  56 -----
> >  drivers/char/tpm/tpm.h                    | 224 ------------------
> >  drivers/char/tpm/tpm2-cmd.c               | 307 ------------------------
> >  include/keys/trusted_tpm.h                |  23 +-
> >  include/linux/tpm.h                       | 264 +++++++++++++++++++--
> >  security/keys/trusted-keys/Makefile       |   3 +-
> >  security/keys/trusted-keys/trusted-tpm.c  |  16 +-
> >  security/keys/trusted-keys/trusted-tpm2.c | 378 ++++++++++++++++++++++++++++++
> >  8 files changed, 652 insertions(+), 619 deletions(-)
> >  create mode 100644 security/keys/trusted-keys/trusted-tpm2.c
>
> 'git format-patch -M' will create a patch that shows the rename, and
> then any tiny differences that happened after that.  A patch like this
> is hard to see what changed in the move.
>

I used this option only to generate the patch-set. Following is the
command I used:

git format-patch -M -3 --cover-letter --subject-prefix="RFC/RFT v3"

It seems like for this patch I need to collect pieces from
"drivers/char/tpm/" and aggregate them under
"security/keys/trusted-keys/trusted-tpm2.c" and "include/linux/tpm.h"
files. So that could be the reason for such patch view.

-Sumit

> thanks,
>
> greg k-h
