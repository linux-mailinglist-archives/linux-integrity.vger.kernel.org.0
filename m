Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3011728D220
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Oct 2020 18:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389691AbgJMQXx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Oct 2020 12:23:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58179 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389679AbgJMQXw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Oct 2020 12:23:52 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kSN5Y-0007Jb-4T; Tue, 13 Oct 2020 16:23:48 +0000
Subject: Re: [PATCH] ima: Fix sizeof mismatches
To:     Mimi Zohar <zohar@linux.ibm.com>, Joe Perches <joe@perches.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Roberto Sassu <roberto.sassu@polito.it>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201007110243.19033-1-colin.king@canonical.com>
 <55ae0b6152c84013d483b1bbecb28a425801c408.camel@perches.com>
 <a9a35d8b480112fe40b45392d0f0e9dcb5be536e.camel@linux.ibm.com>
 <ea06c7431075c57d274a9076077f28fd2c7634a5.camel@perches.com>
 <0ceb198a-a313-f542-49cc-c0b9f6b1ea52@canonical.com>
 <ba5f4d90c714eba5d5a1d822bca25305b40a73e1.camel@linux.ibm.com>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <047842e3-da9d-2dc5-6fa8-60cf6e9fe92d@canonical.com>
Date:   Tue, 13 Oct 2020 17:23:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <ba5f4d90c714eba5d5a1d822bca25305b40a73e1.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 13/10/2020 17:17, Mimi Zohar wrote:
> On Mon, 2020-10-12 at 19:10 +0100, Colin Ian King wrote:
>> On 12/10/2020 19:06, Joe Perches wrote:
>>> On Mon, 2020-10-12 at 13:51 -0400, Mimi Zohar wrote:
>>>> On Wed, 2020-10-07 at 11:27 -0700, Joe Perches wrote:
>>>>> On Wed, 2020-10-07 at 12:02 +0100, Colin King wrote:
>>>>>> An incorrect sizeof is being used, sizeof(*fields) is not correct,
>>>>>> it should be sizeof(**fields). This is not causing a problem since
>>>>>> the size of these is the same. Fix this in the kmalloc_array and
>>>>>> memcpy calls.
>>>>> []
>>>>>> diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
>>>>> []
>>>>>> @@ -216,11 +216,11 @@ int template_desc_init_fields(const char *template_fmt,
>>>>>>  	}
>>>>>>  
>>>>>>  	if (fields && num_fields) {
>>>>>> -		*fields = kmalloc_array(i, sizeof(*fields), GFP_KERNEL);
>>>>>> +		*fields = kmalloc_array(i, sizeof(**fields), GFP_KERNEL);
>>>>>>  		if (*fields == NULL)
>>>>>>  			return -ENOMEM;
>>>>>>  
>>>>>> -		memcpy(*fields, found_fields, i * sizeof(*fields));
>>>>>> +		memcpy(*fields, found_fields, i * sizeof(**fields));
>>>>>
>>>>> Maybe use kmemdup instead.
>>>>>
>>>>> 	if (fields && num_fields) {
>>>>> 		*fields = kmemdup(found_fields, i * sizeof(**fields), GFP_KERNEL);
>>>>> 		etc...
>>>>>
>>>>
>>>> Thanks, Joe.  Since this patch will be backported, perhaps it would be
>>>> better to leave this as a bug fix and upstream other changes
>>>> independently.
>>>
>>> IMO:
>>>
>>> This patch doesn't need need backporting as it doesn't
>>> actually fix anything other than a style defect.
>>>
>>> void * and void ** are the same size.
>>
>> indeed, same size, it's a semantic difference *and* a style fix :-)
> 
> Colin, based on Joe's suggestion of using kmemdup and his opinion of
> not backporting this change, can I assume you'll address his comments
> and re-post v3?

Oops, I missed that email. Yep, I'll address that later today

Colin
> 
> thanks,
> 
> Mimi
> 

