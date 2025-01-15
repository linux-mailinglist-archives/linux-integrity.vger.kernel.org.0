Return-Path: <linux-integrity+bounces-4565-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4D5A11EF4
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jan 2025 11:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA04616627F
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jan 2025 10:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CF81EEA2B;
	Wed, 15 Jan 2025 10:10:26 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DE01E7C16
	for <linux-integrity@vger.kernel.org>; Wed, 15 Jan 2025 10:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736935826; cv=none; b=ouRBaPb95sUPIVsahTgnCTi7Z9ta0OwyBG0IqgHZSqLGWypCg/R1cU9Kk1yeXSHnB/1ovdueVQoUKAK5MFz8iIjpt0eu8NudiKd+m5YY4s4wywsFPnw+JJy4ROufN1l8vFcJeyeADzURlbNbQaCT2iwwM6tWiA7FWltuTKsb1ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736935826; c=relaxed/simple;
	bh=3HbDjPF2IK9U7H9HGzV/eBhECGZl6h5ZG+ZEJbN42Bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ReeXC1fhbjPjM6sXQoRXkPHRl2rmEyzm0dgN6+959q4hdXvbEm4Nni1DLgkhfuZr26aLsLyiKzGJrsquG/7rteIVa4UwXecYvnr/fwjbWZFMLITM5y8FmWRSPjJE93P0tarJMOC3sRD00WDMro2W2Iw3xAt1ij6+D2O+d54YYaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4YY1GT3BX6z9v7JM
	for <linux-integrity@vger.kernel.org>; Wed, 15 Jan 2025 17:41:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 886531402C3
	for <linux-integrity@vger.kernel.org>; Wed, 15 Jan 2025 18:10:06 +0800 (CST)
Received: from [10.45.149.44] (unknown [10.45.149.44])
	by APP1 (Coremail) with SMTP id LxC2BwAXnkx0iYdns8mrAA--.25929S2;
	Wed, 15 Jan 2025 11:10:04 +0100 (CET)
Message-ID: <d0cb280f-ab70-4a26-b253-f99c7b62abaa@huaweicloud.com>
Date: Wed, 15 Jan 2025 11:09:53 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ima: limit the builtin 'tcb' dont_measure tmpfs policy
 rule
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: Petr Vorel <pvorel@suse.cz>
References: <20241230142333.1309623-1-zohar@linux.ibm.com>
 <20241230142333.1309623-2-zohar@linux.ibm.com>
Content-Language: en-US
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <20241230142333.1309623-2-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwAXnkx0iYdns8mrAA--.25929S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWrAr4ftry3AFykKF4fGrg_yoW8uFW8pa
	9FvFWUCrn8XFy2k3W8C3ZrX3yIv3s3J3yDC3y5Gw1jyas8JrnrtwsxCr45ZFWIyF1jyry2
	y3WFgFsrG3Z7ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgqb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVj
	vjDU0xZFpf9x07j8sqAUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAJBGeHXlICDwAAsu

On 12/30/2024 3:23 PM, Mimi Zohar wrote:
> With a custom policy similar to the builtin IMA 'tcb' policy [1], arch
> specific policy, and a kexec boot command line measurement policy rule,
> the kexec boot command line is not measured due to the dont_measure
> tmpfs rule.
> 
> Limit the builtin 'tcb' dont_measure tmpfs policy rule to just the
> "func=FILE_CHECK" hook.  Depending on the end users security threat
> model, a custom policy might not even include this dont_measure tmpfs
> rule.

Another possible alternative would be to support negation for the func= 
keyword.

In that case, the dont_measure tmpfs policy rule can be rewritten like:

dont_measure fsmagic=0x01021994 func=!KEXEC_CMDLINE

Roberto

> Note: as a result of this policy rule change, other measurements might
> also be included in the IMA-measurement list that previously weren't
> included.
> 
> [1] https://ima-doc.readthedocs.io/en/latest/ima-policy.html#ima-tcb
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   security/integrity/ima/ima_policy.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 21a8e54c383f..23bbe2c405f0 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -148,7 +148,8 @@ static struct ima_rule_entry dont_measure_rules[] __ro_after_init = {
>   	{.action = DONT_MEASURE, .fsmagic = PROC_SUPER_MAGIC, .flags = IMA_FSMAGIC},
>   	{.action = DONT_MEASURE, .fsmagic = SYSFS_MAGIC, .flags = IMA_FSMAGIC},
>   	{.action = DONT_MEASURE, .fsmagic = DEBUGFS_MAGIC, .flags = IMA_FSMAGIC},
> -	{.action = DONT_MEASURE, .fsmagic = TMPFS_MAGIC, .flags = IMA_FSMAGIC},
> +	{.action = DONT_MEASURE, .fsmagic = TMPFS_MAGIC, .func = FILE_CHECK,
> +	 .flags = IMA_FSMAGIC | IMA_FUNC},
>   	{.action = DONT_MEASURE, .fsmagic = DEVPTS_SUPER_MAGIC, .flags = IMA_FSMAGIC},
>   	{.action = DONT_MEASURE, .fsmagic = BINFMTFS_MAGIC, .flags = IMA_FSMAGIC},
>   	{.action = DONT_MEASURE, .fsmagic = SECURITYFS_MAGIC, .flags = IMA_FSMAGIC},


