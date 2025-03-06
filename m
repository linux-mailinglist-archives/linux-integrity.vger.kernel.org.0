Return-Path: <linux-integrity+bounces-5154-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB86CA55A19
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Mar 2025 23:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD8F3B2201
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Mar 2025 22:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637D127C162;
	Thu,  6 Mar 2025 22:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="frZ2g56C"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40CC200B95;
	Thu,  6 Mar 2025 22:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741301160; cv=none; b=a8c7pA4vH9TO+4XmuXXFGt7jjNOZXcKUUrAyadeIHIoxdWBkw/6BigZX7GPQBw1P5fOo0qogJ0i+v6R8y+oqjD/UEfU8bZih0cl+kfpgWVIIFRYVvxiFWyhHwqKfD8FXy8HPPyZya8Y6FbuA3p97Khu3yo0vb9tibzkPsqkZE3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741301160; c=relaxed/simple;
	bh=73rsgDoass/Y1+2HG5CNEyi1Fuz1zgyePDkEuCjqoog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BrRaxCOJyE4T8cMkez8613+RBekqWZjkXKRmKNTh1KtGpd8Kn6t6ARgWzaUDG8KpDRFCFC2sSIzYx8YBURprgMns6jK9I3r2Z2BmENZjbvcE0md0RE/cCgm7GdgXXNdDuWmqabub4IQygE5VmTjbM8QIPybZDUsbST5/l3d2fBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=frZ2g56C; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.64.156] (unknown [131.107.174.156])
	by linux.microsoft.com (Postfix) with ESMTPSA id A21DB211049E;
	Thu,  6 Mar 2025 14:45:51 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A21DB211049E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741301151;
	bh=3h7ftrzvKeXTY/PZI7hZ0Sx+af2u9JaEQAn6P8Go0PY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=frZ2g56CJBXLTlvFGP10n2vV/Lei/JOHKPeR+oJ+BoOYE4NEjI4GdM5s5AvOja4F1
	 e9x3Q4hPs5Z9OFTrxEDuZSVeSuZf2eaMpxJ46AbqeZBCaiFvT54SezOOZdv8w5cOZw
	 CccLoMZbeAJsRhpSgj0J0ugVr2zhbfTBS/qXOFTU=
Message-ID: <8bc74dd8-ecd0-44ad-88a2-8b36fa61100a@linux.microsoft.com>
Date: Thu, 6 Mar 2025 14:45:50 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/7] ima: copy only complete measurement records across
 kexec
To: Mimi Zohar <zohar@linux.ibm.com>, Baoquan He <bhe@redhat.com>
Cc: stefanb@linux.ibm.com, roberto.sassu@huaweicloud.com,
 roberto.sassu@huawei.com, eric.snowberg@oracle.com, ebiederm@xmission.com,
 paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
 linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@hansenpartnership.com, vgoyal@redhat.com, dyoung@redhat.com
References: <20250304190351.96975-1-chenste@linux.microsoft.com>
 <20250304190351.96975-2-chenste@linux.microsoft.com>
 <Z8g+uhZQ6totYLmp@MiWiFi-R3L-srv>
 <fe6e3c1333a50d66dc876b5a196d3491170802a8.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <fe6e3c1333a50d66dc876b5a196d3491170802a8.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/5/2025 4:27 AM, Mimi Zohar wrote:
> On Wed, 2025-03-05 at 20:08 +0800, Baoquan He wrote:
>> On 03/04/25 at 11:03am, steven chen wrote:
>>> Carrying the IMA measurement list across kexec requires allocating a
>>> buffer and copying the measurement records.  Separate allocating the
>>> buffer and copying the measurement records into separate functions in
>>> order to allocate the buffer at kexec 'load' and copy the measurements
>>> at kexec 'execute'.
>>>
>>> This patch includes the following changes:
>> I don't know why one patch need include so many changes. From below log,
>> it should be split into separate patches. It may not need to make one
>> patch to reflect one change, we should at least split and wrap several
>> kind of changes to ease patch understanding and reviewing. My personal
>> opinion.
> Agreed, well explained.
>
> Mimi
>
>>>   - Refactor ima_dump_measurement_list() to move the memory allocation
>>>     to a separate function ima_alloc_kexec_file_buf() which allocates
>>>     buffer of size 'kexec_segment_size' at kexec 'load'.
>>>   - Make the local variable ima_kexec_file in ima_dump_measurement_list()
>>>     a local static to the file, so that it can be accessed from
>>>     ima_alloc_kexec_file_buf(). Compare actual memory required to ensure
>>>     there is enough memory for the entire measurement record.
>>>   - Copy only complete measurement records.
>>>   - Make necessary changes to the function ima_add_kexec_buffer() to call
>>>     the above two functions.
>>>   - Compared the memory size allocated with memory size of the entire
>>>     measurement record. Copy only complete measurement records if there
>>>     is enough memory. If there is not enough memory, it will not copy
>>>     any IMA measurement records, and this situation will result in a
>>>     failure of remote attestation.
>>>
>>> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
>>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>>> Signed-off-by: steven chen <chenste@linux.microsoft.com>

I will split this patch into the following two patches:

     ima: define and call ima_alloc_kexec_file_buf
     ima: copy measurement records as much as possible across kexec

Thanks,

Steven


