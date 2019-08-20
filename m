Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68916956E6
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Aug 2019 07:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbfHTFwT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Aug 2019 01:52:19 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44542 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729107AbfHTFwT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Aug 2019 01:52:19 -0400
Received: by mail-lf1-f68.google.com with SMTP id v16so3130457lfg.11
        for <linux-integrity@vger.kernel.org>; Mon, 19 Aug 2019 22:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vHAQ6sjGHaPokXl9LscA2e05lIoVzw0cNrU4ejp7cLc=;
        b=HQvqSgy0YUzEMHBgIvYKX0zsNdO2GK/OgcaAI+Yo+QEFURl36YFnDm6QxkYKZLBQfh
         gl6kpBN477j29o3jAxsyCKqzbbwiKtO8wwumBKw+Fy5bbzHiHTBdZo9vYs2WUaOUFk5C
         rfgG0y2dLA/qprCRRnLVrD/nZCVXNgya8cNMMDFfIrGMmj5v5uPhthv3gH/tTj9zqGt7
         2WtXPOqYS6+/elBcXC2Ff66xH3qX8e3ZFThDI6neMyANPzJYKkoNUZUTl+uQUPJQXGYK
         4pORYYX1dPk/YoJ4PVlrOLRxRF6rtiz5mSvpWxKyh+0Fln7DLrG08nF45fRRUJpa5Dg0
         qS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vHAQ6sjGHaPokXl9LscA2e05lIoVzw0cNrU4ejp7cLc=;
        b=qgTo1GR5+Tly+guakcmmCsGmGeW7vNWuU0YnDxWnVC+/Z+xFIv6g4SxofbaDBbPBX/
         qrJhgjZfbSm3RNwNG7iIo/Mo+LSuAxz+djR14XXT7MYqMOdYh7q0x0+4qXCanLyF/7km
         cf8HN0yFumQZh1lhiLb6fBNWmNNeYRrfQsOTpYhsJaYSXpqmOPwI+5ZpYseLz17v10gB
         XOiQDgsrSM/S5aXQph7X/G9GRbikj0N658WY8Yo89XAfGssK5GsQZ2/5jQWrSerDAwZV
         MZuRyElGbxt6og21BOtpbMFIhIzFvrDdBgxRay7jnHD1qXbDbvcJhCNpy5Q0vrhesYwL
         4BZg==
X-Gm-Message-State: APjAAAXtf0MOu1i5scusLTkqAq0bm4g2e/ibVXUE2816Bje4YMXX78C/
        kmXhLIHbRVANkp3cnHCyiO9+zWrP7Z/u+OgxJ2wWRQ==
X-Google-Smtp-Source: APXvYqw5VQhpvfJxXd2kxR0GMuYrecMAqIEichsfrIuwkJJya9Bt9H2v7Gsuv+lSVTPHE4s9++DwaiSgqwaVMZmC/x4=
X-Received: by 2002:ac2:4901:: with SMTP id n1mr14221485lfi.0.1566280337317;
 Mon, 19 Aug 2019 22:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <1565682784-10234-1-git-send-email-sumit.garg@linaro.org>
 <1565682784-10234-2-git-send-email-sumit.garg@linaro.org> <20190819165629.qv7cmg6kiwb6oxig@linux.intel.com>
In-Reply-To: <20190819165629.qv7cmg6kiwb6oxig@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 20 Aug 2019 11:22:05 +0530
Message-ID: <CAFA6WYMoX95UcuGb2UdrUMnq=4wYJChwcMgm8pHHPs_Lg=5iNg@mail.gmail.com>
Subject: Re: [RFC/RFT v4 1/5] tpm: move tpm_buf code to include/linux/
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

On Mon, 19 Aug 2019 at 22:26, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Tue, Aug 13, 2019 at 01:23:00PM +0530, Sumit Garg wrote:
> > Move tpm_buf code to common include/linux/tpm.h header so that it can
> > be reused via other subsystems like trusted keys etc.
> >
> > Also rename trusted keys TPM 1.x buffer implementation to tpm1_buf to
> > avoid any compilation errors.
> >
> > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>
> A question: did you try to do this as mechanically as you ever could
> or did you do any other code changes? I did go through it but it is
> possible that I missed something.
>

There aren't any other code changes apart from "tpm1_buf" rename.

-Sumit

> In this type of changes it is mandatory be extra strict on not doing
> anything extra (the rename you would was not of course extra because
> it was necessary to do).
>
> /Jarkko
