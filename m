Return-Path: <linux-integrity+bounces-6284-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AA8ABFB28
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 18:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68FCC7AB6C7
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 16:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C487622ACFA;
	Wed, 21 May 2025 16:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nightmared.fr header.i=@nightmared.fr header.b="h7C46KEN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.nightmared.fr (mail.nightmared.fr [51.158.148.24])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A591E3769;
	Wed, 21 May 2025 16:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.158.148.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747844782; cv=none; b=as8wIMwrWoupKRXYim8Bqj3B5VaKsB+H9UzbrKjHfUza3ALL6FB2JomjLUH3DhbFFUQrKgU07IqftysuEOOG2Wenrj2rmrwy6AEGqdEvybMlCkQhj8W8veT4njh4axgJqAY93/M95ZZ7p/FjjwhBXCMukvzksOcIs7gE71RxGnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747844782; c=relaxed/simple;
	bh=PqT176MmKYNLApCcwpSG5VfJS+AddGWN+l+us2/DPn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EnRaLUBfzxZsgqr49u0yhzMnnR5Us0srRoxtWQ79iDPOm8UeNLmml0bTfqI3VgHy1vQ3kgq6L6Ypnbv0T/arn+xddyznUXQGDgAiQ2iQUizhw1ndcDTG+GyPv9kBAWiz/NPs5er4I0B0fk4EVzY/NUnGI7ZMk3CKfCHz3XQHh9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nightmared.fr; spf=pass smtp.mailfrom=nightmared.fr; dkim=pass (2048-bit key) header.d=nightmared.fr header.i=@nightmared.fr header.b=h7C46KEN; arc=none smtp.client-ip=51.158.148.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nightmared.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nightmared.fr
Received: from [10.5.1.10] (atoulon-651-1-170-218.w83-113.abo.wanadoo.fr [83.113.65.218])
	by mail.nightmared.fr (Postfix) with ESMTPSA id 65F941087928;
	Wed, 21 May 2025 16:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nightmared.fr;
	s=docker; t=1747844774;
	bh=PqT176MmKYNLApCcwpSG5VfJS+AddGWN+l+us2/DPn8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=h7C46KENSeU4UrxpdlVeggM2GDMXRB1Iau/08z1hxCePBGPVOzOuOaAgMGHnRhsEZ
	 bXAHbl5mFREG4+5nA7aslG44yVaZ1YqFDiUlD9XfJxxh2HkCtoeY1TXhrm9GPkME84
	 Ux/0S6ZMCXDJNiSeSC1f6BKMgR8mHvKQF/Az2N6TzWZudYdwu0x85PHraL3tWfLopT
	 q3gjXip434pdvy7mRfpUi2gfSIR5ZIo5Yc3WI5JwfS7EAIFUhPEdBii0ZfTkvuRXDU
	 qkBNxa92a6RFO+ugh0PfnNQzsu9rQRXSpX3HZRxtX+YLySGNIqNy6+jDG796ZQo6sl
	 088sH54IHEhUQ==
Message-ID: <c15c3e03-37b5-4fdf-b9df-0ce23a33d4fb@nightmared.fr>
Date: Wed, 21 May 2025 18:26:13 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/9] Loadpol LSM: filter kernel module request
 according to the policy
To: Casey Schaufler <casey@schaufler-ca.com>,
 linux-security-module@vger.kernel.org
Cc: linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250521140121.591482-1-git@nightmared.fr>
 <20250521140121.591482-4-git@nightmared.fr>
 <518c8bdd-4f73-4b8b-bdb9-be3294723c99@schaufler-ca.com>
Content-Language: en-US
From: Simon Thoby <git@nightmared.fr>
In-Reply-To: <518c8bdd-4f73-4b8b-bdb9-be3294723c99@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/21/25 17:47, Casey Schaufler wrote:
> On 5/21/2025 7:01 AM, Simon THOBY wrote:
>> When a kernel module is loaded, the LSM accepts or rejects the demand
>> according to its policy.
>>
>> Signed-off-by: Simon THOBY <git@nightmared.fr>
>> ---
>>  security/loadpol/Makefile         |  2 +-
>>  security/loadpol/loadpol.c        | 22 ++++++++++++
>>  security/loadpol/loadpol.h        | 27 ++++++++++++++
>>  security/loadpol/loadpol_policy.c | 59 +++++++++++++++++++++++++++++++
>>  4 files changed, 109 insertions(+), 1 deletion(-)
>>  create mode 100644 security/loadpol/loadpol_policy.c
>>
>> diff --git a/security/loadpol/Makefile b/security/loadpol/Makefile
>> index a794c8cfbfee..062215e1f831 100644
>> --- a/security/loadpol/Makefile
>> +++ b/security/loadpol/Makefile
>> @@ -1 +1 @@
>> -obj-$(CONFIG_SECURITY_LOADPOL) := loadpol.o
>> +obj-$(CONFIG_SECURITY_LOADPOL) := loadpol.o loadpol_policy.o
>> diff --git a/security/loadpol/loadpol.c b/security/loadpol/loadpol.c
>> index 3fc29263e2f8..4d1a495a1462 100644
>> --- a/security/loadpol/loadpol.c
>> +++ b/security/loadpol/loadpol.c
>> @@ -6,6 +6,15 @@
>>  
>>  #include "loadpol.h"
>>  
>> +// default policy: allow all modules
>> +static struct loadpol_policy_entry default_policy_entries[] __ro_after_init = {
>> +	{
>> +		.origin = (ORIGIN_KERNEL | ORIGIN_USERSPACE),
>> +		.action = ACTION_ALLOW,
>> +		.module_name = NULL,
>> +	},
>> +};
>> +
>>  static int __init loadpol_init(void);
>>  
>>  static const struct lsm_id loadpol_lsmid = {
>> @@ -14,6 +23,7 @@ static const struct lsm_id loadpol_lsmid = {
>>  };
>>  
>>  static struct security_hook_list loadpol_hooks[] __ro_after_init = {
>> +	LSM_HOOK_INIT(kernel_module_load, loadpol_kernel_module_load),
>>  };
>>  
>>  DEFINE_LSM(LOADPOL_NAME) = {
>> @@ -23,6 +33,18 @@ DEFINE_LSM(LOADPOL_NAME) = {
>>  
>>  static int __init loadpol_init(void)
>>  {
>> +	for (int i = 0; i < ARRAY_SIZE(default_policy_entries); i++) {
>> +		struct loadpol_policy_entry *entry = kmemdup(
>> +			&default_policy_entries[i],
>> +			sizeof(struct loadpol_policy_entry),
>> +			GFP_KERNEL
>> +		);
>> +		if (!entry)
>> +			return -ENOMEM;
>> +
>> +		list_add_tail(&entry->list, loadpol_policy);
>> +	}
>> +
>>  	security_add_hooks(loadpol_hooks, ARRAY_SIZE(loadpol_hooks), &loadpol_lsmid);
>>  	pr_info("Loadpol started.\n");
>>  	return 0;
>> diff --git a/security/loadpol/loadpol.h b/security/loadpol/loadpol.h
>> index 5e11474191f0..a81d52f6d4da 100644
>> --- a/security/loadpol/loadpol.h
>> +++ b/security/loadpol/loadpol.h
>> @@ -3,6 +3,33 @@
>>  #ifndef _SECURITY_LOADPOL_LOADPOL_H
>>  #define _SECURITY_LOADPOL_LOADPOL_H
>>  
>> +#include "linux/list.h"
>> +
>>  #define LOADPOL_NAME "loadpol"
>>  
>> +enum policy_entry_origin {
>> +	ORIGIN_KERNEL = 1 << 0,
>> +	ORIGIN_USERSPACE = 1 << 1,
>> +};
>> +
>> +enum __packed policy_entry_action {
>> +	ACTION_UNDEFINED,
>> +	ACTION_ALLOW,
>> +	ACTION_DENY
>> +};
>> +
>> +struct loadpol_policy_entry {
>> +	struct list_head list;
>> +	// bitfield of policy_entry_origin
> 
> The // comment style is not used in the kernel.
> 

Whoops, I had originally started with '//' comments before realizing the kernel comment
policy tends towards /* */ pairs, but looks like I haven't fixed all the '//' insertions I made.

Good catch!

<snip>


