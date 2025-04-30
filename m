Return-Path: <linux-integrity+bounces-6080-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E908CAA45DD
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 10:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 585AC16CD3A
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 08:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D1C20D505;
	Wed, 30 Apr 2025 08:47:08 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA7F21B8FE;
	Wed, 30 Apr 2025 08:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746002828; cv=none; b=sn6YgVDIUkMTWgl7Uop8mziH9bcsRQL+lmgblj0nK9AfzPTOfuROwPUlQbx+BUCt9b5dfnv8Ly3edGejoZgXnj0LXbMH36tXCaOFT1DFGkkUtQoEU+Aan/Z1zap0TbK7U+dvzPG53gs3H5SL3XKDRg7VX5a0EbCcXbYcsG40WyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746002828; c=relaxed/simple;
	bh=oujcGGtTWJdhqn+hsdcintVRbu2G4WyuFYXEHRDX0SI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=S92/rkCn05+JfIek7wZdZC13Zk+wn1KiIfxTbzT7NvIf9k/QcCSsOYG0l/yDsWt1YWTu7Qgv/nSxOywk0jHQG+gwBTjMlAOB4dQ/GGyobV8LelIkmf/RWQhRkHbiEsRIY6uPLXlTHgBQducsm1My16NtsAge8QIeMf3yb+8B3c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8AxDGuD4xFo_PnKAA--.7952S3;
	Wed, 30 Apr 2025 16:46:59 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front1 (Coremail) with SMTP id qMiowMCxbRt_4xFoD_ifAA--.8231S2;
	Wed, 30 Apr 2025 16:46:57 +0800 (CST)
Subject: Re: [PATCH v8 0/5] Add Loongson Security Engine chip driver
To: Herbert Xu <herbert@gondor.apana.org.au>,
 Huacai Chen <chenhuacai@kernel.org>
Cc: davem@davemloft.net, peterhuewe@gmx.de, jarkko@kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linux-crypto@vger.kernel.org, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
 pmenzel@molgen.mpg.de, Lee Jones <lee@kernel.org>
References: <20250418093506.1349-1-zhaoqunqin@loongson.cn>
 <CAAhV-H608_ddH0g0gyFCZSTVxYHOBqLXrtGYxZ1eoXX6eCcEuA@mail.gmail.com>
 <75bb29fa-6d77-6f95-eec4-ee183190da17@loongson.cn>
 <aBHc2tT2-Duj3_-A@gondor.apana.org.au>
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
Message-ID: <6b7385ce-d8ad-1be9-4503-55460f40fe72@loongson.cn>
Date: Wed, 30 Apr 2025 16:45:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aBHc2tT2-Duj3_-A@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMCxbRt_4xFoD_ifAA--.8231S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrKryUWw4DAFWrArW7Gw1ktFc_yoWfZwb_Cw
	48uFnrGw1DGF4SgFs8Kr129F9FgFZrXF97Z3yIv3yay3s3Zr4jgr4xurnxuw4Syr4DJFs8
	Zr429rZ3ZryfCosvyTuYvTs0mTUanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbDkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
	oVCq3wAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa02
	0Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1l
	Yx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI
	0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r4a6rW5MI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8uc_3UUUUU==


在 2025/4/30 下午4:18, Herbert Xu 写道:
> On Wed, Apr 30, 2025 at 04:14:40PM +0800, Qunqin Zhao wrote:
>> Sorry to bother you, may i ask is it fine to move  the Security Engine base
>> driver[Patch v8 1/5] to drivers/crypto ?
>>
>> The base driver uses MFD  interface  to register child device(tpm, rng) , as
>> done in
>>
>> "drivers/iio/common/ssp_sensors/ssp_dev.c" and
>> "drivers/firmware/xilinx/zynqmp.c".
>>
>> Thank you, and I look forward to hearing from you.
> I don't mind at this point in time.  But if this driver were to
> develop features way outside of the Crypto API in future then I
> may change my mind.

Hi, Herbert, thanks for your reply.

In future it just add child platform devices  name(sm2, sm3, sm4) to 
"struct  mfd_cell engines".


Hi, Huaci

Let's go via Herbert's crypto tree for the base driver patch under 
drivers/crypto/loongson/,

What do you think of it?


BR, Qunqin.

>
> Thanks,


