Return-Path: <linux-integrity+bounces-4967-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31793A3FED5
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2025 19:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 530EB3A3219
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2025 18:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF7525290A;
	Fri, 21 Feb 2025 18:29:08 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BF2252901;
	Fri, 21 Feb 2025 18:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740162548; cv=none; b=BZhO3iFajBULshB4I0eE8tpdmow7cZJUbbhj/7irdWaqC+SMpJv236lC/uPjj7I2g+dfrWKEWNU6YnFjaN8OUsXzBjL3TI1tfOtGI10CET732knfyfiOx0uw+oWoxy6Niw4sVZ1hoK+gdIJqYaowceNAeezpWH5rWOFhZ+JvwmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740162548; c=relaxed/simple;
	bh=EQIeLXQqxD3x0BWaZ1lDI0FqVhuWHunLIysa+rgnkTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iyf0PjIxAm+M1teOhv62/QITF1+XAn2Ucujj3ZPOAvh+VRWuK4coOMGbfie+JnxvowT6yIkRDsQtuXm+bsH4OW0p4ntaZtreNFAtzV13r9x9iaqhYzrYJ0Vb5CWwqiizBTJo0VukwPNcNwnzN7NjyxBFVekPFbS3lLf5k9v6VXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B583169C;
	Fri, 21 Feb 2025 10:29:22 -0800 (PST)
Received: from [10.122.18.120] (unknown [10.122.18.120])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 413323F59E;
	Fri, 21 Feb 2025 10:29:04 -0800 (PST)
Message-ID: <79dd35d4-147b-4b12-8ce8-1909428d75bd@arm.com>
Date: Fri, 21 Feb 2025 12:29:03 -0600
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Add support for the TPM FF-A start method
To: Sudeep Holla <sudeep.holla@arm.com>, Sumit Garg <sumit.garg@kernel.org>
Cc: Sumit Garg <sumit.garg@linaro.org>, linux-integrity@vger.kernel.org,
 jarkko@kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca, rafael@kernel.org,
 lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jens Wiklander <jens.wiklander@linaro.org>, Rob Herring <robh@kernel.org>
References: <20250210232227.97761-1-stuart.yoder@arm.com>
 <CAFA6WYM7K4_toy5_n1arW4po4SOX0R9624rCgO=_MvcMeySwUA@mail.gmail.com>
 <4bb3cefa-b843-45ca-82c5-d96b13454baa@arm.com>
 <CAFA6WYM3UA9+TE8L2U5Qd8FZfaGZnbba=QzWU7fEu3LKQVm-tw@mail.gmail.com>
 <fdaa9a58-790f-4839-8db7-1b9a81eb8edf@arm.com>
 <CAFA6WYM0ANqc--ScYtJFRjOsCCjzO3NX46=F5V=rza_6Q-Q96g@mail.gmail.com>
 <e142afd2-38ec-4640-b9be-cb414bccc807@arm.com> <Z7LGbZsOh_w-HRY2@sumit-X1>
 <5dae96fa-0e54-4274-bcc6-1c20fe846f60@arm.com> <Z7iDuwLDA2rFPZK6@sumit-X1>
 <Z7iHaWPyq3KDG7J2@bogus>
Content-Language: en-US
From: Stuart Yoder <stuart.yoder@arm.com>
In-Reply-To: <Z7iHaWPyq3KDG7J2@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/21/25 8:02 AM, Sudeep Holla wrote:
> Hi Sumit,
> 
> On Fri, Feb 21, 2025 at 07:16:35PM +0530, Sumit Garg wrote:
>> On Mon, Feb 17, 2025 at 10:56:58AM -0600, Stuart Yoder wrote:
>>>
>>> I don't see how changing TPM discovery to be via FF-A directly
>>> would improve maintainability.
>>
>> You are considering ACPI at this point but when people want to use this
>> TPM over FF-A on a platform using DT then it will require corresponding
>> DT bindings. After that each platform has to enable TPM over FF-A in
>> their corresponding ACPI/DT. All that won't be needed with auto
>> discovery over FF-A.

Yes, we would need a new DT binding.

> I hear you and completely agree. However, someone thought it was a good idea
> to align with other start methods and duplicate information in the TCG ACPI
> specification. This is definitely a bad idea, as it may contradict the
> firmware. All we needed was a simple flag to indicate whether FF-A is the
> start method.

Do you mean a flag exposed via ACPI?  If you do FF-A based discovery you
don't even need that.  Everything could be determined via an FF-A
interface.

> It sounds like a classic case of misalignment between specification authors
> and practical implementation needs. Instead of a simple flag to indicate FF-A
> as the start method, duplicating information in the TCG ACPI specification
> seems unnecessary and potentially problematic—especially if it risks
> conflicting with firmware behavior.

There is a lot of history, but I think it was simply that ACPI
advertisement of an FF-A based TPM seemed like the approach
with the least friction. And Linux is not the only target OS.

> Anyway, I can't comment on how we ended up here, but this seems to be the reality.

I don't think we are locked into ACPI (or DT) only discovery.
It's possible that with a modest delta on top of this patch series
that the tpm_crb driver could also probe based on FF-A.

The CRB over FF-A spec (DEN0138) could be extended in a backwards
compatible way to expose additional info like the base address of the
CRB.

Thanks,
Stuart


