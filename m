Return-Path: <linux-integrity+bounces-3736-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D73559901BF
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Oct 2024 13:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E5F41F23255
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Oct 2024 11:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14401146D65;
	Fri,  4 Oct 2024 11:01:48 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D3712C81F;
	Fri,  4 Oct 2024 11:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728039708; cv=none; b=DKAWsjEGjWmORig86hA9MQyoMfOI3MgBICUrJI+Wie0po2AjMtlh1xHbkSAtdsK/XfL1Hi/4iaNQ60djmcmaxwCZDNP3e+deT4/25IKmTaPEWzPmud2VECaWceNPL7nxznKpXBk1o8ydoE65ht4wWnPua18blAJgCyehhFW1baw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728039708; c=relaxed/simple;
	bh=NtDsvusRx+fsiFebmXuORxX16ZxXymuvfEFFLg91cOE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=G7iRozRtflyPMoI43NvImWJJ3z7GSXkRiDwxiXZtynZckIGdsPcuy46HST5UqTj+sjgUXB5RY0Ok1dOTqONNmenZTPLQUoUKXiKwoJsRE6ua5fssDCO8jkEx+pd+GsrJ4HHgKekSJUdLrvikMSj3dPVx6yYDPzf9cvX4fG2pbVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4XKkx72wzVz9v7JQ;
	Fri,  4 Oct 2024 18:16:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 537F5140935;
	Fri,  4 Oct 2024 18:42:44 +0800 (CST)
Received: from [10.81.200.188] (unknown [10.81.200.188])
	by APP2 (Coremail) with SMTP id GxC2BwBH9saaxv9m_X80Ag--.35107S2;
	Fri, 04 Oct 2024 11:42:43 +0100 (CET)
Message-ID: <d5387ff4-06c7-4115-bd53-1c485e3743ec@huaweicloud.com>
Date: Fri, 4 Oct 2024 12:42:32 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/14] KEYS: Add support for PGP keys and signatures
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: dhowells@redhat.com, dwmw2@infradead.org, davem@davemloft.net,
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
 linux-crypto@vger.kernel.org, zohar@linux.ibm.com,
 linux-integrity@vger.kernel.org, roberto.sassu@huawei.com,
 linux-security-module@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
References: <ZuPDZL_EIoS60L1a@gondor.apana.org.au>
 <b4a3e55650a9e9f2302cf093e5cc8e739b4ac98f.camel@huaweicloud.com>
 <CAHk-=wiU24MGO7LZ1ZZYpQJr1+CSFG9VnB0Nyy4xZSSc_Zu0rg@mail.gmail.com>
 <ZuaVzQqkwwjbUHSh@gondor.apana.org.au>
 <CAHk-=wgnG+C3fVB+dwZYi_ZEErnd_jFbrkN+xc__om3d=7optQ@mail.gmail.com>
 <a991cf4187bced19485e28a5542ac446b92f864e.camel@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <a991cf4187bced19485e28a5542ac446b92f864e.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwBH9saaxv9m_X80Ag--.35107S2
X-Coremail-Antispam: 1UD129KBjvJXoWxur4xCFW5Jw4rGrW8CFyDZFb_yoW5XF13pa
	9aqFy2kr1kJr1Ik3Z7Ca18ZFWFyws3ta45Gr9xXryrA34YqF12yryfKF43ZFy2krn5Ga1j
	vrZ8try5A3Z8ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAGBGb-TvcIKQAAsC

On 9/26/2024 11:41 AM, Roberto Sassu wrote:
> On Sun, 2024-09-15 at 10:40 +0200, Linus Torvalds wrote:
>> On Sun, 15 Sept 2024 at 10:08, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>>>
>>> If the aformentioned EFI use-case is bogus, then distro package
>>> verification is going to be the only application for PGP keys in
>>> the kernel.
>>
>> So I haven't actually seen _that_ series, but as mentioned it does
>> smell pretty conceptually broken to me.
>>
>> But hey, code talks, bullshit walks. People can most certainly try to
>> convince me.
> 
> The solution has three parts.
> 
> 1. The kernel verifies the RPM header with a PGP key embedded in the
> kernel, and provided by the Linux distribution vendor.
> 
> 2. The Integrity Digest Cache parses the verified RPM header in the
> kernel and feeds one of the existing LSMs (IMA, IPE and BPF LSM) with
> the digests extracted from the RPM header.
> 
> 3. The LSMs compare the fsverity digest they find in the filesystem
> with the authenticated ones from the RPM header, and might deny access
> to the file if the digests don't match.
> 
> At this point, RPM headers don't contain fsverity digests, only file
> content digests, but this is an orthogonal problem.
> 
> 
> I had a look at previous threads on similar topics, to find your
> position on the matter.
> 
> I got that you would not be probably against (1), and maybe not (3).
> 
> However, we still need a source telling whether the fsverity digest in
> the filesystem is the same of one calculated by Linux distributions
> during build. That is what the Integrity Digest Cache provides.
> 
> Regarding (2), maybe I'm missing something fundamental, but isn't
> parsing the ELF format of kernel modules from the kernel similar?
> 
> Cannot really go to user space at this point, since the authenticated
> fsverity digests are directly consumed by LSMs. Also, as David pointed
> out in this thread [1], there is no obligation for user space to call
> any signature verification function before executing a file, this task
> must be done by an LSM.
> 
> I'm aware that we should not run unnecessary code in the kernel. I
> tried to mitigate this issue by striping the parsing functionality to
> the minimum (220 LOC), and formally verifying it with the Frama-C
> static analyzer. The parser is available here [2].
> 
> I'm also aware that this is not the long term solution, but I didn't
> find much support on the alternatives, like a trustworthy user mode
> driver [3][4] (isolated from other root processes) and signed eBPF
> programs [5].
> 
> What it would be the right way to proceed, in your opinion?

If I remove the parsers completely from the kernel, and attach them 
dynamically with eBPF, would you reconsider my patch set?

Thanks

Roberto


