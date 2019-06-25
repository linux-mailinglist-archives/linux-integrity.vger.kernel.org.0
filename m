Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE6865583A
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Jun 2019 21:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfFYT7O (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Jun 2019 15:59:14 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33820 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfFYT7O (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Jun 2019 15:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=M13y4bEHrcxg1rD7DcFMjouLInW22ljnU7XR1V6yjbI=; b=vZO2SEtG27XB0OpNP7Oj9VqKY1
        ueZ00+MzO5uEdivs0+/T2D40mLVl0aiZ//LTCncXwm4Xw7o12hcG3OmrWPfOri25/CfREkcwI502x
        h75DVq1qbPylszfnPvMvIlRIBJD4vm7P77az4vaP+9uAZ+OTMTE+piJ5MSqM+e13ROSbH5JIcFfrp
        x3wyItyba3HLje9Bxx1OK6EBNZ6S5xrq5rd0WI3rbmgAEb1L9iI4txNGTDdbXAGjxwPkMsP4guwDr
        OZZ0j5uBp2Mo+gol8hFgQPjSVQb2+t759TS7hzWoN6x58odxvsGLgGj3si50oLzVh7HiA/Ewj5WTr
        VTvpwueA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfrar-0006vl-Dk; Tue, 25 Jun 2019 19:59:05 +0000
Subject: Re: [PATCH v6 2/2] fTPM: add documentation for ftpm driver
To:     Sasha Levin <sashal@kernel.org>, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@microsoft.com, thiruan@microsoft.com,
        bryankel@microsoft.com, tee-dev@lists.linaro.org,
        ilias.apalodimas@linaro.org, sumit.garg@linaro.org
References: <20190625195209.13663-1-sashal@kernel.org>
 <20190625195209.13663-3-sashal@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b1f27a59-6759-c325-8db5-b2b0f944420c@infradead.org>
Date:   Tue, 25 Jun 2019 12:59:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190625195209.13663-3-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/25/19 12:52 PM, Sasha Levin wrote:
> This patch adds basic documentation to describe the new fTPM driver.
> 
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  Documentation/security/tpm/index.rst        |  1 +
>  Documentation/security/tpm/tpm_ftpm_tee.rst | 31 +++++++++++++++++++++
>  2 files changed, 32 insertions(+)
>  create mode 100644 Documentation/security/tpm/tpm_ftpm_tee.rst
> 
> diff --git a/Documentation/security/tpm/index.rst b/Documentation/security/tpm/index.rst
> index af77a7bbb070..15783668644f 100644
> --- a/Documentation/security/tpm/index.rst
> +++ b/Documentation/security/tpm/index.rst
> @@ -4,4 +4,5 @@ Trusted Platform Module documentation
>  
>  .. toctree::
>  
> +   tpm_ftpm_tee
>     tpm_vtpm_proxy
> diff --git a/Documentation/security/tpm/tpm_ftpm_tee.rst b/Documentation/security/tpm/tpm_ftpm_tee.rst
> new file mode 100644
> index 000000000000..29c2f8b5ed10
> --- /dev/null
> +++ b/Documentation/security/tpm/tpm_ftpm_tee.rst
> @@ -0,0 +1,31 @@
> +=============================================
> +Firmware TPM Driver
> +=============================================
> +
> +| Authors:
> +| Thirupathaiah Annapureddy <thiruan@microsoft.com>
> +| Sasha Levin <sashal@kernel.org>
> +
> +This document describes the firmware Trusted Platform Module (fTPM)
> +device driver.
> +
> +Introduction
> +============
> +
> +This driver is a shim for a firmware implemented in ARM's TrustZone

                         for firmware

> +environment. The driver allows programs to interact with the TPM in the same
> +way the would interact with a hardware TPM.

       they

> +
> +Design
> +======
> +
> +The driver acts as a thin layer that passes commands to and from a TPM
> +implemented in firmware. The driver itself doesn't contain much logic and is
> +used more like a dumb pipe between firmware and kernel/userspace.
> +
> +The firmware itself is based on the following paper:
> +https://www.microsoft.com/en-us/research/wp-content/uploads/2017/06/ftpm1.pdf
> +
> +When the driver is loaded it will expose ``/dev/tpmX`` character devices to
> +userspace which will enable userspace to communicate with the firmware tpm

                                                                          TPM

> +through this device.
> 

Oh, that's the same comments that I made on 2019-06-18:
https://marc.info/?l=linux-integrity&m=156087157019368&w=2


-- 
~Randy
