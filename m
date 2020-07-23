Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55FC722A630
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jul 2020 05:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgGWDnM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Jul 2020 23:43:12 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8258 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726003AbgGWDnM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Jul 2020 23:43:12 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 276ECAB6227FA4A764CC;
        Thu, 23 Jul 2020 11:43:10 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.33) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Thu, 23 Jul 2020
 11:43:09 +0800
Subject: Re: [PATCH 1/3] tpm: Put the TCPA table buf after using it
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        <linux-integrity@vger.kernel.org>
References: <1594986348-52258-1-git-send-email-guohanjun@huawei.com>
 <20200723031900.GA47866@linux.intel.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <c13fc023-dc00-192c-45c8-d97385c3283e@huawei.com>
Date:   Thu, 23 Jul 2020 11:43:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200723031900.GA47866@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.33]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2020/7/23 11:21, Jarkko Sakkinen wrote:
> On Fri, Jul 17, 2020 at 07:45:46PM +0800, Hanjun Guo wrote:
>> The acpi_get_table() should be coupled with acpi_put_table() if
>> the mapped table is not used for runtime to release the table
>> mapping, put the TCPA table buf after using it.
>>
>> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> 
> In a commit message you should first describe the action taken and
> then the rationale of doing that e.g. "Couple acpi_get_table() with
> acpi_put_table() in order to prevent a memory leak."
> 
> In addition, please put a fixes tag.
> 
> Please read the section two from the submitting patches guide:
> 
> https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html

Thanks for the comments, I will update this patch set
and send a new version.

Thanks
Hanjun

