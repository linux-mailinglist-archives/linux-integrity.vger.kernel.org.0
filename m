Return-Path: <linux-integrity+bounces-4480-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2049FCDBF
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Dec 2024 22:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8E917A1591
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Dec 2024 21:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E451A143723;
	Thu, 26 Dec 2024 21:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Zcs3DGbk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA91370827;
	Thu, 26 Dec 2024 21:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735246984; cv=none; b=JImzxzIqwipPV4fDfsood7dOTDcYqXMS2mxwxVPpVlUBZeKB4GUnd2PGBsUn33bl4gs7Qip6oME2akic48yGeW025kWvJI/PVOH77gjDfs4KLPLuDaxzWoqGw+73y/piwtJheqhtXLbipNvH1WR7PkzJathUjUWiNsj8S2fsjbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735246984; c=relaxed/simple;
	bh=iTtlXrQvq/RYJ9bKfqTkCX+RPzBFkuci1zcWCM/Y8Dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VW6ov1AHaDajbgZd9TIfFJS9lZR0sTveuRpfx1axl5B8BLjy3DqCFINcVKj8ks7hDfK8TWOUmzegSZgoSLUN8IHmnoNVvpWtxhRV/SOOb9AOO12XiTVQlBnOvJi+27PATFdbXlqa5v9CR5AdOQRIMxrEnmn50T1eqpuON7hF98c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Zcs3DGbk; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DD64610408FAF;
	Thu, 26 Dec 2024 22:02:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1735246974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qc4+3fKwk69Ej8cNQjQjdFK+LyKVGQuILEDm8IFGViM=;
	b=Zcs3DGbkPkHEwjr/bHtR0RtfZxEbuhhDNjxW15Mg69Ns3X7rqNwp6osh7n1Wue+dika2ny
	iCikYgwqrhty+47YJTTrD/ltojr86uMeZYOLnT0CVSyDVAsXlUpK/r2YvaQqfwfY97UGCK
	yqlvO7fWcQ5bD9z9eH8vrdYXL/gV310gzaV+bfO1oEfp7af8Q0AwJR0nSp5QSUUv/1079z
	2DBjBQyVicWAn6neDATmaIPeUfdzw8k2rhtpsmxR3YNrN+Ykzot72Ui04cFb3bba8U26CT
	S21CxEyLeyQwB7IxjMpoeRQCVi65awO3tO0QiEkitclZ7yGazqOvqQ4UpdNJvQ==
Message-ID: <38ac27d2-6c79-452c-8f8d-d55f05519d05@denx.de>
Date: Thu, 26 Dec 2024 21:29:43 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: tpm: Add st,st33tphf2ei2c
To: Jarkko Sakkinen <jarkko@kernel.org>, devicetree@vger.kernel.org
Cc: Conor Dooley <conor+dt@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 Peter Huewe <peterhuewe@gmx.de>, Rob Herring <robh@kernel.org>,
 linux-integrity@vger.kernel.org
References: <20241226171124.83735-1-marex@denx.de>
 <D6LW9OLX0RGQ.1N4FRX7R7ZYS6@kernel.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <D6LW9OLX0RGQ.1N4FRX7R7ZYS6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 12/26/24 8:54 PM, Jarkko Sakkinen wrote:
> On Thu Dec 26, 2024 at 7:10 PM EET, Marek Vasut wrote:
>> Add the ST chip st33tphf2ei2c to the supported compatible strings of the
>> TPM TIS I2C schema. The Chip is compliant with the TCG PC Client TPM
>                            ~~~~
> 			  chip

Fixed, thanks.

>> Profile specification.
>>
>> For reference, a databrief is available at:
>> https://www.st.com/resource/en/data_brief/st33tphf2ei2c.pdf
> 
> Or just this would be enough:
> 
> Link: https://www.st.com/resource/en/data_brief/st33tphf2ei2c.pdf
I don't think Link: tag should be used for datasheets and other such 
stuff, my understanding of the Link: tag is that it is used to point to 
the patch at lore.k.o once applied ?

