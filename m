Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDEDA3A2F2E
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Jun 2021 17:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbhFJPVB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Jun 2021 11:21:01 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:46904 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbhFJPVA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jun 2021 11:21:00 -0400
Received: by mail-wm1-f43.google.com with SMTP id h22-20020a05600c3516b02901a826f84095so6657343wmq.5
        for <linux-integrity@vger.kernel.org>; Thu, 10 Jun 2021 08:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QEizWV9pqKWtA3I5Lx6+foWFKHfovLYz8YJh/nQGyU4=;
        b=TFqIO+3MbdpOkGxMHxhf2SMlQfMu8eqMvfqrW1sYdwpXawEhQH5qQtIWG2wJ+NtGOZ
         +GLTcPsWzCM9GbR48Q0mfrkrlulZmsBB0hA4rIQoX8JG7heVNOK6M7+by/eWfKjZaBh0
         JiQhpN2tJ02ztr3eq3TnHdM/r8TLl5blt/S5wRdb1E1wI/UzvzNOgCl/HQXLmC+a4Qgd
         K9eYU4gvoJXUpNroAn3DU+nFDM188KF+CJvS8vUNlqtYJWao4KPfiwaVRpPoQS+49kI2
         rZ2EzPEsGsKRzd2083lRUCIPP35YD3UOKqx3ecQ2dIkZxoscTkkKqPEjGfduyjLtGbvh
         Tuog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QEizWV9pqKWtA3I5Lx6+foWFKHfovLYz8YJh/nQGyU4=;
        b=No2jMHzcqGzbqbW6AaSrwUnVzozOYAlkc5Dfh/5gWtpq7Oea+G4dzYrqKYx72ZxS75
         cjeCkduPVUBxekgkfmhhE6QfzsTn1szUKslX7bfFR0ol/j6xDymStF9ElpNJP1SVEi5S
         0eGc2Wy6ZJo4khCeOElT6Ehfsl0MKPixOLiMX/wKeusr5WZdVsGS83HHo9eLsHjkjUEH
         SDKuYTYwQDvirpGnbIw8go2EvVfKZ6xPLdN3v5T+m+ZgZoFnNX+DlUpE3usZSnBnkicz
         xLto7I57UVP4saJDtnyzMeHnNRUqGJ7ZEoQh8QP6DK8bPl+YYm6b3EocLGnOP0AtusCs
         RyJg==
X-Gm-Message-State: AOAM533KNIMHPr4TbJlZx+xAJEeriAlvWmVjD0Jz3rsHJLiYs1OVOS/+
        /I8dawCTQA7g6n0HBGA1tYk4W+JuxmcX/A==
X-Google-Smtp-Source: ABdhPJzynRmYYLsE07cE4IrH1eJB2NV4sziNEvi4rO5rP72ty1783TeIcwOygbWysK8ka+DMFrBoOw==
X-Received: by 2002:a05:600c:5112:: with SMTP id o18mr5396432wms.15.1623338283125;
        Thu, 10 Jun 2021 08:18:03 -0700 (PDT)
Received: from trex (138.red-79-146-80.dynamicip.rima-tde.net. [79.146.80.138])
        by smtp.gmail.com with ESMTPSA id n18sm3584960wmq.41.2021.06.10.08.18.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jun 2021 08:18:02 -0700 (PDT)
From:   "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date:   Thu, 10 Jun 2021 17:18:01 +0200
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>
Subject: Re: ima - wait for tpm load
Message-ID: <20210610151801.GA19687@trex>
References: <20210610071633.GA30216@trex>
 <b3c1f5a0a37419fac51d570cd1c8e521f59cee14.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3c1f5a0a37419fac51d570cd1c8e521f59cee14.camel@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/06/21, Mimi Zohar wrote:
> [Cc'ing Jarkko]
> 
> On Thu, 2021-06-10 at 09:16 +0200, Jorge Ramirez-Ortiz, Foundries
> wrote:
> > I am enabling IMA on a ZynqMP based platform using an SPI based TPM
> > from Infineon.
> > 
> > The SPI TPM driver is built-in but since the IMA is initalized from a
> > late_initcall, IMA never finds the TPM.
> > 
> > Is there a recomended way to work around this issue?
> > 
> > fio@uz3cg-dwg:~$ dmesg | grep tpm
> > [    3.381181] tpm_tis_spi spi1.1: 2.0 TPM (device-id 0x1B, rev-id 22)
> > [    3.423608] tpm tpm0: A TPM error (256) occurred attempting the self test
> > [    3.430406] tpm tpm0: starting up the TPM manually
> > 
> > fio@uz3cg-dwg:~$ dmesg | grep ima
> > [    3.525741] ima: No TPM chip found, activating TPM-bypass!
> > [    3.531233] ima: Allocated hash algorithm: sha1
> 
> Lengthening the TPM timeout, executing the TPM self test have been past
> reasons for the TPM not to initialize prior to IMA.

right, I can understand this.

The problem in this case is that tpm_chip_register() is taking too
long so by the time it executes tpm_add_char_device(chip) is called,
ima has already given up.

The way I am working around this is just by adding a new flag and
providing the chip in idr_alloc (so ima can find it).

Then add an 'enable' flag to the chip structure that ima can use to
wait on.

@@ -333,8 +345,13 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,

        chip->ops = ops;

+ if (ops->flags & TPM_OPS_SLOW_STARTUP)
+         chip->flags |= TPM_CHIP_FLAG_SLOW_STARTUP;
+
        mutex_lock(&idr_lock);
-   rc = idr_alloc(&dev_nums_idr, NULL, 0, TPM_NUM_DEVICES, GFP_KERNEL);
+ rc = idr_alloc(&dev_nums_idr,
+                chip->flags & TPM_CHIP_FLAG_SLOW_STARTUP ? chip : NULL,
+                0, TPM_NUM_DEVICES, GFP_KERNEL);
        mutex_unlock(&idr_lock);
        if (rc < 0) {
                dev_err(pdev, "No available tpm device numbers\n");


> 
> (Missing from this bug report is the kernel version.)

um, didnt think of it as a bug report - the feature is clearly not
synchronized so there can be no guarantees about available TPMs being
used. 

but yes, this is happening on 5.10.42 using tpm_tis_spi to connect to
infineon SLM9670

> 
> thanks,
> 
> Mimi
> 
