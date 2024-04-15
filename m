Return-Path: <linux-integrity+bounces-2123-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1086D8A50D4
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Apr 2024 15:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1DA328CEA6
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Apr 2024 13:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA02885281;
	Mon, 15 Apr 2024 12:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="hTkoK1AK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9073C84FDF
	for <linux-integrity@vger.kernel.org>; Mon, 15 Apr 2024 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185890; cv=none; b=EjwNgrtun0DlDn87u8FIK9oUxO/x4QabD2Z67daREEI5WFvQ3u6fCuf4qF/oUbV4MnDFz6G+y8gcshCViPIXgLeUCK26fKwgKlbXuB8pBkr0PcF0ACT6EF/cqEDWBDr+cizDBvprdnVwzBIMEzHYZYc9xEdyKIe/JzZHFnM1bWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185890; c=relaxed/simple;
	bh=PtRDKTQTDzhoQ+/JuLQ9JmFXYTTE6omhjNyTnWio4Ng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jm2GMy61lgRRlC0AMkCyY18qLKhb/MFxSyWh3jAevG83khf8SytjY94XyOdtrS52mpAjUrzRtTF61L33yI+WGRVNjKLppX/Famexl21E2dpmoHb0GGBP5FvoaPMMkMq7kyVcCRDmHa2sMhHttM/8zDG2p6eZfAzfiT0f5PVsH7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=hTkoK1AK; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-518a56cdbcfso2980115e87.2
        for <linux-integrity@vger.kernel.org>; Mon, 15 Apr 2024 05:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1713185887; x=1713790687; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PtRDKTQTDzhoQ+/JuLQ9JmFXYTTE6omhjNyTnWio4Ng=;
        b=hTkoK1AKs8h/tfzw25yar9T/oUhRWWMZYagLeKSpRvP2wC4DmwzN19cZCdAC1OMQ3y
         SU9XUoCsyxkAbikK+hTmmwvk3rmnxhnfyNKpOMP0WJJNdfb8rdEwhfhtiwAS9MwyLe4Q
         2fOAE1rJ0lqGAG4mBgjIrsHwwpOoJEqeVBfe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713185887; x=1713790687;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PtRDKTQTDzhoQ+/JuLQ9JmFXYTTE6omhjNyTnWio4Ng=;
        b=mCUC1wsF4F5argD9FIvoKuOMgYMT/yA5qrpmtqcvq8F5oiuEo2qvSj2mBridrjsTmU
         9vFUdVrUS4J2WpvuazlmXzHjL46YjgeDMdIoaFbjF1CxiLlGv8KVdGEqCjM8ZGXiWzhu
         07HC8TdxWrXExnwCbGoUEgISBp7hINA8wh8ZajkojNmmNwOOeY81MzXeBaOoNdy7hfXD
         XU84TZaKwQw1TJctiM3ZqTMxmCjhbXQc92uUgCRcXVaAS58KrCA3c9i+ngHTvyenpVFW
         pUUiPxT6Cc8ins8HRf2h62WlNaqffb+YuGVGAtaJLuD7zYS3VA0DyrUNt6+FWQBa+9uz
         E9ow==
X-Forwarded-Encrypted: i=1; AJvYcCV/wuyQ6qyJZNT3dI9f6huBKH9R8xaXvnKeRIzu5aQqW+DXs00ERdElruTiBKmM8tJRfJ9eFSwvJ65BhVkPJljTTGa36EdF2bRYdAPCyspt
X-Gm-Message-State: AOJu0Yxm0z1iRPcJmscafL+nDt138cawR4uHtEDWwEaOWpqY9h4yN4xZ
	aYuuCGO9/c5vneSR8w+ei2rT0k6NsfIZSp04WyEIEKu7THuKn8k0+j/CGxAexLSnDlLygCeuhBO
	oqQmm+9+dIyF1yzTtIsjlJo/D2aU82XgWca2TPg==
X-Google-Smtp-Source: AGHT+IHOnuRHFKR2HVCzMc8TC81Qg4Ae2NPHkxHjQfyNtYIEy4o0Y2sPyHQsY5jkjxH1hi2Cm7TUt4zaFYsDNFeRRJc=
X-Received: by 2002:a19:9112:0:b0:516:9f03:6a92 with SMTP id
 t18-20020a199112000000b005169f036a92mr6833604lfd.43.1713185886774; Mon, 15
 Apr 2024 05:58:06 -0700 (PDT)
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
In-Reply-To: <b74a9a3edc52d96a7a34d6ba327fdb2a5a79a80d.camel@linux.ibm.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 15 Apr 2024 14:57:55 +0200
Message-ID: <CAJfpegvPwpS5_S4qrrVbeC1RovP8jeNuDCYLbdcZ_XDFgfgftQ@mail.gmail.com>
Subject: Re: [RFC 2/2] ima: Fix detection of read/write violations on stacked filesystems
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Stefan Berger <stefanb@linux.ibm.com>, Amir Goldstein <amir73il@gmail.com>, 
	linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, roberto.sassu@huawei.com, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Apr 2024 at 12:47, Mimi Zohar <zohar@linux.ibm.com> wrote:
> It's queued in
> https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/ next-
> integrity branch and should be linux-next.

Is there a document about ima/evm vs. overlayfs?

What exactly is it trying to achieve and how?

Thanks,
Miklos

