Return-Path: <linux-integrity+bounces-7005-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AF175B42A82
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Sep 2025 22:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E36534E49FA
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Sep 2025 20:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD242DF6EA;
	Wed,  3 Sep 2025 20:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="F9NvoDhl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274E82DF147
	for <linux-integrity@vger.kernel.org>; Wed,  3 Sep 2025 20:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756930057; cv=none; b=p9SM3qsfii1U/tL3iwSb2YS04AacW97L419MUNAUwGhVKnDz0ZchoEx7NeTG6qixgI2yZqR17P1151WrKvDJ2J/RaDNywFObAO8vJb0ZWSKpIazIsVsYSkBY8fdeMgMedpyvsgaCmxDN7CW5QMJqXIJjqcyF/JavbXKTqJ130HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756930057; c=relaxed/simple;
	bh=yngmQ/ltButix+LVvtj/TMZq5fYiyFfS8swlHEL00yM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=POdbR9bc8JpFMOKaLyv2nBGWEu6Ymnp/g7HtoFPfpfyqF8XJD9CzEA/uwRRB4Jfk9vl8om7nJSmSa7HRD5QlmdM6kQomnIgct5yPhR2YqhOZhJlAKJ9BuQnVgVMSo8KbF9CITQI2MvwWnrg/ruAzaj9WtPeeQEvvLUfxiSD8nGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=F9NvoDhl; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24c7848519bso3238365ad.1
        for <linux-integrity@vger.kernel.org>; Wed, 03 Sep 2025 13:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756930055; x=1757534855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7BsOvy2TQZjlRoG4f8RUy2TF7CbbV+kzDpz7/CPYH0=;
        b=F9NvoDhlAY1dl1glMsWEDjRfa0U//fMpkgS88uoGFcco6dl8m1oNuNB26SUGgwlUG/
         m+WojV14evsY8vDoqkVXyHzYsHdA1gmf8CmDMhTTcQ34rMyeSUbT3pRLhWeBL0ZkViGC
         dQUw0/g4qTjdMxbfHE4wzX4eCJOrsV9vM3c+5aTDFVjf0x8ChrPxYq/Wja2b6zKEhh4u
         2yrnDKbPtNa5xm4OQposUE8dY1hkucCl/KaYPtTGwziGajWiZg4eJOKNUiPjc3EXrzYB
         i1KpKWlFKX695pTqVRtpvgrRDY4yDuCjkMueHcb92zM8woATwBVsL22IFsOti1cukUVa
         ecWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756930055; x=1757534855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7BsOvy2TQZjlRoG4f8RUy2TF7CbbV+kzDpz7/CPYH0=;
        b=OkACX7BV+9JGwvxAdfiMM2JbDNmXggsG5iGNrTcG2lEHdrk0RL34RA6wbG2+6S9EPW
         8oQSLb2Jqe6FC/t90si/u+9NUkZ2teiHlHbYmrO9u3uu5BUUPKRU+Uyc2E08nEFXG3rd
         GA72lkL1E41zm3pXSoNLnJICcgwmylNmhinfywkKHzXKzNlWFMLkuGZPEWrjXakp3jBH
         JYa+epl2aolJUfIaz6DexfOa6z9pwOyePXGeW8rEeCI1Ld+IyLjVZUSlpBt2am9R9KJt
         YL4TRVzsxq+P9OOZyZfFAMPeDcXOBYh0+Q0xJogNggxUSD17bGtC0dBN0/iejRRePdYg
         zOZA==
X-Forwarded-Encrypted: i=1; AJvYcCXgH1qTg8ZGrmIey2dvLH/80tPzDZEbxh8d+sphpn0zi+pP1xmQKuWjTEhYKsRQeA6kdH7d39qvoVoVIckLrk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKcfXNTcRam1PxarZ0/6+rh7OYLPjy6fSJhNbRN/lLTMXMZ7cZ
	Vkvtl+gBFCNuYSBUBoneZURFpDKnjRWIkzwee3lMkj+S1d9IPln2rM+e+gx/R7GMsLxwFctZ7Bi
	dPNhjsZJ6X9ipAq6kwowpTd3VTiVzS8dd4Uh0mmNHPtfMqoQUPpQ=
X-Gm-Gg: ASbGnctpb5i7CAOYiZzhT2ab3s0emJuA/yoKnv1NATS43vKF/2eorJVU79GIbn5W0AL
	kwEEw7TjQpULwEw4guvne4VEB3ugUTsm+I2kDXsdlTWhkVM94D3iZzOe6T85N7yKYCdDQ1DilyK
	MQtxKA4K5HG8LaOb1FEIBXxWMabbjyNFkJWJD9xdiWle97VDIUVP5e7s4uyzOnUU4i3aWcIlC/t
	RIMptgWm6NNm0B/zw==
X-Google-Smtp-Source: AGHT+IE/jxp5MGXQjY9oGumbm8NaKpkAlmwUE6015x88FR0z5hTMAkqxHgNJHhqTh4+JXLWysrNaHK0JYJQoNh58kjI=
X-Received: by 2002:a17:903:41cc:b0:224:23be:c569 with SMTP id
 d9443c01a7336-249448f4103mr192848795ad.22.1756930055424; Wed, 03 Sep 2025
 13:07:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814225159.275901-36-paul@paul-moore.com> <20250814225159.275901-40-paul@paul-moore.com>
 <e3a54d30-85c4-482f-be91-6d10e0ff6e0e@canonical.com>
In-Reply-To: <e3a54d30-85c4-482f-be91-6d10e0ff6e0e@canonical.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 3 Sep 2025 16:07:22 -0400
X-Gm-Features: Ac12FXzD41H6XFdIb0vdFaRxcoKu4oQccezb2K9_6QR2TZu6fu1vwmKFxGVeaVs
Message-ID: <CAHC9VhRUNPbHnjoOuv+Yby0WPSztSFJJ2GT3NHu32eJxEjiWmg@mail.gmail.com>
Subject: Re: [PATCH v3 04/34] lsm: introduce looping macros for the
 initialization code
To: John Johansen <john.johansen@canonical.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 12:37=E2=80=AFPM John Johansen
<john.johansen@canonical.com> wrote:
>
> On 8/14/25 15:50, Paul Moore wrote:
> > There are three common for loop patterns in the LSM initialization code
> > to loop through the ordered LSM list and the registered "early" LSMs.
> > This patch implements these loop patterns as macros to help simplify th=
e
> > code and reduce the change for errors.
>                        ^
>                        chance

Good catch, thanks.

> otherwise looks good, and you can add my
>
> Reviewed-by: John Johansen <john.johansen@canonical.com>

--
paul-moore.com

