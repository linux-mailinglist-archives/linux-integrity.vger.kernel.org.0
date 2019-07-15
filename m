Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9763C69949
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jul 2019 18:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730874AbfGOQo3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Jul 2019 12:44:29 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33085 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730071AbfGOQo3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Jul 2019 12:44:29 -0400
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id CBD685973DB97AE590A7;
        Mon, 15 Jul 2019 17:44:26 +0100 (IST)
Received: from [10.220.96.108] (10.220.96.108) by smtpsuk.huawei.com
 (10.201.108.36) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 15 Jul
 2019 17:44:19 +0100
Subject: Re: [PATCH] KEYS: trusted: allow module init if TPM is inactive or
 deactivated
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     <jejb@linux.ibm.com>, <zohar@linux.ibm.com>, <jgg@ziepe.ca>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <crazyt2019+lml@gmail.com>, <tyhicks@canonical.com>,
        <nayna@linux.vnet.ibm.com>, <silviu.vlasceanu@huawei.com>
References: <20190705163735.11539-1-roberto.sassu@huawei.com>
 <20190711194811.rfsohbfc3a7carpa@linux.intel.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <b4454a78-1f1b-cc75-114a-99926e097b05@huawei.com>
Date:   Mon, 15 Jul 2019 18:44:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190711194811.rfsohbfc3a7carpa@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.220.96.108]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/11/2019 9:48 PM, Jarkko Sakkinen wrote:
> On Fri, Jul 05, 2019 at 06:37:35PM +0200, Roberto Sassu wrote:
>> Commit c78719203fc6 ("KEYS: trusted: allow trusted.ko to initialize w/o a
>> TPM") allows the trusted module to be loaded even a TPM is not found to
>> avoid module dependency problems.
>>
>> Unfortunately, this does not completely solve the issue, as there could be
>> a case where a TPM is found but is not functional (the TPM commands return
>> an error). Specifically, after the tpm_chip structure is returned by
>> tpm_default_chip() in init_trusted(), the execution terminates after
>> init_digests() returns -EFAULT (due to the fact that tpm_get_random()
>> returns a positive value, but less than TPM_MAX_DIGEST_SIZE).
>>
>> This patch fixes the issue by ignoring the TPM_ERR_DEACTIVATED and
>> TPM_ERR_DISABLED errors.
> 
> Why allow trusted module to initialize if TPM is not functional?

According to the bug report at https://bugs.archlinux.org/task/62678,
the trusted module is a dependency of the ecryptfs module. We should
load the trusted module even if the TPM is inactive or deactivated.

Given that commit 782779b60faa ("tpm: Actually fail on TPM errors during
"get random"") changes the return code of tpm_get_random(), the patch
should be modified to ignore the -EIO error. I will send a new version.

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli
