Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8609E5752A
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Jun 2019 01:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfFZX7s (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Jun 2019 19:59:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbfFZX7s (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Jun 2019 19:59:48 -0400
Received: from localhost (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82F7A20815;
        Wed, 26 Jun 2019 23:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561593587;
        bh=Lw9HtGfPREqavbvapHcgRZQkOGxyNxcVc0zpkrELm54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ka8Lvxc/r9xQrfl57ediU3aHioTQcZYpOBQhWHYASAbZBxxigb8UkPCbQR5AdQuRG
         psdzgQ0kDhqolNy4sx+yEmzGtmkPJXxW7xesBVJESUSrCz7VuYE/S72sWQEqUC+/wc
         /8eQp9CUB1zhRZik9WVGSSPh4OxZhbXOHPMteAD8=
Date:   Wed, 26 Jun 2019 19:59:43 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@microsoft.com,
        thiruan@microsoft.com, bryankel@microsoft.com,
        tee-dev@lists.linaro.org, ilias.apalodimas@linaro.org,
        sumit.garg@linaro.org, rdunlap@infradead.org
Subject: Re: [PATCH v7 2/2] fTPM: add documentation for ftpm driver
Message-ID: <20190626235943.GM7898@sasha-vm>
References: <20190625201341.15865-1-sashal@kernel.org>
 <20190625201341.15865-3-sashal@kernel.org>
 <4bb41de0cd2b0bf89a20dd55576acf15594ae8de.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <4bb41de0cd2b0bf89a20dd55576acf15594ae8de.camel@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 27, 2019 at 02:34:06AM +0300, Jarkko Sakkinen wrote:
>On Tue, 2019-06-25 at 16:13 -0400, Sasha Levin wrote:
>> This patch adds basic documentation to describe the new fTPM driver.
>>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  Documentation/security/tpm/index.rst        |  1 +
>>  Documentation/security/tpm/tpm_ftpm_tee.rst | 31 +++++++++++++++++++++
>>  2 files changed, 32 insertions(+)
>>  create mode 100644 Documentation/security/tpm/tpm_ftpm_tee.rst
>>
>> diff --git a/Documentation/security/tpm/index.rst
>> b/Documentation/security/tpm/index.rst
>> index af77a7bbb070..15783668644f 100644
>> --- a/Documentation/security/tpm/index.rst
>> +++ b/Documentation/security/tpm/index.rst
>> @@ -4,4 +4,5 @@ Trusted Platform Module documentation
>>
>>  .. toctree::
>>
>> +   tpm_ftpm_tee
>>     tpm_vtpm_proxy
>> diff --git a/Documentation/security/tpm/tpm_ftpm_tee.rst
>> b/Documentation/security/tpm/tpm_ftpm_tee.rst
>> new file mode 100644
>> index 000000000000..48de0dcec0f6
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
>
>The way I see it this thing should not exist here at all but the
>first patch should have co-developed-by in addition to
>signed-off-by from you. Otherwise looks good. The list of authors
>is againt something that Git does better than humans.

I've dropped this part, but left the co-developed tag out, I honestly
don't think that I had significant contribution here.

--
Thanks,
Sasha
