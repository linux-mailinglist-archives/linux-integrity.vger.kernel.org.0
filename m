Return-Path: <linux-integrity+bounces-7035-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3CEB49B71
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Sep 2025 23:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66F95188A816
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Sep 2025 21:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC2D2DCF65;
	Mon,  8 Sep 2025 21:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XVg/a8I2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258D92D59FA
	for <linux-integrity@vger.kernel.org>; Mon,  8 Sep 2025 21:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757365493; cv=none; b=ay9bpd1jUMXBMZxA5WHJkWl2EpcsBhxfWWuYJOR4bdAyBhyVaLsowYVGCHZQKwFOjddIRnmD+6I3dbG7vbYYCv6F6KeuArlhppzTkjZIgbCQo1sK8gEvhx4Dli/WoMuWwcBGtpnny9nLsbYk7JIXO8HBYCL/3yvRYAFpob45b7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757365493; c=relaxed/simple;
	bh=a4lFCFQ4PtfVYWKgEt//qlAxL3emGlM9rC/dmhCosbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eSJayBeKKT0F1QwfrnFU5OwkjPnoXxwrx2wpUSr/Wwljj30oOi5QUD9REEvSPvcV6MLsNP7cC6jTzTKO8cDO2ReT+p7pDpCCpGxJtw2y4YWvg80KarSZ4W7VU6y067gpRMnqkNLTSH5XW1kCt7q3/XoKPeGpREajNEcl+HAUnqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XVg/a8I2; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77238cb3cbbso5127341b3a.0
        for <linux-integrity@vger.kernel.org>; Mon, 08 Sep 2025 14:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757365491; x=1757970291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWxRVwHPNOe+2+uiVd3wk2fsjrxz2AYil0l5iSqXIwk=;
        b=XVg/a8I2pxab29Y6sxQCIFKa1ozzh69n6fMdHbmiAUAYzGW14C79Q2sF9GRcgofRxP
         la5aRKl8CcZtIzYUW6YBHWaxaZzXvH9iiPlXV/Q8hvToUOf9+2nXcvIrtb57E19uVmEF
         TtSxcEtXMmVjVWHzf96hNNkbC4Bifc3teEXiIm+znrMrMmrqSZ5/HkC1GYjqwW7RhtsK
         qr4P+ys44PdiHROyV8/x26zu77ip/jV1Gvpe2WgPjzBQ07DrM1ErPUQgwRxbbivog8mc
         YFqa8JsApCNbqOGqQSpFki+MlClrQAMGZ5Bldvi0NZycJXaxEZYzdm21J5y5Q9Js+txk
         jvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757365491; x=1757970291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWxRVwHPNOe+2+uiVd3wk2fsjrxz2AYil0l5iSqXIwk=;
        b=DL9J3m1ROCei4h+CPoXUSLeo1svs43+/RgybPjqTPxDPYj2TfXPz9C9Ifj2l9P42JC
         0abysd8MX7QzL4Gt/ThBpLmjoFYV39iVsU8pmfHpiTsJboGlTWrKtAnwp27B+5NhmHCE
         M4t7Ad0KXUURHcoNXsMgaXgLwNrTBAA6qu/CH518qoQ3UZJRc8f4+9tHAbXcHYqEjp36
         LCTUmNv2pt4Q8Dgf7UFHOTFKX4C+horVcWLzJNzjbpvCBLeFfN290D/oRoq/EuTKOqt2
         8l5ZVBDexb19ln6Vp8n42lAeA6qTIZ3GeV/rNufVgmo6M1rC/1eg3AJ6aNS/85PE1wN7
         RcFA==
X-Forwarded-Encrypted: i=1; AJvYcCXaZ//6omKIuFcc9ii1Lj0nz71q0iPcvDfHo0JX3FiSw/WekvsfQdkUEdoUz/MPWkMQ5nZB0ZIJ0Mt0ncth6tA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGoVXGShw/Ylop5ctzIqivtzv3z7B90o2euFmyZzTZiCNUNE34
	k5Z+d7Gp2xXldn6ho6I3aAxtkwM/bLRtnXUxtXOGYZmd6dJmKP707eo6ALQ7K7B68Jd86DVGSvv
	V6N9f/TrjbButlxLuoydrdQ7EmzGHtOw3I3CucShJ
X-Gm-Gg: ASbGncvoiR3Pm6Lb7Gc+WDUkQpQFODBe8OnPcpCVCTQOjVyh9ASOBWoI1hNMM4wQUPV
	GyHwr1XY42hKDQDJzM214UOzhf6etRdO47NTNZQf7bCzpjdVOlSG1wC9AJUl27WhwxjtZg1BjCS
	LxgoAqi7dOAdDLwMOX6A7RCrPJx9WPwcFu/GGyRu751rNC5M5hBgO3iRN8Ehv5QDD2LM1DFerkH
	ahCyAOMEDyAUfyZUQ==
X-Google-Smtp-Source: AGHT+IE79+FIT2lX4STv+Qj4ZYvAyBp3s+l+jcg0XssqWBwViTVAGpnw+Z5FOAU+MwB1yvwYkfcgw1a6NpkNuJLIgkA=
X-Received: by 2002:a05:6a20:9186:b0:247:b1d9:77c with SMTP id
 adf61e73a8af0-2533e5731cfmr13792340637.3.1757365491255; Mon, 08 Sep 2025
 14:04:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9f35539de7188c6b853c55b76958a286131f5928.camel@huaweicloud.com>
 <20250902125457.2689519-1-roberto.sassu@huaweicloud.com> <82f22f97486622408bec772a9b025e301c8fa2f4.camel@linux.ibm.com>
 <CAHC9VhTGAcMTXHReinybpLzer7seCN+NUTHcFte+aU2oRNtNNg@mail.gmail.com> <0cccd05c0005d3b9e85ab92e35363cc69ea6a3f2.camel@linux.ibm.com>
In-Reply-To: <0cccd05c0005d3b9e85ab92e35363cc69ea6a3f2.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 8 Sep 2025 17:04:39 -0400
X-Gm-Features: Ac12FXwlIo3NiwSuDYn-f8XtCjycRvjRK9k0DwZCt8BVbcg1kTR_F8_45fswT8k
Message-ID: <CAHC9VhRWt54V3nvRDpN_=gb5Fc68KznwDd7xhNmyGJw5+TQ5Dw@mail.gmail.com>
Subject: Re: [PATCH] ima,evm: move initcalls to the LSM framework
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, roberto.sassu@huawei.com
Cc: Mimi Zohar <zohar@linux.ibm.com>, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	john.johansen@canonical.com, wufan@kernel.org, mic@digikod.net, 
	kees@kernel.org, mortonm@chromium.org, casey@schaufler-ca.com, 
	penguin-kernel@i-love.sakura.ne.jp, nicolas.bouchinet@oss.cyber.gouv.fr, 
	xiujianfeng@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 7, 2025 at 10:46=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Sun, 2025-09-07 at 21:08 -0400, Paul Moore wrote:
> > On Sun, Sep 7, 2025 at 5:18=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com>=
 wrote:
> > > On Tue, 2025-09-02 at 14:54 +0200, Roberto Sassu wrote:
> > > > From: Paul Moore <paul@paul-moore.com>
> > >
> > > Remove above ...
> > >
> > > >
> > > > This patch converts IMA and EVM to use the LSM frameworks's initcal=
l
> > > > mechanism. It moved the integrity_fs_init() call to ima_fs_init() a=
nd
> > > > evm_init_secfs(), to work around the fact that there is no "integri=
ty" LSM,
> > > > and introduced integrity_fs_fini() to remove the integrity director=
y, if
> > > > empty. Both integrity_fs_init() and integrity_fs_fini() support the
> > > > scenario of being called by both the IMA and EVM LSMs.
> > > >
> > > > It is worth mentioning that this patch does not touch any of the
> > > > "platform certs" code that lives in the security/integrity/platform=
_certs
> > > > directory as the IMA/EVM maintainers have assured me that this code=
 is
> > > > unrelated to IMA/EVM, despite the location, and will be moved to a =
more
> > >
> > > This wording "unrelated to IMA/EVM" was taken from Paul's patch descr=
iption, but
> > > needs to be tweaked.  Please refer to my comment on Paul's patch.
> >
> > Minim, Roberto, would both of you be okay if I changed the second
> > paragraph to read as follows:
> >
> > "This patch does not touch any of the platform certificate code that
> > lives under the security/integrity/platform_certs directory as the
> > IMA/EVM developers would prefer to address that in a future patchset."
>
> That's fine.

Roberto, is it okay if I update your patch with the text above and use
it to replace my IMA/EVM patch in the LSM init patchset?  I'll retain
your From/Sign-off of course.

--=20
paul-moore.com

