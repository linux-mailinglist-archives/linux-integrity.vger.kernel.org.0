Return-Path: <linux-integrity+bounces-3608-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BF69799E9
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Sep 2024 04:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62D5D282D65
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Sep 2024 02:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C097C8D1;
	Mon, 16 Sep 2024 02:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Od+lUWrZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA4E2F5E;
	Mon, 16 Sep 2024 02:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726454008; cv=none; b=YQ6yELkdIbDft0AFBxAj1zWIKQ6DdacZBbpZw3n8Q9Toxny1mecURI+SBnPgZQ87ZhbOw7e7IdUhAA8QA6V40cyTpRB9ql6egJL84xEkiARDQ3aSpU+uIyGOQpdImYARmjccY/3oXb0uE6GUvRsNnxfqI7yqCoQKL2IGecb6ruk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726454008; c=relaxed/simple;
	bh=MZ0NHCtipHHyGF/fEfMurW1Ve+iCzXkVDy+P5sxjk60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oNa6bPHNCtvYl19g7AiWX3FlnyCL+nRo+20HjU6PQlwpo2yEjKaeNEr8rj+k/BzTcfnnn+HR8X0WtcJlE5gp42D6GpHG8YD8vv6abQLvoVRMQSKoFqrV65t3URF8wVaL+B+w6FR4jQnkETsunw7pbM20hkL0RqXMa4vX77RlI4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Od+lUWrZ; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53568ffc525so4492182e87.0;
        Sun, 15 Sep 2024 19:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726454005; x=1727058805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggg4JtFM6ycNThd/2kQHdL3j4PMBkevtt6B9BIc3upo=;
        b=Od+lUWrZZunXKJtvHFCNiF4nYqQvcTozzgNkLQKWvhjuZo5eOqOoI06c/ipjM7apcl
         zkbT/DTKo17k0LYPeIH+PLH5/TQp6OYgM/ghz/feYWiyCIK9CR7+whTSYLjWmo6CPTes
         t9qh/W1KuOCQZBJZ0CF5FK5bgdHdUsYRoGVCcqJ5Pzip2wkTKFVPL5ZwnesbshFOcMc6
         AeCEkywS8bPB4e53uu8yJkdiAU6BY7I0pzWg5UyRmxaXzNw3pg1beTzUlsoOtncTi3fR
         dUsx79HtOFGiHSJDLr5o75+KhK6T5z2gCDkZdb61mpIcVDK5x9svHj3e179KHLoFn+4B
         6gyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726454005; x=1727058805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ggg4JtFM6ycNThd/2kQHdL3j4PMBkevtt6B9BIc3upo=;
        b=BE88Pw8C2P7R3JKwK4LHN8UZqgRKdnbvnxyoSy28DwM+IvxKwZc/5xmb53cxBIxWqu
         SM9CXSrdJST9QeOxzAxLUm2v4Mssnh0k4N+yv8GU5k+62pQ0VT0PiJ0HitjHtVykjpIR
         KvD//YNjZ0K+XVvRAGV2pGHPhw79tgRPbIJ49r+VjEw/J96Q0elagzRuk91mqAzxeNBL
         5dLNQQUUXyp4aXLOUkLvaXk+EVzMDXkcZeosAvDTD9a/WVrXHsDQpsljx6fXliZKen+g
         k2R6TcTh3f3pYBoZhYoaBlfOFWm2q15TCtlM8kMhaKnkldHxj5BlMb7911oakqbt6onE
         OH4A==
X-Forwarded-Encrypted: i=1; AJvYcCX1bmPyX6szX5rtR+wqiNgch8NL3PeSd2TwcaZDYyVdOGwi5K9nmXQaf3JTUUj2aKhLyOqmJTUfopCfv1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsSdJPu5eAbBW1bwGhiwG69tbKVQGYg8xHPDs7PRiDo1ZMqq2N
	dKk8XTfrLwTZqQRbluYtsEuDziveytw8V62ktLRCS7K4r5FzyLiqQQG89NLCBlWtxFQRT5JYFrU
	wBvSQZsnoW3OLkF4DYSntbBkOKgg=
X-Google-Smtp-Source: AGHT+IGeZY8Ra6ArZv5eqM8elTcbTLcBII9Rw/xiPZlwQLnWVfFQfMRKc3Xz/ZMUEZqddmaCaBV0/dSIYxnyqejs6pI=
X-Received: by 2002:a05:6512:3d23:b0:52c:99c9:bef6 with SMTP id
 2adb3069b0e04-53678fb1929mr6907629e87.7.1726454004592; Sun, 15 Sep 2024
 19:33:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915180448.2030115-1-jarkko@kernel.org> <CALSz7m0ehXM+dU3z0xYPLQkHbyfyMjoCOoMLdBgRcUu1pnT_ww@mail.gmail.com>
In-Reply-To: <CALSz7m0ehXM+dU3z0xYPLQkHbyfyMjoCOoMLdBgRcUu1pnT_ww@mail.gmail.com>
From: Pengyu Ma <mapengyu@gmail.com>
Date: Mon, 16 Sep 2024 10:33:12 +0800
Message-ID: <CALSz7m1WG7fZ9UuO0URgCZEDG7r_wB4Ev_4mOHJThH_d1Ed1nw@mail.gmail.com>
Subject: Re: [PATCH 0/4] tpm: lazy flush for the session null key
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, James.Bottomley@hansenpartnership.com, 
	roberto.sassu@huawei.com, Peter Huewe <peterhuewe@gmx.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

After applied your patches, the boot time is ~15 seconds.
Less than 20 sec, but still much more than 7 sec when disabling HMAC.

Send again in text mode.



On Mon, Sep 16, 2024 at 10:25=E2=80=AFAM Pengyu Ma <mapengyu@gmail.com> wro=
te:
>
> Hi Jarkko,
>
> After applied your patches, the boot time is ~15 seconds.
> Less than 20 sec, but still much more than 7 sec when disabling HMAC.
>
> Thanks,
> Aaron
>
>
> On Mon, Sep 16, 2024 at 2:04=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.or=
g> wrote:
>>
>> There is no load and flush the null key for every transaction. It only
>> needs to be flushed when user space accesses TPM. This postpones the
>> flush up to that point.
>>
>> The goal is to take the first step addressing [1]. Other performance
>> improvements are needed too but this is the most obvious one and
>> easiest to address.
>>
>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D219229
>>
>> Jarkko Sakkinen (4):
>>   tpm: remove file header documentation from tpm2-sessions.c
>>   tpm: address tpm2_create_null_primary() return value
>>   tpm: address tpm2_create_primary() failure
>>   tpm: flush the session null key only when required
>>
>>  drivers/char/tpm/tpm-chip.c       |  13 ++++
>>  drivers/char/tpm/tpm-dev-common.c |   7 ++
>>  drivers/char/tpm/tpm-interface.c  |   9 ++-
>>  drivers/char/tpm/tpm2-cmd.c       |   3 +
>>  drivers/char/tpm/tpm2-sessions.c  | 115 ++++++++++--------------------
>>  include/linux/tpm.h               |   2 +
>>  6 files changed, 68 insertions(+), 81 deletions(-)
>>
>> --
>> 2.46.0
>>

