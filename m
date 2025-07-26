Return-Path: <linux-integrity+bounces-6737-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D867FB129F1
	for <lists+linux-integrity@lfdr.de>; Sat, 26 Jul 2025 11:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C07C174E99
	for <lists+linux-integrity@lfdr.de>; Sat, 26 Jul 2025 09:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6082264C5;
	Sat, 26 Jul 2025 09:38:24 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30A02264A5;
	Sat, 26 Jul 2025 09:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753522704; cv=none; b=H/F1cgDM2RHGzU1IU2RDGD13q8ZAMb3LJu13at9q5wCxv/f61g7r2+UcGy+IuAgJiiG9XrfksqIXRiexHdLavuVkotmjn10S5TkRXKZ8ufWy3TNLVjGclaOFs1DM3TpsPpV6xDI3PAOgCDyxyWWAB2QUGjNNGxGiWCdDUjGabo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753522704; c=relaxed/simple;
	bh=dHuPBIMsuD8ezdXET4y9gJICTLo3EGhV2OmdP7sJqmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=k1517Af/puATjNLgR/O5qmxfD5wTGYDvgaD83LGtb2zswbAvudzMIuOZ7H3fAUH4ReCnk1wgjOPyLHAT2oSjazoauXnYFIzq1NXqGd9JVazyzHXXwzk/KrIy9oY0Yov8h6pJxNJz7yUhK7OApIv/esrPeErDM1xnNKKfHg2Aoy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bq03j3MMgz2RVv6;
	Sat, 26 Jul 2025 17:36:01 +0800 (CST)
Received: from kwepemg500012.china.huawei.com (unknown [7.202.181.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F35C1400CF;
	Sat, 26 Jul 2025 17:38:18 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 kwepemg500012.china.huawei.com (7.202.181.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 26 Jul 2025 17:38:17 +0800
Message-ID: <68025cd0-e55a-066e-954e-a398feedc34b@huawei.com>
Date: Sat, 26 Jul 2025 17:38:16 +0800
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
To: Paul Moore <paul@paul-moore.com>
CC: <linux-security-module@vger.kernel.org>,
	<linux-integrity@vger.kernel.org>, <selinux@vger.kernel.org>, John Johansen
	<john.johansen@canonical.com>, Mimi Zohar <zohar@linux.ibm.com>, Roberto
 Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>,
	=?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
	=?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack@google.com>, Kees Cook
	<kees@kernel.org>, Micah Morton <mortonm@chromium.org>, Casey Schaufler
	<casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng
	<xiujianfeng@huawei.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
 <20250721232142.77224-66-paul@paul-moore.com>
 <3101077d-a5e2-d08b-03c2-2ed064a35b54@huaweicloud.com>
 <CAHC9VhR_24Zv7u0Btz8pSk420Totnx2uRyVdoHU1tXevWKw5mA@mail.gmail.com>
From: xiujianfeng <xiujianfeng@huawei.com>
In-Reply-To: <CAHC9VhR_24Zv7u0Btz8pSk420Totnx2uRyVdoHU1tXevWKw5mA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemg500012.china.huawei.com (7.202.181.74)



On 2025/7/26 0:51, Paul Moore wrote:
> On Fri, Jul 25, 2025 at 4:12 AM Xiu Jianfeng
> <xiujianfeng@huaweicloud.com> wrote:
>> On 2025/7/22 7:21, Paul Moore wrote:
>>> Reviewed-by: Kees Cook <kees@kernel.org>
>>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>>
>> Reviewed-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> 
> Thank you for reviewing this patch.  As you are a Lockdown maintainer,
> can I change your reviewed-by into an acked-by tag?

Yes, absolutely! Thanks for checking!

> 
>>> ---
>>>  security/lockdown/lockdown.c | 3 +--
>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
>>> index 4813f168ff93..8d46886d2cca 100644
>>> --- a/security/lockdown/lockdown.c
>>> +++ b/security/lockdown/lockdown.c
>>> @@ -161,8 +161,6 @@ static int __init lockdown_secfs_init(void)
>>>       return PTR_ERR_OR_ZERO(dentry);
>>>  }
>>>
>>> -core_initcall(lockdown_secfs_init);
>>> -
>>>  #ifdef CONFIG_SECURITY_LOCKDOWN_LSM_EARLY
>>>  DEFINE_EARLY_LSM(lockdown) = {
>>>  #else
>>> @@ -170,4 +168,5 @@ DEFINE_LSM(lockdown) = {
>>>  #endif
>>>       .id = &lockdown_lsmid,
>>>       .init = lockdown_lsm_init,
>>> +     .initcall_core = lockdown_secfs_init,
>>>  };
> 

