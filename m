Return-Path: <linux-integrity+bounces-6142-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 670C0AAC4C3
	for <lists+linux-integrity@lfdr.de>; Tue,  6 May 2025 14:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860743B92FD
	for <lists+linux-integrity@lfdr.de>; Tue,  6 May 2025 12:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF84279350;
	Tue,  6 May 2025 12:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EkjymPD1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A979B25CC58
	for <linux-integrity@vger.kernel.org>; Tue,  6 May 2025 12:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746536233; cv=none; b=lioBrV6dRg2LbS3In8knfQK2HFkaxEeWNc0X/wRR4g5JB8xmZmu4fgAe5xghA9HnzgMnuwVqQrFb87HtOr54YBVyAvUZew/rk6cnkEBTTyllky6L1GRGB73+QFXOChBgKY1OaDd60aIWUcp0Pu4Cuie4sBBUZP+CY068F0SmlO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746536233; c=relaxed/simple;
	bh=MNJbHso8E91OhnvW/LhFYmsR+iWQAS/V0ztFLGfWaKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KiAm9zpvwmg9wYzXvYJVxmaqRtgMhLjTShspDig8gXH2/n20XhY8kqVqIJz2uxnv+Y3JVhRkAltaBltxe3m2RDcLgbRKMcEL8QrzSV1fDl66GDAQ4Lc1WCZL1SZYzrHVbKNhoaUY4+KwUTGc7wFG0QhFihD6ewGzbnE32lW0pjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EkjymPD1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746536230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XFgp51xIgtMeesg3xOWTrCmCGlhlNJzM52JiSzpJIP4=;
	b=EkjymPD1a/yrdgYFNxyhLxOqHBR0VXH1uVNqVqWvs3u8s3RVVM7ZYh47AQTja/8bdtDMBY
	takig3SAtpvNNzBMElUkaXgxJtvPzKAUvbSSQ4CKqVRawXpyfAIT7s9n/S1c/t5QTutCw5
	qYBZyfqU57uzsotdcgtGPffwg1taOVA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-vusfOXPkMHCCL9ppFSfa8A-1; Tue, 06 May 2025 08:57:09 -0400
X-MC-Unique: vusfOXPkMHCCL9ppFSfa8A-1
X-Mimecast-MFC-AGG-ID: vusfOXPkMHCCL9ppFSfa8A_1746536228
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39ac9b0cb6aso2324717f8f.2
        for <linux-integrity@vger.kernel.org>; Tue, 06 May 2025 05:57:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746536228; x=1747141028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFgp51xIgtMeesg3xOWTrCmCGlhlNJzM52JiSzpJIP4=;
        b=g6cjk/c4IwL5I7gdWJKa3cE82zUVtNU6zkJKS/KzUG83R2Uet8fC8RTpoUBGpQZ0Vw
         pxafvpSCD3oTVzgnDOPJQOk7ugJm6XrKvb9Q2rxqAJtXBqnhWdPUKwkO0XvB98Mqkzwy
         bJlJRPzRgnyaRrhfjydHUxTqqLCrLoH4CbP+EJS4mOSa7jZkUBKwdWJcTy7SyN0vUouq
         /NQvLXS44N4awxfC1xbf4gfWR+c4D2+ApfYL5lSJhGQShq2NAJATZZZ0APHkVtf+9C/Q
         IWpmbcEKSLyAU5KYEKADvREevajT5h8+Q+EPcaCH9mMZ9q7tQ8TrqeNMqOc9HJNtNhVj
         ggIA==
X-Forwarded-Encrypted: i=1; AJvYcCXHCjPGLWg+QW7hWiicMJIamEggChPNMFBWI4/tedPJBY/tB+BR3Kg1fAOgcMJ9hKyDHGYy1eQYL0ySc8I3oHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8DbfcrL97Rtliag2ltFcDVrHuE73flgoyMfrZHtKp75Da2opI
	uEDqf+Chizqa5sPwElai37/L5t/t9pRTw/1isiF0EfdnbZBOp0+L8KOjtuzO6lIrU1ywUsEXQPC
	LhKcd8R1G+vuJ015cxLdvmNP5N3kAd+zsHhK9TeGhgJ6ekke/k9nX65EmGKEuEzZcWQ==
X-Gm-Gg: ASbGnctVb1ylJr7O929vMJRMKwVhsCE9QZxFD8inTM5x305H0Usl13aCl303Sh4C9Vp
	yh9Fpc9FP9eq/S+68xHzcC8Tfis7HRbLeyFgKwSOE8LJ5/rfrlOdFjFAaYHLjrHU8ERoBTtzVDn
	/NXXma1B2I4aghXekqHYacKmrPJfazodIUoE1r5a/q7NsVGhf4KgVpURKqISo13s8XAIU4QybZ5
	YJZnuUbOF69X2DIfLZhLBw+BsJwxwsAJA8I8fkGpvmvehCVnoV2Mm9zjYOht6UD/ZTlVZDb8RQ7
	p6+Wh/YHuYrhd7nJ
X-Received: by 2002:a5d:584d:0:b0:3a0:7fd4:2848 with SMTP id ffacd0b85a97d-3a0ac3eb15bmr2544847f8f.52.1746536227910;
        Tue, 06 May 2025 05:57:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESBLa6hkPiOG2btr3qNJwKDWalQ6kHBu+tV3hDT/rTtH40mJeupTlnchUXXZnxabePPxMG5Q==
X-Received: by 2002:a5d:584d:0:b0:3a0:7fd4:2848 with SMTP id ffacd0b85a97d-3a0ac3eb15bmr2544810f8f.52.1746536227166;
        Tue, 06 May 2025 05:57:07 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.145.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae0cd6sm13513664f8f.5.2025.05.06.05.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 05:57:06 -0700 (PDT)
Date: Tue, 6 May 2025 14:56:54 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Peter Huewe <peterhuewe@gmx.de>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Jens Wiklander <jens.wiklander@linaro.org>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Naveen N Rao <naveen@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, 
	linuxppc-dev@lists.ozlabs.org, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, linux-integrity@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Sumit Garg <sumit.garg@kernel.org>, linux-kernel@vger.kernel.org, 
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v3 1/4] tpm: add buf_size parameter in the .send callback
Message-ID: <o72kb2x2jjxyzgyixeva42sk3lr2wwphnyhkcdbxxgfevoqp3n@ir6rwldztmt7>
References: <20250414145653.239081-1-sgarzare@redhat.com>
 <20250414145653.239081-2-sgarzare@redhat.com>
 <aBJETstuSlBUMwj1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aBJETstuSlBUMwj1@kernel.org>

On Wed, Apr 30, 2025 at 06:39:58PM +0300, Jarkko Sakkinen wrote:
>On Mon, Apr 14, 2025 at 04:56:50PM +0200, Stefano Garzarella wrote:
>> From: Stefano Garzarella <sgarzare@redhat.com>
>>
>> In preparation for the next commit, add a new `buf_size` parameter to
>> the `.send` callback in `tpm_class_ops` which contains the entire buffer
>> size. In this patch it is pretty much ignored by all drivers, but it will
>> be used in the next patch.
>
>So instead "in preparation for the next commit" just plain say why it
>will be needed. "next commit" is a fuzzy reference :-)
>
>Same goes for "next patch". Neither can be used to query any possible
>information. That sort of makes the whole paragraph useless, once it
>is in the commit log.

Got it! What about somethig like this:

    Add a new `buf_size` parameter to the `.send` callback in
    `tpm_class_ops`. This parameter will allow drivers to differentiate
    between the actual command length to send and the total buffer
    size. Currently `buf_now` is not used, but it will be used to
    support devices with synchronous `.send` callback to send the
    command and receive the response on the same buffer.

Thanks,
Stefano


>
>>
>> Also rename the previous parameter `len` to `cmd_len` in the
>> declaration to make it clear that it contains the length in bytes of the
>> command stored in the buffer. The semantics don't change and it can be
>> used as before by drivers. This is an optimization since the drivers
>> could get it from the header, but let's avoid duplicating code.
>>
>> While we are here, resolve a checkpatch warning:
>>   WARNING: Unnecessary space before function pointer arguments
>>   #66: FILE: include/linux/tpm.h:90:
>>   +	int (*send) (struct tpm_chip *chip, u8 *buf, size_t cmd_len,
>>
>> Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  include/linux/tpm.h                  | 3 ++-
>>  drivers/char/tpm/st33zp24/st33zp24.c | 2 +-
>>  drivers/char/tpm/tpm-interface.c     | 2 +-
>>  drivers/char/tpm/tpm_atmel.c         | 3 ++-
>>  drivers/char/tpm/tpm_crb.c           | 2 +-
>>  drivers/char/tpm/tpm_ftpm_tee.c      | 4 +++-
>>  drivers/char/tpm/tpm_i2c_atmel.c     | 3 ++-
>>  drivers/char/tpm/tpm_i2c_infineon.c  | 3 ++-
>>  drivers/char/tpm/tpm_i2c_nuvoton.c   | 3 ++-
>>  drivers/char/tpm/tpm_ibmvtpm.c       | 6 ++++--
>>  drivers/char/tpm/tpm_infineon.c      | 3 ++-
>>  drivers/char/tpm/tpm_nsc.c           | 3 ++-
>>  drivers/char/tpm/tpm_svsm.c          | 3 ++-
>>  drivers/char/tpm/tpm_tis_core.c      | 3 ++-
>>  drivers/char/tpm/tpm_tis_i2c_cr50.c  | 6 ++++--
>>  drivers/char/tpm/tpm_vtpm_proxy.c    | 4 +++-
>>  drivers/char/tpm/xen-tpmfront.c      | 3 ++-
>>  17 files changed, 37 insertions(+), 19 deletions(-)
>>
>> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
>> index 6c3125300c00..2e38edd5838c 100644
>> --- a/include/linux/tpm.h
>> +++ b/include/linux/tpm.h
>> @@ -87,7 +87,8 @@ struct tpm_class_ops {
>>  	const u8 req_complete_val;
>>  	bool (*req_canceled)(struct tpm_chip *chip, u8 status);
>>  	int (*recv) (struct tpm_chip *chip, u8 *buf, size_t len);
>> -	int (*send) (struct tpm_chip *chip, u8 *buf, size_t len);
>> +	int (*send)(struct tpm_chip *chip, u8 *buf, size_t cmd_len,
>> +		    size_t buf_size);
>>  	void (*cancel) (struct tpm_chip *chip);
>>  	u8 (*status) (struct tpm_chip *chip);
>>  	void (*update_timeouts)(struct tpm_chip *chip,
>> diff --git a/drivers/char/tpm/st33zp24/st33zp24.c b/drivers/char/tpm/st33zp24/st33zp24.c
>> index c0771980bc2f..3de68bca1740 100644
>> --- a/drivers/char/tpm/st33zp24/st33zp24.c
>> +++ b/drivers/char/tpm/st33zp24/st33zp24.c
>> @@ -300,7 +300,7 @@ static irqreturn_t tpm_ioserirq_handler(int irq, void *dev_id)
>>   * send TPM commands through the I2C bus.
>>   */
>>  static int st33zp24_send(struct tpm_chip *chip, unsigned char *buf,
>> -			 size_t len)
>> +			 size_t len, size_t buf_size)
>>  {
>>  	struct st33zp24_dev *tpm_dev = dev_get_drvdata(&chip->dev);
>>  	u32 status, i, size, ordinal;
>> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
>> index 8d7e4da6ed53..3b6ddcdb4051 100644
>> --- a/drivers/char/tpm/tpm-interface.c
>> +++ b/drivers/char/tpm/tpm-interface.c
>> @@ -106,7 +106,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
>>  		return -E2BIG;
>>  	}
>>
>> -	rc = chip->ops->send(chip, buf, count);
>> +	rc = chip->ops->send(chip, buf, count, bufsiz);
>>  	if (rc < 0) {
>>  		if (rc != -EPIPE)
>>  			dev_err(&chip->dev,
>> diff --git a/drivers/char/tpm/tpm_atmel.c b/drivers/char/tpm/tpm_atmel.c
>> index 54a0360a3c95..5733168bfc26 100644
>> --- a/drivers/char/tpm/tpm_atmel.c
>> +++ b/drivers/char/tpm/tpm_atmel.c
>> @@ -148,7 +148,8 @@ static int tpm_atml_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>>  	return size;
>>  }
>>
>> -static int tpm_atml_send(struct tpm_chip *chip, u8 *buf, size_t count)
>> +static int tpm_atml_send(struct tpm_chip *chip, u8 *buf, size_t count,
>> +			 size_t buf_size)
>>  {
>>  	struct tpm_atmel_priv *priv = dev_get_drvdata(&chip->dev);
>>  	int i;
>> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
>> index 876edf2705ab..38f765a44a97 100644
>> --- a/drivers/char/tpm/tpm_crb.c
>> +++ b/drivers/char/tpm/tpm_crb.c
>> @@ -426,7 +426,7 @@ static int tpm_crb_smc_start(struct device *dev, unsigned long func_id)
>>  }
>>  #endif
>>
>> -static int crb_send(struct tpm_chip *chip, u8 *buf, size_t len)
>> +static int crb_send(struct tpm_chip *chip, u8 *buf, size_t len, size_t buf_size)
>>  {
>>  	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
>>  	int rc = 0;
>> diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
>> index 53ba28ccd5d3..637cc8b6599e 100644
>> --- a/drivers/char/tpm/tpm_ftpm_tee.c
>> +++ b/drivers/char/tpm/tpm_ftpm_tee.c
>> @@ -64,12 +64,14 @@ static int ftpm_tee_tpm_op_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>>   * @chip:	the tpm_chip description as specified in driver/char/tpm/tpm.h
>>   * @buf:	the buffer to send.
>>   * @len:	the number of bytes to send.
>> + * @buf_size:	the size of the buffer.
>>   *
>>   * Return:
>>   *	In case of success, returns 0.
>>   *	On failure, -errno
>>   */
>> -static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len)
>> +static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len,
>> +				size_t buf_size)
>>  {
>>  	struct ftpm_tee_private *pvt_data = dev_get_drvdata(chip->dev.parent);
>>  	size_t resp_len;
>> diff --git a/drivers/char/tpm/tpm_i2c_atmel.c b/drivers/char/tpm/tpm_i2c_atmel.c
>> index d1d27fdfe523..572f97cb9e89 100644
>> --- a/drivers/char/tpm/tpm_i2c_atmel.c
>> +++ b/drivers/char/tpm/tpm_i2c_atmel.c
>> @@ -37,7 +37,8 @@ struct priv_data {
>>  	u8 buffer[sizeof(struct tpm_header) + 25];
>>  };
>>
>> -static int i2c_atmel_send(struct tpm_chip *chip, u8 *buf, size_t len)
>> +static int i2c_atmel_send(struct tpm_chip *chip, u8 *buf, size_t len,
>> +			  size_t buf_size)
>>  {
>>  	struct priv_data *priv = dev_get_drvdata(&chip->dev);
>>  	struct i2c_client *client = to_i2c_client(chip->dev.parent);
>> diff --git a/drivers/char/tpm/tpm_i2c_infineon.c b/drivers/char/tpm/tpm_i2c_infineon.c
>> index 81d8a78dc655..25d6ae3a4cc1 100644
>> --- a/drivers/char/tpm/tpm_i2c_infineon.c
>> +++ b/drivers/char/tpm/tpm_i2c_infineon.c
>> @@ -514,7 +514,8 @@ static int tpm_tis_i2c_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>>  	return size;
>>  }
>>
>> -static int tpm_tis_i2c_send(struct tpm_chip *chip, u8 *buf, size_t len)
>> +static int tpm_tis_i2c_send(struct tpm_chip *chip, u8 *buf, size_t len,
>> +			    size_t buf_size)
>>  {
>>  	int rc, status;
>>  	ssize_t burstcnt;
>> diff --git a/drivers/char/tpm/tpm_i2c_nuvoton.c b/drivers/char/tpm/tpm_i2c_nuvoton.c
>> index 3c3ee5f551db..169078ce6ac4 100644
>> --- a/drivers/char/tpm/tpm_i2c_nuvoton.c
>> +++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
>> @@ -350,7 +350,8 @@ static int i2c_nuvoton_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>>   * tpm.c can skip polling for the data to be available as the interrupt is
>>   * waited for here
>>   */
>> -static int i2c_nuvoton_send(struct tpm_chip *chip, u8 *buf, size_t len)
>> +static int i2c_nuvoton_send(struct tpm_chip *chip, u8 *buf, size_t len,
>> +			    size_t buf_size)
>>  {
>>  	struct priv_data *priv = dev_get_drvdata(&chip->dev);
>>  	struct device *dev = chip->dev.parent;
>> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
>> index 76d048f63d55..660a7f9da1d8 100644
>> --- a/drivers/char/tpm/tpm_ibmvtpm.c
>> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
>> @@ -191,13 +191,15 @@ static int tpm_ibmvtpm_resume(struct device *dev)
>>   * tpm_ibmvtpm_send() - Send a TPM command
>>   * @chip:	tpm chip struct
>>   * @buf:	buffer contains data to send
>> - * @count:	size of buffer
>> + * @count:	length of the command
>> + * @buf_size:   size of the buffer
>>   *
>>   * Return:
>>   *   0 on success,
>>   *   -errno on error
>>   */
>> -static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
>> +static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t count,
>> +			    size_t buf_size)
>>  {
>>  	struct ibmvtpm_dev *ibmvtpm = dev_get_drvdata(&chip->dev);
>>  	bool retry = true;
>> diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
>> index 2d2ae37153ba..7896fdacd156 100644
>> --- a/drivers/char/tpm/tpm_infineon.c
>> +++ b/drivers/char/tpm/tpm_infineon.c
>> @@ -312,7 +312,8 @@ static int tpm_inf_recv(struct tpm_chip *chip, u8 * buf, size_t count)
>>  	return -EIO;
>>  }
>>
>> -static int tpm_inf_send(struct tpm_chip *chip, u8 * buf, size_t count)
>> +static int tpm_inf_send(struct tpm_chip *chip, u8 *buf, size_t count,
>> +			size_t buf_size)
>>  {
>>  	int i;
>>  	int ret;
>> diff --git a/drivers/char/tpm/tpm_nsc.c b/drivers/char/tpm/tpm_nsc.c
>> index 0f62bbc940da..12aedef3c50e 100644
>> --- a/drivers/char/tpm/tpm_nsc.c
>> +++ b/drivers/char/tpm/tpm_nsc.c
>> @@ -178,7 +178,8 @@ static int tpm_nsc_recv(struct tpm_chip *chip, u8 * buf, size_t count)
>>  	return size;
>>  }
>>
>> -static int tpm_nsc_send(struct tpm_chip *chip, u8 * buf, size_t count)
>> +static int tpm_nsc_send(struct tpm_chip *chip, u8 *buf, size_t count,
>> +			size_t buf_size)
>>  {
>>  	struct tpm_nsc_priv *priv = dev_get_drvdata(&chip->dev);
>>  	u8 data;
>> diff --git a/drivers/char/tpm/tpm_svsm.c b/drivers/char/tpm/tpm_svsm.c
>> index 4280edf427d6..d3ca5615b6f7 100644
>> --- a/drivers/char/tpm/tpm_svsm.c
>> +++ b/drivers/char/tpm/tpm_svsm.c
>> @@ -25,7 +25,8 @@ struct tpm_svsm_priv {
>>  	void *buffer;
>>  };
>>
>> -static int tpm_svsm_send(struct tpm_chip *chip, u8 *buf, size_t len)
>> +static int tpm_svsm_send(struct tpm_chip *chip, u8 *buf, size_t len,
>> +			 size_t buf_size)
>>  {
>>  	struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
>>  	int ret;
>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
>> index ed0d3d8449b3..5641a73ce280 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -580,7 +580,8 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
>>  	return rc;
>>  }
>>
>> -static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
>> +static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len,
>> +			size_t buf_size)
>>  {
>>  	int rc, irq;
>>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>> diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
>> index 3b55a7b05c46..1914b368472d 100644
>> --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
>> +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
>> @@ -546,13 +546,15 @@ static int tpm_cr50_i2c_tis_recv(struct tpm_chip *chip, u8 *buf, size_t buf_len)
>>   * tpm_cr50_i2c_tis_send() - TPM transmission callback.
>>   * @chip:	A TPM chip.
>>   * @buf:	Buffer to send.
>> - * @len:	Buffer length.
>> + * @len:	Command length.
>> + * @buf_size:	Buffer size.
>>   *
>>   * Return:
>>   * - 0:		Success.
>>   * - -errno:	A POSIX error code.
>>   */
>> -static int tpm_cr50_i2c_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
>> +static int tpm_cr50_i2c_tis_send(struct tpm_chip *chip, u8 *buf, size_t len,
>> +				 size_t buf_size)
>>  {
>>  	size_t burstcnt, limit, sent = 0;
>>  	u8 tpm_go[4] = { TPM_STS_GO };
>> diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
>> index 8fe4a01eea12..beaa84428b49 100644
>> --- a/drivers/char/tpm/tpm_vtpm_proxy.c
>> +++ b/drivers/char/tpm/tpm_vtpm_proxy.c
>> @@ -322,11 +322,13 @@ static int vtpm_proxy_is_driver_command(struct tpm_chip *chip,
>>   * @chip: tpm chip to use
>>   * @buf: send buffer
>>   * @count: bytes to send
>> + * @buf_size: size of the buffer
>>   *
>>   * Return:
>>   *      0 in case of success, negative error value otherwise.
>>   */
>> -static int vtpm_proxy_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t count)
>> +static int vtpm_proxy_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t count,
>> +				  size_t buf_size)
>>  {
>>  	struct proxy_dev *proxy_dev = dev_get_drvdata(&chip->dev);
>>
>> diff --git a/drivers/char/tpm/xen-tpmfront.c b/drivers/char/tpm/xen-tpmfront.c
>> index 80cca3b83b22..66a4dbb4a4d8 100644
>> --- a/drivers/char/tpm/xen-tpmfront.c
>> +++ b/drivers/char/tpm/xen-tpmfront.c
>> @@ -131,7 +131,8 @@ static size_t shr_data_offset(struct vtpm_shared_page *shr)
>>  	return struct_size(shr, extra_pages, shr->nr_extra_pages);
>>  }
>>
>> -static int vtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
>> +static int vtpm_send(struct tpm_chip *chip, u8 *buf, size_t count,
>> +		     size_t buf_size)
>>  {
>>  	struct tpm_private *priv = dev_get_drvdata(&chip->dev);
>>  	struct vtpm_shared_page *shr = priv->shr;
>> --
>> 2.49.0
>>
>>
>
>BR, Jarkko
>


