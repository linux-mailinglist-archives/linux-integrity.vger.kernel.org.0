Return-Path: <linux-integrity+bounces-5098-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ACDA4F31D
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 01:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8387188FBDF
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 00:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957337FBA2;
	Wed,  5 Mar 2025 00:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Xq4Wif5f"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EC37083F;
	Wed,  5 Mar 2025 00:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741136239; cv=none; b=MceP3fym/iPNartbstV4q2hhnMivtHRP3JCpPkfPb+KGsvw0hgN1NvBjVhEhBPlvs1UMqfexqkmRCQ0aUaD/aC/qyJOMikeWopiDi9x//LZBnTDaq4JpWh8J+JZX4LDKju3p4jowKIih+OX+Izd6CXiQUuOI78V2yZ0spZWL88I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741136239; c=relaxed/simple;
	bh=Cw16+QQ1NI7Erh4T6tWyLbvcSyeQSbBID6VO+V5dBDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dUkIBe4+ZA8wSBokwNAI+hcIo/UUF3gTKly2n3M/pYwpRf4j1Fmu/ke32sqV8XRoUzMEqtdUddYJ3cmnQo2aaF1yUJa8j+LvEfRVgj01jwyKbi5ERN2X/Ivnr4Cd4x1pG1cFsJCxqG81VeFfpOarHedHkhFyRucv64/DYritpfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Xq4Wif5f; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.64.124] (unknown [131.107.8.124])
	by linux.microsoft.com (Postfix) with ESMTPSA id 49D90210EAF8;
	Tue,  4 Mar 2025 16:57:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 49D90210EAF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741136237;
	bh=u9vQn02/NSDQfKQiARKmi0huzx7fugITS4b2YeoInKQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Xq4Wif5fdHC2k1tO26664vgomhoS0IDrsqqB+zG+wRaMsb68EkOJjwuyYOSFL6gQB
	 50NFwYoChZbRG0s8O25HsHex7q652dcWhgMIIiMlO2dknDD9NMdI7rVLSQfiOzVnVa
	 2qF7djP4plkm8kN7DBQWU1iFnssRYaQ8yr9tJlp8=
Message-ID: <0dadaf7d-c607-43c9-9e82-1decfac0d545@linux.microsoft.com>
Date: Tue, 4 Mar 2025 16:57:16 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 7/7] ima: measure kexec load and exec events as
 critical data
To: Mimi Zohar <zohar@linux.ibm.com>, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@HansenPartnership.com, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com
References: <20250304190351.96975-1-chenste@linux.microsoft.com>
 <20250304190351.96975-8-chenste@linux.microsoft.com>
 <330dbd19bf0c0fbf34908d4629cbcc548eb9c254.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <330dbd19bf0c0fbf34908d4629cbcc548eb9c254.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/2025 4:25 PM, Mimi Zohar wrote:
> Hi Steven,
>
> On Tue, 2025-03-04 at 11:03 -0800, steven chen wrote:
>> +void ima_measure_kexec_event(const char *event_name)
>> +{
>> +	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
>> +	size_t buf_size = 0;
>> +	long len;
>> +
>> +	buf_size = ima_get_binary_runtime_size();
>> +	len = atomic_long_read(&ima_htable.len);
>> +
>> +	int n = scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
>> +					"kexec_segment_size=%lu;ima_binary_runtime_size=%lu;"
>> +					"ima_runtime_measurements_count=%ld;",
>> +					kexec_segment_size, buf_size, len);
> Variables should not be defined inline, but at the beginning of the function.
> After doing that, scripts/checkpatch.pl complains about the formatting.
>
> Mimi

Hi Mimi,

I will update it in next release.

Thanks,

Steven

>> +
>> +	ima_measure_critical_data("ima_kexec", event_name, ima_kexec_event, n, false, NULL, 0);
>> +}
>> +



