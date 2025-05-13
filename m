Return-Path: <linux-integrity+bounces-6192-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031E2AB589D
	for <lists+linux-integrity@lfdr.de>; Tue, 13 May 2025 17:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6A273A26B0
	for <lists+linux-integrity@lfdr.de>; Tue, 13 May 2025 15:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5BC1487FE;
	Tue, 13 May 2025 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XOKUeYrS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108E8383;
	Tue, 13 May 2025 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747150275; cv=none; b=cb4pZx0d2ikDJ88gLTKaFC9frf2/uVDwL5c0RJXBOmWu74QCp9khmRsf1UHJOlp6u/GwzMhlJEz+kLful4f1v+fSqFFh+MpjKos3QIOW3bI7uY9sC19oxjoofPsLSfBkfiJwLS3Q7o2rUjBvfHd5mFPuGGdlWRxDH5vteQzLq00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747150275; c=relaxed/simple;
	bh=Y9RPGzLmrUiEcchYpmRDbjr7mMuYIu/wlN9gxwkC/4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BL7j95TNVE1MURNVnGIMJDdLMxZMo35MEUJmdAIPA4osL61ssSJ0MLepZnM7RQVJymjd7ZVdpH6zBjZh8npH/+TOoDhlIqK0dljp7XYblB3+2bgyCRyIQ8rj06RAJI/d0iTT61KMtiDaXetdj98VvHKikAPXTlsU5AV5e6jtDds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XOKUeYrS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.70.65.85] (unknown [20.230.14.159])
	by linux.microsoft.com (Postfix) with ESMTPSA id AAE6E201DB14;
	Tue, 13 May 2025 08:31:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AAE6E201DB14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747150273;
	bh=Y9RPGzLmrUiEcchYpmRDbjr7mMuYIu/wlN9gxwkC/4A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XOKUeYrSVMAsfifIegp/YsbM7SdcAo9hKsJLPyjC3hRsq+LnYpGnXph1jbd+OYTOj
	 9c4h+8Ejp9LvH8K2l7W6xB98Ss2TQVVF7VJs2x1I6GDGptgWeM2iugJVKNwP7kult2
	 7lXoDBsVRKUZ+bsnayWvQMgVeb1WDyZfFkxZ+QMQ=
Message-ID: <7d1b7bea-e85a-474f-85d2-1a0ce27d2044@linux.microsoft.com>
Date: Tue, 13 May 2025 08:31:10 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ima: Kdump kernel doesn't need IMA to do integrity
 measurement
To: Mimi Zohar <zohar@linux.ibm.com>, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@HansenPartnership.com, bhe@redhat.com
References: <20250502200337.6293-1-chenste@linux.microsoft.com>
 <71973027bb0fbc436a95e8bb7fbd2b7d2eab95b4.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <71973027bb0fbc436a95e8bb7fbd2b7d2eab95b4.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/13/2025 4:41 AM, Mimi Zohar wrote:
> Hi Steven,
>
> On Fri, 2025-05-02 at 13:03 -0700, steven chen wrote:
>> From: Steven Chen <chenste@linux.microsoft.com>
>>
>> Kdump kernel doesn't need IMA to do integrity measurement.
>> Hence the measurement list in 1st kernel doesn't need to be copied to
>> kdump kenrel.
> ^kernel
>
> Please use "scripts/checkpatch.pl --codespell" to check for typos.
>
> Mimi
Will update. Thanks!
>> Here skip allocating buffer for measurement list copying if loading
>> kdump kernel. Then there won't be the later handling related to
>> ima_kexec_buffer.
>>
>> Signed-off-by: Steven Chen <chenste@linux.microsoft.com>



