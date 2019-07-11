Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4433F660BE
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jul 2019 22:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbfGKUfn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Jul 2019 16:35:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728355AbfGKUfn (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Jul 2019 16:35:43 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FBDB206B8;
        Thu, 11 Jul 2019 20:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562877342;
        bh=hfnFl7VTYjBEMlwgwzL7ALQj3UVAUmLE8HOpQ1WsSVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xlEmSwZQoGr4heZcmHNdXp8tsiny7MLfd8yHumZE7vRH2pM8GvHXxRZABCE0+nRDx
         uSFdLJCHt5hvibs9i6DmBfe+/RYnHvG7+kCdlc6O1kRYgCbsXmg2P2r008qk4oaAWc
         mpHx/+x2o63yh0M0CmHoSsIIIxNt1p2MvWyS40kA=
Date:   Thu, 11 Jul 2019 16:35:41 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        peterhuewe@gmx.de, jgg@ziepe.ca, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@microsoft.com,
        thiruan@microsoft.com, bryankel@microsoft.com,
        tee-dev@lists.linaro.org, sumit.garg@linaro.org,
        rdunlap@infradead.org
Subject: Re: [PATCH v8 0/2] fTPM: firmware TPM running in TEE
Message-ID: <20190711203541.GC10104@sasha-vm>
References: <20190705204746.27543-1-sashal@kernel.org>
 <20190711200858.xydm3wujikufxjcw@linux.intel.com>
 <20190711201059.GA18260@apalos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190711201059.GA18260@apalos>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jul 11, 2019 at 11:10:59PM +0300, Ilias Apalodimas wrote:
>On Thu, Jul 11, 2019 at 11:08:58PM +0300, Jarkko Sakkinen wrote:
>> On Fri, Jul 05, 2019 at 04:47:44PM -0400, Sasha Levin wrote:
>> > Changes from v7:
>> >
>> >  - Address Jarkko's comments.
>> >
>> > Sasha Levin (2):
>> >   fTPM: firmware TPM running in TEE
>> >   fTPM: add documentation for ftpm driver
>> >
>> >  Documentation/security/tpm/index.rst        |   1 +
>> >  Documentation/security/tpm/tpm_ftpm_tee.rst |  27 ++
>> >  drivers/char/tpm/Kconfig                    |   5 +
>> >  drivers/char/tpm/Makefile                   |   1 +
>> >  drivers/char/tpm/tpm_ftpm_tee.c             | 350 ++++++++++++++++++++
>> >  drivers/char/tpm/tpm_ftpm_tee.h             |  40 +++
>> >  6 files changed, 424 insertions(+)
>> >  create mode 100644 Documentation/security/tpm/tpm_ftpm_tee.rst
>> >  create mode 100644 drivers/char/tpm/tpm_ftpm_tee.c
>> >  create mode 100644 drivers/char/tpm/tpm_ftpm_tee.h
>> >
>> > --
>> > 2.20.1
>> >
>>
>> I applied the patches now. Appreciate a lot the patience with these.
>> Thank you.

Thanks Jarkko!

>Will report back any issues when we start using it on real hardware
>rather than QEMU

And thank you Ilias, let us know if we can help with the setup.

--
Thanks,
Sasha
