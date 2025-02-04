Return-Path: <linux-integrity+bounces-4715-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 096ABA26924
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Feb 2025 01:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 989A93A2310
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Feb 2025 00:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA2378F2D;
	Tue,  4 Feb 2025 00:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="atLHGOwB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA3A7081A;
	Tue,  4 Feb 2025 00:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738630589; cv=none; b=hv4c6Ec9lzpP4InB0XXo8snYzYMpsiu9NVC2aFNWQ1xz4C+MxJZ9EkMPgKYaFwaBNZS8rl3WmKFpHi/ZXQ8osnuVbIDUB4OU5YBRkqJPxSar+60Gizoit5GFysmeGKTa2ylLbypLYFB9lY8oGcdJU6msDae+HhLY8zg3WRizgKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738630589; c=relaxed/simple;
	bh=MZsJfMliRp32i3XMCATCmzL3VGFxLZSIGtNx1hJ/A1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=epef9iHEcr47ezPR5Nw/2XtHk6QTx4xgsX/C6nAcvCeIV31JkQ2fNnFciw3lwFv3OZogpA/ncL62yf45EoFly3FenvD5yh768SrLDmNyeQjn8YlcecYBppQGWe61F5SFfMuEaPSE8mG0wIsGMapParocdA01Lpo2ZJZ/NhGcaIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=atLHGOwB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.64.74] (unknown [131.107.8.74])
	by linux.microsoft.com (Postfix) with ESMTPSA id E896B205493B;
	Mon,  3 Feb 2025 16:56:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E896B205493B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738630587;
	bh=8wiA7A5oplocwPTbfHbf28Kt1oSZNYikOUM55aAquNU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=atLHGOwBOcjpVxbjMIkShaTJjqRpjXXbwi6BYhHWxRjiAJFniD9fNWQtEmFEb3XRJ
	 gZ+/2EVFp1VTDXW6DpR8cA2F6BtL1/9WwqGYNSizCmKWZm3guE50d8lo6gLusvHLgs
	 ZAArZYgabwqImy0Z1BwGQmyTlFQvkGpZzrrya/l0=
Message-ID: <b07a4b44-b76f-4691-ac01-6e91b6b83672@linux.microsoft.com>
Date: Mon, 3 Feb 2025 16:56:26 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/7] ima: kexec: measure events between kexec load and
 excute
To: Mimi Zohar <zohar@linux.ibm.com>, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@HansenPartnership.com
References: <20250203184558.61367-1-chenste@linux.microsoft.com>
 <eb2d3b5f-7aca-42c8-9b34-8ca07b8bc060@linux.microsoft.com>
 <8091ed0d942806e16f995e8444da29df7843df62.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <8091ed0d942806e16f995e8444da29df7843df62.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/3/2025 4:50 PM, Mimi Zohar wrote:
> On Mon, 2025-02-03 at 15:25 -0800, steven chen wrote:
>> Hi all,
>>
>> The below is the correct version for review.
>>
>> [PATCH v7 0/7] ima: kexec: measure events between kexec load and excute
>> <
>> https://lore.kernel.org/linux-integrity/20250203232033.64123-1-chenste@linux.microso
>> ft.com/T/#t>
>>
>> Please ignore the this version because patch 5 is missing.
>>
>> I am really sorry to have troubled you.
> Thanks, Steven.  I was able to apply the patch set to v6.13.  For some reason, b4
> downloads a duplicate 4/7 patch.
>
> Mimi

Hi Mimi,

Please use the one below

[PATCH v7 0/7] ima: kexec: measure events between kexec load and excute 
<https://lore.kernel.org/linux-integrity/20250203232033.64123-1-chenste@linux.microsoft.com/T/#t>

Please ignore the this version because patch 5 is missing.

I am really sorry.

Steven


