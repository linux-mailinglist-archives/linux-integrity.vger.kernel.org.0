Return-Path: <linux-integrity+bounces-4944-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41441A3E493
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 20:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA232700CFE
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 19:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DB92144D6;
	Thu, 20 Feb 2025 19:02:53 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527BB1DFE00;
	Thu, 20 Feb 2025 19:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740078173; cv=none; b=ureaLsfrjbO1EajHjwnxeLfemXUSxwcF4/HbxP5kdDHahK/ROStyrI0WQ5ockCrJREAFd9n2SQ9tVee02fLzz75fqnm7qJJJdVXEkutjNnWv/YXhfZZ71LmnhVnxks2ES1X/gOeoLbjYzmSmQYBqYxW5UF9+RrNqbu+NPRgUjTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740078173; c=relaxed/simple;
	bh=lvtylBYOZWiEhmpuEkcH3mPtglp1tR2ZOkMgeUz4Djk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VG/0W0y4TA/SWLczaZ+/+egyTQ1Y96rC2H1dfosIwoqjHYsouetJWN7jXBf1AVFZm6hj3Weq0eHcb+7is4j/n/oCCaGBSbtmbrWEiQMPjbZ8hCQc5+Tz5vH/+3r5R7J2GEEpUl8nUPPwQNLgmbsDqCM+qz/GNdsXTEXL/f/M7Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA2271007;
	Thu, 20 Feb 2025 11:03:08 -0800 (PST)
Received: from [10.122.18.111] (unknown [10.122.18.111])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C0183F59E;
	Thu, 20 Feb 2025 11:02:50 -0800 (PST)
Message-ID: <41d5f912-9288-4e13-b074-bd64aacc7a5e@arm.com>
Date: Thu, 20 Feb 2025 13:02:49 -0600
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] tpm_crb: implement driver compliant to CRB over
 FF-A
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
 sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250219201014.174344-1-stuart.yoder@arm.com>
 <20250219201014.174344-2-stuart.yoder@arm.com> <Z7b11Kahh7JXDq9E@kernel.org>
Content-Language: en-US
From: Stuart Yoder <stuart.yoder@arm.com>
In-Reply-To: <Z7b11Kahh7JXDq9E@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/20/25 3:28 AM, Jarkko Sakkinen wrote:
> On Wed, Feb 19, 2025 at 02:10:10PM -0600, Stuart Yoder wrote:
>> The Arm specification TPM Service CRB over FF-A specification
>> defines the FF-A messages to interact with a CRB-based TPM
>> implemented as an FF-A secure partition.
>>
>> Spec URL:
>> https://developer.arm.com/documentation/den0138/latest/
>>
>> This driver is probed when a TPM Secure Partition is
>> discovered by the FF-A subsystem. It exposes APIs
>> used by the TPM CRB driver to send notifications to
>> the TPM.
>>
>> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>> Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>
> 
> Cutting hairs now but as I cannot test this and this is 1/5:
> can this patch be run without 2/5-4/5?

Yes. This 1/5 patch has no compile time or runtime dependency
on 2/5-4/5.

Thanks,
Stuart


