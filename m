Return-Path: <linux-integrity+bounces-3296-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5029499C6
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Aug 2024 23:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCC69B24196
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Aug 2024 21:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A16171079;
	Tue,  6 Aug 2024 20:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Eb3sUuf/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B23C170A28
	for <linux-integrity@vger.kernel.org>; Tue,  6 Aug 2024 20:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722977974; cv=none; b=pa9XvOQHB/f73s4Cfw2yo+E8GT6wOoN6oZJjM5dAc5IFTzr8WmFBFN8KIwt+JktAgrVSqTSQCc9sRx3fiENzSILSD0Cf0gpNVTv1RPi5jbbow9+QsAPng/89tHmAvflPWEWsU5+Z6TctmWADw0UyOn/EthH95KJq7mAyURTdDgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722977974; c=relaxed/simple;
	bh=qyUz9Qqv5k5SudOvCxQPX4RBki5RQXyIqfhgrvWKdyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjSUaT/CRBqs1986reTQIKiJs7ukoVRmnNAvCl6skQ3PLNFllXX+lj+thvHjYzTUuOgTqK7s1+u9/uJvKPefdUdRGCL89uK2dp2wpr8aD/ljpttaQ8Vk4Gctuu6D/AyGNOWLV/fPPNql61U71yEXGc/v9xFzKKsvzosl3lGozJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Eb3sUuf/; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e0bfc0ee203so1171542276.2
        for <linux-integrity@vger.kernel.org>; Tue, 06 Aug 2024 13:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1722977971; x=1723582771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqRA/CX/CVDKRMnMKUkE7btXGpws1I/eaVA/YpB62Hc=;
        b=Eb3sUuf/v0kca+XnoKJZRiENpb45DUPlfGi6IMf13qoSoLYimi3mbIv6qhH8hOEh8A
         mtVov7Lo2+nWdrAHGka9zLYVA1Sjmjb3AcjWwDADP1msPFly37oB04+MJAo54CujViTu
         a1vCj3WAE+S3ZIjyJgFSjCbqF+44/OIo599KJgBo80TX+cbW1YJaofC74vUrXxBHwvc3
         sFE1L/cMDbIe99kU4N5IUeNp9/6xTDjzSbnrqVs0378SkaDdfLa0lvtM6stQdlKdcDlN
         DrmYuETjc7TuhIltjqm90BxNzaWLUuccUumCJk4/JR+ilZrg3hf3VdnUc5ty8V2xUoWk
         yVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722977971; x=1723582771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqRA/CX/CVDKRMnMKUkE7btXGpws1I/eaVA/YpB62Hc=;
        b=iYzD7t5AsUztpCsRYyNIzTtrEBUFRll4YheM2Lg0UYDKGDEQJMFQmFl9d8MXg718HJ
         vSIrrlJQ2wxm2gWwIc2uG+lK/s2pBtYaQKNH1vYNFy5F6IHu4DB9e5K4ylTgpTkjrsVu
         WYv7zJShI8m7Eq+fa71iNP1z622oNabKPFMR/kr7rFpyJI0DxkesrErLKAyIg8sBfHDy
         kkE059sFC/l9UrSSr2BH9eEy30xqkCBqdrW7sYgeTdTdQCiPOuvAPJSNvMajaUlkhqms
         vcCxApuds44l2vjEyvyaG9iu+ray1w06qIYnksU4AfS6/C2v4nCk2jZ8S17q6Gim+1nK
         iuAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/N0zbJFl8mzeHcLbu+hO1wMdrOf1pVv94CiRYcVgkRVeQiamxhQ33zZSoY4lf8SvWDDDJKXVmXxbv59HV96MyfToDwXNF1GYGnJEOb+cW
X-Gm-Message-State: AOJu0Ywi0k508MmDyJ3Lx+mnsxFL23pWEzcUy1of/Cxe6yYO+co1mS5y
	ny/8x8uR+Be8C9UxiPDWRZ4jkxSsvjElcjLAyOK2RTbv0LwAYaIhnlRhH34j5G2XM0ADy9o10M/
	+sM9PbsCarD9QpdZSOd01YAs+zuudxdKtQ47m
X-Google-Smtp-Source: AGHT+IG+g9ZPIj3c+gMV8h9nbV6S0gFWlT866BH5MDCEFMia55H31Vc+W1m/exuwqdaE7fTnf6/iUgbwZyFG5W1FJkM=
X-Received: by 2002:a05:6902:15c5:b0:e0b:e2ed:b6c9 with SMTP id
 3f1490d57ef6-e0be2edba28mr17255194276.9.1722977971481; Tue, 06 Aug 2024
 13:59:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1722665314-21156-1-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1722665314-21156-1-git-send-email-wufan@linux.microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 6 Aug 2024 16:59:20 -0400
Message-ID: <CAHC9VhQ3LobZks+JtcmOxiDH1_kbjXq3ao8th4V_VXO8VAh6YA@mail.gmail.com>
Subject: Re: [PATCH v20 00/20] Integrity Policy Enforcement LSM (IPE)
To: Fan Wu <wufan@linux.microsoft.com>
Cc: corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, 
	tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk, agk@redhat.com, 
	snitzer@kernel.org, mpatocka@redhat.com, eparis@redhat.com, 
	linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, fsverity@lists.linux.dev, 
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 3, 2024 at 2:08=E2=80=AFAM Fan Wu <wufan@linux.microsoft.com> w=
rote:
>
> IPE is a Linux Security Module that takes a complementary approach to
> access control. Unlike traditional access control mechanisms that rely on
> labels and paths for decision-making, IPE focuses on the immutable securi=
ty
> properties inherent to system components. These properties are fundamenta=
l
> attributes or features of a system component that cannot be altered,
> ensuring a consistent and reliable basis for security decisions.
>
> ...

There was some minor merge fuzz, a handful of overly long lines in the
comments, and some subject lines that needed some minor tweaking but
overall I think this looks good.  I only see one thing holding me back
from merging this into the LSM tree: an updated ACK from the
device-mapper folks; if we can get that within the next week or two
that would be great.

--=20
paul-moore.com

