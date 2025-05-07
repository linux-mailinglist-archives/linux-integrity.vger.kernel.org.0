Return-Path: <linux-integrity+bounces-6157-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8429BAADB7D
	for <lists+linux-integrity@lfdr.de>; Wed,  7 May 2025 11:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F23E14E117D
	for <lists+linux-integrity@lfdr.de>; Wed,  7 May 2025 09:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA361F417E;
	Wed,  7 May 2025 09:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XTR6XmVp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895C71F2BAB
	for <linux-integrity@vger.kernel.org>; Wed,  7 May 2025 09:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746610356; cv=none; b=ZuGRIKmaHfNuAwcnCPXqJkKdS9fot/mRKviS2aR4Xejk5HIFzMamlFqAwS1Ta6UcbYw9UkCMBSPC5jyP9e450ohvfRNmNkGqr+5H6qmlJYO9Zk2/QpYuNq6LCyjRj/dEHzXRRau+gY+EPjuqmsEAwaZjMLnOUXcGdvSG2YCigy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746610356; c=relaxed/simple;
	bh=+dcoGM/MPnQ7gR2bwDmEC4W4glqMT6D4Z27/zHMAu6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=az3iSMnsrsdJzfVmy2a0dsgGWBhX6Fj5r5b0nzqpUUNyCblTbKcCKXcrHyAnx0fx9FU5MdINkXYGjnvvjgkYQr6M8BMSI78Uo8uci8UQUQuAeBrBtci6lBfjVkD77SJR6D00oH06ttgwiHaujBLJ5Jrw0mk6VTICZSy3Pb5r1LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XTR6XmVp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746610353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=89g+uUbAmI4s1rHApPcoGavOskeIK/6Orkxfvy6zQ+0=;
	b=XTR6XmVpWa4wZxSIc0nJI2ItHsT5JkZXjc92gyUPWAJ6ptdKrhEDqFKC/7KHet4l0HxFga
	PlExHDks005c5vYQAfzAZwWplMPwQSGZpKvllUs4wTg2Ep2WnNBVx03OGznWfq45yjVsDB
	jMCULBqfPjV1HnJpiUZCfS7SLvUiBuE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-jnD_1aKBOg6IveRu0Za5ig-1; Wed, 07 May 2025 05:32:32 -0400
X-MC-Unique: jnD_1aKBOg6IveRu0Za5ig-1
X-Mimecast-MFC-AGG-ID: jnD_1aKBOg6IveRu0Za5ig_1746610351
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac3db5469fbso540980666b.0
        for <linux-integrity@vger.kernel.org>; Wed, 07 May 2025 02:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746610351; x=1747215151;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=89g+uUbAmI4s1rHApPcoGavOskeIK/6Orkxfvy6zQ+0=;
        b=kle5FHzN77twoNFrmwRUKxUVqLZlb9z7T7JzWFVjTHRVnjESYnQsj8GiZefrYiXrLV
         ZNnv+wB9cEpLwDpRzHjsO85wUc36hXXtg7//0UDHO0bMc0P31PxQEWEuTvSB97Cm9h2p
         8JO8S18yMNEaPeVaHm9dByywgVcudLsPCozvH2PtgcCuFSQYshXSpX9M0zzjtuYy6BHl
         HqL1PboY50x7WS6qGmuiSlt36tFyczMpWzB5jIXVqFWWRxgKdNbWkrG3HVD994rlYJcD
         quKPwO69RwCaCAqNZ9hbqDHVD+xplaEVHT3J2AGvdpAjPIB84OnWWDE9AuYlv/rT0sVs
         DGvA==
X-Forwarded-Encrypted: i=1; AJvYcCXXgb0DnqXHbx3O6DmE5DjavHVTjtku55egbstUWbQVhwwYtXCJdefKA8TX1qhDvGNOYcz23rYeBIG2ckgYbYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/uc+jt0x5agmDYguGiaPdFolGTxGZtrsL7Wwer9FIqLPnDsah
	/jJJN0BDXWf21/wccvSvPi2YrY1w8j+ziGt0/CkM8vkF1e7+O9ZZOIXUsx8RNQZqqSppmY0pIMq
	ahL9JECQQ/oCPBaXPp1mlNutnP7oqSWoZoRY5vBkXiuUHmYxoISuRDGvIQGPQYJq/vw==
X-Gm-Gg: ASbGnctc8iReU2o7/tMmrAxo2A02srkazMaHTWx9meJSM8zPQ2glMR8bjwjUyuAHbVP
	+yDmLyhUuEGuNjl4HB/c2f71IK9Nw1fAUTn6V/zAo+QH0IZQB/O6RfyMpPLgxwKT2bQkncHEK64
	eyP0VcqQRSjUlU+MqAysuCwCObEfCldfY8KnHUa3xG6pblYqgVvjwiztNZv6Fx2CwntFXAgY48z
	FSBZgFY0f3HLxeAvXY7cfP4D/f8Rka4422VaQy5Mg1PPf8UFvwm9jE61p6hBp/Szk/WQ+wVLfSQ
	+gkmBhI9/SLgF9rP
X-Received: by 2002:a17:906:d54d:b0:aca:9615:3c90 with SMTP id a640c23a62f3a-ad1e8d0ba2bmr267001166b.52.1746610350921;
        Wed, 07 May 2025 02:32:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFB9GITuMuYoSYN8HyavQFo2/J56H0NB7QS0JaWBQv+IFH3p+ygglDzNeMYFn+SDDKrajLukA==
X-Received: by 2002:a17:906:d54d:b0:aca:9615:3c90 with SMTP id a640c23a62f3a-ad1e8d0ba2bmr266997766b.52.1746610350328;
        Wed, 07 May 2025 02:32:30 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.165.32])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad189147329sm869562066b.1.2025.05.07.02.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 02:32:29 -0700 (PDT)
Date: Wed, 7 May 2025 11:32:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: lee@kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net, 
	peterhuewe@gmx.de, jarkko@kernel.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-crypto@vger.kernel.org, jgg@ziepe.ca, 
	linux-integrity@vger.kernel.org, pmenzel@molgen.mpg.de, Yinggang Gu <guyinggang@loongson.cn>, 
	Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v9 4/5] tpm: Add a driver for Loongson TPM device
Message-ID: <CAGxU2F6m2=+07sUoy4PKVs1vMR6Yr--pgkOG3SEGg8gi=HRf+g@mail.gmail.com>
References: <20250506031947.11130-1-zhaoqunqin@loongson.cn>
 <20250506031947.11130-5-zhaoqunqin@loongson.cn>
 <2nuadbg5awe6gvagxg7t5ewvxsbmiq4qrcrycvnrmt2etzq2ke@6oyzavctwrma>
 <0b148f09-d20d-b6be-d31b-6c8a553658c9@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b148f09-d20d-b6be-d31b-6c8a553658c9@loongson.cn>

On Wed, 7 May 2025 at 03:35, Qunqin Zhao <zhaoqunqin@loongson.cn> wrote:
>
>
> 在 2025/5/6 下午10:13, Stefano Garzarella 写道:
> > On Tue, May 06, 2025 at 11:19:46AM +0800, Qunqin Zhao wrote:
> >> Loongson Security Engine supports random number generation, hash,
> >> symmetric encryption and asymmetric encryption. Based on these
> >> encryption functions, TPM2 have been implemented in the Loongson
> >> Security Engine firmware. This driver is responsible for copying data
> >> into the memory visible to the firmware and receiving data from the
> >> firmware.
> >>
> >> Co-developed-by: Yinggang Gu <guyinggang@loongson.cn>
> >> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> >> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
> >> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> >> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> >> ---
> >> v9: "tpm_loongson_driver" --> "tpm_loongson"
> >>    "depends on CRYPTO_DEV_LOONGSON_SE" --> "depends on MFD_LOONGSON_SE"
> >>
> ...
> >> +static int tpm_loongson_recv(struct tpm_chip *chip, u8 *buf, size_t
> >> count)
> >> +{
> >> +    struct loongson_se_engine *tpm_engine =
> >> dev_get_drvdata(&chip->dev);
> >> +    struct tpm_loongson_cmd *cmd_ret = tpm_engine->command_ret;
> >> +
> >> +    memcpy(buf, tpm_engine->data_buffer, cmd_ret->data_len);
> >
> > Should we limit the memcpy to `count`?
> >
> > I mean, can happen that `count` is less than `cmd_ret->data_len`?
>
> Hi, Stefan, thanks for your comment.
>
> Firmware ensures "cmd_ret->data_len" will be less than TPM_BUFSIZE,  so
> this would never happen.

I see, but I meant the opposite, if `count` (size of `buf`) is less than 
`cmd_ret->data_len`.

I mean, should we add something like this:

	if (count < cmd_ret->data_len) {
		return -EIO;
	}

I see we do this in other drivers as well (e.g. crb, ftpm), so I'm 
trying to understand why here is not the case.

Thanks,
Stefano


