Return-Path: <linux-integrity+bounces-6562-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB8DAEAF24
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Jun 2025 08:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BE6D1C2009B
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Jun 2025 06:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5F419D8A8;
	Fri, 27 Jun 2025 06:47:31 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF04323E;
	Fri, 27 Jun 2025 06:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751006851; cv=none; b=GOVYz4I1tLhX18RErLy1r8tzkzuSFZ2ON1xUewcDNM46WWZiXNZEp2np4z8ghtgqTGNrPbaDhDUaaRobZqx9jbBlJTK9gMkBtTd0BjDTyvjHAe8jhI3zBMAsDH1ImpkAymrc+/UJOvM7hacuVTLQ6S9cB+NhFbQdAd5IrpZbDz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751006851; c=relaxed/simple;
	bh=YdDjLHd/fBPgvr7y93fqf+nWxku2PSXueKPC9DfCgJM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Re46ARgSFktWxmI299CKb11zDH/Yp8ddzhqvA4Op0wDe2mXrDT46edd5v9p4AvX6eKOZldN+moJnvPfqCUc5erXnD6ZqeTk4VlbnMI2HAQ+j8Ge8I8aPwOIYX0u6H2Vo4Y6ucZRJi38N9BzcCLqFWnk9ZxIkh3m4d/NMotR80Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8AxHHJ2Pl5oyx8eAQ--.1233S3;
	Fri, 27 Jun 2025 14:47:18 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front1 (Coremail) with SMTP id qMiowJAxz8NwPl5oLgsAAA--.15S2;
	Fri, 27 Jun 2025 14:47:14 +0800 (CST)
Subject: Re: [PATCH v11 3/4] tpm: Add a driver for Loongson TPM device
To: Jarkko Sakkinen <jarkko@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 Lee Jones <lee@kernel.org>, herbert@gondor.apana.org.au
Cc: linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 davem@davemloft.net, linux-crypto@vger.kernel.org, peterhuewe@gmx.de,
 jgg@ziepe.ca, linux-integrity@vger.kernel.org,
 Yinggang Gu <guyinggang@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>
References: <20250619025138.2854-1-zhaoqunqin@loongson.cn>
 <20250619025138.2854-4-zhaoqunqin@loongson.cn> <aFs2RDOeOKvWUN2L@kernel.org>
 <20250625080527.GN795775@google.com> <aFvhorr3kZSuzVpv@kernel.org>
 <20250625134047.GX795775@google.com> <aFwsIs6ri3HZictC@kernel.org>
 <20250626103030.GA10134@google.com> <aF0oHDVQKVfGZNV2@kernel.org>
 <CAAhV-H7nyKHS70BGh7nwjuGwSWayCbUY=1-zWMU4N3bJZtH1gQ@mail.gmail.com>
 <aF2Rn0R4AlopEwz8@kernel.org>
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
Message-ID: <86b5e396-54d4-7b36-8848-06f41083ba59@loongson.cn>
Date: Fri, 27 Jun 2025 14:46:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aF2Rn0R4AlopEwz8@kernel.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowJAxz8NwPl5oLgsAAA--.15S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoWruF47Xr1kGrWfZr4DtryktFc_yoW3ZrXEka
	yxtF1kZr13Jr97tayagr1xAFn7XayqqasI9340vrs7XayFyF9Ykw4qkwn7CFyUXrn5Jrn8
	GF4fXrW8Cr1SvosvyTuYvTs0mTUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbDxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
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
	W8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU


ÔÚ 2025/6/27 ÉÏÎç2:29, Jarkko Sakkinen Ð´µÀ:
> On Thu, Jun 26, 2025 at 08:48:35PM +0800, Huacai Chen wrote:
>> But there is another coherency, you can see this in the 1st patch:
>>
>> +static const struct mfd_cell engines[] = {
>> + { .name = "loongson-rng" },
>> + { .name = "loongson-tpm" },
>> +};
> I thought already after ffa driver from ARM that I need to fix up
> the naming a bit before it explodes. Thus, I'll stick to this.
>
> And e.g., I could easily find DRM driver with opposite order.
Next revision:

+static const struct mfd_cell engines[] = {
+	{ .name = "loongson-rng" },
+	{ .name = "tpm_loongson" },
+};
Then
"loongson-rng" can match MFD and Crypto subsystem naming convention.
"tpm_loongson" can match TPM subsystem naming convention.


Thanks,
Qunqin

>> Huacai
> BR, Jarkko


