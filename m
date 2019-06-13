Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76226444F4
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Jun 2019 18:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbfFMQkv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jun 2019 12:40:51 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33005 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730575AbfFMG5J (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jun 2019 02:57:09 -0400
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 81C2BB8CCEE475682587;
        Thu, 13 Jun 2019 07:57:07 +0100 (IST)
Received: from [10.220.96.108] (10.220.96.108) by smtpsuk.huawei.com
 (10.201.108.35) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 13 Jun
 2019 07:56:58 +0100
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
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <144bf319-ea0c-f6b6-5737-0aac34f37186@huawei.com>
Date:   Thu, 13 Jun 2019 08:57:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAE=NcrZiyWjZUuxdLgA9Bq89Cpt1W6MLAzPkLHVgfOqSo2i1hQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.220.96.108]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/13/2019 8:01 AM, Janne Karhunen wrote:
> On Wed, Jun 12, 2019 at 7:33 PM Roberto Sassu <roberto.sassu@huawei.com> wrote:
> 
>>> That's a pretty big change for the userland IMHO. Quite a few
>>> configurations out there will break, including mine I believe, so I
>>> hope there is a solid reason asking people to change their stuff. I'm
>>> fine holding off all writing until it is safe to do so for now..
>>
>> The goal of appraisal is to allow access only to files with a valid
>> signature or HMAC. With the current behavior, that cannot be guaranteed.
>>
>> Unfortunately, dracut-state.sh is created very early. It could be
>> possible to unseal the key before, but this probably means modifying
>> systemd.
> 
> Ok, I see the use case. Now, if you pull a urandom key that early on
> during the boot, the state of the system entropy is at all time low,
> and you are not really protecting against any sort of offline attack
> since the file is created during that boot cycle. Is there really use
> for using such key? Wouldn't it be possible to create a new config
> option, say IMA_ALLOW_EARLY_WRITERS, that would hold the NEW_FILE flag
> until the persistent key becomes available? In other words, it would
> start the measuring at the point when the key becomes online?

I also thought about similar solutions. Another is for example to keep
the appraisal flags at file close, if security.ima is successfully
added to the file.

Initializing EVM with a key is not a trivial change, but it seemed
better to me as it does not introduce exceptions in the IMA behavior.

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
