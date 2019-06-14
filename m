Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D66845410
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Jun 2019 07:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbfFNFhh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 14 Jun 2019 01:37:37 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:37488 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfFNFhh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 Jun 2019 01:37:37 -0400
Received: by mail-lj1-f179.google.com with SMTP id 131so1064267ljf.4
        for <linux-integrity@vger.kernel.org>; Thu, 13 Jun 2019 22:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nZNUHhspX/f3YOWEVEHKyyk596NYJqshHjg/vatkpxY=;
        b=W7/HmZtA2ueqgaDGdxDhZWvZWth1HioqPHWq3uv/ZfYeNDFiTuyQdPlIcFpcuu0z3o
         y6Uev4UXOG5e2S2Wthj/b5CuG5uoZNUQ41OGakG4dyH/tXfB2UroHg2Gx7hFqiJFMRhd
         gHQl567nnlSJFX9DFyvlw8RNWSWPh3lL/QzcclAHfQaZ7Hmb/dnSS3ruthZE4pMa5tAj
         qNEHjhma02SIf4fFrc/C/8hZTObaS9YJgPfGfLn6NshA2iWpqtI9/UJDjLUUosWLA3m2
         v6GAqT6YsvDPsMhcK6xY6KxkpITZc7duRiPE1DrBM6fXGlQ03o6X5Ga4vX7NpAEQzxLA
         ALsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nZNUHhspX/f3YOWEVEHKyyk596NYJqshHjg/vatkpxY=;
        b=KSwHWo2KwFhMp9q/whb2kdnkZZIAkOn+FCdCugJKZiB87+uzf5QCQFVVNRg7J3YClV
         NLEREiqYOgwcnpkKyoQSLdJXJD+IIXrMtSEbd8Lknb8XmWHvfVCDSbtLtgwGNEin4NU7
         d1Pcs5F+jNshjml/LlKA2GEsFEA5DEOPGm7UOlyKLG2bpkHpJDtrwg7IszTnNwn6JaoB
         bBW2BMKZy6L9WimRUG72siKPc9kNbRJXWBTf2kfBgdFpmBZbe0aLsSNODS7Gx7yHMaV6
         p494Hg2gWDMdzg1ojrqhr1AJ9nkbiIOjJXoqDJ3lpYbFRHCdtGynL5Klv+P42JJeR+Uv
         +7Uw==
X-Gm-Message-State: APjAAAUD2YujeShsT1mybUMJflujA8dJQyYiffvhFVhvciA4AF9Xdp7j
        DTNTLBmHifTBgJpGPgG3YlepEv0kmgHXCqKgEnMh8g==
X-Google-Smtp-Source: APXvYqyD8F4fw7/Bk2YoYfYuM4/Zn6eIcYSxGX5Muv3tuAEyNC1m3Hoxr0nrzGDdzQZYfXEpLZ8Y+RHbpI0YCi+CBR8=
X-Received: by 2002:a2e:63d9:: with SMTP id s86mr37708080lje.92.1560490655038;
 Thu, 13 Jun 2019 22:37:35 -0700 (PDT)
MIME-Version: 1.0
References: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
 <1560421833-27414-7-git-send-email-sumit.garg@linaro.org> <20190613153414.GG18488@linux.intel.com>
In-Reply-To: <20190613153414.GG18488@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 14 Jun 2019 11:07:23 +0530
Message-ID: <CAFA6WYP7qi_NBRUDBhcEAEzJY-iFvJdXqtCtgQxqAvPSXDjEng@mail.gmail.com>
Subject: Re: [RFC 6/7] doc: keys: Document usage of TEE based Trusted Keys
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>, corbet@lwn.net,
        dhowells@redhat.com, jejb@linux.ibm.com, zohar@linux.ibm.com,
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

On Thu, 13 Jun 2019 at 21:04, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Thu, Jun 13, 2019 at 04:00:32PM +0530, Sumit Garg wrote:
> > Provide documentation for usage of TEE based Trusted Keys via existing
> > user-space "keyctl" utility. Also, document various use-cases.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>
> Sorry missed this patch. Anyway, I don't think we want multiple trusted
> keys subsystems. You have to fix the existing one if you care to get
> these changes in. There is no really other way around this.
>

I understand your point.

When I initially looked at trusted key implementation, it seemed to be
tightly coupled to use TPM device. So I implemented a parallel
implementation to get initial feedback (functionality-wise) on this
new approach.

I will work on abstraction of trusted key apis to use either approach.
But is it fine with you if I send if I send a separate RFC patch for
abstraction and later once reviewed I will incorporate that patch in
this patch-set.

It will be really helpful if you could help to test that abstraction
patch with a real TPM device as I doesn't posses one to test.

-Sumit

> /Jarkko
