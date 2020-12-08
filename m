Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559F12D29FC
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Dec 2020 12:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbgLHLwt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Dec 2020 06:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgLHLws (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Dec 2020 06:52:48 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BF2C06179C
        for <linux-integrity@vger.kernel.org>; Tue,  8 Dec 2020 03:52:08 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id r24so22572003lfm.8
        for <linux-integrity@vger.kernel.org>; Tue, 08 Dec 2020 03:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p3UOlT4T7w2iGiGz4zhACGCaX1lqFN/iswpw5ZnkzrM=;
        b=K1JWSFkTy6XixhuEVjqMYIhYotaaw0q/FmwnMPxBVqxc3uSIdIQNYkJEUr0zLiMovp
         Y0J20mo1QFGat7zPDCW9WuyHBkQfBpKMyRvu00gjUJNlb2GAUa17YVVVPqW0lFr9YbDB
         Rvn30VX44R4T4AkOP2Y2aXUToxPR5Yu1LUL+aHc3tePoKK7BUMW+UqcdeZwpyHa80wQh
         PTjCv5cb2fOmKBNmTlci7Qko2+3OLqE0zyjN3v/J0afe3bNXScVJI5FqsyXg+g1lmvBr
         SQTpwTUMlSpA8Z90euuAlNPXWkOlDB2idVQthpeMFDdcIpQ57mTKAFl8wy6LwcJqGkJu
         Gdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p3UOlT4T7w2iGiGz4zhACGCaX1lqFN/iswpw5ZnkzrM=;
        b=scigH0JS+O6rrDjQNSOQNHFRxxrCbnIYDRwO6nwXoMCMGEqEozk/WLby5RU0FW47sh
         377LD2tBu4iOtt3/AD2SsrrBPgk7FZb7JGUxKBHKmhBZSHK/sNZp1Ey4U1NreURqoGw3
         6uqWUVn2rQRPVaBw9u6mza1++2LODpknsrLG4UZ03sbv2dJibFNQgatizeFrhExHKSP8
         QlCd812tjVDWREQ5jjk1XLsO6NjQIIQ5K7lZ5T/U6dR/VkF7uvRmA7lFCgavqZGdbeD8
         6V47UlbbWqZOGS71jcS1JfxsgqAuQfZzdR0+Jpqd4CA4YhQZktGuZFmxGPi0X3ekq4uc
         XQYA==
X-Gm-Message-State: AOAM531jhXuWYbBPH8q4e5pIjYLtZfnkTioKQhUafBc2ALYDMZNycoNy
        uMRdd+ck+0yZA7iof1UOlyhLKfUFaRP3d+l+yiu+pQ==
X-Google-Smtp-Source: ABdhPJyvGNe6OrrMd86DoarSRS4TSHMXGop3JNtQfwGOmMDdmgDiMAbQn68Ss0Jc/C7WgtMqQw0ZJt2BEbCZMlIgDP0=
X-Received: by 2002:a19:6144:: with SMTP id m4mr10079549lfk.546.1607428324986;
 Tue, 08 Dec 2020 03:52:04 -0800 (PST)
MIME-Version: 1.0
References: <1604419306-26105-1-git-send-email-sumit.garg@linaro.org>
 <20201105050736.GA702944@kernel.org> <CAFA6WYPetvod-Wov2n_L5TL771j+-kt+_csyWYT-uM=haEKMZQ@mail.gmail.com>
 <20201106145252.GA10434@kernel.org> <20201204051642.GA154469@kernel.org>
In-Reply-To: <20201204051642.GA154469@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 8 Dec 2020 17:21:53 +0530
Message-ID: <CAFA6WYOxkAUxg05kKXAcu2F2YD97MXNSggYgL+uSG7wrBVKoMQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Introduce TEE based Trusted Keys support
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Markus Wamser <Markus.Wamser@mixed-mode.de>,
        Luke Hinds <lhinds@redhat.com>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jarkko,

Apologies for the delay in my response as I was busy with other high
priority work.

On Fri, 4 Dec 2020 at 10:46, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Fri, Nov 06, 2020 at 04:52:52PM +0200, Jarkko Sakkinen wrote:
> > On Fri, Nov 06, 2020 at 03:02:41PM +0530, Sumit Garg wrote:
> > > On Thu, 5 Nov 2020 at 10:37, Jarkko Sakkinen <jarkko@kernel.org> wrot=
e:
> > > >
> > > > On Tue, Nov 03, 2020 at 09:31:42PM +0530, Sumit Garg wrote:
> > > > > Add support for TEE based trusted keys where TEE provides the fun=
ctionality
> > > > > to seal and unseal trusted keys using hardware unique key. Also, =
this is
> > > > > an alternative in case platform doesn't possess a TPM device.
> > > > >
> > > > > This patch-set has been tested with OP-TEE based early TA which i=
s already
> > > > > merged in upstream [1].
> > > >
> > > > Is the new RPI400 computer a platform that can be used for testing
> > > > patch sets like this? I've been looking for a while something ARM64
> > > > based with similar convenience as Intel NUC's, and on the surface
> > > > this new RPI product looks great for kernel testing purposes.
> > >
> > > Here [1] is the list of supported versions of Raspberry Pi in OP-TEE.
> > > The easiest approach would be to pick up a supported version or else
> > > do an OP-TEE port for an unsupported one (which should involve minima=
l
> > > effort).
> > >
> > > [1] https://optee.readthedocs.io/en/latest/building/devices/rpi3.html=
#what-versions-of-raspberry-pi-will-work
> > >
> > > -Sumit
> >
> > If porting is doable, then I'll just order RPI 400, and test with QEMU
> > up until either I port OP-TEE myself or someone else does it.
> >
> > For seldom ARM testing, RPI 400 is really convenient device with its
> > boxed form factor.
>
> I'm now a proud owner of Raspberry Pi 400 home computer :-)
>
> I also found instructions on how to boot a custom OS from a USB stick:
>
> https://www.raspberrypi.org/documentation/hardware/raspberrypi/bootmodes/=
msd.md
>
> Also, my favorite build system BuildRoot has bunch of of the shelf
> configs:
>
> =E2=9E=9C  buildroot-sgx (master) =E2=9C=94 ls -1 configs | grep raspberr=
y
> raspberrypi0_defconfig
> raspberrypi0w_defconfig
> raspberrypi2_defconfig
> raspberrypi3_64_defconfig
> raspberrypi3_defconfig
> raspberrypi3_qt5we_defconfig
> raspberrypi4_64_defconfig
> raspberrypi4_defconfig
> raspberrypi_defconfig
>
> I.e. I'm capable of compiling kernel and user space and boot it up
> with it.
>
> Further, I can select this compilation option:
>
> BR2_TARGET_OPTEE_OS:                                                     =
                                                                           =
              =E2=94=82
>                                                                          =
                                                                           =
                 =E2=94=82
>    OP-TEE OS provides the secure world boot image and the trust          =
                                                                           =
                 =E2=94=82
>    application development kit of the OP-TEE project. OP-TEE OS          =
                                                                           =
                 =E2=94=82
>    also provides generic trusted application one can embedded            =
                                                                           =
                 =E2=94=82
>    into its system.                                                      =
                                                                           =
                 =E2=94=82
>                                                                          =
                                                                           =
                 =E2=94=82
>    http://github.com/OP-TEE/optee_os
>
> Is that what I want? If I put this all together and apply your patches,
> should the expectation be that I can use trusted keys?
>

Firstly you need to do an OP-TEE port for RPI 400 (refer here [1] for
guidelines). And then in order to boot up OP-TEE on RPI 400, you can
refer to Raspberry Pi 3 build instructions [2].

[1] https://optee.readthedocs.io/en/latest/architecture/porting_guidelines.=
html
[2] https://optee.readthedocs.io/en/latest/building/devices/rpi3.html#build=
-instructions

> Please note that I had a few remarks about your patches (minor but need
> to be fixed), but this version is already solid enough for testing.
>

Sure, I will incorporate your remarks and Randy's documentation
comments in the next version.

-Sumit

> /Jarkko
