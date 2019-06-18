Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 352394A547
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Jun 2019 17:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbfFRP0H (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Jun 2019 11:26:07 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48970 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728982AbfFRP0H (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Jun 2019 11:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zDQuLvyPeQhgh7/ZzmUlpMUVHgADFhKIg7Jx10j8T5Y=; b=PHPN2gJTKxWUHzfd0/kg7rMWvA
        Yj3i5FFGVoxgSjQttV4VLQROldiE+URTLhWKZONApFUFQZPSia/6BqSPcPFo1hHkvmDU+1zb/7KH8
        iAfuTs7fL8c+u3T4C7a5k8A+vCStaGR7Rq866QEQuJgAAfPc/5Z6TwmPANQLLk+JTxtXZdeHvEbhi
        x5ZWr4fkXLWhGIsf/tgQyShCfFSeWbXWjzoJvmqEgvksGpX0524r9XpMHLI03T/R3ZdqG1duoVouV
        4/V9aXlXKwpWtE7Qty9AtdI5jjEhd3yIreXwmZgu7AvtuvokiWBkx+2gDLHn44ABf3u+mvkf4vZV7
        MTxOG69Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdFzm-0000Kn-4u; Tue, 18 Jun 2019 15:26:02 +0000
Subject: Re: [PATCH v4 2/2] fTPM: add documentation for ftpm driver
To:     Sasha Levin <sashal@kernel.org>, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@microsoft.com, thiruan@microsoft.com,
        bryankel@microsoft.com, tee-dev@lists.linaro.org
References: <20190530152758.16628-1-sashal@kernel.org>
 <20190530152758.16628-3-sashal@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c1cf6154-7140-66c9-dff9-dc7a788df518@infradead.org>
Date:   Tue, 18 Jun 2019 08:25:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190530152758.16628-3-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 5/30/19 8:27 AM, Sasha Levin wrote:
> This patch adds basic documentation to describe the new fTPM driver.
> 
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
> ---
>  Documentation/security/tpm/index.rst        |  1 +
>  Documentation/security/tpm/tpm_ftpm_tee.rst | 31 +++++++++++++++++++++
>  2 files changed, 32 insertions(+)
>  create mode 100644 Documentation/security/tpm/tpm_ftpm_tee.rst

Hi,
Just some minor editing...

> diff --git a/Documentation/security/tpm/tpm_ftpm_tee.rst b/Documentation/security/tpm/tpm_ftpm_tee.rst
> new file mode 100644
> index 0000000000000..29c2f8b5ed100
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


-- 
~Randy
