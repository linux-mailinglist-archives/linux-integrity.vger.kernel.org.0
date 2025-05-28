Return-Path: <linux-integrity+bounces-6330-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5D7AC6650
	for <lists+linux-integrity@lfdr.de>; Wed, 28 May 2025 11:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B356A4A4F11
	for <lists+linux-integrity@lfdr.de>; Wed, 28 May 2025 09:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6473227874F;
	Wed, 28 May 2025 09:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AFBtW3mi"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BA3A2D
	for <linux-integrity@vger.kernel.org>; Wed, 28 May 2025 09:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748426007; cv=none; b=LPXOw9aj7xtDLNtivzrotZGw46abASoDuywGptFcD89Ya8Fc83lClSvxCzLjjF0C+v5YZmrRUcQNkrKpAm5DMKAA8ZeuiNhIqVMlFtBircj05lWXSGejmuRELBKoFUQ8tgJboUPOnje29olJtQHn3zAv1MiqT2yyBPxPfXK/ZgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748426007; c=relaxed/simple;
	bh=Fmr3jwJi3YQouKuqcPQzlRUJ8rteCm7hNAGsR03cBig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DsoQcNPHjY1kI1axrXlVWBhcVkeQT+M6S4n93uisHKnGLEBiA1ZZwiG8yeGY/ugvWWOXIuLjBSJJgpQ6vEZ7XSLyKrXnKRRotgY5/hcYqqOTJ1qn7x4mBqFGvUBH5H4k1DXjs9KFRbgOzoWa7F3cfxMnS7IhS8ywG0WjPfEKolI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AFBtW3mi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748426004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W1u6n8V0ShIO4z2EdyC6/erq05zKheUuyNblwPdU87Q=;
	b=AFBtW3miO6wLnUZaZ+MSNl1QL1hYtOsCbLkPRQFt+GoknfemoaTVoScYVy9LWnbIKfgEbw
	53DUSQo++P6sPzu/HpvGUfsNWgotGpGMUvVYsUXx+xWYePJ7NKexvrydFDcwj9zDYY8akg
	AR3sqGtmNxCAaVLYvw09fAcnVlzV0t8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287--QThS6xMOSCNoa5XjGrKVA-1; Wed, 28 May 2025 05:53:23 -0400
X-MC-Unique: -QThS6xMOSCNoa5XjGrKVA-1
X-Mimecast-MFC-AGG-ID: -QThS6xMOSCNoa5XjGrKVA_1748426002
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-44b1f5b8e9dso16435125e9.2
        for <linux-integrity@vger.kernel.org>; Wed, 28 May 2025 02:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748426002; x=1749030802;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W1u6n8V0ShIO4z2EdyC6/erq05zKheUuyNblwPdU87Q=;
        b=f/yReEKNpEXTkNUKfLIQ6UXjLt02SWhPSO8MJOtiZDnKlieMHeBiz+UewKtOpr947l
         dv40m/iWKclfLqq7ywLyOqM7RFW9bTQG4ufIZeRc6almSpOnQkyeGW/ryf7tt+/+I3Cx
         s8kwQ1s1jv55T0qksm8Oomb4iJ2Cg74aJtiy8uRzlwU4I30cn87zBee7zXdFCI2ZkzwF
         3SDRBa9q3hUvxIdja+IGHx8ZkXiV3aDZoiu0ii6vsG6ywEwVGoRCKXZmSi+3zrPuPq/J
         ern7SrRTC/vgozOzBX1sTjh7nUlX8MJ56zOxHF3gcJCYagxAY/Lo6sKuMlDurNJsgWcz
         HuBg==
X-Forwarded-Encrypted: i=1; AJvYcCV04aZ9GIOIy5rgtkmNKvAhH13SFSb/qKwsMJy5S/vHM3YhuG2673Qykkf88W1rgcTmJl/f22tI+0a96YNWY4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU5qlkX8aKY5TP5nsdRknjmlJVDWLQmsOakQ/LfffB5Z7f1L2B
	S3UeY0iuP+5LcrYlmML1v+xkbankaXY/rVxp03Znt46CCRHbzS7vG6TnY+OREoia9+/F2KHJhec
	XOOaiaTCqn8p254Omlb9Zgd2Zou8CRgkLirpAl/JkeArry0cwv1+YnDHzC8LOhIIU8WEW9Q==
X-Gm-Gg: ASbGnctlYr7y/hStDQ3yPVogA3DN3J/Ng9xKor7ggbnKFiFWBoXOt1iRHZk+huSZN1K
	+/1mOOGImS459yQxpCmtOBDlGtc5a9fwFVeZgQJNZaBo+zUs30qmVi13mWj8wcTukSYIRldxBfv
	HWQ7mHRD+4eO8UQl04HoonwEambcO70bLn6hw4mYv0NG9tcKaauEZJbhUNQKAxWqJyBtMTTSfd2
	2TdTgHYqFjCg8mTfCjQt26bXiFKzA7kurWHKAjoWoTdz5G2aUFPpV/tQoytxlrXLtZxq8FCDbD5
	WI+fT0rHjHplQCeNtsT3EwxTqxIQYmsS5euZAl6iv2aK0apF157nWEqds2OR
X-Received: by 2002:a05:600c:1e1c:b0:441:d438:4ea5 with SMTP id 5b1f17b1804b1-44c9493e6b1mr125991215e9.20.1748426002025;
        Wed, 28 May 2025 02:53:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKtV2CLo/am9z3wUFY2sht7iYltOSuslBrVCVGBjCH19eoPNr5lIJ6KpopXopItx64UQR2OA==
X-Received: by 2002:a05:600c:1e1c:b0:441:d438:4ea5 with SMTP id 5b1f17b1804b1-44c9493e6b1mr125990955e9.20.1748426001537;
        Wed, 28 May 2025 02:53:21 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-35.retail.telecomitalia.it. [82.53.134.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450787ccbd1sm12032595e9.25.2025.05.28.02.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 02:53:21 -0700 (PDT)
Date: Wed, 28 May 2025 11:53:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: lee@kernel.org, herbert@gondor.apana.org.au, jarkko@kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, davem@davemloft.net, 
	linux-crypto@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org, 
	Yinggang Gu <guyinggang@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v10 4/5] tpm: Add a driver for Loongson TPM device
Message-ID: <45xqguhrecn57cwc66hfws4eeqrb6rlijvh2z35e56ogojc2q4@pnlrgx57353b>
References: <20250528065944.4511-1-zhaoqunqin@loongson.cn>
 <20250528065944.4511-5-zhaoqunqin@loongson.cn>
 <7ifsmhpubkedbiivcnfrxlrhriti5ksb4lbgrdwhwfxtp5ledc@z2jf6sz4vdgd>
 <afaeb91a-afb4-428a-2c17-3ea5f098da22@loongson.cn>
 <gymx5tbghi55gm76ydtuzzd6r522expft36twwtvpkbgcl266a@zelnthnhu7kq>
 <ccb1927d-c06a-9fde-6cbb-652974464f4b@loongson.cn>
 <cfaf2fbb-5c6a-9f85-fdc9-325d82fb7821@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cfaf2fbb-5c6a-9f85-fdc9-325d82fb7821@loongson.cn>

On Wed, May 28, 2025 at 05:34:49PM +0800, Qunqin Zhao wrote:
>
>在 2025/5/28 下午5:24, Qunqin Zhao 写道:
>>
>>在 2025/5/28 下午5:00, Stefano Garzarella 写道:
>>>On Wed, May 28, 2025 at 04:42:05PM +0800, Qunqin Zhao wrote:
>>>>
>>>>在 2025/5/28 下午3:57, Stefano Garzarella 写道:
>>>>>>+    chip = tpmm_chip_alloc(dev, &tpm_loongson_ops);
>>>>>>+    if (IS_ERR(chip))
>>>>>>+        return PTR_ERR(chip);
>>>>>>+    chip->flags = TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_IRQ;
>>>>>
>>>>>Why setting TPM_CHIP_FLAG_IRQ?
>>>>
>>>>When tpm_engine completes  TPM_CC* command,
>>>>
>>>>the hardware will indeed trigger an interrupt to the kernel.
>>>
>>>IIUC that is hidden by loongson_se_send_engine_cmd(), that for 
>>>this driver is completely synchronous, no?
>>>
>>>>
>>>>>
>>>>>IIUC this driver is similar to ftpm and svsm where the send is 
>>>>>synchronous so having .status, .cancel, etc. set to 0 should 
>>>>>be enough to call .recv() just after send() in 
>>>>>tpm_try_transmit(). See commit 980a573621ea ("tpm: Make 
>>>>>chip->{status,cancel,req_canceled} opt")
>>>>The send callback would wait until the TPM_CC* command complete. 
>>>>We don't need a poll.
>>>
>>>Right, that's what I was saying too, send() is synchronous (as in 
>>>ftpm and svsm). The polling in tpm_try_transmit() is already 
>>>skipped since we are setting .status = 0, .req_complete_mask = 0, 
>>>.req_complete_val = 0, etc. so IMHO this is exactly the same of 
>>>ftpm and svsm, so we don't need to set TPM_CHIP_FLAG_IRQ.
>>
>>I see,  but why not skip polling directly in "if (chip->flags & 
>>TPM_CHIP_FLAG_IRQ)"  instead of do while?
>
>I mean, why not skip polling directly in "if (chip->flags & 
>TPM_CHIP_FLAG_IRQ)"?
>
>And In my opinion, TPM_CHIP_FLAG_SYNC and TPM_CHIP_FLAG_IRQ are 
>essentially the same, only with different names.

When TPM_CHIP_FLAG_SYNC is defined, the .recv() is not invoked and 
.send() will send the command and retrieve the response. For some driver 
like ftpm this will save an extra copy/buffer.

Stefano


