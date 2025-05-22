Return-Path: <linux-integrity+bounces-6295-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F69AC0802
	for <lists+linux-integrity@lfdr.de>; Thu, 22 May 2025 10:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 288391BC5160
	for <lists+linux-integrity@lfdr.de>; Thu, 22 May 2025 08:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE2628751B;
	Thu, 22 May 2025 08:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nightmared.fr header.i=@nightmared.fr header.b="VSitrMbB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.nightmared.fr (mail.nightmared.fr [51.158.148.24])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C907B27C869;
	Thu, 22 May 2025 08:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.158.148.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747904245; cv=none; b=caYe0Ue5mYyD5MBKeS1kZXftKOs71m8skGELY9ruYW0viHKIsdly1GU4NBs1ChQ2ndOFotrmYutnDw1OcnHkSV5jFqvBmhNAMDFiZAuVeOWVCpOHldyYCYw+NKpPnsmtnNc4JoWuHLDEvFl5t6/6hTsoBS5PfDBGkOxVy4O5jmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747904245; c=relaxed/simple;
	bh=brniH7v+gBzA6HHT54dvM9BL5QJ1ugLgjVvnfc0BXPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iixq+QkybybgNODZumgalsVobi28t/lVObVwYqsWuH3l5/s5o4oMB9HJ3Xls/RcXwu474kqgG8kiG/0ZxRBWUg8Birx0mpEFVt3ECO3pT7MSJoT6fpUUIeVRkvEHZ4oejD7mQfQldtqKlD9Cs3IZK/SgxChShzxW8r1+VJRuQao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nightmared.fr; spf=pass smtp.mailfrom=nightmared.fr; dkim=pass (2048-bit key) header.d=nightmared.fr header.i=@nightmared.fr header.b=VSitrMbB; arc=none smtp.client-ip=51.158.148.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nightmared.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nightmared.fr
Received: from [10.5.1.10] (atoulon-651-1-170-218.w83-113.abo.wanadoo.fr [83.113.65.218])
	by mail.nightmared.fr (Postfix) with ESMTPSA id DF5AA1085270;
	Thu, 22 May 2025 08:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nightmared.fr;
	s=docker; t=1747904239;
	bh=brniH7v+gBzA6HHT54dvM9BL5QJ1ugLgjVvnfc0BXPQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VSitrMbBYMgwuDW6QfnwldB4YRoStylRSII/Rc2hgKXik82GAvZacpAIa1kS6OW6x
	 rxWmaxeHNb4C9q39Ac0gthXq4N/9X2U/ACTMAvoxg12QnXxqjcO5crTwCEPn0GeMSj
	 p/7qT3Iq7wjQEBupg5TQZL7bfgL3KZIhqJUnn1Jq+o0rG9upkyJMKuESoRlHyRoFLr
	 ATK8mR4WF35F2Z1Fd6E9UQyv/qjp1F1MoXgVKwrn642akmfZ9nyjQqo6RYlNrJpfsH
	 AGB3RTi7ps/6ce4OPcluwlAMfYb5RzWGcUt3xJ4AI2eYofWQnXDM1zSSXNAnqczLkw
	 50YwmzPD8yi4A==
Message-ID: <784fa662-9104-4d8a-9b68-7edc90a8affe@nightmared.fr>
Date: Thu, 22 May 2025 10:57:18 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/9] LSM: Introduce a new hook:
 security_kernel_module_load
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20250521140121.591482-1-git@nightmared.fr>
 <20250521140121.591482-2-git@nightmared.fr>
 <20250521220349.GA22189@mail.hallyn.com>
Content-Language: en-US
From: Simon Thoby <git@nightmared.fr>
In-Reply-To: <20250521220349.GA22189@mail.hallyn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/22/25 00:03, Serge E. Hallyn wrote:
> On Wed, May 21, 2025 at 04:01:05PM +0200, Simon THOBY wrote:
>> Introduce a new hook to allow LSMs to decide whether to block the load
>> of a kernel module.
>>
>> Two hooks already exist:
>> - kernel_module_request is called when the kernel itself (not userspace)
>>  request the load of a module, e.g. because a device was detected.
>>  - security_kernel_load_data(LOADING_MODULE) is called when userspace calls
>>  init_module/finit_module, but lack information about the module because
>>  its  headers have not been loaded into kernel space, let alone parsed.
>>  This may not be sufficient for some LSMs.
>>
>> This new hook is similar to security_kernel_load_data(LOADING_MODULE),
>> but called after the module signature and header are verified, and only
>> takes the module name for now.
>>
>> Signed-off-by: Simon THOBY <git@nightmared.fr>
>> ---
>>  include/linux/lsm_hook_defs.h |  1 +
>>  include/linux/module.h        |  1 +
>>  include/linux/security.h      |  6 ++++++
>>  kernel/module/main.c          |  4 ++++
>>  security/security.c           | 14 ++++++++++++++
>>  5 files changed, 26 insertions(+)
>>
>> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
>> index bf3bbac4e02a..51c5212d8bb6 100644
>> --- a/include/linux/lsm_hook_defs.h
>> +++ b/include/linux/lsm_hook_defs.h
>> @@ -223,6 +223,7 @@ LSM_HOOK(void, LSM_RET_VOID, cred_getlsmprop, const struct cred *c,
>>  LSM_HOOK(int, 0, kernel_act_as, struct cred *new, u32 secid)
>>  LSM_HOOK(int, 0, kernel_create_files_as, struct cred *new, struct inode *inode)
>>  LSM_HOOK(int, 0, kernel_module_request, char *kmod_name)
>> +LSM_HOOK(int, 0, kernel_module_load, const char *kmod_name)
>>  LSM_HOOK(int, 0, kernel_load_data, enum kernel_load_data_id id, bool contents)
>>  LSM_HOOK(int, 0, kernel_post_load_data, char *buf, loff_t size,
>>  	 enum kernel_load_data_id id, char *description)
>> diff --git a/include/linux/module.h b/include/linux/module.h
>> index 8050f77c3b64..b6b8d6f7f599 100644
>> --- a/include/linux/module.h
>> +++ b/include/linux/module.h
>> @@ -39,6 +39,7 @@ struct modversion_info {
>>  	char name[MODULE_NAME_LEN];
>>  };
>>  
>> +struct load_info;
>>  struct module;
>>  struct exception_table_entry;
>>  
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index cc9b54d95d22..e175b2cc8caf 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -498,6 +498,7 @@ void security_cred_getlsmprop(const struct cred *c, struct lsm_prop *prop);
>>  int security_kernel_act_as(struct cred *new, u32 secid);
>>  int security_kernel_create_files_as(struct cred *new, struct inode *inode);
>>  int security_kernel_module_request(char *kmod_name);
>> +int security_kernel_module_load(const char *kmod_name);
>>  int security_kernel_load_data(enum kernel_load_data_id id, bool contents);
>>  int security_kernel_post_load_data(char *buf, loff_t size,
>>  				   enum kernel_load_data_id id,
>> @@ -1255,6 +1256,11 @@ static inline int security_kernel_module_request(char *kmod_name)
>>  	return 0;
>>  }
>>  
>> +static inline int security_kernel_module_load(const char *kmod_name)
>> +{
>> +	return 0;
>> +}
>> +
>>  static inline int security_kernel_load_data(enum kernel_load_data_id id, bool contents)
>>  {
>>  	return 0;
>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>> index a2859dc3eea6..12a1a5f4d823 100644
>> --- a/kernel/module/main.c
>> +++ b/kernel/module/main.c
>> @@ -3228,6 +3228,10 @@ static int early_mod_check(struct load_info *info, int flags)
>>  		return -EPERM;
>>  	}
>>  
>> +	err = security_kernel_module_load(info->name);
> 
> Would it be more useful to pass in the whole info struct?
> 

I thought about that, but was afraid the LSM hook is still called very early in
the boot process. I though the 'struct load_info' was only partially populated,
but upon further checking, you're right, and most fields of the structure were
already setup by the time the hook is called:
- len, hdr in the copy_module_from_user function
- sig_ok in module_sig_check
- sechdrs, secstrings, index, strtab and name in elf_validity_cache_copy

So I could definitely pass in the info struct instead.

On that note, I wonder if I should move 'struct load_info' out of kernel/module/internal.h,
because I'm fairly certain we don't want to have linux/security.h depending on an internal
header file from the module subsystem.

<snip>


