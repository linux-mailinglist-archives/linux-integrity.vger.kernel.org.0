Return-Path: <linux-integrity+bounces-4536-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA74A0AD98
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Jan 2025 03:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A00B1886337
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Jan 2025 02:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3DA85260;
	Mon, 13 Jan 2025 02:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="boq9L8Re"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D81749C
	for <linux-integrity@vger.kernel.org>; Mon, 13 Jan 2025 02:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736737000; cv=none; b=OzlVleUFpId2+KU9I/YImN6VGNsf+9TpQiIm/v9l+mc20d+v8EuOBJxo9dUNhatBzauG7ABPDZEbY6pVU1Q7CsrY3V+N5RLfyztKZoJPTT/+dPae2kfU0tihsluREBdtnTiOuDzS3u79zQePjURuieNUtj9e37zOPrnl4Gd8sh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736737000; c=relaxed/simple;
	bh=C1iu4TmU/AZryZK4710MbhiDlwhEBApAQBoxuQB8Gbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iHFq8QY9qcPK+lKLl3tzrWap9qJwBP/j8gRQ1OGuDZDmKGK3/zsO98ubSIlZ06VgKH+z2Ol8Xg9X91255lbtsat3Dgu3EO81pWT8pzPKfjUYajPlcdleHKENf61q5gKAMuX/qNZNxMO3IdYqI7JgiK17ZuXMxTLvXemkEapEJIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=boq9L8Re; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e399e904940so5776158276.2
        for <linux-integrity@vger.kernel.org>; Sun, 12 Jan 2025 18:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736736997; x=1737341797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1iu4TmU/AZryZK4710MbhiDlwhEBApAQBoxuQB8Gbo=;
        b=boq9L8RexMcsmglexIYOcxZ0MhmZl31BQ0u0TT55zZxUPAErFHwkBVu/GF3GT3YD/3
         S2WqvYi4TNG1Q6bWH9CggBXiM379cw6k0q3LxXjhh+wBZHmzf98hKuJwA++SItWPm9Wp
         hCBQARhS5uqu2WWfHJ/161kdkr6FL6PYiHsm0NwYjqRtPXuRUHlV1UVl4WnJML6nzq4w
         ueAzbgMJBx0CHO5dWy+QRhkNm1spQhPbayUM0uMe60Gdm9ZgYmVh+BRVyaEO7/woW8VJ
         0dIPjX4YJZodK5ovA18GAtmScZ9OHB7vpklN6rWkqUme5UBBDJ1uQ/9+c9+8jwPMR7fB
         2t9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736736997; x=1737341797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1iu4TmU/AZryZK4710MbhiDlwhEBApAQBoxuQB8Gbo=;
        b=bsGIHhTYHPXuM4R5+5fca+h7K1jBvz/hzetc4MNBWiD9P7vCsSYV3g/46zmjEKWg+a
         +RlsuALmX2J0GgZ7WObpfgmxnDVhfLiU9TomoCRaIxmHVaGehCFVQkwSbXPDgtHUr4Ls
         7QO8cF5SQkkZVECj08KBLGZI+0ucHtwUNSFNn6OWuiX5A7dz1r7pOCQ/MHBSda7uBI6h
         VHqBzXjboyXLAqrT8sanchWiGFK+kfq9GbxCfXMkqnygJnlZ4RBYHLyFyHPtWHmrgC8Q
         wJ+5r4JEah7lUxxTMeKFiP5s5CJ8Ga9hN0Vfxxo//Pk+1nG7mKKcCOWoQx6CccyvwIan
         UEEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGD6CnxOqRa3gVgC9PuMNpujB7DhOBQRXp9TZQnDjwh6I7ZZ5ZYrx+VjmoXrXujSAydBKFPbOpfrwPzTEqRxE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9frBTH6s7tqbzKRepY2S5Ek9hI39HtlhDB0N/Clp0HB/C4M1/
	evA9WZ1JergHlSp5UfsFYGv3+KuXgJm4llHBl7W66zefZXE3HQdzTMectNH59z4268hXHlClpcv
	Go4JsukhGfnCVhc4QaPh5LFQN7gFznsUlfOPv
X-Gm-Gg: ASbGncsqHLZQqMH/C+nyajRQam3PaLKREJHvgbIKdQZHS3E/11iHdFROvg9tsvc8w7e
	/jBEKpRIBgQ9EdpG2n/bBoO8QhD+gkmM5wGjq
X-Google-Smtp-Source: AGHT+IFjS7DdRTcEdBRLB9UTOd3mDij4P3x6llwm89cu6gVhI47+WAfxD1vVcp4PpGcONy8Uv1dZysPvrHpMXqA9mNY=
X-Received: by 2002:a05:6902:15c4:b0:e3c:8b14:e7ce with SMTP id
 3f1490d57ef6-e54ee1f4a31mr14579604276.34.1736736997649; Sun, 12 Jan 2025
 18:56:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111.22fc32ae0729@gnoack.org> <20250112072925.1774-1-tanyaagarwal25699@gmail.com>
 <CAHC9VhRbZLtBZ8dH-kASnkQUehG4Cu=zd23A6Jj9zfnyeGOTsA@mail.gmail.com> <3c73cee2-a4aa-4e85-bafd-d5571e857849@I-love.SAKURA.ne.jp>
In-Reply-To: <3c73cee2-a4aa-4e85-bafd-d5571e857849@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 12 Jan 2025 21:56:27 -0500
X-Gm-Features: AbW1kvbyZN2Ngdlc0r-2OxHSCbyV0tl9D8n5OSt5gTQRGL2HTVecrwUevJ2okxg
Message-ID: <CAHC9VhQxxwyDkXvN5S7XbbbJTk5-LN3MXteX+F+Bx0wTxujhow@mail.gmail.com>
Subject: Re: [PATCH V2] security: fix typos and spelling errors
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Tanya Agarwal <tanyaagarwal25699@gmail.com>, casey@schaufler-ca.com, 
	takedakn@nttdata.co.jp, john.johansen@canonical.com, jmorris@namei.org, 
	serge@hallyn.com, zohar@linux.ibm.com, roberto.sassu@huawei.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, mic@digikod.net, 
	gnoack@google.com, stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	skhan@linuxfoundation.org, anupnewsmail@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 12, 2025 at 7:00=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2025/01/13 1:36, Paul Moore wrote:
> > Hi Tanya,
> >
> > Ideally this patchset would be split into into seperate, independent
> > patches, one for AppArmor, one for IMA/EVM, one for Landlock, one for
> > SELinux, one for Smack, and one for TOMOYO.
>
> I don't think we need to split this patchset into individual modules,
> especially because this patchset does not affect the result of kernel bui=
ld.
> We sometimes need to do "git bisect", and reducing number of commits help=
s
> saving building time and testing time for bisection.

Merge conflicts and spending time having to coordinate maintainer ACKs
is a real time cost.

Split the patch please.

--=20
paul-moore.com

