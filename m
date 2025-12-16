Return-Path: <linux-integrity+bounces-8072-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E84B6CC1E13
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 10:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 689E53021FA3
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 09:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54D833A6FE;
	Tue, 16 Dec 2025 09:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dLc9yK9m"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EA5257859
	for <linux-integrity@vger.kernel.org>; Tue, 16 Dec 2025 09:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765878958; cv=none; b=KxYS06ZIHzpP19l+7xeI4ByVzJUwEUNWy2jaGRTEP33NTkRoL/NgQirP1/9ToaA/RqSzYho02+YJn6hu6cMuyRj/+aOMr3H5IZPoeGBWVXMjXQhhvRW0tX3tK8FkxboaSoY3MTrzCLDwCgcIIwIeEFhrGdPDz66+jmMzIYhyIRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765878958; c=relaxed/simple;
	bh=v6qSPbazIbEay7EXZFe9DGCkiumHopuzf+llzVeMCzA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ZXi7kc3eO5EN4n4nLWVblSrl5Su2O2QZ0b7XF/iS6R1eViV77esfFAFLJz6vhyPRv7GDvDWFRsEjJK213KXV5blgqPMnG83GWSa0ucXK4O+MzmmVEE57+o4nLHf+ENii9N6ynKLUIRgohqYWjaDlXXUTuUBOhanziYPOE0AHFAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dLc9yK9m; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so33811865e9.3
        for <linux-integrity@vger.kernel.org>; Tue, 16 Dec 2025 01:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765878955; x=1766483755; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6qSPbazIbEay7EXZFe9DGCkiumHopuzf+llzVeMCzA=;
        b=dLc9yK9mQHt/plAosleuRsuPIQJQKLBw71xTvsI0hklvzVOh0B55xZP66xkalolGQh
         8ihDWmxT68hAq7vSYiIftMw2ZhMoUgXu6QbOCz18N+M/n6Kj+wu+yCVCwxypa4oVJdi3
         WLUWp26UOEB1QX81bnXypdND7vlUVU11mi91zXHBLlGCbYyFLg04t6mQbM9Wk6joB7c/
         /428t46GpcCSUL46BmQtKiLYAT4jDnQhSp3Yg9j9tucHbjND5obu9HwqBsCA5YhnyvgR
         EgH+ZzvMF14KyqcqP7ZfjNhFDDzhRDKkfhpS4qMSEqsq6fB7fed6bBA6+1ih8XoFCOU4
         EDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765878955; x=1766483755;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v6qSPbazIbEay7EXZFe9DGCkiumHopuzf+llzVeMCzA=;
        b=VWIJKpgRWv/oOP1gnDPB+BR1FFcC+n6ac8VwxhKS5jsKSYuhgm53rC2YRLZP6hDnjJ
         38Aaqhz8zwPVqGsQnWAvmo8DZ/iUTwkMzPcJIVxuCxeGxg5zpyrf/fAlEq693VYauPRv
         VBASjyUFkq8Bcy5T1W/j18ZUqHqV7yC6FhhsSp8qk2YP/OULHcn9IjhNXTZyYGmTCJYO
         AN+YElvXOEkkCDX1W1jsZ2rQmY1hwO/d7P2H3OUf2RSAcn34B79jm5+cpr0HO1Ih0UXS
         +bHdp7Bd/RSTTLkQdnQliMVKLMWKVAeRRq4/bUE/7Kx0AMuFuygFkvjkfkDRprQ46Ham
         XeMw==
X-Forwarded-Encrypted: i=1; AJvYcCVTDr9gnfPG/M4Sw/yO5Au0mAd6tU2yDiZOwVP1DN6G26euV1RMKCtjG431itTXS30bWbxWoE/mkInU/UmsC14=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWDrSo0LfY5JV61+hs/HBz2Lx8FcLQ1GLMJK6XAHPTTpAtKGrW
	fVm7ZgOeryq+L7mxj/IMIc661Ll+UXH8b+iwChYCDsjnRnItV4s1gQIzOpNAwaACFjo=
X-Gm-Gg: AY/fxX6v0+7g/brzpO/0g3oc7zpZU6sFoe9Dm0UvlVr28nU10Gt2qxgDy1Tny12AC79
	I4JfwWa9sGDMpXTIUnCczIU1xJ9578bv0b+7k/p/MFiVmwnIbc/ARO7P4BEVCflyo5tw+iG+Bzr
	eX/bWHMq8qgWAcQVDaZKKmxQj4S3Psdx5rkCZlK/1tK5UcaJg4c1is/jB/nG2sG1Ia+R/oy9xI4
	bGVGPPZZcabFCNGuHd7czukhVV8riZgyo/jKEwGoYaQaNZu6mIvAYIDWH5gXXZodzSQqQJnO+Fx
	4v8DU095ZW63Bkz9jrCfdfhAaJYhRrx8UfBzlPWWKaSzFzm34MPQUCC+xwsEDtrna1rn92UA1l1
	vOLBmeSJiHXfX1LkwJD78AXOjA3yTCyxtAQ6A8Mn0kvLrvbkIChY+uF9iClRXNx7zCAZ7S2MVTv
	DYEcYXA+3Q2j6bDsJgHpg=
X-Google-Smtp-Source: AGHT+IHVG/5tLgeX9lKKllhXy4OLKTMjwaMgOmEL5Z/47SH1UmyNaMk7+S+ymlyPRDD4ez9W+Qs8ww==
X-Received: by 2002:a05:600c:1d2a:b0:477:9a28:b09a with SMTP id 5b1f17b1804b1-47a8f7039c3mr146487405e9.0.1765878955168;
        Tue, 16 Dec 2025 01:55:55 -0800 (PST)
Received: from localhost ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-430fb078e56sm13668810f8f.21.2025.12.16.01.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 01:55:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Dec 2025 10:55:54 +0100
Message-Id: <DEZJUGBX3UJT.3NRHNSS55B7I2@suse.com>
Cc: <selinux@vger.kernel.org>, <linux-integrity@vger.kernel.org>
Subject: Re: [LTP] [PATCH] ima_selinux: Fix requirements
From: "Andrea Cervesato" <andrea.cervesato@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20251208141321.696537-1-pvorel@suse.cz>
In-Reply-To: <20251208141321.696537-1-pvorel@suse.cz>

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

--=20
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


