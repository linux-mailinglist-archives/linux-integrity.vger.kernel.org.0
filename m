Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 611BB23799
	for <lists+linux-integrity@lfdr.de>; Mon, 20 May 2019 15:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388320AbfETMwY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 May 2019 08:52:24 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32957 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387725AbfETMSs (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 May 2019 08:18:48 -0400
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 48F69DF4E0C69AB1F29D;
        Mon, 20 May 2019 13:18:47 +0100 (IST)
Received: from [10.220.96.108] (10.220.96.108) by smtpsuk.huawei.com
 (10.201.108.37) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 20 May
 2019 13:18:45 +0100
Subject: Re: [PATCH 2/3 v5] add a new template field buf to contain the buffer
To:     prakhar srivastava <prsriva02@gmail.com>
CC:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mimi Zohar" <zohar@linux.ibm.com>, <ebiederm@xmission.com>,
        <vgoyal@redhat.com>, Prakhar Srivastava <prsriva@microsoft.com>
References: <20190510223744.10154-1-prsriva02@gmail.com>
 <20190510223744.10154-3-prsriva02@gmail.com>
 <45344b2f-d9ea-f7df-e45f-18037e2ba5ca@huawei.com>
 <CAEFn8qJVvNivP6Lmx+nVewPcHjH=V2OrR_HyHR6nOeuVQW0A4w@mail.gmail.com>
 <ec8ee6f7-3a1d-6498-e009-f85e677b448a@huawei.com>
 <CAEFn8qKgH5FMLaudqTH6W0k7NpSoWV_NHbmiVduaQPbUNF_4Lg@mail.gmail.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <50235394-58da-18a6-c149-c385efa080cc@huawei.com>
Date:   Mon, 20 May 2019 14:18:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAEFn8qKgH5FMLaudqTH6W0k7NpSoWV_NHbmiVduaQPbUNF_4Lg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.220.96.108]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 5/18/2019 1:32 AM, prakhar srivastava wrote:
> On Tue, May 14, 2019 at 6:22 AM Roberto Sassu <roberto.sassu@huawei.com> wrote:
>>
>> On 5/14/2019 7:07 AM, prakhar srivastava wrote:
>>> On Mon, May 13, 2019 at 6:48 AM Roberto Sassu <roberto.sassu@huawei.com> wrote:
>>>>
>>>> On 5/11/2019 12:37 AM, Prakhar Srivastava wrote:
>>>>> From: Prakhar Srivastava <prsriva02@gmail.com>
>>>>>
>>>>> The buffer(cmdline args) added to the ima log cannot be attested
>>>>> without having the actual buffer. Thus to make the measured buffer
>>>>> available to store/read a new ima template (buf) is added.
>>>>
>>>> Hi Prakhar
>>>>
>>>> please fix the typos. More comments below.
>>>>
>>>>
>>>>> +     buffer_event_data->type = IMA_XATTR_BUFFER;
>>>>> +     buffer_event_data->buf_length = size;
>>>>> +     memcpy(buffer_event_data->buf, buf, size);
>>>>> +
>>>>> +     event_data.xattr_value = (struct evm_ima_xattr_data *)buffer_event_data;
>>>>> +     event_data.xattr_len = alloc_length;
>>>>
>>>> I would prefer that you introduce two new fields in the ima_event_data
>>>> structure. You can initialize them directly with the parameters of
>>>> process_buffer_measurement().
>>> I will make the edits, this will definitely save the kzalloc in this code
>>> path.
>>>>
>>>> ima_write_template_field_data() will make
>>>> a copy.
>>>>
>>> Since event_data->type is used to distinguish what the template field
>>>    should contain.
>>> Removing the type and subsequent check in the template_init,
>>>    buf template fmt will result in the whole event_Data structure
>>> being added to the log, which is not the expected output.
>>> For buffer entries, the buf template fmt will contains the buffer itself.
> 
>>
>> The purpose of ima_event_data is to pass data to the init method of
>> template fields. Each method takes the data it needs.
>>
>> If you pass event_data->buf and event_data->buf_len to
>> ima_write_template_field_data() this should be fine.
> 
> Hi Roberto,
> I did some testing after making the needed code changes,
> the output is as expected the buf template field only contains
> the buf when the ima_event_data.buf is set.
> 
> However i just want to double check if adding two new fields to
> the struct ima_event_data is approach you want me to take?
> Mimi any concerns?

I think it should not be a problem. ima_event_data was introduced to
pass more information to a function for a new template field, without
changing the definition of existing functions.


> what all tests do i need to run to confirm i am not
> in-inadvertently breaking some thing else?

ima_event_data is not used for marshaling/unmarshaling. Adding two new
members to the structure won't change the behavior of existing code.

Roberto


> Thanks,
> Prakhar Srivastava
>>
>> Roberto
>>
>>
>>>>> +      .field_show = ima_show_template_buf},
>>>>
>>>> Please update Documentation/security/IMA-templates.rst
>>> Will update the documentation.
>>>
>>> Thanks,
>>> Prakhar Srivastava
>>>>
>>>> Thanks
>>>>
>>>> Roberto
>>
>> --
>> HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
>> Managing Director: Bo PENG, Jian LI, Yanli SHI

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
