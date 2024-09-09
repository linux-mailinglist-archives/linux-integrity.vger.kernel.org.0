Return-Path: <linux-integrity+bounces-3497-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB44972020
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Sep 2024 19:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD1851F243FC
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Sep 2024 17:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9DA13A885;
	Mon,  9 Sep 2024 17:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="KPlyNgRU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3CB168BD;
	Mon,  9 Sep 2024 17:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902187; cv=none; b=SUp7kktRRzSvp0xKPo5ewnd8LRwQqjCINgFWQ+D7dodeNiXr2/5IhtQLkLp+WENZXtqcm8m9HmpXDGIk17dBXdYQtC6MkUsOMzY1kOC5OdpYD+fp08PLKCLjNVk2vh75+VvmSNGS+5fttMH/h33NCsCroFAiU7Qk/x9MlKVuk2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902187; c=relaxed/simple;
	bh=WdtjfJfFax49BUXe0J2NEx13L4l5Io4Wb1Jd8zgQ8i4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y+VI/OrJXOdX4w5n4t2nqSV0uKTrx58VLE3wYIuNyZ+rjCQqg05bndr1Ldh5Tpw1/3aPVjrbtOhhXX8MCqtMWCAcNsMpc631qTfJsaoHraQ9B5FAbHRM8hKNZDKcf37QWjm1mywRwarj1DjA+q+tG7q4F8Hg9X7rQ3nfyD/TS+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=KPlyNgRU; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1725902175; x=1726506975; i=wahrenst@gmx.net;
	bh=419wjomNzniGm9B42Dz+raTwDB9f2lxhiCspgj9PUqE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KPlyNgRUZwGhIPnyJsLZFLwuMuDEEYebaB+CU5pm07GuE+HMuqCLQYrV9Rl0vf2G
	 7AN8WNPv3yA1zTYdENOVI3vEq+DV/AqYTVoYGeWVEWXZEb8/ajXsxur4vxRwZpT9X
	 TL2FakbroHnzz0JncHu6k6mtgU9Xd3bdaDMqoX5yFTOgi6fM+fVbIMhQ/PYxQb2hv
	 xtR4/JDBldSRLDIXRhZLds2ELAVsT+qEFx+KHs3+FRJpWUgn33SN+UmaeUEoeNOMy
	 N+wAux3ItkDoRptK3cnpe9kPi0j4GpCRwGHMI9OW1zWPrPnJyjZI+9NPZ4pHie2eo
	 f6mSedNGj5xaarlNnw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.128] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mt79P-1rudMs1oOv-015Vsj; Mon, 09
 Sep 2024 19:16:15 +0200
Message-ID: <2e3f270e-4c18-490f-8f18-87a422818cb6@gmx.net>
Date: Mon, 9 Sep 2024 19:16:14 +0200
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
 <e7d402f4-0463-4bb2-b1ea-afb36a58e59a@gmx.net>
 <D41X15Z6ZQ4K.3HGVA7H9C6PJ5@kernel.org>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <D41X15Z6ZQ4K.3HGVA7H9C6PJ5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DZX4RHmuZ66cfpVGYRE8AlnbNEFL/vQbMXJgKiJ0x13FeB0xyRM
 xd+51E/Wb6dktCTZ7B4XnjUrybpN7Fuu2qhAna58FIUP0A5WGKW1jEhr18Oja3zDSmxYBIB
 B+h9xndcVLLXucWad/XaZoYp+4mhbZYCiFglLxTnXt9m0JkFbvQmLj+SE9+7hROeCpv1x88
 /2q8ITitFf6bDLYdAahSg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rPgDiUKqz2E=;BS/1AaBoKLBHsnNHswKYEeUNra6
 VJCkFMl5B9CRWOGUCMIXPBCWY/F6SXDGl43ofiMbRN/ht1Ji2GeE85rvL3OI/aLMnewRwbhyM
 XsLkFfkF4jhLN84CzfbwcIRdmuvjfoRc7Z+Y6IJzQu2QFrUaqPsbN1yYzHbhp34WQUGAuSsmp
 rXSpVthbtx7mHEU5W3P5Kwjd3dEW6+NzJ4rLeb3HN5hAXNdpLlCVwGSt/zUA0SfyMINTCrRLl
 8Rwrp/oLi6AFmt24OPHLXQqbosCIh/q7/Z4qoKb9L/bEvaKUjws3uCMZCscIoU+0T1tnWmpIX
 mOlFPNRon6j99113bTevKawukwztCEBQ08/eXL/eVXJq+l2Cr8KaSHgV826v/b4EDsRefNE6w
 7Cy1CfKeCsCgrcCOOr8+KgkC2NuG0a2EZWadB4m8JeEWYWI2QuQclssugHKIm8iTJt1QQQZu0
 8XvdjYy6nk1fBqxB3dh0Zb5UrYm72lEphFLvikxFJijDt4miWyfDLznWw42oTEF3hQBpyMCw+
 6z0jbU612J5PG831KKrZ0flFAreXwSPIAVLbqFnTqlaustJ5aDKGfmXqj1Uh3Lpx0+OhNyDsY
 Nh8vejCzFXQaU1dGScx7+E/hKN2zV6AqRBzdoeL+ICdBZ0Q3aTh10P1gg9tEclf4/3W1hROVy
 n4yhB3sV4YXOgNghOPSCve6xMZ5pIuRBRBYMF5kM7JX39ufRj3ghPVlrdhyE57zRtCQ45Dr6l
 xUfzlJ1JSvDhNqeIC/r3iQIBc/TCz3Bu2jn/Y6ABis//h+0lxGycuD9rbHboICfnvsZlao4If
 9YisP5qPEIfhGQg8XI3u1kXg==

Hi Jarkko,

Am 09.09.24 um 19:05 schrieb Jarkko Sakkinen:
> On Fri Sep 6, 2024 at 5:46 PM EEST, Stefan Wahren wrote:
>> Am 06.09.24 um 11:47 schrieb Jarkko Sakkinen:
>>> On Fri Sep 6, 2024 at 9:09 AM EEST, Stefan Wahren wrote:
>>>> According to TCG PC Client Platform TPM Profile (PTP) Specification
>>>> only SPI mode 0 is supported. In order to ensure the SPI controller
>>>> supports the necessary settings, call spi_setup() and bail out
>>>> as soon as possible in error case.
>>>>
>>>> This change should affect all supported TPM SPI devices, because
>>>> tpm_tis_spi_probe is either called direct or indirectly.
>>>>
>>>> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
>>>> ---
>>>>    drivers/char/tpm/tpm_tis_spi_main.c | 11 +++++++++++
>>>>    1 file changed, 11 insertions(+)
>>>>
>>>> diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/t=
pm_tis_spi_main.c
>>>> index 61b42c83ced8..e62d297b040e 100644
>>>> --- a/drivers/char/tpm/tpm_tis_spi_main.c
>>>> +++ b/drivers/char/tpm/tpm_tis_spi_main.c
>>>> @@ -248,6 +248,17 @@ static int tpm_tis_spi_write_bytes(struct tpm_ti=
s_data *data, u32 addr,
>>>>    int tpm_tis_spi_init(struct spi_device *spi, struct tpm_tis_spi_ph=
y *phy,
>>>>    		     int irq, const struct tpm_tis_phy_ops *phy_ops)
>>>>    {
>>>> +	int ret;
>>>> +
>>>> +	spi->mode &=3D ~SPI_MODE_X_MASK;
>>>> +	spi->mode |=3D SPI_MODE_0;
>>>> +
>>>> +	ret =3D spi_setup(spi);
>>>> +	if (ret < 0) {
>>>> +		dev_err(&spi->dev, "SPI setup failed: %d\n", ret);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>>    	phy->iobuf =3D devm_kmalloc(&spi->dev, SPI_HDRSIZE + MAX_SPI_FRAM=
ESIZE, GFP_KERNEL);
>>>>    	if (!phy->iobuf)
>>>>    		return -ENOMEM;
>>>> --
>>>> 2.34.1
>>> Why?
>> SPI protocol driver usually call spi_setup to verify that the SPI
>> controller accept the settings (SPI mode, bit, clock rate ...). Bailing
>> out early is more helpful for debugging issues.
> What problem has this patch solved for you? I think it makes the code
> only less robust and more error prone.
this is not a fix for an issue i was experiencing.

It is just an improvement to catch possible invalid settings which has
been passed via DT device for example or the SPI controller doesn't
support SPI mode 0.
>
> BR, Jarkko


