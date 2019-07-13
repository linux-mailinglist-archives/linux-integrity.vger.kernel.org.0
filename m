Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E52FC67ADA
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Jul 2019 17:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfGMPLB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 13 Jul 2019 11:11:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727656AbfGMPLB (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 13 Jul 2019 11:11:01 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 253AD20838;
        Sat, 13 Jul 2019 15:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563030660;
        bh=kE7m9cGprI//uvkO6ecB5iEt1Q6DfXVSibQcRX0j3EM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=psrHfeGU2v9zEcMUhCgl8Sct2dyMyH8o+Kp0lXmkTYGVoQHKsBRM5DakR9oTnmdCK
         QsAZPgIvfhwrnBefDtqkmGRyyLAOXnR/6O34qU86VhkBUSCNtBwjrXpnQsinqyi+tf
         dxT9GMZN+6Wh4YDV/UrTu2JgZsEcD3dzyEYCg5tc=
Date:   Sat, 13 Jul 2019 11:10:59 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Peter Huewe <peterhuewe@gmx.de>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fTPM: fix PTR_ERR() usage
Message-ID: <20190713151059.GG10104@sasha-vm>
References: <20190712114951.912328-1-arnd@arndb.de>
 <730715760b20d9a76aa93c3ebc39a62045c9ee34.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <730715760b20d9a76aa93c3ebc39a62045c9ee34.camel@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jul 12, 2019 at 06:34:24PM +0300, Jarkko Sakkinen wrote:
>On Fri, 2019-07-12 at 13:49 +0200, Arnd Bergmann wrote:
>> A last minute change must have confused PTR_ERR() and ERR_PTR():
>>
>> drivers/char/tpm/tpm_ftpm_tee.c:236:15: error: incompatible pointer to integer
>> conversion passing 'struct tee_context *' to parameter of type 'long' [-
>> Werror,-Wint-conversion]
>>                 if (ERR_PTR(pvt_data->ctx) == -ENOENT)
>> drivers/char/tpm/tpm_ftpm_tee.c:239:18: error: incompatible pointer to integer
>> conversion passing 'struct tee_context *' to parameter of type 'long' [-
>> Werror,-Wint-conversion]
>>                 return ERR_PTR(pvt_data->ctx);
>>
>> Fixes: c975c3911cc2 ("fTPM: firmware TPM running in TEE")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
>Arnd, thanks.
>
>I squashed this to the associated commit.
>
>I also fine-tuned the commit messages a bit (tag, imperative form).

Yes, thank you!

>Started also wondering tha tpm_ftpm_tee is a too generic name given that
>this is for ARM TZ only. Would it make sense to rename it as something
>like tpm_ftpm_tee_arm? Other proposals are welcome. Just made something
>up.

Hm, isn't the _tee part enough?

--
Thanks,
Sasha
