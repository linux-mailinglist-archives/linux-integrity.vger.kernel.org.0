Return-Path: <linux-integrity+bounces-4970-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 762A8A40196
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2025 22:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D3E166C59
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2025 21:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D7B255E25;
	Fri, 21 Feb 2025 21:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QrZAWW+W"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA870253F3F;
	Fri, 21 Feb 2025 21:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740171782; cv=none; b=Xaj0doQFZNrvqOXGNYnM/OjcjmKeZ2AkeMnt8vsK/Q1qJzj52W8MhXv2GPNiFh2V1mKX44B4Adh7zvLxzcaOv5oevmjVJqQ4uljq+m+4UV0R4J7e9l4lBt52l9czCTkjpKZlOWiOlOGagaXcpjvgAzedUToInqi4GZxUwfYUgOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740171782; c=relaxed/simple;
	bh=gXRIoaHEb4ahhX4SMbS7XTFTss9UrOqAcMI194HS5K8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N5gxAgFXkBe/H4rg3/KUrd02ErqRyk2CwQJ6cGdcebcEzlPC6cwr09dHYi7afWSUrBnSTTTqyR5o6mA5G95IW3+UXaVQqDoUenYErhnzoBNhfFcvDEBaRNt+x/GanprlHuJUd5GhvRjCCeQ2e9/c5FR5ecMwoAxQgzftmh3gJfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QrZAWW+W; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.64.59] (unknown [131.107.8.59])
	by linux.microsoft.com (Postfix) with ESMTPSA id C3AD82053679;
	Fri, 21 Feb 2025 13:02:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C3AD82053679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740171780;
	bh=q7qimWw3fn4gbEHfpk5d5zJg4X5BJznDEs8fnMd9NWU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QrZAWW+WlDUN2t1FYwRI+vhXC2SlIyYK0t/b7MF+3kKSdrBoY839/T9e5D3+y+wt+
	 Auc5gw+nuGbrsM87S9flV4lof9nA4Jb12ZAXHw4GPNRL6ojr1RWSxkWnR+F6RF42Sg
	 fnKvsKqbpJxDGL+KAz1FClIfYEGipGIyQGoWAXmI=
Message-ID: <0e82335b-ef66-46bf-a0b8-211e20fff77a@linux.microsoft.com>
Date: Fri, 21 Feb 2025 13:02:58 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/7] ima: define and call ima_alloc_kexec_file_buf
To: Mimi Zohar <zohar@linux.ibm.com>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 stefanb@linux.ibm.com, roberto.sassu@huaweicloud.com,
 roberto.sassu@huawei.com, eric.snowberg@oracle.com, ebiederm@xmission.com,
 paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
 linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com, bhe@redhat.com,
 vgoyal@redhat.com, dyoung@redhat.com
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
 <20250218225502.747963-2-chenste@linux.microsoft.com>
 <8023fa50a84817cc911a117db9bd3757c34fddfb.camel@linux.ibm.com>
 <58e70121aaee33679ac295847197c1e5511b2a81.camel@HansenPartnership.com>
 <241e6b5336d1dcee751cb35554e507e552563a16.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <241e6b5336d1dcee751cb35554e507e552563a16.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/20/2025 8:23 AM, Mimi Zohar wrote:
> On Thu, 2025-02-20 at 10:04 -0500, James Bottomley wrote:
>> On Thu, 2025-02-20 at 09:53 -0500, Mimi Zohar wrote:
>>> On Tue, 2025-02-18 at 14:54 -0800, steven chen wrote:
>> [...
>>>> Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>>> Steven, thank you again for picking up this patch set.
>>>
>>> As previously explained, there is no tag named "Author" in
>>> https://www.kernel.org/doc/Documentation/process/submitting-patches.rst
>>> .  To give credit to the original author use "Co-developed-by".
>> Just on this, only use the co-developed-by if you actually *modified*
>> the patch.  If you're just transmitting the patch unmodified you can
>> give original author credit by including a
>>
>> From: original author <email>
>>
>> Followed by a blank line at the beginning of the email.  That makes the
>> git author field contan whatever the From: line says.  You still need a
>> signoff from yourself in the original patch because you transmitted it.
>>
>> Some people also consider minor modifications to be insufficient to
>> disturb the original copyright ownership and simply document what they
>> did in square brackets under their signoff, like this:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b5d1e6ee761a109400e97ac6a1b91c57d0f6a43a
> Originally I had said:
>
>     > Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>     > Signed-off-by: steven chen <chenste@linux.microsoft.com>
>
>     Before the "Co-developed-by" tag was defined, it was implied simply by this ordering
>     of the "Signed-off-by" tags.
>     
>     For those patches you didn't modify, simply import Tushar's patch with him as the
>     author and add your Signed-off-by tag after his.
>
> Thanks, James, for the explanation of using "From: original author <email>" to force the
> author to be Tushar.
>
> Mimi

Thanks, I will update in next version.


