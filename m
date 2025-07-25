Return-Path: <linux-integrity+bounces-6731-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEB8B11998
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Jul 2025 10:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B8AE1CC827C
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Jul 2025 08:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1532BE7D7;
	Fri, 25 Jul 2025 08:12:28 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777B41CF5C6;
	Fri, 25 Jul 2025 08:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753431148; cv=none; b=CC/A0Wa6znEyW+Z9vsPprRwxvpq72DpJba3ygfUHTeTKMQrHk4lVCP8b+Ht4DbJeUgrHOPBvq0hLHHwGiiC+p2hHuAhy5p0I8mgvMbG8ZtvLK1kV37/YEZ0YiIrG0uTjZah3EuEEa1+RrD+tv3QpbhbkKKd/WnwhkKlZUt9/gos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753431148; c=relaxed/simple;
	bh=g1cALe+4q01xO5+Us7k0owbBU8+/y9s69BlMp7QIyP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RfSKsXtKL7+CniwYtVTZs95PoiWf0pb2NJL0FweN+zVEo35TiQBfrgDutR11I0Qaa6jFCLTdIB1NbvblJwU8RGl5hKk6OYbu8xWu8nhvjsy3mh0q/sx5RlPi/hRhzjcNHEQAAneJw952+GB8jEyc/VTuBQ7VoaHp4Eri4RxlGGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bpLFg6vwrzYQv6G;
	Fri, 25 Jul 2025 16:12:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A461A1A145C;
	Fri, 25 Jul 2025 16:12:22 +0800 (CST)
Received: from [10.67.110.112] (unknown [10.67.110.112])
	by APP4 (Coremail) with SMTP id gCh0CgBHwhJjPINocTa0BQ--.12928S2;
	Fri, 25 Jul 2025 16:12:22 +0800 (CST)
Message-ID: <3101077d-a5e2-d08b-03c2-2ed064a35b54@huaweicloud.com>
Date: Fri, 25 Jul 2025 16:12:19 +0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH v2 30/34] lockdown: move initcalls to the LSM
 framework
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Fan Wu <wufan@kernel.org>, =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?=
 <mic@digikod.net>, =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack@google.com>,
 Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiu Jianfeng <xiujianfeng@huawei.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
 <20250721232142.77224-66-paul@paul-moore.com>
From: Xiu Jianfeng <xiujianfeng@huaweicloud.com>
In-Reply-To: <20250721232142.77224-66-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBHwhJjPINocTa0BQ--.12928S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFWDJr17Zr4xGFWxXry3twb_yoWfCFc_Ww
	1kAF1DGFsxZw1rAr4UCF1fur1v93yxJFy7uw1xGr1DA34UJw18J3WxJrn5AFWrGa1UC3yj
	kanIka4Fqr1YqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/



On 2025/7/22 7:21, Paul Moore wrote:
> Reviewed-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Xiu Jianfeng <xiujianfeng@huawei.com>

> ---
>  security/lockdown/lockdown.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index 4813f168ff93..8d46886d2cca 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -161,8 +161,6 @@ static int __init lockdown_secfs_init(void)
>  	return PTR_ERR_OR_ZERO(dentry);
>  }
>  
> -core_initcall(lockdown_secfs_init);
> -
>  #ifdef CONFIG_SECURITY_LOCKDOWN_LSM_EARLY
>  DEFINE_EARLY_LSM(lockdown) = {
>  #else
> @@ -170,4 +168,5 @@ DEFINE_LSM(lockdown) = {
>  #endif
>  	.id = &lockdown_lsmid,
>  	.init = lockdown_lsm_init,
> +	.initcall_core = lockdown_secfs_init,
>  };


