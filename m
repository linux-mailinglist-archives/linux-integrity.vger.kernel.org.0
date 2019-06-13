Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B65943817
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Jun 2019 17:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732543AbfFMPD1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jun 2019 11:03:27 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37913 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732495AbfFMOX2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jun 2019 10:23:28 -0400
Received: by mail-io1-f66.google.com with SMTP id k13so17272875iop.5
        for <linux-integrity@vger.kernel.org>; Thu, 13 Jun 2019 07:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YOkGT1KIxTydfc//oUhWW5qv+v1zc6TApVXVTHnuiBk=;
        b=u9W4Ip1SP17N3CMFC0jAgqw3/YCf1mjljApAKab6FyIk/0lSaR9QRCtVuXQBJPoce4
         HxaxZd0q32m4aA1vZj2VX3h3IyI7P/rcbwYk13PXuJsSlv6rWlKioMkguiV/92+5nBRF
         F9SzazSY7gdyB5ZiVWlbxAS219PzVwSFyYOhmVr/xrBp3xGihlpgQXGsEsit8B8qDjbU
         AP470YMK0ikMrhW4bGl8U8ZmYJHjIrfUn6B9uAvo4fs7DpFTR0bdPf2/tI5Qphy1HO8Y
         7l6lnvoTCOI9rci2G8fSYjp/z/Z1/Sa0KxaV7qbMksPAzPiaVHoFQXPG63mMFRGdwt+r
         aAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YOkGT1KIxTydfc//oUhWW5qv+v1zc6TApVXVTHnuiBk=;
        b=hZZmBXXTCuxDoT2svdGknkvxwPQXw2F4QypNM6nt9NveLk98kfNpJmQaZGg9mUDbjf
         SWM/NBIWLpgtiOQGRejqIzqHkssg3GmFnqFAe/HTjZRK44G/br028M2WUczMMOZI2/0Y
         rSuN55AJK2LpzjmMlFxr7MKhWDEtAacUfNQar4mOwKC5++1Ej514db16riZImgOS68Nk
         rcfTxFpb652FfqwPqT6iLjniH1ET8VZS48TpkPG7MQpDIWSyQgYQFrgu5cAg6C1RNsKJ
         8nMon5Bz0HaGgXvu0ineqp58TBaiaBCANBMTGNIA6H/vOHtOPlc7ovifAW/lewp6nrXx
         RcFA==
X-Gm-Message-State: APjAAAUL13KDBITjL0rvAMVAPGyoqNA1oik0zqhUmeQnh4TJ5NsV4FTA
        S2NpLmvXcfOW8R55RN4q+OQ5V738AsVYSTHC6jy7frtQM+0=
X-Google-Smtp-Source: APXvYqySOWyS2ZP9Mgdhpfz4IsLEVqbSwM6UU/jOunxH/EWnFp0zHvdh9z5miYCq61vyXmCSTiFJ0K46W0yL85439jA=
X-Received: by 2002:a5d:9d97:: with SMTP id 23mr4599191ion.204.1560435807048;
 Thu, 13 Jun 2019 07:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190607205147.102904-1-matthewgarrett@google.com>
 <20190607205147.102904-2-matthewgarrett@google.com> <CAKv+Gu-Vz8OSspw9RdEnVj3e7GFaNdA9PVVMWY2RKkEDfAbuRA@mail.gmail.com>
 <20190613140643.GE12791@linux.intel.com>
In-Reply-To: <20190613140643.GE12791@linux.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 13 Jun 2019 16:23:15 +0200
Message-ID: <CAKv+Gu_tacPw-71bgC7WMgSQvN28kWujdmfCgTT5WESF0e=f8A@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] tpm: Don't duplicate events from the final event
 log in the TCG2 log
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Matthew Garrett <matthewgarrett@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        =?UTF-8?Q?Peter_H=C3=BCwe?= <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-efi <linux-efi@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        Joe Richey <joerichey@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 13 Jun 2019 at 16:06, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Fri, Jun 07, 2019 at 11:11:21PM +0200, Ard Biesheuvel wrote:
> > Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> Ard, is it cool if I include these to my next TPM PR along with the
> other Matthew's changes? Just sanity checking given that crossing
> subsystems...
>

Yes, that is fine.
