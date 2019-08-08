Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1272285769
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Aug 2019 03:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730628AbfHHBIt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Aug 2019 21:08:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730626AbfHHBIt (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Aug 2019 21:08:49 -0400
Received: from localhost (unknown [65.200.167.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95AD82184E;
        Thu,  8 Aug 2019 01:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565226528;
        bh=gNF57YoB8Yriv3C573qb+XOB2FsI9s0QaaJyXutg9/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2rvV4yOfIXfCJEHpC25spqGYHKgBoT+0D1pdEzPhdDAydud2z/8PVw9DNztXtoWd7
         qAEBNzMOLYsSA3bMFMftKIzenyOnpiASeKaPlKnfJT8e6L0fb1WgoXGhgm1o/FxXKI
         hVkWhYor2eLDGFTlIJlf27KYWw66edIxKiKN1jaE=
Date:   Wed, 7 Aug 2019 21:08:47 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@microsoft.com,
        thiruan@microsoft.com, bryankel@microsoft.com,
        tee-dev@lists.linaro.org, ilias.apalodimas@linaro.org,
        sumit.garg@linaro.org, rdunlap@infradead.org
Subject: Re: [PATCH v8 0/2] fTPM: firmware TPM running in TEE
Message-ID: <20190808010847.GU17747@sasha-vm>
References: <20190705204746.27543-1-sashal@kernel.org>
 <20190711200858.xydm3wujikufxjcw@linux.intel.com>
 <20190804214218.vdv2sn4oc4cityy2@linux.intel.com>
 <20190805180518.GC17747@sasha-vm>
 <20190805223324.qvbqa45xnp5fgsib@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190805223324.qvbqa45xnp5fgsib@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Aug 06, 2019 at 01:51:32AM +0300, Jarkko Sakkinen wrote:
>On Mon, Aug 05, 2019 at 02:05:18PM -0400, Sasha Levin wrote:
>> On Mon, Aug 05, 2019 at 12:44:28AM +0300, Jarkko Sakkinen wrote:
>> > On Thu, Jul 11, 2019 at 11:08:58PM +0300, Jarkko Sakkinen wrote:
>> > > On Fri, Jul 05, 2019 at 04:47:44PM -0400, Sasha Levin wrote:
>> > > > Changes from v7:
>> > > >
>> > > >  - Address Jarkko's comments.
>> > > >
>> > > > Sasha Levin (2):
>> > > >   fTPM: firmware TPM running in TEE
>> > > >   fTPM: add documentation for ftpm driver
>> > > >
>> > > >  Documentation/security/tpm/index.rst        |   1 +
>> > > >  Documentation/security/tpm/tpm_ftpm_tee.rst |  27 ++
>> > > >  drivers/char/tpm/Kconfig                    |   5 +
>> > > >  drivers/char/tpm/Makefile                   |   1 +
>> > > >  drivers/char/tpm/tpm_ftpm_tee.c             | 350 ++++++++++++++++++++
>> > > >  drivers/char/tpm/tpm_ftpm_tee.h             |  40 +++
>> > > >  6 files changed, 424 insertions(+)
>> > > >  create mode 100644 Documentation/security/tpm/tpm_ftpm_tee.rst
>> > > >  create mode 100644 drivers/char/tpm/tpm_ftpm_tee.c
>> > > >  create mode 100644 drivers/char/tpm/tpm_ftpm_tee.h
>> > > >
>> > > > --
>> > > > 2.20.1
>> > > >
>> > >
>> > > I applied the patches now. Appreciate a lot the patience with these.
>> > > Thank you.
>> >
>> > Hi, can you possibly fix these:
>>
>> Any objection to sending you a patch on top of your tree instead?
>
>Go ahead. Added the previous patches to my master.

Thanks! I'm getting back home on Monday and I'll send it out right away.

--
Thanks,
Sasha
