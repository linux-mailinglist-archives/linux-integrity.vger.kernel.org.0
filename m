Return-Path: <linux-integrity+bounces-6251-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B16AABBE5F
	for <lists+linux-integrity@lfdr.de>; Mon, 19 May 2025 14:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AFDF3BD851
	for <lists+linux-integrity@lfdr.de>; Mon, 19 May 2025 12:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781AE278E7F;
	Mon, 19 May 2025 12:54:30 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6861E7C2E;
	Mon, 19 May 2025 12:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747659270; cv=none; b=u4k3KpfmkgSAWyJIn3Lzb3XIP4HCHR45BsbWpPgpzl5KuUtCXkfU/Vu5JZ+FiVa2S2RjYzcpM39DbZJ/gQuhrvuPBRwU8N7ogLh55378YzD+ZY1dB443FSJCnHnzm3HtRFIN4SlFG+CxCyRMG048NvmwywTVmED/wO7pkVh/2PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747659270; c=relaxed/simple;
	bh=Y8vfbAw7o2olarJnZW6Z6xjayrWHe56GUK693E1d9Sw=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=AOmNyr/pUfL2U1qHr9LEizb/9z2MEdFgkyolT4rL/RnGVrBvb5yTU2qS10HNJNUPDooKfNOfvCY2vmw8q8Q1ThdmZEVahVKQfzbOvmrV+YqiaKA+7W4p/OXLSpfjEYwYReRTtPm+DQw0Mo1DJ0tf0gLypIGRY9TfLny0wONoRTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4b1Hf70SLQz1d1Dp;
	Mon, 19 May 2025 20:52:47 +0800 (CST)
Received: from kwepemg500006.china.huawei.com (unknown [7.202.181.43])
	by mail.maildlp.com (Postfix) with ESMTPS id C08951402EB;
	Mon, 19 May 2025 20:54:19 +0800 (CST)
Received: from [10.67.121.110] (10.67.121.110) by
 kwepemg500006.china.huawei.com (7.202.181.43) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 19 May 2025 20:54:19 +0800
Subject: Re: [PATCH v9 2/5] crypto: loongson - add Loongson RNG driver support
To: Herbert Xu <herbert@gondor.apana.org.au>, Qunqin Zhao
	<zhaoqunqin@loongson.cn>
CC: <lee@kernel.org>, <davem@davemloft.net>, <peterhuewe@gmx.de>,
	<jarkko@kernel.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-crypto@vger.kernel.org>, <jgg@ziepe.ca>,
	<linux-integrity@vger.kernel.org>, <pmenzel@molgen.mpg.de>, Yinggang Gu
	<guyinggang@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>
References: <20250506031947.11130-1-zhaoqunqin@loongson.cn>
 <20250506031947.11130-3-zhaoqunqin@loongson.cn>
 <aCrIL_ZXL-UtaLdJ@gondor.apana.org.au>
 <96118a23-3e6c-c9d1-2135-bd7a22091f35@loongson.cn>
 <aCrqPnwr7lMJNOnL@gondor.apana.org.au>
From: liulongfang <liulongfang@huawei.com>
Message-ID: <e7ad2dd5-78a5-618d-f450-ef0eed430adf@huawei.com>
Date: Mon, 19 May 2025 20:54:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aCrqPnwr7lMJNOnL@gondor.apana.org.au>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemg500006.china.huawei.com (7.202.181.43)

On 2025/5/19 16:22, Herbert Xu wrote:
> On Mon, May 19, 2025 at 04:13:14PM +0800, Qunqin Zhao wrote:
>>
>> Then the HISI TRNG driver isn't a right demo?
> 
> Yes the hisi trng looks wrong too.
>

We are currently updating and plan to create software TFM for users when
they unable to apply for hardware device queues, ensuring that users' tasks
can continue to be completed.

Thanks,
Longfang.

>> This can also avoid concurrent access to a device, otherwise i need to
>>
>> add mutex_lock/unlock in generate and seed callback.
> 
> Randomly failing the tfm allocation is not a solution to resource
> control :)
> 
> Cheers,
> 

