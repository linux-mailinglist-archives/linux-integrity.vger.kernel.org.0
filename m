Return-Path: <linux-integrity+bounces-6862-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B13B9B284A7
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 19:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 697803B42B1
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 17:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1621309DAB;
	Fri, 15 Aug 2025 17:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MMWR2raD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417FE257844
	for <linux-integrity@vger.kernel.org>; Fri, 15 Aug 2025 17:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755277612; cv=none; b=I8fXHCbgEcB4hRpdfaX0PMY1iD/Dufz/KpYvtKFqIIuC8lM3aaYH/G+uvE8KrJ5j6qvXX4z0/07WbjJpVBC3h6Fo18gr5rLZHAaqjnXVZmO1s54ptRGFUQRXoP4fgq+3wxw/6OjcDYM4QUpt08KBwQf/oDv3+S2Ytt2qNaEvtx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755277612; c=relaxed/simple;
	bh=pL+KIUNonL6GieFzGfDFgPzMGRCJoSc59aGwIdQvhhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f8Q9EUQ5uD1U62FlxKR+yrPVbn+8Wny87EucSSjr/L5AmUxaSuHF7FxH4xiF2HW/m3qSw5uwtc5HJBH+PtPxwmP3oU1bljLNHjLe3DtJP6ovjbkpdu2S1D6cAZ9xjcPUh8AmbPoM919jpJc9YTRhFbK2Vj0RU3TnoqtaoWgTF/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MMWR2raD; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55ce52ab898so2541285e87.3
        for <linux-integrity@vger.kernel.org>; Fri, 15 Aug 2025 10:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755277609; x=1755882409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pL+KIUNonL6GieFzGfDFgPzMGRCJoSc59aGwIdQvhhI=;
        b=MMWR2raDt4u+TmwPN8wEaVMqxqOCGxkpfm6MXN5C6iA3BEaDeNf1Tw1CaAtuft3ip7
         OsmbrRSipsgp5WakIZzZsiZkVkvLNO+PrI5U2EJuuNz1um1yBj+n7V4mM5tSeP5rnI3j
         eil/VT76nW1i5qVVsk0/OjLuhnZ3fM3/oSusc+ZMpyYYLJtvFTj3XON39jwfSva+RRjA
         OXNHyCSSJfVQo6UOW7orvZW7OUKliCM7RDQz1PmNxx/0juR/ryFGSIiOShq7PAuEpHRb
         /v1bo/SlxsqDWU54QqZxHtsrGH/twsQeCLmnAEAD4spRmRzeteWYUAsgKx3MF+lYL9HN
         yHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755277609; x=1755882409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pL+KIUNonL6GieFzGfDFgPzMGRCJoSc59aGwIdQvhhI=;
        b=HPklM8E92mwgZUKWcGRt1jgJqT4lXzefCtKGliKAWaFtPTp8HT80Wd82yaVKHeHJNE
         J75YBke7jxtaADrwGMyerID4HUzluHtLC9CRL4UyKbQ/LB1JyOsqoLmcipu5FM7IT+O9
         DReG3rOLHjj+X+mBJXehJZHSX9tLgigHYiDnFdovic6+wAEGc+P48wW23UDCnqglu+3Y
         KIaCYdod8O4WSixOrcuNi8oIV5+26Jr+eRWJBAb64vwsohu2wy1JXLMK/ESmAo4Vuw1j
         vStX9EaHkK1uCNPuA3jkJS5q/TAykyU4iv13rmev1uhP/x1+zYKgIcTMZmzPVvm8EO2a
         Aqmg==
X-Forwarded-Encrypted: i=1; AJvYcCUVOzm4JMsNrosD/aqSO5kswp4uvJwIJFZeBGvj68cu2ztVUtfhRB+DtuvqqvahuFOo/9AZgk86qpMbQWnvxTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzZp6mTyom5Qb7Kmkje++tLxXbeSSmOI54Sb1wZB3IHkGrjUuF
	Pz3LmKu9yFJ1z2TROYqu00RXT+A3WnC0WEUE5+PdAyvt9FSB0LY0YA0KhhhVeS/GhzHgNM7iqr5
	oCgSYohfeo1zZ0kn/08mCS3EOrw8i3/6H36Wk49u7
X-Gm-Gg: ASbGncvngREgOvhX5RYu8x3lye6C+p0yjqZ72JEPxm3/f+ch9ik4yvZtnq+a3WYIzOH
	oBCck8307WBggkvkl3OU2AMg1a3A27ip2NUcpCDjr3VuByXyKl2E9+hUC6kGdXpPtzYKQ8GEbzD
	s5j0cnk7FLf/qe8xLiYjqFxwknOrCTyHvk5nLovdq/tMNM4P3fM4OHU+dui/wev59T89YDVfrXV
	6xs3gCa03qO
X-Google-Smtp-Source: AGHT+IE00vYYh6yZ2ovM5beTH+9/5iG2gqMZLSk5Mk9qR//MtgKHHWRi+VX3T8bpUsXQfN41PGgiSv5Jgv9nB4pa/qE=
X-Received: by 2002:a05:6512:3b09:b0:55c:bfee:d959 with SMTP id
 2adb3069b0e04-55ceeb8e4a2mr645923e87.55.1755277609209; Fri, 15 Aug 2025
 10:06:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814162252.3504279-1-cfenn@google.com> <aJ8iNLwlf4PAC0h1@kernel.org>
 <CAMigqh1RTVzz0ffY8M3mZuc7NDaBKpMmCU4q0LuNyM2eAi+NFg@mail.gmail.com> <aJ9fy_sO6tza9qLF@iki.fi>
In-Reply-To: <aJ9fy_sO6tza9qLF@iki.fi>
From: Chris Fenner <cfenn@google.com>
Date: Fri, 15 Aug 2025 10:06:36 -0700
X-Gm-Features: Ac12FXxi9rDKgCbCPcDjkhN0YzfqTpcE1IQTDtiiLTRyzFymdSe7ALv45u7gK3M
Message-ID: <CAMigqh2=Kmnv_rrT-gBtESSXtnMrxU=VJdrYE6_9NGhKBN+ZrA@mail.gmail.com>
Subject: Re: [PATCH] tpm: Disable TCG_TPM2_HMAC by default
To: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 9:27=E2=80=AFAM Jarkko Sakkinen <jarkko.sakkinen@ik=
i.fi> wrote:

> I'll with shoot another proposal. Let's delete null primary creation
> code and add a parameter 'tpm.integrity_handle', which will refers to
> persistent primary handle:

I'm not yet sure I understand which handle you mean, or what you're
proposing to do with it. Could you elaborate?

Thanks
Chris

