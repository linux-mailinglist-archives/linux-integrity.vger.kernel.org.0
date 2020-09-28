Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA5E27A52C
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Sep 2020 03:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgI1BWd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 27 Sep 2020 21:22:33 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51342 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726387AbgI1BWd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 27 Sep 2020 21:22:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id A9BD08EE17F;
        Sun, 27 Sep 2020 18:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601256152;
        bh=yoHIHM3+Su6TOLDsV9bLyo6wb/q8x7fR8ORf1mIC/QI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mqaW3PwczvahHGO2n+c8gTA28ei4nSKyxypJ/dja9Kp/et1p+GZGLVoLMjU6mVbE9
         U2Km0YFUY+/Xruo/5+Slq7prrE6P9wmjoHmFNFIkvejBpUzVCRhVxFJu66kT3iEEoL
         T9Qy7XfAi1JUwIdE72ncZxJil2DdhRi1VZJNQj0s=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MaCHzYzCib9D; Sun, 27 Sep 2020 18:22:32 -0700 (PDT)
Received: from jarvis (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 0D2458EE012;
        Sun, 27 Sep 2020 18:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601256152;
        bh=yoHIHM3+Su6TOLDsV9bLyo6wb/q8x7fR8ORf1mIC/QI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mqaW3PwczvahHGO2n+c8gTA28ei4nSKyxypJ/dja9Kp/et1p+GZGLVoLMjU6mVbE9
         U2Km0YFUY+/Xruo/5+Slq7prrE6P9wmjoHmFNFIkvejBpUzVCRhVxFJu66kT3iEEoL
         T9Qy7XfAi1JUwIdE72ncZxJil2DdhRi1VZJNQj0s=
Message-ID: <0c896ca8eb0e30d6e75843cfbf2aa627ddc63feb.camel@HansenPartnership.com>
Subject: Re: [PATCH] Fix Atmel TPM crash caused by too frequent queries
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Hao Wu <hao.wu@rubrik.com>
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        Hamza Attak <hamza@hpe.com>, nayna@linux.vnet.ibm.com,
        why2jjj.linux@gmail.com, zohar@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Ken Goldman <kgold@linux.ibm.com>,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>
Date:   Sun, 27 Sep 2020 18:22:30 -0700
In-Reply-To: <E6E3C07D-57F4-48F5-B4A9-50868B82E779@rubrik.com>
References: <20200926223150.109645-1-hao.wu@rubrik.com>
         <73405d14d7665e8a4e3e9defde7fb12aeae7784c.camel@HansenPartnership.com>
         <DFD7629C-05BF-46C1-B3D7-92FBBC176D9E@rubrik.com>
         <cf5c8035b7183522fb8a5df4baa95bd24288e61f.camel@HansenPartnership.com>
         <E6E3C07D-57F4-48F5-B4A9-50868B82E779@rubrik.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2020-09-27 at 17:11 -0700, Hao Wu wrote:
> Hi James,
> 
> Maybe there is a misunderstanding. Here I am using tpm_msleep, not
> msleep. tpm_msleep is using usleep underlaying. See
> https://github.com/torvalds/linux/blob/master/drivers/char/tpm/tpm.h#L188

Right, I had missed that.

> The reasons I choose 15ms, is because before 
> https://github.com/torvalds/linux/commit/9f3fc7bcddcb51234e23494531f93ab60475e1c3
> (Where msleep is changed to tpm_msleep (which is essentially
> usleep)), The actual sleep time is 15ms, thus here we change this
> back to 15ms to fix regression.

Right now most TIS TPMs operate successfully with a sleep in there of
the range 0.1-0.5ms.  Upping that to 15ms introduces a 100x delay in
our status wait for the TPM to become ready, potentially slowing down
all TIS TPM operations by 100x, which will hit us most with the PCR
writes we do for IMA logging ... that seems like a bad bargain for a
single TPM family manufacturer.

However, there is another possibility: it's something to do with the
byte read; I notice you don't require the same slowdown for the burst
count read, which actually reads the status register and burst count as
a read32.  If that really is the case, for the atmel would substituting
a read32 and just throwing the upper bytes away in tpm_tis_status()
allow us to keep the current timings?  I can actually try doing this
and see if it fixes my nuvoton.

James


