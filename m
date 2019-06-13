Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E09143F39
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Jun 2019 17:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731545AbfFMPzb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jun 2019 11:55:31 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33007 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731543AbfFMIv6 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jun 2019 04:51:58 -0400
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id E13342F4C597DB972D83;
        Thu, 13 Jun 2019 09:51:56 +0100 (IST)
Received: from [10.220.96.108] (10.220.96.108) by smtpsuk.huawei.com
 (10.201.108.35) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 13 Jun
 2019 09:51:50 +0100
Subject: Re: [PATCH v3 0/2] ima/evm fixes for v5.2
To:     Janne Karhunen <janne.karhunen@gmail.com>
CC:     Mimi Zohar <zohar@linux.ibm.com>, <dmitry.kasatkin@huawei.com>,
        <mjg59@google.com>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <silviu.vlasceanu@huawei.com>
References: <20190606112620.26488-1-roberto.sassu@huawei.com>
 <CAE=NcraYOw9B3RFu3_DbJs9nPT87AtQEptC7zF4kAu4FP8YhxA@mail.gmail.com>
 <d9efe3c7-20dd-bbb0-40d8-40f69cba5b88@huawei.com>
 <CAE=NcraHqzST=SZNcrSgpv5EqfyUfpCCb7iQ0Oh6uohL3yiCdw@mail.gmail.com>
 <c13c6b4f-1302-35fb-f077-00b7f84fea08@huawei.com>
 <CAE=NcrZiyWjZUuxdLgA9Bq89Cpt1W6MLAzPkLHVgfOqSo2i1hQ@mail.gmail.com>
 <144bf319-ea0c-f6b6-5737-0aac34f37186@huawei.com>
 <CAE=NcrZgQSENPOtRdU=u1y6kqy0ouaaj-gioKHaUxZUcbUHwqA@mail.gmail.com>
 <3911846b-f836-592a-81e1-a2fd25470d98@huawei.com>
 <CAE=NcraD_DcSqog8XbisA+0YdNqwj0v_jZhzjR2Na0eZ-2XgJQ@mail.gmail.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <af08b46a-323e-5f91-e349-731ee9ea24ab@huawei.com>
Date:   Thu, 13 Jun 2019 10:51:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAE=NcraD_DcSqog8XbisA+0YdNqwj0v_jZhzjR2Na0eZ-2XgJQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.220.96.108]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/13/2019 10:04 AM, Janne Karhunen wrote:
> On Thu, Jun 13, 2019 at 10:50 AM Roberto Sassu <roberto.sassu@huawei.com> wrote:
> 
>>> Would the appraise actually need any changes, just keep the
>>> IMA_NEW_FILE in ima_check_last_writer()? Of course it's not that easy
>>> (it never is) as the iint could go away and things like that, but with
>>> some tweaks?
>>
>> I think the problem would be that the code that sets the status to
>> INTEGRITY_PASS is not executed, because the file gets security.ima after
>> the first write.
> 
> We have a patchset coming shortly that starts tracking the inode
> changes as we go, so first time we fix it is when the file is created
> before it has any content (!);
> 
> diff --git a/security/integrity/ima/ima_appraise.c
> b/security/integrity/ima/ima_appraise.c
> index 5fb7127bbe68..da4f0afe0348 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -236,8 +236,10 @@ int ima_appraise_measurement(enum ima_hooks func,
>                          iint->flags |= IMA_NEW_FILE;
>                  if ((iint->flags & IMA_NEW_FILE) &&
>                      (!(iint->flags & IMA_DIGSIG_REQUIRED) ||
> -                    (inode->i_size == 0)))
> +                    (inode->i_size == 0))) {
> +                       ima_fix_xattr(dentry, iint);
>                          status = INTEGRITY_PASS;

Some time ago I developed this patch:

http://kernsec.org/pipermail/linux-security-module-archive/2017-November/004569.html

Since the appraisal flags are not cleared, ima_appraise_measurement() is
not executed again and the problem with EVM does not arise.

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
