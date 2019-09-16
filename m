Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65786B3884
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Sep 2019 12:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732109AbfIPKoY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Sep 2019 06:44:24 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42167 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfIPKoY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Sep 2019 06:44:24 -0400
Received: by mail-lf1-f65.google.com with SMTP id c195so12163874lfg.9
        for <linux-integrity@vger.kernel.org>; Mon, 16 Sep 2019 03:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4TMJJQeWGJA8VF71xE0hPDEpdbOukphgb+fbEU6PJrk=;
        b=RW+t8PFYU2pHIMbRwc7SVm7BgzMbwX3dW9LgE3kDXgwS0Bo1gacYCvgYwQIvvHjbfW
         I2+0dYRvIvMsrLH+rrvpbJNdU59ak0GruD9Y28GK3oATrOUBQR8ZB4MBTnZaV1IgBzHc
         s9K8ioFjcPm+FHgxRXnsYxmukxUwNSm0rJ2ojtEXoB4vO+7EO+H2GRedneUXs1JmwEJK
         vDFmDEXBFbcW+JCzvRZUUqJiTnxlPEU6n43ZYeT0ZGXd5T0shA1ZsoyROVSkNNAsZEzG
         jWb169w221/OuDahAG8iLDWqwsx0VEN2U92lRFV2CYdky34D3MLbgvtYlW6oLTbEsWJ8
         t2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4TMJJQeWGJA8VF71xE0hPDEpdbOukphgb+fbEU6PJrk=;
        b=t7q0C+sm8Z6joYNufsnLAzpDDBfj7jLDozw4KGYFFR2Aynl9S796lfi8gGQTFndHlp
         VXSXC5vILzvAhYZLRLx8iEwMrKu3TTU17+9hAwbGPF+BJESg03/c7+Gsz2nDFt9jgBOV
         aFM9q2l+k+KCC7NFRakd5u+k1s22ZHWtazh1CZOXffu7vL4zR1TBZJyORe4n2G4SDINE
         EMD7fFQ4xlfR4e1kqOP5vjZvSIgNHiaYewv38yc7byK+HcKdsCtMHGpaUaSKaocGlM0j
         u2uYUoGvQtJef6Vb9bOsMxURI/Q6r5539PWiWvpYbIpRBpISwf7fvPe/oJn5NfK032Mk
         kf9g==
X-Gm-Message-State: APjAAAVeFbeZceGDys0CV9HCVtRsz1onMyvsATv+K58QFxH5+jLMtgym
        H4Rai0wsJ3niLeySfiDuxzzgTQ+ptGIoTi7qd1EffQ==
X-Google-Smtp-Source: APXvYqwN4zfNV74BLwgIXx4X2c03lAb9auaVc/LbzTY2tQotezdZhD7wXF8tfwn2M2w8XBQid2GoaBLnon4NI0i+reg=
X-Received: by 2002:a05:6512:304:: with SMTP id t4mr39208602lfp.15.1568630661777;
 Mon, 16 Sep 2019 03:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <1568157511-5464-1-git-send-email-zohar@linux.ibm.com>
 <1568157876.4991.3.camel@linux.ibm.com> <1568203240.5783.8.camel@linux.ibm.com>
 <20190913140820.GC29755@linux.intel.com> <1568580742.5055.0.camel@linux.ibm.com>
 <1568604471.4975.8.camel@linux.ibm.com> <20190916074225.fouluhpylge6fmlj@cantor>
In-Reply-To: <20190916074225.fouluhpylge6fmlj@cantor>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 16 Sep 2019 16:14:09 +0530
Message-ID: <CAFA6WYMdLLOe87BN5mD78A4vkmXPesco+QZXTY6uDgTYqPnong@mail.gmail.com>
Subject: Re: [PATCH] selftest/trustedkeys: TPM 1.2 trusted keys test
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Petr Vorel <pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 16 Sep 2019 at 13:19, Jerry Snitselaar <jsnitsel@redhat.com> wrote:
>
> On Sun Sep 15 19, Mimi Zohar wrote:
> >On Sun, 2019-09-15 at 16:52 -0400, Mimi Zohar wrote:
> >> On Fri, 2019-09-13 at 15:08 +0100, Jarkko Sakkinen wrote:
> >> > On Wed, Sep 11, 2019 at 08:00:40AM -0400, Mimi Zohar wrote:
> >> > > On Tue, 2019-09-10 at 19:24 -0400, Mimi Zohar wrote:
> >> > > > On Tue, 2019-09-10 at 19:18 -0400, Mimi Zohar wrote:
> >> > > > > Create, save and load trusted keys test
> >> > > >
> >> > > > Creating trusted keys is failing with the following messages.  Any idea why?
> >> > > >
> >> > > > [  147.014653] tpm tpm0: A TPM error (34) occurred attempting to a send a command
> >> > > > [  147.014678] trusted_key: srkseal failed (-1)
> >> > > > [  147.014687] trusted_key: key_seal failed (-1)
> >> > >
> >> > > This is a regression, that needs to be resolved.  The test works on
> >> > > kernels prior to 5.1.
> >> >
> >> > It breaks on 5.2?
> >>
> >> No, the regression is in 5.1.
> >>
> >> >
> >> > Can you bisect the failing commit?
> >>
> >> git bisect start -- drivers/char/tpm/
> >> git bisect bad
> >> git bisect good v5.0
> >>
> >> # first bad commit: [412eb585587a1dc43c9622db79de9663b6c4c238] tpm:
> >> use tpm_buf in tpm_transmit_cmd() as the IO parameter
> >
> >In tpm_send(), setting buf.data directly to cmd, instead of calling
> >tpm_buf_init() fixes the problem.
> >
> >Mimi
> >
> >
>
> The problem is that the command buffer is copied into the tpm_buf with
> the memcpy, but after the tpm_transmit_cmd, nothing gets copied back
> to be used by the code path that called tpm_send. There is code that
> looks at that buffer after trusted_tpm_send returns. Both
> security/keys/trusted.c and crypto/asymmetric_keys/asym_tpm.c run into
> this.
>
> While playing around with it, adding a memcpy() after the transmit
> call worked for me as well as setting buf.data directly instead of the
> tpm_buf_init/memcpy/tpm_buf_destroy calls.
>
> I'm wondering if it would be worthwhile to convert the
> security/keys/trusted.c and crypto/asymmertic_keys/aym_tpm.c code to
> use the same tpm_buf and tpm_buf manipulation code as gets used in
> drivers/char/tpm.

This is exactly what patch #2 in this patch-set [1] tries to achieve.

[1] https://lkml.org/lkml/2019/9/16/196

-Sumit
