Return-Path: <linux-integrity+bounces-9336-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CC26JCuF7GneZQAAu9opvQ
	(envelope-from <linux-integrity+bounces-9336-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 25 Apr 2026 11:11:07 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C69654659E0
	for <lists+linux-integrity@lfdr.de>; Sat, 25 Apr 2026 11:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63D9B3008D35
	for <lists+linux-integrity@lfdr.de>; Sat, 25 Apr 2026 09:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1003233E360;
	Sat, 25 Apr 2026 09:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="PFouws7o"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AE9175A70;
	Sat, 25 Apr 2026 09:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777108265; cv=none; b=sjCSSuVPhEhmJv2OP92o4rWi5t0eYAfLbr5JLq/rGaBMH3WttLxgPl0sSqLcSVMPz13o2KhiDbUaw35IAH92IIoWty/frf2WgDR3EB1IwjPbC6uNd8Rl7SQUbGoqM1gpdI6uhx72ZilzVCs+rTsOWRqxy0tmU0b40RG+NLBb9a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777108265; c=relaxed/simple;
	bh=aoeFCb6TbdJA35mUaAHSKWFBhTGH2XvKgroRhl3uI08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVBau6JY70Hkrqb00MU8705J330yzE2b9Qxdfpn/D7s1mVQ1BL/F2o0BHJBjoqbAbHoWnBnglYk/NPnKwpE53zVvu/iH3/hpR5X1rTAocyT/7ONI7wmHKHZwqWMVdm8o3Ko4To3+JX9/cHdPaXU3s5d9rbDNzr+dASGbXy5SlHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=PFouws7o; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=j6rxqb2f278iGTGU/7sMH9FbEKwwMCCocICHWINsPdM=; b=PFouws7o5doLAYVrlIoXV/9ww5
	d4iXXPdRwm17lO0bbEn5PHzf49HJBIdNDLUsugiKPZkJ5h5nSwbHUQ1Xq2+5ABLaJ07o8zATneKKF
	w+UtT4JkUFt2KJkkfhcZ0nFa3Mqatf1iCNpJMiYXw2+7rbdwpoWMkemT2W/v4xZ5XZweXR2wG6icq
	vNY729gWq41ni9koXEUoRD+hV1lsY+neB7jIdnofYL7YzbQ0iwxIBVZ8jvgkWg3dkYsni9qGV6wRC
	pa+gbrXFIYlAcUqJw6/tPrrN5vfjA7qHE4sGi1aKYyGDEj+XAJQNrBCoow2mnGmFdsY6gE8534edj
	HMC6xTeA==;
Received: from noodles by the.earth.li with local (Exim 4.98.2)
	(envelope-from <noodles@earth.li>)
	id 1wGZ2O-00000006EIj-3k1D;
	Sat, 25 Apr 2026 10:10:57 +0100
Date: Sat, 25 Apr 2026 10:10:56 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com, jarkko@kernel.org, jgg@ziepe.ca,
	sudeep.holla@kernel.org, maz@kernel.org, oupton@kernel.org,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, noodles@meta.com,
	sebastianene@google.com, Yeoreum Yun <yeoreum.yun@arm.com>
Subject: Re: [RFC PATCH v3 2/4] security: ima: call ima_init() again at
 late_initcall_sync for defered TPM
Message-ID: <aeyFIP4Ph57LvPqe@earth.li>
References: <cover.1777036497.git.noodles@meta.com>
 <5552c20c6d6d2ae3bbb6b35124af5d98d2f79163.1777036497.git.noodles@meta.com>
 <43ff6ca37df45ed53061dad46e9d31a5118e5714.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43ff6ca37df45ed53061dad46e9d31a5118e5714.camel@linux.ibm.com>
X-Rspamd-Queue-Id: C69654659E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[earth.li:s=the];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9336-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[earth.li];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,huawei.com,gmail.com,oracle.com,kernel.org,ziepe.ca,arm.com,meta.com,google.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[noodles@earth.li,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[earth.li:-];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_TWELVE(0.00)[25];
	TO_DN_SOME(0.00)[]

On Fri, Apr 24, 2026 at 04:25:31PM -0400, Mimi Zohar wrote:
>Thanks, Jonathan!
>
>On Fri, 2026-04-24 at 14:24 +0100, Jonathan McDowell wrote:
>> -static int __init init_ima(void)
>> +static int __init init_ima(bool late)
>>  {
>>  	int error;
>>  
>> @@ -1247,10 +1247,26 @@ static int __init init_ima(void)
>>  		return 0;
>>  	}
>>  
>> +	/*
>> +	 * If we found the TPM during our first attempt, or we know there's no
>> +	 * TPM, nothing further to do
>> +	 */
>
>Perhaps it's just me, but the comment wording is a bit off.  Could I change it
>to: If we either found the TPM or knew there's no TPM during our first attempt,
>nothing futher to do.

No objections to that updated wording from me.

>Otherwise the patch looks good.
>
>Mimi
>
>
>> +	if (late && (ima_tpm_chip || !IS_ENABLED(CONFIG_TCG_TPM)))
>> +		return 0;
>> +
>> +	ima_tpm_chip = tpm_default_chip();
>> +	if (!ima_tpm_chip && !late && IS_ENABLED(CONFIG_TCG_TPM)) {
>> +		pr_debug("TPM not available, will try later\n");
>> +		return -EPROBE_DEFER;
>> +	}
>> +
>> +	if (!ima_tpm_chip)
>> +		pr_info("No TPM chip found, activating TPM-bypass!\n");
>> +

J.

-- 
Revd Jonathan McDowell, ULC | Run like hell!

