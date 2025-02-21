Return-Path: <linux-integrity+bounces-4971-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41625A401C1
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2025 22:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B00D16B26D
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2025 21:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99AB253F30;
	Fri, 21 Feb 2025 21:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PlsqIhZP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41138253B62;
	Fri, 21 Feb 2025 21:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740171948; cv=none; b=OGs7QJIMeR9vVC6+inXMuz7VFt4pPAhbq9h/3O1fyoT6/cibrQQlojb2zViCjnzPx77UUxtJA6HIJRk1u+etXnGPfrQP7mX4giKrGyvJopiowlld7H8nZo97+Gq1iA9OFhwBDOxy0CBcMqRcz+z4TaYjyVUzmM9WrN8EruWrcdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740171948; c=relaxed/simple;
	bh=GWK6sgltHoesfc4Hvs48MbApGe+KxZvU2GqOLuArVLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tsvIgWH2Nrvg1ETNqZnyainPIE9KpPYMedcP7bgaJXwqpmEUJ+0c7DRTSmBJH7rqdG4TOL9AXSgmvD0afWJs0M/PlISmsv+fyxoExshVktHX8duu7h9zTiYC7vdRHWGhTkPdLxwV/gTOHk0vqH/MZv52vgwbHqkg0w2mQTZDtWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PlsqIhZP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.64.59] (unknown [131.107.8.59])
	by linux.microsoft.com (Postfix) with ESMTPSA id 79933205367B;
	Fri, 21 Feb 2025 13:05:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 79933205367B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740171946;
	bh=5nEtVawYrUgdWCquTzf4DrLN6Eub03km1393TBgkgBY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PlsqIhZPJD1i6y0OPUbwIhXXlgdZ2AbNoe6SqE2MjQUSTscFXcpAUHNYPtGCSI4aO
	 zae24HXFY1JXGtlF6KOJZNxQJHpqNqfoDlqC7Z9on+58eJbtbYIP25EFvxuYHf3STS
	 zjNseWrCXv0uqFFduPb3oK8ysGVSKzllqRinz820=
Message-ID: <3723d5f8-12b7-417f-9030-218e561e9397@linux.microsoft.com>
Date: Fri, 21 Feb 2025 13:05:45 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/7] kexec: define functions to map and unmap segments
To: Mimi Zohar <zohar@linux.ibm.com>, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@HansenPartnership.com, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
 <20250218225502.747963-3-chenste@linux.microsoft.com>
 <c76a6a741b6f465d270153b65ea6f728383ca608.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <c76a6a741b6f465d270153b65ea6f728383ca608.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/20/2025 9:22 AM, Mimi Zohar wrote:
> Hi Steven,
>
> On Tue, 2025-02-18 at 14:54 -0800, steven chen wrote:
>> Currently, the mechanism to map and unmap segments to the kimage
>> structure is not available to the subsystems outside of kexec.  This
>> functionality is needed when IMA is allocating the memory segments
>> during kexec 'load' operation.  Implement functions to map and unmap
>> segments to kimage.
> Obviously up to now Kexec was mapping the segments. Missing from this patch description is
> the reason "why" these functions are needed now.  It's not enough to say "is needed when
> IMA is allocating the memory segments during kexec 'load' operation".  The question is why
> does "IMA" need to allocate the memory segments.  Don't make the kexec/kexec_dump
> maintainers guess.
>
> Refer to the section "Describe your changes" in
> https://www.kernel.org/doc/Documentation/process/submitting-patches.rst
>
>> Implement kimage_map_segment() to enable mapping of IMA buffer source
>> pages to the kimage structure post kexec 'load'.  This function,
>> accepting a kimage pointer, an address, and a size, will gather the
>> source pages within the specified address range, create an array of page
>> pointers, and map these to a contiguous virtual address range.  The
>> function returns the start of this range if successful, or NULL if
>> unsuccessful.
>>
>> Implement kimage_unmap_segment() for unmapping segments
>> using vunmap().
>>
>> From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Again, no such thing as an "Author" tag.  Refer to the comments on 1/7.
>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> As previously requested, please add the Cc's inline here and in all the kexec/kdump
> related patches:
>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
>
>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> thanks,
>
> Mimi

Mimi, thanks. I will update in next version.

Steven


