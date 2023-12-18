Return-Path: <linux-integrity+bounces-530-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9E4817B1C
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Dec 2023 20:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF5A1B21CFB
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Dec 2023 19:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76B149899;
	Mon, 18 Dec 2023 19:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ee1sM63f"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C6F5D74B
	for <linux-integrity@vger.kernel.org>; Mon, 18 Dec 2023 19:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-552eaf800abso2474a12.0
        for <linux-integrity@vger.kernel.org>; Mon, 18 Dec 2023 11:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702928357; x=1703533157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5umlgnbsnFZiZVJ0cVpQu5AC72Lnsh+rnvB7uAFTfiY=;
        b=ee1sM63fzLs6LTmOWGeAK94NWTKA43uncd97atBiZi6BSwmGCaOHLyfbzdrKypmsBv
         GBn79kLjb2222f+WZ06uhCzu5ffX8lHA6gCPTB7/iXdo9AD6ds8aOalWzz7TMxGAE2rZ
         fPHK9fEdfVA0HRfV2jDstrTzevsTdEZkc392kcn4siPR+bwu88DjHkYRRj4pP7ocpM3b
         RrlKdd7bbzO5tRqZDKL7R+Jn1zCTpo4xlDH/MoWmIx4MSmDK5Lwgz7h3CpiqlxKpxHDp
         KwNkOAwyC95JSBXZrW/eGOU9IIhWVT4l6UVqbD/NxwSvtha2mRb+pKDhrxooOlGy2WZP
         dg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702928357; x=1703533157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5umlgnbsnFZiZVJ0cVpQu5AC72Lnsh+rnvB7uAFTfiY=;
        b=iXR/nF962Jeo5R5IarxM4FwTjgc1uccoR+K/FquawPEDWxztBYumR7zBIUs+mTcjme
         3irBTngcRUPgr4XNy27YBBpa4b+bBd1zdIEeB6i02fHdOVfIepQjlTWvrTyb3mhdKR0I
         PAbPR3qP7guA8yuS6tHC2twIcDhxK0ZS/wPVwLKEj7uanjZWXsFqza2+VGhC4+NWSI+d
         LAFPnrQnxsH8m4PrHXRCE6xN9rqX4wso+nYn1MDIiM6mLt9CLISAV2Zu2kOVqN+bkN0e
         41+/4edIh+edE5D9ecuwYEeEXk072v2Wee/yBxQSaqztqcgtu0r8SD0dW/dC98ZGZ3Wu
         U0pg==
X-Gm-Message-State: AOJu0Yz0RU9lvdT0vydUdjKkXmiCedECFKe7GVSsgrg8IMqd/u0SSLNU
	ODlEuL3Ehh6NLiNq6lTM8Y9smZrMnd4MVwurlKJIA9in/NM=
X-Google-Smtp-Source: AGHT+IG2zTOcLT/slo8Xy1NCbxTjx8uZ3GB00uyChCN28rM0o4JcEyf70j7nxUJQlMxzM1AFksLtvXT6JGsj12dWHxE=
X-Received: by 2002:a50:d0cd:0:b0:553:7ff4:5885 with SMTP id
 g13-20020a50d0cd000000b005537ff45885mr34380edf.2.1702928357402; Mon, 18 Dec
 2023 11:39:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000b505f3060c454a49@google.com> <ZXfBmiTHnm_SsM-n@sashalap>
 <CAJc0_fz4LEyNT2rB7KAsAZuym8TT3DZLEfFqSoBigs-316LNKQ@mail.gmail.com>
 <2023121848-filter-pacifier-c457@gregkh> <2023121834-abiding-armory-e468@gregkh>
In-Reply-To: <2023121834-abiding-armory-e468@gregkh>
From: Robert Kolchmeyer <rkolchmeyer@google.com>
Date: Mon, 18 Dec 2023 11:39:04 -0800
Message-ID: <CAJc0_fzhWtHJJ+7j6vKoSxppVS0TpbqGZ398JwLs=dkUjUTzhQ@mail.gmail.com>
Subject: Re: IMA performance regression in 5.10.194 when using overlayfs
To: Greg KH <greg@kroah.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org, 
	linux-integrity@vger.kernel.org, regressions@lists.linux.dev, 
	eric.snowberg@oracle.com, zohar@linux.ibm.com, jlayton@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 3:58=E2=80=AFAM Greg KH <greg@kroah.com> wrote:
>
> On Mon, Dec 18, 2023 at 12:57:20PM +0100, Greg KH wrote:
> > On Tue, Dec 12, 2023 at 04:37:31PM -0800, Robert Kolchmeyer wrote:
> > > > Looking at the dependencies you've identified, it probably makes se=
nse
> > > > to just take them as is (as it's something we would have done if th=
ese
> > > > dependencies were identified explicitly).
> > > >
> > > > I'll plan to queue them up after the current round of releases is o=
ut.
> > >
> > > Sounds great, thank you!
> >
> > I've dropped them now as there are some reported bug fixes with just
> > that commit that do not seem to apply properly at all, and we can't add
> > new problems when we know we are doing so :)
> >
> > So can you provide a working set of full backports for the relevant
> > kernels that include all fixes (specifically stuff like 8a924db2d7b5
> > ("fs: Pass AT_GETATTR_NOSEC flag to getattr interface function")) so
> > that we can properly queue them up then?
>
> Also don't forget 18b44bc5a672 ("ovl: Always reevaluate the file
> signature for IMA") either.  There might be more...
>
> thanks,
>
> greg k-h

Thanks - from what I can tell with `git log --grep`, 8a924db2d7b5
("fs: Pass AT_GETATTR_NOSEC flag to getattr interface function") is
the only such fix we need to backport (18b44bc5a672 ("ovl: Always
reevaluate the file signature for IMA") is already in stable trees and
introduced the regression that motivated this investigation).

I'll prepare these backports and send them to the list.

Thanks,
-Robert

