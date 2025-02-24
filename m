Return-Path: <linux-integrity+bounces-4982-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5462EA4307D
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Feb 2025 00:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 961033B26F0
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Feb 2025 23:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A0E1E1C2B;
	Mon, 24 Feb 2025 23:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BewR2QQb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4AC1A9B23;
	Mon, 24 Feb 2025 23:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740438340; cv=none; b=byjwKjjzqgABXQXg3vEQYFtKYxHjMf/rETy7wK2kFZfug11l8OuH5TyNw46Z+xMLLXJhAATNLhW/ikJclBEz+JKzZ1b7i2LVTvInf4wU+8puvMOIB5xrcHmZ29KaA4dwr/vBoFCuysUTei+HKlRvzSz+jBzwNYyaltMNUTLN/kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740438340; c=relaxed/simple;
	bh=aFQQ3iUfB4dAwZ+pfOVo4hd1+yzZJrpmP2cav/P/IO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BMNrC50kb6eZ9DPrA/1+49zoXAf7ojzg/zEridfIfHC0s+1h0X2bug+GaCOIYPWNWF3ll3nZjzP7z3SHuNaTpU4ThEDpmscjtkskKjMXt94wuDJ2e7HqzdFh1pe+HWd3GE24n+TxOt7Km6lVriMzQRdo1DsiNxn3EDvsdP+PDkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BewR2QQb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.64.108] (unknown [131.107.147.236])
	by linux.microsoft.com (Postfix) with ESMTPSA id BFBC0203CDE5;
	Mon, 24 Feb 2025 15:05:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BFBC0203CDE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740438338;
	bh=9MyoYHOlezsCiyRipc+Ai3jbgANrCAW1Nz/SR6iLSG0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BewR2QQbanLDaGC2OZXUdPzQXUx3togJgoyfFUuDpnJwJqJJ2repwj7aieQhfPKSG
	 J1bvIr72exvJ1CEo3AAcEbFCl8ZtZPlrF1tzM1ZoTby97pRhA5epMNkg4Fkco6kYG+
	 xBKe8llQLbWED05MRZi3Bt/Zs2JAeaU0RiKFNZT0=
Message-ID: <658b52e4-a4bb-40fc-a00b-bfdb3bf15b52@linux.microsoft.com>
Date: Mon, 24 Feb 2025 15:05:37 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/7] kexec: define functions to map and unmap segments
To: Baoquan He <bhe@redhat.com>
Cc: zohar@linux.ibm.com, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
 nramas@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
 vgoyal@redhat.com, dyoung@redhat.com
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
 <20250218225502.747963-3-chenste@linux.microsoft.com>
 <Z7wOPiDfy/vtrkCS@MiWiFi-R3L-srv>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <Z7wOPiDfy/vtrkCS@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/23/2025 10:14 PM, Baoquan He wrote:
> Hi Steve, Mimi,
>
> On 02/18/25 at 02:54pm, steven chen wrote:
>> Currently, the mechanism to map and unmap segments to the kimage
>> structure is not available to the subsystems outside of kexec.  This
>> functionality is needed when IMA is allocating the memory segments
>> during kexec 'load' operation.  Implement functions to map and unmap
>> segments to kimage.
> I am done with the whole patchset understanding. My concern is if this
> TPM PCRs content can be carried over through newly introduced KHO. I can
> see that these patchset doesn't introduce too much new code changes,
> while if many conponents need do this, kexec reboot will be patched all
> over its body and become ugly and hard to maintain.
>
> Please check Mike Rapoport's v4 patchset to see if IMA can register
> itself to KHO and do somthing during 2nd kernel init to restore those
> TPM PCRs content to make sure all measurement logs are read correctly.
> [PATCH v4 00/14] kexec: introduce Kexec HandOver (KHO)
>
> Thanks
> Baoquan

Hi Baoquan,

For IMA, it appears that there are no current issues with TPM PCRs after 
a kernel soft reboot.

This patches is used to get currently missed IMA measurements during the 
kexec process copied to new kernel after the kernel soft reboot. I think 
it's ok to leave it at current location: it will be easy to maintain for 
IMA.

Overall, for these patches, do you see any major blockers for kexec?

If you have any specific concerns or need further details, please let me 
know.

Thanks,

Steven

