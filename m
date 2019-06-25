Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D784D55850
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Jun 2019 22:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfFYUDN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Jun 2019 16:03:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbfFYUDM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Jun 2019 16:03:12 -0400
Received: from localhost (unknown [167.220.24.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDA232063F;
        Tue, 25 Jun 2019 20:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561492992;
        bh=fqAZKzKRx/Ot2SysCdAhm3Xfrbk8RJvyM8hT/R8Gqro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IJ9kVUyZoKeKYze/0ESHAr6cvMNpomazRxc1Qc94T0nUUDB9bdfT8pJJPM/hOe7J/
         DSysRTMQw/z8NI19hSEace8e8M/tjrpoEzECdzEImctIwSAPAGnUcMGn3znc7w5Co5
         zxTtS5TKXUdo9ckXSy5d34z84JEfmrxT6Gl7I/E0=
Date:   Tue, 25 Jun 2019 16:03:10 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@microsoft.com, thiruan@microsoft.com,
        bryankel@microsoft.com, tee-dev@lists.linaro.org,
        ilias.apalodimas@linaro.org, sumit.garg@linaro.org
Subject: Re: [PATCH v6 2/2] fTPM: add documentation for ftpm driver
Message-ID: <20190625200310.GC7898@sasha-vm>
References: <20190625195209.13663-1-sashal@kernel.org>
 <20190625195209.13663-3-sashal@kernel.org>
 <b1f27a59-6759-c325-8db5-b2b0f944420c@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b1f27a59-6759-c325-8db5-b2b0f944420c@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 25, 2019 at 12:59:02PM -0700, Randy Dunlap wrote:
>On 6/25/19 12:52 PM, Sasha Levin wrote:
>> This patch adds basic documentation to describe the new fTPM driver.
>>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  Documentation/security/tpm/index.rst        |  1 +
>>  Documentation/security/tpm/tpm_ftpm_tee.rst | 31 +++++++++++++++++++++
>>  2 files changed, 32 insertions(+)
>>  create mode 100644 Documentation/security/tpm/tpm_ftpm_tee.rst
>>
>> diff --git a/Documentation/security/tpm/index.rst b/Documentation/security/tpm/index.rst
>> index af77a7bbb070..15783668644f 100644
>> --- a/Documentation/security/tpm/index.rst
>> +++ b/Documentation/security/tpm/index.rst
>> @@ -4,4 +4,5 @@ Trusted Platform Module documentation
>>
>>  .. toctree::
>>
>> +   tpm_ftpm_tee
>>     tpm_vtpm_proxy
>> diff --git a/Documentation/security/tpm/tpm_ftpm_tee.rst b/Documentation/security/tpm/tpm_ftpm_tee.rst
>> new file mode 100644
>> index 000000000000..29c2f8b5ed10
>> --- /dev/null
>> +++ b/Documentation/security/tpm/tpm_ftpm_tee.rst
>> @@ -0,0 +1,31 @@
>> +=============================================
>> +Firmware TPM Driver
>> +=============================================
>> +
>> +| Authors:
>> +| Thirupathaiah Annapureddy <thiruan@microsoft.com>
>> +| Sasha Levin <sashal@kernel.org>
>> +
>> +This document describes the firmware Trusted Platform Module (fTPM)
>> +device driver.
>> +
>> +Introduction
>> +============
>> +
>> +This driver is a shim for a firmware implemented in ARM's TrustZone
>
>                         for firmware
>
>> +environment. The driver allows programs to interact with the TPM in the same
>> +way the would interact with a hardware TPM.
>
>       they
>
>> +
>> +Design
>> +======
>> +
>> +The driver acts as a thin layer that passes commands to and from a TPM
>> +implemented in firmware. The driver itself doesn't contain much logic and is
>> +used more like a dumb pipe between firmware and kernel/userspace.
>> +
>> +The firmware itself is based on the following paper:
>> +https://www.microsoft.com/en-us/research/wp-content/uploads/2017/06/ftpm1.pdf
>> +
>> +When the driver is loaded it will expose ``/dev/tpmX`` character devices to
>> +userspace which will enable userspace to communicate with the firmware tpm
>
>                                                                          TPM
>
>> +through this device.
>>
>
>Oh, that's the same comments that I made on 2019-06-18:
>https://marc.info/?l=linux-integrity&m=156087157019368&w=2

Appologies Randy, I've missed it. I'll send a new ver in a moment.
Thanks!

--
Thanks,
Sasha
