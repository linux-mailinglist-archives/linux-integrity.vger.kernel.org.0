Return-Path: <linux-integrity+bounces-6282-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A12ABFB10
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 18:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 961C216A3EB
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 16:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF02121147B;
	Wed, 21 May 2025 16:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BtOWHf4m"
X-Original-To: linux-integrity@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FBA1F541E;
	Wed, 21 May 2025 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747844508; cv=none; b=o/+z0/98Gqmrb1depFOCyWwBVnYJTgaxcUbkbTAySxU0AqNuDpaU/FhlXya/SJbjcpPFlgdilspg2+WhdUiXwp2ne9Zkjah+44wRdnCcaaURI2tSZSCfyHSfuPaCX9LQ6MgZ/4Na1T9HwqZQfXgyFbUwxzMntcfThA+ZkinZ8II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747844508; c=relaxed/simple;
	bh=J7o0Lb1pwl0h+ksh5sKFy9GKFufm/F6Lshj9x86mGVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jk4W/3qkQexuE36bDHodZzX9Z2l56JYMYMqPAfOSfapr0sMOtXuOQhD7wYpz0aGwbaruRkxfYNXCE4UTXeSijK1v96N4q7eYanN7VR8Nh2sjAR5xkbKiSTgzvDpWbbMRN1Y6ugqrh+3B/dtxnadXhQyA+A4q0+/jpAIspWwlD2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BtOWHf4m; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=JXH2FEgz+hUcwhxL+GbuVE6d02Hq/eC4kagxedFMxDY=; b=BtOWHf4ma3qnxjeaBPjVYnEGuQ
	xa5Gh2ukaoXt0ogWizfchndry8oS9O82JxN4K8B1MYB35C4eJwTyrVQeA6hB4SBXagcgZqE0KLd6K
	vk3J9FOzfaNQp2oDaak4CCfiT8jgHezORzOIxXmALjwS5UU0tiT924wgZ77uO092+9rIhRv6+e/Qx
	pjcDWjkUSrHDRbm2x2Agv/w4/dtUxbZ/HEYffTKUFUJjXFDpU4OhEZhuBxcvLoPhUrNQ1KMDqOe7P
	fAqvappewROvudFgDiRfm48435xPauYHRuhryazw1SLSMTWqMHsXdI2iPVgpKr/1m58ez5RynPLrM
	/ERyyDkA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHmCN-00000004qw1-1vqy;
	Wed, 21 May 2025 16:21:43 +0000
Message-ID: <a79a38d3-a5d5-4f53-8cc6-8c5a8f070861@infradead.org>
Date: Wed, 21 May 2025 09:21:40 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/9] Loadpol LSM: filter kernel module request
 according to the policy
To: Casey Schaufler <casey@schaufler-ca.com>, Simon THOBY
 <git@nightmared.fr>, linux-security-module@vger.kernel.org
Cc: linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250521140121.591482-1-git@nightmared.fr>
 <20250521140121.591482-4-git@nightmared.fr>
 <518c8bdd-4f73-4b8b-bdb9-be3294723c99@schaufler-ca.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <518c8bdd-4f73-4b8b-bdb9-be3294723c99@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/21/25 8:47 AM, Casey Schaufler wrote:
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

>> +
>> +struct loadpol_policy_entry {
>> +	struct list_head list;
>> +	// bitfield of policy_entry_origin
> 
> The // comment style is not used in the kernel.

Counter:

https://lore.kernel.org/lkml/CA+55aFyQYJerovMsSoSKS7PessZBr4vNp-3QUUwhqk4A4_jcbg@mail.gmail.com/


-- 
~Randy


