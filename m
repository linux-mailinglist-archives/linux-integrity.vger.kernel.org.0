Return-Path: <linux-integrity+bounces-4847-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E03A388B3
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Feb 2025 17:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C8C17729D
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Feb 2025 16:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941AF226193;
	Mon, 17 Feb 2025 15:53:27 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09998225405;
	Mon, 17 Feb 2025 15:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807607; cv=none; b=Kdhbgtab1rIZs7s7uowSOuy+gIn92K4/7xR6+UgtcTyNDFLnNV/Nj//QpgyY4ziZlXfaVwg8TwXEjA7jclznqh70d8RiUrIqr3Y9CEGvUg+IUKplDVn8V9OT/efUcDO+F1e4wllyFlhBQRJ7smEpJwb6o7l0ds8PIiUYRAkGPjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807607; c=relaxed/simple;
	bh=Gb9tT7GHGhrsX9hN/sCMCBb5o0oWmHYRnrWf2XeKYCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VXqZVOsX5/5jEG99+dmZzSqiaOnv5kgbtHrjUAugYWtusHXyK+pgILTNSly5Jl4G1uLcQTAXP+zzmgZL7awulcq/y+ZfiaZreqjaTMqGmQrXRFkmVMIsEjTy33ls0Uf0bNVl4NW2gTRTFZdtVhq85c21DGT7v3jThJNH7AygLKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 951CB152B;
	Mon, 17 Feb 2025 07:53:44 -0800 (PST)
Received: from [10.122.18.64] (unknown [10.122.18.64])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 380AD3F5A1;
	Mon, 17 Feb 2025 07:53:25 -0800 (PST)
Message-ID: <195bc518-a20a-487f-b1ad-e83ca9ed5630@arm.com>
Date: Mon, 17 Feb 2025 09:53:24 -0600
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] tpm_crb: implement driver compliant to CRB over
 FF-A
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
 sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250214002745.878890-1-stuart.yoder@arm.com>
 <20250214002745.878890-2-stuart.yoder@arm.com> <Z670QLo_FefvuNb8@kernel.org>
Content-Language: en-US
From: Stuart Yoder <stuart.yoder@arm.com>
In-Reply-To: <Z670QLo_FefvuNb8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>> +int tpm_crb_ffa_init(void)
>> +{
>> +	if (tpm_crb_ffa == NULL)
>> +		return -ENOENT;
>> +
>> +	if (IS_ERR_VALUE(tpm_crb_ffa))
>> +		return -ENODEV;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(tpm_crb_ffa_init);
> 
> Should be documented given export [1].

Ack.

> 
>> +
>> +static int __tpm_crb_ffa_send_recieve(unsigned long func_id,
>> +		unsigned long a0, unsigned long a1, unsigned long a2)
>> +{
>> +	int ret;
>> +	const struct ffa_msg_ops *msg_ops;
> 
> Reverse tree-order would be easier for brain.

Ack.

>> +
>> +	if (tpm_crb_ffa == NULL)
> 
> You probably did not run checkpatch.pl with '--strict', did you? ;-)

No, did no check with --strict.  Will do that.

>> +}
>> +EXPORT_SYMBOL_GPL(tpm_crb_ffa_get_interface_version);
> 
> Ditto.

Ack.


>> +}
>> +EXPORT_SYMBOL_GPL(tpm_crb_ffa_start);
> 
> Ditto.

Ack

>> +++ b/drivers/char/tpm/tpm_crb_ffa.h
>> @@ -0,0 +1,30 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (C) 2024 Arm Ltd.
>> + *
>> + * Authors:
>> + * Stuart Yoder <stuart.yoder@arm.com>
>> + *
>> + * Maintained by: <tpmdd-devel@lists.sourceforge.net>
> 
> Please, rip off this authors and maintainers clutter:
> 
> 1. Git maintains authorship
> 2. MAINTAINERS takes care of the rest.

Ack

Thanks,
Stuart

