Return-Path: <linux-integrity+bounces-4752-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3107DA2CC74
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Feb 2025 20:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D603AAA9E
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Feb 2025 19:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5981A262A;
	Fri,  7 Feb 2025 19:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JvGq8pOE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5C118DB0E;
	Fri,  7 Feb 2025 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738956058; cv=none; b=pGXojiCfd65CSAGgcE3vEkZcqZyhukNM0cKp6rUCc+u/XdeVjy4KDl5SS4y2ayP5xxfKPlMbdfGN/CJ2+9V/Td1dTudG6vOQNoU19qkhuTpS1fP/Wkh+M5XuIzQT48+Nx3NzWG+CoIMw6n2ON6lDr7Sm6BufUYvIU81aqonnHz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738956058; c=relaxed/simple;
	bh=MPOdjOsZq6P8+ZUOLvXCEU95PiamdoowEEV6uK8MWTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VorxpNifqQ9BR0Mx7EMQCavc8UL8lIE14KD+xXxayp7ACqon700jWM/r1+71OZqit9MnAvktr+lrVddayYaJjBfpFQJltjdbdjoRkio85dYWPZfJMbwC4Sb79qDxViE8OW9oMSRcC5eXuAVbj33d3kc6KbdYo6vvjcBHYKFgWWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JvGq8pOE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.64.61] (unknown [131.107.8.61])
	by linux.microsoft.com (Postfix) with ESMTPSA id CB5A02107306;
	Fri,  7 Feb 2025 11:20:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CB5A02107306
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738956056;
	bh=zdZ/uDQtZb8rk+qu5u0Z4m4Ap1sKgFkFGaXTq+duMqI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JvGq8pOEV0DjerwLjO87ymq3rSfWYanj6xtSiX++XRQgflsNRMWR6me86+9TXWzhp
	 4YVqiTb0mdXUHK8dOoZ8t0WSesAi+/zHZ69b7M6yjtUdxwKgRIDcKuvcch/nhd6qD/
	 VyzY5kPOdQccOJRDHSXj9B4DRfUsMYuTj54kJffU=
Message-ID: <3ef51a84-b300-49a3-87f1-b850c5978264@linux.microsoft.com>
Date: Fri, 7 Feb 2025 11:20:55 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/7] ima: define and call ima_alloc_kexec_file_buf
To: Mimi Zohar <zohar@linux.ibm.com>, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@HansenPartnership.com
References: <20250203232033.64123-1-chenste@linux.microsoft.com>
 <20250203232033.64123-2-chenste@linux.microsoft.com>
 <4d258641d36088b1a1239724a2951211159d81f0.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <4d258641d36088b1a1239724a2951211159d81f0.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/6/2025 8:49 AM, Mimi Zohar wrote:
> Thanks, Steven, for picking up and working on Tushar's patch set.
>
> I normally finish reviewing the patch set, before commenting.  In this case, there's
> a generic comment that relates to all of the patches.  It's also a way of letting you
> know that I've started reviewing the patch set.  The remaining comments will come
> after I finish reviewing the patch set.
>
> On Mon, 2025-02-03 at 15:20 -0800, steven chen wrote:
>> Carrying the IMA measurement list across kexec requires allocating a
>> buffer and copying the measurement records.  Separate allocating the
>> buffer and copying the measurement records into separate functions in
>> order to allocate the buffer at kexec 'load' and copy the measurements
>> at kexec 'execute'.
>>
>> This patch includes the following changes:
>>   - Refactor ima_dump_measurement_list() to move the memory allocation
>>     to a separate function ima_alloc_kexec_file_buf() which allocates
>>     buffer of size 'kexec_segment_size' at kexec 'load'.
>>   - Make the local variable ima_kexec_file in ima_dump_measurement_list()
>>     a local static to the file, so that it can be accessed from
>>     ima_alloc_kexec_file_buf(). Compare actual memory required to ensure
>>     there is enough memory for the entire measurement record.
>>   - Copy as many measurement events as possible.
>>   - Make necessary changes to the function ima_add_kexec_buffer() to call
>>     the above two functions.
>>   - Compared the memory size allocated with memory size of the entire
>>     measurement record. If there is not enough memory, it will copy as many
>>     IMA measurement records as possible, and this situation will result
>>     in a failure of remote attestation.
>>
>> Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> I understand you want to credit Tushar for the patch, but the mechanism is described
> in Documentation/process/submitting-patches.rst.  Refer to the paragraph on "Co-
> developed-by".  There is no tag named "Author".
>
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> "Suggested-by" goes before the Signed-off-by tag(s). "Reviewed-by" tag goes after
> your and/or Tushar's Signed-off-tag.
>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> Before the "Co-developed-by" tag was defined, it was implied simply by this ordering
> of the "Signed-off-by" tags.
>
> For those patches you didn't modify, simply import Tushar's patch with him as the
> author and add your Signed-off-by tag after his.
>
> thanks,
>
> Mimi

Thanks Mimi, will update it in next release.


