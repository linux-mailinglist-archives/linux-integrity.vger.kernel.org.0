Return-Path: <linux-integrity+bounces-6141-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EFEAAC3A5
	for <lists+linux-integrity@lfdr.de>; Tue,  6 May 2025 14:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C79DF3AD56F
	for <lists+linux-integrity@lfdr.de>; Tue,  6 May 2025 12:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725D227FB1B;
	Tue,  6 May 2025 12:16:15 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883E51DDE9;
	Tue,  6 May 2025 12:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746533775; cv=none; b=C/9Qaa8pwAiudLCSn8FKDZJA5OcUDuS1TfhmfsqtEKCVvc+2R3Ln0RfD1MXqyes0M4FPGoeCH+Tu0J9TRwnll/Z5u2ZWxetYoFnzZqm1lGWJZk8EBSJ0GE9+SupMbdnQSc4D3sGkwo7XNEkxLzdcjPT+DGtTexgV/jvLDsmSNIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746533775; c=relaxed/simple;
	bh=oEwS2B/SEVhvr/PEsjOt8P75XFO79S+SKeaI3RLVp/w=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=W8VxrriwXm7SjHwc5DgGc0Z+WV4qJ20E5ZnUeWIgiYxlsHyp3vneARLU0jRCEB7GpmoRJQbdBaygRkoiXJVfHQcOBS32baCIcWAezpos2XLypN1dw9GNKl520YIzVUfk0RZzx+EG6mgxYVCf+S0Gj0bQrziTxDlMNSe2F/+Aj6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8DxvnOJ_Rlo+rPWAA--.57490S3;
	Tue, 06 May 2025 20:16:09 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front1 (Coremail) with SMTP id qMiowMCxvMaE_RloXPG2AA--.50748S2;
	Tue, 06 May 2025 20:16:06 +0800 (CST)
Subject: Re: [PATCH v9 5/5] MAINTAINERS: Add tpm_loongson.c to LOONGSON CRYPTO
 DRIVER entry
To: Yanteng Si <si.yanteng@linux.dev>
Cc: lee@kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net,
 peterhuewe@gmx.de, jarkko@kernel.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-crypto@vger.kernel.org, jgg@ziepe.ca,
 linux-integrity@vger.kernel.org, pmenzel@molgen.mpg.de,
 Huacai Chen <chenhuacai@loongson.cn>
References: <20250506032053.11147-1-zhaoqunqin@loongson.cn>
 <a03b4963-55aa-4a75-b795-1e8f0db7ec89@linux.dev>
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
Message-ID: <00196f77-1060-fe67-3e6b-6721092207d6@loongson.cn>
Date: Tue, 6 May 2025 20:14:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a03b4963-55aa-4a75-b795-1e8f0db7ec89@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMCxvMaE_RloXPG2AA--.50748S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Jw4fJFy7ZF48ury7WFWUKFX_yoWkKFg_Ca
	yIkr1kGr18Jrn2g3W2gr97XwnxWa98Xa4rW3WUtw1fWw1jvFyDGFs7Cw1fA3WfWFWkGFnx
	Jrn7WFZ7Ary2vosvyTuYvTs0mTUanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbDAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
	oVCq3wAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa02
	0Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1l
	Yx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI
	0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
	W8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUUUU=


在 2025/5/6 下午5:03, Yanteng Si 写道:
> 在 5/6/25 11:20 AM, Qunqin Zhao 写道:
>> Changes to Loongson TPM driver would be best reviewed by the Loongson
>> crypto driver maintainers.
>>
>> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
>> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
>> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>> ---
>> v8-v9: None
>> v7: Added tag from Jarkko and Huacai
>> v6: "tpm_lsse.c" -> "tpm_loongson"
>> v4-v5: None
>>
>>   MAINTAINERS | 1 +
>>   1 file changed, 1 insertion(+)
> I'm just curious. Why is this patch kept outside the tmp_loongson 
> patch set?

Hi, Yanteng. Thanks for your reply.


When sending this patch, git send-email prompted "too many commands"

and disconnected from the server. Then I sent this patch separately.

Even after setting sendemail.smtpBatchSize to 100, I still have this 
problem.

Now I am trying to find  Loongson SMTP server administrator to solve it.

Have you ever encountered this kind of problem?


BR, Qunqin.

>
> <https://lore.kernel.org/loongarch/20250506031947.11130-1-zhaoqunqin@loongson.cn/T/#mf09225c286a8e2b92a677720afafb9e20be57a18> 
>
>
> Thanks,
> Yanteng


