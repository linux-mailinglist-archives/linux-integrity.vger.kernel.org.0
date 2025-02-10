Return-Path: <linux-integrity+bounces-4763-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F302A2EC12
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Feb 2025 12:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBC993A8FBA
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Feb 2025 11:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A1D1F7060;
	Mon, 10 Feb 2025 11:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="hF9/qC3q"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996B81F560D
	for <linux-integrity@vger.kernel.org>; Mon, 10 Feb 2025 11:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739188690; cv=none; b=St0VId3jg56DkzlI/FYDGp9OefMwH87ZoiRgOEuhUikIg2fcfRbShh/qKq85UaxmZK8Ayh3ywWm/D7tHQLl/IC2ANORHhM+tMBPj4lTTR2ocnduZ65hBjEOlMyBWPRWYjQMv2F6LzG9JiUFgGt4ZPuxLrcLlZQcBzHiu85axWRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739188690; c=relaxed/simple;
	bh=as4SUiBKDJu7f/KIbNhAFDg767Lu1xis1B9Fm+JHYDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r4bOry6lMLZ+nQd31DZZwMWmXI+GXxRzyqm3LlJl9eiS5yjjjtm6q949f2JMddiq8kum1SA1QUe7/9PO3NEPxd7k8aFbwp/wSrT63LtL7mUjLsE6HGK7jVW0x7Pkk1R/N2aoZwvOLDl/2Z7d1987HW3amuAqkQLQYGFWh6UkHtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=hF9/qC3q; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38dc6d55ebaso1891796f8f.1
        for <linux-integrity@vger.kernel.org>; Mon, 10 Feb 2025 03:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1739188687; x=1739793487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=as4SUiBKDJu7f/KIbNhAFDg767Lu1xis1B9Fm+JHYDM=;
        b=hF9/qC3qvEkqii5v99lO+25HlASbdJiZ7L6PoI0wqTQP//BzHFo5utI/Oc/Zul/Rq3
         1Y23yhO94yahrt0YarbuS6KA57b41MSq2JME6u7V6AX+P1RrbmgJ7Er/Gw0wzjb9fi0w
         15e+iOaPku8YBDmpPMHKaLSUspkLdFmy8qaja+KnU5EGIEXFEScihNfN1gkDQSFwRMSP
         stfd4NrbWvzctso5rO/eBMoBugLAnlAXx9DF1679nl99G1qfyd/znFsazyD6spd9m7B/
         y2HOUmDmqaEZuPiJQEA2/jRHrh/RQLeMM08D39zPL9QfbT2N0iOZsU6Hd2NAvm12fYQ3
         SWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739188687; x=1739793487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=as4SUiBKDJu7f/KIbNhAFDg767Lu1xis1B9Fm+JHYDM=;
        b=j69CI3nYwigM3M/sExqybuW5KOlFr9o4kOWGwPf5bzDu4FPX6tYkwF3JGxfO5+9oFC
         BpsRfd3snxU1KPSBdIR6YqscH7Z4AxHed82s/1xW539ZXAQVbnDpSqAtC7KYH118zHUA
         BNUu80Iiq3/kJAGpwcqRP8vBibZSAZybt9UXpl8nUQ7Ow3SKf3OVUmQ65696QOoxWfaN
         uhpzTIL4T5WKG3+Jk33Q8jL4ddw5EO/3qmuxG4JfXIxruAY/gsZm7NjYkSodGZ7uQF8m
         rQohnjoAjCJacuSOcp9VbT1Av2OyxnAPMdPXEmcdqGfXXAjNbyAQHKzkmuiUDfHkHrW7
         VPUg==
X-Gm-Message-State: AOJu0YzYOhQBQfZN/fAGj3gNGXXYK3yCWVOboXnQyKUchCEMcMGuEYk1
	WGddUjb65yqipUwDMlrbc79HVMP6AOZSqqLtxISBnSenwe9svkFIhVXSYJIbu890Ii7cEwduRlp
	D
X-Gm-Gg: ASbGncum91U5kC9rjhx3o4J9AjJ4IJibDzvoDdjszCggTOFAXe1SlR1d7sq0wxsc+n7
	ttlK3Fjlj+sVGCR20Y6Fi1gt0e3oLg/O65H+RFLNfXKOvJqRMV9roMzvCoMncy1Nxzn9bLtmMcF
	Tw9oCeHNJSv0L4xXLzl8YQrAFLRMoeVipxdqsQdOKY77NHj7L1jD6YJEMeQ6vjhGrf2RcEdcHfc
	xBheLY1Qv1jLSdrJTN1Liu7weHnJpM1fc2Te+vp8gW1fXL6ByhFslaOAt1gVeMTuGi/Tp7UhL9+
	aYaIftQ7kRtPiqpk
X-Google-Smtp-Source: AGHT+IFEd0xQXpxBXbxhVrVFY+Z1GeZScw7oor+XBNGkufWYSsyj+e3PrFPwPqOelxgNNUVPM0WgUw==
X-Received: by 2002:a5d:6da9:0:b0:38d:dffc:c14f with SMTP id ffacd0b85a97d-38ddffcc5ffmr2071887f8f.1.1739188686752;
        Mon, 10 Feb 2025 03:58:06 -0800 (PST)
Received: from somecomputer ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dcc9bd251sm8905203f8f.9.2025.02.10.03.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 03:58:06 -0800 (PST)
From: Richard Weinberger <richard@sigma-star.at>
To: David Gstir <david@sigma-star.at>,
 sigma star Kernel Team <upstream+dcp@sigma-star.at>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
 David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>,
 SCE_Linux_Security_team@msteams.nxp.com, upstream@sigma-star.at
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kshitiz Varshney <kshitiz.varshney@nxp.com>,
 Kshitiz Varshney <kshitiz.varshney@nxp.com>
Subject:
 Re: [PATCH v1] trusted_dcp.c: Do not return in case of non-secure mode
Date: Mon, 10 Feb 2025 12:58:05 +0100
Message-ID: <2171670.G923GbCHz0@anvil>
In-Reply-To: <20250210114606.1593650-1-kshitiz.varshney@nxp.com>
References: <20250210114606.1593650-1-kshitiz.varshney@nxp.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Montag, 10. Februar 2025 12:46 Kshitiz Varshney wrote:
> There are multiple type of keys in different worlds, like
> test key in case of non-secure world and OTP, unique key
> in case of secure world.
> So, instead of returning with an error, in case of test key, we
> should display warning to the user and allow the user to run the
> trusted key functionality with test key.

We have the dcp_skip_zk_test module parameter to allow such cases.
Why can't you use it?

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y



