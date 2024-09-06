Return-Path: <linux-integrity+bounces-3490-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C2C96F728
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Sep 2024 16:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F5481F25C2E
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Sep 2024 14:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013091D1F4D;
	Fri,  6 Sep 2024 14:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="ldp+Qsdw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6318D1D1757;
	Fri,  6 Sep 2024 14:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633764; cv=none; b=OcMICHH8Ahrhx22lj8/H/gctDLn8D1/npuJN1R0YEsLsboYNh5p6psi3c569D+oEoizLhemgTOrw/8FFWSsMX50CocDN3rD0SR4zHn8o5CUa5VOIyj5DzdRdv7MR+C9yb5hpRs9Vi490NMO7rVboCqAv17f14f9SwXIbnMaabWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633764; c=relaxed/simple;
	bh=pj6q7pRbyGidAOFqbosve8d0lwaSXVGdj3+1bN4PSq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OSOrcrgPb7UXvVl0bhLLyM1cJC9d5zCIvrRQ5OoIpax+9rJpa/cyf4kBruDONYvw16gJX44JyCdCNmr7Jefi0q+kuXwGW36S4qCr1KCMAYwUgd7xopuWzlfMMv3A3RMdih0v1bI8Hadyk0H6y2uENSM+H+6y48WQSmUQQoiqoCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=ldp+Qsdw; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1725633752; x=1726238552; i=wahrenst@gmx.net;
	bh=EnJX//TvEm1gJVJJPWoKfObjaG1VzryhTzzDecbT7PA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ldp+QsdwjxOqoiFfvG+QAU62V02ktzMQluOjf+kNal02FQWAx7Ow4tfGbeobO4yI
	 u4nLuG5ZYTdvgQEgWyPYb0+biJx66zUHuMlJ15Y3FQRzLlN6yGMo9GMaJU66wSsZc
	 KJIRfP2ux6hN7W9Wyb7esYoaTeOA6XVldxs9jtzKYLRS2dxm10h5GZmgRtp+HlY2l
	 te3HlazP0+Qllpn2GqIdzbii82gMfUQTewfTU8X4xY1/Nm9j4o9mB+hjeJExECrnF
	 JcVndOO2vhu0I0gXOqOarEAak/lZNB+SDtZWGum08RW//jdar4vMTFHRqfXQ31vFx
	 iaK4PpY3G/o2IH/zAw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MysRu-1rr1hK0P1m-00vusc; Fri, 06
 Sep 2024 16:42:32 +0200
Message-ID: <357a8f1d-033c-4d55-a6d3-05703cc7e0b0@gmx.net>
Date: Fri, 6 Sep 2024 16:42:31 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] tpm: tpm_tis: Provide error messages in
 tpm_tis_core_init
To: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
 Stefan Berger <stefanb@linux.ibm.com>
References: <20240906060947.4844-1-wahrenst@gmx.net>
 <20240906060947.4844-3-wahrenst@gmx.net>
 <D3Z3W2PZDU7C.4CBZUBZYY0RS@kernel.org>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <D3Z3W2PZDU7C.4CBZUBZYY0RS@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cQ3Bi+qJJONkbJSVrtzaDZ7EJa1pKmcUqvZ2PtkEfG6spgtY22s
 EUZhI3L6o8FJB7SOc+Y39npMQZRIM478F3LTdyhzkhBBnjftLpOWtkIFBu+AQ9Fdy3HgsMj
 4hOplRCB5UwTppj3tmhzTtYhEOuwO3+bo69dtUkY4vBJnMgEvIRTxOros5dPK0NAP/l3/Bf
 tqUfreHVwIETPHNrdowVw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3s6IcaSm9Do=;L/me6pEx9WDHae79V5Rr2Any+nJ
 Sp4ans00YyU4i0zYXbs/zyhuy2oM3GX44bOZ7mQzG9aUZQLv3gsR/Qf6PoIlTOAU1tJH4eUQi
 vbjPg5Xwa/Aee7tX6KPe//kWnfnycP9SXyo8E0QDAdM3tU402+c7X2+VMrjj81M8uwdNWkuFg
 DZpRGxZXjV0C5mc3Y544f5+I2ClKnOFQNScWICeUmTjetzvmZj96oPCXXTyuvRHcZfum+zkMA
 DK97sAoDMIk5GGQUnyI3NUc7e0u8hlB19cTSVPu/CSl8zOvHav6PEXUeNsmIQsbosgRBtY+7r
 kMXoIzdOk6SrMrXMRxUkmnphCcK7HJTM38TuZ0M39n2K9AvdQuRwx7O8p9vvbCK5Q4R18dUrP
 NTkDcSaZkMUf+Mrs0m2h1o1H4jFtoe0CfLs/HhWRQv2tgeMcGfoujuULbzVvsWLY/cjWy99+h
 VZ9kSa4764Pnjq59YcRDGffRdoWDznT8SrucM1WcTQjft5OSRFiHc+o97CPEMJ6IUPaUJ4R8K
 vZCKLjM6SqvFzhaG63oRau0d436n6RnHtP868vFf7h56pxIFKrEB1hPcZRr3vxBtU74KmoEEn
 vUvRPnuJd9ug5D3SPjz1Egk48cLUn7dLgMwFghmP2fvKk1SSAm1IplAjWVMjzbSlhLvmnf3Dp
 fWEFIaCqINiZnCboD0ZAWxp4Ohh9CHCtra9YbiaP0Q0XgDVzYrAZ4NswlaZjdQHUzjBS23EVD
 TIVwL3hGywk8gjwuWIzbRu9hq4iYUMq9JRLpn0nwU7DreaqCE3fs5kio9fT9QNnWT1s4vT1kF
 IWkgIC2McGdLYuD/kK6CFJgQ==

Am 06.09.24 um 11:50 schrieb Jarkko Sakkinen:
> On Fri Sep 6, 2024 at 9:09 AM EEST, Stefan Wahren wrote:
>> In case of SPI wiring issues (e.g. MISO pin permanent high) the
>> core init won't provide any error message on failure. Add some
>> helpful error messages to tpm_tis_core_init(), which helps
>> to better understand why the driver won't probe.
>>
>> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
>> ---
>>   drivers/char/tpm/tpm_tis_core.c | 15 ++++++++++++---
>>   1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis=
_core.c
>> index fdef214b9f6b..830e331fcebe 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -1133,8 +1133,10 @@ int tpm_tis_core_init(struct device *dev, struct=
 tpm_tis_data *priv, int irq,
>>   	dev_set_drvdata(&chip->dev, priv);
>>
>>   	rc =3D tpm_tis_read32(priv, TPM_DID_VID(0), &vendor);
>> -	if (rc < 0)
>> +	if (rc < 0) {
>> +		dev_err(dev, "Failed to read TPM_DID_VID register: %d\n", rc);
>>   		return rc;
>> +	}
>>
>>   	priv->manufacturer_id =3D vendor;
>>
>> @@ -1162,19 +1164,25 @@ int tpm_tis_core_init(struct device *dev, struc=
t tpm_tis_data *priv, int irq,
>>   		chip->ops->clk_enable(chip, true);
>>
>>   	if (wait_startup(chip, 0) !=3D 0) {
>> +		dev_err(dev, "TPM device not accessible (0x%0x)\n",
>> +			vendor);
>>   		rc =3D -ENODEV;
>>   		goto out_err;
>>   	}
>>
>>   	/* Take control of the TPM's interrupt hardware and shut it off */
>>   	rc =3D tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask=
);
>> -	if (rc < 0)
>> +	if (rc < 0) {
>> +		dev_err(dev, "Failed to read TPM_INT_ENABLE register: %d\n", rc);
>>   		goto out_err;
>> +	}
>>
>>   	/* Figure out the capabilities */
>>   	rc =3D tpm_tis_read32(priv, TPM_INTF_CAPS(priv->locality), &intfcaps=
);
>> -	if (rc < 0)
>> +	if (rc < 0) {
>> +		dev_err(dev, "Failed to read TPM_INTF_CAPS register: %d\n", rc);
>>   		goto out_err;
>> +	}
>>
>>   	dev_dbg(dev, "TPM interface capabilities (0x%x):\n",
>>   		intfcaps);
>> @@ -1209,6 +1217,7 @@ int tpm_tis_core_init(struct device *dev, struct =
tpm_tis_data *priv, int irq,
>>
>>   	rc =3D tpm_tis_request_locality(chip, 0);
>>   	if (rc < 0) {
>> +		dev_err(dev, "Failed to request locality (0x%0x)\n", vendor);
>>   		rc =3D -ENODEV;
>>   		goto out_err;
>>   	}
>> --
>> 2.34.1
> No thanks. It not only adds helpful messages but has potential to add
> unwanted merge conflicts.
So this is a general NAK?

So with every setup where the driver exits without an error message, the
developer should add its own debug?
>
> BR, Jarkko


