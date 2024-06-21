Return-Path: <linux-integrity+bounces-2909-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F65912D0D
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Jun 2024 20:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE5C9283F52
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Jun 2024 18:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4A41667CF;
	Fri, 21 Jun 2024 18:12:26 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1D51607A4
	for <linux-integrity@vger.kernel.org>; Fri, 21 Jun 2024 18:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718993546; cv=none; b=lB8K9bF5/WoH/GOVQlQ7ZEJXldit6aL7+HD68CxRiZDeh3+kDgeDghFpbXZ70Nui1DKXKQfVcTcOmFFHZzBTspiTj4i2mTiYvtVRKiUI7iYrQA2ptcUEz2BPyBcpv+fJ7FEckBcWoQuNUblQFz4XCFMq+YFCkFFNTWDkxeXqFNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718993546; c=relaxed/simple;
	bh=wrkaTMbWQ/Opvcmj6YE4KMwEj5XR4EzwSkFfeF1wSkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ssJXQFVifc2YkMtouSZ+FpixcdaGqpM3vVDdKgN+M0NyG2EwSThF8mZG/arfpUvvegJ2CcFFBwLnuH8BTad/uoCD6MKR/l5oJ4RgJoLwrCu9uXMECmmk59IcZp/Ya/wBoe8lb6Cah67t2WFMkFxvTDGPrmctNjEkMNfQYLXdrhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4W5Q3K1qYdz9v7Hk
	for <linux-integrity@vger.kernel.org>; Sat, 22 Jun 2024 01:54:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id D4D401402E0
	for <linux-integrity@vger.kernel.org>; Sat, 22 Jun 2024 02:12:04 +0800 (CST)
Received: from [10.204.63.28] (unknown [10.204.63.28])
	by APP1 (Coremail) with SMTP id LxC2BwDHIVFuwnVmC37eAA--.43270S2;
	Fri, 21 Jun 2024 19:12:04 +0100 (CET)
Message-ID: <6e2b6fc6-6bb6-4ae6-82ef-5d01c8bc7bb6@huaweicloud.com>
Date: Fri, 21 Jun 2024 20:11:57 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ] ima: fix buffer overrun in ima_eventdigest_init_common
To: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
 zohar@linux.ibm.com, roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com
Cc: eric.snowberg@oracle.com, linux-integrity@vger.kernel.org
References: <20240620194632.3996068-1-samasth.norway.ananda@oracle.com>
Content-Language: en-GB
From: Enrico Bravi <enrico.bravi@huaweicloud.com>
In-Reply-To: <20240620194632.3996068-1-samasth.norway.ananda@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwDHIVFuwnVmC37eAA--.43270S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF43GF45KF1UuryUGF1xKrg_yoW8XFy7pa
	1vga1jkF1DJFyfGFnxAa47tw4xW3yvkry7Gr45Gr1akr90qr1v9an3AryI9r4rGFW5AFyx
	twsIqryay3Wjya7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgvb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
	Ja73UjIFyTuYvjxUOyCJDUUUU
X-CM-SenderInfo: 5hquxuvroe2ttyl6x35dzhxuhorxvhhfrp/

On 6/20/2024 9:46 PM, Samasth Norway Ananda wrote:
> Function ima_eventdigest_init() can call ima_eventdigest_init_common()
> with HASH_ALGO__LAST which is then used to access the array
> hash_digest_size[] leading to buffer overrun. Have a conditional
> statement to handle this.
> 
> Fixes: 9fab303a2cb3 ("ima: fix violation measurement list record")
> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>

Tested-by: Enrico Bravi (PhD at polito.it) <enrico.bravi@huawei.com>

> ---
>   security/integrity/ima/ima_template_lib.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
> index 4183956c53af..14c000fe8312 100644
> --- a/security/integrity/ima/ima_template_lib.c
> +++ b/security/integrity/ima/ima_template_lib.c
> @@ -320,13 +320,17 @@ static int ima_eventdigest_init_common(const u8 *digest, u32 digestsize,
>   
>   	if (digest)
>   		memcpy(buffer + offset, digest, digestsize);
> -	else
> +	else {
>   		/*
>   		 * If digest is NULL, the event being recorded is a violation.
>   		 * Make room for the digest by increasing the offset by the
>   		 * hash algorithm digest size.
>   		 */
> -		offset += hash_digest_size[hash_algo];
> +		if (hash_algo < HASH_ALGO__LAST)
> +                        offset += hash_digest_size[hash_algo];
> +               else
> +                        offset += IMA_DIGEST_SIZE;
> +	}
>   
>   	return ima_write_template_field_data(buffer, offset + digestsize,
>   					     fmt, field_data);


