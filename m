Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 195068B1DD
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Aug 2019 09:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbfHMH7d (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Aug 2019 03:59:33 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43585 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727933AbfHMH7c (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Aug 2019 03:59:32 -0400
Received: by mail-lj1-f196.google.com with SMTP id h15so7013058ljg.10
        for <linux-integrity@vger.kernel.org>; Tue, 13 Aug 2019 00:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ppVR4stowlIJ6/4pZZBiqz7XFOa7GBtQMtynjohKpDM=;
        b=gMNzHJkjPlTKg8J3P1ItvpHxlkyUzWeShHE+QJSJ32VauPTGnzGKsD+QuZrHHI76pj
         RQaLjgiFHttMYl1YL5egx0p1M2IIOgyXxDeB1ftBhbKgE91RpNxJqdP+/QCc15BfoOhL
         Z1+PP778xl2OwXclKn24vrxEMqdB2zsz1S9Mo+1+LLBC3XvBF1qfh81VIeKQdgw15Wfs
         3UPAiB+GQfna3uzgBhqY2DIQZ1U1Dd6wdEjtIkq7MQrftD+JJ76fJF/zUJB30qtgXZ8g
         gkbmkqgpWNNJ+9OWrPYhYkczySrcOktUtmOi5kVY6tzWBM01UKaeDCvccNuWK35inzMd
         u0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ppVR4stowlIJ6/4pZZBiqz7XFOa7GBtQMtynjohKpDM=;
        b=EOa7L+9nKGRAzbWaQyv9uT+bnMxViNTfe/J93Tux0JuXQEny4z6kryORkecwPVfdzN
         4uJ++JvSX2yGb6i1VqK04AbnqxOzT1wDnDGayOE5GJbAPn9h9IswXPolOa5lt3XUG5g7
         SUFm4LTAZyl+ni9EBNz6uE1Ozj9wcHRTU0Bs3We8Q497QJnPHAAtsjH4p5m8vxIGcWEO
         fXwDfr8EaJ7A6SOanPfgMYcKLpUOsPwfiaGihawte2gZYAI2YjvR08VuqgWTJde8bYtn
         uRza7Mzk+6y1nryAOvbXAzd/oPjYsbsG/3yFy+CFYjiz1Pg4hCDkVtP30DF3zJlnbjl9
         3BVA==
X-Gm-Message-State: APjAAAVUQab1+8tQRG5rrHNMQ3n3OR5oFqIK92QvFRSLb51tRguIH9xu
        G8T1aRPAxRTD83d9EyZu0PQltqkri+eboeVGoUZu1A==
X-Google-Smtp-Source: APXvYqy9Xa1Q8vdR2OCkDVG7ShxG5L9IQXmi6qKK2LlN8HtiapeB1JlrnTXdtXIphrZmMJ+SZciCiafKR0IU/QMDd44=
X-Received: by 2002:a2e:970a:: with SMTP id r10mr19876829lji.115.1565683170315;
 Tue, 13 Aug 2019 00:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <1565098640-12536-1-git-send-email-sumit.garg@linaro.org>
 <1565098640-12536-3-git-send-email-sumit.garg@linaro.org> <20190807190320.th4sbnsnmwb7myzx@linux.intel.com>
 <CAFA6WYN-6MpP2TZQEz49BmjSQiMSqghVFWRZCCY0o1UVad1AFw@mail.gmail.com> <20190808151500.ypfcqowklalu76uq@linux.intel.com>
In-Reply-To: <20190808151500.ypfcqowklalu76uq@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 13 Aug 2019 13:29:19 +0530
Message-ID: <CAFA6WYNqBH9aAM-uke6jFTCeLB2GG7UYyrYEPHgyVy8p_q+Pww@mail.gmail.com>
Subject: Re: [RFC/RFT v3 2/3] KEYS: trusted: move tpm2 trusted keys code
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

On Thu, 8 Aug 2019 at 20:46, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Thu, Aug 08, 2019 at 06:51:38PM +0530, Sumit Garg wrote:
> > It seems to be a functional change which I think requires proper unit
> > testing. I am afraid that I don't posses a TPM device to test this and
> > also very less conversant with tpm_buf code.
> >
> > So what I have done here is to rename existing TPM 1.x trusted keys
> > code to use tpm1_buf.
> >
> > And I would be happy to integrate a tested patch if anyone familiar
> > could work on this.
>
> I can test it on TPM 1.2.
>

I have posted v4 with changes as you requested. I hope they work well
with a real TPM 1.x or TPM 2.0 device.

-Sumit

> /Jarkko
