Return-Path: <linux-integrity+bounces-2709-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC4E8D4465
	for <lists+linux-integrity@lfdr.de>; Thu, 30 May 2024 05:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DEB81C2224B
	for <lists+linux-integrity@lfdr.de>; Thu, 30 May 2024 03:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF940142E7D;
	Thu, 30 May 2024 03:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="poJOdBYy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6800F142E6F;
	Thu, 30 May 2024 03:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717041512; cv=none; b=OwFomr8HZpApEjdmWgTvPsJm+oxQeuslSJcMbdx9djHo/R+OUZmyZncq+1Av3e5mf7cpz2+NuUJj70vE74SH1gOKaMu4aEn5XMXnT/cHWaUiS4n3KSlPdtCeGAuk+kcEDl/DYOltd5hh23otxeQ53wzmmiGw0VIe+IL/kmghQKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717041512; c=relaxed/simple;
	bh=YluysAVk4ksN5vzzyKbt0ixss+ScRJr2e/SJs4bpgRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TOy/7Zr6jAonI1bv5M7IbbwEQk87N7Ry4ZYDdZ1cDrwJLMo0JG11dIIyYtb0Q2/tpQ0xaWfI4mcswolBhxjdolzXn2TR5In1WJP+MEwqPePAWq9omeAI37LuaFkv563jqXrHBvxZu1vVbmi9giA9kYyRejhVf7zm4JbeX0hUIeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=poJOdBYy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.106.151] (unknown [167.220.2.23])
	by linux.microsoft.com (Postfix) with ESMTPSA id B40492067D2D;
	Wed, 29 May 2024 20:58:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B40492067D2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1717041510;
	bh=+kiYt5jrL2wuHqmmVtYraxeKmaEo1PO1ifZIQfZR8kA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=poJOdBYyTG8TUNHTotK6WFRaggItlvdnO6TWJaiEwQDOjt+GU3RXoGZuO2NCnEV9H
	 ljVuxPAPkriX1zs1VlC3rcVXmkmP0OOJtB/FBiYWDGW/+sene5oFA3x9DksOIpg2ON
	 6dv9z7Guh6Wp5pBwYYE1zq/BGO9VT8qeBkQQLaJk=
Message-ID: <67da2ff3-e0c4-4552-93dd-cf9cb04d0d78@linux.microsoft.com>
Date: Wed, 29 May 2024 20:58:30 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 13/20] ipe: add support for dm-verity as a trust
 provider
To: Paul Moore <paul@paul-moore.com>, corbet@lwn.net, zohar@linux.ibm.com,
 jmorris@namei.org, serge@hallyn.com, tytso@mit.edu, ebiggers@kernel.org,
 axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
 eparis@redhat.com
Cc: linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org, fsverity@lists.linux.dev,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 audit@vger.kernel.org, linux-kernel@vger.kernel.org,
 Deven Bowers <deven.desai@linux.microsoft.com>
References: <1716583609-21790-14-git-send-email-wufan@linux.microsoft.com>
 <2ecde610ca3f0cabcbb111e3432f2dd5@paul-moore.com>
Content-Language: en-US
From: Fan Wu <wufan@linux.microsoft.com>
In-Reply-To: <2ecde610ca3f0cabcbb111e3432f2dd5@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/29/2024 6:44 PM, Paul Moore wrote:
> On May 24, 2024 Fan Wu <wufan@linux.microsoft.com> wrote:
>>
>> Allows author of IPE policy to indicate trust for a singular dm-verity
>> volume, identified by roothash, through "dmverity_roothash" and all
>> signed and validated dm-verity volumes, through "dmverity_signature".
>>
>> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
>> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
>> ---
>> v2:
>>    + No Changes
>>
>> v3:
>>    + No changes
>>
>> v4:
>>    + No changes
>>
>> v5:
>>    + No changes
>>
>> v6:
>>    + Fix an improper cleanup that can result in
>>      a leak
>>
>> v7:
>>    + Squash patch 08/12, 10/12 to [11/16]
>>
>> v8:
>>    + Undo squash of 08/12, 10/12 - separating drivers/md/ from security/
>>      & block/
>>    + Use common-audit function for dmverity_signature.
>>    + Change implementation for storing the dm-verity digest to use the
>>      newly introduced dm_verity_digest structure introduced in patch
>>      14/20.
>>
>> v9:
>>    + Adapt to the new parser
>>
>> v10:
>>    + Select the Kconfig when all dependencies are enabled
>>
>> v11:
>>    + No changes
>>
>> v12:
>>    + Refactor to use struct digest_info* instead of void*
>>    + Correct audit format
>>
>> v13:
>>    + Remove the CONFIG_IPE_PROP_DM_VERITY dependency inside the parser
>>      to make the policy grammar independent of the kernel config.
>>
>> v14:
>>    + No changes
>>
>> v15:
>>    + Fix one grammar issue in KCONFIG
>>    + Switch to use security_bdev_setintegrity() hook
>>
>> v16:
>>    + Refactor for enum integrity type
>>
>> v17:
>>    + Add years to license header
>>    + Fix code and documentation style issues
>>    + Return -EINVAL in ipe_bdev_setintegrity when passed type is not
>>      supported
>>    + Use new enum name LSM_INT_DMVERITY_SIG_VALID
>>
>> v18:
>>    + Add Kconfig IPE_PROP_DM_VERITY_SIGNATURE and make both DM_VERITY
>>      config auto-selected
>>
>> v19:
>>    + No changes
>> ---
>>   security/ipe/Kconfig         |  27 ++++++++
>>   security/ipe/Makefile        |   1 +
>>   security/ipe/audit.c         |  29 ++++++++-
>>   security/ipe/digest.c        | 118 +++++++++++++++++++++++++++++++++++
>>   security/ipe/digest.h        |  26 ++++++++
>>   security/ipe/eval.c          |  93 ++++++++++++++++++++++++++-
>>   security/ipe/eval.h          |  12 ++++
>>   security/ipe/hooks.c         |  93 +++++++++++++++++++++++++++
>>   security/ipe/hooks.h         |   8 +++
>>   security/ipe/ipe.c           |  15 +++++
>>   security/ipe/ipe.h           |   4 ++
>>   security/ipe/policy.h        |   3 +
>>   security/ipe/policy_parser.c |  24 ++++++-
>>   13 files changed, 449 insertions(+), 4 deletions(-)
>>   create mode 100644 security/ipe/digest.c
>>   create mode 100644 security/ipe/digest.h
> 
> ...
> 
>> diff --git a/security/ipe/hooks.c b/security/ipe/hooks.c
>> index b68719bf44fb..51f1e63c295c 100644
>> --- a/security/ipe/hooks.c
>> +++ b/security/ipe/hooks.c
>> @@ -191,3 +193,94 @@ void ipe_unpack_initramfs(void)
>>   {
>>   	ipe_sb(current->fs->root.mnt->mnt_sb)->initramfs = true;
>>   }
>> +
>> +#ifdef CONFIG_IPE_PROP_DM_VERITY
>> +/**
>> + * ipe_bdev_free_security() - Free IPE's LSM blob of block_devices.
>> + * @bdev: Supplies a pointer to a block_device that contains the structure
>> + *	  to free.
>> + */
>> +void ipe_bdev_free_security(struct block_device *bdev)
>> +{
>> +	struct ipe_bdev *blob = ipe_bdev(bdev);
>> +
>> +	ipe_digest_free(blob->root_hash);
>> +}
>> +
>> +#ifdef CONFIG_IPE_PROP_DM_VERITY_SIGNATURE
>> +static void ipe_set_dmverity_signature(struct ipe_bdev *blob,
>> +				       const void *value,
>> +				       size_t size)
>> +{
>> +	blob->dm_verity_signed = size > 0 && value;
>> +}
>> +#else
>> +static inline void ipe_set_dmverity_signature(struct ipe_bdev *blob,
>> +					      const void *value,
>> +					      size_t size)
>> +{
>> +}
>> +#endif /* CONFIG_IPE_PROP_DM_VERITY_SIGNATURE */
>> +
>> +/**
>> + * ipe_bdev_setintegrity() - Save integrity data from a bdev to IPE's LSM blob.
>> + * @bdev: Supplies a pointer to a block_device that contains the LSM blob.
>> + * @type: Supplies the integrity type.
>> + * @value: Supplies the value to store.
>> + * @size: The size of @value.
>> + *
>> + * This hook is currently used to save dm-verity's root hash or the existence
>> + * of a validated signed dm-verity root hash into LSM blob.
>> + *
>> + * Return: %0 on success. If an error occurs, the function will return the
>> + * -errno.
>> + */
>> +int ipe_bdev_setintegrity(struct block_device *bdev, enum lsm_integrity_type type,
>> +			  const void *value, size_t size)
>> +{
>> +	const struct dm_verity_digest *digest = NULL;
>> +	struct ipe_bdev *blob = ipe_bdev(bdev);
>> +	struct digest_info *info = NULL;
>> +
>> +	if (type == LSM_INT_DMVERITY_ROOTHASH) {
>> +		if (!value) {
>> +			ipe_digest_free(blob->root_hash);
>> +			blob->root_hash = NULL;
>> +
>> +			return 0;
>> +		}
>> +		digest = value;
>> +
>> +		info = kzalloc(sizeof(*info), GFP_KERNEL);
>> +		if (!info)
>> +			return -ENOMEM;
>> +
>> +		info->digest = kmemdup(digest->digest, digest->digest_len,
>> +				       GFP_KERNEL);
>> +		if (!info->digest)
>> +			goto dmv_roothash_err;
>> +
>> +		info->alg = kstrdup(digest->alg, GFP_KERNEL);
>> +		if (!info->alg)
>> +			goto dmv_roothash_err;
>> +
>> +		info->digest_len = digest->digest_len;
>> +
>> +		if (blob->root_hash)
>> +			ipe_digest_free(blob->root_hash);
> 
> The above if/free looks like a new addition from v18 and I'm not quite
> sure why the `blob->root_hash` NULL check is necessary as
> ipe_digest_free() does a IS_ERR_OR_NULL() check right at the top.
> 
> Likely harmless and doubtful to have any noticable performance impact,
> but I wanted to mention it just in case ...
> 

Yes directly call ipe_digest_free() should be enough.

Also this new free is introduced because the mapped device with an 
existing dm-verity target can be suspended and associated with a new 
dm-verity target. In this case, the root hash associated with the 
security blob will be stale and needs to be freed before setting the new 
data.

-Fan

>> +		blob->root_hash = info;
>> +
>> +		return 0;
>> +dmv_roothash_err:
>> +		ipe_digest_free(info);
>> +
>> +		return -ENOMEM;
>> +	} else if (type == LSM_INT_DMVERITY_SIG_VALID) {
>> +		ipe_set_dmverity_signature(blob, value, size);
>> +
>> +		return 0;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +#endif /* CONFIG_IPE_PROP_DM_VERITY */
> 
> --
> paul-moore.com

