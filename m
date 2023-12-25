Return-Path: <linux-integrity+bounces-564-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAA181E0B5
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Dec 2023 14:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71EF51C21B24
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Dec 2023 13:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEA056468;
	Mon, 25 Dec 2023 13:00:24 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFE656462
	for <linux-integrity@vger.kernel.org>; Mon, 25 Dec 2023 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SzJ075Zb0zMpBK;
	Mon, 25 Dec 2023 20:59:51 +0800 (CST)
Received: from dggpemm500024.china.huawei.com (unknown [7.185.36.203])
	by mail.maildlp.com (Postfix) with ESMTPS id 56208180069;
	Mon, 25 Dec 2023 21:00:12 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Dec 2023 21:00:12 +0800
Message-ID: <46e0fd93-86f6-bdf9-99d4-1ccf83f88afe@huawei.com>
Date: Mon, 25 Dec 2023 21:00:11 +0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] ima: add crypto agility support for template-hash
 algorithm
To: Mimi Zohar <zohar@linux.ibm.com>, Enrico Bravi <enrico.bravi@polito.it>,
	<linux-integrity@vger.kernel.org>, <roberto.sassu@huawei.com>
CC: Silvia Sisinni <silvia.sisinni@polito.it>
References: <20231214145152.36985-1-enrico.bravi@polito.it>
 <8bf7eaf170cf609fb4280475d3340179283fd196.camel@linux.ibm.com>
 <a27cd216-ab70-46a1-8c2c-4640728c99b2@polito.it>
 <89cea05a61ac4616774446683bf612165ba2f43c.camel@linux.ibm.com>
Content-Language: en-US
From: "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <89cea05a61ac4616774446683bf612165ba2f43c.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500024.china.huawei.com (7.185.36.203)

On 2023/12/22 6:05, Mimi Zohar wrote:
> On Thu, 2023-12-21 at 15:38 +0100, Enrico Bravi wrote:
>> Hi Mimi,
>>
>> thank you for your feedback.
>>
>> On 19/12/23 21:54, Mimi Zohar wrote:
>>> Hi Enrico,
>>>
>>> On Thu, 2023-12-14 at 15:51 +0100, Enrico Bravi wrote:
>>>> The purpose of this patch is to add the possibility to configure the hash
>>>> algorithm to use when calculating the template-hash.
>>>
>>> The patch description should be written in the imperative mood.  For an
>>> explanation, please refer to "Describe your changes" in
>>> Documentation/process/submitting-patches.rst.>
>>> For example:
>>>
>>> The second field of the IMA measurement list, the template data hash,
>>> contains a fixed sized SHA1 digest.  Add support to replace the SHA1
>>> digest with other hash algorithms.  For backwards compatability, only
>>> the new larger digests will be prefixed with ...
>>>
>>>> The ima_template_hash command line parameter has been introduced to enable
>>>> this configuration.
>>>
>>> The term "ima_template_hash" could be misconstrued to refer to the hash
>>> algorithm used to calculate the file digest.  To differentiate between
>>> the hash algorithm used to calculate the file digest, the term
>>> 'ima_template_data_hash' is longer, but I think clearer.
>>
>> Yes you're right, this name is ambiguous.
>>
>>>> The entry will contain the hash_algo_name before the actual template-hash,
>>>> separated by a colon (:).
>>>
>>> This chnage will break existing userspace applications, unless the SHA1
>>> digest isn't prefixed.
>>
>> Yes, in the current patch, this value is present even in the case of SHA1. We
>> can modifying the patch by omitting it in the case of SHA1; as an alternative,
>> the addition of the hash algorithm information can be made configurable in the
>> ima log to maintain backward compatibility with existing applications.
> 
> After thinking about this some more, I realized that we didn't discuss
> carrying the measurement list across kexec.   How will the kexec'ed
> kernel be able to differentiate between the original and new
> measurement list?   Neither the Kconfig nor making SHA1 backwards
> compatible address this.   How will attestation servers be able to
> differentiate between the two logs?
> 
> Obviously the new measurement list with larger digests won't be
> backwards compatible. Can we support carrying the original measurement
> list across kexec to a new kernel?
> 
> As long we're making changes to the IMA measurement list, we should
> mention that we could include multiple digests, but I don't think it is
> necessary.
> 
>>>> An example of the resulting ima log is the following:
>>>>
>>>> 10 sha256:64326[...]25313 ima-ng sha1:5fc9b[...]974e6 boot_aggregate
>>>> 10 sha256:afd64[...]e3123 ima-ng sha1:5a493[...]f9566 /init
>>>> 10 sha256:99329[...]a6353 ima-ng sha1:8c87d[...]3d8c7 /usr/bin/sh
>>>> 10 sha256:a16ad[...]2ac0e ima-ng sha1:59d4b[...]330b0 /etc/ld.so.cache
> 
> The template DATA_FMT_DIGEST_WITH_ALGO field is a composite field
> defined as <hash algo> + ':' + '\0' + digest.   The above ascii display
> looks like the template composite field, but isn't.  It is two separate
> fields.  Perhaps it should look differently as well.   Consider instead
> of a string use the hash_algo value (include/uapi/linux/hash_info.h).
> 
> binary measurement log:  <pcr> <hash_algo> <digest_len> <digest>
> 
Hi Mimi and Enrico,

As we are extending all supported algorithms of a PCR bank, does
algorithm of template-hash still matters?

-- 
Best
GUO Zihua


