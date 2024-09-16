Return-Path: <linux-integrity+bounces-3610-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BECA8979AD9
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Sep 2024 07:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46031C226CE
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Sep 2024 05:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C3B18637;
	Mon, 16 Sep 2024 05:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rv2VLqjn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635596FDC;
	Mon, 16 Sep 2024 05:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726465999; cv=none; b=AfjL1gL0AzHU9Lw0Q5SfNcE4AL57dsLOm79tsYbT7kICa4vCOtuI+C1ibKEiaFe+1OQscGr4j8YZqUqJ3DxqpYdWXeetMsL+GBM7mrpxjO905zARFAmcCQhdFXmOcUm5oOBxKixSTUI53k3y4RYMITXghgCjCvhu9dOdz9tLJuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726465999; c=relaxed/simple;
	bh=JR0wXPZj26rnqI6FeapVdw6vICH82DBIxPs630K33j4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tjtx1YOahbvfy6lYwfVQ0A88e1YhbC0VEplUvlSbYCFDIK6IQvbKuGR19rwJlHeI1stXJRE4yUGyPSUuxa9Dw79vpDJCzU6Nl/NIv67GuPSW1GCXeJ2vrJxCzL2C5TrESg3T5gxaAaDEzkwLGgk4VnZdUMP2fuZNZTE1r+M/3Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rv2VLqjn; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53659c8d688so3194431e87.1;
        Sun, 15 Sep 2024 22:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726465995; x=1727070795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JR0wXPZj26rnqI6FeapVdw6vICH82DBIxPs630K33j4=;
        b=Rv2VLqjnF+H0q2QV9wMkvtBqyUQDjE1yfs+iGkYmJrDzUGfPwmeKoIkfQITRbuTHYW
         b7CqTl1kBSQQA0mcgzaDl9J7h5D1BoApt/J0KapHT6mFYCgzrm5KMWPhhf2rSzsV6Hz5
         GKokpMQV58IEh8kDg0tyTyoMUG3IV1I28reRtTqiCNW3O+8FfSu1BCRm/2UD0CgDmANH
         XKgZrt+WMbH7yejeCQzQGaeBL1T5pfLFRdxR6XT7FJNbLxKYDi8v455l7rf5o566KNxe
         TfYcWsMtzrV0rHp/m7oCiE3YFob4pA17hkuCp47Jvjvod9yiHynS4/7LBoferZLPXckl
         Mmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726465995; x=1727070795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JR0wXPZj26rnqI6FeapVdw6vICH82DBIxPs630K33j4=;
        b=hNDvaKZc99Pwqq/55rn124P3tQorsfUU3zCRafryVri5NdTSbrhIJFwucm1rkHRsb+
         Y4Nvf67k+g7JLwMQ7nJW3iO65dd5WMjVw1wCzzAMBAnTn/MITTxkxpUsr9HAlnIPQmeM
         DJbUE+sa9wdQiOPfVBklHDR9jDP/v3tAPCRU3LWE2z0q2OdCXBLCkEXW0g0sfQh1whXf
         AFjB/9it9pT+PN8UCLue9VZC3ObukCNLGobq9C1pOTHlo5nxmqZOXmTd3iixL02jqMmJ
         xuMJpEsjJ810iQWu2yfADXf1ub7cTcw0RoEUpyFuUp5KUdbpIWxPZCgCJlJtj4Oil9YH
         OsTA==
X-Forwarded-Encrypted: i=1; AJvYcCW+JQpzMKMJ9n/5OwjGreM0p7TGnz36bY9pCOW17K3TMfUS9M8+Vl/5kPl/d9587h7+EGcl+GHepeuvmbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFV8vwiT4MvgfgAyA/jDrBh6ViLpEeBZIjuU+kCtS6yyZ9Eyh+
	RZ/wxzJU9poN4QwBwvYDo9DKxd0INBrS6WylRGQCRcebsLMrCgDtozlhEDdtBj7haaL9euUtwSx
	NbNjqLsPFF74PU96BJHwrMDa5t8w=
X-Google-Smtp-Source: AGHT+IE+BzxQ65k++z8/tENLy0w5XhPZnMRxr4iXq1hiJSFy7wGKAiJbneT9HrFT/fMQNoRHMUdLpYruQKt5qurB/EU=
X-Received: by 2002:a05:6512:4002:b0:533:4191:fa4a with SMTP id
 2adb3069b0e04-5366b93364cmr6657243e87.15.1726465994998; Sun, 15 Sep 2024
 22:53:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915180448.2030115-1-jarkko@kernel.org> <CALSz7m0ehXM+dU3z0xYPLQkHbyfyMjoCOoMLdBgRcUu1pnT_ww@mail.gmail.com>
 <CALSz7m1WG7fZ9UuO0URgCZEDG7r_wB4Ev_4mOHJThH_d1Ed1nw@mail.gmail.com> <D47GBS5ZGNPC.3IRSGEBQGJURI@kernel.org>
In-Reply-To: <D47GBS5ZGNPC.3IRSGEBQGJURI@kernel.org>
From: Pengyu Ma <mapengyu@gmail.com>
Date: Mon, 16 Sep 2024 13:53:02 +0800
Message-ID: <CALSz7m1qd-7uLKbQ9Dz36GvzompQ7gg7Vfe2uj3YRj0jHONDPg@mail.gmail.com>
Subject: Re: [PATCH 0/4] tpm: lazy flush for the session null key
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, James.Bottomley@hansenpartnership.com, 
	roberto.sassu@huawei.com, Peter Huewe <peterhuewe@gmx.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 1:16=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Mon Sep 16, 2024 at 5:33 AM EEST, Pengyu Ma wrote:
> > After applied your patches, the boot time is ~15 seconds.
> > Less than 20 sec, but still much more than 7 sec when disabling HMAC.
>
> Great, and thank you for testing this. I did expect it to fully address
> the issue but it is on the direct path. It took me few days to get my
> testing environment right before moving forward [1], mainly to get
> bpftrace included, thus the delay.
>
> Do you mind if I add tested-by for the for this one?
>

Yes, please feel free to add it.
And thanks for the effort and details.

BR,
Pengyu.


> Before the patch set the in-kernel TPM sequences were along the lines
> of:
>
> 1. Load the null key.
> 2. Load the auth session.
> 3. Do stuff with overhead from encryption.
> 4. Save the session.
> 5. Save the null key.
>
> With the changes:
>
> 1. Load the session.
> 2. Do stuff with overhead from encryption.
> 3. Save the session.
>
> Each swapped session gets an increasing count. If the count grows over
> treshold measured by the difference of the count in the latest loaded
> session and the session currently being saved, then TPM throws out
> a context gap error. It has a limited resolution for this.
>
> As long as /dev/tpm0 is not opened by any process, there is only one
> session open (or at least fixed pre-determined number moving forward).
> This means that context gap error cannot occur, as the only session
> saved is the auth session.
>
> I'll implement a patch on top of this, which does exactly this: track
> the number of open /dev/tpm{rm0}. Only when the device is open, the
> auth session is flushed.
>
> With this change the sequence reduces to:
>
> 1. Do stuff with overhead from encryption.
>
> Since the results are promising (thanks to you), I create a new version
> of this patch set with this additional fix. There's no chance to reach
> the same exact boot-up time as without encryption but I think we might
> be able to reach a reasonable cost.
>
> [1] https://codeberg.org/jarkko/linux-tpmdd-test
>
> BR, Jarkko

