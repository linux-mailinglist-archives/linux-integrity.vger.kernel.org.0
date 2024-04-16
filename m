Return-Path: <linux-integrity+bounces-2175-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C83C18A6ECE
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Apr 2024 16:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F3D28468B
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Apr 2024 14:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EBF12F389;
	Tue, 16 Apr 2024 14:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="UxN+QcvH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFA812E1D9
	for <linux-integrity@vger.kernel.org>; Tue, 16 Apr 2024 14:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278835; cv=none; b=XUehsWWWQhlF60ZbgjvCRD1EVwJtbY5syt9D03NcTKwg4NEiAJ4TxKSItGUGGdxE1aVeUM6MKroV3YWyt92u4dqfI7rD9AN0awsFQ7l3h5J/n/GBjT4RSCx/FHXJnVlrCla2JMH5vXaOYlh0kF8SKi1e/hZzoSKDvKUHR9mk/OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278835; c=relaxed/simple;
	bh=lpIRWhyVZ0w6q5mXIuwstpp9Haqu8fvuxrXiwMYh2rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nef0cGJsoiE0N2OKl/VZVRPYlU/4I83kgOp78KfmUmOrTaorp6auJBHxiB4Vbpz1Mr+kBQzW/E9ZVOxEz4lQqYM03zyTi+hR6TeyfXkc72XTQvFSZxaXLHBQsQPe7echuOS+aEHoK9x0pLrz85Z20bYm1+MtBLN8JghRpABHzNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=UxN+QcvH; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a526d0b2349so276374066b.3
        for <linux-integrity@vger.kernel.org>; Tue, 16 Apr 2024 07:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1713278831; x=1713883631; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VdUNeq7IC88ql40wcww2SSOHhBozeb4bC7ktgyYktbA=;
        b=UxN+QcvH6qyWiipF31MNXyIb++13ZTuftGyKGO1g1GIJgq+DwD8444IfIIVuTw+WAg
         9+sx7Vtga1lPpZ7tgzh9foJ+w3CyRxDNSXut6NhkkwgDMrifb1cmrsT01bkjVvham2oL
         w5NqhZQ/HTgbSJth9ZfmW3KQq4dMPOhFJVABI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713278831; x=1713883631;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VdUNeq7IC88ql40wcww2SSOHhBozeb4bC7ktgyYktbA=;
        b=AylKF1Aw/bfGhP8qvy3LRScP6AdKH1fAouH34rh7njG3jdrpY215WZRI+l/ohQCtf4
         k0kMvNs4ixXresXdOieJsr6GWBF9REAQA1InS/OM8bI1vWyv/j6ewbwt/gXzZIttAS4p
         uPHsTrJ//efvSmZ9xf4QBw3QDgRDsWxjqmXPYO27k9lK16RNrBdXEW9dUiQd7WPFghG7
         gYNgDGJZM7o0fhRN2dZxf6iZ0GIqUjnKDwlUg2vjzLH3V0JwUAe7dOceMbc/pLiTX4Er
         /t548A+HllibfvPF61j18baLvz7iDAb78SOxOfp6JmHNWO36XgkuhIMmF0Golutt4UdK
         lrvA==
X-Forwarded-Encrypted: i=1; AJvYcCXVYxhnA2PXLJ082IdUSIPwuuPvozsoQh5WSLO0pLTnS8ZPbS3NNqPP42DHD/PatTTMZd5nJiCShvwoq20+tMySSEvY99213sAvxpf5VLZS
X-Gm-Message-State: AOJu0Yw40c7FgzciwjiAcrvdu1I6iO19/t3LEDWkOyDAsmjZByzwKiE7
	D8VlYArJ04s+LBT9tpAubDzV2KtTnrNWnFVoRVmHFvArduy0clF6dmhh7ue4qLhPXSgrLuD258Y
	p0W3/7x0rUUkLwsRWKrOBV3AMgXlIcT+lCR3R3A==
X-Google-Smtp-Source: AGHT+IEfXfihX/tUYUNNR8Qj5bxuR99dJm6dIhykvYZzZyGT2orL8P+33E1uaoeESHWxJGIirFpNcQFSZ7tt3Rvpn6g=
X-Received: by 2002:a17:906:c309:b0:a52:4246:7f65 with SMTP id
 s9-20020a170906c30900b00a5242467f65mr5693156ejz.35.1713278831418; Tue, 16 Apr
 2024 07:47:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412140122.2607743-1-stefanb@linux.ibm.com>
 <20240412140122.2607743-3-stefanb@linux.ibm.com> <CAOQ4uxjDQO91cjA0sgyPStkwc_7+NxAOhyve94qUvXSM3ytk1g@mail.gmail.com>
 <89b4fb29-5906-4b21-8b5b-6b340701ffe4@linux.ibm.com> <CAJfpeguctirEYECoigcAsJwpGPCX2NyfMZ8H8GHGW-0UyKfjgg@mail.gmail.com>
 <b74a9a3edc52d96a7a34d6ba327fdb2a5a79a80d.camel@linux.ibm.com>
 <CAJfpegvPwpS5_S4qrrVbeC1RovP8jeNuDCYLbdcZ_XDFgfgftQ@mail.gmail.com>
 <52645fb25b424e10e68f0bde3b80906bbf8b9a37.camel@linux.ibm.com>
 <CAJfpegsHJ1JsM3SxNk5gnUM+aucqOqNm3RTrsYgePkcQYR4EEw@mail.gmail.com> <e052c1b5d2aa29b3a1f3a8086af4fb8a94c4d318.camel@linux.ibm.com>
In-Reply-To: <e052c1b5d2aa29b3a1f3a8086af4fb8a94c4d318.camel@linux.ibm.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 16 Apr 2024 16:46:59 +0200
Message-ID: <CAJfpeguzh6VzhdnwOPf_hM4x0FbsK8hhZp=VK4kWpCYn0xeBCg@mail.gmail.com>
Subject: Re: [RFC 2/2] ima: Fix detection of read/write violations on stacked filesystems
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Stefan Berger <stefanb@linux.ibm.com>, Amir Goldstein <amir73il@gmail.com>, 
	linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, roberto.sassu@huawei.com, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Apr 2024 at 14:18, Mimi Zohar <zohar@linux.ibm.com> wrote:
> Originally there was a single measureent unless the filesystem was mounted with
> SB_I_VERSION.  With commit a2a2c3c8580a ("ima: Use i_version only when
> filesystem supports it") this changed to always re-measure the file if the
> filesystem wasn't mounted with SB_I_VERSION.

Does the i_version get stored and compared only while the inode is in memory?

In that case I think it should be possible to support a version number
for the overlay inode.

Thanks,
Miklos

