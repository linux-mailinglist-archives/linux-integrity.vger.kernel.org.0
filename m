Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88FFA8249C
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Aug 2019 20:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbfHESFU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Aug 2019 14:05:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730011AbfHESFU (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Aug 2019 14:05:20 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36C1A206A2;
        Mon,  5 Aug 2019 18:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565028319;
        bh=4zj0WOS0HKxI+9HNAwbT0W8pBLSjUbq7Qvos7piJMe8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HHpciDACnikAmxWjh5CUq79Xi+1N61c7Mf/IK9ah412iKlsgGkpZ7W+vNAETumn6B
         D0vaQYM32YAo8YFFV5Ux2xqjo0agtKj43xUn7ENA5JJGOP2ffGK1wn19/AyzUhK//y
         xXSnRgZKfECIZS+vd5UoPR9TJo8YIdJKFpUYbkO4=
Date:   Mon, 5 Aug 2019 14:05:18 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@microsoft.com,
        thiruan@microsoft.com, bryankel@microsoft.com,
        tee-dev@lists.linaro.org, ilias.apalodimas@linaro.org,
        sumit.garg@linaro.org, rdunlap@infradead.org
Subject: Re: [PATCH v8 0/2] fTPM: firmware TPM running in TEE
Message-ID: <20190805180518.GC17747@sasha-vm>
References: <20190705204746.27543-1-sashal@kernel.org>
 <20190711200858.xydm3wujikufxjcw@linux.intel.com>
 <20190804214218.vdv2sn4oc4cityy2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190804214218.vdv2sn4oc4cityy2@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Aug 05, 2019 at 12:44:28AM +0300, Jarkko Sakkinen wrote:
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
>
>Hi, can you possibly fix these:

Any objection to sending you a patch on top of your tree instead?

--
Thanks,
Sasha
