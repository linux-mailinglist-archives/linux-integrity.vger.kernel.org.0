Return-Path: <linux-integrity+bounces-6707-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB08B10E81
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Jul 2025 17:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96A785A7C75
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Jul 2025 15:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADEC2E9EA7;
	Thu, 24 Jul 2025 15:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="sCKkpikB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic309-26.consmr.mail.ne1.yahoo.com (sonic309-26.consmr.mail.ne1.yahoo.com [66.163.184.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DBF2E9748
	for <linux-integrity@vger.kernel.org>; Thu, 24 Jul 2025 15:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753370442; cv=none; b=GmsGoZq1Na5rHy4TD2jnWzwqAAF0lShIrBrWXbzbtnLUsLbL4M/8MOMs4P//QEzVmYn6xgHnnJmsWIMqp08BJn+xI1L7WaM2QyB+LZbwHy3c6OzCDrizqAoCph8WwMSznL4TxAKBFYoqUKTIclweK3QmOCaV9u2dgJZYHXcQfMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753370442; c=relaxed/simple;
	bh=cpfttxP7fscAKeWOKevItGZRzxDwTcvL618zjukfRcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f1SMQjjdi14ta+uvn2GTfuQPVRJt5aEp6sb89aHMVf+2FKWZS8BsnvJOFjkcq629tyyo+Ck5yhvrNrWwvxyw/merUlI3xCtEcAESfj2Aj3o2ke90ZL2JIS7p0tiAXch2+wPbITNaZTKmm5mhzKEqtKjtCd5yostCYO/nRQDCCRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=sCKkpikB; arc=none smtp.client-ip=66.163.184.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753370439; bh=6e+Nn0AgYQ2+iI0iQPfDsaw/GpFAJjluHYikZuUXP/Y=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=sCKkpikBTTgqsmOZaDHfRpBn99GcxryKTF+XTeCd7Q5yWHdfna5Emg3iiUaOwKTUWxCVaGuKQ5LuMNS3XCTeGRm5a0LZ1dLlHPzqANAdfHzHYAygHBu3b/Lsy3aD6F9B+1ukCXpa68eUCXY/dE4SCve5tCrmQojBzYAk0Zm0xlEpE/cc/+qja4ySscuiHIsVWKoBzj0m7LWy/yegKhFms+1LW+RzSZIoDRZ/ivYyym9qaBoP7SZu0uecorNFOOwfxMVkc8yi3NsPEZQMy2fmqB/VI/Iz0K2VBi1euqrDg4zwhUhkIgd5bUTZxk+IhWX54eep/lBlO1KaCAAhaPJghw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753370439; bh=ww70qHPo5gpUwrzOKGG6qtXev46AykWNPqYJnySNXdu=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Tpmzplog/1KNyG+kFw4OVMOENXRr3udCmlKkHXIRp2uF69eaIMBsKEdGivS3EYT6RrifwvpZmiQ18UiwUKA3+WOa9njs37M36hndTH19IFsSxQDWMbKifNtIv3yrWmwOZdlVrFwkHtOK+R5uzufgu3z6npHC3//fvK2fhuVx0WBaGIJXGV1mNSYcebJO2tO5vo5OFq9lPmx7jxZDJBd80SMPLgWJA8LOFkgiDmN5LNpjMQGf3AQdsTycHrMMk0PE/07W1LHLbvSWUiDx+4LarL5aNTv7pwMsHoxen9oqMC9NfvcjBrT72ldamx3G+DMvlTMhYL9c1X0sxkfdXBZMFQ==
X-YMail-OSG: XWlL.IkVM1mS2uB_c673CvyibWOY5BQDq3BxPCbtkGcfHIs3BGbw7ear3iKLE9p
 9fHYhCgbfWsuIaKW2KDZna4ZBtO4Jqad.WeL_FC68.S9iCk_Y.Szh6csHJOhhTOvz3tHNsOkAzYK
 Mz7y4jHZRjHw8Q6T2KJYdqkcNe.jcucd2KEDZeeC_A_zrmLxeqAWDii8G7GM8uUoti4Sw6hH4pBk
 hXtRX6oN7Lty_B.Sy1bm8GE0X21qWTfm6TJUc9bwBk0IPUZ.BtKmvF1CpKM_MpREoSdM6fTnAv1g
 165F.fovm20uvHk9Og1WoM9y8aCg0.BrcM2estLhDZXzXebS345zPIyU.znRqqTjUEIYIa6yXJPB
 uAI2ZWGPSctDCscwuFDEQ7ZKnDEMAXVXyEQ6XIyzuS_o7NRH.510B4ipijtwjxkzB6fidT4f5EBR
 49bmSVnACtTIvuPJn5IJ3xMjuH5lOPowRdON9if.P6NVLygCdLTwwqxiIXzVYyRBRkPjTs9yCE1.
 aBTOc_n9s8TFhgyTMIHG1e8e9IXfdbwQN2tfABtviKUhr9.hYgKM3RQBfoUYjYGH9IsNew.L7aBv
 TlW_lId_L13We9M8OOI9Xy7W50rPZ3zZWlNarcdVp8_N1vtqk.v7RJM0krztMIcYXlz_RPf3WLuH
 gp9ZDbYtUAHLaSzMIZS8tQY7zqLV6s8LLHzGKsRwKLueYY_taZB9eqa.bF5QZmd2gMvHwORty5.w
 6OFsRe2qCQbn2UQGjM9RKa0Y71Iki9FV4FBS68hNsKYU8HV4CaMkZfNNfWJ3PQlwUwLzMH_eHjoF
 TRWcds.0wcmg7deR8C1bSGkMQ.pdUjZDXS4sWKwchW3ZGSvc1LmEc5bC9T6KY6JGf0zlTkQh2OK2
 5xkkZHDdncOGHSPU4N9vzLHhP5jOmpSPjp4I_104DPMyJ9DfIYSz2HqwtOcZx_xsJFD7jo_A6hfu
 Ab4eVfZ_Bi4kdL8GUiOQiOHRqBLeyoZXQ9QLRWCabaLmVDJBvHOH0zCUqbHYnB8EA5LRYJT1PgFM
 P6kxi2QnsY4a_.Ix8.xGNCvrCOuajZu_2x67UuUCyq3AmGlUrinfLI4AzcOAIkQmcKanZSL5tlXU
 Wf_FsELRJIsYUQawOXcor6W76tYSaR47vylyM0jLnlz7pegStkyEcgPiMfyOCA7PB_4LtxV0B1rM
 g8GFjN_EoLh1d9HiZ_rN4TgT6s84bHtMs_4XKojufU0mPyQ3jgKwTg_PCsCD9ygWGNPkOAIcT9f9
 o_XFcC24NpMV0bvqHO.a3ez3NwH1ANndm93LMpU_0P7YWQTM5xzhtttoBw4ml0PD86NYECnvwiIO
 fwQ_Izi.dO7OAAgCQgRFnoum7U7COlQpqu42FfxJ9rLLGcdt5FHDjv13X0eLSK.03pwJdIIPa31G
 m53IdPZP5uVUxSxhKiYIGum6qTUxKyrfyVqZPo21U9JD.Bfr0DQXHf7aio36RJG8nZNBvT2vXq_T
 ICU8JgrHr3WGrkos.rG2z3v1VMj3sGLMcogc96LXxkXB5bNeHzeCOJryhWTr4v66gp770_7etGD8
 SP2BePYbQJUHmyYxp88ceAaojA_5nZr0DdXbq9FQn1WBkaNRwwxuT0zl5EVLuCyqyOaVQFDv1Cx1
 HQaHuD8vvQGdq020_WLPlgG9QlGDR1BGRW._ezeLynv30l8efiH_n5sTag_8D4.HN7I0J0LIoC6A
 v8pjjYMQ3i_59CXtvbk1w9.L17HKme9W1tIuo4IgbxdlU7u9OZPAOy35VbxCVr12WDMPU5.L8_rN
 YL5u1Gud9Rba49cw5tNe_dPHfRf.Sq5VN1B1xJ3xd4ffgYxZCyEB9MXu5UFJXlrYBLzLolKaMWzR
 tJX60OJc4CkW4S652xlbU8BDkl2vRPtt7BwsUphX301DeVe0qdzvOUz7WsxllEBiTsV11AxWjSE7
 gTWT88fy1L1820rvbdIcBrdZjS52OECkR0IRUTP3JNH3R.K4TeDhpN1oBV_GElIPvGI8hZtfBA0L
 M5T_R3QTB77OvN3DT5zDCRHzNYFeN_qUQeDRWkekRYs2WmMam7Bg.wQ04WLiYxQ2.FUod3675Pz8
 .IZFIRdxWrTgK39meO5x5ek2092i8DR5TPc47eQoTJS736ln65H2x51Ccv3zGswnKlDIbYlHHizL
 DJfOc7_A5DVxFMQv_wW44DESIG9.GucK5jaUfTwJM8HZmr9qYt7vURzcIzZCSDFv9_MnUqsA8tDO
 KdkpyZ2XTVMNZRn6CjC1WcfzfyA.0.TFwPth4pN8j8H7Q916RIRaFwKHWQf1P4OBlZApLVkPtELP
 yJQ2q_EU5PYuNSaXubDBWk0FRIxI4K8YIyl8-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 1e8cb7c8-0591-425e-b4cb-56bc135baf62
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 24 Jul 2025 15:20:39 +0000
Received: by hermes--production-gq1-74d64bb7d7-45lk9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8b4b55ec4af6718bdd9644be8e80c800;
          Thu, 24 Jul 2025 15:20:33 +0000 (UTC)
Message-ID: <db1b6813-2e33-412f-b799-ccbb9abc13cd@schaufler-ca.com>
Date: Thu, 24 Jul 2025 08:20:31 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 06/34] lsm: integrate lsm_early_cred() and
 lsm_early_task() into caller
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Fan Wu <wufan@kernel.org>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiu Jianfeng <xiujianfeng@huawei.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
 <20250721232142.77224-42-paul@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250721232142.77224-42-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/21/2025 4:21 PM, Paul Moore wrote:
> With only one caller of lsm_early_cred() and lsm_early_task(), insert
> the functions' code directly into the caller and ger rid of the two
> functions.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>


> ---
>  security/lsm_init.c | 35 +++++------------------------------
>  1 file changed, 5 insertions(+), 30 deletions(-)
>
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index d20c6df55e7d..7e736c20458a 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -288,34 +288,6 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  	kfree(sep);
>  }
>  
> -/**
> - * lsm_early_cred - during initialization allocate a composite cred blob
> - * @cred: the cred that needs a blob
> - *
> - * Allocate the cred blob for all the modules
> - */
> -static void __init lsm_early_cred(struct cred *cred)
> -{
> -	int rc = lsm_cred_alloc(cred, GFP_KERNEL);
> -
> -	if (rc)
> -		panic("%s: Early cred alloc failed.\n", __func__);
> -}
> -
> -/**
> - * lsm_early_task - during initialization allocate a composite task blob
> - * @task: the task that needs a blob
> - *
> - * Allocate the task blob for all the modules
> - */
> -static void __init lsm_early_task(struct task_struct *task)
> -{
> -	int rc = lsm_task_alloc(task);
> -
> -	if (rc)
> -		panic("%s: Early task alloc failed.\n", __func__);
> -}
> -
>  static void __init ordered_lsm_init(void)
>  {
>  	unsigned int first = 0;
> @@ -376,8 +348,11 @@ static void __init ordered_lsm_init(void)
>  						    blob_sizes.lbs_inode, 0,
>  						    SLAB_PANIC, NULL);
>  
> -	lsm_early_cred((struct cred *) current->cred);
> -	lsm_early_task(current);
> +	if (lsm_cred_alloc((struct cred *)current->cred, GFP_KERNEL))
> +		panic("%s: early cred alloc failed.\n", __func__);
> +	if (lsm_task_alloc(current))
> +		panic("%s: early task alloc failed.\n", __func__);
> +
>  	lsm_order_for_each(lsm) {
>  		initialize_lsm(*lsm);
>  	}

