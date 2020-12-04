Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136132CE751
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Dec 2020 06:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725550AbgLDFRb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Dec 2020 00:17:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:47726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgLDFRb (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Dec 2020 00:17:31 -0500
Date:   Fri, 4 Dec 2020 07:16:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607059009;
        bh=MytoTQmK0FWpezBeB0/MIP6XIJc0eGXJUDMWPEVo7PA=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=SuRTAIIUpLjq3GUyKoK3lRf2aP+PaQZ5/PHvW+PdJV9RBOUq4jqvEwmrkzGp23Mdc
         eHU+vvWSnsIKri9zYinMa5cNfTq7O8qk25EG7K9tHw3MNzJSWMhy4BuJvYtAWx0msc
         A9UW3vaU51sXDgVCz1Ez1SLfJqsEuk2sgqH6EOS58woJacVBUqlsqVrFI5mvfP6a4C
         YIVa8iBrmGRX2zXFu2DiXu65vG5IUZExc0SCeKhrmoiQfnToOd3WOOdrfCX8/8WDUg
         d7kzEaS/3nYG3eBiXmopNWZrEKe/FxTZT/2vZ+nfuQdH9kkAwpGMoyk9DRrXHv+Hwz
         SB1T4+ZpRwx7Q==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
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
Subject: Re: [PATCH v8 0/4] Introduce TEE based Trusted Keys support
Message-ID: <20201204051642.GA154469@kernel.org>
References: <1604419306-26105-1-git-send-email-sumit.garg@linaro.org>
 <20201105050736.GA702944@kernel.org>
 <CAFA6WYPetvod-Wov2n_L5TL771j+-kt+_csyWYT-uM=haEKMZQ@mail.gmail.com>
 <20201106145252.GA10434@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201106145252.GA10434@kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Nov 06, 2020 at 04:52:52PM +0200, Jarkko Sakkinen wrote:
> On Fri, Nov 06, 2020 at 03:02:41PM +0530, Sumit Garg wrote:
> > On Thu, 5 Nov 2020 at 10:37, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > >
> > > On Tue, Nov 03, 2020 at 09:31:42PM +0530, Sumit Garg wrote:
> > > > Add support for TEE based trusted keys where TEE provides the functionality
> > > > to seal and unseal trusted keys using hardware unique key. Also, this is
> > > > an alternative in case platform doesn't possess a TPM device.
> > > >
> > > > This patch-set has been tested with OP-TEE based early TA which is already
> > > > merged in upstream [1].
> > >
> > > Is the new RPI400 computer a platform that can be used for testing
> > > patch sets like this? I've been looking for a while something ARM64
> > > based with similar convenience as Intel NUC's, and on the surface
> > > this new RPI product looks great for kernel testing purposes.
> > 
> > Here [1] is the list of supported versions of Raspberry Pi in OP-TEE.
> > The easiest approach would be to pick up a supported version or else
> > do an OP-TEE port for an unsupported one (which should involve minimal
> > effort).
> > 
> > [1] https://optee.readthedocs.io/en/latest/building/devices/rpi3.html#what-versions-of-raspberry-pi-will-work
> > 
> > -Sumit
> 
> If porting is doable, then I'll just order RPI 400, and test with QEMU
> up until either I port OP-TEE myself or someone else does it.
> 
> For seldom ARM testing, RPI 400 is really convenient device with its
> boxed form factor.

I'm now a proud owner of Raspberry Pi 400 home computer :-)

I also found instructions on how to boot a custom OS from a USB stick:

https://www.raspberrypi.org/documentation/hardware/raspberrypi/bootmodes/msd.md

Also, my favorite build system BuildRoot has bunch of of the shelf
configs:

➜  buildroot-sgx (master) ✔ ls -1 configs | grep raspberry
raspberrypi0_defconfig
raspberrypi0w_defconfig
raspberrypi2_defconfig
raspberrypi3_64_defconfig
raspberrypi3_defconfig
raspberrypi3_qt5we_defconfig
raspberrypi4_64_defconfig
raspberrypi4_defconfig
raspberrypi_defconfig

I.e. I'm capable of compiling kernel and user space and boot it up
with it.

Further, I can select this compilation option:

BR2_TARGET_OPTEE_OS:                                                                                                                                              │  
                                                                                                                                                                     │  
   OP-TEE OS provides the secure world boot image and the trust                                                                                                      │  
   application development kit of the OP-TEE project. OP-TEE OS                                                                                                      │  
   also provides generic trusted application one can embedded                                                                                                        │  
   into its system.                                                                                                                                                  │  
                                                                                                                                                                     │  
   http://github.com/OP-TEE/optee_os       

Is that what I want? If I put this all together and apply your patches,
should the expectation be that I can use trusted keys?

Please note that I had a few remarks about your patches (minor but need
to be fixed), but this version is already solid enough for testing.

/Jarkko
