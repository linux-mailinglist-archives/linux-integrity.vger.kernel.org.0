Return-Path: <linux-integrity+bounces-7589-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2165AC3B475
	for <lists+linux-integrity@lfdr.de>; Thu, 06 Nov 2025 14:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A68E561A8B
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Nov 2025 13:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B00A20299B;
	Thu,  6 Nov 2025 13:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XGQSohYe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AMVRHxJD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ACB19F11E
	for <linux-integrity@vger.kernel.org>; Thu,  6 Nov 2025 13:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762435819; cv=none; b=nxLVLT8/C/+7tTKcswwyB9sRdwulN0/MLLkr5FMk2qgOsCAMLRFpHLSE9FYqJAZEth3WCSnGgSfKN/20/NREvP3P8WQR24+pjDJN+MQnu+0RkqegO8giWQp6BhFBE5K92ydFUhPRPCVkhEGO8O0KHZUG9MgzGH1F6YHdwO+v3Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762435819; c=relaxed/simple;
	bh=CmB1MWecEBBp4OgxfqCuQiSEAV5QOXrCNuLXgiG46GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQoC59jFVx3/yO2Rs8jaorwwfd7b1t0Q4SBnLAVIlqXXIAJL45Z/dd1X07t81PQwYAQRQCWs7HzP6tADhkrvfi0jc3Y2y9oQHGXrlPEOguibi8aDEVrkOp4ue4bYDaSyNzUOa3qPzjtDvwIP23MHd6FC0wsqsLE5fpyoLfWx3is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XGQSohYe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AMVRHxJD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762435816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GKaQ6ZP+peJ5RMaPGONMdp62mSGMz4ih+kVgJblXjSY=;
	b=XGQSohYeP2d3S1T1LEJdeEXcA+W60bGkGX6aqp1V84y5CifZ6A5sQiRQAWG0a3haoZRa7V
	hINcu5oLFX1DFUYnXZh0AC7bCHEqLS790EIm6Wa50tEK7OgQ4UvfFA/lndm+FzmUCS+aEw
	jF1LJITR73LqyDidsfiCv3XsbDheivE=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-L_bYTsPUPT2ZXK1Ghm-wzw-1; Thu, 06 Nov 2025 08:30:15 -0500
X-MC-Unique: L_bYTsPUPT2ZXK1Ghm-wzw-1
X-Mimecast-MFC-AGG-ID: L_bYTsPUPT2ZXK1Ghm-wzw_1762435814
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-ba265ee0e34so846539a12.2
        for <linux-integrity@vger.kernel.org>; Thu, 06 Nov 2025 05:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762435814; x=1763040614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GKaQ6ZP+peJ5RMaPGONMdp62mSGMz4ih+kVgJblXjSY=;
        b=AMVRHxJDX8cEqQB2dBiym2BWC6LFYm3FnOpnbN227FGDdpXELBbUdqxXobgm/QYIh7
         +anK++Up/31kNGUs34oBq8BmW50E+bnWRxduM2OZPRvEKxOOD20czuwSKeptOww1tmJO
         VtZajIH7gxfzewHApW4900bCc12YAwxkOUAOmRAlPfCskf5RqzOO2IaDgHNMyriI5fZn
         bA6yAe/vwBso8nkwg+l2gsrU5+lUCraECbnpk/Z9a+v/YuJSXk7nGRVUiMxmeTkKbWY1
         e1e+kPDt2HB5DvJWoGUZs2iV5+/lg7+hU9zWArbRi40mf/K0g6KqONg5ceswyEPbcfHj
         nPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762435814; x=1763040614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKaQ6ZP+peJ5RMaPGONMdp62mSGMz4ih+kVgJblXjSY=;
        b=raSoNPrbg3G2TcjHuW02/W4Cu52Bhn2f0BnaWq4vsDXhJ59c3y+12Vy4piwzxkOnrk
         gXjYA531qop5MYsliMzIWI+QUZL3uz5djtIxOX6oICaVmIyh/vwPBgYtq7mhtDY0Sn6V
         xseB+zZrogismo4EYWMtQhjXzmA12o7NiMmEk7WxuMYldTjZOkv5ApZm9ZC0/R8a+F+r
         5TPGrpb9rfuO8PGTEXynkOmXy23Eph06lRZ8LTKTX5JD6FsKuekTrMTF1Qp3OT7gcjH0
         t0yWDcVxUrOYtaxH1x1W1XKROICLhwWa0aL7ekepp8IyG/WGLDP8JoVpZcCsUhMD9DzC
         3Z+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFoCdA/wojX+XEr3+Qkt2Bary9PZA2ptVuM021K+6kmPYjDlpCm/Kk+8+vb4wcq5ZgRlcAxNeL+oybQZiXhfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWdJjowmjdhmUD8rzKQFTyiV6CCznyCuDrkK0Km+QO4aJ7KAlO
	S6ikGyjYfBT+EHPJ/E7kCSH0P9HeN9Cxggq21viaRZ0Krr+c/RpMR0T08iEnEdzvNRGLmleSgrp
	Di4LQvDsfsPUAeKUxW86EHEPnjIlrXg6uMKJENLqtnT7BGmSzOQm7Ey5GrJy22gex/KrvwA==
X-Gm-Gg: ASbGncv+eECUdp4KqFOjAYPjo69UvwqkUKxQ+udVmpiuATIBGa09tC0dLvjhwSt+UNj
	XUT4ApYy3QrDFkxdulsUlr2r2ct88kJfMtsnv0ZLhjAEYMYynZN6O443MBu6saP/QXEMs7oeYro
	VgDlBvel7YvK3ZYy21t+IJkvnSGTRSVsU9L8B0MjFCL35kj5zynOZ5aXauxtz3GRb80FA4o7uw1
	P1cjslhpcwBejeSQSKgu2REQi9U1RowOkbUAukWsHXiYNFT43Kg63K5jsg033hm9+2DfI8w+J/R
	rd1p+Y33ZZTpW+oQ4LtI3/0DayfFXE4N/+ZS0gdf63qRQxvxShIG/W3nc3SOzkaHmg==
X-Received: by 2002:a05:6a20:6a11:b0:342:1265:158f with SMTP id adf61e73a8af0-34f85f23889mr10202198637.51.1762435813482;
        Thu, 06 Nov 2025 05:30:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF58+7mJo3sNtAxMb3Nqi6GJVi04D/CfZ0QveWCpOETxQnk4AuJy1ge7Ljn9GwytoZbabtjJg==
X-Received: by 2002:a05:6a20:6a11:b0:342:1265:158f with SMTP id adf61e73a8af0-34f85f23889mr10202143637.51.1762435812912;
        Thu, 06 Nov 2025 05:30:12 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba902207227sm2527090a12.33.2025.11.06.05.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:30:12 -0800 (PST)
Date: Thu, 6 Nov 2025 21:29:42 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Paul Moore <paul@paul-moore.com>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Karel Srot <ksrot@redhat.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	open list <linux-kernel@vger.kernel.org>, "open list:MODULE SUPPORT" <linux-modules@vger.kernel.org>
Subject: Re: [PATCH v2] lsm,ima: new LSM hook
 security_kernel_module_read_file to access decompressed kernel module
Message-ID: <d24wnmefebnheerigmh6ts5yskkutz726l6a2f6g5s3s5fhhrv@osaactobwb5g>
References: <20250928030358.3873311-1-coxu@redhat.com>
 <20251031074016.1975356-1-coxu@redhat.com>
 <CAHC9VhRBXkW+XuqhxJvEOYR_VMxFh4TRWUtXzZky=AG_nyBYEQ@mail.gmail.com>
 <baa39fcd1b6b485f14b8f06dcd96b81359e6e491.camel@linux.ibm.com>
 <CAHC9VhToe-VNqbh6TY2iYnRvqTHRfQjnHYSRWYgt8K7NcLKMdg@mail.gmail.com>
 <fftfj4o3kqxmfu3hb655xczqcddoeqjv55llsnwkrdu5isdm4z@6sqe3k24a6kk>
 <84a0e1785c7f0ff816b3246be49012092ae12126.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <84a0e1785c7f0ff816b3246be49012092ae12126.camel@linux.ibm.com>

On Wed, Nov 05, 2025 at 03:47:25PM -0500, Mimi Zohar wrote:
>On Wed, 2025-11-05 at 08:18 +0800, Coiby Xu wrote:
[...]
>
>Hi Coiby,
>
>Based on the conversation with Paul, there is no reason to remove the existing
>security_kernel_post_read_file() call.
>
>The changes are similar to the 2nd link, but a bit different.
>- Define a single enumeration named READING_MODULE_COMPRESSED.
>
>- In module/main.c add a new security_kernel_post_read_file() call immediately
>after decompressing the kernel module.  Like a previous version of this patch,
>call kernel_read_file() with either READING_MODULE or READING_MODULE_COMPRESSED
>based on MODULE_INIT_COMPRESSED_FILE.
>
>- In ima_post_read_file() defer verifying the signature when the enumeration is
>READING_MODULE_COMPRESSED.  (No need for a new function ima_read_kernel_module.)

Hi Mimi,

Thanks for summarizing your conversation with Paul! I can confirm Paul's
approach works
https://github.com/coiby/linux/tree/in_kernel_decompression_ima_no_lsm_hook_paul

While testing the patch today, I realized there is another
issue/challenge introduced by in-kernel module decompression. IMA
appraisal is to verify the digest of compressed kernel module but
currently the passed buffer is uncompressed module. When IMA uses
uncompressed module data to calculate the digest, xattr signature
verification will fail. If we always make IMA read the original kernel
module data again to calculate the digest, does it look like a
quick-and-dirty fix? If we can assume people won't load kernel module so
often, the performance impact is negligible. Otherwise we may have to
introduce a new LSM hook so IMA can access uncompressed and original
module data one time.

>
>thanks,
>
>Mimi
>

-- 
Best regards,
Coiby


