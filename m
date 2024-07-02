Return-Path: <linux-integrity+bounces-2968-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A276924C5F
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2024 01:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B88061F23A7B
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jul 2024 23:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E880217DA00;
	Tue,  2 Jul 2024 23:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="pyQNKyHX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F38517A59E;
	Tue,  2 Jul 2024 23:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719964129; cv=pass; b=UiVoZyEKEjY5RPvYX0Ds1N2KO6aas1s8rptDsWmJLykid3/RReN3F3QN92q/hlkhz6zokd+4E+ujqRAdUp5ZZP7xskLH2OI4A64fy4tJJIyXSWQsaUj5f63G/TGldch3yHaY3tQ48EcG4I6SEZuNIunDPzNNClzxTmiJfqasbMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719964129; c=relaxed/simple;
	bh=90b13T27WVDefVQ9TFMIUOTIGoYWnvBBve830JPz5uc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hFBvSme3K3vVRkiBQP/52QEUhLEz8V4bzZyCjrPqMVIVkSD9xd7qZe9vXUctyqGl5EnLFfNcdK3PuFoTURBNRj7G2bLnaGVocZEor2vBoZtwoHZ4ECWX+h6SKwrdlKnPY4XZ1m5OgGxsy29lnP3DaLYPaQ1vy0tv5+ie/IotuMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=pyQNKyHX; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from localhost (83-245-197-232.elisa-laajakaista.fi [83.245.197.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sakkinen)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4WDKP33tvPzyTK;
	Wed,  3 Jul 2024 02:48:38 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1719964120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=90b13T27WVDefVQ9TFMIUOTIGoYWnvBBve830JPz5uc=;
	b=pyQNKyHXp39EAf5Qlg0oPHmathCHi9DXuB8SJxSP4UnJjkKXlBJwpqWr150clD70HDqjjB
	W+8d1isZg9nJjodxdv9Yy9+o5pn49jSx/EsP0rdWM8+f+WwH7me/RcI7CmYjfQDm7NoHp1
	RRGMSZ9/xgGQGSPFXdU1LvwYB3sKrHM=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1719964120; a=rsa-sha256; cv=none;
	b=dIV5AhFDjU0eFidNIvVfjBgVwP07smKHAjGKaDFD2/b9VOi6T3xvX5gueQ7bDeqdVkfAz5
	axjvq8NAAAmFz7FthJsjSsp3l/4zrpDmYrUaivn6BFPVgYGCpZCAwr66vQ7yHZXe59DTKp
	4Uy44jpNG1LCq3OPg2EeYR5jQtclOpY=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1719964120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=90b13T27WVDefVQ9TFMIUOTIGoYWnvBBve830JPz5uc=;
	b=cqjXrtof80qPRszwXMneHjrKuZT+XYUAXgsHM0qfCgfczmSXpD+RRY4qy7yAJgYLTbrBlt
	dsIX9PXJq1RF9m0boyXJ/KFP2Dec6rRo5DNN3ylWXge0yyn3whuWIsGQWxf+ohI8e6NOYp
	735GZdN11M1phMS9bIv3+poJf6wItSM=
Message-ID: <b7559dbb323d16fb334f8f8f35b8fda3fb6e481c.camel@iki.fi>
Subject: Re: [PATCH] tpm: ibmvtpm: Call tpm2_sessions_init() to initialize
 session support
From: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
To: Stefan Berger <stefanb@linux.ibm.com>, Linux regressions mailing list
	 <regressions@lists.linux.dev>
Cc: naveen.n.rao@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 03 Jul 2024 02:48:37 +0300
In-Reply-To: <e7db74a0-cd5c-4394-b87e-c31ea0861ea1@linux.ibm.com>
References: <20240617193408.1234365-1-stefanb@linux.ibm.com>
	 <9e167f3e-cd81-45ab-bd34-939f516b05a4@linux.ibm.com>
	 <55e8331d-4682-40df-9a1b-8a08dc5f6409@leemhuis.info>
	 <9f86a167074d9b522311715c567f1c19b88e3ad4.camel@kernel.org>
	 <53d96a8b-26ef-46a3-9b68-3d791613e47c@linux.ibm.com>
	 <D2EFNJTR80JS.1RW91OVY1UH1N@iki.fi>
	 <e7db74a0-cd5c-4394-b87e-c31ea0861ea1@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-01 at 15:14 -0400, Stefan Berger wrote:
> Applying it is probably the better path forward than restricting HMAC to=
=20
> x86_64 now and enabling it on a per-architecture basis afterwards ...

Why is this here and not in the associated patch?

Any, what argue against is already done for v6.10.

The actual bug needs to be fixed before anything
else.

I can look at the patch when in August (back from
holiday) but please response to the correct patch
next time, thanks.

BR, Jarkko

