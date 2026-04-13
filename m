Return-Path: <linux-integrity+bounces-9167-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIauJ3bO3GmcWQkAu9opvQ
	(envelope-from <linux-integrity+bounces-9167-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Apr 2026 13:07:34 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C483EB1A2
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Apr 2026 13:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EDEA5300BC6C
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Apr 2026 11:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632D430FF05;
	Mon, 13 Apr 2026 11:03:50 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1543BAD8C
	for <linux-integrity@vger.kernel.org>; Mon, 13 Apr 2026 11:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776078230; cv=none; b=FJ3dLvuRJ/rF7mfvK+YOw8pQTaGidUDJywfaPIgW8zng85NFu+b8BDo8NBqQAo791y4E3SzrSVs/eXXE+VghEvPT4eEvuIxJCSINRebH6JA6/ucItOMw6IsrEVxBHNZTjapGTqXcJQMabIL3Ax8t6Uxs7Cm+2xz0r0JGt9+ikBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776078230; c=relaxed/simple;
	bh=MeOutffsjD4+Sqt7uudqdDFUVeC0MMpC/NDFeB5xch8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BsH7pGMti1OgohBVCVapxHDOg44O12MRDjQj5riJL2G0VSIrzPeRODQ+e88tFqx6QUIyiQSxxIc6fniBgsQLDLwp3tDrdQ4BIsHYEvuxf0uC5+Oc1bcfnHTfbQD/Ne5Y2OvkFslBfwugCcdOEU7TemJeBq3UZo+sECSBoeNZrPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1wCF4n-0007q2-4q; Mon, 13 Apr 2026 13:03:33 +0200
Message-ID: <20e9f021-f6b3-4e19-9e1b-93b1e00eb803@pengutronix.de>
Date: Mon, 13 Apr 2026 13:03:30 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] trusted-keys: move pr_fmt out of trusted-type.h
To: Marco Felsch <m.felsch@pengutronix.de>, Josh Snyder <josh@code406.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
 David Howells <dhowells@redhat.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, David Gstir <david@sigma-star.at>,
 sigma star Kernel Team <upstream+dcp@sigma-star.at>,
 Srish Srinivasan <ssrish@linux.ibm.com>, Nayna Jain <nayna@linux.ibm.com>,
 Sumit Garg <sumit.garg@kernel.org>, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260411-trusted-key-header-v1-1-407c2cd954db@code406.com>
 <cie3zqy5phlopdrxsxpniujwr6i3cpdkfrwjvth3a7ypwjx3ee@hqjl67jnfdch>
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Content-Language: en-US, de-DE, de-BE
In-Reply-To: <cie3zqy5phlopdrxsxpniujwr6i3cpdkfrwjvth3a7ypwjx3ee@hqjl67jnfdch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9167-lists,linux-integrity=lfdr.de];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a.fatoum@pengutronix.de,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity,dcp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[code406.com:email,pengutronix.de:mid,pengutronix.de:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E9C483EB1A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 4/13/26 1:01 PM, Marco Felsch wrote:
> Hi Josh,
> 
> On 26-04-11, Josh Snyder wrote:
>> Defining pr_fmt in a widely-included header leaks the "trusted_key: "
>> prefix into every translation unit that transitively includes
>> <keys/trusted-type.h>. dm-crypt, for example, ends up printing
>>
>>     trusted_key: device-mapper: crypt: dm-10: INTEGRITY AEAD ERROR ...
>>
>> dm-crypt began including <keys/trusted-type.h> in commit 363880c4eb36
>> ("dm crypt: support using trusted keys"), which predates the pr_fmt
>> addition, so the regression has been live from the moment the header
>> gained its own pr_fmt definition.
>>
>> Move the pr_fmt definition into the trusted-keys source files that
>> actually want the prefix.
>>
>> Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
>> Assisted-by: Claude:claude-opus-4-6
>> Signed-off-by: Josh Snyder <josh@code406.com>
>> ---
>>  include/keys/trusted-type.h               | 6 ------
>>  security/keys/trusted-keys/trusted_caam.c | 2 ++
>>  security/keys/trusted-keys/trusted_core.c | 2 ++
>>  security/keys/trusted-keys/trusted_dcp.c  | 2 ++
>>  security/keys/trusted-keys/trusted_pkwm.c | 2 ++
>>  security/keys/trusted-keys/trusted_tpm1.c | 2 ++
>>  security/keys/trusted-keys/trusted_tpm2.c | 2 ++
>>  7 files changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
>> index 03527162613f7..54da1f174aeab 100644
>> --- a/include/keys/trusted-type.h
>> +++ b/include/keys/trusted-type.h
>> @@ -11,12 +11,6 @@
>>  #include <linux/rcupdate.h>
>>  #include <linux/tpm.h>
>>  
>> -#ifdef pr_fmt
>> -#undef pr_fmt
>> -#endif
>> -
>> -#define pr_fmt(fmt) "trusted_key: " fmt
>> -
>>  #define MIN_KEY_SIZE			32
>>  #define MAX_KEY_SIZE			128
>>  #if IS_ENABLED(CONFIG_TRUSTED_KEYS_PKWM)
>> diff --git a/security/keys/trusted-keys/trusted_caam.c b/security/keys/trusted-keys/trusted_caam.c
>> index 601943ce0d60f..a31fd89c0e5c5 100644
>> --- a/security/keys/trusted-keys/trusted_caam.c
>> +++ b/security/keys/trusted-keys/trusted_caam.c
>> @@ -4,6 +4,8 @@
>>   * Copyright 2025 NXP
>>   */
>>  
>> +#define pr_fmt(fmt) "trusted_key: " fmt
> 
> Can we adapt this patch further to include the trusted-key type as well?
> E.g. 'trusted_key-caam'.

Agreed, if we move it into the individual files, we can use the occasion
to make it a bit more descriptive.

I would suggest "trusted_key: caam: ", so the prefix stays the same.

Cheers,
Ahmad

> 
> Regards,
>   Marco
> 

-- 
Pengutronix e.K.                  |                             |
Steuerwalder Str. 21              | http://www.pengutronix.de/  |
31137 Hildesheim, Germany         | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686  | Fax:   +49-5121-206917-5555 |


