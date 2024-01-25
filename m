Return-Path: <linux-integrity+bounces-889-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E222383CBE5
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jan 2024 20:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 691B129BB57
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jan 2024 19:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB18C1339B7;
	Thu, 25 Jan 2024 19:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LQM31NQb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E26C6A005
	for <linux-integrity@vger.kernel.org>; Thu, 25 Jan 2024 19:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706209598; cv=none; b=dxFKDsl3j3GYjbS4+3b2OPTwxgNiryTuuEpo+cbtAAwq+qo6q/Hc85wm+ztDt8a3DF7/Ioe1xaXgLKDKNPh1VtMkAO3S5KpdYBZ2LcNeTPAC2Toc4IMh5xqnUnZuuoIrd6qO2hilA26mL1wVOlqITVSfcm1eja8XG+0/SuOyzp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706209598; c=relaxed/simple;
	bh=gF6W+BAy3FfnLOs3Kk71+3ZtbxB5cPbFO8Rj+l7r/5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uP5tkA1JPtrKLCNlvfJQ05icT9+olCGJHTdP0g/Cw208Rhb8IBH2IZz0HIrvUFqElOZBYs3bFDtNTKdtDfRYIBcEPVH+xqpUIjK8AbA8ZTCGb+LBT1FSpPvSpAG08AknXCkCtd9i7Jw6DKEMkDq8VZrAmVvPMeHozdIYRHTU6aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LQM31NQb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id AFAF920E56BC;
	Thu, 25 Jan 2024 11:06:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AFAF920E56BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706209596;
	bh=ye950e0unO0+Ln8d/jDNryrh84eW8VyNikpbfZLuGzc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LQM31NQbess+W8mxY2a3ZUu69AZIfqYp9kqSOZA0kGQhORFiihNtiKoJ2TTgjdRHT
	 +omHYAM+wQgrToP8AMh+1TlLHqpj5lK43GsskAc6AVNoHGM96OeuauwNd+40mIV3Dh
	 P/0q4HnzOXmvn7IhzJQCGMYuouzYhDG7nAsx+ywc=
Message-ID: <8eee667e-9e97-409f-864f-b4b25710d1ca@linux.microsoft.com>
Date: Thu, 25 Jan 2024 11:06:36 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] ima: kexec: move ima log copy from kexec load to
 execute
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huaweicloud.com,
 roberto.sassu@huawei.com, eric.snowberg@oracle.com, stefanb@linux.ibm.com,
 ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
 linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20240122183804.3293904-1-tusharsu@linux.microsoft.com>
 <20240122183804.3293904-5-tusharsu@linux.microsoft.com>
 <871a808d902bd6f1133b092a7b1924bcbba2ca6e.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <871a808d902bd6f1133b092a7b1924bcbba2ca6e.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/24/24 08:11, Mimi Zohar wrote:
> On Mon, 2024-01-22 at 10:38 -0800, Tushar Sugandhi wrote:
>> ima_dump_measurement_list() is called during kexec 'load', which may
>> result in loss of IMA measurements during kexec soft reboot.  It needs
>> to be called during kexec 'execute'.
>>
>> The below changes need to be part of the same patch to ensure this
>> patch series remains bisect-safe by ensuring the IMA log gets copied over
>> during kexec soft reboot both before and after this patch.
>>
>> Implement ima_update_kexec_buffer() to be called during kexec 'execute'.
>> Move ima_dump_measurement_list() from ima_add_kexec_buffer() to
>> ima_update_kexec_buffer().  Make the necessary variables local static to
>> the file, so that they are accessible during both kexec 'load' - where
>> the memory is allocated and mapped to a segment in the new Kernel, and
>> during 'execute' - where the IMA log gets copied over.
>>
>> Implement kimage_file_post_load() and ima_kexec_post_load() to be invoked
>> after the new Kernel image has been loaded for kexec.
>> ima_kexec_post_load() will map the IMA buffer to a segment in the newly
>> loaded Kernel.  It will also register the reboot notifier_block to trigger
>> ima_update_kexec_buffer() at exec 'execute'.
> 
> This defines two new IMA hooks - ima_kexec_post_load() and
> ima_update_kexec_buffer().  They shouldn't be hidden here in the move of copying
> the measurement list from kexec load to execute.
> 
> If "ima_update_kexec_buffer()" was initially defined as a stub function, the
> infrastructure could be set up ahead of time.  This patch could then be limited
> to just moving the copy from kexec "load" to "execute", by replacing the stub
> function with the real function.
> 
Agreed.  Making ima_kexec_post_load() and ima_update_kexec_buffer() as 
stubs/hooks did cross my mind.  Thanks for confirming that.

I will split this patch (4/7) into two.

First will define the stubs, setup the infrastructure.
And second will move the copy from 'load' to 'execute'.

~Tushar
>> Modify kexec_file_load() syscall to call kimage_file_post_load() after the
>> image has been loaded and prepared for kexec.  Call it only on kexec soft
>> reboot and not for KEXEC_FILE_ON_CRASH.
> 

