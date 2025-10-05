Return-Path: <linux-integrity+bounces-7371-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D584ABB9AAD
	for <lists+linux-integrity@lfdr.de>; Sun, 05 Oct 2025 20:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9040F3A8D92
	for <lists+linux-integrity@lfdr.de>; Sun,  5 Oct 2025 18:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E352C1C8629;
	Sun,  5 Oct 2025 18:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Q4/nDrPZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A561C9DE5
	for <linux-integrity@vger.kernel.org>; Sun,  5 Oct 2025 18:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759687770; cv=none; b=BkOE4ErU8WrsuDo2Ca+hJFR1GPEf7MqY5vGi1OMWzxXHb2XbNqjbvb3lT9zsno2xc2uVuW210cghYcb2BDdLp7YxGPStVbZIt9HIt+lNtQm6kZOY6G1jTUYkB8Adh/DTYbsTi14xKqGkj6X3r0qHB57CFQuxODrZ8ucV/ZJbn3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759687770; c=relaxed/simple;
	bh=camg0iKThq865GJUn9nyBstkvg6jbOfG+xY6ZZ721ko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aqHerkRXV26HYSLa4TK1OWAGkIuchAIifjzzvDsmv0D6P9a1L3tmv5D1sN4DofOIh6LIiQRvkW37K1zXfPtrIxLDA8e0mzq5MeLb5GqQNB1nG4OzXKDbJOexVbIOP/ghxiFXJip7IW7F+rS71onMMINwICGUG0TH5WAxpWiluYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Q4/nDrPZ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6395172532fso4534580a12.0
        for <linux-integrity@vger.kernel.org>; Sun, 05 Oct 2025 11:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759687767; x=1760292567; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HywiWrZnA2plSPoOMy05VizUC7aDffpgiwOCnh4rnRA=;
        b=Q4/nDrPZi79ONAUCXtEC5rHyuOdjAGZf8eoRnKBoIr85sNxINNXrE++MgQlaUKbFNV
         AJ5EQ2vgqt3yP/T68vwVqaDfHdm6prEUHlWz5jWEvaWAfIHLevxQNljjEr/18FmRQ9U5
         EEZKQ5hAGCGcYqKmakWeDpRzbxPqB7M0kk33w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759687767; x=1760292567;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HywiWrZnA2plSPoOMy05VizUC7aDffpgiwOCnh4rnRA=;
        b=JjpvXDUBq+xuY9MTIKJai6btjmBI2bKiww7FlFBrHJtRo/al4MEZ2D0Y9q/FdfC7XD
         yHuB0eybwe0amH4qydAr0zkD54LG6xs959SvCGVJzA/AoTrT3LzQj2DtGXpHzXlFmrOX
         kSdXAReStWO0WeiqeYUsbSTU5GITKfJyqjOqckDRKm8FxDv/hN+1vSp/B00Eupok0feM
         qiihy1oMbjsbVOmApS7f2H9iKb1a5BABThcHdN6FMbxpWaIuzXAxOpJcT/CPwvP8m93t
         bPcurID9YmeAx7VMxM3GpA0npQRze4Xs3FYS8ta81LT24ySo+Ei23QCQpI2PTISxVPQV
         /x0A==
X-Forwarded-Encrypted: i=1; AJvYcCUni9MwTmfRfTSdK1e+xDG13mAmUv6m6QMkHFfLjSF0v7zXp4JYz1LKH6otlPm5VqwYt9CY1a2hx7pf9NrGPOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD6yXI6/Rhw9wLDBMgouGLTOwdnx2S9O1mBEeuQza3wxjd2NGU
	z7z/I6a0+2webHUgpGNND8HdvnoQrupIsjtR1NlhTzsKNY4aTDEmO4678AwotTcFBuDRB+ChT9n
	FbzSrmug=
X-Gm-Gg: ASbGncuW+LLhzKPoAl2W5uTBXTS/a0+Tpig72WkBZJqivjRLxpcifsXusijRCL1UuIb
	v7FVzV4zahBiDm9c01KoKuj5dVMDeMuWo7QjdWy4pTnSK9RoFlGqrYMMSOltjXPbEfXYfELGaaS
	r8dAkXAYmIwrZ7dFLubCzFMUjQbByCzwkQ84kFPsuaC/iigx3PUXk/KImV2y5UlNT+xZOeSgHxu
	64KIrrjylIUGDGUYNZJpBf4IMQgiHK0cJ1JNY+U8CwUnipLibHyDVwlCuthbjLq0lDPxeEaHunh
	HIhT1Wu6asvCEs+BVH3tm/rdAqSWWfQNmFKJotkiGpxSwAEfnx14YGZFm+/ahGT51JLKkPRQ2Od
	daoLWIQk5q4VBn5nrfKyAyR6CuRR6zcuhZjvn3bDaAy6x7MVdGO6Y3Qavi1W0fB3/mZpwlXJBIq
	c9w2JVqYxKk8YeyyI3ZFQh
X-Google-Smtp-Source: AGHT+IEFckXxlmfz/Lc4k6geqj+EDlVsbGvejlrzH0r8mwLiKICMHfx1dgVwpoxBOvy29jaNNvRefQ==
X-Received: by 2002:a05:6402:4306:b0:637:dfb1:33a8 with SMTP id 4fb4d7f45d1cf-639346c8053mr11947942a12.3.1759687766867;
        Sun, 05 Oct 2025 11:09:26 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63788111e1dsm8412445a12.40.2025.10.05.11.09.24
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Oct 2025 11:09:25 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb7a16441so669902666b.2
        for <linux-integrity@vger.kernel.org>; Sun, 05 Oct 2025 11:09:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX9WVvCGoIId3wfR5dwQ5PCYDsFxcCPrk2Wq4nGsCxnPPspipSVAy79zuc9RyLaz+BG+rwQrJrT67ATekmRDik=@vger.kernel.org
X-Received: by 2002:a17:906:d542:b0:b48:44bc:44d5 with SMTP id
 a640c23a62f3a-b49c407909cmr1225542266b.43.1759687764580; Sun, 05 Oct 2025
 11:09:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aOKTFv1vh1cvvcLk@kernel.org>
In-Reply-To: <aOKTFv1vh1cvvcLk@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 5 Oct 2025 11:09:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiCWiDcLEE3YqQo78piVHpwY2iXFW--6FbmFAURtor2+w@mail.gmail.com>
X-Gm-Features: AS18NWBEWs0_aNhsaDpKimWKOjw3bWPdM4hwd_m5NImN1ornADwAqfSmAg4O0Zc
Message-ID: <CAHk-=wiCWiDcLEE3YqQo78piVHpwY2iXFW--6FbmFAURtor2+w@mail.gmail.com>
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-v6.18
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, 
	keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 5 Oct 2025 at 08:47, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
>      This pull request disables
> TCG_TPM2_HMAC from the default configuration as it does not perform well
> enough [1].
>
> [1] https://lore.kernel.org/linux-integrity/20250825203223.629515-1-jarkko@kernel.org/

This link is entirely useless, and doesn't explain what the problem
was and *why* TPM2_TCG_HMAC shouldn't be on by default.

I think a much better link is

   https://lore.kernel.org/linux-integrity/20250814162252.3504279-1-cfenn@google.com/

which talks about the problems that TPM2_TCG_HMAC causes.

Which weren't just about "not performing well enough", but actually
about how it breaks TPM entirely for some cases.

              Linus

