Return-Path: <linux-integrity+bounces-5847-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1658DA86789
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 22:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 499B69A7F87
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 20:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DE7283CB2;
	Fri, 11 Apr 2025 20:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fCdOkhe9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F5F28150A
	for <linux-integrity@vger.kernel.org>; Fri, 11 Apr 2025 20:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744404340; cv=none; b=q+IU0BlNKiLMLN1HeT77GAJvS6RT17m9/3ThUOm7VopmoNbE6YB9cos3MsdCZLFY2YCHtsPE+klrRiXCpId6vwcmVsQs27tSk/B0SJdBQR7wtc4y0wCwQgL1hUvJL5uN74/M+ZRbbYyT0bxZ1WPR+abBqayxMnHb6eUNb3m+XIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744404340; c=relaxed/simple;
	bh=w6Ke9wv7LjR/4PFnRiWR5xnZ0BH+mtCxjUCYNIXimSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rnf/0YELE40if4sga/bfCt9TGW5H2Ad3EPGEnWpmdsav9RMno1MkqnRXf55fdIxW03x/s9yYaNYX0KwNtJ1BkT4iHc7c/mW/gY0PKMgfayeQnty7loYNHJwbjKa/9oYgA/9k4vmwsdX/08sHL5r4wuFG7TkxHRUz7tgA1JxBfCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fCdOkhe9; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e5372a2fbddso2217083276.3
        for <linux-integrity@vger.kernel.org>; Fri, 11 Apr 2025 13:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744404337; x=1745009137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6Ke9wv7LjR/4PFnRiWR5xnZ0BH+mtCxjUCYNIXimSo=;
        b=fCdOkhe92a+czn6r8lTKR1HFI22RNATPq9sn8vHZb/OYbO7ZU0jM6hmwYQOt9GEEw6
         Q0iCXhzSG9126s1ZEdyk6S7KHPlrnr7tFnXYZlIRry0R9wEW44meemrR8mSIC2UfgM72
         Cq2ajHPVhfjfzRzGEQQ6W+4dkYOchA1WSWeTksIIGqq1Q3kOcaWe/yBICb/juk3vbo+H
         oUcguB5VjkmnBqqfp13PiHUDAk9u5hLwzrZsVuxl2b/ESD4djfb74tU91JdKbD9uaUU9
         486jZlS6mJ5q4sgJeLbDThvrWYtH17ytD8QGyG4rW1Tvpe8g4xQ3JfBp1ptg/g8e7497
         msGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744404337; x=1745009137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6Ke9wv7LjR/4PFnRiWR5xnZ0BH+mtCxjUCYNIXimSo=;
        b=rwYgupf/7XkGfWWPecY87+CCMLj5zP0NMzzFgRYuCo6mSp4mseXrTVfD5AHEjbdbBt
         9otsmmb7NQ+n007DD9YnfBcHvg8ouEECA53NmfPnBZlpItG6BFxicOrRO1amISWVYyxz
         EH9ske1kzDT07X5mkXaxebF7SbmQW0qP/35kNhuG6KMdFf8Dtj/AztY4eQMmsjM1bWx/
         XeQiNrVuUVS2qO2jh69gx5rFt+RoZejsSXPIrpiU6Bs+V60AIGaW1661OrDPY76SP2Ex
         SCftD7P+bdmNNXVOXcrAjJy4sAGTyKP3zOMEWx3I94iEUYLI0nwDq/oQ/yB373R4Nw2E
         e8FA==
X-Forwarded-Encrypted: i=1; AJvYcCVu5Fqzp3nGYMFWPlUAKF6daMTTveDF6Ytdxq4N6toRHylci2ZkdiAFaMly9Px5exZIa3UnQ39QXHufLkxPBJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoEyUSZ5IJVVTRGkAKbQMH2gizhis4ci1wqbQQx8TvYZre1KAt
	mDSEss/tdwlk31o6vcP2XpLL6zTZY9bbDluGm8JHZ2Yy5YHYuEnLhZLiIhXOxEKLa4TFlYv5WC5
	iEA+8jKlO2sjREGsD1+DW8xK7cAtK3Iftoi3F
X-Gm-Gg: ASbGncvdRvZiqKxtIbpSdrwciiRzVC0IIhRURmFgMpGKgcvpVEVp8TLZHt+/rAuuCtg
	sVOPCrNNZV/g2A/2/Wmxl+6GxhkGEPYjVVCHUtNKarY5+KiSyQjlHw+oFY9J8A1z0urXkbhwOE0
	GJP0YjUjZ4sCISVxzt4xpP8A==
X-Google-Smtp-Source: AGHT+IERD7EfEd4vcG+sH9/p55NpMd2VNX+B1QFTclYMresfzQTk4MDCOmiXBzyaq4WSjA0sy7Gh//Ms4ocoFVGvxPA=
X-Received: by 2002:a05:690c:20a7:b0:703:b8f4:5b0e with SMTP id
 00721157ae682-70559aa82e7mr59884407b3.28.1744404336823; Fri, 11 Apr 2025
 13:45:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-53-paul@paul-moore.com>
 <202504091643.3C42B66ECB@keescook> <CAJ-EccMhb+Ry0bW8abExkE5V1wJe+CUO_Ty41UHsH-s1ZJdDhg@mail.gmail.com>
In-Reply-To: <CAJ-EccMhb+Ry0bW8abExkE5V1wJe+CUO_Ty41UHsH-s1ZJdDhg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 11 Apr 2025 16:45:25 -0400
X-Gm-Features: ATxdqUEFkrL1sQ2xYg-xZSMKiA1gg-2u5EQBXUcwBefIS8-edyh-uTPNanoSGQM
Message-ID: <CAHC9VhSDR8A9S+dsy_KX5NwNKgq5JaWVK1m5rXizir6RMtonrw@mail.gmail.com>
Subject: Re: [RFC PATCH 22/29] safesetid: move initcalls to the LSM framework
To: Micah Morton <mortonm@chromium.org>
Cc: Kees Cook <kees@kernel.org>, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 3:20=E2=80=AFPM Micah Morton <mortonm@chromium.org>=
 wrote:
>
> Acked-by: Micah Morton <mortonm@chromium.org>

Thanks Micah!

--=20
paul-moore.com

