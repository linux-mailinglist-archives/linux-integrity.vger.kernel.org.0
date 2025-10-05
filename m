Return-Path: <linux-integrity+bounces-7372-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5962EBB9AC6
	for <lists+linux-integrity@lfdr.de>; Sun, 05 Oct 2025 20:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 047AB346BC3
	for <lists+linux-integrity@lfdr.de>; Sun,  5 Oct 2025 18:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D3319C553;
	Sun,  5 Oct 2025 18:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HdVtMv9e"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38971C9DE5
	for <linux-integrity@vger.kernel.org>; Sun,  5 Oct 2025 18:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759688670; cv=none; b=pCJYoOD7HXA6T/7e1y53CXwVdI5B+nr/pKsO1bsPr6/4SDSdkNZUE/znubUowXBVXJancZdSqOsM3USLNA6hZlN4vGXyExxvwEjGlGT0NumPWvlI/USmkbgxJLsSsTb5jxTKz/MpdqF6joUruVYMjvI2bBe5wBbVCErPApsN0jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759688670; c=relaxed/simple;
	bh=9WjzuHBdxag7kq4Nilmq5RRZAta4IJxqsLveY2PxQo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1EFu2ddbCkGx7EacY4r4h98hEjm1iM6vbz2dXC4Qx2QvLNNdz9SpaVAOfifbzc74XFtczYMcm+q4vt7P5pYlEmw5wJs+u4a0/pLFbS+tWm/OLYbMECP8gmNuDSn4mPOVbBcbbV4t1fVySEebw924NVkZ1Im4EpnMH0WcZkVbbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HdVtMv9e; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-631787faf35so7661796a12.3
        for <linux-integrity@vger.kernel.org>; Sun, 05 Oct 2025 11:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759688667; x=1760293467; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wpo9TLVZT45BbNVhzNvMd0DcfN1QJDQZVUcsc3h68LA=;
        b=HdVtMv9euE5/0U9sLNVF2gbuHojkZQUPZ2Zn5x66STinIEleYV+KCxEvarbXnNvndS
         z88RVvXvriz0jXTccZqGo0YbL4NH3yd45X1otzxnwxacVGqM+ghAsCpK75QJAn09FqqI
         q1B5zC801UfJby3fT9gAzGUJnyLWJn1IGfsbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759688667; x=1760293467;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wpo9TLVZT45BbNVhzNvMd0DcfN1QJDQZVUcsc3h68LA=;
        b=PHvlt24kTJCbHpMsyPvZc34NuKMLU6Pfghj51MQZ+hFfZeSHS/eGNFbtve/iN6bshX
         u5KZdnqhfX0vVMYuwvMKierS8HRHElE5MbVF2Fqvxg4B9Sy86XEPvFeGR3bL6mCvG5SE
         kPQvjKWAJys4fSIS+T87X+/J1kRhXmZAdU5stDHPFa82Qg+SR+j2DOuAxloUYiI57Igi
         YMPhm74W5cxeGwQdtkQP3dVbj5lxVAFzWRe6XUBMxUQFTNv3/gYNGRjbw8Sg2cCd8ueT
         fNkz+oT/PNH3EcmihlNkmWFr8mfh+YUE1uQYsdfDiLkCBoD8pphmE/qDQwy3OvWzjvNZ
         3RPw==
X-Forwarded-Encrypted: i=1; AJvYcCV2mVbnE0I6ldjj0qrcLLwTZFTv8wjt/+YY+JbNhwaUWDtH1NZ1eDLfJH1FDk6vjhlIrX5UXsKP7JFu+yLsxdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx8VV8aqbMDMLZ1LGvHH7oCimtlFUGzLEdLDI96WAiWDo4R9NB
	57v0rtFkFaYDTqStMR3ueJur5SynfFcIduzoSLQUF8njyCAgp03ltZVUy0vAJfJiGzsF/+Wh1UJ
	7ZRBpaSU=
X-Gm-Gg: ASbGncvoT+b0+V3aaANngC7wkaquLflmMj8TlOmbC2qjftqhfjA2vJVO3pOUD4WMzOI
	lADsQQ/47n1Nh43Z0Pd0968DuNTlpU8xl06E4W+iqO3qqEEQ3FR4mbWoh58K+hm7gM/3N94hwgR
	kTHh8aUyLvpe0A7vTHHk1DatjFankoHYfdZgdRVF4lRh48agWE45BwSdlA6kMdOuivTA35iU9SZ
	+rwpRO82s6crdMi4wHnE7Om6AVuLft6fKfjSwnUl1oV8LzHRolwcTx+askZLlbpDuYwev5bry/Z
	0a4n6KkPv2J2tEcghEWNticm3RdtFIKGbmejn5CylfV+jO6wW9JsKYp71SiLiI6eeqMEf8Udupz
	H/x7fxbNo9pW/gD39LsNjOOZP9Q7K5wYdsh5y7EOPymtcMb4VWetBOJeehllEnolzssHcYqP4yV
	MYg1Nq5DCKNN1TcH3qARz8Yhfv1DsPokA=
X-Google-Smtp-Source: AGHT+IEZbnJcne+NjgFb8eKj3/VzvKW+9nLQSdBxelxtc0LBnBGRTgooVdhpXVoHitU54F/HvwqfTw==
X-Received: by 2002:a05:6402:5191:b0:633:7017:fcbc with SMTP id 4fb4d7f45d1cf-639348f1c5emr10905203a12.15.1759688666873;
        Sun, 05 Oct 2025 11:24:26 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6376b3ab692sm8418610a12.6.2025.10.05.11.24.25
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Oct 2025 11:24:26 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb7a16441so671188066b.2
        for <linux-integrity@vger.kernel.org>; Sun, 05 Oct 2025 11:24:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZE27Bog+dkmKB2ffhFKQOJCv8VxtRfxOQbhTCISQYObav0uxgMzSG2Iw1pvyUe2tU/B4NYkR8CO9Foi6zdD8=@vger.kernel.org
X-Received: by 2002:a17:907:2da6:b0:b3e:ac8a:b1e1 with SMTP id
 a640c23a62f3a-b49c27518demr1450075066b.27.1759688665152; Sun, 05 Oct 2025
 11:24:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aOKTFv1vh1cvvcLk@kernel.org>
In-Reply-To: <aOKTFv1vh1cvvcLk@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 5 Oct 2025 11:24:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whSe9AGigVydkwo=ewE6_GFTJ_rU=XzO=v1N1sWyfVmAw@mail.gmail.com>
X-Gm-Features: AS18NWBWjtRNMqiFhMnbqxI4QyLpCSEY68UKMaGvljy0AnFZ4D7Y6Tta1dBrPrw
Message-ID: <CAHk-=whSe9AGigVydkwo=ewE6_GFTJ_rU=XzO=v1N1sWyfVmAw@mail.gmail.com>
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-v6.18
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, 
	keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 5 Oct 2025 at 08:47, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> and apologies for this late pull request. This pull request disables
> TCG_TPM2_HMAC from the default configuration as it does not perform well
> enough

So having looked more at this, not only does it disable that
TCG_TPM2_HMAC, it does a lot of other things too.

I really am going to require a better pull request, and I have thrown
this one away.

The exclusive access looks debatable to me too. I think you should
also require that the open was done not only with O_EXCL, but as a
write too.

Exclusive reads do not make sense.

Now, I certainly *hope* that nobody has /dev/tmp being world-readable,
so it probably doesn't matter, but that new exclusive access thing is
very different than what the code used to do, and if I read it
correctly it will also disable the kernel doing certain operations. So
it needs to be as limited as possible.

And damn it, it needs to be *explained*. Not have a pull request where
one single line is explained badly.

             Linus

