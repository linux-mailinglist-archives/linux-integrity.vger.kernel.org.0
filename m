Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42A1D33A45
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Jun 2019 23:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfFCVwX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Jun 2019 17:52:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:44450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbfFCVwX (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Jun 2019 17:52:23 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F7D5241CD;
        Mon,  3 Jun 2019 21:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559596609;
        bh=Xgr7lJ3JLwLrJm5SpjRoarLVI9iWkUQs9uPYN4YO6Z8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bvQBuAmLUqTZy22XORfP7W+gTIOX0aBml0W7r3nHT6a7DxOLtLOD0UcQxj//i/hkh
         7Rh2wwX/1MzfoP6ICSngMlEIRZ/9rA2H+4kA2S/pDN1F0r5ChHO8ffBHpDpSL0uu47
         isSYTIplK2rlVjxoE/McfpfayBefl0SEA49Rwka0=
Date:   Mon, 3 Jun 2019 17:16:48 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@microsoft.com,
        thiruan@microsoft.com, bryankel@microsoft.com,
        tee-dev@lists.linaro.org
Subject: Re: [PATCH v4 0/2] fTPM: firmware TPM running in TEE
Message-ID: <20190603211648.GV12898@sasha-vm>
References: <20190530152758.16628-1-sashal@kernel.org>
 <20190603202815.GA4894@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190603202815.GA4894@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jun 03, 2019 at 11:28:15PM +0300, Jarkko Sakkinen wrote:
>On Thu, May 30, 2019 at 11:27:56AM -0400, Sasha Levin wrote:
>> Changes since v3:
>>
>>  - Address comments by Jarkko Sakkinen
>>  - Address comments by Igor Opaniuk
>>
>> Sasha Levin (2):
>>   fTPM: firmware TPM running in TEE
>>   fTPM: add documentation for ftpm driver
>
>I think patches start to look proper but I wonder can anyone test
>these? I don't think before that I can merge these.

They're all functionally tested by us on actual hardware before being
sent out.

The reference implementation is open and being kept updated, and an
interested third party should be able to verify the correctness of these
patches. However, it doesn't look like there's an interested third party
given that these patches have been out for a few months now.

--
Thanks,
Sasha
