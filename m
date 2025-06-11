Return-Path: <linux-integrity+bounces-6427-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 186F2AD600A
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jun 2025 22:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E16F37AA2CB
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jun 2025 20:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E80B2367AB;
	Wed, 11 Jun 2025 20:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eLn/4Us8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9EC2367AE
	for <linux-integrity@vger.kernel.org>; Wed, 11 Jun 2025 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749673638; cv=none; b=tKbZd1MbL1zCB8KEF2giSfQkF6Zq7TrJHOwWYYOJhhNI2BH6BYqyHHZWjs9pzbaQsCig/0Myvx7MgSwncD8VKjfaHZyJ8xwomzzNoEgSkeOOh/ZLZiWpryofbcwnUYUysoBgv7XVpUWWle2KW4NIypJZPRvJC8Fvkir87GdTf3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749673638; c=relaxed/simple;
	bh=b462XvDCSfMevaIQxn3sYyGpMaL7uBHahet9/QOpJHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LWM/ca88THHoSO0AXDumjZnoHVeKBPgLezQ2EGn9XBVj988Q7BKKgyW+PYGXrqgq+cW8sa+dEK2+hAH2eqeHV9UfMxaxRc0oKgWpJak4z0QrXR0MJBXoW/1cjMmr6G6XSO4RauGnSpu6l+pHr7mZ2RzEsI9X0M0MHLKGIsmzvwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eLn/4Us8; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e7569ccf04cso211434276.0
        for <linux-integrity@vger.kernel.org>; Wed, 11 Jun 2025 13:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1749673636; x=1750278436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3H1uAtO+gZJCXVOFgln/U+eNFJCAoQXkaNwNc9tito=;
        b=eLn/4Us8K6pgDk1K37yxhLgGDY/R4sI3hM6xguaNs6VXi9CZy6IS7RdfW8Tg0J3mR7
         X0G3ijtJngWy5hdPSq7ARs94PS86Xq9Ix92Pm9X2Q1kVkIKaqHMwflTzpb1phnfi4md7
         Iwbm7h1bhQuRtbAT1eLOdxYLM9GycF272IjYpnjx/98DK4pd9JARNUHp/7IjVLyrWzqH
         iLpJf5YRVXU1pLb5J+uOW3q+S8Jb9MyypZ/554NCMz1coCtNEuVnxbjYTMUSyPR4EDxM
         Dogv+t5JtOLT0nO+kLANyAsVQYAkarVnn2Z/PrBFlApv3tCQ5n4TgsX9hw3aWRSGgulb
         8XLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749673636; x=1750278436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A3H1uAtO+gZJCXVOFgln/U+eNFJCAoQXkaNwNc9tito=;
        b=EniA9XIphmbcTd9MWwstBFxkT+7nEpa/6RCTJVhv32T8pzJ1f39sKq7BHANzioE8nv
         yFz8CjO94kbQoCdP768jCm9egFDxR53KrSXXgfFysvU+Do+uJZQauP5+JjrWlqr66FFf
         NYvH/ZxPCfYzhzXj2M7A2fJlTaKp0M4td3DLJV5qismCVppSHq+Ks8egEYgpHa1poEnC
         pUzMQ8Sh50q75Igs2JROloaCSn154kkchPfJeL9pHP2pY9Jf2THnkrO2pEOcN2PWx0Wi
         3j+iUxO8nEGdpX4mG3Z0I8CsCHu5hjZTiUvKTbAocrA8ohcPec66464XNMFlEb6c4THZ
         y7KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVUVonT5JNOharJVtYcAYOsci29qiaHGR/N8T/7u8dZdCL5pT3BE0OEngaNBM827pvQgXoeNV62stXnFrLOuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuVeMV108fipPTuIC8cJybg9d2LfpMrrI78d8G7GHSoES3SvuD
	Vxb9mt7XGSpzQoNkO7Sg18DVzZy5vbBzC3EVReji6yUlvrZfEHOgidwQICZBHON9MhHKh2BbYrX
	wPObifdM6j+DaVhlmQ5hewJKpamc75ahTt4lKON/i
X-Gm-Gg: ASbGncvsCVrTdvII9BsaZSPr2Gg1uH/gvYfihAvDenXVEzqNsx0aEj8tlI/LfObeief
	7RrzxasJ+kzNcpGvemsayfDnQRwwHWPRSH382eHtXusif0EcAmX1FsOvxSVLFlzYy5KOcbV6TI4
	gLi0vUp31YQJev/MnP7BfmTPhMtnrJSHPUvzn4VXOqs1Y=
X-Google-Smtp-Source: AGHT+IEVVLEbhs1siAlIrgblMXiy7/1GYb0zZZID5dw2ruoClMFtAoDqtrQDzTOvm/A3WlpYxkgeMG1oUpdy8wiHzZ0=
X-Received: by 2002:a05:6902:2408:b0:e81:e0b4:1bc2 with SMTP id
 3f1490d57ef6-e820c7d6b2dmr752984276.10.1749673636310; Wed, 11 Jun 2025
 13:27:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-56-paul@paul-moore.com>
 <12d9ea5981f5a2c33a01798311543db2e9bd4ee3.camel@linux.ibm.com>
In-Reply-To: <12d9ea5981f5a2c33a01798311543db2e9bd4ee3.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 11 Jun 2025 16:27:05 -0400
X-Gm-Features: AX0GCFtB1BfHO9UnqaP7qiGZ525Kvp-h6Jc_bADxlaJPbPrl5km3UWt0_EFnhUw
Message-ID: <CAHC9VhTfNQeu3gcWii7kUrGY+fVygXs6j4UhybodPqjuSzA-pQ@mail.gmail.com>
Subject: Re: [RFC PATCH 25/29] ima,evm: move initcalls to the LSM framework
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 6:04=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Wed, 2025-04-09 at 14:50 -0400, Paul Moore wrote:
> > This patch converts IMA and EVM to use the LSM frameworks's initcall
> > mechanism.  There were two challenges to doing this conversion: the
> > first simply being the number of initcalls across IMA and EVM, and the
> > second was the number of resources shared between the two related,
> > yet independent LSMs.
>
> There are a number of the initcalls under integrity/platform/, which load=
 arch
> specific keys onto the platform and machine keyrings, which shouldn't be
> included in this patch.

I don't want to assume too much from your reply, but if the cert/key
loading under integrity/platform shouldn't be subject to the LSM
initcall rework, that implies that the integrity/platform cert/key
loading is independent of IMA/EVM and should perhaps live somewhere
else, e.g. security/keys?

Or am I misunderstanding something?

> > The first problem was resolved by the creation of two new functions,
> > integrity_device_init() and integrity_late_init(), with each focused on
> > calling all of the various IMA/EVM initcalls for a single initcall type=
.
> > The second problem was resolved by registering both of these new
> > functions as initcalls for each LSM and including code in each
> > registered initcall to ensure it only executes once.
>
> With the above change, there obviously will be a lot fewer initcalls, but=
 it
> might still make sense to keep the common ima/evm function.

I'm not sure I understand, what do you mean by "common ima/evm
function"?  This patch doesn't remove any IMA/EVM functions, it adds
the integrity_device_init() and integrity_late_init() functions to
setup and populate some keyrings.

It's also worth mentioning that the goal of this patchset is not
necessarily to reduce initcalls, but rather to ensure that LSM
initcalls are only executed when the LSM is enabled, and to provide a
mechanism to notify kernel users when all of the LSMs have initialized
themselves.

--=20
paul-moore.com

