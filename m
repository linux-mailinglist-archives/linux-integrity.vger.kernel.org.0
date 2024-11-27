Return-Path: <linux-integrity+bounces-4218-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE18A9DA13E
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Nov 2024 04:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E44BB22D58
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Nov 2024 03:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED62C129A78;
	Wed, 27 Nov 2024 03:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RNJgJ8sF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4736453370
	for <linux-integrity@vger.kernel.org>; Wed, 27 Nov 2024 03:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732679647; cv=none; b=I2mDKxiW1ROt6Ofeazf1rB9IH42QBz5kF2t3nlYQFk6w1pWJS28MtH6XRRmF0VpVIOVjs7YORhIcVV3xm+a201o7yZKZAJOTp+8whcKCEMcxHB/9x2wrtPEE6JlT/hNdVWNwi+hRxuYR8ekZq45h03VweLD59P/kIyWzKub6poI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732679647; c=relaxed/simple;
	bh=gHWVtT64xW/oYKsm1H1s7gXvV5oC9AiMhgDBCf2ERw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=as7HAyDYwMGaUUpCQ0Z/u+flYpXBgwtuwbjCv/5DgOnAzHyzsmKQ70Dh0RqMS6h3iSzQiMVU8/2Hdlhg3RB6jDr7EURpuvDCj32VQdTKqZs5teZdbZW1mC3xuEQ9H3q/1ujgFf4mnkbCPJuIsSN9khSqYKfc+R2oiyHAODTP1pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RNJgJ8sF; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e3824e1adcdso5991714276.3
        for <linux-integrity@vger.kernel.org>; Tue, 26 Nov 2024 19:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1732679645; x=1733284445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JFRcmOZiXHu3/zU8zCoF0fSGQ7YTFiOrtbQ3JdZhf4=;
        b=RNJgJ8sFc9hYqyLg6ykQB5Va/6h1tuD9tOjf1PWqpObSbbHxOM2M+z0l9E0MWiuw3N
         r5NqaIaZCdAyT+zetuFiJzTef5IngPxZqzHsVZgpIlt8PSaniccPPTatYXb0PiXh48Ru
         Pw3NxbShi2RsEhAYKiUT9OZuC7ukR7hWb9B/rilX2HTQuOYpqzwycz6bDUIemEjal9aE
         jxrwHBvhSb99oLGEBwCkYir75JLWnL/RSwRuSR7lMvn0wsALfdGQZx6aoDmfVRomv6ES
         bbsfX6nMFVDVgNDilip3nKlf5hhh0b0Q7k7Np6M3BWku+DmRxxtw90SKXIB2yDXl63Jb
         6+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732679645; x=1733284445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9JFRcmOZiXHu3/zU8zCoF0fSGQ7YTFiOrtbQ3JdZhf4=;
        b=pr83wYkCIiQCXp1KYVzMcLXXFkgjFHSVK/IZDjULFbdzrtxeyH69E3Q+TNCyJDs470
         isdRgEaTrzghd6sa0lUMdd4z/cDcS76nYBSOWUEOc5lRExpLf9zprllKxQfAn9UfaiJx
         MAPZds83vyZAJtOhDDTcJGdCUEJWOFsnTi1tiUBU58W2SwnjVa1Lkx1KMNcusxXaVibu
         7X9IyrUHh2+H397CFc1ZFHB0wEqwaOjzAW9MdrxXJbcEk+oS1hWrCugTY6IcoJi7b7vx
         Qd2WK4wEecSv5RWmXdwwDidVFcLYYUP5nN/oPDLokwj+I4a+bOQE/9eKFaTmXxvOfel1
         XvXA==
X-Forwarded-Encrypted: i=1; AJvYcCV5JcYpayfNeyf84qHfLC53rQto33IE1fYyu2sF9ZwH4r4tuIjMfM8K52yd/abP2IKjp13ok3ZPZfyApRdJOa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL+NCJV9HyxYpHqTMJJfeCgXmpyz0E37vBzQNh44DRhl7pt0KA
	XEKADuiEGrOIbmEjIgXth0BvMh6iZicIcRT6IxcrscoB2CTzfEGrWMYhDRfbVJ6JqIsYKVjzLJE
	ceCzVg9P50AOj4m2ne1PzMtH6WjEujWqjobYN
X-Gm-Gg: ASbGnctwKidOG8JakCvD0hEcoOx4PeH8sK5X531+xhgdAQOFR4qVwZE23ZtE0W6SmPt
	vIOXBSUTLZpCyVwMDfnz0JKO63sjVXw==
X-Google-Smtp-Source: AGHT+IEdqF+9WL4cRPWTyDd8aisGMJUrebOf6avTBCMaDvjIIq3DWm39d2KLQfyoufDVabCnOWJJVG7gr6EsbTiVTLI=
X-Received: by 2002:a05:6902:2d8c:b0:e35:e24f:284d with SMTP id
 3f1490d57ef6-e395b8a5f2cmr1359548276.16.1732679645222; Tue, 26 Nov 2024
 19:54:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ2a_DeUX9UdAYOo9OwG-yXSH1etKQZortPcyxfzG70K3N+g7g@mail.gmail.com>
 <92e5fd64-8c75-4e82-981a-846364fc7a38@schaufler-ca.com> <91a227f3b57374a8aece5480f285c433d3888572.camel@huaweicloud.com>
 <CAHC9VhS7KRcpA7cHcwpKknYsC7iZiBjZGVz1xznC=d=uDYu7EQ@mail.gmail.com> <86863031e74c46e9982fee38706a4d17b5c536dd.camel@huaweicloud.com>
In-Reply-To: <86863031e74c46e9982fee38706a4d17b5c536dd.camel@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 26 Nov 2024 22:53:54 -0500
Message-ID: <CAHC9VhTw71a2tKdbOeYz_1hv6vFG9EDREwG==Ri-Z6iL594J+g@mail.gmail.com>
Subject: Re: ima: property parameter unused in ima_match_rules()
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	linux-integrity@vger.kernel.org, 
	"M: Roberto Sassu" <roberto.sassu@huawei.com>, "M: Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>, 
	"R: Eric Snowberg" <eric.snowberg@oracle.com>, LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 11:39=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Tue, 2024-11-26 at 10:57 -0500, Paul Moore wrote:
> > On Tue, Nov 26, 2024 at 2:50=E2=80=AFAM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > >
> > > On Mon, 2024-11-25 at 10:23 -0800, Casey Schaufler wrote:
> > > > On 11/25/2024 3:38 AM, Christian G=C3=B6ttsche wrote:
> > > > > Hi,
> > > > >
> > > > > I noticed that the `prop` parameter of `ima_match_rules()` is
> > > > > currently unused (due to shadowing).
> > > > > Is that by design or a mishap of the recent rework?
> > > > >
> > > > > Related commits:
> > > > >
> > > > > 37f670a ("lsm: use lsm_prop in security_current_getsecid")
> > > > > 870b7fd ("lsm: use lsm_prop in security_audit_rule_match")
> > > > > 07f9d2c ("lsm: use lsm_prop in security_inode_getsecid")
> > > >
> > > > The shadowing was inadvertent. The use of lsm_prop data is
> > > > corrected by this patch.
> > >
> > > Thanks Casey. Yes, this is what I had in mind.
> >
> > Looks good to me too.  Casey can you resend the patch with the proper
> > sign-off, commit description, etc.?  Roberto, can we convert your
> > comment above into an ACK?
>
> Yes:
>
> Suggested-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
> Acked-by: Roberto Sassu <roberto.sassu@huawei.com>
>
> > Lastly, Mimi and Roberto, would you like me to take this fix up to
> > Linus via the LSM tree, or would you prefer to take it via IMA?
> > Either way is fine with me as long as we get it fixed :)
>
> It is fine if you take in your tree.
>
> May I also ask to double check for the patches in your PRs that we are
> aware and me or Mimi acked our parts?

Yes, of course.  I didn't chase the ACKs like I normally do on Casey's
lsm_prop patchset as I was in a bit of a rush and thought it minor
enough for most everything, but you are correct that I should have
sought out you and Mimi's ACK on the IMA related changes.

--=20
paul-moore.com

