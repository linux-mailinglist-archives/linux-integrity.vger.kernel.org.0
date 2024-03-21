Return-Path: <linux-integrity+bounces-1827-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 184F088589D
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Mar 2024 12:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EF1AB21EF3
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Mar 2024 11:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDFF3C17;
	Thu, 21 Mar 2024 11:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=puiterwijk.org header.i=@puiterwijk.org header.b="K2qhLENO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840C958210
	for <linux-integrity@vger.kernel.org>; Thu, 21 Mar 2024 11:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711022147; cv=none; b=svYXjgnoyWVgbKv3Oqe4u76cSPUrGz3MkkX4/SixhlJjkvF5VI2TftbQb61OeCn/5QnFyVRCeBGkbRAp7NWZJEOLnh/VsS/0FXctROsjLIeG47Yf805yGi5OacYWajzrDwTtH+Hx3LahtWihEj90mXLVaO+4b7HSzgyp3DbDsGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711022147; c=relaxed/simple;
	bh=/7zJS9kh7ywPyp5oMkU4MF5UwIruAkJZVZuetUiX1AA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JsTNPIWbHylJL7USHghl/Z5CaoOEVk/ieS2rRcubTinwyKC5FwIDtjwpmb5Wip9Bf4onOEbBvhIAtb4gTwsXdzJjoUwdbLrljYcKBINcpcAxCGqQZPD3tt9ToAQMR6Cpnpm10ynIon5Bul5Ccs5muDGbvhvXEy0iGiyFhETZd7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=puiterwijk.org; spf=pass smtp.mailfrom=puiterwijk.org; dkim=pass (2048-bit key) header.d=puiterwijk.org header.i=@puiterwijk.org header.b=K2qhLENO; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=puiterwijk.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=puiterwijk.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a46dd7b4bcbso118828566b.3
        for <linux-integrity@vger.kernel.org>; Thu, 21 Mar 2024 04:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puiterwijk.org; s=google; t=1711022144; x=1711626944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7zJS9kh7ywPyp5oMkU4MF5UwIruAkJZVZuetUiX1AA=;
        b=K2qhLENOVXFiKV+ZFhT4RFRm/nhfKQf2u3ZIqDGGXZ0gemqQWR+98J8Gri47AyS+T0
         q3zTagMzhdI2u3B/0Mv1bTcQryHL2OT2+Ya2yhRL03JNtEizYqJ0GpdB1Ay4oZxVyJpz
         hAdJGPFepqF7n1GThJs6Vq2hAVobfC8X0ILJQanq8ebh4CHgfEk+OjgbwZOB4fBHMU+K
         9xWcseUSk4biF0ybhVrM7PpKWJOQYX3sHRqOsdsIj95uruVGmfos/JnQ3xSYow3oiuFI
         t65EzSUQ2FnRvAzx/wc2LBebaIXoJobplm1ZipD8wiAyu7jKe8z6foqWciGsGShvPI1b
         3JMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711022144; x=1711626944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7zJS9kh7ywPyp5oMkU4MF5UwIruAkJZVZuetUiX1AA=;
        b=B/2DzPO4gLvIN+akbsCUbH/fkRfIe4466WzmEuYD70Wc7IS+QXO9arXh8zG4ODWR+J
         0sqtGYeMiY9p9pWrJ+JSR/c9OkH9L5UVKjqCWmlxi6L5Q4lREm5LMQKZBbyuKw7rgYzJ
         nro9PYOL6FPTNTPZlUKjO4Lw0+LkwjsVQSYI1ywfPMrnskNdwby/mtsj+5qJ/maYjpVI
         oVIQBwASaxXYVcg1fh0IoO85ODWqVbk5jrMrlrjk8r6A/n91/egvUWUMK7CHiA6ekInq
         73Di3jg2uzWMT70yx2pA2uUw77HQySO8UzRyTr74l/0DTa44QB76wnN+iYqyjj/jalln
         Z2Qw==
X-Gm-Message-State: AOJu0Yyx2DE3wBj4Bafj59CC4ZeVdmIZSWt5t+S4JExSbRC5fNhSksyd
	2JZEORvrDhf0TIY6B4NP7zUjLAkEPnbZaGykk6xrPIt5Gj1NAdCUaTVXNkN/1YS98hqdRQfE581
	6PkpHx1TRswASgUGxQQ5mWouh0IPRH7dezFAx7Q==
X-Google-Smtp-Source: AGHT+IHimp1R/NZ7ifYnBgtyg0FNWRtuMFmOKILTsVnOvikp8ziRuT4o7ANtaqk57Vz6/X4PfD5/A7AWNbAdubQQCEQ=
X-Received: by 2002:a17:907:1b06:b0:a46:d6f7:e8f5 with SMTP id
 mp6-20020a1709071b0600b00a46d6f7e8f5mr1418590ejc.18.1711022143515; Thu, 21
 Mar 2024 04:55:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <103252ffff09c607e83c887cab2e0af5404d62ff.1710774200.git.dmitry.kasatkin@gmail.com>
In-Reply-To: <103252ffff09c607e83c887cab2e0af5404d62ff.1710774200.git.dmitry.kasatkin@gmail.com>
From: Patrick Uiterwijk <patrick@puiterwijk.org>
Date: Thu, 21 Mar 2024 19:55:32 +0800
Message-ID: <CAJweMdbvnnkHrO884meR3bCt-xwo6_hUXh7ofaZqkREQzuupqQ@mail.gmail.com>
Subject: Re: [ima-evm-utils: PATCH v2 1/1] Change license to LGPL-2.0-or-later
 and GPL-2.0-or-later
To: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: linux-integrity@vger.kernel.org, 
	Dmitry Kasatkin <dmitry.kasatkin@huawei.com>, Petr Vorel <pvorel@suse.cz>, 
	Mimi Zohar <zohar@linux.ibm.com>, Stefan Berger <stefanb@linux.ibm.com>, 
	Vitaly Chikunov <vt@altlinux.org>, Ken Goldman <kgold@linux.ibm.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Bruno Meneguele <bmeneg@redhat.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, George Wilson <gcwilson@linux.ibm.com>, 
	Tergel Myanganbayar <tergelmyanganbayar2024@u.northwestern.edu>, 
	=?UTF-8?Q?Andr=C3=A9_Draszik?= <git@andred.net>, 
	Frank Sorenson <sorenson@redhat.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 11:08=E2=80=AFPM Dmitry Kasatkin
<dmitry.kasatkin@gmail.com> wrote:
>
> Currently libimaevm provided by this project is used by the tool evmctl,
> which is also provided by this project.
>
> An issue was reported about using libimaevm with other software. Its
> GPL2-only license makes it incompatible to use with other licenses, in
> particular GPL3-only.
>
...

Acked-by: Patrick Uiterwijk <patrick@puiterwijk.org>

