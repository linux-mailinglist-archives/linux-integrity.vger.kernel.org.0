Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3C84573D
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Jun 2019 10:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfFNIRa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 14 Jun 2019 04:17:30 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41432 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfFNIRa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 Jun 2019 04:17:30 -0400
Received: by mail-lf1-f68.google.com with SMTP id 136so1092109lfa.8
        for <linux-integrity@vger.kernel.org>; Fri, 14 Jun 2019 01:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sYZceYw/PBvRSxvmCoPk9kiBr948sZ4CFzmxWCPNjiY=;
        b=RLrsNPT/uaaAfFbVFaeqZ6JSPheqCUq74WDZJocy/VXfonejDDi21W3KH/jUcNDYit
         uFjYoUzJhvbyvDe6ImPVkmAIf0sWV0aajwDBxm1DxLInFjAvbcMbi5RidfsPjVZrMffs
         Zg+N5N/SfwdpXzQeNbaoZttXLU3LyrWuOVWSUD/HN+icQi3UAq7i4EQoY2e7fRWAKS2G
         DTsOw5eHbsCdluVPpPOXyDWc9Cz/smTVsS+OkRpIHcajmkoMv6Zwg3xxiKhhxMbLvAUE
         ADOPKegxUfDNG+Bdd3FC2qU8XzWIx16DnlzPqgQA9ybWXYaKidIR61Rwg9y4sX2RXm2T
         7/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sYZceYw/PBvRSxvmCoPk9kiBr948sZ4CFzmxWCPNjiY=;
        b=AZeSB5qlqfEBUzQVMsSUbrarandTIPtBLHDBmughXfc59r+kO92ov1ppBF7Yr/Oval
         J5cD8cRSq5iZIjWcDOBA/MRAdSHe/X3p/CcjklK7Mp6Z0pZB51h5iuZqTnVssviK6j5s
         Ial10R8INKz94oM0eWtYwnLNjl4b7cFoxGImGTvhaWX/ACuzNQgBurhpwsQ/ln/2+iPX
         po8IxoeSNyCY4M3GuYhUGGx/Z1DqELzbhILdXvBje+ldIRYT/eQ1z+2Oik8LVZdwSM/7
         rDupsjlNQrwqQGlcik4L//F30WzwcrmeAEQT60JGEFbkyYapq1kOC+8mVdQTHg0fdGvw
         A9Ag==
X-Gm-Message-State: APjAAAXZsAE/hLMbaeq3+tM9OxNPqqlFE7inxXZad1fHLOljwUmelh4n
        6SWipIbjV7cEovwYwqhTVp+gp938pH19M5Ctakm5WQ==
X-Google-Smtp-Source: APXvYqwlbCDwuNlvWWLAMVDCvRG6Cs9rwpyMyT1zYYedGWIAKIWp5RRw1PxqPMLnhghF9xZ+PIVYSTL3bBt2hmIi3WQ=
X-Received: by 2002:ac2:50c4:: with SMTP id h4mr34300421lfm.61.1560500248037;
 Fri, 14 Jun 2019 01:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
 <d803283e-5e69-5deb-fe94-3f2e45fb95af@schaufler-ca.com> <1560470593.4805.109.camel@linux.ibm.com>
In-Reply-To: <1560470593.4805.109.camel@linux.ibm.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 14 Jun 2019 13:47:16 +0530
Message-ID: <CAFA6WYOZOrv5D6261z-bwCP6+6ORzH3PcZz89Sfn=yts0dkvTg@mail.gmail.com>
Subject: Re: [RFC 0/7] Introduce TEE based Trusted Keys support
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>, corbet@lwn.net,
        dhowells@redhat.com, jejb@linux.ibm.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        jmorris@namei.org, serge@hallyn.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tee-dev@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Thanks Mimi for your comments.

On Fri, 14 Jun 2019 at 05:33, Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Thu, 2019-06-13 at 09:40 -0700, Casey Schaufler wrote:
> > On 6/13/2019 3:30 AM, Sumit Garg wrote:
> > > Add support for TEE based trusted keys where TEE provides the functionality
> > > to seal and unseal trusted keys using hardware unique key. Also, this is
> > > an alternative in case platform doesn't possess a TPM device.
> > >
> > > This series also adds some TEE features like:
> >
> > Please expand the acronym TEE on first use. That will
> > help people who don't work with it on a daily basis
> > understand what you're going on about.
>
> Thanks, Casey.
>
> "[6/7] doc: keys: Document usage of TEE based Trusted Keys" refers to
> the kernel tee documentation, but that documentation is limited to
> userspace interaction with the tee.
>

Thanks for pointing this out. I will update documentation to include
TEE bus approach and communication apis for kernel clients.

BTW, the interface is similar as with user-space. Only difference is
instead of IOCTL's from user-space, there are wrapper apis to
communicate with TEE.

Also, in case someone is interested to learn about TEE technology,
this webinar [1] could be one of starting points.

> A trusted key is a random number generated and sealed(encrypted) by
> the TPM, so that only the TPM may unseal it.  The sealing key never
> leaves the TPM.  The sealed, trusted key may be exported to userspace.

Understood.

>  In the tee case, can the "sealing" key ever leave the tee?

No, the "sealing" key never leaves TEE. Its basically a Hardware
Unique Key (HUK) tied to a particular SoC.

>  Can the
> sealed, trusted key, exported to userspace, be unsealed by the tee?

You mean using user-space interface to TEE? If yes, then answer is
"no" as user-space can't communicate with this TEE service as its
accessible to kernel clients only (see patch [2]).

In case you meant loading exported trusted key blob via "keyctl", then
"yes" this driver can unseal the trusted key. Have a look at examples
I have listed in documentation patch [3]. Also, this approach works
well across power cycles too.

>  Are the tee security protections similar to those of the TPM?  How do
> they compare?
>

Let me try to compare both environments. Regarding TEE, I will refer
to OP-TEE [4] as one of its implementation.

TPM:

1. External hardware.
2. Sealing key resides inside TPM.
3. Communicates via SPI, I2C etc.

OP-TEE:

1. On chip, trusted execution environment enforced via ARM TrustZone.
2. Sealing key is unique to a particular SoC provided by secure fuses,
secure crypto engine etc.
3. Communicates via Secure Monitor Calls (SMCs [5]).

[1] https://globalplatform.org/resource-publication/webinar-an-introduction-to-tee-technology/
[2] [RFC 3/7] tee: add private login method for kernel clients
[3] [RFC 6/7] doc: keys: Document usage of TEE based Trusted Keys
[4] https://optee.readthedocs.io/general/about.html
[5] http://infocenter.arm.com/help/topic/com.arm.doc.den0028b/ARM_DEN0028B_SMC_Calling_Convention.pdf


-Sumit

> Mimi
>
> >
> > >
> > > Patch #1, #2 enables support for registered kernel shared memory with TEE.
> > >
> > > Patch #3 enables support for private kernel login method required for
> > > cases like trusted keys where we don't wan't user-space to directly access
> > > TEE service to retrieve trusted key contents.
> > >
> > > Rest of the patches from #4 to #7 adds support for TEE based trusted keys.
> > >
> > > This patch-set has been tested with OP-TEE based pseudo TA which can be
> > > found here [1].
> > >
> > > Looking forward to your valuable feedback/suggestions.
>
