Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99DE028CF55
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Oct 2020 15:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgJMNkv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Oct 2020 09:40:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:42818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729110AbgJMNkv (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Oct 2020 09:40:51 -0400
Received: from localhost (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5114024741;
        Tue, 13 Oct 2020 13:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602596450;
        bh=hMKks0yH+1QbT8lmw2IcB9FvKt0uw8hZHVUF20d9isU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iEP+KtkxdbveqHc3o6dc0NabtkgQBAMQRm6bRQ2wdx9i0idUyeoN5bGhVU9LshPhp
         RQ63GxGtL7rGZLClYXAzipFBusI5YRWl3Ei/5GCzmB4WQdmknstsXe4e0k9JPY8ebc
         MIveOdrgpZSUwYYlnCVuFPoWuCxl9brA4QH81e+I=
Date:   Tue, 13 Oct 2020 16:40:48 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Markus Wamser <Markus.Wamser@mixed-mode.de>,
        Luke Hinds <lhinds@redhat.com>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v7 4/4] MAINTAINERS: Add entry for TEE based Trusted Keys
Message-ID: <20201013134048.GA147135@kernel.org>
References: <1602065268-26017-1-git-send-email-sumit.garg@linaro.org>
 <1602065268-26017-5-git-send-email-sumit.garg@linaro.org>
 <20201013022157.GA47751@linux.intel.com>
 <CAFA6WYO6zNKtxhpNpTpqAjZnMPrEygs1k7Gwg3hwJV8Ynrr=qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYO6zNKtxhpNpTpqAjZnMPrEygs1k7Gwg3hwJV8Ynrr=qQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Oct 13, 2020 at 04:58:47PM +0530, Sumit Garg wrote:
> On Tue, 13 Oct 2020 at 07:52, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Wed, Oct 07, 2020 at 03:37:48PM +0530, Sumit Garg wrote:
> > > Add MAINTAINERS entry for TEE based Trusted Keys framework.
> > >
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > ---
> > >  MAINTAINERS | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 48aff80..eb3d889 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -9663,6 +9663,14 @@ F:     include/keys/trusted-type.h
> > >  F:   include/keys/trusted_tpm.h
> > >  F:   security/keys/trusted-keys/
> > >
> > > +KEYS-TRUSTED-TEE
> > > +M:   Sumit Garg <sumit.garg@linaro.org>
> > > +L:   linux-integrity@vger.kernel.org
> > > +L:   keyrings@vger.kernel.org
> > > +S:   Supported
> > > +F:   include/keys/trusted_tee.h
> > > +F:   security/keys/trusted-keys/trusted_tee.c
> > > +
> > >  KEYS/KEYRINGS
> > >  M:   David Howells <dhowells@redhat.com>
> > >  M:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > --
> > > 2.7.4
> >
> > I'm sorry but I think I have changed my mind on this. This has been
> > spinning for a while and sometimes conclusions change over the time.
> >
> > I don't think that we really need a separate subsystem tag.
> 
> I don't see it as a separate subsystem but rather a kind of underlying
> trust source (TEE) driver plugged into existing trusted keys
> subsystem. We could relate it to the RNG subsystem as well where there
> is a subsystem maintainer and specific driver maintainers.
> 
> IMO, having a dedicated entry like this brings clarity in maintenance
> and in future we may have more trust sources like this added where
> everyone may not have access to all the trust sources to test.

More entries pointing to the exact same stuff does not necessarily mean
clarity in my books.

> > I'd be for a
> > new M-entry or R-entry to the existing subsystem tag. It's essential to
> > have ack from someone with ARM and TEE knowledge but this way too heavy
> > for the purpose.
> 
> If you still think otherwise then I am fine with a new M-entry for
> existing trusted keys subsystem as well.

Adding a M-entry does makes sense because trusted keys backends can be
based on various technologies and standard. It's a different in that
sense than lets say a TPM hardware driver.

> > I also see it the most manageable if the trusted keys PR's come from a
> > single source.
> 
> I echo here with you to have a single source for trusted keys PR's
> irrespective of whether we go with a separate trust source entry or
> update existing subsystem entry.
> 
> -Sumit

And I echo that oviously if there is someone to say the final ack about
TEE, I will require that as the minimum to ever pick any of those
changes :-)

I would resolve this with just the M-entry, and we can *later on*
restructure, if there is a need for that. These things are not sealed
to stone.

/Jarkko
