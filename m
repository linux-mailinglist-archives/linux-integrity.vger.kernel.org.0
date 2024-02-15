Return-Path: <linux-integrity+bounces-1233-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD811855AD4
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Feb 2024 07:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DB95B286AD
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Feb 2024 06:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0659476;
	Thu, 15 Feb 2024 06:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="b19pVT1E"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE0D610E
	for <linux-integrity@vger.kernel.org>; Thu, 15 Feb 2024 06:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707980156; cv=none; b=nfe88LroO4BiyUmZnlMPy9lyAZE9HIzM5fK8lMS3I0ianhlJtmd1a7A7omNASNQqgqLdq93aTjExTWCOosdSeQbK8sWTZtG8aXPkLcM0OvQN0oyXBTl59lmcuOcbpEM/7flrXrGZ1Gg52bdc3UsxX3O7zdfVzN527Gq5P/zGEvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707980156; c=relaxed/simple;
	bh=5iQwTjW+RXLGvmPYypiKxSgdDUwiJsld+1jEPYO/XzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jvc7l0vUyOTQG9tquXnZSYFTuDbq7DU4QeM8AQFX1iOiVSiSohbnN9gTx/wAjCsE71Q/TxY7uZD2HooznONsh//wYa3Yyj3KhJofCXiW2yRbgahqaN8f5DIZIV2njUD0m60Y7CRJ2oKCxZORkaEpmUlJfu/x+qN8l77qu8DmrfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=b19pVT1E; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id D5AE1207F228;
	Wed, 14 Feb 2024 22:55:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D5AE1207F228
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1707980155;
	bh=bkxc7nHkeBriUENd6669TjcMt9DOTF2AwIiWhyYhBKg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=b19pVT1E3P2KKBxgZ1knNnIE4LLIBCLZ//H+owN4eEy2ZRCFZRs+FgpcJlppFh60T
	 QC1zv+w6LlDyd4vqlaKOMAOnWIZP55983tE7x90WDqWN1pdHhcjkZFcVAx+XMPxFeS
	 G35fmV+/GEAnUboEO9rrFS2RGQp8QUAXmXS5eYe0=
Message-ID: <6c7158ef-2b12-4ba4-afc5-7618357d3aa4@linux.microsoft.com>
Date: Wed, 14 Feb 2024 22:55:54 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/8] ima: kexec: define functions to copy IMA log at
 soft boot
Content-Language: en-US
To: Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, noodles@fb.com,
 bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
 <20240214153827.1087657-5-tusharsu@linux.microsoft.com>
 <4189d465-dafc-4cf8-80d2-972f60bb6214@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <4189d465-dafc-4cf8-80d2-972f60bb6214@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/14/24 12:47, Stefan Berger wrote:
> 
> 
> On 2/14/24 10:38, Tushar Sugandhi wrote:
...
<snip/>
...
>> +void kimage_file_post_load(struct kimage *image)
>> +{
>> +    ima_kexec_post_load(image);
>> +}
>> +
> 
> We get this here at this point but it disappears later -- missing header?
> 
> kernel/kexec_file.c:189:6: warning: no previous prototype for 
> ‘kimage_file_post_load’ [-Wmissing-prototypes]
>    189 | void kimage_file_post_load(struct kimage *image)
>        |      ^~~~~~~~~~~~~~~~~~~~~
> 
> 
Thanks Stefan.
I was also getting it.
But couldn't figure out why. And I was puzzled why it was going away.

Since kimage_file_post_load() is called from the same file in patch 5/8,
I don't see a need of declaring it in a header file like 
include/linux/kexec.h.

Making kimage_file_post_load() local static resolves the warning.
But then it throws "defined but not used" warning. I will have to call 
it from kexec_file_load syscall in this patch (4/8) instead 5/8 to 
resolve that warning.

I will make the function a stub function in this patch and
make it call ima_kexec_post_load(image) in the next patch to avoid any 
potential bisect safe issues.

It aligns with the goals of patch 4/8 and 5/8 anyways.

+static void kimage_file_post_load(struct kimage *image)
+{
+	/*
+	 * this will call ima_kexec_post_load(image) to map the segment
+	 * and register the reboot notifier for moving the IMA log at
+	 * kexec execute
+	 */
+}
+


@@ -410,6 +410,9 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, 
int, initrd_fd,
         kimage_terminate(image);
+    if (!(flags & KEXEC_FILE_ON_CRASH))
+        kimage_file_post_load(image);
+

...
...<snip/>
...

> 
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Thanks for the tag. I will apply it on the next version.

~Tushar

