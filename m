Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEE5956EF
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Aug 2019 07:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbfHTFyG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Aug 2019 01:54:06 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45710 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728206AbfHTFyF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Aug 2019 01:54:05 -0400
Received: by mail-lj1-f193.google.com with SMTP id l1so3911896lji.12
        for <linux-integrity@vger.kernel.org>; Mon, 19 Aug 2019 22:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IaeMGDmGKxX8wxK8cdDbGY1eDp+Ld1z3eVWTJJyayFE=;
        b=TS7SGgjEzTreybigsAv3qVsuN075oTJVKpFp88ofnjJbbEJZAgthB8vDgLgvRLnLUS
         ++vjrM9g7gE2SN4igmXwiI7zyfyNMmtdmu3w8qOi/PtuwRPhsGTVmjVqf80oUjz0Gota
         KLbMPEV3aXizb/qctuOZlv9r2CXJfJWF7uuuHs78yPoxVzArINw/TpZXQhP90Z1WSRqe
         zB4Oi3RyIcR/OK3OCmRD6nczrw6lo6HvpTS129UjNx1gW4G5bbkeuDsV2cOsphJgjiUm
         9KFiqRv2wgsOonNC64H6p5NykM5elpfOcC8VJddEJHVgky5Tbc+GOLM3TWgFH7iWMy3U
         aYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IaeMGDmGKxX8wxK8cdDbGY1eDp+Ld1z3eVWTJJyayFE=;
        b=WpX2p/0Enr7iU9hj0Wf8VEVsm2jSK+Zb+u6WdiOcXRgM8/zhusxuIQvyvFri7Qa3oy
         vFeookxHCB5dLbxQh7OlZf2E9yg62bASdwCw8PR4/pzimAcDesfjq0/zlR9hxOvzphyz
         qVkB5clkvmbdZ5ucmPSyQHCFjxZn9iGidY12ug+N0voAPxeU+EYZVe4X3+kM6z3HjhyT
         Ny5h1PhPSY++Ag6Lnp3V6NCykfUzoQ2eX43KSw4VxsFzWVw2GZZ4YUFSlrhOUtXjZ5w5
         Zk0NcjvtpEaYZ6kz2ncSDTyS9QxQPe69XHaSJCUiqTKFMl88j7WGISG1ix80WfV0j0Lq
         adkA==
X-Gm-Message-State: APjAAAUKpTeMBp9ezwQYhDhFyhpGfmXOb0/OlqjeY52Xj6hPvrHndCaV
        bkYvu8HZDCHVjxHf4HMo0gK7fQL5RcWFhwaW02N9Pg==
X-Google-Smtp-Source: APXvYqxDON+ceMUmjzSzpMq37WQzohKgTpxzAYYEzr9bWHlarBKWsHRjGcZO8/n74pOlmwou6eEdk+97uPN2CZG7nig=
X-Received: by 2002:a2e:87c5:: with SMTP id v5mr13283366ljj.115.1566280443691;
 Mon, 19 Aug 2019 22:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <1565682784-10234-1-git-send-email-sumit.garg@linaro.org>
 <1565682784-10234-4-git-send-email-sumit.garg@linaro.org> <20190819170458.m7adhkji64kta32d@linux.intel.com>
 <20190819170635.jlxxi6ogbm4s6gcx@linux.intel.com>
In-Reply-To: <20190819170635.jlxxi6ogbm4s6gcx@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 20 Aug 2019 11:23:51 +0530
Message-ID: <CAFA6WYOTYhJ3kGYFGU9rxnxqFqMFMhVXfVYq+3bepOax92fLSg@mail.gmail.com>
Subject: Re: [RFC/RFT v4 3/5] KEYS: trusted: create trusted keys subsystem
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

On Mon, 19 Aug 2019 at 22:36, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Mon, Aug 19, 2019 at 08:04:58PM +0300, Jarkko Sakkinen wrote:
> > On Tue, Aug 13, 2019 at 01:23:02PM +0530, Sumit Garg wrote:
> > > Move existing code to trusted keys subsystem. Also, rename files with
> > > "tpm" as suffix which provides the underlying implementation.
> > >
> > > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > ---
> > >  crypto/asymmetric_keys/asym_tpm.c                       | 2 +-
> > >  include/keys/{trusted.h => trusted_tpm.h}               | 4 ++--
> > >  security/keys/Makefile                                  | 2 +-
> > >  security/keys/trusted-keys/Makefile                     | 7 +++++++
> > >  security/keys/{trusted.c => trusted-keys/trusted-tpm.c} | 2 +-
> > >  5 files changed, 12 insertions(+), 5 deletions(-)
> > >  rename include/keys/{trusted.h => trusted_tpm.h} (98%)
> > >  create mode 100644 security/keys/trusted-keys/Makefile
> > >  rename security/keys/{trusted.c => trusted-keys/trusted-tpm.c} (99%)
> >
> > Would prefer trusted_tpm.c.
>
> Actually, trusted_tpm1.c.
>

Okay.

-Sumit

> /Jarkko
