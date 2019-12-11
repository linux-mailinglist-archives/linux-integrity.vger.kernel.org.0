Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4E9911BA65
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2019 18:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfLKRfO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Dec 2019 12:35:14 -0500
Received: from linux.microsoft.com ([13.77.154.182]:56954 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbfLKRfO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Dec 2019 12:35:14 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id CDC0020B7187;
        Wed, 11 Dec 2019 09:35:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CDC0020B7187
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1576085713;
        bh=nSJ76MuThJZImWshPx8k80CuagJmlu+tb/uEOZgjAGg=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=ivQ0dab4ovb5UalORzdy7Dl6LYZMulUKi7xGZXL4l7sv08EU9q9nxr2kj7zcFfvB0
         GXRxF2aDPvQsX+Q8e2OiJnMtHkaiDNRx1C244jipfbrwSPRMeQHKrSp0iYVkCyk09E
         10bCMvKT0TSgX5XQYhsNf2TWzK+D4/F36RYRbOBA=
Subject: Re: Does IMA support SHA-256 PCR banks?
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
References: <62e91411-d38d-8b75-bf0e-849fdd3c447f@linux.microsoft.com>
 <36fb73d7534f47b6906c348792bd5d96@huawei.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <4673b391-6936-d2c1-bbd1-cd5daf6937f7@linux.microsoft.com>
Date:   Wed, 11 Dec 2019 09:35:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <36fb73d7534f47b6906c348792bd5d96@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/11/19 12:45 AM, Roberto Sassu wrote:

> 
> Hi Lakshmi
> 
> currently the SHA256 PCR bank is extended with a padded SHA1.
> 
> Some time ago, I posted some patches to support the TGC Crypto Agile format:
> 
> https://lkml.org/lkml/2017/5/16/369
> 
> However, this is a bit complicate because the current format does not follow
> the TCG standard. A work to support the new IMA Canonical Event Log format
> has been presented at LSS:
> 
> https://static.sched.com/hosted_files/lssna18/03/lss_2018_slides_V4.pdf
> 
> Given that the patches are very invasive, to me seems a good idea to split this
> work in two parts: first, extend PCRs with the correct digest and second
> change the measurement list format.
> 
> For the first part, the patch will be very simple, as IMA will just query the TPM
> to get the list of hash algorithms and will calculate all the digests in
> ima_calc_field_array_hash().
> 
> Also, the first part would be sufficient for remote attestation, as the data used
> to calculate the digests is passed to the verifier. The verifier can calculate by
> himself the digest of non-SHA1 PCR banks, even if they are not included in the
> measurement list.
> 
> Roberto
> 

Thanks Roberto for the info and the link to the related patches posted 
earlier. I'll take a look at the patches.

thanks,
  -lakshmi

