Return-Path: <linux-integrity+bounces-215-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C17A67F9341
	for <lists+linux-integrity@lfdr.de>; Sun, 26 Nov 2023 16:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CA04B20D89
	for <lists+linux-integrity@lfdr.de>; Sun, 26 Nov 2023 15:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BC58814;
	Sun, 26 Nov 2023 15:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ToRo8XwV";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ToRo8XwV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFC6F0;
	Sun, 26 Nov 2023 07:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1701011136;
	bh=aqmYsKUpNCRIJS4hgh1ZMp9ElG8Efss/NTEhkhLbBxo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=ToRo8XwVNVld14KxxHTLerHbf9skZc41l3xsxbWL3B5kmP6ZfY45z7RniTrRvgB04
	 TY66Sliez3A5b5mw436l2ADwYxHcTNUTC10/e3Bcss0yrvDeuHESLxN04WL7nOx6Wi
	 HSpNaSuQ9ShMRuhnOKRpAHXF2XCvGhMNeaXkf6ps=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id B6D2F1286954;
	Sun, 26 Nov 2023 10:05:36 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id ozBzADCObiEz; Sun, 26 Nov 2023 10:05:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1701011136;
	bh=aqmYsKUpNCRIJS4hgh1ZMp9ElG8Efss/NTEhkhLbBxo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=ToRo8XwVNVld14KxxHTLerHbf9skZc41l3xsxbWL3B5kmP6ZfY45z7RniTrRvgB04
	 TY66Sliez3A5b5mw436l2ADwYxHcTNUTC10/e3Bcss0yrvDeuHESLxN04WL7nOx6Wi
	 HSpNaSuQ9ShMRuhnOKRpAHXF2XCvGhMNeaXkf6ps=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id DB8931286906;
	Sun, 26 Nov 2023 10:05:35 -0500 (EST)
Message-ID: <4e7fd5c07dede4ebe640dcc3b123adcb1e65f1f0.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 08/13] tpm: Add full HMAC and encrypt/decrypt session
 handling code
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, Mimi Zohar
	 <zohar@linux.ibm.com>
Date: Sun, 26 Nov 2023 10:05:33 -0500
In-Reply-To: <CX8FJA25TO6W.ET37QQIXFGQH@kernel.org>
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
	 <20230403214003.32093-9-James.Bottomley@HansenPartnership.com>
	 <CX8FJA25TO6W.ET37QQIXFGQH@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 2023-11-26 at 05:39 +0200, Jarkko Sakkinen wrote:
> One very obvious thing to fix there is the kconfig flag:
> 
> 1. Its meaning and purpose is not documented to the commit message.
> What
>    is it and what is its meaning and purpose.
> 2. TPM_BUS_SECURITY does not follow the naming convention of other
>    TPM kconfig flags, and to add, "security" is way way too abstract
>    word. Something like TCG_TPM_HMAC
> 
>    It should be renamed as TCG_TPM_

One question is do we still need this?  Since my tree has moved ahead,
I also need the HMAC code for policy on keys and the primary code for
permanent parents.  The only real performance concern is for PCR
extension (no-one really cares about the speed of unseal or random), so
a different possible way of doing this is simply to CONFIG that one
operation.

Regards,

James


