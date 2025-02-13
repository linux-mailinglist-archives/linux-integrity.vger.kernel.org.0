Return-Path: <linux-integrity+bounces-4818-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B85A35118
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Feb 2025 23:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50EDD16CC29
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Feb 2025 22:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64352211299;
	Thu, 13 Feb 2025 22:18:01 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E80A44C7C;
	Thu, 13 Feb 2025 22:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739485081; cv=none; b=I16WLd36gNMtKl/HzqZqYZbialCaq+UTu1609Qq0IFkmJC65gexlpGa0ZYZIuBhFbdkSMT1AbBfiZ1EyFRxiLJX3zpA1t8pOgU8aZPHGH/7kQ7MSGrbMzEy1Bf/4M8hLxwxPKITnGxkMNzSd+JQLUz5KxSYHQJAFcoby+OwowK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739485081; c=relaxed/simple;
	bh=wqefMj2OjBMV9f903IECS9IfnZFQxMtV9+o7b+D27sU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aFn6+IqNfM1WkVpdw8S5/FWNJQa5RcAJDi2Ogev9gSOecOU7PU6xxz+Jxk6jSByu8fdClVc9UGgIs3JJGKuVM0OdQCS/NjgrXKDbwc+xWliXifn9thGJ50FkyxRjMwkByfeXSoGjRVjkR6vO0DlS75saFAXdfrpEXD1+I8q7OJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B436106F;
	Thu, 13 Feb 2025 14:18:18 -0800 (PST)
Received: from [10.122.17.146] (unknown [10.122.17.146])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36CEA3F5A1;
	Thu, 13 Feb 2025 14:17:57 -0800 (PST)
Message-ID: <b9a7d98a-2723-45e0-bb3b-19cd31473251@arm.com>
Date: Thu, 13 Feb 2025 16:17:56 -0600
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] Documentation: tpm: add documentation for the CRB
 FF-A interface
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
 sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250212220548.400447-1-stuart.yoder@arm.com>
 <20250212220548.400447-6-stuart.yoder@arm.com> <Z65uKkt2f0WYxjHi@kernel.org>
Content-Language: en-US
From: Stuart Yoder <stuart.yoder@arm.com>
In-Reply-To: <Z65uKkt2f0WYxjHi@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/13/25 4:11 PM, Jarkko Sakkinen wrote:
> On Wed, Feb 12, 2025 at 04:05:48PM -0600, Stuart Yoder wrote:
>> Add documentation providing details of how the CRB driver interacts
>> with FF-A.
>>
>> Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>
>> ---
>>   Documentation/security/tpm/tpm_ffa_crb.rst | 65 ++++++++++++++++++++++
>>   1 file changed, 65 insertions(+)
>>   create mode 100644 Documentation/security/tpm/tpm_ffa_crb.rst
>>
>> diff --git a/Documentation/security/tpm/tpm_ffa_crb.rst b/Documentation/security/tpm/tpm_ffa_crb.rst
>> new file mode 100644
>> index 000000000000..c70f8904a93d
>> --- /dev/null
>> +++ b/Documentation/security/tpm/tpm_ffa_crb.rst
>> @@ -0,0 +1,65 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +========================
>> +TPM CRB over FF-A Driver
>> +========================
>> +
>> +The TPM Command Response Buffer (CRB) interface is a standard TPM interface
>> +defined in the TCG PC Client Platform TPM Profile (PTP) Specification [1]_.
>> +The CRB provides a structured set of control registers a client uses when
>> +interacting with a TPM as well as a data buffer for storing TPM commands and
>> +responses. A CRB interface can be implemented in:
>> +
>> +- hardware registers in a discrete TPM chip
>> +
>> +- in memory for a TPM running in isolated environment where shared memory
>> +  allows a client to interact with the TPM
>> +
>> +The Firmware Framework for Arm A-profile (FF-A) [2]_ is a specification
>> +that defines interfaces and protocols for the following purposes:
>> +
>> +- Compartmentalize firmware into software partitions that run in the Arm
>> +  Secure world environment (also know as TrustZone)
> 
> Does that also cover ARM CCA? Just a question (not a review question).

No, CCA is for confidential VMs which is a separate trusted execution
environment and FF-A is not used there.

Thanks,
Stuart

