Return-Path: <linux-integrity+bounces-7519-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E650FC049A5
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Oct 2025 09:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AFE41A654FA
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Oct 2025 07:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEE31FF7BC;
	Fri, 24 Oct 2025 07:02:26 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D60215E8B;
	Fri, 24 Oct 2025 07:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761289346; cv=none; b=KQH+8giHbDJ1T8m3NHAl07YzcNUqA4gclrQTUEQQhNjA4AQ7h+WSTLjJ0W6Kt7jzaFPyfXIQ8ikNl14almXwrBV6eDiGdZVqHfpzQan3s802It0clXkjqCQJ9rb86dJ4qkou+sY2UkSLysUz9UpTFSqRJLlwNOgxBfy/iVOB8K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761289346; c=relaxed/simple;
	bh=VFtpABJWPa4CNfNSsUoEbgpiJe037EVLlKY9pkg3Ktk=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=loqVx/u6dqe6TGmXaqRdna7DRpSdozv2K2Nt1TP5PhJNPEMvfOpw9fy/pH87LhC2jU6E+Jk+85yFJm2B+4W1qwmgThS05asMub5fTAfIpSl+x8LNNZlrt/gTSl9LZiVLBpnG0XKW+bG5xr8v3cB6QuC1Kzj4HQ0ipFz3ZaP2tbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ctDMd2gb5zYQtwJ;
	Fri, 24 Oct 2025 15:01:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 92AA81A0AD1;
	Fri, 24 Oct 2025 15:02:14 +0800 (CST)
Received: from [10.174.178.185] (unknown [10.174.178.185])
	by APP2 (Coremail) with SMTP id Syh0CgDnPUZwJPtoNGC5BQ--.15047S3;
	Fri, 24 Oct 2025 15:02:14 +0800 (CST)
Subject: Re: [PATCH] KEYS: fix compilation warnings in the dump_options()
 function
To: a.fatoum@pengutronix.de, kernel@pengutronix.de,
 James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
 zohar@linux.ibm.com, dhowells@redhat.com, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com, linux-integrity@vger.kernel.org,
 keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
 yebin10@huawei.com
References: <20251024061153.61470-1-yebin@huaweicloud.com>
From: yebin <yebin@huaweicloud.com>
Message-ID: <68FB2470.4000206@huaweicloud.com>
Date: Fri, 24 Oct 2025 15:02:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251024061153.61470-1-yebin@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDnPUZwJPtoNGC5BQ--.15047S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uF15Cr4UAr4UurWkKrW7urg_yoW5JrWUpa
	1jkFyjqrW0yF9Fg3yUGr4kAryfCwn8KFW7Gws7tayYgFnxJ347Xa4Uur43ur17ZFyIgryj
	va4jvr1Fg3yq9r7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUrPEfUUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

Ignore this patch as 275a9a3f9b6a（“KEYS: trusted: Pass argument by 
pointer in dump_options”）already fix this issue.

On 2025/10/24 14:11, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
>
> There's issue as follows:
> security/keys/trusted-keys/trusted_caam.c: In function ‘dump_options’:
> security/keys/trusted-keys/trusted_caam.c:37:20: note: the ABI of passing struct with a flexible array member has changed in GCC 4.4
>     37 | static inline void dump_options(struct caam_pkey_info pkey_info)
>        |                    ^~~~~~~~~~~~
>
> To solve the above problem, pass 'struct caam_pkey_info*' type parameter
> to the dump_options() function.
>
> Fixes: 9eb25ca6c973 ("KEYS: trusted: caam based protected key")
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>   security/keys/trusted-keys/trusted_caam.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/security/keys/trusted-keys/trusted_caam.c b/security/keys/trusted-keys/trusted_caam.c
> index 090099d1b04d..dd7a69bcf6a3 100644
> --- a/security/keys/trusted-keys/trusted_caam.c
> +++ b/security/keys/trusted-keys/trusted_caam.c
> @@ -29,12 +29,12 @@ static const match_table_t key_tokens = {
>   };
>
>   #ifdef CAAM_DEBUG
> -static inline void dump_options(struct caam_pkey_info pkey_info)
> +static inline void dump_options(struct caam_pkey_info *pkey_info)
>   {
> -	pr_info("key encryption algo %d\n", pkey_info.key_enc_algo);
> +	pr_info("key encryption algo %d\n", pkey_info->key_enc_algo);
>   }
>   #else
> -static inline void dump_options(struct caam_pkey_info pkey_info)
> +static inline void dump_options(struct caam_pkey_info *pkey_info)
>   {
>   }
>   #endif
> @@ -108,7 +108,7 @@ static int trusted_caam_seal(struct trusted_key_payload *p, char *datablob)
>   		ret = get_pkey_options(datablob, &info.pkey_info);
>   		if (ret < 0)
>   			return 0;
> -		dump_options(info.pkey_info);
> +		dump_options(&info.pkey_info);
>   	}
>
>   	ret = caam_encap_blob(blobifier, &info);
> @@ -140,7 +140,7 @@ static int trusted_caam_unseal(struct trusted_key_payload *p, char *datablob)
>   		ret = get_pkey_options(datablob, &info.pkey_info);
>   		if (ret < 0)
>   			return 0;
> -		dump_options(info.pkey_info);
> +		dump_options(&info.pkey_info);
>
>   		p->key_len = p->blob_len + sizeof(struct caam_pkey_info);
>   		memcpy(p->key, &info.pkey_info, sizeof(struct caam_pkey_info));
>


