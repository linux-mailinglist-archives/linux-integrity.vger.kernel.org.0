Return-Path: <linux-integrity+bounces-3593-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B40F979662
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 12:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2042B222B7
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 10:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA09E55B;
	Sun, 15 Sep 2024 10:52:11 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3756D184E;
	Sun, 15 Sep 2024 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726397530; cv=none; b=uN2txjkaqps+WOhsUmvaoeVhQOoC7NHYneDi24ZKi1mbiwlftVCjX2fJ1VY+MJt6YTJ4cczQ6X/HCdPKdzwxt2QRbAfndfNNbN1N8VoeVyOB958URa//fomcPYiEdrCC6rCP5PzFzwHGQWsHLt7chXt4Bdnv0HR005HG5qD+TP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726397530; c=relaxed/simple;
	bh=nTZPj6uwDfR1desg7EOtuQJmR6Ust8e7oYW8MzabxJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jzfuebfHmBF6C+oiKdEpN+pawumEZwWITJVWV6CoVm/SglgyW0nbuEpCejqBglPz3mGJlkCRBJGDWpdTEoEcDymzSSIS26nCosKRZDysdZlxfWnVrzKz8OExqvB4gSlc6AkCxUhhViC+1Fc72FCZfraOJlNivUGtnyJyCtGT6lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4X649h3KNzz9v7Hm;
	Sun, 15 Sep 2024 18:32:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 83D44140413;
	Sun, 15 Sep 2024 18:51:53 +0800 (CST)
Received: from [10.81.210.187] (unknown [10.81.210.187])
	by APP2 (Coremail) with SMTP id GxC2BwCX+clAvOZmO134AA--.24823S2;
	Sun, 15 Sep 2024 11:51:53 +0100 (CET)
Message-ID: <85f25b5f-cbf0-4032-9502-5fa0f7d07849@huaweicloud.com>
Date: Sun, 15 Sep 2024 12:51:39 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/14] KEYS: Add support for PGP keys and signatures
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, dhowells@redhat.com,
 dwmw2@infradead.org, davem@davemloft.net, linux-kernel@vger.kernel.org,
 keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, zohar@linux.ibm.com,
 linux-integrity@vger.kernel.org, roberto.sassu@huawei.com,
 linux-security-module@vger.kernel.org
References: <ZuPDZL_EIoS60L1a@gondor.apana.org.au>
 <b4a3e55650a9e9f2302cf093e5cc8e739b4ac98f.camel@huaweicloud.com>
 <CAHk-=wiU24MGO7LZ1ZZYpQJr1+CSFG9VnB0Nyy4xZSSc_Zu0rg@mail.gmail.com>
Content-Language: en-US
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <CAHk-=wiU24MGO7LZ1ZZYpQJr1+CSFG9VnB0Nyy4xZSSc_Zu0rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwCX+clAvOZmO134AA--.24823S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF1Uur48AFy7Cr1rXFWDJwb_yoW8trykpF
	Z5W3yDC3WkXF97CwnrKw47uw1F9ws3Ja15GF9xJ3s8A3W5Krn2kw12qr47Xa4qkws7CF12
	vrW5tryj93Z8ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAHBGbmQnQBnQAAso

On 9/15/2024 9:11 AM, Linus Torvalds wrote:
> On Fri, 13 Sept 2024 at 10:30, Roberto Sassu

[...]

> The objections I had were against the whole "start doing policy in
> kernel", with what sounded like actually parsing and unpacking rpm
> contents and verifying them with a pgp key. *That* still sounds like a
> disaster to me, and is the part that made me go "why isn't that done
> in user space together with then generating the fsverifty
> information"?

In my opinion, trusting root in this situation is not ideal. Trusting 
root means trusting all applications that root can run, that they will 
verify PGP signatures of fsverity digests with Linux distribution keys. 
In order to trust them, we would need to check the integrity of all 
those applications, in particular file read and IPC with the rest of the 
system.

A safer way to achieve the same goal is to let the kernel verify PGP 
signatures, assuming that the kernel is more privileged and cannot be 
tampered by root (for example, by using the 'lockdown' LSM). Since the 
PGP keys of the Linux distribution would be embedded in the kernel image 
(or certified by the embedded ones), trusting the system would require 
only to verify the kernel image itself (for example, with the boot loader).

Kernel-based policy enforcement is currently adopted by other LSMs, such 
as SELinux. SELinux also parses and enforces a policy sent from user 
space in the kernel. This does not mean that the policy itself is in the 
kernel, but that the kernel is the only component in the position of 
enforcing the policy without trusting all applications that root can run.

Roberto

> The argument that the kernel is the only part of the system you trust
> is bogus. The kernel does nothing on its own (apart from device
> enumeration etc of course), so if you have no trustworthy user space,
> then you might as well just give up entirely. At a *minimum* you have
> initrd, and that can then be the start of a chain of user space trust.
> 
> Parsing rpm files in the kernel really sounds horrendous. But that
> doesn't mean that I hate *this* series that just adds pgp key handling
> in case there are other valid uses for it.
> 
> But maybe I misunderstood the original suggestion from Roberto.
> 
>                Linus


