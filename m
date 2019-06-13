Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90925448E0
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Jun 2019 19:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393252AbfFMRLn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jun 2019 13:11:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392711AbfFMRLm (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jun 2019 13:11:42 -0400
Received: from localhost (unknown [131.107.160.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0248C205ED;
        Thu, 13 Jun 2019 17:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560445902;
        bh=no9PMWb5VDOx7ySl5Q7f0oB1g4k565KdjFHzM77TOLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pwobQrn2aoQYIN1bzYPeE5Ko11Ur0FE4EXjws5h5FTkyrG4Rm77bvEnzXFBjvcjPp
         /xjX3Xawq2DH3fe4mM55XcblmrXZTA/Op+UQVzyL1/o0OrLAknvnr0ybQvzBKWlEnS
         t9RrtqaDbsvYLAiE/D8WMC2Zd3a7/dIb4ESmg2CY=
Date:   Thu, 13 Jun 2019 13:11:41 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     peterhuewe@gmx.de,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        jgg@ziepe.ca, corbet@lwn.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        Microsoft Linux Kernel List <linux-kernel@microsoft.com>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        "Bryan Kelly (CSI)" <bryankel@microsoft.com>,
        tee-dev@lists.linaro.org
Subject: Re: [PATCH v4 1/2] fTPM: firmware TPM running in TEE
Message-ID: <20190613171141.GL1513@sasha-vm>
References: <20190530152758.16628-1-sashal@kernel.org>
 <20190530152758.16628-2-sashal@kernel.org>
 <CAFA6WYM1NrghG9qxUhrm76kopvBx9nmCL9XnRs11ysb2Yr0+Qw@mail.gmail.com>
 <20190604200951.GB29739@sasha-vm>
 <CAFA6WYMOjgHRw9RVrjherNo0ZNbTtEonPwSFFC0dT4CZO=A1NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAFA6WYMOjgHRw9RVrjherNo0ZNbTtEonPwSFFC0dT4CZO=A1NQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 05, 2019 at 04:39:36PM +0530, Sumit Garg wrote:
>On Wed, 5 Jun 2019 at 01:39, Sasha Levin <sashal@kernel.org> wrote:
>>
>> On Tue, Jun 04, 2019 at 11:45:52AM +0530, Sumit Garg wrote:
>> >On Thu, 30 May 2019 at 20:58, Sasha Levin <sashal@kernel.org> wrote:
>> >> +       /* Open context with TEE driver */
>> >> +       pvt_data->ctx = tee_client_open_context(NULL, ftpm_tee_match, NULL,
>> >> +                                               NULL);
>> >> +       if (IS_ERR(pvt_data->ctx)) {
>> >> +               dev_err(dev, "%s:tee_client_open_context failed\n", __func__);
>> >
>> >Is this well tested? I see this misleading error multiple times as
>> >follows although TEE driver works pretty well.
>>
>> Yes, this was all functionally tested.
>
>Can you share your build instructions and testing approach?

Yes: it looks like you got all the kernel bits, but not the firmware.
There are instructions for it here: https://github.com/microsoft/ms-tpm-20-ref

Once it's running, you can test it by running your favorite TPM usecases
through /dev/tpm0.

--
Thanks,
Sasha
