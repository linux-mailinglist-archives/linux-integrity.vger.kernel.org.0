Return-Path: <linux-integrity+bounces-2120-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB538A49CD
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Apr 2024 10:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76FD7285BF4
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Apr 2024 08:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC0A376E6;
	Mon, 15 Apr 2024 08:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="JY7WVL3i"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B168376E1
	for <linux-integrity@vger.kernel.org>; Mon, 15 Apr 2024 08:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713168560; cv=none; b=abU2L7ibvNVtLKYrsxcOuPBx20LAIlDf49BoJZ96y3Y0HR4OqjpOqhKChFG4FVhP3XAhhNg5qwLXCmHzKXXYGOISwKU83ndvK5/47cS3t8Q2m4FzzFLkcxpNhFc1K3ydgv+fpEv8Yvp8Bk74f8lGwkgt8/RzBZKkx3m1H8TfjWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713168560; c=relaxed/simple;
	bh=YwT+akiycT7zUiBlGUGl+TAPvveigRMKj7UEv7P0iyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VpQGFW4ENwoJWA5GC8kMYS/vSHEiw2UEXTMpkuW0fevzmakkqFcO4j61jUB77MN3Sc30VN84Xv4bKFNSux23y69E9kJqVCF7tjSbYHc6jkcwHzLLwm/nn0hYOVFvtZwT82Rdg5z65A0NuJlkDHg3V1hsYKsKCDp86/jseJ9iTxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=JY7WVL3i; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a53f130b0e6so30964166b.1
        for <linux-integrity@vger.kernel.org>; Mon, 15 Apr 2024 01:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1713168557; x=1713773357; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pHvyqQ17Tn2O1Y0m3BirRC4u7vNkpQHjAXPedl5MpWU=;
        b=JY7WVL3iVR1YLrQJA7nhoQOedXkhesVg2XEwHh8rAUu/acPKqm0qf44vf+48wWkWTX
         +O6aby62bOxOX1VjWQBgTgy0fQX2rx9AYcF3Ds854NornsqjRUFMozqBVDanOliOXjaC
         ABMew1MNiWf/XcKre597vqyus32SD6AwiwqYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713168557; x=1713773357;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pHvyqQ17Tn2O1Y0m3BirRC4u7vNkpQHjAXPedl5MpWU=;
        b=o/PuTOMWFBT7dqmcABM6RRDhcNVwBH0V3qb0q9X9wGvg7YLxjIrYV28zvVa0DV1Vfo
         PZJiFu3BijsDhBLcHe/D/frlpi+7kPvw1qDYNPnn89C8CYTlOkNgaQ3d1TE1ErTYJGr6
         mnJ0PQVjJjBRaFZQ6E0aaJo8+bjVLk05ak5lBPx31QgySbjRuYYRpKTTKK9RdV/41R/M
         kWDj0BvQg1rMx3YfPy9z8rPe22LCfKjOX5p1T6qAsIZLjczzJSxwoEHIdujSnoU2NY4+
         S6qXZQZSV3XxPjsKQFT7GCgeiYsu84IEGjHEMRiLHTcrijR7HWTP9s+IIILRVq7utk1O
         qjGg==
X-Forwarded-Encrypted: i=1; AJvYcCWbgPUJs9bJFM2ISNyaEsrXfqSanh2GV9xjpUkme7ytEt1hIgRQYAy/applo9tdzhMwCyHeTMFkBl4VbJo7r0jEIPgCVDPjoQBLakVr9bdZ
X-Gm-Message-State: AOJu0YyZP9Rs+WcT1Bh9xoSed5lcPekZ5/yL6VrYtsy5PXE6i1YL8g6+
	3dzciVoU0jDoQ2PwEhJSMIwiaR/KknwDAyedDAnhoOAqhv3o0M/585x0Dit6qy9ZKZoP8fddtv4
	xhDH/S0NmZc3bpiATIjQObx4cVqlEFsmzyVIzZQ==
X-Google-Smtp-Source: AGHT+IGoqJvq2Ws+YedI2hZHMr9V8PWREbeZlVZIRGIcxv9MlUvw5e4bwOV6DFMx4/NAgcd9Hj0J1HO6Mylueh0Bijo=
X-Received: by 2002:a17:907:7da1:b0:a51:b0e1:8640 with SMTP id
 oz33-20020a1709077da100b00a51b0e18640mr7941615ejc.9.1713168557383; Mon, 15
 Apr 2024 01:09:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412140122.2607743-1-stefanb@linux.ibm.com>
 <20240412140122.2607743-3-stefanb@linux.ibm.com> <CAOQ4uxjDQO91cjA0sgyPStkwc_7+NxAOhyve94qUvXSM3ytk1g@mail.gmail.com>
 <89b4fb29-5906-4b21-8b5b-6b340701ffe4@linux.ibm.com>
In-Reply-To: <89b4fb29-5906-4b21-8b5b-6b340701ffe4@linux.ibm.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 15 Apr 2024 10:09:05 +0200
Message-ID: <CAJfpeguctirEYECoigcAsJwpGPCX2NyfMZ8H8GHGW-0UyKfjgg@mail.gmail.com>
Subject: Re: [RFC 2/2] ima: Fix detection of read/write violations on stacked filesystems
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-integrity@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zohar@linux.ibm.com, roberto.sassu@huawei.com, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Apr 2024 at 21:09, Stefan Berger <stefanb@linux.ibm.com> wrote:

> I was hoping that this would be sufficiently generic to work with
> potential future stacked filesystems as well that would need to also
> provide support for D_REAL_FILEDATA.

I also have very bad feelings from IMA digging in the internals of overlayfs.

We should strive to get rid of remaining d_real() instances, not add more.

On a related note, D_REAL_METADATA was apparently added for IMA
(commit 11b3f8ae7081 ("fs: remove the inode argument to ->d_real()
method")), but there's no current user.  What's up with this?

Thanks,
Miklos
,

