Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBBF07EF03
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Aug 2019 10:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbfHBIVf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Aug 2019 04:21:35 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33107 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727008AbfHBIVf (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Aug 2019 04:21:35 -0400
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 367D3321756B743FA386;
        Fri,  2 Aug 2019 09:21:33 +0100 (IST)
Received: from [10.220.133.57] (10.220.133.57) by smtpsuk.huawei.com
 (10.201.108.36) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 2 Aug
 2019 09:21:25 +0100
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
 <b4454a78-1f1b-cc75-114a-99926e097b05@huawei.com>
 <20190801163215.mfkagoafkxscesne@linux.intel.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <e50c4cfa-1f0c-6f4d-1910-010a8d874393@huawei.com>
Date:   Fri, 2 Aug 2019 10:21:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190801163215.mfkagoafkxscesne@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.220.133.57]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/1/2019 6:32 PM, Jarkko Sakkinen wrote:
> On Mon, Jul 15, 2019 at 06:44:28PM +0200, Roberto Sassu wrote:
>> According to the bug report at https://bugs.archlinux.org/task/62678,
>> the trusted module is a dependency of the ecryptfs module. We should
>> load the trusted module even if the TPM is inactive or deactivated.
>>
>> Given that commit 782779b60faa ("tpm: Actually fail on TPM errors during
>> "get random"") changes the return code of tpm_get_random(), the patch
>> should be modified to ignore the -EIO error. I will send a new version.
> 
> Do you have information where this dependency comes from?

ecryptfs retrieves the encryption key from encrypted keys (see
ecryptfs_get_encrypted_key()).

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli
