Return-Path: <linux-integrity+bounces-6325-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5691DAC650C
	for <lists+linux-integrity@lfdr.de>; Wed, 28 May 2025 11:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69B231BA6227
	for <lists+linux-integrity@lfdr.de>; Wed, 28 May 2025 09:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A672749F6;
	Wed, 28 May 2025 09:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+8/FF+o"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFEB2741B3
	for <linux-integrity@vger.kernel.org>; Wed, 28 May 2025 09:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748422824; cv=none; b=Jdt65Ik+ZK6Q8fXW8V3Mkbl/qB4tv1V4HaMmJpcFwmXuiSF/YlBORocQImvrqwrmy0LPJRiVunZwoy8hGgbP4HEprQaFW8dFDPm0tDoJWimSyfpH4csG7DX3bWnkpqWO3Cf2QHAqcwOj+nXb1UNUniAjKSMifrlXGIQ29JeMowo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748422824; c=relaxed/simple;
	bh=t1e/HvfosFpsLoFkhIGG8ncpvv+6aZviJ2nKgmWiOW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwnDxF03nWchpmqqGZv20SKFkG2hMToFg91xcMju8keIpUHgcpt+hQIoEkIamnIp6NzoksIHurFCfuQ0rMokMCO6FgczZamzvqn/hAe5+yuMb0Rs2PjdKnfgtNg8SOe+9SVAVQkdVW4TQAd0j8OQzsbDiiuO5p7J3tOsa6t10Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J+8/FF+o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748422821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=64QsXwazpQwW+tOYOMo7hDdSauBGVg6nC6ZKTpmi0VI=;
	b=J+8/FF+opcuDOX++0wvmaIQVrgvdohzjFJub7w3QEwfLxaSR0+odejqCDAv2eY86hC0jrn
	2HO6ATFtbcIrJcWZcaORcrq/vINBciOYyucZvfLdtD1w7Wq8dT7kU0rdMEwKD6iHcwGttY
	xP5MhGtjbxjxoLdb9QmsbhVgZsilMmM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-TPmQe2PUMp66pwY4VaupCw-1; Wed, 28 May 2025 05:00:20 -0400
X-MC-Unique: TPmQe2PUMp66pwY4VaupCw-1
X-Mimecast-MFC-AGG-ID: TPmQe2PUMp66pwY4VaupCw_1748422819
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a367b3bb78so2466692f8f.1
        for <linux-integrity@vger.kernel.org>; Wed, 28 May 2025 02:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748422819; x=1749027619;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=64QsXwazpQwW+tOYOMo7hDdSauBGVg6nC6ZKTpmi0VI=;
        b=SL3NDQrIJE54/3IPnZ597GLV4O5G30IHuzFZNDAh1cCfX0+CY/7/zvn5UGcMbzJR4V
         E9CzP0nHwrAS4OeefexuBREd71scwQBx4Lxw7LmpQ2VBqiJJ51OpCb/kcNMsmX/LSdRm
         pIKhECVeWB+LP5WHWcFCZvERKXs0CQa7n0D0IcmmRCaOOez9cWxFEqPABqc5guNKUbxT
         L1Dtbk1Rc7SpdSWxWvefXxelT71us5vFRL4bSAzcKrqsOYjXLKINqo4ksxlbWaWzi2vI
         x8TTRzmOyVGD/IzedCpO5EtZTQJ9o1sYWTaW+4VOJduqg3JIN6IUFJygRriU1VOY8/rh
         5VvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDbAFI+twGd1YlL/gWtOiAXQQRHYAfnazQGXXdE3AM3/7UOUleYfkbQDRr0ZDKBqYWA6kSuEf3e0YVVDqsY8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Njr4n1sA+K1Omt7iVV9/+TXWAqx6YZ/kBjsWzXl1eyislDSp
	WPWYUJfxYxzP5oEMfO6cVoXQ3hk795gOaNkqvuSJWdnU2ggWOqmRpy35mWq+FvZkgWF7sBJ+bOH
	KMl+kx9VeO85CPHu2GfIyyOjps0m7HPSh1R9KkJa9xSkU2YyBdN2kOz68w59NvKtq1ySOkg==
X-Gm-Gg: ASbGncuAU/RqAM5ZOn+XSZHYSLeafh1wUmsUzc6dtJ6nSuUcU2+EHqRCmZnWjeTi9mx
	GJtsnE4mb+eeAdtkY/uRXA1Xl5zerb+BboLox0W1yJlPSAgzA5YMRyVz3sbalUnRJ69yieATfuH
	DOFuCJAS6tkX4nB44i3oFcKEWHSfn2MAB3yedV9TIjwCWqXXXaed0AES86cCUPTd2RP2t4mqYnD
	rs1bWfzPCNjeEigrX9MnTWC+JaNtlsrvJZQg3TKMZXmk9uMpNAsONXfnYmp9t9dNlSmUjaiLHAG
	UvLS1Bo5hEDs16hnnHPT44FfZCGDFAnCYwt28+XdvVvjusyFMCZbPv7shxtJ
X-Received: by 2002:a5d:5f8b:0:b0:3a3:6595:921f with SMTP id ffacd0b85a97d-3a4cb4b822dmr12928264f8f.41.1748422818880;
        Wed, 28 May 2025 02:00:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjrV5vgUL5ysXDl7B3oxB4ovG+UqKk+QHfVQ+EndsK3P47vCbb2duzqpq4xfTjaqx9Sg54xQ==
X-Received: by 2002:a5d:5f8b:0:b0:3a3:6595:921f with SMTP id ffacd0b85a97d-3a4cb4b822dmr12928217f8f.41.1748422818345;
        Wed, 28 May 2025 02:00:18 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-35.retail.telecomitalia.it. [82.53.134.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4eab0b596sm892079f8f.0.2025.05.28.02.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 02:00:17 -0700 (PDT)
Date: Wed, 28 May 2025 11:00:12 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: lee@kernel.org, herbert@gondor.apana.org.au, jarkko@kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, davem@davemloft.net, 
	linux-crypto@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org, 
	Yinggang Gu <guyinggang@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v10 4/5] tpm: Add a driver for Loongson TPM device
Message-ID: <gymx5tbghi55gm76ydtuzzd6r522expft36twwtvpkbgcl266a@zelnthnhu7kq>
References: <20250528065944.4511-1-zhaoqunqin@loongson.cn>
 <20250528065944.4511-5-zhaoqunqin@loongson.cn>
 <7ifsmhpubkedbiivcnfrxlrhriti5ksb4lbgrdwhwfxtp5ledc@z2jf6sz4vdgd>
 <afaeb91a-afb4-428a-2c17-3ea5f098da22@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afaeb91a-afb4-428a-2c17-3ea5f098da22@loongson.cn>

On Wed, May 28, 2025 at 04:42:05PM +0800, Qunqin Zhao wrote:
>
>在 2025/5/28 下午3:57, Stefano Garzarella 写道:
>>>+    chip = tpmm_chip_alloc(dev, &tpm_loongson_ops);
>>>+    if (IS_ERR(chip))
>>>+        return PTR_ERR(chip);
>>>+    chip->flags = TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_IRQ;
>>
>>Why setting TPM_CHIP_FLAG_IRQ?
>
>When tpm_engine completes  TPM_CC* command,
>
>the hardware will indeed trigger an interrupt to the kernel.

IIUC that is hidden by loongson_se_send_engine_cmd(), that for this 
driver is completely synchronous, no?

>
>>
>>IIUC this driver is similar to ftpm and svsm where the send is 
>>synchronous so having .status, .cancel, etc. set to 0 should be 
>>enough to call .recv() just after send() in tpm_try_transmit(). See 
>>commit 980a573621ea ("tpm: Make chip->{status,cancel,req_canceled} 
>>opt")
>The send callback would wait until the TPM_CC* command complete. We 
>don't need a poll.

Right, that's what I was saying too, send() is synchronous (as in ftpm 
and svsm). The polling in tpm_try_transmit() is already skipped since we 
are setting .status = 0, .req_complete_mask = 0, .req_complete_val = 0, 
etc. so IMHO this is exactly the same of ftpm and svsm, so we don't need 
to set TPM_CHIP_FLAG_IRQ.

Thanks,
Stefano


