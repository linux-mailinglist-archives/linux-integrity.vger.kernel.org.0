Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA745FCBB
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2019 20:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfGDSL1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Jul 2019 14:11:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43434 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbfGDSL1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Jul 2019 14:11:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id p13so7452166wru.10
        for <linux-integrity@vger.kernel.org>; Thu, 04 Jul 2019 11:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EeY1//zgHjHvZL8PlJS76RO/TPLoiFY9/zkEu270Qfs=;
        b=SgKiCrhYnxaQpOWryEwRE0jUNEKFhFz3Iw6QyUsme9ZyaVqDNoXUooFMnA9vLDiVP7
         nDCBoZ9A80UD5z1G3VQD8CFzjxv1gj4kZfqNLxR1Zggc2VAX4N3/+gOBFNCAY2gxuw+7
         H2pmvBR0LaFZT07eB3T7R1Y+sXr6XU3udnIPQ9T0D+ULJpDhKybLGnxrq4OBUbr8YTq6
         iaoVk1x+JEIbZ5//8L00zQqNoEWsUB56O+t81vS12tlef8yb3zrkg5NHgLA8aZQXsTfU
         cSFGAcip1OWVtzXCumPbhhUl7zPMoDq0Vt5/rfzG2HoM7Xc9+VLgoV2PBisnbK/CIbsP
         IlUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EeY1//zgHjHvZL8PlJS76RO/TPLoiFY9/zkEu270Qfs=;
        b=pFSM6Ro/+semYcXDe3V4xRXbFi2l0XFuIPl2vyvCIn5+glGxLT5IrITvvZkRBnouut
         8dhs1uZjnO5Tr+RQHFaUUg3wXWNJKTJV7R64mgC8/mjYMrlU51CtyrKqKTE4EDion8TW
         mbbnsySrxdRunejGSKaKHTclaW3z28hNUUj33ZUrWaR1G1HGKvEVVRQEJSb5o4cEGOcB
         E1XGyF2WV/EtdRTNNw/D4fgH2zZOoiBS1xrzVTOCv7JeMh9DHULQ2fqNSrzd/j6jn7u9
         i6L70731A+cLa4ZS7IILpjizLWUXQFS+XBPPFXdqo+sCEWccHAkjWXz6BX2fUDsLi1Lo
         PLnQ==
X-Gm-Message-State: APjAAAXsBusd9/pOGlHteL2Rjg1X2vfKzECihD4irmdYoIYTrWZowcj+
        TlJBcHPBjqoiQVDCp6EWaf1beQ==
X-Google-Smtp-Source: APXvYqyG/pol3jM2+TZsOqHSuN2Z8zVhvdIGUGLFjgj1lkzu8Hii2SD1es3NYfFmFBlXgWjxuCr5Vg==
X-Received: by 2002:adf:aacf:: with SMTP id i15mr24167399wrc.124.1562263884453;
        Thu, 04 Jul 2019 11:11:24 -0700 (PDT)
Received: from apalos (athedsl-428434.home.otenet.gr. [79.131.225.144])
        by smtp.gmail.com with ESMTPSA id o4sm6313945wmh.35.2019.07.04.11.11.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 11:11:23 -0700 (PDT)
Date:   Thu, 4 Jul 2019 21:11:20 +0300
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
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        Joakim Bech <joakim.bech@linaro.org>
Subject: Re: [PATCH v7 1/2] fTPM: firmware TPM running in TEE
Message-ID: <20190704181120.GA21445@apalos>
References: <673dd30d03e8ed9825bb46ef21b2efef015f6f2a.camel@linux.intel.com>
 <20190626235653.GL7898@sasha-vm>
 <b688e845ccbe011c54b10043fbc3c0de8f0befc2.camel@linux.intel.com>
 <20190627133004.GA3757@apalos>
 <0893dc429d4c3f3b52d423f9e61c08a5012a7519.camel@linux.intel.com>
 <20190702142109.GA32069@apalos>
 <CY4PR21MB0279B99FB0097309ADE83809BCF80@CY4PR21MB0279.namprd21.prod.outlook.com>
 <20190703065813.GA12724@apalos>
 <CAC_iWjK2F13QxjuvqzqNLx00SiGz_FQ5X=MQxJyDev57bo3=LQ@mail.gmail.com>
 <CY4PR21MB02791B5EF653514DC0223694BCFA0@CY4PR21MB0279.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR21MB02791B5EF653514DC0223694BCFA0@CY4PR21MB0279.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Thirupathaiah,
[...]
> > > > > I managed to do some quick testing in QEMU.
> > > > > Everything works fine when i build this as a module (using IBM's TPM 2.0
> > > > > TSS)
> > > > >
> > > > > - As module
> > > > > # insmod /lib/modules/5.2.0-rc1/kernel/drivers/char/tpm/tpm_ftpm_tee.ko
> > > > > # getrandom -by 8
> > > > > randomBytes length 8
> > > > > 23 b9 3d c3 90 13 d9 6b
> > > > >
> > > > > - Built-in
> > > > > # dmesg | grep optee
> > > > > ftpm-tee firmware:optee: ftpm_tee_probe:tee_client_open_session failed,
> > > > > err=ffff0008
> > > > This (0xffff0008) translates to TEE_ERROR_ITEM_NOT_FOUND.
> > > >
> > > > Where is fTPM TA located in the your test setup?
> > > > Is it stitched into TEE binary as an EARLY_TA or
> > > > Is it expected to be loaded during run-time with the help of user mode OP-
> > TEE supplicant?
> > > >
> > > > My guess is that you are trying to load fTPM TA through user mode OP-TEE
> > supplicant.
> > > > Can you confirm?
> > > I tried both
> > >
> > 
> > Ok apparently there was a failure with my built-in binary which i
> > didn't notice. I did a full rebuilt and checked the elf this time :)
> > 
> > Built as an earlyTA my error now is:
> > ftpm-tee firmware:optee: ftpm_tee_probe:tee_client_open_session
> > failed, err=ffff3024 (translates to TEE_ERROR_TARGET_DEAD)
> > Since you tested it on real hardware i guess you tried both
> > module/built-in. Which TEE version are you using?
> 
> I am glad that the first issue (TEE_ERROR_ITEM_NOT_FOUND) is resolved after stitching
> fTPM TA as an EARLY_TA. 
> 
> Regarding TEE_ERROR_TARGET_DEAD error, may I know which HW platform you are using to test? 

QEMU, on armv7

> What is the preboot environment (UEFI or U-boot)? 
> Where is the secure storage in that HW platform? 
> I could think of two classes of secure storage. 
> 1. UFS/eMMC RPMB : If Supplicant in U-boot/UEFI initializes the 
> fTPM TA NV Storage, there should be no issue. 
> If fTPM TA NV storage is not initialized in pre-boot environment and you are using
> built-in fTPM Linux driver, you can run into this issue as TA will try to initialize
> NV store and fail. 
> 
> 2. other storage devices like QSPI accessible to only secure mode after
> EBS/ReadyToBoot mile posts during boot. In this case, there should be no issue at all
> as there is no dependency on non-secure side services provided by supplicant. 
> 

Please check the previous mail from Sumit. It explains exaclty what's going on.
The tl;dr version is that the storage is up only when the supplicant is running.

> If you let me know the HW platform details, I am happy to work with you to enable/integrate
> fTPM TA on that HW platform. 
> 
Thanks, 
The hardware i am waiting for for has an eMMC RPMB. In theory the U-Boot
supplicant support will be there so i'll be able to test it.

Thanks
/Ilias
