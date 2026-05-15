Return-Path: <linux-integrity+bounces-9533-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KUKL9BiB2q90wIAu9opvQ
	(envelope-from <linux-integrity+bounces-9533-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 20:15:44 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62803556000
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 20:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCA6B31353A5
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 17:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC6340315B;
	Fri, 15 May 2026 17:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ja2IcddK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B0E403148;
	Fri, 15 May 2026 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866634; cv=none; b=FaotPi94CTDftdhWFtbKgYRFb3xvawbcaYTX5qKNuD7qU/wbIjjmHsQ0e+eGf3AVecxL7g7LmoZ3ENMoHVRNKKUQBXnCcHVId61qinyBPI+yEg0ed6I4ltCJro9uQizkqu5al+jIB63jdw7dPXG6o/R/pS0cGGm/0ceouitIBgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866634; c=relaxed/simple;
	bh=+Ls0F6w9VURXI4GEcetLzbFzanKRu8yo3W8wxOnalcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EhfYyzdHbZGwOuy+6T4N+VHbOKh2zw4eF0WlU8InWGeaKgzxA859EYCIYPxflO6Pykwm1RNTy4jXx9vEzOwSEh0pKK9owrE/JAUO2muGKC4b28jfDomchqK5zOsFrx9IuxBcJQZQevadRW+OG4T2XcUDht1Jsyoe6HhsMUiQImc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ja2IcddK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.2.212.4] (unknown [131.107.8.4])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5354C20B7166;
	Fri, 15 May 2026 10:37:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5354C20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778866628;
	bh=B8AsH74VMVc9O2e3pFp8lTxUXERC0+x7JLz81ESDZ/U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ja2IcddKHdNxZqi0t5OjkqZUuFkClB9lzzBaxQ5gu0njqloyL3B1onhHBIhbtYE9Z
	 5FaYSfFJszfyl4IcA6f0FQq/0Nir/zy0hUna+QFjzQkcX4VQ9P5sErp2DaOql6Jvhq
	 n+vjZ836QKRuddVqrCgSPDDVw2eEcy6fUudpqlYU=
Message-ID: <8db443f1-d2f3-47ce-9116-18985ed0b290@linux.microsoft.com>
Date: Fri, 15 May 2026 10:37:11 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/13] ima: Introduce staging mechanism
To: Roberto Sassu <roberto.sassu@huaweicloud.com>,
 steven chen <chenste@linux.microsoft.com>, corbet@lwn.net,
 skhan@linuxfoundation.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 gregorylumen@linux.microsoft.com, Roberto Sassu <roberto.sassu@huawei.com>
References: <20260429160319.4162918-1-roberto.sassu@huaweicloud.com>
 <99c30be6-8b0f-486a-890c-cf74c5930726@linux.microsoft.com>
 <aaed52cf-26e1-4c40-812d-3788024ce5b5@linux.microsoft.com>
 <2302296a13b847960dbdbab3cf5518b275938838.camel@huaweicloud.com>
Content-Language: en-US
From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
In-Reply-To: <2302296a13b847960dbdbab3cf5518b275938838.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 62803556000
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9533-lists,linux-integrity=lfdr.de];
	FREEMAIL_TO(0.00)[huaweicloud.com,linux.microsoft.com,lwn.net,linuxfoundation.org,linux.ibm.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nramas@linux.microsoft.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Thanks for the response Roberto.

On 5/12/2026 1:17 AM, Roberto Sassu wrote:

>>>
>>> This submission proposes two ways for log trimming:
>>>
>>> *Flavor 1:* Staging With Prompt
>>> *Flavor 2:* Stage and Delete N
>>>
> 
> I'm happy to support your trimming method. Just does not fit with my
> use case. I would like to keep both.
> 

If "Flavor 1: Staging With Prompt" would be beneficial to the Linux 
kernel customers, in general, we should continue to review the change 
and merge it eventually.

My request, then, would be to split this patch set into 2 parts:

	Part 1: Implements "Staging With Prompt"

	Part 2: Implements "Stage and Delete N"

I think that would make it easier for reviewing the code, test\validate, 
and merge.

Thanks,
  -lakshmi



