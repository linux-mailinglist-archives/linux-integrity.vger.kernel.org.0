Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83E848113E
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Aug 2019 07:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfHEFDN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Aug 2019 01:03:13 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44828 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfHEFDN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Aug 2019 01:03:13 -0400
Received: by mail-lf1-f66.google.com with SMTP id v16so2999364lfg.11
        for <linux-integrity@vger.kernel.org>; Sun, 04 Aug 2019 22:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=59rGgYKXfbOVeORIb/3aPCsYO+up32tSP1XLT583cgM=;
        b=Pp7rr9JWyW8rvNf7mskAanI9AtGCJ6FROK5Y/83r2NqcfGniuX15dpaNbFLBKhal8P
         wcn6BAM1OS2b7l9JhEUu+FS4jI0d/3GAs5fSPHIOYeXXTcNlYrreX9QFYp2amkc/us3n
         fPQS0IYuedLccQz4EBV6PVVi4j1lGml4t6nHKJjsvODNUqz+ZKWMwtQ4XS8y7BbkFPlR
         UfGU2a2Vdilwtonwk61BmmALDw8mJueH6lj6efGPTYSB54fQ4ghZlgkmuLk0TB4C9uCT
         q+r1ixbNM2GsHvVAAVMDTBsMBXdUeRcU3exa0a88mrKmpwKKtzY2uB0ycJSYruz7r9JQ
         GjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=59rGgYKXfbOVeORIb/3aPCsYO+up32tSP1XLT583cgM=;
        b=ouosacUEezPip0DoZdZhUphL2mA2EIQzKjMeKCVdYxN0Tgi/VekE17pUdA35lNY8+e
         NoloI1I7Bh86dZY1UNUi5G1yygOadVF8D9csM7t7/GDL8349kBEqOXgJVwGib3MpMuA/
         +1fIOU/rsBrlhOgbg6kC1v06/wvNxORcStoQ20OmooLLgGZuLD3Uhrobjdv6hkJFQ9JQ
         FmHPdLsnnHEn/klp1JIf90Gauyk2jAEt9s0/UgPn6iG41od/FCZtfoBK+SQsOLml9LvX
         l2CuWRxAql9FP9mcaLDuyuSPbuFnsO8hrNGgavaAjvUV0+wnR/OrsvMeQlZ2QV9GaEef
         voPw==
X-Gm-Message-State: APjAAAWO4c+YhJvvI2a91G/u1BU8X6kRESLuz3P3pD2Uqj7cyCkOxD/v
        k2m3yo3s/ls8bCw7aabYrraZklpZAVeW5xB310BXXw==
X-Google-Smtp-Source: APXvYqy5gh4FUNfT5zeuzGIzpHixqpgMfXNy82xJgmEg1C0rn6VH0AyjgsO7hoUJnb3lPf96FzNFy/x/O14eI0YZFv4=
X-Received: by 2002:a19:c7ca:: with SMTP id x193mr14674281lff.151.1564981391240;
 Sun, 04 Aug 2019 22:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <1563449086-13183-1-git-send-email-sumit.garg@linaro.org>
 <1563449086-13183-2-git-send-email-sumit.garg@linaro.org> <20190801172310.cldcftfdoh5vyfjg@linux.intel.com>
 <CAFA6WYM+FQuXA9Saj5+ffOGsc-shhiF5Uos4g14Qndvu6w97Sg@mail.gmail.com> <20190802193802.jn56jhoz5crebggt@linux.intel.com>
In-Reply-To: <20190802193802.jn56jhoz5crebggt@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 5 Aug 2019 10:32:59 +0530
Message-ID: <CAFA6WYOMXc2y=vXOwRv+PYyF8oBV70G7CrJ81jvD5yJT41zLZw@mail.gmail.com>
Subject: Re: [RFC/RFT v2 1/2] KEYS: trusted: create trusted keys subsystem
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        jejb@linux.ibm.com, Mimi Zohar <zohar@linux.ibm.com>,
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

On Sat, 3 Aug 2019 at 01:08, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Fri, Aug 02, 2019 at 11:20:09AM +0530, Sumit Garg wrote:
> > On Thu, 1 Aug 2019 at 22:54, Jarkko Sakkinen
> > <jarkko.sakkinen@linux.intel.com> wrote:
> > >
> > > On Thu, Jul 18, 2019 at 04:54:45PM +0530, Sumit Garg wrote:
> > > > Move existing code to trusted keys subsystem. Also, rename files with
> > > > "tpm" as suffix which provides the underlying implementation.
> > > >
> > > > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > >
> > > What about TPM2 trusted keys code?
> >
> > Isn't TPM2 code located here: "drivers/char/tpm/"? Would you like to
> > move that code under trusted keys subsystem only?
>
> Yeah, we need a design decision here. What I care is that they should
> be in the same subsystem. I did trusted keys directly to TPM 2.0 subsys
> because the subsystem was not too robust back then.
>
> Right now I think it would be feasible to implement TPM2 trusted keys
> outside TPM driver since the whole transmit functionality is way more
> robust.
>

Okay, I will try to move TPM2 trusted keys code also.

-Sumit

> /Jarkko
