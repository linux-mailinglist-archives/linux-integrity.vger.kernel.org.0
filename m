Return-Path: <linux-integrity+bounces-6696-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AE9B0CE2F
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Jul 2025 01:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2173A3B5C80
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Jul 2025 23:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D6C246786;
	Mon, 21 Jul 2025 23:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ag/ARq7B"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B5C2367CB
	for <linux-integrity@vger.kernel.org>; Mon, 21 Jul 2025 23:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140615; cv=none; b=BTJNASCKCesC+s3kEVwqcZuq08Voa057Ru7lJ0DtkUirxAIein3tnMrxJDnIfhcnRdZ5GYWDiRGZBu+NcHbZ9a7Tm/jb6iY2JSJb967XtSsTDLIAdxqVgfvBHGeAO/OKjsYAjb0CZFVlrbQLgTbtda68Kr0mLNxj8iyron5MATE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140615; c=relaxed/simple;
	bh=n4cACpakvgGkheh0DbJQW2Qo2CVKULduhn3NpR88744=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=er/nBkMuSwaWhSSUVA1b1eGnqQPf0FIhYR4iCA7u9sSavTgVxHIWjvktof1Ein7HhWVcaT5k+OC72lK29n4vJ17HcCmhn6WO0lF2cN/Mh2ZZh5GIRvA86XhIxz6NIUbIPnF5woe5wsS3nUSrK7FiXkbCI/hDQ6KgYDnyIFCIoJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ag/ARq7B; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e740a09eae0so4811385276.1
        for <linux-integrity@vger.kernel.org>; Mon, 21 Jul 2025 16:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140612; x=1753745412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YScyYlmWxZeZkUXTs2GiN2Rd6DwhYsAR3xjaaeYH7iU=;
        b=Ag/ARq7BgOn40Y/lJD7sVsbZ2lsPEdxxlm8svUIJZ4XH8fzo7S6b+HEiBjVq1LSKWx
         1lRGth3RA8Q0+JTMPxNKow/NaaZsGxj1/1B1guYgMHI6ZJKav9mt6gHGRM82Tzkcn3dk
         eP39VdDBh8D8BlcSxE8ee5bAP2ysriawpOyf7TffME7O/4zOrpXLjUVTnnXOGrBLeCTV
         GagOPpe6rfHhwjagdEp2Oca+po+lCfm6sNPSUcMRriJ5cfDY+LEDS8lRJXKbxmCGZPBm
         Q04xolmdGJ7JD/DU013lX4d3PRtPFp/ZEkYnQkuc5p6tlrRMhaa6EJv1S0gTDtA3r8TR
         Nvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140612; x=1753745412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YScyYlmWxZeZkUXTs2GiN2Rd6DwhYsAR3xjaaeYH7iU=;
        b=TKH3/TkCWv1Cbpm86jZEwCXLnQVwwFJhfzDzu48w/5JbMn7KJGqgbKaijCt8r2c6n4
         Y3Rr3rjQnxz1o9evoPpqqgAvL2bcPsNXNydS8pMYNgerpOM4RkxM9HkuJRa1d3f7m8ny
         YJHD1cBeQxE7eShIrNY9ISSc3xDv6lvlKOZJ0TOVznFQGDzUkPOMpCwcU2OrYeH6Uncd
         VxIlGlfr58VfiP4IqLj9LyEXiFRPgbPEkknPoW9AdjZ7lnxefbLklRxAnU63o4/aUDzN
         Usd8gKA91DdP2WYg2Gpx9g9ILlPmuDuOplNid54UwArO/DKT86+X9TSPUTqu1/npBSoK
         UU9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPqGW+U6cTe1s+KoxH4uJydw7WTXjRWW/4f8JPsyUkJMmL8o6GpEDhr5bT9fJvalS7XCXOMVIBLWTr0lZg1BY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyROlllZbmUoiR/n2eLib/2oDhSo5JMCpgU+dKNIHAx5FG6cuSP
	IhViad+uB6KPbFN88cc60Um2TRfL92+yzr7CBKgYB0/u5tpSz+X0b9avJm5QxWU3CsVrJ61Mr4+
	y2Jov8ZxjJJXWpe29M/RLlcBb/XKMPk+MDYC0JnCNLyXBBKNatiI=
X-Gm-Gg: ASbGncvlvgufKX4N7r8yXDzvJD/Osd5U1u2RCzp+6Ce3OqiXMmibpVANVK446GsBa/9
	yYWbiA5/5NueXdSHf6lkmWGX6fhrD+Rk6KGoHahMllHY3K0zse6O6dXLUmPE+MwCkdvpzwxO4NE
	hYgAjtLjuP9Cmv/HA1ZixFiKb2FIGMToehRtN72tEWeeAnTV+cbyu4EXfCfWrs9+IQRZTbg2XVB
	VTD1og=
X-Google-Smtp-Source: AGHT+IHzggdi+b4kD0YQImV9DfXMg1yZN6qGQ3w9w0ti/VLY2zLiyXoRGLzOSdsFZx3ohVsfNJkmn2R66Rnpi25gOVI=
X-Received: by 2002:a05:6902:6301:b0:e84:4341:4101 with SMTP id
 3f1490d57ef6-e8c56d10083mr15777492276.10.1753140612431; Mon, 21 Jul 2025
 16:30:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721232142.77224-36-paul@paul-moore.com> <20250721232142.77224-67-paul@paul-moore.com>
In-Reply-To: <20250721232142.77224-67-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 21 Jul 2025 19:30:01 -0400
X-Gm-Features: Ac12FXx2zja76sOQ58TOV5f_D8IAFTcRD5gf5X3DAnwKfDgcKZX5GBzOMn7gBmI
Message-ID: <CAHC9VhSY7FoQdSo=VvzZCs=_WQhOz+HKjV8jXe==-4wOCvpVjQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 31/34] ima,evm: move initcalls to the LSM framework
To: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 7:24=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> This patch converts IMA and EVM to use the LSM frameworks's initcall
> mechanism.  There was a minor challenge in this conversion that wasn't
> seen when converting the other LSMs brought about by the resource
> sharing between the two related, yes independent IMA and EVM LSMs.
> This was resolved by registering the same initcalls for each LSM and
> including code in each registered initcall to ensure it only executes
> once during each boot.
>
> It is worth mentioning that this patch does not touch any of the
> "platform certs" code that lives in the security/integrity/platform_certs
> directory as the IMA/EVM maintainers have assured me that this code is
> unrelated to IMA/EVM, despite the location, and will be moved to a more
> relevant subsystem in the future.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/integrity/Makefile       |  2 +-
>  security/integrity/evm/evm_main.c |  6 ++---
>  security/integrity/iint.c         |  4 +--
>  security/integrity/ima/ima_main.c |  6 ++---
>  security/integrity/initcalls.c    | 41 +++++++++++++++++++++++++++++++
>  security/integrity/initcalls.h    | 13 ++++++++++
>  6 files changed, 63 insertions(+), 9 deletions(-)
>  create mode 100644 security/integrity/initcalls.c
>  create mode 100644 security/integrity/initcalls.h

...

> diff --git a/security/integrity/initcalls.h b/security/integrity/initcall=
s.h
> new file mode 100644
> index 000000000000..5511c62f8166
> --- /dev/null
> +++ b/security/integrity/initcalls.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef PLATFORM_CERTS_INITCALLS_H
> +#define PLATFORM_CERTS_INITCALLS_H

Ooops, the above two lines can obviously be removed, vestiges of the
previous revision.

> +int integrity_fs_init(void);
> +
> +int init_ima(void);
> +int init_evm(void);
> +
> +int integrity_late_init(void);
> +
> +#endif
> --
> 2.50.1

--=20
paul-moore.com

