Return-Path: <linux-integrity+bounces-6874-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B19FB2B164
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Aug 2025 21:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58A661B21645
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Aug 2025 19:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3BE3451A5;
	Mon, 18 Aug 2025 19:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FOZx8phq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ADF3451B3
	for <linux-integrity@vger.kernel.org>; Mon, 18 Aug 2025 19:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755544339; cv=none; b=bN33J3LqEmWjohd9ZZVTzHwyQ2G816HqTVVWijfcskGWuep+IX4WR5upn6qKWnLiEijy3GhKc7nyhET3GMtASO+2o981s2GSUchqzY41bxf+5m96pf9Yl+9Ix8Fnn/bndgNEwgnk1A+LD3baTlsxrfCdmgB6ohl379f/qOUqEoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755544339; c=relaxed/simple;
	bh=bUaU8wwI0UwWqzwGVbLN8E8vy6BQTe1SFYXNisbxnE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QsaSdfaasEaeeFB8M+1c6WKvl8Pe8iCFMfh6sIJuf0cVWwqxvWJVsvDoOG2ENZjX8t3RtCZxtHDndWUSYXdD8yiGPOiN/wV5Olx3Yv67PBLbktg7+kVQjNXD6yI2OxHB1/hgdP55uUtBCdjbulkiy9MTDCHKpIBKcHo1Q24KanY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FOZx8phq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755544336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bUaU8wwI0UwWqzwGVbLN8E8vy6BQTe1SFYXNisbxnE0=;
	b=FOZx8phqRFb3AbWplMiuHgjl3chKtibviGr71OCxlwNlroJielKuW1janGKfS6BAyO392W
	KyR35+b9/E105qJ4OK3C4wEBTegSXw48YmmzN1t0DH+1Wl+GRUioSb07atC0sd564chcoD
	MPGyOJbBSuV3AvZ6gAFKEvqI/WkFOkg=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-KXmGYgjhN4euFWd7do283Q-1; Mon, 18 Aug 2025 15:12:14 -0400
X-MC-Unique: KXmGYgjhN4euFWd7do283Q-1
X-Mimecast-MFC-AGG-ID: KXmGYgjhN4euFWd7do283Q_1755544334
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-71d604dcc4dso64503537b3.2
        for <linux-integrity@vger.kernel.org>; Mon, 18 Aug 2025 12:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755544334; x=1756149134;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bUaU8wwI0UwWqzwGVbLN8E8vy6BQTe1SFYXNisbxnE0=;
        b=PbTcyESteJAm8ayfFHI1I67mAUjI0fNcm21SSdk9+TaEDJiG50LTLf2hiBorIFkyVW
         DfQuJ0QBd/xu3RzwrdZN4U8+nQuUbe4U3ChV855X2D0LwZHFI4umf4Y8jqr1c6j9SK3Z
         eM8GEEujeJF/eorTsCqiHWbWAiayTwvDh7ZP2njA2z9ABHcVlZ/gFC0zjSnVAsSTaIFE
         AjRvBSoFIi8QGLfCDtxanaGgw7hJtJe/zNFb7nVnN/AnecrWuM3nFJmjrGKNHxJSbvLM
         8XUOKhrmCvQ2zNYrd9aIaI5CyCKrVDw1daPprrJR5mTRiZUrNs80vSiMy5u9Pgg3BEuV
         9ddw==
X-Forwarded-Encrypted: i=1; AJvYcCVQa3Sfcld/2FXjf9GoAUpNN18SK31U8xPs7EA1KNClSLS9/pn0i+TNs+IRWTF/RlXZrdW81svWjBxT9Bk0f7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7eojEYZc2Boyp2rF1lmalGOtPOZX8yg8DciVPfta0BIUFU8XW
	vEyx3hQiMnnZaydW9nvJZVBs6MdijKK67k7k8Z1QnjqkjcvoxRLG+xJVAUBqu6p6YZrKQ4xTPQh
	huY7OU4ZKG5R6EXEaLUgkVH23tLgdFKLzRlae4hdLlnRjQwfb/YGuHet5FbHezvop76cu0+g7Ev
	O/5u3Fn4AK4gyM5Ajiy0phtiHuvS9BNaR4UetDHSXwkKrm2TzzFJiL
X-Gm-Gg: ASbGnctmlZry3jj1u/rWNjelETStuvFfn4ZF9WZNg4wccdfCdyiOVc1rzQnI/CENIac
	a02plW8d/ZKgVYXvxOQeJeDxlBBhAkxhQ5rhRJLFqCjCclAsTRS4eAnQgWkVEmyVcicHh36eFpc
	Pc3DygCl4D+8yLTDPzDZhMeQ==
X-Received: by 2002:a05:690c:3609:b0:719:e1d0:4b6c with SMTP id 00721157ae682-71e6d90d3b0mr160256887b3.0.1755544333864;
        Mon, 18 Aug 2025 12:12:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElqlASQEBzjKMb5lQhyMDjT8PSQ3glox+hfjM+8tCp87kGc5HNcszd1qa4dqObklYHs4vyTiJb0gkilR+3iQ8=
X-Received: by 2002:a05:690c:3609:b0:719:e1d0:4b6c with SMTP id
 00721157ae682-71e6d90d3b0mr160256567b3.0.1755544333551; Mon, 18 Aug 2025
 12:12:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702202851.33344-1-daleksan@redhat.com> <aGW2wabMXtdBEQxR@kernel.org>
 <CAG+gbFfKLCQND-TT8DEZ09T=Nhb39_CJfM5imv341Pen03bHjw@mail.gmail.com>
 <CAG+gbFfLP1Y=HgRfzjhT4uJ121keQ0ZKo=4saB3uqnZYyoV8JA@mail.gmail.com>
 <CAG+gbFcgfZALHCAxaMmWkNQX2sKgkc-HBJrYXdmehsqLidG_tA@mail.gmail.com> <aKNlck45-FF_p40t@kernel.org>
In-Reply-To: <aKNlck45-FF_p40t@kernel.org>
From: Denis Aleksandrov <daleksan@redhat.com>
Date: Mon, 18 Aug 2025 15:12:02 -0400
X-Gm-Features: Ac12FXz8nQ-IWdrXBWBowgfdmo_8dymo5ih5nGM93UqyACVf22_KIHkuo5BeOwI
Message-ID: <CAG+gbFe07nngs2-2iifeK7usAEo3C07NuSsQU7jVpps0m-3RzA@mail.gmail.com>
Subject: Re: [PATCH] tpm: prevents local DOS via tpm/tpm0/ppi/*operations
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org, 
	Jan Stancek <jstancek@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hi Jarkko,

Thanks for the detailed review. I will update the fix, test it,
and send over a v2.

Hoping to get that over to you this week or early next.

Best,
Denis

P.S.
Would you like the v2 in a new thread, or keep it here?


