Return-Path: <linux-integrity+bounces-1678-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38479876649
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Mar 2024 15:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E204A1F25D1D
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Mar 2024 14:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B1140865;
	Fri,  8 Mar 2024 14:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmvxcPGV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5D6381C1
	for <linux-integrity@vger.kernel.org>; Fri,  8 Mar 2024 14:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709907787; cv=none; b=ZhDqRMu5w0v6LAlSBhyh8B/h7GqWaf2vNH2mbOmJJjnE1r0RUgwMR8wVnr3dYQdNc7SZzjrf4Yn8Y2q870aEC0rMcGy2BW3bAGVMJqB5d5SkxGLWMgOGHQ/nHseBxx/qpvtdC9tJcoQRvg9C1dYolvLz1BjhoO9f+LC1/sxO3ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709907787; c=relaxed/simple;
	bh=7AcrRHJk7ctlQ6un6LX4IWHVFhRl8rVyKsvfFYpNVsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qWvWnl+sB5iv49l0+Xrgvy3NXGU2TYZx36Cb266F21JxrOwkmoTXMvQXHmBJWAYJO0qsIeB2ubt1krsRj7Zp7vW2jqMcL7wolQM4SJ2dkNtxjlQI6kOKw6UuZCQMWAwmaKeDTkGTD/znYI06bQHBrggDy66wpWfLTyDE2fP/nUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmvxcPGV; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-60974cb1cd7so20803247b3.3
        for <linux-integrity@vger.kernel.org>; Fri, 08 Mar 2024 06:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709907785; x=1710512585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7AcrRHJk7ctlQ6un6LX4IWHVFhRl8rVyKsvfFYpNVsY=;
        b=MmvxcPGVl+uYm8grsa/pUOKEiMFrpCRBq3vJSk0rjt3NDSMD/Ye9exk8GwWGZcnU6W
         KdMd+SFPQBN8rY0VCEiOafqKAI2xTNK+Hmd2+cUoFwC2THRGIAfemIGsEaKTF2RrTQGP
         LKhvgVlBYu7QX+mMW2W/ouBdBUZULyMBoNAgEOHR/1SCvWX7GiUxlPYAikqT+6H/L5vg
         48miZzil74trp7TjUu0GKEf79Ipe41XLdWYBecEXaSZ4+P2ahtYm8wEr3At0Djn+FJmf
         6zWLxPE4uVVZWol1v3ooPWYBOZVw4sDJQaTIEIePPUBQOVux4+OynVLDL004GDo7h4Oe
         /KZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709907785; x=1710512585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7AcrRHJk7ctlQ6un6LX4IWHVFhRl8rVyKsvfFYpNVsY=;
        b=WXdJFrZ1OPNrlHAavO4pcIM5BtQH1J+ZNXCWRhmj7lOfMlsztLGk5uWwIX1acpbOwW
         6CUi7FY7cgY1J/f0kHwwAdMY1nDmHfNOq/+Vq5g2+MGqGP+X12VfI4/2ZV2LfkVzGGwL
         Y2lUXD0Zu6pBD2RrFJYnvj16nRZ25M/eV1WK3b6J6O/pvoirrC4H62k1yQL8nLvJ43up
         /jUiqJSscTF7z91Uw6Rglx6W5+QNmaspBsqYXXL0IfSuUbfulCogBDTEMdw+VNbblySj
         e/CtYB8VACpQbMZwB/KMiKHoca4UZRpLbpJumYu3qHdfN1OK5nnyGgKjX0U9VmeKY5fb
         ORPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVK3Hhyxk4aHqp4ecgF8d2YJk1USROfwEXUfXHdbTG5WG9dOis0K1rrK4N+PW5Zc1ijR9/CijIKQ3fyZMOfpiA9vXTuBwMn2rcsmKezKHNM
X-Gm-Message-State: AOJu0YwdEqMIWXyliw/IQ6NwZGgWdn0toVmYIX+SOScjzfjORmd3qnvH
	A8EFadKCtNyBbjxzSchwyFfsFe5+UmFXOb3FTuab/UbQVajNXKQx2KTvp2m8j2mxsH6k77jqnb2
	UmMR9akTMzB5jpmqcUkkpuE37H5c=
X-Google-Smtp-Source: AGHT+IE0h6W/EkY1oB6ENnQ05SUWcYX5YhvC8NKy14c55AlmUofwXpVLm2BoSfosUo7svte6McuwBPyoLik1b0wqfYM=
X-Received: by 2002:a25:2d1:0:b0:dcb:e82c:f7f with SMTP id 200-20020a2502d1000000b00dcbe82c0f7fmr19169528ybc.12.1709907784880;
 Fri, 08 Mar 2024 06:23:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CZNS5B6JRFLS.28TOPENHJIKCQ@kernel.org> <20240307224957.29432-1-adamoa@gmail.com>
 <61067410-5cbe-4b28-a31c-f994933f310d@molgen.mpg.de>
In-Reply-To: <61067410-5cbe-4b28-a31c-f994933f310d@molgen.mpg.de>
From: Adam Alves <adamoa@gmail.com>
Date: Fri, 8 Mar 2024 11:22:53 -0300
Message-ID: <CAHwaaX_OmZek4z4M=h=4C_Xm4W=mjsbDVX9k8LsQDke9kk00DA@mail.gmail.com>
Subject: Re: [PATCH v2] tpm: Fix suspend/shutdown on some boards by preserving
 chip Locality
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Paul,

Thank you very much for your review, I will provide a new version with
some of your suggestions.

> Out of curiosity, would reboot work?

Reboot works, but clearly in an error handling path by the firmware
(the whole system is powered off for some seconds and then turned
backed on automatically), this doesn't happen when I am rebooting from
another OS. With this fix, reboot goes softly in Linux as well.

> I=E2=80=99d use `` from Markdown.
> Could you please document the TPM for completeness?

Done. Will be submitted with a new version.

> Is the exception useful, if a user explicitly requests to disable the
> behavior? I was thinking for a case, where a newer system firmware has a
> fix (and the DMI check would need to be extended).

Thanks! Will submit a new version with possibility to set module param
to force enable, force disable and auto. Will also include cmdline
documentation on parameter.

> For completeness, I=E2=80=99d mention/paste the new log message.

Will be submitted with a new version.

> Should this be backported to the stable series?

That would be great, please advise me if I need to do anything to allow tha=
t.

> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

Thank you, will include this on the next version, submitting shortly -
I am currently testing.

Best,
Adam Alves

