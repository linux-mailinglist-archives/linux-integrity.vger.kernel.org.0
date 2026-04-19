Return-Path: <linux-integrity+bounces-9236-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gC/gJDH45GnPcgEAu9opvQ
	(envelope-from <linux-integrity+bounces-9236-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Apr 2026 17:43:45 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF38C424845
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Apr 2026 17:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 783FF300E5C4
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Apr 2026 15:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4A815B0EC;
	Sun, 19 Apr 2026 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HRsg4CDL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868CF1A6834
	for <linux-integrity@vger.kernel.org>; Sun, 19 Apr 2026 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776613422; cv=none; b=hEv5/+ihw9gNKqFm8O/CNjH0i9G69F4f8TzryFNW3GMxzGk0kYIIrIvseDC+n5jhHE8Od/egP7nUvZTEWu11/gWZz5Giw3s/zn8FNEBLZVBdOHgzfp+1ddPSeuh6XbQpIAZ4r7p/mxrjUg3EJG6/IPkzp2cJmNRZ8lV/3zlBskk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776613422; c=relaxed/simple;
	bh=ghZiPcVncZXyb4N9ERFqMStHV3mzq4Bshv+I6uXEDpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZoLfWqc6WkpmW7MOQN16ZG73shV6lvSEUiM8wwEihD8Hry93Zr1CzlU2kSpxlEcQB9plT8OZhAolBcVcrXmEbYuHseBFzTirmWxZ1FoNACTBU0JHcrqU+UQLpDYrBsNvJKv7zFcGb/vk8ipvkEIp7i57xjvi8pwCX9Avazcn7Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HRsg4CDL; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ba67b332bbaso86723766b.0
        for <linux-integrity@vger.kernel.org>; Sun, 19 Apr 2026 08:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1776613419; x=1777218219; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w/oRXVFRurK/1hSlacPxQ2tT4pqKl2JDBMWth3dthQ0=;
        b=HRsg4CDLm3mP0NGDPZhlNxBReCoEhI+zOKV/G/UDTyqLB7/FbBMbUaVwyC8Fopzmel
         oEu36wmUC0AmkNoQUvQEHaWFndnT/VyHzCdgOHDaCSmtGnE3BJtdRMqPUKN7K90i6ibw
         8hqCPkhMGs/GdaGEMqfKFq7vCRLzPXQGf+HzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776613419; x=1777218219;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/oRXVFRurK/1hSlacPxQ2tT4pqKl2JDBMWth3dthQ0=;
        b=VjdDvAKwlFnjFMwTNjv4GILWyaE4+T+VvgFu3nk5eoXm+45WUHf/u4i3V1CtbA8ynU
         D6h5rdDjcooeNfSE8YZRQ+XN1QxxBpxd8A1L5V/3OKWnBmi74uYE/UF7EXoIIrOEQ7JH
         tq6D4zJEImL4h9NUcAorj3TV0Me7bZfrL0SIe/AthbmRzTQvE/sKfc3NSiQU7TY5yqsV
         +rSTjadiikmVOEKLN45SqKYHDnpP5nAcR2BtgmPVR3czKuADrNhXtd2kzRMk9THGokvP
         gmZNuce92C70axvl5rr5nE1sUHSXorYN6NuLRh0JdqdTD+UZeSJekgn06rIJfJ46UPSp
         2Apg==
X-Forwarded-Encrypted: i=1; AFNElJ+wVsvXvpAlmTPgHOyq+NVsQFK3NGNMz3ALQwfJxjYMvGGBzU9m2y5k//al2wXP6Sv3TUNDe9CiRbK+NYz63yI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcVOxMafY/SF3oDqTuxwX9NvVTrFmc4VSk7VqWjIxsA+DCgL7b
	FJJk6Q1CherGMaqX5vVc74wytEDr/euTAE3k9orEindRBmSEZ3NggWH5jXGE0WrOQTQBwo2erR/
	lcBJDH7M=
X-Gm-Gg: AeBDieuGtHI/E4/4Dyr5oxvVUy2oZtCvq28xbUWMgZ9KKAGqN2Z0eD9gQnG7mo5j2yJ
	qmAGRbG6K7TUfQ/LC9qni4V/rETiltAgIx3NFcoOunWZdds6fepACF6CQo6BIB+JVA04pGkMKPY
	uAJXT2D1Dv+ogmQ6EjRGVgpQDNukT1ao+Rj6Egjlra2IxObJfiQKa1gIqahntmxNAwbwyycjrGZ
	JXFuoLf6Xt6pkhWV2FLdmlmpPPqSZTiuW4BA8gfLydUqdfgSoMJIAQJfS64hNSiSt9suIEmSvED
	FC+mz3ZA+euFrwikzXV0tl0XbZcxhrft1O6lwiA1wSS32Tw6QhXugr6q6RNpmfcXDQS1kiwn/nD
	8dodLCaQwiFP2XRo9q3sJEN9khqUYmPLuUzHjwZELC1SNEZCZ7ldtJW03WSKG5lVETFQeHeoeBN
	1tTX2c/uLxJ2X9M5/Zw8x7O9QzPjm8qoUTinWsE+SD2kpK0EBYE/eOg5NIsleqQZoPC4JYAugac
	o7yUzDDb9c=
X-Received: by 2002:a17:907:6a16:b0:b9c:2c55:3384 with SMTP id a640c23a62f3a-ba41adf9231mr501600366b.31.1776613418570;
        Sun, 19 Apr 2026 08:43:38 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba455533b79sm259443566b.54.2026.04.19.08.43.38
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 08:43:38 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6634bb959a2so3019203a12.1
        for <linux-integrity@vger.kernel.org>; Sun, 19 Apr 2026 08:43:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ90rMlzhsU8qUP3e/hfNuhXwweROZhnWVXTYWzmU3TpjvNH0Yce4tAkwT1nWncNjfZ/Q0eo3HrQHKHa1sQyGTg=@vger.kernel.org
X-Received: by 2002:a05:6402:280f:b0:672:6419:8c23 with SMTP id
 4fb4d7f45d1cf-672bfdc3813mr4829148a12.14.1776613417846; Sun, 19 Apr 2026
 08:43:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aeTLzOgblMZRnDvF@kernel.org>
In-Reply-To: <aeTLzOgblMZRnDvF@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 19 Apr 2026 08:43:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=whjUfVy22QCcsCS2h8AkJVpQBjHyVW4_hKXpUxHn9S65w@mail.gmail.com>
X-Gm-Features: AQROBzD-MuYoon2JCfj2oa26fofPfJsB3Yf3SnKXc5ssgIBczbMthS2Y7Dg_eHo
Message-ID: <CAHk-=whjUfVy22QCcsCS2h8AkJVpQBjHyVW4_hKXpUxHn9S65w@mail.gmail.com>
Subject: Re: [GIT PULL] KEYS: keys-next-7.1-rc1
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org, 
	linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9236-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-integrity@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:dkim,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF38C424845
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This too appears to have been rebased just minutes before sending the email

No.

That counts as "zero testing" when you don't even explain why it happened.

                Linus

