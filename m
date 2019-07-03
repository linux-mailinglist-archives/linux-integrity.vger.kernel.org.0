Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9A085DE5A
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2019 08:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfGCG6T (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 3 Jul 2019 02:58:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37817 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfGCG6T (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Jul 2019 02:58:19 -0400
Received: by mail-wr1-f68.google.com with SMTP id v14so1388477wrr.4
        for <linux-integrity@vger.kernel.org>; Tue, 02 Jul 2019 23:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7NIH8CFjAMNOmJLuHgmNt9jeNJYxR5K2QbGvBFYhPyM=;
        b=zQl30MMYhx8iWYLwIlLcv/0wck1BuceVHDEuRd2T38gMScJknOBuV9dIia/OxTsOne
         UiekeRlnsmdKKem6TxZ7FnAX7OwFWc0t1yboi4SJPCLz0SePEH6zy9YglOjh3zK3As7e
         U5frAhWsfFf2lcvoSrnaeCOKdho5ZmrzWbcbgW31fh6FCLixroxYU/emHdGuqsj8+xZX
         5P1osZUnAolbMmu6Uyw6cMoqYTwq37eWPnCvDjLXvg3hkv/3ZyxqRoBKnIeQlX0NBIub
         hkiOCkOscL99ZtTxTaY2pFPk236kNhq13Et10x2UsdzqorQ3g2R76Mt4H7Vk/6UDLbbZ
         Spmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7NIH8CFjAMNOmJLuHgmNt9jeNJYxR5K2QbGvBFYhPyM=;
        b=QJUYyjBmxfEvaH0CbAOCZJtTAeF7sJsdpnbLGjyCndDkBZe/zCTpagii0grLbe+ih5
         xopEQ0a4mblRlINFpklsF0tlW9uFhNE5A/b1YyGxBgClrIC2s3s7fxmZQAl8ootPm+3+
         qU3jAc9MoguHyzHwGMCw15Yxs9IRefbTm6I3N3sZgaYY8Wd08/dT7dn6gv0A0f0r4aVe
         lrRq8yjZ/1jZMjZ/83RpwmOtQCsYEve+GAuO7H8jdRzRS6zpuBpx/HDGs/W70TMP7opi
         AnxqOihOu3HBhFIJDLFvV8L0LRO3HoblTB7sESFB8SGy6oE+s/LC50A8pJ92oVCIruUY
         1CPw==
X-Gm-Message-State: APjAAAUXN684wpE/GDWjIOpF1cC2TioZ62WGntTzEAjE9X67waqeJ/Ki
        G1kLgAnsCOIZcoDo4yxtKlMLBg==
X-Google-Smtp-Source: APXvYqw/X5rM8ZDYSaQMfFrQjrC5Br42gx2+HjM1yZXBgIo539ABva79LWol9ilB7gBuqGDXalghlQ==
X-Received: by 2002:adf:b748:: with SMTP id n8mr1825265wre.268.1562137096980;
        Tue, 02 Jul 2019 23:58:16 -0700 (PDT)
Received: from apalos (athedsl-428434.home.otenet.gr. [79.131.225.144])
        by smtp.gmail.com with ESMTPSA id g14sm1287678wro.11.2019.07.02.23.58.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 23:58:16 -0700 (PDT)
Date:   Wed, 3 Jul 2019 09:58:13 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Thirupathaiah Annapureddy <thiruan@microsoft.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Microsoft Linux Kernel List <linux-kernel@microsoft.com>,
        "Bryan Kelly (CSI)" <bryankel@microsoft.com>,
        "tee-dev@lists.linaro.org" <tee-dev@lists.linaro.org>,
        "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>
Subject: Re: [PATCH v7 1/2] fTPM: firmware TPM running in TEE
Message-ID: <20190703065813.GA12724@apalos>
References: <20190625201341.15865-1-sashal@kernel.org>
 <20190625201341.15865-2-sashal@kernel.org>
 <673dd30d03e8ed9825bb46ef21b2efef015f6f2a.camel@linux.intel.com>
 <20190626235653.GL7898@sasha-vm>
 <b688e845ccbe011c54b10043fbc3c0de8f0befc2.camel@linux.intel.com>
 <20190627133004.GA3757@apalos>
 <0893dc429d4c3f3b52d423f9e61c08a5012a7519.camel@linux.intel.com>
 <20190702142109.GA32069@apalos>
 <CY4PR21MB0279B99FB0097309ADE83809BCF80@CY4PR21MB0279.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR21MB0279B99FB0097309ADE83809BCF80@CY4PR21MB0279.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Thirupathaiah,
> 
> First of all, Thanks a lot for trying to test the driver. 
> 
np

[...]
> > I managed to do some quick testing in QEMU.
> > Everything works fine when i build this as a module (using IBM's TPM 2.0
> > TSS)
> > 
> > - As module
> > # insmod /lib/modules/5.2.0-rc1/kernel/drivers/char/tpm/tpm_ftpm_tee.ko
> > # getrandom -by 8
> > randomBytes length 8
> > 23 b9 3d c3 90 13 d9 6b
> > 
> > - Built-in
> > # dmesg | grep optee
> > ftpm-tee firmware:optee: ftpm_tee_probe:tee_client_open_session failed,
> > err=ffff0008
> This (0xffff0008) translates to TEE_ERROR_ITEM_NOT_FOUND.
> 
> Where is fTPM TA located in the your test setup? 
> Is it stitched into TEE binary as an EARLY_TA or 
> Is it expected to be loaded during run-time with the help of user mode OP-TEE supplicant?
> 
> My guess is that you are trying to load fTPM TA through user mode OP-TEE supplicant. 
> Can you confirm? 
I tried both

> If that is the true, 
> - In the case of driver built as a module (CONFIG_TCG_FTPM_TEE=m), this is works fine 
> as user mode supplicant is ready. 
> - In the built-in case (CONFIG_TCG_FTPM_TEE=y), 
> This would result in the above error 0xffff0008 as TEE is unable to find fTPM TA. 
Maybe i did something wrong and never noticed it wasn't built as an earlyTA

> 
> The expectation is that fTPM TA is built as an EARLY_TA (in BL32) so that
> U-boot and Linux driver stacks work seamlessly without dependency on supplicant.  
> 
You can add my tested-by tag for the module. I'll go back to testing it as
built-in at some point in real hardware and let you know if i have any issues.

If someone's is interested in the QEMU testing: 
1. compile this https://github.com/jbech-linaro/manifest/blob/ftpm/README.md
2. replace the whole linux kernel on the root-dir with a latest version + fTPM 
char driver
3. Apply a hack on kernel and disable dynamic shm (Need for this depends on 
kernel + op-tee version)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 1854a3db..7aea8a5 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -588,13 +588,15 @@ static struct optee *optee_probe(struct device_node *np)
        /*
         * Try to use dynamic shared memory if possible
         */
+#if 0
        if (sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
                pool = optee_config_dyn_shm();
+#endif

        /*
         * If dynamic shared memory is not available or failed - try static one
         */
-       if (IS_ERR(pool) && (sec_caps & OPTEE_SMC_SEC_CAP_HAVE_RESERVED_SHM))
+       if (sec_caps & OPTEE_SMC_SEC_CAP_HAVE_RESERVED_SHM)
                pool = optee_config_shm_memremap(invoke_fn, &memremaped_shm);

        if (IS_ERR(pool))


For the module part:
Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
