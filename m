Return-Path: <linux-integrity+bounces-9150-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GzyGd711mkUKQgAu9opvQ
	(envelope-from <linux-integrity+bounces-9150-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 09 Apr 2026 02:42:06 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 050163C5128
	for <lists+linux-integrity@lfdr.de>; Thu, 09 Apr 2026 02:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31CFC302C5CC
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Apr 2026 00:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D07013D539;
	Thu,  9 Apr 2026 00:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rdk4EEpr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1FD1B4257;
	Thu,  9 Apr 2026 00:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775695307; cv=none; b=R7ttcpPn81eH0rmSMi+VIXjeuL352p96RjewJ8vUw5sEud8wolXZCJS9jVdDcx4nrOz9K/udytokJKmD+aFXP2w/m74DjAajt3TPeZTtJhZXLM3S+XeKsFPfJFLGeXCqSirZLWGv1RQEkLkfzdCOovjwq2ceEk/Yo6kTKxmciCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775695307; c=relaxed/simple;
	bh=8wLuI6mh7RXt8kDT4ACedoTRSCK518cCE/kGtYLgjzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o0cJLLR3ncD39EYw5gTeUpaY5rvYAXCd5ZMaMF5juJ9Pqr18hLorIots4qLh0IV321N/bfrnu3XCKVGC1s9G3u5XE7NjdyabZZa/+0cjTvaY4IXniP30vvI/lHJPOYsF50jZw3AaPS+D1AC27UTV23sv+lfEYsdHEcKcNbA9rSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rdk4EEpr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638JwMZS2302812;
	Thu, 9 Apr 2026 00:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pRmlUh
	ffsUdNaSm0DEU37CAO1oOaNK/euXOQaoxSaSA=; b=rdk4EEpr/tmMiUNhFkqbU8
	7Fo+coYxcS6ZHPGjcHU/uS8/P/rFty9qgyqOM0IH/H3hGWEq3Am1wVBaVnayZIhc
	18AoLpjRCF/XFt1bDZ24BAzLaodUdA8zNvElqXq2tG/4Hotp8e68P7kJZEOZSrjl
	q6/irpToG3G8O7WxC9doHv5sFElV8zeu/zonQDfZdjv7Z+oZj0nR2cPjogAunJZ0
	75u5fa6a7oksxTIk9tQ+nyMFrmrL8mohIHLQFWn4nHRUMntUiWgAY45EECnKK7tu
	xn+wad2YbytkLz1x/yqj6ITjhAnbDTwUGHnSn6NgqeVNZQDw5Tt0MDZ+jir68hHQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fjm8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Apr 2026 00:41:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 638KivM3013827;
	Thu, 9 Apr 2026 00:41:23 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmf49kmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Apr 2026 00:41:23 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6390fMdf29426372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Apr 2026 00:41:22 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2FC258051;
	Thu,  9 Apr 2026 00:41:21 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FD425805C;
	Thu,  9 Apr 2026 00:41:21 +0000 (GMT)
Received: from [9.61.12.143] (unknown [9.61.12.143])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Apr 2026 00:41:21 +0000 (GMT)
Message-ID: <de80f843-32cf-44fc-99fa-27741bb5591a@linux.ibm.com>
Date: Wed, 8 Apr 2026 20:41:20 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KEYS: trusted: Debugging as a feature
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Srish Srinivasan <ssrish@linux.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Ahmad Fatoum
 <a.fatoum@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
References: <20260324110043.67248-1-jarkko@kernel.org>
 <afc489d2-a62f-4604-8e56-219311b46516@linux.ibm.com>
 <adYRURAJfNCu0FYB@kernel.org>
Content-Language: en-US
From: Nayna Jain <nayna@linux.ibm.com>
In-Reply-To: <adYRURAJfNCu0FYB@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDAwMSBTYWx0ZWRfXx03AtMlscnw0
 +nHg0Q1ejTFqilAIAFX/PS/H+YJcRn5uw9YzKjL8vaGETUH+ktrw6C5mUcs+1oBbRXIKQcD+/Nm
 28Mx0LAybPA2KjS6vsd+QP83xa30zDv9vnid84UQO1Z7vLNkfTh6fHPdBQf/pfU2Z46jiu0yDZa
 TfuwyfXTcVpAWDstqF4nFZSOJzJV2RsYaC36t2twHwj4wSIMnEFw+DVITWu6ZxCsr+9ibSlVb4N
 qoqCakTZ9cC7ThHAasbvBYswRgKNKJuzF6Z40mWeqXfBa1BRWsI6PwJsFO2iGY5n9nPOepgk7NW
 KhySIq5mQsE4nW7taDiME3dT3Cxa/1MuZogI2s5tQ2D9xCfjxBt5VbtiyJ9wUV8vPOR9/OBJuUi
 4OkSrgj7uLUtpIuq91dbnAQBCQgDeu/GsqT0ilhk+doT5P9xUY1DC2q3MUIRmq3aiR29K32hvM8
 4UTT+U5z55ZMPX5rVJg==
X-Authority-Analysis: v=2.4 cv=FsY1OWrq c=1 sm=1 tr=0 ts=69d6f5b4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=9zmYnvBJHafUxEwRPyoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: iiKealSa48_Ha8C8NaPTn0cV83Mj2L13
X-Proofpoint-GUID: iiKealSa48_Ha8C8NaPTn0cV83Mj2L13
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_07,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090001
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid];
	TAGGED_FROM(0.00)[bounces-9150-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nayna@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 050163C5128
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/8/26 4:26 AM, Jarkko Sakkinen wrote:
> On Mon, Apr 06, 2026 at 10:42:00PM -0400, Nayna Jain wrote:
>> On 3/24/26 7:00 AM, Jarkko Sakkinen wrote:
>>> TPM_DEBUG, and other similar flags, are a non-standard way to specify a
>>> feature in Linux kernel.  Introduce CONFIG_TRUSTED_KEYS_DEBUG for
>>> trusted keys, and use it to replace these ad-hoc feature flags.
>>>
>>> Given that trusted keys debug dumps can contain sensitive data, harden
>>> the feature as follows:
>>>
>>> 1. In the Kconfig description postulate that pr_debug() statements must be
>>>      used.
>>> 2. Use pr_debug() statements in TPM 1.x driver to print the protocol dump.
>>>
>>> Traces, when actually needed, can be easily enabled by providing
>>> trusted.dyndbg='+p' in the kernel command-line.
>>>
>>> Cc: Srish Srinivasan <ssrish@linux.ibm.com>
>>> Reported-by: Nayna Jain <nayna@linux.ibm.com>
>>> Closes: https://lore.kernel.org/all/7f8b8478-5cd8-4d97-bfd0-341fd5cf10f9@linux.ibm.com/
>>> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>>> ---
>>> v2:
>>> - Implement for all trusted keys backends.
>>> - Add HAVE_TRUSTED_KEYS_DEBUG as it is a good practice despite full
>>>     coverage.
>>> ---
>>>    include/keys/trusted-type.h               | 18 +++++-------
>>>    security/keys/trusted-keys/Kconfig        | 19 ++++++++++++
>>>    security/keys/trusted-keys/trusted_caam.c |  4 +--
>>>    security/keys/trusted-keys/trusted_tpm1.c | 36 +++++++++++------------
>>>    4 files changed, 46 insertions(+), 31 deletions(-)
>>>
>>> diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
>>> index 03527162613f..620a1f890b6b 100644
>>> --- a/include/keys/trusted-type.h
>>> +++ b/include/keys/trusted-type.h
>>> @@ -83,18 +83,16 @@ struct trusted_key_source {
>>>    extern struct key_type key_type_trusted;
>>> -#define TRUSTED_DEBUG 0
>>> -
>>> -#if TRUSTED_DEBUG
>>> +#ifdef CONFIG_TRUSTED_KEYS_DEBUG
>>>    static inline void dump_payload(struct trusted_key_payload *p)
>>>    {
>>> -	pr_info("key_len %d\n", p->key_len);
>>> -	print_hex_dump(KERN_INFO, "key ", DUMP_PREFIX_NONE,
>>> -		       16, 1, p->key, p->key_len, 0);
>>> -	pr_info("bloblen %d\n", p->blob_len);
>>> -	print_hex_dump(KERN_INFO, "blob ", DUMP_PREFIX_NONE,
>>> -		       16, 1, p->blob, p->blob_len, 0);
>>> -	pr_info("migratable %d\n", p->migratable);
>>> +	pr_debug("key_len %d\n", p->key_len);
>>> +	print_hex_dump_debug("key ", DUMP_PREFIX_NONE,
>>> +			     16, 1, p->key, p->key_len, 0);
>>> +	pr_debug("bloblen %d\n", p->blob_len);
>>> +	print_hex_dump_debug("blob ", DUMP_PREFIX_NONE,
>>> +			     16, 1, p->blob, p->blob_len, 0);
>>> +	pr_debug("migratable %d\n", p->migratable);
>>>    }
>>>    #else
>>>    static inline void dump_payload(struct trusted_key_payload *p)
>>> diff --git a/security/keys/trusted-keys/Kconfig b/security/keys/trusted-keys/Kconfig
>>> index 9e00482d886a..2ad9ba0e03f1 100644
>>> --- a/security/keys/trusted-keys/Kconfig
>>> +++ b/security/keys/trusted-keys/Kconfig
>>> @@ -1,10 +1,25 @@
>>>    config HAVE_TRUSTED_KEYS
>>>    	bool
>>> +config HAVE_TRUSTED_KEYS_DEBUG
>>> +	bool
>>> +
>>> +config TRUSTED_KEYS_DEBUG
>>> +	bool "Debug trusted keys"
>>> +	depends on HAVE_TRUSTED_KEYS_DEBUG
>>> +	default n
>>> +	help
>>> +	  Trusted keys backends and core code that support debug dumps
>>> +	  can opt-in that feature here. Dumps must only use DEBUG
>>> +	  level output, as sensitive data may pass by. In the
>>> +	  kernel-command line traces can be enabled via
>>> +	  trusted.dyndbg='+p'.
>> Would it be good idea to add an explicit note/warning:
>>
>>
>> NOTE: This option is intended for debugging purposes only. Do not enable on
>> production systems as debug output may expose sensitive cryptographic
>> material.
>> If you are unsure, say N.
>>
>> Apart from this, looks good to me.
>>
>> Reviewed-by: Nayna Jain <nayna@linux.ibm.com>
> Thank, I'll add your tag but would you mind quickly screening v3 again
> where I add "trusted.debug=0|1". And yes, your suggestion about extra
> warning makes sense.
Sure Jarkko.. However, I don't see v3 version in my inbox or in 
linux-integrity. Or you are about to post it soon.
>
> Let's make this safe as possible. Mistakes do happen... and then those
> measures pay off :-)
Yes agree.
>
> BR, Jarkko

Thanks & Regards,

     - Nayna


