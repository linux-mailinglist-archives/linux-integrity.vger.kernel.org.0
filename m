Return-Path: <linux-integrity+bounces-5237-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 729ADA5D480
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Mar 2025 03:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AE7E1899FFB
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Mar 2025 02:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E8A18D643;
	Wed, 12 Mar 2025 02:51:55 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB7D165F13;
	Wed, 12 Mar 2025 02:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741747915; cv=none; b=qgMSmChBJ/JwkwszhU2SFiTAKAMB3DVmVVp3pav+7eMzGWK1UZ7c6ZVhcBqiDtqGQJ1w0JFvAqH0CeTCl2j95gD5Wzus8LFxAHbff3dBOZmek1T0OdrkENHjnC2cSj8f3vVVO61f5KowmmTR+lhvTbNakSj9fUlFxAdGQS+Rb7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741747915; c=relaxed/simple;
	bh=odQu+YbNOqP4hHDB4GXFaIIi08qe4rGyQ0NRo1CGb5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nmLDvoG/zMQSUfIH2tTAK4FzqF8KVFDQmXttK5+yF+YKjcv4hCsIoZzdRg+VRgrElixauGcwc2CnMoJirxn4aN5nsVT/QAUhBFJjrCZfV+xvlzyg9nEsYGVuzp5ARBFfiERYQnerUH+JqCExTZKm17yQU4tFlrJszF73rAjNyII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4252E152B;
	Tue, 11 Mar 2025 19:52:02 -0700 (PDT)
Received: from [10.119.39.65] (unknown [10.119.39.65])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 794B73F673;
	Tue, 11 Mar 2025 19:51:50 -0700 (PDT)
Message-ID: <635af7df-be7c-4eb1-95d7-cad26a2af787@arm.com>
Date: Tue, 11 Mar 2025 21:51:49 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Build error on -next due to tpm_crb.c changes?
To: Thorsten Leemhuis <linux@leemhuis.info>, jarkko@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 lenb@kernel.org, rafael@kernel.org, jgg@ziepe.ca, peterhuewe@gmx.de,
 sudeep.holla@arm.com, linux-integrity@vger.kernel.org,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20250305173611.74548-1-stuart.yoder@arm.com>
 <0ad035ff-400e-4b15-8b8f-40b69152ec46@leemhuis.info>
 <92bc0a65-608f-4307-bb1c-16d8836d42e5@arm.com>
 <77fb9077-f598-4308-8862-6d09b23688bb@leemhuis.info>
Content-Language: en-US
From: Stuart Yoder <stuart.yoder@arm.com>
In-Reply-To: <77fb9077-f598-4308-8862-6d09b23688bb@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/11/25 11:51 AM, Thorsten Leemhuis wrote:
> On 11.03.25 16:53, Stuart Yoder wrote:
>> On 3/11/25 10:21 AM, Thorsten Leemhuis wrote:
>>> On 05.03.25 18:36, Stuart Yoder wrote:
>> [...]
>> So, it should not be possible on one had have
>> CONFIG_TCG_ARM_CRB_FFA being true when building tpm_crb.c
>> and false resulting in the tpm_crb_ffa.o not being
>> picked up in the build.
> 
> Many thx for the answer. Maybe Fedora's way to prepare the .config files
> (which my package builds use to be close to Fedora's official packages)
> is doing something odd/wrong. Will take a closer look and report back.

It would help to be able to see the .config to see how the relevant
config options were set.

Thanks,
Stuart


