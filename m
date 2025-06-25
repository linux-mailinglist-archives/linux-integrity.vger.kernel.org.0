Return-Path: <linux-integrity+bounces-6508-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98117AE74A8
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jun 2025 04:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B98885A5AE1
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jun 2025 02:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB60C1A08BC;
	Wed, 25 Jun 2025 02:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aCu1mQrG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B02A190676
	for <linux-integrity@vger.kernel.org>; Wed, 25 Jun 2025 02:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750817283; cv=none; b=qaqcwHSva7Ap8kKp8h210AdvkcnC4c0JxlO14cBE7HD3aAU0p/TZ7tKpTh+zt5zu+XJ2JVp3YqgyZxuZJ98wdFn95NUEK0Lr3Z6lgd2xjGKmq9FXhc1tbWfKv4+IrSzO5w+4KB8dVv6mwK7uiQBYYj9e7EJAILbDzaPbk1DYfYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750817283; c=relaxed/simple;
	bh=ma+88H5VpAOifU7fHtlXxdBKdlhmSUKKZ8A91So9mGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ll5FDtGd/yzaAZRo41fGeewJoNIyQze+bHOpWgcnhZUt69xXbL8xwlL8EEDNblpboxk4AEAY6zHTMbdbSU00TtnE/brTL6sXPNU5Ayi4+1qndjquEsRyG0X32zRs+UJvUJ/dF6YiYUK6ORYNBRW3zMERzq/Q5Q5Ci3WHB0NCRxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aCu1mQrG; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-70e77831d68so59837727b3.2
        for <linux-integrity@vger.kernel.org>; Tue, 24 Jun 2025 19:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750817279; x=1751422079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ma+88H5VpAOifU7fHtlXxdBKdlhmSUKKZ8A91So9mGM=;
        b=aCu1mQrGTrvIeygS6AxuH3K2HUUERSjtj4eyshr4PdYU6DEjweIS7AdEeHfW1Rcfel
         NzeRw2llw+41r9aAyX6jQRlJpPuhGc9sX4bkMJN3PSq2wfUCwbs9/Sfy9QKgaT12ha03
         6eVU3bguO6Oll/5C8Zc3gWxSDRWuxI81r/P0rJIf8bzeIDoD7RRNonjonehOKpNxZIWb
         TLwJ3TCmVAq0byBuFhWj6bmtN21IdogFWjn8bFYiKQrK4LKfulmn0VjJan/YV4SXESDz
         WLJkmX+lcN767Pf7KkeamVsL8jo5j0UVsCVOCDita6KOGOnQEVG6qgNkEROglhWh6vwp
         CpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750817279; x=1751422079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ma+88H5VpAOifU7fHtlXxdBKdlhmSUKKZ8A91So9mGM=;
        b=ucyp2apDKCO8z7yNl3/tCyVYGuRY1rgkcwfImn7zDHI6JsZrgcmk5ywAEUUxKAkziW
         Z3EQ5DlejWTKAgtpYEHMGfvGW+mDEcrBUoeGTMCgCxGk40W2vkJUp5XtFq+nvyYEWO3v
         GzAtsUACiIkOrBo4noNJVztcEenpOY8Gc4eBkPKxjXabV1tyVgXIK69ZwMbvAMNqZCOX
         fNNv92xwWue6K2RLziE7twtF35jDpfyyFznQ1f5BrfyY6drmUWHdZCNEX+uwK+ewCd3P
         AaSMkAoCSjGfjQm4dHk4zNezd0feJoXgKMbZWHPpnIbCl3mnZCsS5+Y50/cV7mAnL4Yy
         ftgw==
X-Forwarded-Encrypted: i=1; AJvYcCWBT3ySwVTrEmpOLnab/fWVUvOhUcjDJCApwPkUImtacsfufcrehGtru7wh6NI6n9Oz02O/kmGRDE9sX1WeEcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7no8Oyvg3hni28dkq/+IYtWWKsnhAiiHy+EwTpSqHfqj566na
	WZvhY2r1Vgeg+dW6GKywg1itLJML+kRDOlaPqVr8aKcyyFhhc+cGXOKsJH5N49rq6LG1f+8WSgd
	f5NGHbCSH44dbMgAzOBWhLrqfHEILp2t5eUqqjQUEYzo7Nqw5Zrs=
X-Gm-Gg: ASbGncv+KyZfRlVCdmWPbCYI73oRXTPJTMbtUimwUv/TJVZB2pjLxY6MTy8ImUFlsDg
	AlwHXf/hfSfPlRvoSpPDJIqTliU/3/ikJ1Q/AaaZQkfKuc7MXFdSSFNS2C1tylzHs0zZeAxZJz+
	GHx9lIj7Uar9i56U3cWnzZzrX2S6FtlAWQb5hXUz5GdYk=
X-Google-Smtp-Source: AGHT+IGlJ3+t50Dx73mM8Air5bfcWg1IIPvwg/Vg5HkXBBKOKiLaOFTVUfjQ8shi4PBm0CiACEhKPb3fm1gsyHDeyKc=
X-Received: by 2002:a05:690c:3693:b0:70c:90af:154 with SMTP id
 00721157ae682-71406dd05f1mr17609477b3.20.1750817279444; Tue, 24 Jun 2025
 19:07:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612030951.GC1647736@ZenIV> <20250625014709.GQ1880847@ZenIV>
In-Reply-To: <20250625014709.GQ1880847@ZenIV>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 24 Jun 2025 22:07:48 -0400
X-Gm-Features: Ac12FXxDWMVHh8x3oQC-oksHsfE97o8MSwUkJxZcBW8YhsT9RmghUSqQlA1JLeI
Message-ID: <CAHC9VhSTzc-KZyd1RSOaFDMjmiXCQBscLE=d1wGvc=DWnfz6gQ@mail.gmail.com>
Subject: Re: [PATCHES][CFR][CFT] securityfs cleanups and fixes
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 9:47=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
> On Thu, Jun 12, 2025 at 04:09:51AM +0100, Al Viro wrote:
>
> > Branch (6.16-rc1-based) lives in
> > git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.securi=
tyfs
> > Individual patches in followups.
> >
> > Help with testing and review would be very welcome.
>
> Seeing that no complaints have materialized, into -next it goes (with
> Acked-by/Tested-by attached)...

Thanks Al, I appreciate the help cleaning this up.

--=20
paul-moore.com

