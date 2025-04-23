Return-Path: <linux-integrity+bounces-6006-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFA5A992EF
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Apr 2025 17:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B96D1B88045
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Apr 2025 15:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B2328EA4C;
	Wed, 23 Apr 2025 15:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VKe3aNkW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC28A290BC4;
	Wed, 23 Apr 2025 15:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422190; cv=none; b=hpe2rg79W3D5Il4kJZRgOYJWpAwIhqvjAEHmFK/R1CwaTIuJ+iTIEPD8/OHs0vzriIi7j3r2Pqcjf3nLt0ELKyIIJeAoTi4UGeak7x2kbA921xXfEsxJiOE4AkenF56tXjbvuNCYdbe2fVXMgTyv0GVDtb8SqMh4GvYvd3/8tWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422190; c=relaxed/simple;
	bh=mTnOEvztkfKLWsBS8tmmBTk1Hq32rvvAP+K2zR/06Go=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DBrzFV1cBRcmgHcFcOTEAi/nNGD5ZrQhQdRIxDjgsxV8dHfrUBt/V+RC0x8p1uI2SWYcfkWgQL4ekVYw5I7Yqmz9QPY8MHI+CuuzpVy9K5+jHZxBFcVE5GRoYe5SmLhiAUi03muVIYNIkZqPX7vvcpPwaiIRXhRfMdnw7rE1eYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VKe3aNkW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.70.64.216] (unknown [172.172.34.12])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0A9E6211308D;
	Wed, 23 Apr 2025 08:29:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0A9E6211308D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745422188;
	bh=LC7pkHihs4T9XyOd3vElvpj55QuaAXTM1TekQVBmxmM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VKe3aNkWdbI858tuCCCibH52jv6/KugZ24rss+dWKHRXrezKFC7/K1lhGJbWzMwlP
	 h7CQC44Hl5LjBE4wXv/dNphwSp55Nt50mVpImBvZw0JVs8TH7j3dS1RpMVoxu4TEYs
	 OVmQHglqmVS7WgCKhYndQ95NNmWxb5ogldgZJYiM=
Message-ID: <99e18151-2866-4646-8532-3d10d63279b9@linux.microsoft.com>
Date: Wed, 23 Apr 2025 08:29:43 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 3/9] kexec: define functions to map and unmap segments
To: Mimi Zohar <zohar@linux.ibm.com>, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@HansenPartnership.com, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com
References: <20250421222516.9830-1-chenste@linux.microsoft.com>
 <20250421222516.9830-4-chenste@linux.microsoft.com>
 <f2f4a873489b28d3baa4ac1f6073a49fe888d120.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <f2f4a873489b28d3baa4ac1f6073a49fe888d120.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/22/2025 5:29 PM, Mimi Zohar wrote:
> On Mon, 2025-04-21 at 15:25 -0700, steven chen wrote:
>> From: Steven Chen <chenste@linux.microsoft.com>
>>
>> Implement kimage_map_segment() to enable IMA to map the measurement log
>> list to the kimage structure during the kexec 'load' stage. This function
>> gathers the source pages within the specified address range, and maps them
>> to a contiguous virtual address range.
>>
>> This is a preparation for later usage.
>>
>> Implement kimage_unmap_segment() for unmapping segments using vunmap().
>>
>> Cc: Eric Biederman <ebiederm@xmission.com>
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: Vivek Goyal <vgoyal@redhat.com>
>> Cc: Dave Young <dyoung@redhat.com>
>> Co-developed-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> Checkpatch.pl is complaining that the Signed-off-by tag does not matches the
> "From:" line only on this patch.  I've updated your Signed-off-by tag to match
> the "From:" line above.
>
>> Acked-by: Baoquan He <bhe@redhat.com>
> Missing from v13 is Stefan's Tested-by tag.  As the code hasn't changed, I've
> added it.  In the future, please don't forget to add the tags.
>
> Stefen Berger spent quite a bit of time reviewing this patch set, but with v13
> most of his Reviewed-by tags are missing. Stefan?
>
> For now the patch set is staged in the next-integrity-testing branch.
>
> thanks,
>
> Mimi

Hi Mimi,

Could you help to add
Tested-by tag for this patch set: "Tested-by: Stefan Berger 
<stefanb@linux.ibm.com> # ppc64/kvm"
Reviewed-by tags "Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>" to 
patch 1, 5, 6, 9.

Thanks a lot.

Hi Stefen,

Thanks for your help all the time and sorry missing tags to show your work.

Sorry again,

Steven


