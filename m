Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F34B3CB0E6
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Jul 2021 04:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbhGPC7P (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Jul 2021 22:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbhGPC7O (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Jul 2021 22:59:14 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D5BC06175F
        for <linux-integrity@vger.kernel.org>; Thu, 15 Jul 2021 19:56:19 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id u14so12066102ljh.0
        for <linux-integrity@vger.kernel.org>; Thu, 15 Jul 2021 19:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8xd/rlvQ31BLa83nTsq39bcVtCTaIA+Ws/cHStrw/78=;
        b=VaEJuF6uwnpzYFpmKd0BRN02vDh+Lc3hWQoJoa7srOazeD97xquti3m2pX/byaDWbT
         xPjN4AzOEI3d4micd6dzb7uzN3N7ZQm1uDJWsz/HifdtG3OuNmB46fXmtL7x8Y4MHvKV
         l5E7hHMf/5iST4kNp+xUe212QJNrGWG/fROxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8xd/rlvQ31BLa83nTsq39bcVtCTaIA+Ws/cHStrw/78=;
        b=Btvv81xbCIaFchVMG5HPS6L5w+DHgtvbVA9gRGlLQ0r5s3Ohnw+Prs4lo3w5hjkOuf
         BkAtkKV3sR244aEyy8Im+DRcWMY9JjpgnbpsrlDjtkTFRattuLAQqIfjU6XWk8vRL0sg
         6zKCitYEOrU+r64Ml3ZRyzCGMmp80+OYU6tNqr0PVMhgfBuhgW/gN3CEdVyTv+N3jDVP
         hu/hVq67CF7M44E6+hMZoSdmmIxg/iRTKreAWAcrpIL6y8mbiWhYSVJpK83vjBRuWpUl
         4XJ5vWRMBv9CdH1ypl4rf9A2J7ELsKVvMn1cGcNdkEGOpRGgrimzKQGCGgoj0FQZY+k5
         miEQ==
X-Gm-Message-State: AOAM530S+infDy0ROqryyMYPouFkKO9MuaN0/pCQijiGhTqB0FmBRZZE
        RSJfZNvzZcHR9JLT7MB99WhtXjOyEE8zPTX2YxRP3w==
X-Google-Smtp-Source: ABdhPJxDrSwhyGwFgiho4jlZKLoDvmGAurflyWjHNRcti+Yl2PvjB0IvI4ZjKlqB91QMfk9hLE33Iw9jBxU63natEps=
X-Received: by 2002:a2e:9e18:: with SMTP id e24mr7016639ljk.336.1626404177987;
 Thu, 15 Jul 2021 19:56:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210716022332.GC3232@sequoia>
In-Reply-To: <20210716022332.GC3232@sequoia>
From:   Vikas Gupta <vikas.gupta@broadcom.com>
Date:   Fri, 16 Jul 2021 08:26:06 +0530
Message-ID: <CAHLZf_tpwnE8X8BL4GnhFQMzhh+395qjAdGrxjeM-wGtZ_snCQ@mail.gmail.com>
Subject: Re: [PATCH v5 8/8] firmware: tee_bnxt: Release TEE shm, session, and
 context during kexec
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Allen Pais <apais@linux.microsoft.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        op-tee@lists.trustedfirmware.org, linux-integrity@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000050b53d05c734bbe6"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

--00000000000050b53d05c734bbe6
Content-Type: text/plain; charset="UTF-8"

Hi Tyler/Allen,
 The patch looks good to me.

Thanks,
Vikas


> > From: Allen Pais <apais@linux.microsoft.com>
> >
> > Implement a .shutdown hook that will be called during a kexec operation
> > so that the TEE shared memory, session, and context that were set up
> > during .probe can be properly freed/closed.
> >
> > Additionally, don't use dma-buf backed shared memory for the
> > fw_shm_pool. dma-buf backed shared memory cannot be reliably freed and
> > unregistered during a kexec operation even when tee_shm_free() is called
> > on the shm from a .shutdown hook. The problem occurs because
> > dma_buf_put() calls fput() which then uses task_work_add(), with the
> > TWA_RESUME parameter, to queue tee_shm_release() to be called before the
> > current task returns to user mode. However, the current task never
> > returns to user mode before the kexec completes so the memory is never
> > freed nor unregistered.
> >
> > Use tee_shm_alloc_kernel_buf() to avoid dma-buf backed shared memory
> > allocation so that tee_shm_free() can directly call tee_shm_release().
> > This will ensure that the shm can be freed and unregistered during a
> > kexec operation.
> >
> > Fixes: 246880958ac9 ("firmware: broadcom: add OP-TEE based BNXT f/w manager")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Allen Pais <apais@linux.microsoft.com>
> > Co-developed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > ---
> >  drivers/firmware/broadcom/tee_bnxt_fw.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/firmware/broadcom/tee_bnxt_fw.c b/drivers/firmware/broadcom/tee_bnxt_fw.c
> > index ed10da5313e8..a5bf4c3f6dc7 100644
> > --- a/drivers/firmware/broadcom/tee_bnxt_fw.c
> > +++ b/drivers/firmware/broadcom/tee_bnxt_fw.c
> > @@ -212,10 +212,9 @@ static int tee_bnxt_fw_probe(struct device *dev)
> >
> >       pvt_data.dev = dev;
> >
> > -     fw_shm_pool = tee_shm_alloc(pvt_data.ctx, MAX_SHM_MEM_SZ,
> > -                                 TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
> > +     fw_shm_pool = tee_shm_alloc_kernel_buf(pvt_data.ctx, MAX_SHM_MEM_SZ);
> >       if (IS_ERR(fw_shm_pool)) {
> > -             dev_err(pvt_data.dev, "tee_shm_alloc failed\n");
> > +             dev_err(pvt_data.dev, "tee_shm_alloc_kernel_buf failed\n");
> >               err = PTR_ERR(fw_shm_pool);
> >               goto out_sess;
> >       }
> > @@ -242,6 +241,14 @@ static int tee_bnxt_fw_remove(struct device *dev)
> >       return 0;
> >  }
> >
> > +static void tee_bnxt_fw_shutdown(struct device *dev)
> > +{
> > +     tee_shm_free(pvt_data.fw_shm_pool);
> > +     tee_client_close_session(pvt_data.ctx, pvt_data.session_id);
> > +     tee_client_close_context(pvt_data.ctx);
> > +     pvt_data.ctx = NULL;
> > +}
> > +
> >  static const struct tee_client_device_id tee_bnxt_fw_id_table[] = {
> >       {UUID_INIT(0x6272636D, 0x2019, 0x0716,
> >                   0x42, 0x43, 0x4D, 0x5F, 0x53, 0x43, 0x48, 0x49)},
> > @@ -257,6 +264,7 @@ static struct tee_client_driver tee_bnxt_fw_driver = {
> >               .bus            = &tee_bus_type,
> >               .probe          = tee_bnxt_fw_probe,
> >               .remove         = tee_bnxt_fw_remove,
> > +             .shutdown       = tee_bnxt_fw_shutdown,
> >       },
> >  };
> >
> > --
> > 2.25.1
> >
>
> ----- End forwarded message -----

--00000000000050b53d05c734bbe6
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
I7qKxvF8Yo7eGTnHRTa99J+6yTd88AKVuhM5TEhpC8cS7qvrQXJje+Uing2xWC4FH76LEWIFH0Pt
x8C1WoCU0ClXHU/XfzH2mYrFANBSCeP1Co6QdEfRAgMBAAGjggHZMIIB1TAOBgNVHQ8BAf8EBAMC
BaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJlLmdsb2JhbHNp
Z24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYIKwYBBQUHMAGG
NWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwME0G
A1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxz
aWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqGOGh0dHA6Ly9j
cmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3JsMCMGA1UdEQQc
MBqBGHZpa2FzLmd1cHRhQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSME
GDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUUc6J11rH3s6PyZQ0zIVZHIuP20Yw
DQYJKoZIhvcNAQELBQADggEBALvCjXn9gy9a2nU/Ey0nphGZefIP33ggiyuKnmqwBt7Wk/uDHIIc
kkIlqtTbo0x0PqphS9A23CxCDjKqZq2WN34fL5MMW83nrK0vqnPloCaxy9/6yuLbottBY4STNuvA
mQ//Whh+PE+DZadqiDbxXbos3IH8AeFXH4A1zIqIrc0Um2/CSD/T6pvu9QrchtvemfP0z/f1Bk+8
QbQ4ARVP93WV1I13US69evWXw+mOv9VnejShU9PMcDK203xjXbBOi9Hm+fthrWfwIyGoC5aEf7vd
PKkEDt4VZ9RbudZU/c3N8+kURaHNtrvu2K+mQs5w/AF7HYZThqmOzQJnvMRjuL8xggJtMIICaQIB
ATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhH
bG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwYjepatB64S625eswwDQYJ
YIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIF9KjhFQJE4iiAEeTDfVw9IDkgM97/+WVjJe
jJYNF1JSMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIxMDcxNjAy
NTYxOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFl
AwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATAN
BgkqhkiG9w0BAQEFAASCAQAA2r3bkKsEeRuN4imCQJUn2ux/awCLcb+/CPT396EhP64vqebS17I2
Rv+A1tyYK4N0ZaJ0J9hqwgxW+4FeJFQV1hvU5rAarbRhKP92SMZvTio/+ioT4PDE7VVXD0HcsbEB
zJ2jCKOvZ8oaptm+ApkA/NgCZO7J2fK4yhRtm+7dPj+qC3mHYZET2f+KjMtQF+75Yd3YPyBoZ7TG
U4fZLDdp2NnXAl+mVGoHRH5TTsMHeBmR4shKG8OhnPbXhF2tHONCPtjVLFVlxFIfMP1wN31it04T
lKoMzyfWOqubJ8iT2bkSAiyj0kMktbYHYfBollz2IfZPx9Mzc7CJAL2jm97c
--00000000000050b53d05c734bbe6--
