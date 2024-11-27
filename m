Return-Path: <linux-integrity+bounces-4219-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 686839DA14B
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Nov 2024 05:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DE06168806
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Nov 2024 04:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AB0282FE;
	Wed, 27 Nov 2024 04:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MJu6yPxR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A864228EB
	for <linux-integrity@vger.kernel.org>; Wed, 27 Nov 2024 04:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732680140; cv=none; b=psh0LaqoOWVkayClLEZ1bsrPIoSFuUeHNOv51TtBqCG/HNQzGNF/eLlsrej7QBqu37PztQRseHTpDuH+9WJYQ6OKrcSgZGgVyphQEgAnyR+8yxpQvYe9K36s7SY1wAt7D5XC4n9ojI5GdCkltj1iLNHkLMg3kav/OugnQFAANto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732680140; c=relaxed/simple;
	bh=rgGUtTi6cgHbXeEIBneesc4o26QfRW4kSE8z1VlqAaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PEl+WJBws6Z9OfnnATXGIDroO8f8XDGc24Afp3cnuHP5kSmhUQf2/8mV0p8GIfykiopEs3okvNWDQZh5ve/wtXkfpg7iOXEDFeTElTogvfTe6qmAdIZPc1Uy7Jh/yuN8ohm8vDXKDp1RJ4eENL2In8GtES2sNShA5SnnbOcWqQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MJu6yPxR; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e3884cd186aso6384192276.1
        for <linux-integrity@vger.kernel.org>; Tue, 26 Nov 2024 20:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1732680137; x=1733284937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYdPHxRKENTOkIj1dnE8bjE/PoWNE+0I9VP8yD2g53Q=;
        b=MJu6yPxR0bpmYq3MPhwFovVdnvbGor5GSl5VunSGA/TQ9H6oUmNCy3zKyuOdm3/uua
         4nt0op4cvi9S6y/9i9SPy6M0hfmfN/4dnmhcUiIH+xtcPQrwtX2xhwJxGw3VC0ArCkb5
         4eXN0C9+fG90aUgoZCOrKwCd1VexkFviOyhospxgnqEAxINSKDngtrqcPttS+HYR5IZA
         orSirMqUpzgeXGQVMTUWDfD4Pu1bBDyFV01Gr2OXcyWAFfGfVSQHPn077LRaGQOl60GW
         oagCpzIJSOy3ScIBM66K6DUmFFnZMwP4o0VSBvzLIzV+p51/VgXhlRg/w6LOaKk5Amq6
         IQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732680137; x=1733284937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYdPHxRKENTOkIj1dnE8bjE/PoWNE+0I9VP8yD2g53Q=;
        b=qgMjAmtViD478Y1t8mdRfB0JcOaDhtvXJQIM3tPmsM8FsIgs23KLjpSEpJ80nAt9si
         ZO3e4H8tPSrV5zwk/+kOHRFDV/lQ5ERN4w+Xcnv2DQlkT6lG+IxMpjP+Xz85/OpmOYoh
         2jMZUtHCwlz79TeyR2/kwCHK3VzSk94bIo1YQTkA0YFzLcKouotVojEwgionLvQWzsCt
         k1J+vDtYLnk8KUiRvP7+IZf7V7PKK5HS1ZSZTOaoRyr/PI3faPZ5kVZlEnKJLmaYFGbp
         5w08e5gpbCaOCab9B4B6cYuCIB+iLKbs0BugBjkW+KoIcIOrm2WmsGb88Q6WOWaQeS/m
         ZkJw==
X-Forwarded-Encrypted: i=1; AJvYcCVnWwELKr3kkS/uA584rdtvDwq7cQMoF1/5ehW+Er++slJ5inTy6LiH+Rn9wj/8R4AJWwEaUYPk+wbMKWRPFlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo7GAzUTjGd2q+Pd+yU+cfbfJk5QltpUCPAdpi05G9G4hAjAsJ
	nnUV9GFDBzq4bDHmG95aRHwSzdxmcri4f2kBEvs7ucxvxobJRViUo3pUbfaToAWrvQF/B2r6Sag
	E2ni/VtJymjgT4bEAg6ezjXTfgRCKatpdERum
X-Gm-Gg: ASbGncuPfPwzOPtmPL9OVWS5Zgj6RCI5Lhn0t5FF9bXpgu+JyDvEc8gnbdHNzwAGFGn
	cI2ru06r6BmDgGi71zHawXLDaGVCPxg==
X-Google-Smtp-Source: AGHT+IFIhoHV1KZILzwwjbRHgH3oq5xxKI/6tI2yJz7Higi7u+bkhBhq9AhbFSn85Rm7+o3h+w2rhHHyh73JVHZ2jOM=
X-Received: by 2002:a05:6902:114b:b0:e38:b868:cfea with SMTP id
 3f1490d57ef6-e395b891d60mr1535472276.16.1732680137568; Tue, 26 Nov 2024
 20:02:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ2a_DeUX9UdAYOo9OwG-yXSH1etKQZortPcyxfzG70K3N+g7g@mail.gmail.com>
 <77003d04-f3a4-46b1-9368-510b529fda44@schaufler-ca.com>
In-Reply-To: <77003d04-f3a4-46b1-9368-510b529fda44@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 26 Nov 2024 23:02:06 -0500
Message-ID: <CAHC9VhTmyHr1U97mE0YwueJ_-8p_sBK-CB6O8rWMUz1Gr70iKw@mail.gmail.com>
Subject: Re: [PATCH] IMA,LSM: Uncover hidden variable in ima_match_rules()
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, 
	"M: Roberto Sassu" <roberto.sassu@huawei.com>, "M: Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>, 
	"R: Eric Snowberg" <eric.snowberg@oracle.com>, LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 1:21=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> The variable name "prop" is inadvertently used twice in
> ima_match_rules(), resulting in incorrect use of the local
> variable when the function parameter should have been.
> Rename the local variable and correct the use if the parameter.

/if/of/

> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Suggested-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/integrity/ima/ima_policy.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Aside from the typo above (which can be fixed during the merge) this
looks good to me.  Based on the discussion in the previous revision it
looks like Roberto would prefer this go via the LSM tree, so I'm going
to merge this into lsm/stable-6.13 and send this up to Linus later
this week (or early next depending on how my holiday travels go);
additional testing is always welcome :)

I'm also going to swap Roberto's reviewed-by tag for his ack which he
gave on the previous revision as this is touching IMA code.

--=20
paul-moore.com

