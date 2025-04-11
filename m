Return-Path: <linux-integrity+bounces-5842-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A91C9A86629
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 21:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 677E01B881F0
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 19:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DDA27BF77;
	Fri, 11 Apr 2025 19:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XT+hUKYL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9F2279353
	for <linux-integrity@vger.kernel.org>; Fri, 11 Apr 2025 19:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744399216; cv=none; b=kmvnKWOuYX6rHUe7h/Gt1h33364KV8r6IaVFRtgH95yJNf8d9LVhMWkgkWAAI80PulvYtHrHgRnSaSrmpBqHEP2WnW3/7RD62ptLAjbrtIpNQmiLVbebpuRPSB/sfs+wHM1yUJG4dwPFQQjZR7CIwzNWmmOnvVdClRT7fRw2mzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744399216; c=relaxed/simple;
	bh=bwQrki1LW4rIya7QfG7cpYGxUJCP7olPSs3vTIDp5HI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lq/ZThoEfyrSsSSYzrIuiuUsW9P67Q6g9XUU/Xl6QKas91HI8P3qwYrufkZQYYlcDWEkZMEXj4GCo+72rMbTdQxkNxojYFeQHyfJ4IvARXaTpfSWABbBsd/epMeLYAHh683LMkCLgFotNUmSDC8bE/FMy2wEmEHjRDQIxY6uSD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XT+hUKYL; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac3fcf5ab0dso407584666b.3
        for <linux-integrity@vger.kernel.org>; Fri, 11 Apr 2025 12:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1744399212; x=1745004012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwQrki1LW4rIya7QfG7cpYGxUJCP7olPSs3vTIDp5HI=;
        b=XT+hUKYLG9ussuY9QStIWsO+NRwf71+8e9MCCCvImPVfbTh7mfqsTd/sp9Naoa8fEi
         dF4s3Olq9Cf3dLUMxOhCTiTq8rwXZ0fKJiR/FFg7qxfpBGOUig84RaBCqKDtsFDfdQt4
         D6q6IOyx3rTSQKPs4MlwmUnTLKcd7hYc7RTSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744399212; x=1745004012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bwQrki1LW4rIya7QfG7cpYGxUJCP7olPSs3vTIDp5HI=;
        b=K9dAEF+cjM1H40P6Vt9kLxImmVad/UB/Ay2GCxrhnIGmAJCbv9NZEabd5lP3MxuRoL
         aX43alFwvVYeAHHTdd/L89JgVijJYkcvTFmPXhYExxuvyYBsHB1o6rO2hFeKDlExc5aP
         9r3SgZ1abZ6tAjESU0V+POi/BaU1wmvOK9dZ5nbVnaC3OsJXl6yLhx9W/kNP6mDIhBA4
         g8XWLhSnbRjNerIi3YofESWNUo+uA+jczfn0j9k7+MliyK5DaIN/EFIhEP8DZ8SGjBr8
         uA/1g2fdYre5u3aB2lS0Cu8vjTBrQrqCeB8hQKcPQVWdotcdAzwji46HPYHr7KfSFFgy
         EIQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsVomAe081dfWCLGI8k5Dn4bhDZOa472tTOltj9R4pT0APqUA+f/ZMhv44DKi8dRu689D54j3V2/wDTZmVCYY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynyqk4F9NKfkRoNHFX4CTtO179gBVuJtmGmQl25PyHTZoBNTCw
	W58gJrJ09RT0o8Yf+i7fi3s7roM5zizXNInEN4xjLtzPmh+TerumtAYTAZ1OyfBSgLDIlZtBgpo
	lbTSYG5ywskEjo4CSEqPFvIu4LtmJ1JtE9jCs
X-Gm-Gg: ASbGncuxhgudwzcixNMaQDyCdz5ICi/q1CV6O6UMqqC0rWexDnjLKuD9UsSiws6fLiW
	J0/PElpWZSw3UlKVb5V2/tugYoWbG1FaVx3l8EvLqJc9WdDzHj0uXwHiyzN3vjyvnTORE6F6Scj
	TPIa/OwPjm3e3tFmQhPxVzRnM=
X-Google-Smtp-Source: AGHT+IErO/wFycetDqHLZ59nJlqxvZeRR7iYXzNYsaGdLraNNvnVeWXTxdCP3oc+y0OVwxcW9yRJa73Xy0cfI5TS2Z0=
X-Received: by 2002:a17:907:3e0e:b0:ac2:55f2:f939 with SMTP id
 a640c23a62f3a-acad3446cc9mr330029166b.6.1744399212186; Fri, 11 Apr 2025
 12:20:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-53-paul@paul-moore.com>
 <202504091643.3C42B66ECB@keescook>
In-Reply-To: <202504091643.3C42B66ECB@keescook>
From: Micah Morton <mortonm@chromium.org>
Date: Fri, 11 Apr 2025 12:20:00 -0700
X-Gm-Features: ATxdqUGiVvNux-N2_Zf2iA8S0CxC8AJE2HGWavCv50sc5-TRBEPKBa8mI6Moi7Y
Message-ID: <CAJ-EccMhb+Ry0bW8abExkE5V1wJe+CUO_Ty41UHsH-s1ZJdDhg@mail.gmail.com>
Subject: Re: [RFC PATCH 22/29] safesetid: move initcalls to the LSM framework
To: Kees Cook <kees@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 4:43=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Wed, Apr 09, 2025 at 02:50:07PM -0400, Paul Moore wrote:
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Reviewed-by: Kees Cook <kees@kernel.org>

Acked-by: Micah Morton <mortonm@chromium.org>

>
> --
> Kees Cook

