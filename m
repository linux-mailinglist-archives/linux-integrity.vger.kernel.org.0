Return-Path: <linux-integrity+bounces-7027-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EBEB481C1
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Sep 2025 03:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9675D7A0389
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Sep 2025 01:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDAC1922FD;
	Mon,  8 Sep 2025 01:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="M03Jwoh6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6E1185E4A
	for <linux-integrity@vger.kernel.org>; Mon,  8 Sep 2025 01:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757293713; cv=none; b=ORmbAGi2ZWMN09xB40ir/ef71okz9l/0nXr47rSBMkze/vICiL4bWC4ZcFHftPtnqFCJpR1YFxz9okwPrXfgGuPthrgq+HxSt/5VPA+B1/N+Qx4SFwLeGNCBHAXtF7bNuoVziQtEi36rgIXTDcfLm2oz1zq6S1YVRhlzerp0c3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757293713; c=relaxed/simple;
	bh=dcTHWeC8QncDPL2EeofbWQ4zwx90vxy57HeJd1rlNc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gm+xEQ+har8WagR5oln+QTg4yQQwKjcHEr7iuugvZOopvw6EfxgTSzIBC/kp/dgNXtmBsXM5tKguZVoR3BSqWKpb1OIrGPAi+mb4F1yHpaUo2QHT16/L6+07v/ltmiSVDel0TuD8r+QQSN85sQDphFPqLCpzQn3JWZj/wa6jAwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=M03Jwoh6; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24eb713b2dfso18074925ad.0
        for <linux-integrity@vger.kernel.org>; Sun, 07 Sep 2025 18:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757293711; x=1757898511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCby98fuHykeF9/gIJ4wJ1zBkioxK2Pnyqoe8ZEv4HM=;
        b=M03Jwoh6NfEc12jdGDdv0x80hRkJj/wAzmveuZBSqXf7fBoIjMSrtYttOLP5pqRw23
         CkJEQwxwPIZKr+H2KDMnewAItDIt+UU/YFRvJESQPtY6rt+pyAVvCFE9aGy3fpjK/CEs
         1UPHW3JKrbmn6IWmfLp/nwpd8fUgvZIlLBXetLMVEx2N9WlTCoq7dsNFMBgf9NHaoks6
         c9CK6C1DzV0V+30YiEINEZo8h/B5Lno6v7vmRlJ+6vFxJB9puWYtrFyjKKqbaTxAS6yd
         ciVRgVuLZsIKeXiGiEVsoKkL15d5ZKNvTTkh6sdeZxTA96ytjPVZVzcuTmQoj/99g0px
         PgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757293711; x=1757898511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCby98fuHykeF9/gIJ4wJ1zBkioxK2Pnyqoe8ZEv4HM=;
        b=DBnaY4GBdF6+0lVi+AfM5iql7EvPrYc+L/qJULo+CWJ66yz4w2i26BuSU0QdJ6vbGL
         IcD0/d+JoqBpdbCfAmffuZqa/UIoqM29EXPFPn6vWRzcZ/2uF9YSEm/7Je7Kgd1zBFb7
         rRrwqNcTjB8gwaGtUYko9qkpHDswU75EcPyzbyHqStGWo81uyjdCVfodbAGg6MuSIper
         1AmO/elI7qEo0QoN2W5u2XmYLkcfm6Sy6O9AFNPpisRb4bdRXffvCcANmE5vzkzy1tqx
         eoBWWBj961IqsKo4zrBlO+pmNm43W3gOlN7Eax4oJw7Lj9GJ7OqE3xAfEsSOomXDJKe0
         1igQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbnmCbiv9yn07/m/S20hS2Y3EJZFA6in/wO0bVtBafACc8h7/cSrIjXBMEqTyYLYjN1Wqynow0B0F9gt9b/oY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2OKyitFsaf2Uuy0ztVvcaoRc1J10hhgmKtDvWc59aESpdo9fb
	AKci68moR1oyY7S8kUEx44FiImKKamzU2zn6JEcAX2jU9wuHCEV8AXNEm64I7uDzgx19QtX7T1p
	6iT5s4of8UjWEiSdJrJ4dx8GschP0ASRzQadMUWRQ
X-Gm-Gg: ASbGncvAojzHGHDL6QXwVT5D6kvvU/NglS53PjqZ+vNO094tc/Cy7GEYkbo/3/l8MUR
	3TDSzWWMRE2z/v4MnZjzYXVL1HnciIjGnD8JWveNOJEp6kVz7UwyQwL86pAQUV/E7DaiNZsDuR2
	7czwTvKD1ED8ZLWnHeDnY3c/wsmYOAT2u9dS9aXtTrZfB0s238sYjqeBg7TNswbAyX8f3+qk1dr
	5rMpWgWrn9TJRQ2ABR5FtOxFBYz
X-Google-Smtp-Source: AGHT+IHOMpUmUGvARznOaHD6cjYr8eVlW646Pw9KSgkliNtnjdUIH/ScSsfYujUC7X5+4fGLUufMT9jln/j7XHfC6WI=
X-Received: by 2002:a17:902:e802:b0:24b:1625:5fa5 with SMTP id
 d9443c01a7336-2516d33edd9mr102319205ad.11.1757293711530; Sun, 07 Sep 2025
 18:08:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9f35539de7188c6b853c55b76958a286131f5928.camel@huaweicloud.com>
 <20250902125457.2689519-1-roberto.sassu@huaweicloud.com> <82f22f97486622408bec772a9b025e301c8fa2f4.camel@linux.ibm.com>
In-Reply-To: <82f22f97486622408bec772a9b025e301c8fa2f4.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 7 Sep 2025 21:08:19 -0400
X-Gm-Features: Ac12FXwoV7fb06gH8Z5E4U6UlqLB13nK6Eu7J_q-p88Bs4R0h8-YzVl3W09F4Js
Message-ID: <CAHC9VhTGAcMTXHReinybpLzer7seCN+NUTHcFte+aU2oRNtNNg@mail.gmail.com>
Subject: Re: [PATCH] ima,evm: move initcalls to the LSM framework
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, roberto.sassu@huawei.com, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, john.johansen@canonical.com, wufan@kernel.org, 
	mic@digikod.net, kees@kernel.org, mortonm@chromium.org, 
	casey@schaufler-ca.com, penguin-kernel@i-love.sakura.ne.jp, 
	nicolas.bouchinet@oss.cyber.gouv.fr, xiujianfeng@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 7, 2025 at 5:18=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wro=
te:
>
> On Tue, 2025-09-02 at 14:54 +0200, Roberto Sassu wrote:
> > From: Paul Moore <paul@paul-moore.com>
>
> Remove above ...
>
> >
> > This patch converts IMA and EVM to use the LSM frameworks's initcall
> > mechanism. It moved the integrity_fs_init() call to ima_fs_init() and
> > evm_init_secfs(), to work around the fact that there is no "integrity" =
LSM,
> > and introduced integrity_fs_fini() to remove the integrity directory, i=
f
> > empty. Both integrity_fs_init() and integrity_fs_fini() support the
> > scenario of being called by both the IMA and EVM LSMs.
> >
> > It is worth mentioning that this patch does not touch any of the
> > "platform certs" code that lives in the security/integrity/platform_cer=
ts
> > directory as the IMA/EVM maintainers have assured me that this code is
> > unrelated to IMA/EVM, despite the location, and will be moved to a more
>
> This wording "unrelated to IMA/EVM" was taken from Paul's patch descripti=
on, but
> needs to be tweaked.  Please refer to my comment on Paul's patch.

Minim, Roberto, would both of you be okay if I changed the second
paragraph to read as follows:

"This patch does not touch any of the platform certificate code that
lives under the security/integrity/platform_certs directory as the
IMA/EVM developers would prefer to address that in a future patchset."

> > relevant subsystem in the future.
> >
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>, but not yet tested.

--=20
paul-moore.com

