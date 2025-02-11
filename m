Return-Path: <linux-integrity+bounces-4790-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA7EA3196F
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Feb 2025 00:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFC283A132C
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Feb 2025 23:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF89F267AF5;
	Tue, 11 Feb 2025 23:21:19 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE37272910;
	Tue, 11 Feb 2025 23:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739316079; cv=none; b=GJLT/2LoFTSbBz/zYsRYYZoJLnvxIit3Qr6/G7A3NnLNbrCssXYxBzLeuP3DMl0+F+tZ1ewiVDX4nxcpHa1djncFAVBshLo9kmD2Yfz+znTw2mKD6sqGaBshAddi+OkL0ViwJ0XofMN0vKnFrSu96/MWTg9AENXP57+xNR4S4w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739316079; c=relaxed/simple;
	bh=9zyrwDqbnFDvfkB8IDpKb0RSh3VGjRbz0cJek4rgbGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fj1+ZC8UAmxOhk/X8gYG0BJKHW9UDbyhIvGbgwjclWEOlqwDI45I/J5yQUBPOfKBxF+NBX16TxFShJneLY10gL/foQC+4PZB3dQ9Lrk1T8s+RpJzbmVYBkVC85UjJdLcldIr1zJroBSwP24Izr70JxAv3xGBh5UDB8FIHbF0fLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C8AB1D14;
	Tue, 11 Feb 2025 15:21:36 -0800 (PST)
Received: from [10.118.111.35] (G9L3377F54.austin.arm.com [10.118.111.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5B183F58B;
	Tue, 11 Feb 2025 15:21:14 -0800 (PST)
Message-ID: <b167a781-e9b3-444b-aee2-1c9267f7efeb@arm.com>
Date: Tue, 11 Feb 2025 17:21:14 -0600
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Add support for the TPM FF-A start method
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
 sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250210232227.97761-1-stuart.yoder@arm.com>
 <Z6u8DbOlZflmQ9i7@kernel.org>
Content-Language: en-US
From: Stuart Yoder <stuart.yoder@arm.com>
In-Reply-To: <Z6u8DbOlZflmQ9i7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/11/25 3:07 PM, Jarkko Sakkinen wrote:
> On Mon, Feb 10, 2025 at 05:22:23PM -0600, Stuart Yoder wrote:
>> These patches add support for the CRB FF-A start method defined
>> in the TCG ACPI specification v1.4 and the FF-A ABI defined
>> in the Arm TPM Service CRB over FF-A (DEN0138) specification.
>> (https://developer.arm.com/documentation/den0138/latest/)
> 
> 
> It would bring a whole a lot of clarity to open up acronyms.
> What are F, F and A? There's quite a few of these in this
> industry.
> 
> Also, probably you could take the spec out of parentheses and
> use double colon.

Will do this in v2.

Stuart

