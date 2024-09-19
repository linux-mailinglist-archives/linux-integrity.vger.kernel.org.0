Return-Path: <linux-integrity+bounces-3640-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD9897C25E
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Sep 2024 03:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3395E1C20FAA
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Sep 2024 01:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41533C2F;
	Thu, 19 Sep 2024 01:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqdpvgnR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5E179D2;
	Thu, 19 Sep 2024 01:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726708362; cv=none; b=hDfpajYt065QF0QG7j1fILoRUzM4sA+8si0ERf8qxQZ84QXBXudhIs9l6A94f93B7UAeKLv7y91sNJAUlIPW7d5xNRcdd7KjZvXTddbrNHGHalrvfjD5nXMhIvTFnBywKYfYdI6MnvdlmvrzjzuATSJgljQKcQ4+jMLpAGHd3s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726708362; c=relaxed/simple;
	bh=o3G+mZv7Dg4WUGawn4ExcHsCIklE/37c+rlu+u2/N0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ohOzQxMdVfu6IEe9FDAfO/HRe8UGA2+0op43twNr3dCnsl5itTCPqPnmMn+3Kqev7VZogi+iZzpc8cxVou4riuOznbqU2kAAZxBR6f/9fxCOFoHyNVqshZXF4Ih9IQavFDffIBGbtBdQ/iSfiIAksIzVMneeY74LQAhjB12AkTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqdpvgnR; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5365b71a6bdso300351e87.2;
        Wed, 18 Sep 2024 18:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726708359; x=1727313159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dB1gc+yGLOs2kchtI7XwJyvizaEutRuYGrskAUCT1b0=;
        b=FqdpvgnRxLz03i70gUpN88KdjO/JgUrynbzNtzNVcPSmxk7246t9ZaY0g6UuSDw/Oj
         kF5Nei+BaLuJkaeao2ZBMRDq7g/K6ChYf0UFWAB9TQsyF8pdd+KHcN6eWPFRcGijRy95
         S/eTeDuGVLFMnb8ducmw6xirIlY/rtbTO9dDPj+KxvOTYxwY7sMZq6ymbgYH1T6l/WQA
         vTg7s1h+2lJ/NSuH4YXJZd3zr7N9d1vbdH4YldLCQpzv69awTqmQsjK6LYYVEkKkBpjO
         N9WwjJ/Y4nbVI+S843fSCu5Fny8fg6GfQUO++AnCuckOGFaqbTWEOQaHfBY3tk7iKz84
         jExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726708359; x=1727313159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dB1gc+yGLOs2kchtI7XwJyvizaEutRuYGrskAUCT1b0=;
        b=exL78innrdSyIXH0wFkErqHdpAfFjMPYkfguvYyGNWn7KNB87w665O/c04FyDOu+VR
         gEM0OcenmeHNyqoift/FcxKxRoA/pB4DEppEsFn7zOALZw0A/D6W6OOtxRN7fo/0DBCM
         XKLYy1aXu/MfQwiQOiYITo8CSL9M85hRDWyqcztdTwC5KZPAQ9a6avTHu2s/ur5kSjTy
         MdIRbAn0YSNLRTzfv3WxyqJ2G8Dl46Z9qqUgowZ2F/x4GIDiDp9nSOYN/We/iPuv+WGI
         KBJdokOHnVvB+7X4flHVbfScH2BfPrs6YtjOYrN6AvaGVm1nP49eBSDsG4UlLQB2ZrY9
         KTsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5rQrW/yycR1l0LWAk0H6rgSPPTt88OV8yOzlfsQa+3oy1Nde/nHCpb8ercW/pRlDzcEqByzBa49VxVJCC@vger.kernel.org, AJvYcCVK8EslrKau8V8UxiZVguuoZX2bElegc+ZlQECqK58ZJY8Kzs8IgANWru34ojex749KQ3ZSw1Oymp0KoyGKXj6pwygZ+Tdw@vger.kernel.org, AJvYcCVWgy9A2YrvFSD5kP0lqLb9MXIoSM3CwzapuQ2MZ6nRA0qbQTyvVViv05znQ4/wa8OLrfakjlQb/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhgjltQYTcQXQL98IQBCyshy7Y9NbqPV/k3CzsQv2K9IXQmrAY
	CST0rE3hsLTmPxw9Hm8w+G6nmtp7TzlfTFayJBvksbNdYBKAA0Wd0OOmI3lFF0wbjvF61pKivFs
	Lgr/XG4k+z37dpF6dur+VF9QEii4=
X-Google-Smtp-Source: AGHT+IFOLp2ZhO84fb64DPm0Rm8L/PWOA9f5FFy8m43tqUXG9/+REZx2PzWFEAWtEgBdHUkKplJvqCdc9BhQy3g1Yl4=
X-Received: by 2002:a05:6512:a8d:b0:530:e323:b1d0 with SMTP id
 2adb3069b0e04-5367feba0a6mr10735885e87.9.1726708358747; Wed, 18 Sep 2024
 18:12:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240918203559.192605-1-jarkko@kernel.org>
In-Reply-To: <20240918203559.192605-1-jarkko@kernel.org>
From: Pengyu Ma <mapengyu@gmail.com>
Date: Thu, 19 Sep 2024 09:12:26 +0800
Message-ID: <CALSz7m3SXE3v-yB=_E3Xf5zCDv6bAYhjb+KHrnZ6J14ay2q9sw@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Lazy flush for the auth session
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, James.Bottomley@hansenpartnership.com, 
	roberto.sassu@huawei.com, Mimi Zohar <zohar@linux.ibm.com>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 4:36=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> For the sake of:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D219229
>
> The baseline for the series is v6.11 tag.

Clean applied on v6.11 upstream kernel.
Boot time is 8.7 seconds which is almost good as 7 seconds without TPM2_HMA=
C.

Thanks,
Pengyu

>
> v3:
> https://lore.kernel.org/linux-integrity/20240917154444.702370-1-jarkko@ke=
rnel.org/
> v2:
> https://lore.kernel.org/linux-integrity/20240916110714.1396407-1-jarkko@k=
ernel.org/
> v1:
> https://lore.kernel.org/linux-integrity/20240915180448.2030115-1-jarkko@k=
ernel.org/
>
> Jarkko Sakkinen (5):
>   tpm: Return on tpm2_create_null_primary() failure
>   tpm: Return on tpm2_create_primary() failure in tpm2_load_null()
>   tpm: flush the null key only when /dev/tpm0 is accessed
>   tpm: Allocate chip->auth in tpm2_start_auth_session()
>   tpm: flush the auth session only when /dev/tpm0 is open
>
>  drivers/char/tpm/tpm-chip.c       |  14 ++++
>  drivers/char/tpm/tpm-dev-common.c |   8 +++
>  drivers/char/tpm/tpm-interface.c  |  10 ++-
>  drivers/char/tpm/tpm2-cmd.c       |   3 +
>  drivers/char/tpm/tpm2-sessions.c  | 109 +++++++++++++++++++-----------
>  include/linux/tpm.h               |   2 +
>  6 files changed, 104 insertions(+), 42 deletions(-)
>
> --
> 2.46.0
>

