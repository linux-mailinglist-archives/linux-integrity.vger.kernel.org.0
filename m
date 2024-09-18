Return-Path: <linux-integrity+bounces-3630-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC5897B822
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Sep 2024 08:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87A6AB21C2B
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Sep 2024 06:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E0F15B995;
	Wed, 18 Sep 2024 06:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfGgd1hu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A624523B0;
	Wed, 18 Sep 2024 06:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726642082; cv=none; b=k+TFnawK+EDEt/ZqPRy2PHsEZQrsTFlT58ciZWm6019HJ2Gh6JuUJ3XTVzn2F9TtdC+V+4FBOTHMU8dQDFpWLvVDu5cPkg2PTuLxE3i1jxdicaxSF6fUyOdJ9cesLZNYDrNubpmZnKaMN3uUtG/lTCaZn72p3jhaMV5wJDbJ3BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726642082; c=relaxed/simple;
	bh=McIvYy+BGihGKxJMpTs8gHXv0sinqQ5zAFYvzUigNOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IoE7Y2rqKFan6OsbY79aIZWdepzy/SV1xlL7PsnSm7SYbVg4oqNldmAZwkiAS/782W080HR4ulWH0ZbJpCJrUKZUZgf8NjL/LuL2qnTYKhYQxEV1hL9j615nkLp2k/EjTSkBd2syxk22TTJu4bV0RGwmPBllbQL7Lq1E7I+iQaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfGgd1hu; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-536584f6c84so8078401e87.0;
        Tue, 17 Sep 2024 23:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726642079; x=1727246879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBA4nXH8MQgpPlR0fk7ZqDX4tlkcqpDR/ShKhOG7YKw=;
        b=CfGgd1hufIF3LcSayWjG3ih+aGObz53DEb1mynq/zopEkyJhelRNUCcJHKSeuBY8MC
         Q4YOxbjRgJ4OqF2a/BuJBCMhN+fX4IPEGHEVOOaaHnf+tAi5LfbSG0hUAsVeawHIT1DJ
         0d+diEVGDtTxmCcc47NS9ykG3s6I4T2V6mjrBK462P3DJbm3cW1OacGNZGYIHVEwT0JU
         kxNZMCeLhGDTy5Hnk6LqgMaFvut7xdMHTKWMNMpOCOtdJNPR4RuCmC3LgCECL8txoh5f
         wS5ugHQ3g7vAE5Y221wLEjZGQCOFsOauubmQkmHmQ1RLiyD1j9mbn3b3zFIVJ5Szn19U
         6L0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726642079; x=1727246879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WBA4nXH8MQgpPlR0fk7ZqDX4tlkcqpDR/ShKhOG7YKw=;
        b=mQVy5AziuS4DEUu45gKCIac3s4bNT/f8wPTpqQxgyQlJYM+dgxmRB2rQChhcj43pw7
         wuM2NcmVycmc76rFCs5ZJkP0UtObzbhgS2BfpS23qrXRNu7EcKXhpdtTseSwPguZuqNp
         f5W/1B0TI4nez5r8RC+EwJzAVstFQuHbdeKU2PVjede4HBSgLrlcv015LpT3OnXqgYvT
         zsoZ3in8c2ghaD2z2XjQQOn47hvUvxqRWRaEvkJ2YpZRpPY8Em85M5imCjD5vwerHQSm
         aalZKQUaf6vZzHF1HTb7D2Z2aGJNAdst6I1yxiu6MFxBuK5Jy0pdY5RVBb8ykYoePbnC
         /ffw==
X-Forwarded-Encrypted: i=1; AJvYcCVVSVopTlpb03k12GezarBCsifgbd1yTdfmTl7Gmh7BKkM1ZZeVFhvxTWK3nT/kv6j6v0IQnKw+dQ==@vger.kernel.org, AJvYcCVqSG+Gl+QslPtJ+zh+zYZ6yueAmmNGBEbAnndbgh/3kpH9r/WBgP+RDXcCaiBb3OKPDoj/yDd6qoUf5MGTpbtQNx67YTrq@vger.kernel.org, AJvYcCXyIClnNq8rhxmXSalf0NbUpZE1nywCCImQKrI7oqFZvOQ4fdKJ9jjyMi07T6xmpvpmxO/PyxJDvJh5O+eT@vger.kernel.org
X-Gm-Message-State: AOJu0YxSNoJ78jhTpkM9rWhDlJH1MFwofgLuunk8KNXtucFiwzg26Jki
	KcApHfwkdx8afmgxWBACliu4Wmpu4Yir1yqnL9mLq0WfaHeMswcRQ1ZJhD/aOusXsJRcdJLL9e5
	TwJuQ8hYTIb8B7fbgXHA/uaBgd8E=
X-Google-Smtp-Source: AGHT+IHEtLECEowm3VS8B7S2CugiZp0LgUrES7e/uZE5IPiTtMPah0KifYNlKfcEWtvvgn5FBoxT8Gz40YzESYWF+bw=
X-Received: by 2002:a05:6512:31cb:b0:52f:89aa:c344 with SMTP id
 2adb3069b0e04-53678fc22e7mr12153487e87.16.1726642078318; Tue, 17 Sep 2024
 23:47:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240917154444.702370-1-jarkko@kernel.org>
In-Reply-To: <20240917154444.702370-1-jarkko@kernel.org>
From: Pengyu Ma <mapengyu@gmail.com>
Date: Wed, 18 Sep 2024 14:47:45 +0800
Message-ID: <CALSz7m0EvuDmRQHCbmwA=ED-bt7x8mhCS=X69f+yx60SYq7VgA@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Lazy flush for the auth session
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, James.Bottomley@hansenpartnership.com, 
	roberto.sassu@huawei.com, Mimi Zohar <zohar@linux.ibm.com>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jarkko,

After applied this patchset, the boot time become 8.9 secondes, it's
more reasonable.

But this patchset can't be clean applied to upstream 6.11 kernel.
looks like file tpm2-sessions.c is changed in your code base.

Tested-by: Pengyu Ma <mapengyu@gmail.com>

Thanks,
Pengyu

On Tue, Sep 17, 2024 at 11:44=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org=
> wrote:
>
> For the sake of:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D219229
>
> v2:
> https://lore.kernel.org/linux-integrity/20240916110714.1396407-1-jarkko@k=
ernel.org/
> v1:
> https://lore.kernel.org/linux-integrity/20240915180448.2030115-1-jarkko@k=
ernel.org/
>
> Jarkko Sakkinen (7):
>   tpm: Remove the top-level documentation tpm2-sessions.c
>   tpm: Return on tpm2_create_null_primary() failure
>   tpm: Return on tpm2_create_primary() failure in tpm2_load_null()
>   tpm: flush the null key only when /dev/tpm0 is accessed
>   tpm: Allocate chip->auth in tpm2_start_auth_session()
>   tpm: flush the auth session only when /dev/tpm0 is open
>   tpm: open code tpm2_create_null_primary()
>
>  drivers/char/tpm/tpm-chip.c       |  14 +++
>  drivers/char/tpm/tpm-dev-common.c |   8 ++
>  drivers/char/tpm/tpm-interface.c  |  10 +-
>  drivers/char/tpm/tpm2-cmd.c       |   3 +
>  drivers/char/tpm/tpm2-sessions.c  | 196 +++++++++++-------------------
>  include/linux/tpm.h               |   2 +
>  6 files changed, 109 insertions(+), 124 deletions(-)
>
> --
> 2.46.0
>

