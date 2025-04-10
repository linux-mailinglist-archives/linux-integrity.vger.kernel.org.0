Return-Path: <linux-integrity+bounces-5807-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A36A84F57
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 23:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5C51BA2DC8
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 21:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA90C1F03F8;
	Thu, 10 Apr 2025 21:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UZ/0PdFx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DDA1DF27D
	for <linux-integrity@vger.kernel.org>; Thu, 10 Apr 2025 21:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744322305; cv=none; b=hiQGOZ8hpP73amz8nyOz8B+Jay92+OU9+eLfXnOmNxCBxDoWmWsKN91+BAmll3PBSdf/3BU8cdjJ2JA0vUUHJondvYW1AmSkW4ls3OuQ+eq4p/2ycASY2+e6S2s6OwxqlXR1NkOLyfm9uzwBwOEFCkOSRUqNXNQTVW4t3qcMkD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744322305; c=relaxed/simple;
	bh=xf+Qpp4fWLADurZF671LO8FaLAy3yzJQjgSG7swl/Xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kh1crAmu+h06iaMDL/lVw6evXRt6zuAR5TudXTDSgcf5Mb2fJ4c7tTmortCY1v/2rlpA/L6TGZN5yqfwewIfb/Jm8FiaXEryNMb3WrIXqFujVCz9SKkZmvt1XqU1pXT+3ExOZQOzcBpfNmRfcz7g0WL9QUs3zkZJbvlB9eoeF0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UZ/0PdFx; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e702cffe574so1097256276.3
        for <linux-integrity@vger.kernel.org>; Thu, 10 Apr 2025 14:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744322303; x=1744927103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a99uw9N7Lzivq2ccoM3Ykb2u8k0fY7Jrmxn9hUy89Pg=;
        b=UZ/0PdFxQv7bPChJ97kD+qQfIPAMcJI25EjZjyXuzLn26lSnA177P8F7uaE1s6WUzl
         JzpEhnl0/DfdioGAWFxvTv0dONXQlg3Sl+BJHY2yryzVwuXbUVutqAGt5cLahhTTibjn
         p4xGQ4wJ7blZFzxbDcG43Ml0QhMhkVl+/OaafeRwebKkqr33vpD2bKvJhT/d/l8LJPpV
         zPSo9EPmEeBeeiv0tu9+1lThKUGu5slSaBmmkntMu8wJ2Syh6DomdpOFwzbrvgLl7DKm
         J8ZM35RYusnmcOVccOV+KVSKmRh0CLPQ+YfwYaaIzC9p0Nn4PnM3xrTt74+NkS90L66l
         UB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744322303; x=1744927103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a99uw9N7Lzivq2ccoM3Ykb2u8k0fY7Jrmxn9hUy89Pg=;
        b=grTujgoFvbAxiMkD6Ue8MX/pFV2e9Sk7RBq2I1uJzBvXV8oglSKbixrSubEfGOQ71T
         NuMUU7fK7JmTlhoMtbteZs37+fE95m11jM2E4k0lSNubVnSKceng9eAAH8awRrynatOu
         IMvGdFpTK4eNUZoQv/87lyReSp2Hkuh38j8qCAoXybJ9gIjuflmWLh7lDccT58Zv2r4n
         8JaZBkN2uMB0vTpZer0WzplMpVZCnW54s9+cs1IcbHY2OnTHye7vO8gA0S6Dn0KRb63V
         j8rhU07tp+2Io0f37wD0DiJj2dC0OzpNc8Qj3uB4A0MFg2Pg2cEYDWb0LNDzrIrfJL7d
         F3Pw==
X-Forwarded-Encrypted: i=1; AJvYcCX2ztpKU+lMLNb6QT7rhT10H7r+Mz6dt/nEWioQ8yg/zfikRtjWVJZwIISpsIszMjVIaqUu2eXOHemh+XUCQHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvov/A4lrywNg8aG4Y/9pXgajBHamVqaX+Zc0SIhgdWHOlMzBR
	NyeSy5tQnVu+bGvqUY4zbTdKo04P4woS5Zyq5r8xsWXQAB7cFUlmRovXImfLIUDXLvYvMux54ML
	J+5LYq2FfLRCwBH5OOtXpeejUvzi285AYbuCG
X-Gm-Gg: ASbGncv2efn+woiHMp+LOAihXOfxweJTaNIZmImEAQZ4M83tzkhg8KTa5LDugr/aCjP
	wijVGB2lcngiI+0SbQNN2UJ46SvygNaAVsBOc83wZUHH6oUdVllnTJEgBMztW4upPjT393yJaiZ
	ej07ehVGAKEzCFu8Tal07I7A==
X-Google-Smtp-Source: AGHT+IEhqGj1qeRSmULuZX8MBjusdWC5sjxEfjdXDaapWmerQoIjW7G/m0gW/nqxXOgQ7naOlGkeTmN/+rBMNMZGkQg=
X-Received: by 2002:a05:690c:4809:b0:700:b001:a938 with SMTP id
 00721157ae682-70559a013d5mr9801527b3.20.1744322302824; Thu, 10 Apr 2025
 14:58:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-38-paul@paul-moore.com>
 <3da6eb0d-9781-4d9d-b6ef-f9105c231b17@schaufler-ca.com>
In-Reply-To: <3da6eb0d-9781-4d9d-b6ef-f9105c231b17@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 Apr 2025 17:58:11 -0400
X-Gm-Features: ATxdqUGFoxDpFViEAlbFwq9G2XjX-epmb8ySE4XY5YfFgHpmthXke_Xr2ekPqKg
Message-ID: <CAHC9VhT7eVyds28nL-Q=w=Qbe=8mtUCmfHi-1BVxK_0jk3COTA@mail.gmail.com>
Subject: Re: [RFC PATCH 07/29] lsm: rework lsm_active_cnt and lsm_idlist[]
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 5:38=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
> On 4/9/2025 11:49 AM, Paul Moore wrote:
> > Move the LSM count and lsm_id list declarations out of a header that is
> > visible across the kernel and into a header that is limited to the LSM
> > framework.  This not only helps keep the include/linux headers smaller
> > and cleaner, it helps prevent misuse of these variables.
> >
> > During the move, lsm_active_cnt was renamed to lsm_count for the sake
> > of brevity.
>
> lsm_count could be mistaken to be the number of LSMs compiled in
> as opposed to the number that are active. Hence lsm_active_cnt.

Fair enough, I'll preserve the name.

--=20
paul-moore.com

