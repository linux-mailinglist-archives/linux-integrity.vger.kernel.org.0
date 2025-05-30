Return-Path: <linux-integrity+bounces-6347-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E37A5AC91EE
	for <lists+linux-integrity@lfdr.de>; Fri, 30 May 2025 16:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB60E189F782
	for <lists+linux-integrity@lfdr.de>; Fri, 30 May 2025 14:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB5B235040;
	Fri, 30 May 2025 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZKbzoavf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D050D234973
	for <linux-integrity@vger.kernel.org>; Fri, 30 May 2025 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748617180; cv=none; b=AXxA2/DkNU9sABAkepBF7gZ0IeblukDUlvfkvjdluE3w66elfqNzUxUXXm0188cLrPad2nY1YdqgxxK5Y9c7SxT0HlcgI2Jy/xA+f+nj2z/UksjOfvQQkj0JqjyCeJcA+VEwwp6V3DsEOfCgV/QJk1HTw2QewRDY+21C4agpwpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748617180; c=relaxed/simple;
	bh=jasKmp2aQuprGgWI5wC0BqX8f7HQURC6vV2wipWoXUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ry0obpkdwP+ksV8++s8EJoa86bCEi1Z/jCOipEXWWHdqwkH0rS54P1YlzsOAaKplNV34PLw8CAYPcRJ4Zh7zOcX49M7TDkmyYYlvaxCt/LirQgLCapPIwta3vE5cbgzp4u7e227PD2NiV+kjRJdqgAWaBZ0RxZ8YFk10CY4UZmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZKbzoavf; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-70e33252046so20678097b3.3
        for <linux-integrity@vger.kernel.org>; Fri, 30 May 2025 07:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1748617177; x=1749221977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAAu3PNn/g5swmaHMNzxUtR7zHSWqNSkf/EYcL84FJM=;
        b=ZKbzoavfJTTsa1cyffhW4nXl/B2WC9layXNA/Xwo4HB1mjXpmYbPZnxWkFNlisELmd
         jAeyAgL9mMb7qJbVHJOUBWT7WsY/P8iJiU447v9jhfjs8clOJCQFPqIz5p+tUUaRg4QQ
         pqa/2gHJnE6jlOO/7+SiXrX0Tzaq/qm8opI2itTNMgTnTztfNWYxQLoqoUO24cHElzhr
         PX2UL8PcTbab76f871N6wVhxRyhIyMMaGe4VjQhDAln3ez+tuvmXMeuKK4kOIuyQWpA3
         8vYI2H81GIXnusEcRhT/wb+GCs17fB1zPeyPi5Zwwor0ddJFGOvho48cupfENEED+BIr
         a1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748617177; x=1749221977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FAAu3PNn/g5swmaHMNzxUtR7zHSWqNSkf/EYcL84FJM=;
        b=pf2pilzVgv6+sHpORC03HL6IbTq4ZuRJA0A2tZlUWevWYcBKPVxkevxqMQkXsZCSFQ
         ip5972pY6B1Ft7uf4lUpPdaRhrUN8LeccSqr0e2CC2E2ZIaKjfmmF3Fqg/NTyh7jPhtL
         Pap6G8V6Vd8VNbN9J6r7HpvO3BeLasrzISlHq5HjA14ownFHae8oxxD2l2cI8oFJRL71
         lHSIIBVKnKMyHky/kr25Et2ohrAJY4QwThUhI06u3sxQXmHvMwKe02tvRyevkPlMmym1
         lnBOW3RM9zEgw3xlfvhGWmakerFKAV0UeSFoOOwGNjHXvfg8agkofzT8e3LbXFyKznAo
         mwUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs3j34BpPQaRVT3BKr8IxYR7L9Jms0SR9H7hIZfyLyp9zn7bsLuFcSKxAJryzEHWPs4Xp0MKJPci4qWE9JNc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDRahB2lwLvd1HBog7MV/r54D0O30RlYxBTeXCU+p6qMpPPJY/
	Vd0Gfo+Q7sskOYrqjWWCBFCdqZRwKVAJRQzQPGxn1/qX2nKRwkw1Ga3iux5Y7bNNrUvj4trrfEd
	hkM53eH75a/6NmmJFz3tTDHdO7SoLw5+izAiWE2nl
X-Gm-Gg: ASbGncuFjCq4/5omrOG2vkukSuyOq6mLo96kyKewR8XMbvLZqO0FeNgVv2OsS8hiFOM
	MFiQN+vYf6o0G3m/FlAFlI9SamdTVTsJCBfuabJMYf0YEbzFczfmOEvW2h8BVVdXp0jjiIRnp9H
	lCdp65z+U+9vu8p4JESq7VhuAfUNF1d6inWcIy9nIhETg=
X-Google-Smtp-Source: AGHT+IHHnVePMsvh3ufc14xyANHYkK76dmtQi3C9pr0hEAJFnSpRDvuBz9Sw+cjnx2wg+DaroEvhGoRJ1j6utE6EWUc=
X-Received: by 2002:a05:690c:c0b:b0:70e:2a04:c768 with SMTP id
 00721157ae682-70f97e9b96cmr52596327b3.14.1748617177588; Fri, 30 May 2025
 07:59:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521140121.591482-1-git@nightmared.fr> <20250521140121.591482-10-git@nightmared.fr>
 <CAHC9VhR-80zxgo+q07Aw8HqK+qiPdnuXC0axONGac0e9JxXvmw@mail.gmail.com>
 <4939d8ab-3911-4759-b8d6-cb57ff9f9cda@nightmared.fr> <CAHC9VhT5JrhzGhRnJ4VNo6e941o-xdAG-FC-Q6wDbSZhgSUWOQ@mail.gmail.com>
 <2495c0bf-5a24-483b-835f-abf433687889@nightmared.fr>
In-Reply-To: <2495c0bf-5a24-483b-835f-abf433687889@nightmared.fr>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 30 May 2025 10:59:26 -0400
X-Gm-Features: AX0GCFvKjrCn57dBCtHrgxUd83Gfghrq1tsQqynYBLqWk4EKe074m06s3Cas29k
Message-ID: <CAHC9VhSvwOZXnh4o3O8_+QXXKJ32D=9ogoizvNzEEGpzQWhx+A@mail.gmail.com>
Subject: Re: [RFC PATCH 9/9] Loadpol LSM: add a minimal documentation
To: Simon Thoby <git@nightmared.fr>, Kees Cook <kees@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 3:03=E2=80=AFAM Simon Thoby <git@nightmared.fr> wro=
te:
> On 5/30/25 01:49, Paul Moore wrote:
> >
> > My thinking around possible augmentation of LoadPin is that both
> > LoadPin and Loadpol share a similar, limited focus of controlling
> > access to kernel module loading and Loadpol has support for a basic
> > loadable policy, a policy that could likely be extended to support a
> > LoadPin-esque construct that limit module loading based on filesystem
> > pinning.  It probably makes more sense to think of adding LoadPin
> > support to Loadpol, rather than augmenting LoadPin to support the
> > Loadpol concepts, but for consistency with upstream we probably need
> > to speak in terms of the latter.
>
> Thanks for the reply, I now see what you meant. I will try to put somethi=
ng
> together (hopefully next week), starting with looking at how we can expre=
ss
> the current LoadPin feature set as a loadable and user-extensible policy,=
 and
> then add non-filesystem-related policy entries (like module name restrict=
ions)
> to that policy.

You may want to see what Kees thinks of the idea before you spend too
much time on this as he is the LoadPin maintainer.  I'm guessing he
would be okay with the additions, but that is just a guess on my part.

--=20
paul-moore.com

