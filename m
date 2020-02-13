Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D392B15CB41
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Feb 2020 20:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgBMTjM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Feb 2020 14:39:12 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36489 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgBMTjL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Feb 2020 14:39:11 -0500
Received: by mail-qt1-f195.google.com with SMTP id t13so5314104qto.3
        for <linux-integrity@vger.kernel.org>; Thu, 13 Feb 2020 11:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XlaiOyPoTQiX3Vuk5cpUfnsu7dczUQOtR8OVBPBHL2Q=;
        b=BEZPNvbeyYNK/rkYNeYs+pAx9VhBbGgIK42BBDiaeEZQFWkmSyPpZf/3OD6811cvPm
         MqFJoj9UFOrc+TNfmDilBfGC7JPw0kjXWKlPPNHAdyoYEZ955JrWn57xcemXy7p0gbtZ
         UWXdPAHWkS0HzgAPzlSKOonk6c+Qkd3lbZbjyWccVMfcUtrj55lP4L2Dw+0tsRo5hosR
         PsVHq+JPLxr1mS9wHSEOdM0wBaB89bLYeBqUpOLbHDcpLQtYWjj5vw3yWdAhmkU9qiUZ
         7vdMLPiOvTuOprkvmTnZP2hRpY+GuWq7Tp2BwmktG1K8xAxVJlo/yDkvxe8+53Wac5++
         DCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XlaiOyPoTQiX3Vuk5cpUfnsu7dczUQOtR8OVBPBHL2Q=;
        b=QSJzRaEhCSPzAKWIDoBJt+u4sbcStlVJyAi5o4GBZ1mRXha/YvBgnpYoE9QmMwxmiS
         Mq8gAM8Wzgom38ETv8WgpkW5K4mV1pbe1S0gdkRROK/g+4AF3DE/p2xzeSnSeYm3tVYw
         B64UpwrZoJfDjOoiJdEpdo7OxFcwL0P92PlU9H7CxhBe4iQkHDIX8VcCoLB62d0xwC8D
         H4ZAS+XtHgxQxkZEib4oVYnCQ9QxGm9HWuxVqX8O4hEPAE5H7dAptVhtfRYLixrOHKKg
         si1Ys3sOTk/iH7K+eh5pN671OguQSV2IZtfEwoSATkWOoPW74asek9d8MqVmjKUw68hS
         HvyQ==
X-Gm-Message-State: APjAAAUCia57BIbblxjsLa6wTOxPKk1iw9QiymxZ2803hf1J98KIR6c5
        PS4TewM6iEXQE+lc9UtK2zIIpA==
X-Google-Smtp-Source: APXvYqwdCn3xpD8M/ltW22e01Lqu/Bk5XB2h0dxgimBO3jE4MuDUsgahgPTI/qTunQumZxzuwjp0sg==
X-Received: by 2002:ac8:1ac1:: with SMTP id h1mr13069458qtk.255.1581622749372;
        Thu, 13 Feb 2020 11:39:09 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id d18sm1847436qke.75.2020.02.13.11.39.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Feb 2020 11:39:08 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j2KKK-0005Oy-Bd; Thu, 13 Feb 2020 15:39:08 -0400
Date:   Thu, 13 Feb 2020 15:39:08 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Nayna <nayna@linux.vnet.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, aik@ozlabs.ru,
        david@gibson.dropbear.id.au, linux-kernel@vger.kernel.org,
        gcwilson@linux.ibm.com
Subject: Re: [PATCH 3/3] tpm: ibmvtpm: Add support for TPM 2
Message-ID: <20200213193908.GP31668@ziepe.ca>
References: <20200204132706.3220416-1-stefanb@linux.vnet.ibm.com>
 <20200204132706.3220416-4-stefanb@linux.vnet.ibm.com>
 <a23872ef-aa23-e6b0-4b69-602d79671d4b@linux.vnet.ibm.com>
 <d805c04b-3680-97d5-8ea7-82409c7ef308@linux.ibm.com>
 <20200213183508.GL31668@ziepe.ca>
 <b424faea-33a7-8e5a-caac-f322fad68118@linux.ibm.com>
 <20200213191108.GO31668@ziepe.ca>
 <1e301947-a8f3-0b7d-d86c-5bfe04a68a75@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e301947-a8f3-0b7d-d86c-5bfe04a68a75@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Feb 13, 2020 at 02:15:03PM -0500, Stefan Berger wrote:
> On 2/13/20 2:11 PM, Jason Gunthorpe wrote:
> > On Thu, Feb 13, 2020 at 02:04:12PM -0500, Stefan Berger wrote:
> > > On 2/13/20 1:35 PM, Jason Gunthorpe wrote:
> > > > On Thu, Feb 13, 2020 at 01:20:12PM -0500, Stefan Berger wrote:
> > > > 
> > > > > I don't want side effects for the TPM 1.2 case here, so I am only modifying
> > > > > the flag for the case where the new TPM 2 is being used.  Here's the code
> > > > > where it shows the effect.
> > > > I'm surprised this driver is using AUTO_STARTUP, it was intended for
> > > > embedded cases where their is no firmware to boot the TPM.
> > > The TIS is also using it on any device.
> > TIS is a generic driver, and can run on TPMs without firmware
> > support. It doesn't know either way
> 
> The following drivers are all using it:
> 
> 
> drivers/char/tpm/st33zp24/st33zp24.c, line 493
> drivers/char/tpm/tpm-interface.c, line 374
> drivers/char/tpm/tpm_crb.c, line 421
> drivers/char/tpm/tpm_ftpm_tee.c, line 184
> drivers/char/tpm/tpm_i2c_atmel.c, line 139
> drivers/char/tpm/tpm_i2c_infineon.c, line 602
> drivers/char/tpm/tpm_i2c_nuvoton.c, line 465
> drivers/char/tpm/tpm_tis_core.c, line 917
> drivers/char/tpm/tpm_vtpm_proxy.c, line 435
> 
> https://elixir.bootlin.com/linux/latest/ident/TPM_OPS_AUTO_STARTUP

These are all general purpose drivers.

Though perhaps vtpm_proxy shouldn't include it, not sure.

> > > > Chips using AUTO_STARTUP are basically useless for PCRs/etc.
> > > > 
> > > > I'd expect somthing called vtpm to have been started and PCRs working
> > > > before Linux is started??
> > > Yes, there's supposed to be firmware.
> > > 
> > > I only see one caller to tpm2_get_cc_attrs_tbl(chip), which is necessary to
> > > call. This caller happens to be in tpm2_auto_startup.
> > That seems to be a mistake, proper startup of the driver should never
> > require auto_startup.
> 
> Is this IBM vTPM driver special that it should do things differently than
> all those drivers listed above? From looking at the code is seems it is to
> be set for the TPM 2.0 case.

Any driver that knows the TPM must be started prior to Linux
booting should not use the flag.  vtpm drivers in general would seem
to be the case where we can make this statement.

If it was mandatory then it would not be a flag the driver has to specify.

Jason
