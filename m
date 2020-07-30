Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3DD23368F
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jul 2020 18:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbgG3QT4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Jul 2020 12:19:56 -0400
Received: from sonic314-26.consmr.mail.ne1.yahoo.com ([66.163.189.152]:35681
        "EHLO sonic314-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726275AbgG3QTz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Jul 2020 12:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1596125994; bh=4DM0swhg6BYzktglxKAL6atFFcVuPuyqocAJ2jvegWs=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=fTghDs3CBeQY5BIJ/sg0DHLAaj7WRfMg0cFN2fJX/9+6L6uHyG7yzDgNW1smVxHJ16iXudXVTUlwX2AfQbwQeD8EI6jfF/1FxSXmDmxu6kW5sJoiMOv9ZGOOz8tvvpHgbI83plS2jR69SHwXk9G5MqPu8bPxjopREtIyI5HFNhInPduEZx2AV5e+5qEie3YtH9OUxM7WA03Z3GbSYu+MLYvxh6ER6NdO6VKnxkGfO7jDrshtoxbT2eZ900sJVNoCiueSP6GXTMLCaLIT/aE06v+EvMzCTK4msKH3YeMJDyASShEewiVwRSQ4LSh2YtlFW5TFzsRmzKOfEqpFxEeJcQ==
X-YMail-OSG: z8EZ56YVM1mbBvh2GM33p3jBokBkHN8L0OqgoxLeweL1ZyaaL_Y9uRYc61CrK8r
 9bziWEFFEawFUuYnLtXKSv4veeoNuiODsGO4_RWLsuozXQruwrbSn1narOdJiczkRN7Ataf1DWwP
 15nrGzwB7F4BQPKLHyWlohR7wdx20JkBqvKloGEADEbn2_5AYaEXP5MhvTbfmxUQSpPMP4fi4pix
 F4sCeNmy8ZSGufJ6lzRwuoLupGguaTO908xSe7_La364s27DdGillvIh48jL5dlhz4bKsFkkd9iX
 zk5GmJ4eP58KOcM6z.kCWfrTFTUoCiPm1_4rPJEsSMTMkNANFlPujGhZHFid8MJapWqzHkeixfsP
 rJThJd2VeUpNHATeg5lffJfuCa3cjY4FOmcDeQQrsP5RGdKt0MsXZRv2YHU.Tb5g_QBgyY9vQXvx
 DpHKB4B.8FGC2HsncTrFP0ee3zGLms.nd5l2.Ey821PTza7bk.T3MNVWifjSbcchcALLCDkq_Cwy
 n.Y0cSrR7LxJrnI.yQMiz8OgeqQnK302k0x8FMAdeiIz8MIzYtFsnhioPgUjk9g8FH5BCant1IW8
 CZgsvoZIXK8WN2RKl.s22aKELNX.O8YMjH45th2p4lQ7QUU39UiViOj8s2lhsZ7gvQhN2tX6rfpm
 VPry.vg9lA2UJU5fYAfT2ip1gV_og2dPXLDQmWR1UCjPMhxOk.qqp.efzkxfwaBQhMhEBtyne4c5
 Y21bpO12WMqRgz_FVKrmYVNilaSc4C9XB1BeuXGKE5alKTs0evcf4UvxhZzLHKxa8m7FJ0TXMd.s
 QabnWembXCYOFnmLNBwMIl1gM4wxu_oMfna3VeBWGlL8In8kMcyVSfKvK6wtQMoTL2BbEnIcvblu
 Qf8SEnEqIGgCkA7UlnSdUt6FC8s8HdLreWHQyL9jIo2qSd26RatXsfGEoxHcaZNbnW08slUX2i0t
 e9lWCXTCJpl8Tb8QtQIoIkheTh9r3YaKRGG6U9kqxVh1vawzXgq3RcPaGpVDS7EDd_knVdZccumH
 0B_81Yj8Ft1co6eKdZUEolNQK9COFxVfZB40WEXWAttlqGOrIoBWR9E9BxiShgpy_cbiKmvganYV
 hHpfPixFatKvK8vxjRP51o7m6OCZNNoxbGaIhWJUb5BXiwhivA43UxKNPi47sLtzy2B1KskCwNhZ
 ict59hRkNU8DznJBBHowqKBdaI2pEmdhSHerFS2jsE_vHqfkrt4OipHRruozXjEPygdCU_caubyF
 BKfzr6ZLceLywsOD7TUtZRn32UwmnvauFlDDeLxv0CpN8DFPaHVWEhtlP78ry8WH2d9FKhUA_eli
 JMlVF03iCiLntlqJb8OY.Pbhjo4o3DC9OEVT2IzoBmPO4H2nORtye7JNIXaOBI.h2ebFmbus.AeU
 Vd4B1wdc-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Thu, 30 Jul 2020 16:19:54 +0000
Received: by smtp414.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID d6f3bc80f8d81f4fde3bcbf52505d268;
          Thu, 30 Jul 2020 16:19:52 +0000 (UTC)
Subject: Re: [PATCH v5 1/4] IMA: Add func to measure LSM state and policy
To:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200730034724.3298-1-nramas@linux.microsoft.com>
 <20200730034724.3298-2-nramas@linux.microsoft.com>
 <20200730150228.GV4181@sequoia>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <b4428195-7a68-365d-a792-2855609c2221@schaufler-ca.com>
Date:   Thu, 30 Jul 2020 09:19:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730150228.GV4181@sequoia>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.16271 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/30/2020 8:02 AM, Tyler Hicks wrote:
> On 2020-07-29 20:47:21, Lakshmi Ramasubramanian wrote:
>> Critical data structures of security modules need to be measured to
>> enable an attestation service to verify if the configuration and
>> policies for the security modules have been setup correctly and
>> that they haven't been tampered with at runtime. A new IMA policy is
>> required for handling this measurement.
>>
>> Define two new IMA policy func namely LSM_STATE and LSM_POLICY to
>> measure the state and the policy provided by the security modules.

If, as you suggest below, this is SELinux specific,
these should be SELINUX_STATE and SELINUX_POLICY.
It makes me very uncomfortable when I see LSM used
in cases where SELinux is required. The LSM is supposed
to be an agnostic interface, so if you need to throw

	if (IS_ENABLED(CONFIG_SECURITY_SELINUX) &&

into the IMA code you're clearly not thinking in terms
of the LSM layer. I have no problem with seeing SELinux
oriented and/or specific code in IMA if that's what you want.
Just don't call it LSM.

>> Update ima_match_rules() and ima_validate_rule() to check for
>> the new func and ima_parse_rule() to handle the new func.
>>
>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>> ---
>>  Documentation/ABI/testing/ima_policy |  9 ++++++++
>>  security/integrity/ima/ima.h         |  2 ++
>>  security/integrity/ima/ima_api.c     |  2 +-
>>  security/integrity/ima/ima_policy.c  | 31 ++++++++++++++++++++++++----
>>  4 files changed, 39 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
>> index cd572912c593..b7c7fb548c0c 100644
>> --- a/Documentation/ABI/testing/ima_policy
>> +++ b/Documentation/ABI/testing/ima_policy
>> @@ -30,6 +30,7 @@ Description:
>>  				[FIRMWARE_CHECK]
>>  				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
>>  				[KEXEC_CMDLINE] [KEY_CHECK]
>> +				[LSM_STATE] [LSM_POLICY]
>>  			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
>>  			       [[^]MAY_EXEC]
>>  			fsmagic:= hex value
>> @@ -125,3 +126,11 @@ Description:
>>  		keys added to .builtin_trusted_keys or .ima keyring:
>>  
>>  			measure func=KEY_CHECK keyrings=.builtin_trusted_keys|.ima
>> +
>> +		Example of measure rule using LSM_STATE to measure LSM state:
>> +
>> +			measure func=LSM_STATE template=ima-buf
>> +
>> +		Example of measure rule using LSM_POLICY to measure LSM policy:
>> +
>> +			measure func=LSM_POLICY template=ima-ng
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index 38043074ce5e..1b5f4b2f17d0 100644
>> --- a/security/integrity/ima/ima.h
>> +++ b/security/integrity/ima/ima.h
>> @@ -200,6 +200,8 @@ static inline unsigned int ima_hash_key(u8 *digest)
>>  	hook(POLICY_CHECK, policy)			\
>>  	hook(KEXEC_CMDLINE, kexec_cmdline)		\
>>  	hook(KEY_CHECK, key)				\
>> +	hook(LSM_STATE, lsm_state)			\
>> +	hook(LSM_POLICY, lsm_policy)			\
>>  	hook(MAX_CHECK, none)
>>  
>>  #define __ima_hook_enumify(ENUM, str)	ENUM,
>> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
>> index 4f39fb93f278..8c8b4e4a6493 100644
>> --- a/security/integrity/ima/ima_api.c
>> +++ b/security/integrity/ima/ima_api.c
>> @@ -176,7 +176,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
>>   *		subj=, obj=, type=, func=, mask=, fsmagic=
>>   *	subj,obj, and type: are LSM specific.
>>   *	func: FILE_CHECK | BPRM_CHECK | CREDS_CHECK | MMAP_CHECK | MODULE_CHECK
>> - *	| KEXEC_CMDLINE | KEY_CHECK
>> + *	| KEXEC_CMDLINE | KEY_CHECK | LSM_STATE | LSM_POLICY
>>   *	mask: contains the permission mask
>>   *	fsmagic: hex value
>>   *
>> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
>> index 07f033634b27..a0f5c39d9084 100644
>> --- a/security/integrity/ima/ima_policy.c
>> +++ b/security/integrity/ima/ima_policy.c
>> @@ -442,13 +442,20 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>>  {
>>  	int i;
>>  
>> -	if (func == KEY_CHECK) {
>> -		return (rule->flags & IMA_FUNC) && (rule->func == func) &&
>> -		       ima_match_keyring(rule, keyring, cred);
>> -	}
>>  	if ((rule->flags & IMA_FUNC) &&
>>  	    (rule->func != func && func != POST_SETATTR))
>>  		return false;
>> +
>> +	switch (func) {
>> +	case KEY_CHECK:
>> +		return ima_match_keyring(rule, keyring, cred);
>> +	case LSM_STATE:
>> +	case LSM_POLICY:
>> +		return true;
>> +	default:
>> +		break;
>> +	}
>> +
>>  	if ((rule->flags & IMA_MASK) &&
>>  	    (rule->mask != mask && func != POST_SETATTR))
>>  		return false;
>> @@ -1044,6 +1051,18 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
>>  		if (ima_rule_contains_lsm_cond(entry))
>>  			return false;
>>  
>> +		break;
>> +	case LSM_STATE:
>> +	case LSM_POLICY:
>> +		if (entry->action & ~(MEASURE | DONT_MEASURE))
>> +			return false;
>> +
>> +		if (entry->flags & ~(IMA_FUNC | IMA_PCR))
>> +			return false;
>> +
>> +		if (ima_rule_contains_lsm_cond(entry))
>> +			return false;
>> +
>>  		break;
>>  	default:
>>  		return false;
>> @@ -1176,6 +1195,10 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>>  				entry->func = KEXEC_CMDLINE;
>>  			else if (strcmp(args[0].from, "KEY_CHECK") == 0)
>>  				entry->func = KEY_CHECK;
>> +			else if (strcmp(args[0].from, "LSM_STATE") == 0)
>> +				entry->func = LSM_STATE;
>> +			else if (strcmp(args[0].from, "LSM_POLICY") == 0)
>> +				entry->func = LSM_POLICY;
> This patch generally looks really good to me with the exception of one
> thing...
>
> We should only accept rules with these specified hook functions when an
> LSM that has measurement support is enabled. This messes up the ordering
> of your patch series but it could be as simple as doing this:
>
> 			else if (IS_ENABLED(CONFIG_SECURITY_SELINUX) &&
> 				 strcmp(args[0].from, "LSM_STATE") == 0)
> 				 entry->func = LSM_STATE;
>
> Or you could do something a little more complex, like what's done with
> CONFIG_IMA_LSM_RULES. You could create a CONFIG_IMA_MEASURE_LSM option
> that's default enabled but depends on CONFIG_SECURITY_SELINUX and then
> check for IS_ENABLED(CONFIG_IMA_MEASURE_LSM) in ima_parse_rule().
>
> I'd personally opt for just placing the
> IS_ENABLED(CONFIG_SECURITY_SELINUX) check directly into
> ima_parse_rule().
>
> Tyler
>
>>  			else
>>  				result = -EINVAL;
>>  			if (!result)
>> -- 
>> 2.27.0
