Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF205ABF9
	for <lists+linux-integrity@lfdr.de>; Sat, 29 Jun 2019 17:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfF2PBs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 29 Jun 2019 11:01:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbfF2PBs (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 29 Jun 2019 11:01:48 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E6BC208E3;
        Sat, 29 Jun 2019 15:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561820507;
        bh=caaGJU8UDhuKtp8FRlsWrsEYDrZQrfr6zLk+xngL3gQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rt5tRCu4ori8ybhSLB4EWixfe22aGZbTB2xl8C7tTvqNX8McdQJt7mrFqvRLdHRWJ
         vJUwWqo5Hc6DYiUk40C0oA9LbJaebPvoanwD9CXBsyeiSHak3ASJtaybC+Ea0D2ZQJ
         VBGDkGaAZFH/ZkrhZ/fOmLNxqlnyTb0hhsiXp1v0=
Date:   Sat, 29 Jun 2019 11:01:45 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@microsoft.com,
        thiruan@microsoft.com, bryankel@microsoft.com,
        tee-dev@lists.linaro.org, ilias.apalodimas@linaro.org,
        sumit.garg@linaro.org, rdunlap@infradead.org
Subject: Re: [PATCH v7 1/2] fTPM: firmware TPM running in TEE
Message-ID: <20190629150145.GL11506@sasha-vm>
References: <20190625201341.15865-1-sashal@kernel.org>
 <20190625201341.15865-2-sashal@kernel.org>
 <673dd30d03e8ed9825bb46ef21b2efef015f6f2a.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <673dd30d03e8ed9825bb46ef21b2efef015f6f2a.camel@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 27, 2019 at 02:31:35AM +0300, Jarkko Sakkinen wrote:
>On Tue, 2019-06-25 at 16:13 -0400, Sasha Levin wrote:
>> +static const uuid_t ftpm_ta_uuid =
>> +	UUID_INIT(0xBC50D971, 0xD4C9, 0x42C4,
>> +		  0x82, 0xCB, 0x34, 0x3F, 0xB7, 0xF3, 0x78, 0x96);
>> +
>> +/**
>> + * ftpm_tee_tpm_op_recv - retrieve fTPM response.
>> + *
>
>Should not have an empty line here.
>
>> + * @chip: the tpm_chip description as specified in driver/char/tpm/tpm.h.
>> + * @buf: the buffer to store data.
>> + * @count: the number of bytes to read.

Jarkko, w.r.t your comment above, there is an empty line between the
function name and variables in drivers/char/tpm, and in particular
tpm_crb.c which you authored and I used as reference. Do you want us to
diverge here?

--
Thanks,
Sasha
