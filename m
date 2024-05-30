Return-Path: <linux-integrity+bounces-2716-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 283CE8D4624
	for <lists+linux-integrity@lfdr.de>; Thu, 30 May 2024 09:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB96C1F2217D
	for <lists+linux-integrity@lfdr.de>; Thu, 30 May 2024 07:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7D8176AD7;
	Thu, 30 May 2024 07:34:40 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02EA176AD1
	for <linux-integrity@vger.kernel.org>; Thu, 30 May 2024 07:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717054480; cv=none; b=GPUXXd1mUF3aDiYHUH9Slzb2V4vYWqwJ3SjOdMFv5KJoCL3LshseFORjua7r6uuse8abiCg8kr80/Ap7YecVewVGJkbjVF2aI2yUhrZeJGtiTG0umzXaYiMURrUJQmaje7gTFCUSbApJfeC0ogjWNG1z5przW3ZVI7SR78Obw3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717054480; c=relaxed/simple;
	bh=3eXXWrco9u/SWtwCtIoIq+S7kEzSLWVh3xy3bOLbCak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MSffpa0rOfmsrtHOFrAiuODBBCRdsGgfIhUKY/JT7ua9im11x9xSdYRGN0W09d5S+16iOmqM5ykSDV6U7ayd1S8Lcog+8mHpMA6A59ldm9MnLlUZBg5XE/DyS70DhMNWKghcc77kX5AmML51koMNJTy8rLVx+M3zb9Ra/B6vsI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Vqcrf1DLrz9v7JT
	for <linux-integrity@vger.kernel.org>; Thu, 30 May 2024 15:12:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id A00F614037F
	for <linux-integrity@vger.kernel.org>; Thu, 30 May 2024 15:34:23 +0800 (CST)
Received: from [10.48.130.175] (unknown [10.48.130.175])
	by APP2 (Coremail) with SMTP id GxC2BwCHwCT4K1hmW8UuCQ--.57860S2;
	Thu, 30 May 2024 08:34:23 +0100 (CET)
Message-ID: <7f851f47-ab5d-40bd-84a6-7fcb48490d7d@huaweicloud.com>
Date: Thu, 30 May 2024 09:34:09 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ima: fix wrong zero-assignment during securityfs dentry
 remove
Content-Language: en-US
To: Enrico Bravi <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org,
 zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, roberto.sassu@huawei.com
Cc: eric.snowberg@oracle.com
References: <20240529181432.494253-1-enrico.bravi@polito.it>
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <20240529181432.494253-1-enrico.bravi@polito.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwCHwCT4K1hmW8UuCQ--.57860S2
X-Coremail-Antispam: 1UD129KBjvJXoW7urW8AF1kKry8Jw47JFy5Jwb_yoW8Zw4rpa
	1aqa48Cr1rJayxGwn7CanrGa1Sy3yrWF45GwsxGw1vy3ZxZry09rZ3Cr1jkrn0qF4jqF1v
	qw17trsIywnrtaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU189N3UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgATBF1jj5nAZAABsY

On 5/29/2024 8:14 PM, Enrico Bravi wrote:
> In case of error during ima_fs_init() all the dentry already created
> are removed. {ascii, binary}_securityfs_measurement_lists are freed
> calling for each array the remove_securityfs_measurement_lists(). This
> function, at the end, assigns to zero the securityfs_measurement_list_count.
> This causes during the second call of remove_securityfs_measurement_lists()
> to leave the dentry of the array pending, not removing them correctly,
> because the securityfs_measurement_list_count is already zero.
> 
> Move the securityfs_measurement_list_count = 0 after the two
> remove_securityfs_measurement_lists() calls to correctly remove all the
> dentry already allocated.
> 
> Fixes: 9fa8e7625008 ("ima: add crypto agility support for template-hash algorithm")
> Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>

Looks good to me.

Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>

Thanks

Roberto

> ---
>   security/integrity/ima/ima_fs.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> index abdd22007ed8..e4a79a9b2d58 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -427,8 +427,6 @@ static void __init remove_securityfs_measurement_lists(struct dentry **lists)
>   
>   		kfree(lists);
>   	}
> -
> -	securityfs_measurement_list_count = 0;
>   }
>   
>   static int __init create_securityfs_measurement_lists(void)
> @@ -625,6 +623,7 @@ int __init ima_fs_init(void)
>   	securityfs_remove(binary_runtime_measurements);
>   	remove_securityfs_measurement_lists(ascii_securityfs_measurement_lists);
>   	remove_securityfs_measurement_lists(binary_securityfs_measurement_lists);
> +	securityfs_measurement_list_count = 0;
>   	securityfs_remove(ima_symlink);
>   	securityfs_remove(ima_dir);
> 
> base-commit: e0cce98fe279b64f4a7d81b7f5c3a23d80b92fbc


