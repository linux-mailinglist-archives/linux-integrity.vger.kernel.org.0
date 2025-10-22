Return-Path: <linux-integrity+bounces-7515-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 027F7BFE975
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Oct 2025 01:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C3511A07367
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Oct 2025 23:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF602FB61D;
	Wed, 22 Oct 2025 23:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Q8f6meju"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65F6289376
	for <linux-integrity@vger.kernel.org>; Wed, 22 Oct 2025 23:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761176072; cv=none; b=NtpLMTXdcEuMV3Bhc9C9hV1lh9N5+GOyqznFvHmi4tCjxexcx5O1AHNGT0wV+svOCYuI5vw5FAfepxVMn0P78wbReqGsjuIqr5LYADP0o2lLw/B6HpkK1QVIpt3HYJEB5ckKlCYuFN/MFN5ZXUniblOqOffiCSY3MScif8z+iHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761176072; c=relaxed/simple;
	bh=SMAOENLFLnEuNnFZ1B57t486wsXpH7mhGQuf802qEsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFEiHDAUJXj2Z0QD/jdLR3QiqiIq+WmGESoMyLnJETxPQM6RqYULqRJO1tLdx+dd5QtVGT8hmeyzB2pu2f7jNVS4ZY5qIscpinUCdkfGfablQGsqZQau4FTDK4ze6x9+v3PbLyjvKCzyM70XCwyKurIo766IV0N5ku/yo7Lj08A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Q8f6meju; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b62e7221351so104306a12.1
        for <linux-integrity@vger.kernel.org>; Wed, 22 Oct 2025 16:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761176070; x=1761780870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYTGG9Mb6OsLLfCv5H2JjYhedhDfFTXQmDBbuKdGPv0=;
        b=Q8f6mejuot8zc2yRERzbqti3HeoTvgR8KpPG8kLTncFU3Viwta3Hn/tO9VZMK8e9iR
         buFSjJ4JUX2wfiMzEE87djhoicf+/c77NXCGGkdV/+tUQe9Bl0T3el/UOk09o24c1N8u
         7yXrzN0d9BH/Yc0Qj9Ne/Tr+/9EBF0g3VGHtH62xw+8pOeRDjJNePuagH7m4QnSW6Cpz
         4+MevC/CeNcaDOikdBGoJSKU/cfefzlc6pQhKU5lcG0cE0InUTOpGsNXxyDIjxZxjJQ6
         Ku6kSaX3Imp6h+iG5LbI6N2Dq4ZPoIUQMTarGNKqDC+0OZL9Kr4bB7BvwxxEXC2TGJEy
         T0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761176070; x=1761780870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYTGG9Mb6OsLLfCv5H2JjYhedhDfFTXQmDBbuKdGPv0=;
        b=I0yKRUkaAJU2FsvkaAcEbsTKDPMzOLODA3xRrCfrpmQZSh/A+P4M65JP6RSgzArpp2
         2z8a7NzQ22xdhl4zxdPQ6PO3zkoPMJduRLUujPm6oYvuEYAGQuS90M84Tcm8eS9RToKG
         MLXujd32HFS07fMHmUwDYY8SnOzXlVONEnHAkzKZpRBJurtXmS1qr28A59dO9Lu4yyC/
         W/KfQbFIP5HsDk+eiUWBth0dzgC3vis4Kh9kM1m9e0IREhTTWaaLD3UNKzvKQDAPXrdg
         7pLyW47jFTo2IcIeI6M/dzHgKCmvrs5Q840a1ppCa/ug1JideeLxD/qu55lYkOzqDcnU
         lN3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtR4GTFyACBtWo/bvRQ2/8pCnV/ECRuRwZ4oIL7B0KorFsQLmDhaU0NPbV992U9mq/OnGlKwNVcN8iOAmSsIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzoxp2XIwRhCAiG4qhP4sw1uGAjZ1HTRSLF56y8Q8wSsGyEKcdz
	bYIZ3ZSTKq6qbwTAT+upgHmyPYo12GyQs25NNS2xFExXoyFZGTEITOxo/WqjIOi9bq2HcQIb8a1
	zJbq/L33ROSEMkT/3sl0xiXkW5IbHbVl9OYJMbVTR
X-Gm-Gg: ASbGncvsfZLXO8VlMqKv0AZesLwZtkI4ZffVsG0JqUDc4ytIfrS3/kYqmWlV5seGkIr
	pAvkTKtjT6hUR30sv4ujLo1OcpeT9zmNqPmZdA/9c2SBg6+RYF02dtCHMVWj8OLN8L7f//T/+xT
	5BpsIHGirUh8sCPiiFW83+aBvSo0tpj8pgqNq9ilzzoaUeHGfhFfC15g29+EA4V6Lh2yyZaymQy
	kBFCUH5hMdV0ShVbjK3C/CXosaLatDbCw69RzlvN9VSJZmYBsi6tfoYzwZLLVHQkbau478=
X-Google-Smtp-Source: AGHT+IEpdFxeI3Tg3wPnuZQbcK3uSFH1zDfkYZ+d44nuiGe8slDFYbF1+f2bbbTHcXljNnVPc4f29mGU4SVhJ+4wxrk=
X-Received: by 2002:a05:6a21:328a:b0:334:a523:abe7 with SMTP id
 adf61e73a8af0-334a8594429mr30867764637.27.1761176070015; Wed, 22 Oct 2025
 16:34:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017202456.484010-36-paul@paul-moore.com>
In-Reply-To: <20251017202456.484010-36-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 22 Oct 2025 19:34:18 -0400
X-Gm-Features: AS18NWB813Tg6fqdUDfKRNqfMg-iS1a5dI4NsDx5kG5Rq3ywJYs9FofpNeOyw_c
Message-ID: <CAHC9VhTNBs4+n6m83hbwJk4APALsikmwcHoyX67GWHLPZPSQBQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/34] Rework the LSM initialization
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

On Fri, Oct 17, 2025 at 4:28=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> This is the fifth, and likely final, revision of the LSM rework patchset.
> The number of changes in this revision are very minor and barring any
> surprises I expect to merge this into the lsm/dev branch next week; I'll
> send a notice when I do.

Here is that notice.  This patchset is now merged into lsm/dev and
should be in the next linux-next release; if anyone notices anything
odd, please let me know.

As a FYI, I also moved the base of lsm/dev up to v6.18-rc2 to grab the
fix below (it was affecting testing).

https://lore.kernel.org/netdev/20251015052715.4140493-1-edumazet@google.com=
/

--=20
paul-moore.com

