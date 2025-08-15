Return-Path: <linux-integrity+bounces-6868-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D72B28597
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 20:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A8573BE9A0
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 18:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BAA302770;
	Fri, 15 Aug 2025 18:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ml7XGtjj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD98301031
	for <linux-integrity@vger.kernel.org>; Fri, 15 Aug 2025 18:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755281363; cv=none; b=Idv8Hs6Tgd74bU1hGMWyXa96d4rlAtGJHu0xRiL6sxx1GCs4bTGDglJXA5aiXjw6/KMjbB6FRIQSsXitry1VnVng/IApHQqo7tseCHw1myAHw4xvKK2A+GPqk/bYr0NhYA+8+0sExWsHy9eu56WZxeY6Lr+QiGPYwXLDWb1oA8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755281363; c=relaxed/simple;
	bh=VAFPFyAfwkotMN5lELbbjxQFE0CyO//yvNt+to9CJMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FpmePVOFXHipM8wmJFIpkf+J65GkP+Pe4BDLv8MIJB5G9NBIU1nyY9MCruBhrdMWL2unZmHeJJw+5MZS2B0Y1roCqBJAO2QDkYc7IzTf14N3EoKcXYeZ+4/l12n5No0wKPN+QRuO9A9tzkXgAc3j0sRv2rwMUhbRqQKUBqwxhhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ml7XGtjj; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55ce526ac04so2117180e87.2
        for <linux-integrity@vger.kernel.org>; Fri, 15 Aug 2025 11:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755281360; x=1755886160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAFPFyAfwkotMN5lELbbjxQFE0CyO//yvNt+to9CJMA=;
        b=ml7XGtjjEUP4fLxMwf7OEcqSeECf82HLil4wwzPJB0D9ysp4Zf/WRT4EmvCykEFJ9C
         pyrnSMqx1ytyEAaYvp47l2Rn1cT+Cg9lf6TBeI+B0ukqNop+ugeZvLbBtQAXyusb7RE4
         mMPMA6o+lBUG9lSk79I/YBKdrLaiScIA9oTChCGD4KjuiqUPdWm1j7NejjpevdJYCg0/
         u+tsL1Gb9PgV94cceLbq4LcFQDIGXG54TrRpF9BtZVXQaTiiDcI73L/JKStcEpP5EEtQ
         Xe8YN6uOtbF+3UUEo91bHvGS8o+2RSeJ/7gm89u+MqX3rJKqj06Wsl9ZA/f4VHIDYR+n
         Qa8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755281360; x=1755886160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAFPFyAfwkotMN5lELbbjxQFE0CyO//yvNt+to9CJMA=;
        b=EjBUWGHTb7dE2+YRzRksbYklL+eZcq92AYLxKZ+HSBVQjhp0prLhPI4UYB4cAYFPma
         7yo/wpL1vjclxcO6mYVYqLVxXbRJX02zHRH2YQWMvQ+9OtrKdfqfy8QdP5Dr4wWlThiE
         hRhxEmJTCej7ddqaWvoD1g/I22JmpE8McmoGzw6MynR68xUiBXE9627kCXtQ7L2IMXwB
         8N80+mu0A5VDz5nlKGTiLvG3dkq1k1tuD8/ZJt6KrZj22tB4P/yR+4XVMYY7MH9mIVNx
         G0/oN0iiq1Hun2XI25PWfNCGQ0gxPxZXSCZPURfPSGXzw5CgOTo7wxVa20zfDNC8jhom
         BdiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIdKbf5GucAx0yZERvYhDPLBLerkni75WmZQv52LZ9X53jeLzxC2vAxwtf0Toqb0YiR/Od8NWWBDyr8r9Mv8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW4DmMW8PnRUTx+nB+cDzpAeB+gkNR133GLn3OCFn1ciLoDWm2
	Y5hyYwV7GHPmXPnnAS++qsEY7fQ+qcVRQJO5EIhF5tYkOFuIz/8U61gkMpl0/g0BBgmsXcc9wSs
	akRmdjV8u42LDfJ3YIEuuAJRAf+Dk6o7o5OKjv1si
X-Gm-Gg: ASbGnct00NRuYWULOigJ60/I+biGSWdV13e0I5B3isBMmULXzUpQxEiH7cBomCXA3YY
	IKpaPoZiUBYury2/15S6rwEGbNfSfYxTY1lL4Qb+9/z7W5RZlNHj2KyptUb0iKwE2V5j8D3j4sw
	4iqqa1XjBNeDSM7qGKIpPXkCyl0FxfSsmcZ97k11gzVREVOzIk6ELOF/Bu7BCCAGNh+kBmUvd1t
	QC5Q7QxCWhYjYThwQkqmL4=
X-Google-Smtp-Source: AGHT+IEqCYHW13TYrFzD3R9yuwCjd58YoB8BOmQK/j4b6qVInQSzYl9DHImFwD09MJFV3aovA6rCWkl3GgDpI67yFUw=
X-Received: by 2002:a2e:b8cf:0:b0:32b:a9a4:cd4b with SMTP id
 38308e7fff4ca-33409809a95mr8565381fa.4.1755281359499; Fri, 15 Aug 2025
 11:09:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814162252.3504279-1-cfenn@google.com> <aJ8iNLwlf4PAC0h1@kernel.org>
 <CAMigqh1RTVzz0ffY8M3mZuc7NDaBKpMmCU4q0LuNyM2eAi+NFg@mail.gmail.com>
 <aJ9fy_sO6tza9qLF@iki.fi> <CAMigqh2=Kmnv_rrT-gBtESSXtnMrxU=VJdrYE6_9NGhKBN+ZrA@mail.gmail.com>
 <aJ9ySGv0JZ0DiNgf@kernel.org> <aJ9z4OlwvFdEA2Q_@kernel.org>
 <aJ91KX97WVOQ3nVk@kernel.org> <aJ92qt6oSYyRYPZG@iki.fi>
In-Reply-To: <aJ92qt6oSYyRYPZG@iki.fi>
From: Chris Fenner <cfenn@google.com>
Date: Fri, 15 Aug 2025 11:09:07 -0700
X-Gm-Features: Ac12FXyKyx-GCsrnIWEuVzsmwUR80hJX2IJjlIFJ-EPYx70be01fuqQ1Sg5pyjs
Message-ID: <CAMigqh3yx7S2T=b-gTfdTG5BRs_JbHkXar4DT32AB3v_beNveA@mail.gmail.com>
Subject: Re: [PATCH] tpm: Disable TCG_TPM2_HMAC by default
To: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 10:45=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org=
> wrote:

> Primary key persistent handle.

I see, thanks. I think this might make it easier to ensure the driver
fails-open in the "relaxed" case, but I don't think it would resolve
much of the performance drawbacks (really we'd just cut out the
ContextLoads, which in my testing constitute around 30ms of the total
135ms of overhead). I still don't think it really solves the threat
model since the adversary can just make sure to interpose all the
requests instead of just some of them.

That said, it really seems prudent to disable the (seems to be?
broken) feature by default for now, then re-enable it once this is
confirmed working.

On Fri, Aug 15, 2025 at 10:52=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org=
> wrote:

> This is not to admit that right now the feature is no good to anyone
> but in a selected set of use cases with this modification it would
> make e.g., IMA's security *worse* than it would be with the feature
> enabled.

Under what specific threat model would IMA's security be worse in this
case? Either there is an interposer, or there isn't, right? If there
is an interposer, then they can interpose all the commands including
the CreatePrimary and session establishment(s) and defeat the current
and proposed version of TCG_TPM2_HMAC. If there is not an interposer,
then this is moot (I think).

Philosophically, I think there is no such thing as "more secure";
there is only "solves a stronger threat model." For example, you could
construct something called "AES-129" that you could argue is "more
secure" than AES-128, but since nobody's threat model has attackers
that can break 128-bit keys but not 129-bit keys, we don't use it. I
try to apply this reasoning to everything I build: all security
features trade-off against performance, usability, and compatibility,
and I strive to justify these trade-offs with whatever specific
threats that they resolve.

On Fri, Aug 15, 2025 at 11:04=E2=80=AFAM Jarkko Sakkinen <jarkko.sakkinen@i=
ki.fi> wrote:

> I'm happy to make patch next week for this change too. So probably this
> where I align myself to. It's just the best average IMHO. Everyone gets
> exactly what they want, right?

To be clear: I already have what I want (the ability to disable this
feature because it seems broken to me), I'm just making
recommendations as a TPM abyssal domain expert. I hope my feedback is
of some use on this -- the work of dealing with interposer attackers
is quite important and I appreciate the effort already put in by the
team.

Thanks
Chris

