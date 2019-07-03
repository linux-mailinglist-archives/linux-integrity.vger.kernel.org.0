Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E09E5E642
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2019 16:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfGCOQJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 3 Jul 2019 10:16:09 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36668 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfGCOQI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Jul 2019 10:16:08 -0400
Received: by mail-ed1-f66.google.com with SMTP id k21so2268980edq.3
        for <linux-integrity@vger.kernel.org>; Wed, 03 Jul 2019 07:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8DKdbUgQ2jVt8K/6qfz1G9yQLM6zzf/4kO2TWk7/Q2I=;
        b=yoGgAuhKXkHJtjTmsoIY1ltoABbwgoH4O2/u8mUvBkgk65XAlbzp9wlFR/oFrSWTx9
         ZCsCR3BVFGPGC6bYgfwm3xRJQ5BJMcfaMt7WN5uklWjMlkTNw18k2aMokV1fw+NDbmnp
         tYjbVLeqmMFJj+dPJUb4BFJdACG+A9sOY1/giqckYB9YZwlecSMLG9ZaoBW9VRV3WptH
         4zV2LQYbdMjjIogOzL3LIcJH4bSgxg+CRaBqg/sOkxawmRHhg7pr7SoAaMtHHiVNmD5T
         pgSLhq7vmgRujivkOGWRy4NJnuByC0ZwmzVaBJz+7zpQPZEtpCsRqDOYywJi0ng+U00l
         612A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8DKdbUgQ2jVt8K/6qfz1G9yQLM6zzf/4kO2TWk7/Q2I=;
        b=WO69+F1M4i5qm2ZEOh/3OWd1S9QZg3/JRlkHOx43F3z3x62KOY45UqVnqVonFyJOnh
         lM2LlIP3DRhRNSfpNvYMge0z+klvrVivMxemd0ASdc5SB4qOXUO8i6RhMhcztZxbtmpT
         Eshyb2Cfh8KtIUMjDrxmzRW1CLE2XsB11CJO3XI2sXv0+h8ix/XOboJwNRDi1tmgexO9
         dK+7+GU9j8tyGsu/c0qVdLMwwWHydEg2ylHrZJD4WyPV4XpNCxv6BJA9agxAP+fO7mGN
         A0Kh5O5aj9/2T5A+T14/Sg6Yjls8FcFl+ZLs7/j/Ci+CKBDrUMzYkfBlSBJdXAd7bleN
         sMmQ==
X-Gm-Message-State: APjAAAVLtRwtjDEhsC+QCGXEvC2E4sGgcT0eyyZatUctHnHlsOxVGmmO
        /tvHR8JxJK52Z3GbXeTvLzvpuw==
X-Google-Smtp-Source: APXvYqzMRF+/JPrGOgSS5HsYyntug1qCDYYN0ECP6hsJdmOeudDh/QasZt/niKNGAswJvAZAaEnywg==
X-Received: by 2002:a17:906:3956:: with SMTP id g22mr34311793eje.292.1562163366123;
        Wed, 03 Jul 2019 07:16:06 -0700 (PDT)
Received: from debby (81-231-61-154-no276.tbcn.telia.com. [81.231.61.154])
        by smtp.gmail.com with ESMTPSA id d4sm737274edb.4.2019.07.03.07.16.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jul 2019 07:16:04 -0700 (PDT)
Date:   Wed, 3 Jul 2019 16:16:02 +0200
From:   Joakim Bech <joakim.bech@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Microsoft Linux Kernel List <linux-kernel@microsoft.com>,
        "Bryan Kelly (CSI)" <bryankel@microsoft.com>,
        "tee-dev@lists.linaro.org" <tee-dev@lists.linaro.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>
Subject: Re: [PATCH v7 1/2] fTPM: firmware TPM running in TEE
Message-ID: <20190703141602.fky5x5buuqdjw7wx@debby>
References: <673dd30d03e8ed9825bb46ef21b2efef015f6f2a.camel@linux.intel.com>
 <20190626235653.GL7898@sasha-vm>
 <b688e845ccbe011c54b10043fbc3c0de8f0befc2.camel@linux.intel.com>
 <20190627133004.GA3757@apalos>
 <0893dc429d4c3f3b52d423f9e61c08a5012a7519.camel@linux.intel.com>
 <20190702142109.GA32069@apalos>
 <CY4PR21MB0279B99FB0097309ADE83809BCF80@CY4PR21MB0279.namprd21.prod.outlook.com>
 <20190703065813.GA12724@apalos>
 <CAC_iWjK2F13QxjuvqzqNLx00SiGz_FQ5X=MQxJyDev57bo3=LQ@mail.gmail.com>
 <CAFA6WYMvd1BVGppYM230Bd1XjO11uU4WQf-F+ZtmtpasP4AjxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFA6WYMvd1BVGppYM230Bd1XjO11uU4WQf-F+ZtmtpasP4AjxQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jul 03, 2019 at 03:33:14PM +0530, Sumit Garg wrote:
> On Wed, 3 Jul 2019 at 13:42, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Thirupathaiah,
> >
> > (+Joakim)
> >
> > On Wed, 3 Jul 2019 at 09:58, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Thirupathaiah,
> > > >
> > > > First of all, Thanks a lot for trying to test the driver.
> > > >
> > > np
> > >
> > > [...]
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
> > > > Is it expected to be loaded during run-time with the help of user mode OP-TEE supplicant?
> > > >
> > > > My guess is that you are trying to load fTPM TA through user mode OP-TEE supplicant.
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
> >
> 
> > > > U-boot and Linux driver stacks work seamlessly without dependency on supplicant.
> 
> Is this true?
> 
> It looks like this fTPM driver can't work as a built-in driver. The
> reason seems to be secure storage access required by OP-TEE fTPM TA
> that is provided via OP-TEE supplicant that's not available during
> kernel boot.
> 
> Snippet from ms-tpm-20-ref/Samples/ARM32-FirmwareTPM/optee_ta/fTPM/fTPM.c +145:
> 
>     // If we fail to open fTPM storage we cannot continue.
>     if (_plat__NVEnable(NULL) == 0) {
>         TEE_Panic(TEE_ERROR_BAD_STATE);
>     }
> 
> So it seems like this module will work as a loadable module only after
> OP-TEE supplicant is up.
> 
This seems to be the same issues that I faced when trying to put
together a setup for Linaro Connect discussions. When compiling the fTPM
driver into the kernel (instead of a module) I saw mainly two issues.

1) fTPM driver seems to be probed before the TEE driver has been probed.
   I temporary solved that by doing a late_initcall.

2) With the late_initcall hack applied, the TEE side was called
   successfully (if the fTPM TA's is compiled as "early TAs", i.e.,
   built into the TEE core iself), but as Sumit said, it got stock on
   secure storage operations, since tee-supplicant, the userspace
   process serving the TEE with storage access hasn't been started.

The first issue can(?)/should(?) be solved by some deferred probing
mechanism.

Regarding the second issue, is there a must to access secure storage
when Linux kernel is booting up? I suppose this is some kind of
initialization of the "NV" (adding TPM measurements?), but I guess it
should be possible to delay those calls to a later point, when
tee-supplicant is up and running and the first call to the TEE is made.

-- 
Regards,
Joakim
