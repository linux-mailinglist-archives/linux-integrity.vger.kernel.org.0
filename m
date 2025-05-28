Return-Path: <linux-integrity+bounces-6326-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A7AAC657A
	for <lists+linux-integrity@lfdr.de>; Wed, 28 May 2025 11:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95FA1888156
	for <lists+linux-integrity@lfdr.de>; Wed, 28 May 2025 09:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7696B20D51C;
	Wed, 28 May 2025 09:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pn4kTPQj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98A820D51D
	for <linux-integrity@vger.kernel.org>; Wed, 28 May 2025 09:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748423714; cv=none; b=uPLQsRlSG0GRrX3Thppmc+kyymp8BzD9jp+SCJ49A30/4+vbnkxDYOcCC+rBEG5S+j7qtKGWHN19IL31RIkU9/cqqHQAzGXXQKZfQBVp9IOZXAYmGGlpoWnU6oTzEpiIsiy1lZSWsWGYT82zz1i+d/CXNAFsrKOa/2SMwvRG+nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748423714; c=relaxed/simple;
	bh=4cXf7MErAkLA9U3B2oNG6s7tbUnnuq7wfLX8Cx+1mvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eDLgN9n7Xte0UHGZfvJ90hKaZ6yMZLgZljbilaY7TL2BinHVpxo2k/Inhk/ENBNvtwwfGgmHr6G4TOgHPUq9wisxOY1tyRKy43RBcCkRj+nfdiic8/Y1ucDFavTSKKjkQ4COeAlJOvnuOeS8yASNaqXQ3IwcMuGDX3OmyWMSP9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pn4kTPQj; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0b328692-f333-4bba-9572-6f3c86dbed29@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748423709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FI9HKlKAfdwWrEKUw5etibdxZ+5o3KFvUbDhmI3SbF0=;
	b=pn4kTPQjC7e1P+nXW2gDru2pUb+AApmOIFcvMaQQcceHjVel2fhXM4qGNuOjhIe8RJ3Tuh
	h/pNN3yQAx9UsrZwpptM2jrubF5d11fQiql17wRMxC5c7x1plULl8WB2aidGKwNaCq3y3D
	+NCJy9gWuRc8lQu3Isla4IudqVTf/Mg=
Date: Wed, 28 May 2025 17:14:16 +0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v10 0/5] Add Loongson Security Engine chip driver
To: Huacai Chen <chenhuacai@kernel.org>, Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: lee@kernel.org, herbert@gondor.apana.org.au, jarkko@kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 davem@davemloft.net, linux-crypto@vger.kernel.org, peterhuewe@gmx.de,
 jgg@ziepe.ca, linux-integrity@vger.kernel.org
References: <20250528065944.4511-1-zhaoqunqin@loongson.cn>
 <CAAhV-H7hBksA2P+vfMbpDVnbjW1Mo09Out_wOQLgLRXPLaFCfA@mail.gmail.com>
 <cda7ef56-87b3-6594-c2b6-2a4f5a1b63ce@loongson.cn>
 <CAAhV-H557CLtoF23nbRQaoDPdzuM5xgsS-+-1p_VeX0OreG2vQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <CAAhV-H557CLtoF23nbRQaoDPdzuM5xgsS-+-1p_VeX0OreG2vQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 5/28/25 4:17 PM, Huacai Chen 写道:
> On Wed, May 28, 2025 at 4:06 PM Qunqin Zhao <zhaoqunqin@loongson.cn> wrote:
>>
>>
>> 在 2025/5/28 下午3:17, Huacai Chen 写道:
>>> Hi, Qunqin,
>>>
>>> As I said before, why the patch "MAINTAINERS: Add entry for Loongson
>>> Security Module driver" is missing?
>>
>> Hi, Huacai
>>
>> https://lore.kernel.org/all/8e55801a-a46e-58d5-cf84-2ee8a733df9a@loongson.cn/
> Sorry, I missed this email. But if you put all files in one entry, you
> can merge Patch-3 and Patch-5 as the last patch (then you will also
> not meet the 5 patches limit).

We are cutting the foot to fit the shoe. Sigh...


Thanks,
Yanteng
> 
> Huacai
> 
>>
>> Thanks,
>>
>> Qunqin.
>>
>>>
>>> Huacai

