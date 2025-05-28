Return-Path: <linux-integrity+bounces-6320-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3F6AC633B
	for <lists+linux-integrity@lfdr.de>; Wed, 28 May 2025 09:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9853517B505
	for <lists+linux-integrity@lfdr.de>; Wed, 28 May 2025 07:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFCD2459E6;
	Wed, 28 May 2025 07:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FUN/QgMS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF02124500E
	for <linux-integrity@vger.kernel.org>; Wed, 28 May 2025 07:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748418158; cv=none; b=oPJOlWC0soaKAw6doZyXHUlvLbnHdQzIJfOXrKJAfxVWQJxmIEtWd9pWRBUyR2PNY1lDqr3XAD0Y6W2sO2Uu+cVmqPECGA0St1avegxF5n0EGO6QagFxkmZM7nsehMWw0PB+B44gJ+us/Bnt8B8PbLprgYwErpi2o3+lfpM50nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748418158; c=relaxed/simple;
	bh=xYJevYiGKI0K7avOKmDDQjjiD0+OYWRjkuns92h5r1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LVuCcahUv4tCkx2mZUZZ0D0Xh1KFdMLWdt96FXWKg3WjZg57s7dHh3O7QeHjE7Ltq30OqEa4rUytHos/JWfeGLV10JtMVqjG+QwfXlBa+cCenGHKQF9kLew5zbNeZ2LqoYpmXvV6Iay+PxhxpkK47v6cLqmyGpaRzwVbqV5dHfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FUN/QgMS; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <edd25df6-47a0-410d-ab48-54a0660c6149@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748418144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XWpUHx95xVQCUGTqWlHukBzLJnxxv1s1PMTNi6sAZco=;
	b=FUN/QgMSNmz/dsJyLSQ9iduOvw6nDteuE2lDMs+7mz6z+byomfgosG2T1MsoPBeBuVGhR3
	DBo5chzKTeQei5Z+/poQJRfeZGsrvUQPYNRBP56S3w7sjU3iWWntUmD91zAaH5rj//wrCs
	WazTaJjqCQLRdwYSootlfyykjyxhnlA=
Date: Wed, 28 May 2025 15:42:07 +0800
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <CAAhV-H7hBksA2P+vfMbpDVnbjW1Mo09Out_wOQLgLRXPLaFCfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 5/28/25 3:17 PM, Huacai Chen 写道:
> Hi, Qunqin,
> 
> As I said before, why the patch "MAINTAINERS: Add entry for Loongson
> Security Module driver" is missing?

Similar issues widely exist in the Loongarch mailing list.
The cause should be attributed to the mail server of Loongson.

It seems that Loongson Mail can only send no more than five
emails at a time. I suggest abandoning the use of Loongson Mail.


Thanks,
Yanteng

