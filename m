Return-Path: <linux-integrity+bounces-5943-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E171A947D5
	for <lists+linux-integrity@lfdr.de>; Sun, 20 Apr 2025 14:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A01447A1E29
	for <lists+linux-integrity@lfdr.de>; Sun, 20 Apr 2025 12:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F261EB1A6;
	Sun, 20 Apr 2025 12:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Sz1r5ZgH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80751E8345;
	Sun, 20 Apr 2025 12:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745151675; cv=none; b=fSNW6uk30LYRokYiqxRc/mC4zPZrZIxVT8EGS6Weow8uJ4u3ifVDRVGpX54Vcd+ktVv3J5/sk+cpXl0nTrPAiB5y7/iwnyVDvgg/NTFU28bE290MVR77nbZhwZkH/wldAyFKCRHFa56fW1trhOgXgfdcUDkPoWID9b2ViOVLTdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745151675; c=relaxed/simple;
	bh=gDbNQmIpjQjvi5QlsicHvs9bBNUrMobgSBRIvWLTCyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uAIhjB7dm13GEILTd7J0+O1KMeggcz4ICr2nwKkt45TnXAS8Ca0Q2uSZjDgVzzu9BArUecehMgVt2npQ7/Zf6rZLi9o/7vliL058N/1mIwp6klQxlnBcOFv4Ds27F/SWecK+Y2h35MWmi3//kF3NHlU0hZbHxyDuFSBWwOA8AXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Sz1r5ZgH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.70.200.26] (unknown [20.110.218.7])
	by linux.microsoft.com (Postfix) with ESMTPSA id 715EB2052525;
	Sun, 20 Apr 2025 05:21:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 715EB2052525
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745151666;
	bh=S6B7H0sl7eejbWsBOT80A+X1SXdpkkOS21qiU9XGhAk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Sz1r5ZgH0eN5ZQZi7sPpR/CBz3lY2fwwK1tGF11xyRv9VXMM4keeCkkT+/63Xjyo6
	 iwy5a0ddelImoGAxwDn23U1B49quNLup2fRwlaEM8wN5rzdeSNgrYzBXwqcSfpwIZO
	 u7S4cLaCowM7K0ri1YvGiXIdginhNQnMhGhxqKIk=
Message-ID: <b786b537-19e0-497c-b32f-c9df6e88e6b9@linux.microsoft.com>
Date: Sun, 20 Apr 2025 05:21:02 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 0/9] ima: kexec: measure events between kexec load and
 execute
To: Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@HansenPartnership.com, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com
References: <20250416021028.1403-1-chenste@linux.microsoft.com>
 <4a2f7fde-99ee-4bcd-a97d-fe0db418fd5f@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <4a2f7fde-99ee-4bcd-a97d-fe0db418fd5f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/16/2025 6:09 PM, Stefan Berger wrote:
>
>
> On 4/15/25 10:10 PM, steven chen wrote:
>> From: Steven Chen <chenste@linux.microsoft.com>
>>
>> The current kernel behavior is IMA measurements snapshot is taken at
>> kexec 'load' and not at kexec 'execute'.  IMA log is then carried
>> over to the new kernel after kexec 'execute'.
>>
>> Currently, the kernel behavior during kexec load is to fetch the IMA
>> measurements log from TPM PCRs and store it in a buffer. When a kexec
>> reboot is triggered, this stored log buffer is carried over to the 
>> second
>> kernel. However, the time gap between kexec load and kexec reboot can be
>> very long. During this time window, new events extended into TPM PCRs 
>> miss
>> the chance to be carried over to the second kernel. This results in
>> mismatch between TPM PCR quotes and the actual IMA measurements list 
>> after
>> kexec soft reboot, which in turn results in remote attestation failure.
>
> Tested-by: Stefan Berger <stefanb@linux.ibm.com> # ppc64/kvm

Hi Stefan,

Thank you very much!

Steven


