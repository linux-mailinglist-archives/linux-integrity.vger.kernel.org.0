Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 667E082127
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Aug 2019 18:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbfHEQEJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Aug 2019 12:04:09 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33115 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726847AbfHEQEJ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Aug 2019 12:04:09 -0400
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id A3D53898A8990C361E84;
        Mon,  5 Aug 2019 17:04:06 +0100 (IST)
Received: from [10.210.168.118] (10.210.168.118) by smtpsuk.huawei.com
 (10.201.108.36) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 5 Aug
 2019 17:04:00 +0100
Subject: Re: [PATCH] KEYS: trusted: allow module init if TPM is inactive or
 deactivated
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     <jejb@linux.ibm.com>, <jgg@ziepe.ca>,
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
 <e10f7b04-3d63-435e-180e-72a084ac4bab@huawei.com>
 <1565020459.11223.179.camel@linux.ibm.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <02f749ef-2438-a99b-c5b3-22bc97cc6b7a@huawei.com>
Date:   Mon, 5 Aug 2019 18:04:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1565020459.11223.179.camel@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.210.168.118]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/5/2019 5:54 PM, Mimi Zohar wrote:
> On Mon, 2019-08-05 at 16:50 +0200, Roberto Sassu wrote:
>> Regarding Mimi's proposal to avoid the issue by extending the PCR with
>> zeros, I think it also achieve the goal.
> 
> Roberto, removing the following code from init_digests() would be the
> equivalent to the prior code, without needing to make any other
> changes.  Let's keep it simple.  Do you want to post the patch with
> the change, or should I?

I will send the new patch.

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli
