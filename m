Return-Path: <linux-integrity+bounces-6742-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 557A0B1440C
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Jul 2025 23:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022E41888918
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Jul 2025 21:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5691A23AC;
	Mon, 28 Jul 2025 21:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Nh+KwAhg"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227121F7580
	for <linux-integrity@vger.kernel.org>; Mon, 28 Jul 2025 21:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753739380; cv=none; b=Cajnf+WC/C0MX8qrV93STDOv/gkbLTmxHq6yEE5/tzxiBPtfsFpbTDuG+ltu76VVLbY6WF44Oi2WKzn8Y/YRrPAIr0pNSx7KJei8SDL9LAovDs3KsVCh23JORk+8eLArmmC9aVa9Qe2LxUIt67ikjQGVPHxhSOnWv6W9UMZpORQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753739380; c=relaxed/simple;
	bh=tTCJWGUp62X7xORqgRT8/m9obaHcnwzTRIbKZR7RuOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PVzP40bSQAhAxK8NwWBFaw6ez74QP8DBdr6MGwwI4o4X7iOBIa6V7oY1RQLXu2rKUvuaqeESkw/syvvC//k9RqIOJ6TtG+SmlayMa2bttM1nm2UzS6HDeVEwnr0KSvHbfdiKq9HvDSrSosbdcFH93dIxrgNFXfW18ppiP8RBuV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Nh+KwAhg; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e8e0aa2e3f9so1802562276.1
        for <linux-integrity@vger.kernel.org>; Mon, 28 Jul 2025 14:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753739376; x=1754344176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=poaEelBg7a7OcoaRwgyEnvu3ww/B0f0meFimZvf+Ksc=;
        b=Nh+KwAhg220CV5ri5tPFw7EWzAPu7j3V3OA15Ypm2cfmtWCJMJZwB4uQP5llEDBiUj
         0WMw5a1JT6p1AKSg0PPTclQVO8PXh/xLaBHvROZ+R8XWT5IDqAMozM23xfekNFXtrv7Y
         yMwNWnGjUlXJI7RK/ZrbojjGkDLpnwj/Wems67wS9YR2OQERVE9VHF5x/vBvrsw1uP22
         jjuBdb3nJLh511EJvJHtLnUH4TAM+HfZv+5C74Z3DMtrDdVR7se/NalkW0GD6u1Vx4M3
         2Q64lV9GbNNNuui/PlCznV3zYeXxzIks9ASQGBVG/0r3JtxkTCIoWz+xRnt6bdDuR7fL
         IG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753739376; x=1754344176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=poaEelBg7a7OcoaRwgyEnvu3ww/B0f0meFimZvf+Ksc=;
        b=s62HWSEZeN9YC3KflCzK/I+kWa2mB98mx1XCfSdfkPNPYeyyGaSQhBH0aOy36ZaflK
         xCDL7cuwiqG9Wfzmkc7YE79yxmp4rWh0mGl08oMTEhV9ssQmWAm3olLgZRjNrx0P7OIX
         /rhhvLszNFxZ3MNyf2ScEaGQTppZaCQMuDMlwaEzG4G9wgLIGtWKRtZH1dR1NGgOOqe4
         Mh64nB97PYgXsAYJOA4Ojm09jQZsEp/TYXvh6HAJ3Zc6c+wJj7O+yOWUFprRXAgnoVAs
         ix76MxfJXGm4arfjXep4vpXQMBE4cbdnKhcOqMdhKWA0nXb4gAWATWj5TPF/y6ESJQZj
         Ig9A==
X-Forwarded-Encrypted: i=1; AJvYcCUxlsO6Prw4ClT6S0ZBLmk/BBzSqrxh9Oahc1Zys7wLdW9f3jcLszx+gMwBBgEs6htaa/jFN1zeijfNJ0fobKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmDXmTOBrU5cV5XBfv9OOt1+QLxzqeY+mtInJt4egRLd7lu0i8
	ED1sgMh+LruHzdN9qnB4DaHjQyKp0GCfw1s4jOUZu3FQniTKCNK9eT84AwiomjZ1qgHIsOfrUpO
	HXxGA2h0wAaQPPiL2KtMS4PexfwEULrQ7QjLTEDOgOinDr8GfRzk=
X-Gm-Gg: ASbGncvvUK8G9pi2S+/uCiT5MVwUT8M8BSVHvopn1M4ndaEa+Cu/3WBoHXgxCdKivAU
	0/+WaFL8NGFr81tER7M8NnIs002uajggxRKHutah+gXPKiF8dG1E39qICRTjCwpgP3PtP8toRFp
	r1LdFof1jTap8sOLejdjVYSjTUDnQ5ii2L5xP4DFXvbD65oFpcuoS4Zwg1NvbKkn3CA7by7AflW
	kvAGiUJm79p3id+Cw==
X-Google-Smtp-Source: AGHT+IGDWEdUVk8nOAd3eyXAgRoqbzWehDC/nmyeD5iRJSvY5Vw/y940r4iuZWMM9Zl9+esWYILkX9fMDQfg5o7B9Hc=
X-Received: by 2002:a05:6902:1501:b0:e8e:25db:be33 with SMTP id
 3f1490d57ef6-e8e25dbc361mr1013358276.28.1753739375979; Mon, 28 Jul 2025
 14:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721232142.77224-36-paul@paul-moore.com> <20250721232142.77224-66-paul@paul-moore.com>
 <3101077d-a5e2-d08b-03c2-2ed064a35b54@huaweicloud.com> <CAHC9VhR_24Zv7u0Btz8pSk420Totnx2uRyVdoHU1tXevWKw5mA@mail.gmail.com>
 <68025cd0-e55a-066e-954e-a398feedc34b@huawei.com>
In-Reply-To: <68025cd0-e55a-066e-954e-a398feedc34b@huawei.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 28 Jul 2025 17:49:25 -0400
X-Gm-Features: Ac12FXyHnpkhjuUV-tiMUv0zwfhXi7dvEqfqeEj1riNPGNByZhk8N5Ld8lteEnw
Message-ID: <CAHC9VhSp0cfSf1aeuWU3ZGt45v-vyoR9L2LtAMLpE+yB39ThPw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 30/34] lockdown: move initcalls to the LSM framework
To: xiujianfeng <xiujianfeng@huawei.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26, 2025 at 5:38=E2=80=AFAM xiujianfeng <xiujianfeng@huawei.com=
> wrote:
> On 2025/7/26 0:51, Paul Moore wrote:
> > On Fri, Jul 25, 2025 at 4:12=E2=80=AFAM Xiu Jianfeng
> > <xiujianfeng@huaweicloud.com> wrote:
> >> On 2025/7/22 7:21, Paul Moore wrote:
> >>> Reviewed-by: Kees Cook <kees@kernel.org>
> >>> Signed-off-by: Paul Moore <paul@paul-moore.com>
> >>
> >> Reviewed-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> >
> > Thank you for reviewing this patch.  As you are a Lockdown maintainer,
> > can I change your reviewed-by into an acked-by tag?
>
> Yes, absolutely! Thanks for checking!

Done, thanks!

--=20
paul-moore.com

