Return-Path: <linux-integrity+bounces-216-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 662107F9343
	for <lists+linux-integrity@lfdr.de>; Sun, 26 Nov 2023 16:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167E428120D
	for <lists+linux-integrity@lfdr.de>; Sun, 26 Nov 2023 15:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862DC79C5;
	Sun, 26 Nov 2023 15:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="d8/40mkf";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="k8/ZKB/j"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B37DF;
	Sun, 26 Nov 2023 07:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1701011252;
	bh=+DNjYQqIssPqAWmXjxp4JyvSDdbz/p8NHfW+HfEVAeQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=d8/40mkfkkDYITzrjflZ8l52cle4Oj06GLCmal2kBHEy0iiC7rxo9/nz0Ri/bhN8l
	 ZiHdfRxWfPZ75aXTPx7HP0vuAVTVfLy/glQ1vMFn9tR9TzYsFKXR4XS1VfbkNB/B1R
	 2HSbWaklxxVFZDJw0Zr9TBrd4eHx+/lBi6nMKSs8=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6BBD91286954;
	Sun, 26 Nov 2023 10:07:32 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id WDupy6BrESKk; Sun, 26 Nov 2023 10:07:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1701011251;
	bh=+DNjYQqIssPqAWmXjxp4JyvSDdbz/p8NHfW+HfEVAeQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=k8/ZKB/jrdaLd+xXYLwsiBdtcjBXzCMTJXpPtqECPzoHIfrlSubODXrF5K7fWV4qi
	 T6d2A7BZsMUGIypYvf6rW8GMT+cYTJNVMY2AQ9yasjZ2PT4d84CvM2KCB80Q4FfJpP
	 hIoeqihxG4/a+8laDui3wLsfRNlin+rz1ys4tTNA=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 65FF01286906;
	Sun, 26 Nov 2023 10:07:31 -0500 (EST)
Message-ID: <74edd2b83180cd4af1446df3711196fce7502b59.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 08/13] tpm: Add full HMAC and encrypt/decrypt session
 handling code
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 26 Nov 2023 10:07:29 -0500
In-Reply-To: <CX8FNY9X41EO.2JJKWOS7HEQH0@kernel.org>
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
	 <20230403214003.32093-9-James.Bottomley@HansenPartnership.com>
	 <CX8FJA25TO6W.ET37QQIXFGQH@kernel.org>
	 <CX8FNY9X41EO.2JJKWOS7HEQH0@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Could you please trim your replies.  In long patches like this not
doing so makes for a huge fishing expedition

On Sun, 2023-11-26 at 05:45 +0200, Jarkko Sakkinen wrote:
[...]
> > Most the code looks overally decent, except reverse christmas tree
> > declarations would be nice to have. Getting this patch right is
> > probably the most critical and rest is pretty easy after that.
> > Thus the focus.
> 
> I'll consider picking the tail, editing minimally and sending a new
> version with the hmac patches. I.e. change the config flag name and
> stuff like that.

I already have it converted ... that's how I found the bugs I reported,
but I need a stable base for a repost.

James


