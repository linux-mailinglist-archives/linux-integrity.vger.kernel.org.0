Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD6010DBCE
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Nov 2019 00:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387399AbfK2Xc7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 29 Nov 2019 18:32:59 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56940 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387398AbfK2Xc7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Nov 2019 18:32:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575070377;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WhdAPdS+FPZ3dgyUmfDfDLG8hWWC09Bk50fcphiVxF8=;
        b=JSFHGpeLt6/mtTABF4aqZWT/Ze3zpkvLENuApe6t/+KfSWKWkfhllDfD4ilH2dJI1giuDC
        No9iy8AlNSJiRQn2Sv4Cs1ZtUFRAaZ1ak3FWmGfIfB0dQkfd+CsRF7Gfgo4P42gWPjtSQJ
        Zz9xHf4BcAPNm85EaEzZ6JB83TV/ut0=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-2zzcSAG9OR-DkZ0udyLwpA-1; Fri, 29 Nov 2019 18:32:50 -0500
Received: by mail-pf1-f197.google.com with SMTP id s131so13635635pfs.21
        for <linux-integrity@vger.kernel.org>; Fri, 29 Nov 2019 15:32:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=HMDoKlR2zf3F9JvmSD977gMi1kegZrPiHW0J/3/orrg=;
        b=IWERoT7F8onahMEjr928LBwRab4iFI3hRsbMlwlkRBKF5R9/M3MEWwrfimBND8VD6D
         z2vZWx5bOohq6WuE7tr3y08XA2hJkJnXIqY7m4r9tOdJ6ZX2muFQWhyLnbbzZhbRvzby
         NbOjIuEmGXLw82o24yZuyl6UPUByLQeRN8LU4pXf/sPg41RYICBbo2GMuivdG9YAordm
         /49i4I69v0tPWb2YX51HO877AuN27z1RFRdphhaLh/orU+SLtiBE7jlucKEsmtiRuhJN
         I3GbdWohnxybAFEGVyaoii2E2GGR2mcW4rtRTc6ueb1TvAdRbCtKDTpfPd84grad0Vy1
         TIUg==
X-Gm-Message-State: APjAAAXC2nFP7hQl5mjwAv+EXhtQXePdT1tXOa1spplFPRe+wwyUG5KE
        snstj13y/xS0/nh1GXSk33rV5ruwufACwovSN5D1FaPpJyw7UXoFfttgNybGYtjVR6X47EG312B
        D0RiC1VEJiTkRjM0xMiIdCDcPIYJR
X-Received: by 2002:a17:902:322:: with SMTP id 31mr16947670pld.244.1575070369420;
        Fri, 29 Nov 2019 15:32:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqzVF8jKFmE3JjTqFteQwms+t8J+SNdGuKRwByDQQgQ8pgQWV7RRFncg5z+6xw+77cmd/+Z98Q==
X-Received: by 2002:a17:902:322:: with SMTP id 31mr16947655pld.244.1575070369087;
        Fri, 29 Nov 2019 15:32:49 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id e1sm9545891pfl.98.2019.11.29.15.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 15:32:48 -0800 (PST)
Date:   Fri, 29 Nov 2019 16:32:47 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org, James Morris <jmorris@namei.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>
Subject: Re: [GIT PULL] tpmdd updates for Linux v5.4
Message-ID: <20191129233247.oavwmrp65b5nc5hq@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org, James Morris <jmorris@namei.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>
References: <20190902143121.pjnykevzlajlcrh6@linux.intel.com>
 <CAA9_cmeLnHK4y+usQaWo72nUG3RNsripuZnS-koY4XTRC+mwJA@mail.gmail.com>
 <20191122161836.ry3cbon2iy22ftoc@cantor>
 <20191129210400.GB12055@linux.intel.com>
 <20191129232249.bgj25rlwrcg3afj5@cantor>
MIME-Version: 1.0
In-Reply-To: <20191129232249.bgj25rlwrcg3afj5@cantor>
X-MC-Unique: 2zzcSAG9OR-DkZ0udyLwpA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri Nov 29 19, Jerry Snitselaar wrote:
>On Fri Nov 29 19, Jarkko Sakkinen wrote:
>>On Fri, Nov 22, 2019 at 09:18:36AM -0700, Jerry Snitselaar wrote:
>>>On Wed Nov 20 19, Dan Williams wrote:
>>>> On Mon, Sep 2, 2019 at 7:34 AM Jarkko Sakkinen
>>>> <jarkko.sakkinen@linux.intel.com> wrote:
>>>> >
>>>> > Hi
>>>> >
>>>> > A new driver for fTPM living inside ARM TEE was added this round. In
>>>> > addition to that, there is three bug fixes and one clean up.
>>>> >
>>>> > /Jarkko
>>>> >
>>>> > The following changes since commit 8fb8e9e46261e0117cb3cffb6dd8bb7e0=
8f8649b:
>>>> >
>>>> >   Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel=
/git/rdma/rdma (2019-08-30 09:23:45 -0700)
>>>> >
>>>> > are available in the Git repository at:
>>>> >
>>>> >   git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-=
20190902
>>>> >
>>>> > for you to fetch changes up to e8bd417aab0c72bfb54465596b16085702ba0=
405:
>>>> >
>>>> >   tpm/tpm_ftpm_tee: Document fTPM TEE driver (2019-09-02 17:08:35 +0=
300)
>>>> >
>>>> > ----------------------------------------------------------------
>>>> > tpmdd updates for Linux v5.4
>>>> >
>>>> > ----------------------------------------------------------------
>>>> > Jarkko Sakkinen (1):
>>>> >       tpm: Remove a deprecated comments about implicit sysfs locking
>>>> >
>>>> > Lukas Bulwahn (1):
>>>> >       MAINTAINERS: fix style in KEYS-TRUSTED entry
>>>> >
>>>> > Sasha Levin (2):
>>>> >       tpm/tpm_ftpm_tee: A driver for firmware TPM running inside TEE
>>>> >       tpm/tpm_ftpm_tee: Document fTPM TEE driver
>>>> >
>>>> > Stefan Berger (2):
>>>> >       tpm_tis_core: Turn on the TPM before probing IRQ's
>>>> >       tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before probing for interru=
pts
>>>>
>>>> Hi Jarrko,
>>>>
>>>> I'm replying here because I can't find the patches to reply to
>>>> directly from LKML.
>>>>
>>>> Commit 7f064c378e2c "tpm_tis_core: Turn on the TPM before probing
>>>> IRQ's" in the v5.3-stable tree caused a regression on a pre-release
>>>> platform with a TPM2 device. The interrupt starts screaming when the
>>>> driver is loaded and does not stop until the device is force unbond
>>>> from the driver by:
>>>>
>>>>     echo IFX0740:00 > /sys/bus/platform/drivers/tpm_tis/unbind
>>>>
>>>> I checked v5.4-rc8 and it has the same problem. I tried reverting:
>>>>
>>>> 1ea32c83c699 tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before probing for in=
terrupts
>>>> 5b359c7c4372 tpm_tis_core: Turn on the TPM before probing IRQ's
>>>>
>>>> Which silenced the screaming interrupt problem, but now the TPM is rep=
orting:
>>>>
>>>> [    3.725131] tpm_tis IFX0740:00: 2.0 TPM (device-id 0x1B, rev-id 16)
>>>> [    3.725358] tpm tpm0: tpm_try_transmit: send(): error -5
>>>> [    3.725359] tpm tpm0: [Firmware Bug]: TPM interrupt not working,
>>>> polling instead
>>>>
>>>> ...at load, where it was not reporting this previously. Can you take a=
 look?
>>>>
>>>
>>>We've had an issue reported for a Lenovo t490s getting an interrupt stor=
m
>>>with the Fedora 5.3 stable kernel, so it appears to be impacting a numbe=
r of
>>>systems.
>>
>>Hi sorry for inactivity. I've had a renovation going on where I live
>>which has caused some crackling in the comms but I'm catching up during
>>the weekend.
>>
>>Which CPU model does T490S have? Can you paste /proc/cpuinfo?
>>
>>/Jarkko
>>
>
>I still don't have access to one of the laptops, but looking online
>they should have one of the following: i5-8265U, i5-8365U, i7-8565U,
>or i7-8665U. The tpm is discrete, so I don't know that the cpu will
>matter. Looking at a log, in the t490s case it is an STMicroelectronics
>chip. So both Infineon and STM so far.
>

In the case reported on Fedora the cpu is a i7-8665U.

