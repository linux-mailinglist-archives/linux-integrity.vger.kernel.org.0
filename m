Return-Path: <linux-integrity+bounces-3491-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BACBE96F748
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Sep 2024 16:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71F7E1F2371F
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Sep 2024 14:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4F81D1739;
	Fri,  6 Sep 2024 14:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="KVLZ0SaF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4107A1D1757;
	Fri,  6 Sep 2024 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634025; cv=none; b=hMFUVIiAcp1RgDh5dqyQnUgvv6qotUVVp1M2vP0XYWOWPXfIwI/Kxir1piEgMLIVxjtEmbCuAqoFETcOhcxent14R0yYDJ7lUJN9J5jMv3Adm33jPLB7aGCVBV7oEZHeJ79xUCWJaBpi64Wl+blAfLIHzhpisY4ruAWaBxiyXZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634025; c=relaxed/simple;
	bh=mjoEV2nkxba7NXpNAx69U1z4LUgw2JnPKYzgeXvhE0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p8kVcEbn172JfhHOw7ZsIp9thKmMpEFK0RsAzL9LoIxxDKoU/EMOLqQ0s2KN1ha15i9uTsyFSeMZDPVSVyecg6SD5zw+31NPAV62OqaGvuAL5ahWViSAVbtmrvft5r0Jyy3CimIhH2GN2FNnRQt1jqtQYHBRco5dqbKniRUWo0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=KVLZ0SaF; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1725634013; x=1726238813; i=wahrenst@gmx.net;
	bh=Sb49VtVwriQo+XRQ7LTW/AS3NXjs/HP8dJ9KabtiuUg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KVLZ0SaFkzFq5XtaJGJCdlz45uv5z+CErIBtDUZsohcsMh5m2Cyal3Dm6IdXNZ2C
	 Y+f4cz4/wmENYY2aC5NkCRAra5UJlTNUSuTHzDXQjiQUZo7vLSHNiTE6t1YRCOGba
	 sgNqdR9zJZRJohK+wgUvD+tWtx2x1KyJg4Z8rn59VIYZ+/5xMb+LkjW1eLIl4XRuU
	 No0Z2siPU73DxD891SVW0lKZ5aK40YbkF4it2eFR0YkVrHRE8mkkXYDXtwr+oilBN
	 IH9pyfr5J834yIAZ7qRsLvVk1kZn5M2GOnVb671+QmYpgnzpcx6/OO5C9oWd56+H6
	 FpDoAwhfIvw133DfSQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSKy8-1sbhC91Fg8-00JBRK; Fri, 06
 Sep 2024 16:46:53 +0200
Message-ID: <e7d402f4-0463-4bb2-b1ea-afb36a58e59a@gmx.net>
Date: Fri, 6 Sep 2024 16:46:52 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] tpm: tpm_tis_spi: Ensure SPI mode 0
To: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
 Stefan Berger <stefanb@linux.ibm.com>
References: <20240906060947.4844-1-wahrenst@gmx.net>
 <20240906060947.4844-2-wahrenst@gmx.net>
 <D3Z3UFHWQ3MG.N8JU7ZHX3XHN@kernel.org>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <D3Z3UFHWQ3MG.N8JU7ZHX3XHN@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a8/Tmf8EmFEoGVVPHZ8c1mImK/BZzqO7BIjYDqiGN8cy37gjo2T
 FLbfbjRnuFcgL8wtG8bneJzXzItPMdLZBqMMFgvlUrnoYAHTI9pCkdQ8WV3oL6Wse0Nx9Jy
 xCAk73/IGORP/nHCP5x2ngsORprEBm3aLqFuOq75q+wcejD+/qNRFNwmeuDWoj1tz8hCsuN
 oXNW+wzNsisv9B8Yp5RKQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kd4zzV9Q6rg=;H1FbPddwM33ZjaGIFzCKmdk7lxV
 0/t0j8Gyq/GAV28xZBlm6s9fi73xCVxx92BeIKUaDa2uvyA0/8cSleaMGjfeB4eWdwEYP5k0r
 wiR7rxn1SdfpTRmJ3Wgt856ExmyjgqBQ7mTBRJFtnjfFZOhI7mX5LVH7yEcH6iXsODLtUsoy2
 f5HCM+KCjA7wvRceXqsiSTeeFTQFboMt5dxPJ0np7OLg+eOsm2Uay0e2QkSSSkHrXg7bsI5ov
 0wpMwEhdn73IAgJagtpF7UllmBc4aeYk0o8WxMApucp6ILxRH6QgVh6EAjdEuPMHoUFbe+X5A
 5u0+uvvWimsL+d0olB0EiVG982XKkBd8yuQ3inWVb5tMJu2uozT+iDEWEVWPD6oGyWr92zql+
 FK59WccTP7g1Sp1c0IIE13FDJUdGZvp/rS+QZ6duN8UQyq58+FVo/7ZBq0tq5+qVtHjxoKhzF
 IYD4jcm85oU6zDn9b7TDQSQWDdcn5FtLgTxQ2pf/Ift8nUw/ki5+PlPZSub6QoSUAypummZBf
 uKEr7oPQexH+W+oR4L03zEsDMh6PsQIbVomXZ/F9aQvgrw3Sf0XXqICJcs0r26TqssMbc8Hr5
 PF8amJfNA9IycHrSTvJE0eG+X3IzlazwWmMCpTR9/58OA9/9Poa+Dfe+JVgmkoq+nhmN7Fxla
 lloCQGuFi9peqoz91jJ0dCyLufFGJ2BfaYiI2xpNbI3wfPBXy9e8PQ2wn3ZqAmtplOXZpXMYT
 wp77a3W4fPlq/MrG2Rk8s1LwTXP/zt+cR5soCD1Y93DeOU12VrDm+LDHfJZx0ZoTOPYjUHw1Z
 /lAN+TvpmG97Y14JGxD5X32g==

Am 06.09.24 um 11:47 schrieb Jarkko Sakkinen:
> On Fri Sep 6, 2024 at 9:09 AM EEST, Stefan Wahren wrote:
>> According to TCG PC Client Platform TPM Profile (PTP) Specification
>> only SPI mode 0 is supported. In order to ensure the SPI controller
>> supports the necessary settings, call spi_setup() and bail out
>> as soon as possible in error case.
>>
>> This change should affect all supported TPM SPI devices, because
>> tpm_tis_spi_probe is either called direct or indirectly.
>>
>> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
>> ---
>>   drivers/char/tpm/tpm_tis_spi_main.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm=
_tis_spi_main.c
>> index 61b42c83ced8..e62d297b040e 100644
>> --- a/drivers/char/tpm/tpm_tis_spi_main.c
>> +++ b/drivers/char/tpm/tpm_tis_spi_main.c
>> @@ -248,6 +248,17 @@ static int tpm_tis_spi_write_bytes(struct tpm_tis_=
data *data, u32 addr,
>>   int tpm_tis_spi_init(struct spi_device *spi, struct tpm_tis_spi_phy *=
phy,
>>   		     int irq, const struct tpm_tis_phy_ops *phy_ops)
>>   {
>> +	int ret;
>> +
>> +	spi->mode &=3D ~SPI_MODE_X_MASK;
>> +	spi->mode |=3D SPI_MODE_0;
>> +
>> +	ret =3D spi_setup(spi);
>> +	if (ret < 0) {
>> +		dev_err(&spi->dev, "SPI setup failed: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>>   	phy->iobuf =3D devm_kmalloc(&spi->dev, SPI_HDRSIZE + MAX_SPI_FRAMESI=
ZE, GFP_KERNEL);
>>   	if (!phy->iobuf)
>>   		return -ENOMEM;
>> --
>> 2.34.1
>
> Why?
SPI protocol driver usually call spi_setup to verify that the SPI
controller accept the settings (SPI mode, bit, clock rate ...). Bailing
out early is more helpful for debugging issues.
>
> BR, Jarkko


