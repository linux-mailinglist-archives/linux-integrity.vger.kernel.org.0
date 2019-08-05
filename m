Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 675B881F79
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Aug 2019 16:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfHEOuz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Aug 2019 10:50:55 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33114 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728815AbfHEOuz (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Aug 2019 10:50:55 -0400
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 443347AA8897794C0CE7;
        Mon,  5 Aug 2019 15:50:53 +0100 (IST)
Received: from [10.210.168.118] (10.210.168.118) by smtpsuk.huawei.com
 (10.201.108.36) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 5 Aug
 2019 15:50:43 +0100
Subject: Re: [PATCH] KEYS: trusted: allow module init if TPM is inactive or
 deactivated
To:     Tyler Hicks <tyhicks@canonical.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     <jejb@linux.ibm.com>, <zohar@linux.ibm.com>, <jgg@ziepe.ca>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <crazyt2019+lml@gmail.com>, <nayna@linux.vnet.ibm.com>,
        <silviu.vlasceanu@huawei.com>
References: <20190705163735.11539-1-roberto.sassu@huawei.com>
 <20190711194811.rfsohbfc3a7carpa@linux.intel.com>
 <b4454a78-1f1b-cc75-114a-99926e097b05@huawei.com>
 <20190801163215.mfkagoafkxscesne@linux.intel.com>
 <e50c4cfa-1f0c-6f4d-1910-010a8d874393@huawei.com>
 <20190802142721.GA26616@elm>
 <20190802194226.oiztvme5klkmw6fh@linux.intel.com>
 <20190802202343.GE26616@elm>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <e10f7b04-3d63-435e-180e-72a084ac4bab@huawei.com>
Date:   Mon, 5 Aug 2019 16:50:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190802202343.GE26616@elm>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.168.118]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/2/2019 10:23 PM, Tyler Hicks wrote:
> On 2019-08-02 22:42:26, Jarkko Sakkinen wrote:
>> On Fri, Aug 02, 2019 at 09:27:22AM -0500, Tyler Hicks wrote:
>>> On 2019-08-02 10:21:16, Roberto Sassu wrote:
>>>> On 8/1/2019 6:32 PM, Jarkko Sakkinen wrote:
>>>>> On Mon, Jul 15, 2019 at 06:44:28PM +0200, Roberto Sassu wrote:
>>>>>> According to the bug report at https://bugs.archlinux.org/task/62678,
>>>>>> the trusted module is a dependency of the ecryptfs module. We should
>>>>>> load the trusted module even if the TPM is inactive or deactivated.
>>>>>>
>>>>>> Given that commit 782779b60faa ("tpm: Actually fail on TPM errors during
>>>>>> "get random"") changes the return code of tpm_get_random(), the patch
>>>>>> should be modified to ignore the -EIO error. I will send a new version.
>>>>>
>>>>> Do you have information where this dependency comes from?
>>>>
>>>> ecryptfs retrieves the encryption key from encrypted keys (see
>>>> ecryptfs_get_encrypted_key()).
>>>
>>> That has been there for many years with any problems. It was added
>>> in 2011:
>>>
>>>   commit 1252cc3b232e582e887623dc5f70979418caaaa2
>>>   Author: Roberto Sassu <roberto.sassu@polito.it>
>>>   Date:   Mon Jun 27 13:45:45 2011 +0200
>>>
>>>       eCryptfs: added support for the encrypted key type
>>>
>>> What's recently changed the situation is this patch:
>>>
>>>   commit 240730437deb213a58915830884e1a99045624dc
>>>   Author: Roberto Sassu <roberto.sassu@huawei.com>
>>>   Date:   Wed Feb 6 17:24:51 2019 +0100
>>>
>>>       KEYS: trusted: explicitly use tpm_chip structure from tpm_default_chip()
>>>
>>> Now eCryptfs has a hard dependency on a TPM chip that's working
>>> as expected even if eCryptfs (or the rest of the system) isn't utilizing
>>> the TPM. If the TPM behaves unexpectedly, you can't access your files.
>>> We need to get this straightened out soon.
>>
>> I agree with this conclusion that eCryptfs needs to be fixed, not
>> another workaround to trusted.ko.
> 
> That wasn't the conclusion that I came to. I prefer Robert's proposed
> change to trusted.ko.
> 
> How do you propose that this be fixed in eCryptfs?
> 
> Removing encrypted_key support from eCryptfs is the only way that I can
> see to fix the bug in eCryptfs. That support has been there since 2011.
> I'm not sure of the number of users that would be broken by removing
> encrypted_key support. I don't think the number is high but I can't say
> that confidently.
> 
> Roberto, what was your use case when you added encrypted_key support to
> eCryptfs back then? Are you aware of any users of eCryptfs +
> encrypted_keys?

Well, my use case at that time (I was at the university) was to provide
a secure storage based on TPM. I'm not aware of users of this
functionality, but I believe that it is reasonable (depending on how
trusted keys are used, the secure storage is available only on a
specific platform and if the software configuration is good). This
secure storage would be even more effective if it is coupled with
Mandatory Access Control, to release sensitive data only to the
legitimate applications.


> Jarkko, removing a long-standing feature is potentially more disruptive
> to users than adding a workaround to trusted.ko which already requires a
> similar workaround. I don't think that I agree with you on the proper
> fix here.

I also don't think it is a good idea to remove this functionality.

Jarkko, we were discussing about this issue in another thread, and your
answer then (https://lkml.org/lkml/2019/3/21/396) was that it is a
priority to fix the regression.

The patch I proposed (https://lkml.org/lkml/2019/8/2/1282, I will apply
Tyler's comments) is not invasive and fixes the issue. If the digests
pointer is still NULL, pcrlock() returns an error.

Regarding Mimi's proposal to avoid the issue by extending the PCR with
zeros, I think it also achieve the goal. The purpose of pcrlock() is to
prevent unsealing of sealed data outside the kernel. If PCR values do
not change, sealed data can be unsealed and misused by a user space
process.

Extending the PCR with any value would be sufficient, as the extend
operation (the only way to update PCRs) was designed in a way that
finding the value that would be passed to the extend operation to obtain
again one of the previous PCR values is computationally infeasible.

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli
