Return-Path: <linux-integrity+bounces-6812-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E6EB24A62
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Aug 2025 15:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F26B27251BF
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Aug 2025 13:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A021185B67;
	Wed, 13 Aug 2025 13:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ElUmFgYD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6BB2E54C4
	for <linux-integrity@vger.kernel.org>; Wed, 13 Aug 2025 13:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755090815; cv=none; b=C1JJSXhPyJ3xQhTQQwqdg8490I9cj2ATp2ZcNOmFOMiun/0Ceu1d+5AwpznlpAhwYqOxN/CSkq9f3i3UQOwgFt6WOn/HY0REjI026C8+IVAP1uujH1Xzy/GqAt6CgazyNXim7As57s8WEuZ+xxDV+jP1/cJAqFBLlyLhHNmbLj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755090815; c=relaxed/simple;
	bh=fyeMUZY6ThtsOTcXmCjqYAf3UNQaZ6/KR+1iKKM0Lk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nyLEvs6nc/l02y6kHoWNao0FmWWy7/ZVIBl5FtR/v+juav5/fnz/W/5MdByHyObdER9qJp+Cbj2viyMZ4eHw1249glCIWs3DcZWWQgd4RBkJ6FCPHW2r5LheEa1JMUdoQLw/V8DRqt7fSoCDYlMhI/Dc3OEs2Ruh64QnHDuXonY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ElUmFgYD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755090812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fyeMUZY6ThtsOTcXmCjqYAf3UNQaZ6/KR+1iKKM0Lk0=;
	b=ElUmFgYDVVxNzM3gQ3045ktqJFF1kUN0DyAeTMAfUAbk/pynaTosRwqsJM8orM5QuxCW+i
	cHDqeE8whx5qmzFlpGmu/PBCfxtTD4A63xhjX7QgmIr4G6EV+hK0c1moO72BQwsC05nlfY
	ktZRwomBeBUz3zFfD4DTgIlbQtWdkUI=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-wZsqf6eaM8-CI1Oa628_YA-1; Wed, 13 Aug 2025 09:13:31 -0400
X-MC-Unique: wZsqf6eaM8-CI1Oa628_YA-1
X-Mimecast-MFC-AGG-ID: wZsqf6eaM8-CI1Oa628_YA_1755090811
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-70e4bd6510eso105999527b3.0
        for <linux-integrity@vger.kernel.org>; Wed, 13 Aug 2025 06:13:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755090811; x=1755695611;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fyeMUZY6ThtsOTcXmCjqYAf3UNQaZ6/KR+1iKKM0Lk0=;
        b=MZJI054HTaUQUla51dZyjJ5YzNg5KZXLrl90LWxWLmp264sQWU1eJZeov1/FNexodm
         8+40mU9xYutEZ7WMNvXwrBvrB6rd+BW806uz8FansUlf36aLC7T+uS7FzLWP1fELBGFV
         c8WmcWEp9pwx8dtNYPzfqe8Oeexm3LZUJ8nRrgUeoQVIhb2XBlEwL6AneqWc9Rd0FtPa
         rYm5AEsdEGu9gxqXYOW+ZIO4LRLwN5JEXVr90qgoVnYXRQWACcYZ57QbE+dqJsFV9c2P
         15n9SkTyJrf6PJgBl1rO2jfEYlnb2XMEp0gi5DNSpZSDadqjvBtAtKZz/55yZH3w1ALS
         IbEA==
X-Forwarded-Encrypted: i=1; AJvYcCWmMzPFhwDsh/sXfPIw54JXKDWXufq9/oaiaqLbUscAu7tR5xZIHeG/TnigQ4nKa1Zc4bJ48e7bfuFiXR1bJMY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Lx8BeJu1QSxcV3fXP+UE1eczEyECqj7m8kgbT8ROeZRcMVZ1
	ze9OU7ThoUPOSSU7hKP7tbHUK+VFL4qOEaWqp/62U6vLxQNmPjZpOcd68GXVCOUTns5Y3iaIkY8
	MMNi8Iw9LvCu2pcTUnGJXXxvmzEJE9HRPjksMxA3fbENyB+fkiGH1wp1UIm0hjAyixehlvhHtOP
	9eOU649pSyqA1rvx4TINv/8tOvN1h8nmJEg8c0jXzyokPr/PvLlyrS
X-Gm-Gg: ASbGnctNqSvXCZYIK+7QSFtZi0RqS/qKPezS5DMj0Z5eUEQy36dqakdQSbRtRdF7PZK
	ZdjkuBu15XsvdvOlfw/LrZgOPFmX8D+we6yqT88Orfr0U6lAGjj8oexly5seiZEU7ohoR5OzFTg
	zINMpktlDszYmpdsNvsmXezg==
X-Received: by 2002:a05:690c:610d:b0:719:dbb5:e76a with SMTP id 00721157ae682-71d4e5e850amr32820357b3.42.1755090810624;
        Wed, 13 Aug 2025 06:13:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1i80xSvH/QGRIDndzqqz+XrV2XmMvLR1XR52wn6UhfOsA5U0w0Rq3qMOEIQ+wyAps1CD2wVv7IoPovA8RSfQ=
X-Received: by 2002:a05:690c:610d:b0:719:dbb5:e76a with SMTP id
 00721157ae682-71d4e5e850amr32819697b3.42.1755090809881; Wed, 13 Aug 2025
 06:13:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702202851.33344-1-daleksan@redhat.com> <aGW2wabMXtdBEQxR@kernel.org>
 <CAG+gbFfKLCQND-TT8DEZ09T=Nhb39_CJfM5imv341Pen03bHjw@mail.gmail.com>
 <CAG+gbFfLP1Y=HgRfzjhT4uJ121keQ0ZKo=4saB3uqnZYyoV8JA@mail.gmail.com>
 <CAG+gbFcgfZALHCAxaMmWkNQX2sKgkc-HBJrYXdmehsqLidG_tA@mail.gmail.com>
 <aJtl4MOJ5hYU7mWy@kernel.org> <CAG+gbFfY=YZZ24dZpBtShc+4ypGJgngsz7X32XKaHZ90s3okFg@mail.gmail.com>
 <aJxDRb5KJUTc-dL9@kernel.org>
In-Reply-To: <aJxDRb5KJUTc-dL9@kernel.org>
From: Denis Aleksandrov <daleksan@redhat.com>
Date: Wed, 13 Aug 2025 09:13:19 -0400
X-Gm-Features: Ac12FXxtjkrOE7p6888zxzRSjt_1KFRbu55XQxQN15hn9vaz0VStX9_Ql5hqZM0
Message-ID: <CAG+gbFdesyWJRBss6xBcGsKmTPZ=fro8DAFZaQTOsO-ZT1tcEg@mail.gmail.com>
Subject: Re: [PATCH] tpm: prevents local DOS via tpm/tpm0/ppi/*operations
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org, 
	Jan Stancek <jstancek@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Sorry about the HTML, my reply kept getting booted yesterday due
to formatting and I wasn't sure why that was the case.

I guess it might be some automated gmail formatting.

Let me know how you would like to proceed.

Thanks again,
Denis


