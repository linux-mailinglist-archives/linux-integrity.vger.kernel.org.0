Return-Path: <linux-integrity+bounces-2956-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F9491E574
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2024 18:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 343B6286918
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2024 16:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E5416DC0B;
	Mon,  1 Jul 2024 16:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c1Co9JUr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802D516D9C9
	for <linux-integrity@vger.kernel.org>; Mon,  1 Jul 2024 16:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719851755; cv=none; b=uEybizFYyG3Cd0pkx1vC5iQyx13y5AzrqdQeq/k6QFTNEwvtY7IYABLYiHXXEeuwEg7KJ6Uav1op4xKjB6x0TS8ZGTO+oozS7M0ZyFB+GgkLmxq1MH1/uUietTZD2rH1idY3OeawPuv84nbs1BYjnCZLWfswoaNjqKrwJWlN09E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719851755; c=relaxed/simple;
	bh=YLGmbdUVgoClE4zgm/y2rPqET0D9fHrQj2RcTVt3beo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RALTIg11Ig1faTp17TMF+/f3Rzl6ATyPn7nJ5oeL9jDty9PKeW7MYMmfxWKnyKue2TnZqYNW53vF3yFYeQujXCbCojR/YzkpuqNaflGkq/i+Muz238AWILk3ANm5Ja8bfTlzv/+r8xv2NBCvW//8rsOvIC9Hy3bHLpghjoXKit0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=c1Co9JUr; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57d457357easo662078a12.3
        for <linux-integrity@vger.kernel.org>; Mon, 01 Jul 2024 09:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719851751; x=1720456551; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Obs6N/BH5UkcS/x22yz2VPLEj/fFFqodHfDKGoUVc5k=;
        b=c1Co9JUr+HB6MCmUUPKirkZ8BfbYQjSUuD0EEZgh18HcFSLrEL7cSJzKWPZlfRyzic
         IkeLSInNvZTSvecK+eTrGa87BDWQKdgBnOqaynPjJ1zK67PGaXFFLMXj7OWLDtqJCPkE
         lHdxKeZr+cYTLccWT0jotNxDly6DgR34x0HP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719851751; x=1720456551;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Obs6N/BH5UkcS/x22yz2VPLEj/fFFqodHfDKGoUVc5k=;
        b=Od7CDdy2VzQReIKbXz9SVp8n9Zizv8jmGx9zmOI0vQI4fQxt7E1ObPYX+sP3e3vMIX
         Ix+CQzKVi+5mc2zfrUHcZeTWf6zX4t+SKFxZATx/KbQrIVSl+Hr/MhrJHvZnizapBC9u
         If801An6fXPM1JGbxkqqGVrZE2apedejJeHC2KMAGnAqWhBw45RKGHCS+kSe6kWZWcrF
         9PkOe2GQEFJcW3NqPmSX4xi2GqaJCnxgUTesAhyWHiKaqsKUNrU4U5zUhnBpRsMtCuSv
         58dWtMrzCcoXgf0j7+Hf4Gzu2qHUjsOpAwzbSd4R3EtvQvktzOpW4l56x1zcYs0h617Y
         R14w==
X-Forwarded-Encrypted: i=1; AJvYcCWeJgDMQKXK7M640EJKuHNNmMbLUXrrQWfmO5Il7wBih3WrVE18MYmro9zkEiw4xGudWE68s6/4evxYeBH39TJkPINiabLEwRaqlqB08ngB
X-Gm-Message-State: AOJu0YyQfG+cqTJuMqlOzPU7tC+YiXiySpKYLnT8Co0p3KvkCjNfA2vl
	O/64VwJ3a6UzZXt+ay624JVENnUh0svVW52Zc1XR0RaeYqmxCbOBk+xYHuZuM34JcPP02+fjdgj
	vl40Zrg==
X-Google-Smtp-Source: AGHT+IHKNpEgFFGZvVAEEOmnSN2OFA4Y+k4JF8AbBEM2L40wiWhpGFcybofuQvNFjwHULauwpUe3UQ==
X-Received: by 2002:a17:907:868c:b0:a6f:63c7:3083 with SMTP id a640c23a62f3a-a751441f03bmr500804166b.13.1719851751703;
        Mon, 01 Jul 2024 09:35:51 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72b5abddaesm295358766b.140.2024.07.01.09.35.50
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 09:35:50 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a724440f597so393881066b.0
        for <linux-integrity@vger.kernel.org>; Mon, 01 Jul 2024 09:35:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXMttqPfRg3k4XEKRJKghVT0QHlKvDcZC3RDuXqWPmCjJ53LndA++aiclBrmElF/I/HXpugVa1FxYHQhhh9yd5Oj/C2iVRx04HSYcWpK2q8
X-Received: by 2002:a17:907:724c:b0:a6f:5698:ab5b with SMTP id
 a640c23a62f3a-a751441edbcmr548618366b.8.1719851750079; Mon, 01 Jul 2024
 09:35:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <D2EBML829ZJI.1XZZVLVGUXRBH@kernel.org>
In-Reply-To: <D2EBML829ZJI.1XZZVLVGUXRBH@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 1 Jul 2024 09:35:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjYe22cLAF=LmZwRu3VOf80LO6XdsdYt3Lhb_TEJ0XnPA@mail.gmail.com>
Message-ID: <CAHk-=wjYe22cLAF=LmZwRu3VOf80LO6XdsdYt3Lhb_TEJ0XnPA@mail.gmail.com>
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.11-rc1
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, 
	keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Jul 2024 at 08:51, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> Contains couple of bug fixes.

This - and your keys pull - say 6.11-rc1 (and say "next"), but don't
really look like the usual merge window stuff.

Just checking.

            Linus

