Return-Path: <linux-integrity+bounces-4208-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8639D9AE8
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Nov 2024 16:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB479165FF3
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Nov 2024 15:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43FD1D9320;
	Tue, 26 Nov 2024 15:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Cp94FTsi"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5151D90C5
	for <linux-integrity@vger.kernel.org>; Tue, 26 Nov 2024 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732636646; cv=none; b=feQFcLoJF6bkZKlkGZEkrmj2bIDF0N5tfJ5dJR8axeSFTnRDizf91a8qDfZqiJ+XonDtxxZwthholhQgarjcLJ20kvftf57A8RhrKPes/5k3qoukwth3RBGOBzXtn44gtig0ZeIJDQtXyugyKnLJhz8Hr2r4IL98j89UgdTN+BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732636646; c=relaxed/simple;
	bh=M097b3AoLZGGrSY88ozNfK3DDyUr21f4JQcRdhc8+mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OgOxxKAIBN9mfByTVEEJf4MF/M9jq7kqxzLksMQfEU4z4yBOQhvwcqPixLBTVVN2voTVpopQ6i3yjqPXvI5O729rglJ9leIxDckWTKLVABYTOm9NfgPaXZD7lJTesZ4IocmK4UBXvgBG7vZdtI1tKnqVrjojlTTVXv71pJ2zbm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Cp94FTsi; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6eeca160f14so62552797b3.2
        for <linux-integrity@vger.kernel.org>; Tue, 26 Nov 2024 07:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1732636644; x=1733241444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/E2x/9m0Jw9OhM2T6isfKESQbjzMtZ3n4WMxBZ5NYAg=;
        b=Cp94FTsim9ffSsyWFkgl4I2LIo/KS58tDE8pg0Rt1OvNfh24lznrGicfforS3MeSVD
         u3TfTLLYeuCQDnRy5KcZq+tnbfaPRhVe6hVQ7kazvqe4SAYfYjjLt16dm9hDYqorWz+X
         zkQa2zdtun4LptE2Ie5TKcSqw7qZhfTuTW2VhsQuTAQ9qfgIVdlVAXQ4hmAL3O1zJ+2C
         yV2RSFAV5voKxGC9TISsHPoeJIeIswPBDFJoyi48upIn1z4JYeYNF2KRRWlOTmzYzKWu
         McANHwqdt4vxMgqM5nhmSTTs0inDA5ryQiDtP4v+FEvdWGfXUgwLb37Mhrnqs7+VBqP2
         6LMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732636644; x=1733241444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/E2x/9m0Jw9OhM2T6isfKESQbjzMtZ3n4WMxBZ5NYAg=;
        b=Vr/i22BtN9CjMpfLCBhPrZ+iEh5GeqtwXh/EUNvlrO96Vxpq00nO+TrikCTnOrS0LC
         vie4EqMHR6IkQhmjodouq+xOhduJW97ijTGSJUEX9iOvTz8pndFjDAXuJJEkvG+QHncY
         MoRZ4O4R6IRka44vDPdumuL7yKEMu7QgXrBWYK2jxWCoFg5tPxoAyUaXpESai5C8GpUJ
         FuPhkr2ZXCQYopyDBXuNYQRowmCY7kggdozMlD8EPHazXZBhHl5rMuHFs945EUfozluj
         zoffxWCSYMMHo/CrpG8N5RcdrdGxLkbbW8KRAXH6utS2XjjyGBtSO9CZOPZktZbk71/q
         vjgw==
X-Forwarded-Encrypted: i=1; AJvYcCV6lFtMyDmLP+ZrDlla5IwBaVQWxObRsEj9uCG7QBo52gbazhWZYA8UbNTdv6sCOX8VI61ByJO8TpTlEBisgHw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk1miinFqMNTwlCia6gpOyzAE9K5+GhLQ/qmk6l2Ai2oB/DhiI
	dIPMMNT89c5nDabIA6eiXxvk7SLCi+Wckc9xUIngI04fdZOJ/VhqMToODEx5QjVh4SpI9RHbGON
	d8F3K+DGtOUZtTOxEt3uooOdZRNCReT+mES/f
X-Gm-Gg: ASbGncs/5hjGfawKUaUY73Z0XhOOuOt+9yImlY+RdqxdKLujZHU2QbRZatEGEXvKDdu
	9NxJNdIYxoysdKSGXjV5MSBWtNDPAzw==
X-Google-Smtp-Source: AGHT+IF1Clm0YywkLQZI0a+CkqXFyBhHuwmyMfxWR8/y9KxVZw2fTN6BtGj26+4Z3na+aij2uacRKZKketxnwJax8Uc=
X-Received: by 2002:a05:690c:6301:b0:6e3:153a:ff62 with SMTP id
 00721157ae682-6eee08bc182mr175416367b3.23.1732636644270; Tue, 26 Nov 2024
 07:57:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ2a_DeUX9UdAYOo9OwG-yXSH1etKQZortPcyxfzG70K3N+g7g@mail.gmail.com>
 <92e5fd64-8c75-4e82-981a-846364fc7a38@schaufler-ca.com> <91a227f3b57374a8aece5480f285c433d3888572.camel@huaweicloud.com>
In-Reply-To: <91a227f3b57374a8aece5480f285c433d3888572.camel@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 26 Nov 2024 10:57:13 -0500
Message-ID: <CAHC9VhS7KRcpA7cHcwpKknYsC7iZiBjZGVz1xznC=d=uDYu7EQ@mail.gmail.com>
Subject: Re: ima: property parameter unused in ima_match_rules()
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Mimi Zohar <zohar@linux.ibm.com>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	linux-integrity@vger.kernel.org, 
	"M: Roberto Sassu" <roberto.sassu@huawei.com>, "M: Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>, 
	"R: Eric Snowberg" <eric.snowberg@oracle.com>, LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 2:50=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Mon, 2024-11-25 at 10:23 -0800, Casey Schaufler wrote:
> > On 11/25/2024 3:38 AM, Christian G=C3=B6ttsche wrote:
> > > Hi,
> > >
> > > I noticed that the `prop` parameter of `ima_match_rules()` is
> > > currently unused (due to shadowing).
> > > Is that by design or a mishap of the recent rework?
> > >
> > > Related commits:
> > >
> > > 37f670a ("lsm: use lsm_prop in security_current_getsecid")
> > > 870b7fd ("lsm: use lsm_prop in security_audit_rule_match")
> > > 07f9d2c ("lsm: use lsm_prop in security_inode_getsecid")
> >
> > The shadowing was inadvertent. The use of lsm_prop data is
> > corrected by this patch.
>
> Thanks Casey. Yes, this is what I had in mind.

Looks good to me too.  Casey can you resend the patch with the proper
sign-off, commit description, etc.?  Roberto, can we convert your
comment above into an ACK?

Lastly, Mimi and Roberto, would you like me to take this fix up to
Linus via the LSM tree, or would you prefer to take it via IMA?
Either way is fine with me as long as we get it fixed :)

--=20
paul-moore.com

