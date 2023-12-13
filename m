Return-Path: <linux-integrity+bounces-427-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AE2810BD2
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Dec 2023 08:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74836281736
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Dec 2023 07:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0E71A5A2;
	Wed, 13 Dec 2023 07:51:13 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71190BD;
	Tue, 12 Dec 2023 23:51:06 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4SqnPC144gz9y1y3;
	Wed, 13 Dec 2023 15:37:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 31E66140426;
	Wed, 13 Dec 2023 15:51:03 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwCnpV9gYnllQm9tAg--.42816S2;
	Wed, 13 Dec 2023 08:51:02 +0100 (CET)
Message-ID: <ecf524e0-b580-44c0-b64a-4b99da0615bf@huaweicloud.com>
Date: Wed, 13 Dec 2023 08:50:53 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add Roberto Sassu as co-maintainer to IMA
 and EVM
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231212152937.928126-1-zohar@linux.ibm.com>
 <20231212152937.928126-2-zohar@linux.ibm.com>
Content-Language: en-US
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <20231212152937.928126-2-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwCnpV9gYnllQm9tAg--.42816S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1UAF43Zw13Ar1DXFyrZwb_yoW8AF15pa
	yDWr45Cry0gr1xA3ZYgF43Aay5X3y8Jry7W3yDtw17ZasxG3Z09F4vk3WI9FykKr18KFWY
	yr9Igrn8uan8ZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAKBF1jj5OUXwACsn

On 12.12.23 16:29, Mimi Zohar wrote:
> Roberto Sassu has been actively involved in IMA and EVM since 2011.
> His first major IMA contribution was IMA template support.  He also
> contributed extending TPM 2.0 PCRs with properly calculated per TPM
> bank digests and included file metadata information in the IMA
> measurement list.
> 
> Regarding EVM, Roberto contributed to making EVM portable and immutable
> signatures more usable.  He also prepared the LSM infrastructure to
> support EVM as a fully fledged LSM, by ensuring that the latter receives
> from the former all xattrs provided by other registered LSMs at inode
> creation time, for HMAC calculation.
> 
> Roberto is currently working on making IMA and EVM full fledged LSMs.
> 
> Add Roberto as an IMA and EVM maintainer.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

Acked-by: Roberto Sassu <roberto.sassu@huawei.com>

Thanks

Roberto

> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 012df8ccf34e..ffaac404d1e0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7977,6 +7977,7 @@ F:	include/uapi/linux/ext4.h
>   
>   Extended Verification Module (EVM)
>   M:	Mimi Zohar <zohar@linux.ibm.com>
> +M:	Roberto Sassu <roberto.sassu@huawei.com>
>   L:	linux-integrity@vger.kernel.org
>   S:	Supported
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
> @@ -10554,6 +10555,7 @@ F:	drivers/crypto/inside-secure/
>   
>   INTEGRITY MEASUREMENT ARCHITECTURE (IMA)
>   M:	Mimi Zohar <zohar@linux.ibm.com>
> +M:	Roberto Sassu <roberto.sassu@huawei.com>
>   M:	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
>   L:	linux-integrity@vger.kernel.org
>   S:	Supported


