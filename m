Return-Path: <linux-integrity+bounces-3601-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AD49797F7
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 19:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8FBEB2141F
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 17:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709E81C9874;
	Sun, 15 Sep 2024 17:52:46 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BA01C579C;
	Sun, 15 Sep 2024 17:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726422766; cv=none; b=U8FFd80wS3NQtogFuhcSHQz6n/hPc14HSIUEW7thp8yFVT5+QbA0f3h8dHJip2Alr7sQD597yaZmZ5hmNUZrmf/EhZ5M1xV9GdslNRshp/W6u6iWtLdL362YdPVloaHiJy/QYm4BMxv48lvkigeANPE+G3Cpv9dnd/dRy4A6nTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726422766; c=relaxed/simple;
	bh=ZZlK3V802zzOLTPZYT2VYgsot0+Pl9FAceSF6jAj7rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jjyggbLFf/LFHhoECXoWvZPXhgjHSbSUo39mZketjfx2y4Z87xM6BOI5OLGoxPQJ9lNi/jbOrMWKK3F3osxjiBv+JO391rgM5F6YtUNj8gOpvkwBB67VGwm0DSr1idGRC6QonUVGap0B45TGJXromthTSC0n4crkCZBg8dMb8Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4X6FNL6612z9v7JY;
	Mon, 16 Sep 2024 01:27:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 9D6BB140590;
	Mon, 16 Sep 2024 01:52:28 +0800 (CST)
Received: from [10.81.201.197] (unknown [10.81.201.197])
	by APP2 (Coremail) with SMTP id GxC2BwCnVsfQHudm9DD9AA--.26858S2;
	Sun, 15 Sep 2024 18:52:27 +0100 (CET)
Message-ID: <2541abb8-68b5-4e6a-b309-a001ecdfbea1@huaweicloud.com>
Date: Sun, 15 Sep 2024 19:52:13 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/14] KEYS: Add support for PGP keys and signatures
To: Herbert Xu <herbert@gondor.apana.org.au>,
 Linus Torvalds <torvalds@linux-foundation.org>
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
 <ZualreC25wViRHBq@gondor.apana.org.au> <ZuapXswFUxsFxjgH@gondor.apana.org.au>
Content-Language: en-US
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <ZuapXswFUxsFxjgH@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwCnVsfQHudm9DD9AA--.26858S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtrWrGF1xCrWrWw17Ar4ktFb_yoW3XrcEkF
	95Aa48Jws5GF40yanayF4j9rZ3Kr1UAFyFq3Z5XrWfu34fJrsayws3GryrZw1kAFsavrZr
	Ga4qv3W2q3Z0qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267
	AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAwI
	DUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAHBGbmQnQGRgABs1

On 9/15/2024 11:31 AM, Herbert Xu wrote:
> On Sun, Sep 15, 2024 at 05:15:25PM +0800, Herbert Xu wrote:
>>
>> Roberto, correct me if I'm wrong but your intended use case is
>> the following patch series, right?
> 
> Actually the meat of the changes is in the following series:
> 
> https://lore.kernel.org/linux-integrity/20240905150543.3766895-1-roberto.sassu@huaweicloud.com/

Yes, correct. The idea is to verify the authenticity of RPM headers, 
extract the file digests from them, and use those file digests as 
reference values for integrity checking of files accessed by user space 
processes.

If the calculated digest of a file being accessed matches one extracted 
from the RPM header, access is granted otherwise it is denied.

Roberto


