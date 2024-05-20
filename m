Return-Path: <linux-integrity+bounces-2472-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545EA8C9F03
	for <lists+linux-integrity@lfdr.de>; Mon, 20 May 2024 16:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0546B20A3C
	for <lists+linux-integrity@lfdr.de>; Mon, 20 May 2024 14:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376AB13699A;
	Mon, 20 May 2024 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="D+kk4AG0";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="D+kk4AG0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546591E878;
	Mon, 20 May 2024 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716216633; cv=none; b=nmXlPKO+tCkr26RCVNlXfO0sd9eoyjB8DYEi4cnWxYbpj5AhVX+N1IGsBSgjD5rj1fOU1HdKjSjDNhXuacImTXMueYPG9E7xJLRchLwvJvqv1XuUzzTFf7eC/BmPwhbLZ+UQJ8FCMG7gSEvO5JcHUBLM+lT5YIqGKpk2tNrUIIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716216633; c=relaxed/simple;
	bh=a3b4/nDS8pHPvnKT7j0QAuoDnWKmn0konKkL0z8d35c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KEIhNv9oK4paCPmtDeUQnFcnfzZD0tZNKbXPVfVBiR92C3lohbpClvuAXUhu8N44ZZricN76ulonkniQ1dYCVBV3MLFAbHS5XEBTH8HJK4EzXVBUWrlWbA4m9J0LRbV3DDF3hhw8l1OBtEdpn2xHTsPGXkm/6eshyjimA4XW8jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=D+kk4AG0; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=D+kk4AG0; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716216630;
	bh=a3b4/nDS8pHPvnKT7j0QAuoDnWKmn0konKkL0z8d35c=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=D+kk4AG0QoCIjSouaPRINcQbpA2n+ukVzkMHBxe++5m1vX8AvqhxpMnBcRzOOikgI
	 byZL9IzE/WUXrRlY0lX90yiIcYTRhToUfCIrc8Gvw5jOyP1qBe5MQr8Zs1iYzzml54
	 tVjmfvHbT1zsC7Rcuz2/P3siTEz0gxntrf5pt1t0=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5F2941285FA1;
	Mon, 20 May 2024 10:50:30 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id Da-M4TCAyMMp; Mon, 20 May 2024 10:50:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716216630;
	bh=a3b4/nDS8pHPvnKT7j0QAuoDnWKmn0konKkL0z8d35c=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=D+kk4AG0QoCIjSouaPRINcQbpA2n+ukVzkMHBxe++5m1vX8AvqhxpMnBcRzOOikgI
	 byZL9IzE/WUXrRlY0lX90yiIcYTRhToUfCIrc8Gvw5jOyP1qBe5MQr8Zs1iYzzml54
	 tVjmfvHbT1zsC7Rcuz2/P3siTEz0gxntrf5pt1t0=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 88E8B1280773;
	Mon, 20 May 2024 10:50:29 -0400 (EDT)
Message-ID: <41466b65a30a351d57869042e9f130cdb68aab5b.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: Disable TCG_TPM2_HMAC by default
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, Vitor Soares <ivitro@gmail.com>, Peter Huewe
	 <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, open list
	 <linux-kernel@vger.kernel.org>
Date: Mon, 20 May 2024 10:50:28 -0400
In-Reply-To: <20240518113424.13486-1-jarkko@kernel.org>
References: <20240518113424.13486-1-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Sat, 2024-05-18 at 14:34 +0300, Jarkko Sakkinen wrote:
> Causes performance drop in initialization so needs to be opt-in.
> Distributors are capable of opt-in enabling this. Could be also
> handled by kernel-command line in the future.
> 
> Reported-by: Vitor Soares <ivitro@gmail.com>
> Closes:
> https://lore.kernel.org/linux-integrity/bf67346ef623ff3c452c4f968b7d900911e250c3.camel@gmail.com/#t

Hey, there's no response on that thread verifying the primary
generation is the culprit.  Could we at least wait for a reply before
taking such drastic action based on surmise?

I'd be really surprised if it is primary generation.  If I used an RSA
primary it would be a problem (My oldest TPM takes a couple of minutes
to generate one) but the longest I've seen an EC primary take to
generate is still less than a second.

James


