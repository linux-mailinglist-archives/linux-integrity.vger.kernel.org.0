Return-Path: <linux-integrity+bounces-2164-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8348A65AE
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Apr 2024 10:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 057A51F21C1F
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Apr 2024 08:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D930127B72;
	Tue, 16 Apr 2024 08:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="lW+z02Fm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E0D84FDB
	for <linux-integrity@vger.kernel.org>; Tue, 16 Apr 2024 08:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713254769; cv=none; b=JKYaKOsn05jTzk8HVgW1nbpKn/NSIaij3kS+hj0y5nB9OJvQ7bYk1+Tfk/m7f2OXmzD1mdeH8uSaM02ivENpt6a9WGJSnfTCsHsERaw6Q+NGyXSzUZ16woaEcpnrJxqDCwoIn0zSiMng1DRFVxSnC+Z9SEhRVOWD4UmG1rf5EkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713254769; c=relaxed/simple;
	bh=fg5enCRClFzMv6bdvt1Y6X9xAUZhUI7GAdZthN4hE2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ftcq9587qXI7aG78UKRg7w3PtBtv9C1atBUkDDd+lAQn/JhX0Ycs0EmS9C9vjMoN0gKCB+MKZFk9WkwPRa+Gn/sEUmgl7SrYSgIuelF+7PiFgI6X7flTTJpMP0qhIn3QylAOd1k0e6+2EFUxgObrPUO194fUAySFWZxgo1D761A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=lW+z02Fm; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56fe7dc7f58so3586177a12.2
        for <linux-integrity@vger.kernel.org>; Tue, 16 Apr 2024 01:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1713254765; x=1713859565; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FoqNTXSVJxVnoomAkAmOc0tpYIUt/Fr7OUpds6qVicI=;
        b=lW+z02FmKq2sZrwkzqdQlSM1VKdoHe5jjC9Gz/OwrTy6u4O/FMmR9coVMiyFXICn8Y
         amwCmXQ/ug01YvFqjKGk4bLfeSP6+Xuhua4GLocF3DCxrHEWiApPHn9hqUvGc5DbetzL
         5ZyvE49GLf6EsCAsbFuzohmUu2zf0VLHGnjX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713254765; x=1713859565;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FoqNTXSVJxVnoomAkAmOc0tpYIUt/Fr7OUpds6qVicI=;
        b=spgLTySPcl4x8OOkVgI3Vhm0VByE/POVIGA5dxht1ExdAmcIFMLdJeQyFC/Rk5kYGo
         vG5dCQODoRZF0Vo2YkzbPWiqOQkI1bZNIl2uC8WvOZhHeeB7msW68fIVQLMJKpz5mmo9
         ymJTwdQQOmogMUwxm+27nGzQrQVfIVZl/juPLUGgbB7nmJQMMIZudfMmRISKXtKzoo7L
         mJefY0OEa9rxyvEaYtso9M4bRr4lPP1ujgMaucQdPuySipGrz26PckXkls+M41E3NSdW
         HoUICA/sMoPv6zpZ/MEnO6PujR91Yv0piS62LL6Eqmk6cNlI3kN90rF20tFI9Rxw5Idd
         3l1A==
X-Forwarded-Encrypted: i=1; AJvYcCXbz2F/fH0N8Sinm38xiIKrpBfQki7HrNCs/a7QX5/q9UKkexSJKucjHarrFr3lE/BPipcNi8rz6oG1IIvZwg4BT6YhXsMbsKd2QcDErzK8
X-Gm-Message-State: AOJu0Yy6CqqCdLNyEtDi62G9pkfkoMI/h8LwEBxQGAprPZ+GGvxB5uSD
	Rd12TtXbuc2+HNWdNtRJnGZjvyymLdCJ5/XrmNJWCqAH96UIwEnWr1MvuNqj3ZHPESoXEGxw6lI
	7cxKt8/qY03DuV3GM4xYzPdIgqhKdRbQf8z5lhA==
X-Google-Smtp-Source: AGHT+IFUt+TdRo5/lwa0iU7eIPcfQR2RMazKfVpGy4W16qNguCkLvu3MteqG74P0Dv9xqS7zJrT0nlKrob2NRz5PBhk=
X-Received: by 2002:a17:907:6d18:b0:a51:e2a9:97c with SMTP id
 sa24-20020a1709076d1800b00a51e2a9097cmr12053296ejc.6.1713254765520; Tue, 16
 Apr 2024 01:06:05 -0700 (PDT)
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
 <CAJfpegvPwpS5_S4qrrVbeC1RovP8jeNuDCYLbdcZ_XDFgfgftQ@mail.gmail.com> <52645fb25b424e10e68f0bde3b80906bbf8b9a37.camel@linux.ibm.com>
In-Reply-To: <52645fb25b424e10e68f0bde3b80906bbf8b9a37.camel@linux.ibm.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 16 Apr 2024 10:05:54 +0200
Message-ID: <CAJfpegsHJ1JsM3SxNk5gnUM+aucqOqNm3RTrsYgePkcQYR4EEw@mail.gmail.com>
Subject: Re: [RFC 2/2] ima: Fix detection of read/write violations on stacked filesystems
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Stefan Berger <stefanb@linux.ibm.com>, Amir Goldstein <amir73il@gmail.com>, 
	linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, roberto.sassu@huawei.com, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Apr 2024 at 20:35, Mimi Zohar <zohar@linux.ibm.com> wrote:

> Although "Changes to the underlying filesystems while part of a mounted overlay
> filesystem are not allowed.", from an integrity perspective these changes might
> affect overlay files.  So they need to be detected and possibly re-measured, re-
> appraised, and/or re-audited [1, 2].

How are changes of non-overlay files detected?

Thanks,
Miklos

