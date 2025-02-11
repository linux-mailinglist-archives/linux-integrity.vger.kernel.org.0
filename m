Return-Path: <linux-integrity+bounces-4783-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCFEA310DB
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Feb 2025 17:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00A56188D39A
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Feb 2025 16:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFE2257441;
	Tue, 11 Feb 2025 16:09:30 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7191253F33;
	Tue, 11 Feb 2025 16:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739290170; cv=none; b=jB0Ncsv9vduLvx0HJEMD2rmliMVE9TQuJ27O2EqkA/WySb55jetPvEqSzpoJ3+6NYsxa0KEK1yKQzWQyUihF7lc7tmIYKMMTKuf6pcwdJkoTugqQ+FhZwbDNFOf215XbRdmqrAOJyP17QMXdR2QifDTUDteocAf+Tb1KStzh6KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739290170; c=relaxed/simple;
	bh=Hvu6y70Mb6bMgfUhIj1Vw0po/lQBZkipV1p9qSr+/NI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A0jxVajSlAa1Y72LJJHIqMRNxh8GyXq1+Sf31w5dmK62R3AqGYZeWRJXKcBODA1wgS29VSYjqgIK+i+RjGTxNfXHzKSvJvNjt/rd08vP88uQWs+q4n8ESyBEd9L7iEsgW5IrNiu/MOjdu3ggcHLOw8C7j5AU4umRYQltdwWGtWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 344A712FC;
	Tue, 11 Feb 2025 08:09:49 -0800 (PST)
Received: from [10.122.17.210] (unknown [10.122.17.210])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A4133F6A8;
	Tue, 11 Feb 2025 08:09:27 -0800 (PST)
Message-ID: <4bb3cefa-b843-45ca-82c5-d96b13454baa@arm.com>
Date: Tue, 11 Feb 2025 10:09:26 -0600
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Add support for the TPM FF-A start method
To: Sumit Garg <sumit.garg@linaro.org>
Cc: linux-integrity@vger.kernel.org, jarkko@kernel.org, peterhuewe@gmx.de,
 jgg@ziepe.ca, sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jens Wiklander <jens.wiklander@linaro.org>
References: <20250210232227.97761-1-stuart.yoder@arm.com>
 <CAFA6WYM7K4_toy5_n1arW4po4SOX0R9624rCgO=_MvcMeySwUA@mail.gmail.com>
Content-Language: en-US
From: Stuart Yoder <stuart.yoder@arm.com>
In-Reply-To: <CAFA6WYM7K4_toy5_n1arW4po4SOX0R9624rCgO=_MvcMeySwUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sumit,

On 2/11/25 12:45 AM, Sumit Garg wrote:
> + Jens
> 
> Hi Stuart,
> 
> On Tue, 11 Feb 2025 at 04:52, Stuart Yoder <stuart.yoder@arm.com> wrote:
>>
>> These patches add support for the CRB FF-A start method defined
>> in the TCG ACPI specification v1.4 and the FF-A ABI defined
>> in the Arm TPM Service CRB over FF-A (DEN0138) specification.
>> (https://developer.arm.com/documentation/den0138/latest/)
> 
> Nice to have a specification standardizing interface to TPM
> managed/implemented by the firmware. Care to add corresponding kernel
> documentation under Documentation/security/tpm/.

Yes, I can add some documentation there.

> BTW, we already have drivers/char/tpm/tpm_ftpm_tee.c, so do you see
> possibilities for an abstraction layer on top of communication channel
> based on either FF-A or TEE or platform bus?

I think the CRB and OP-TEE based messaging approaches for interacting
with a TZ-based TPM are fundamentally different and I don't see how
to harmonize them through some abstraction.

The OP-TEE TPM protocol copies the TPM command into a temp shared memory
buffer and sends a message to the TPM referencing that buffer.

The CRB uses a permanently shared memory carve-out that in addition
to the command/response data has other fields for locality control,
command control, status, TPM idle, etc. The only 'message' needed is
something to signal 'start'.  Any OS that is FF-A aware and has a
CRB driver can simply add a new start method, which is what this
patch series does.

>>
>> FF-A is a messaging framework for Arm-based systems and in the
>> context of the TPM driver is used to signal 'start' to a CRB-based
>> TPM service which is hosted in an FF-A secure partition running in
>> TrustZone.
> 
> Is there any open source implementation for such a secure partition
> managing the TPM?

Nothing yet, but something I am working towards.

> Also, is that really a discrete TPM or firmware TPM
> managed by the firmware?

It could be either. It doesn't matter from the point of view of
the OS CRB driver. For testing this patch series I used an
internal proof-of-concept fTPM with a CRB interface.

> If it supports firmware TPM, I would be interested to see how you plan
> to handle cases related to secure storage.

Yes, this is a challenge and there are various ways it could be
implemented. For example, RPMB or if you have an internal root of
trust with secure storage like an RSE that could play a role.

Thanks,
Stuart



