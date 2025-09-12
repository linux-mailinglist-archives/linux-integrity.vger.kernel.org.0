Return-Path: <linux-integrity+bounces-7065-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAC0B55867
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Sep 2025 23:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CFA71C85546
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Sep 2025 21:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4757426B973;
	Fri, 12 Sep 2025 21:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlg3Ik6Y"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176352BAF4;
	Fri, 12 Sep 2025 21:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757712782; cv=none; b=CIbrIWDu3EGDx7Trijs1+znL4ZXnA1fnx5bIHkR+dlrmXKwvW2ULJ8blCeN9kWJkEUNpnt5QCe/vahvUDl6gqMaRpz//FzTn5Qr1Zalqhjrx9IrmazCl83LAmtmc01v/aMGVUWymeJ+bEV+FkZW44SanDGwQ+7w8p/+Or6h1ITY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757712782; c=relaxed/simple;
	bh=Fa1ZYSxyvToVhEv9NrlVYdvmGvyVBS7zdoogcGQu6K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcNc/mZfYh8UhTkjA9oZqPLO07ln+i+SbRid1CunaIT8T7v49vHf8sebuGVEmB7TLWCT9VhU4Gfumcq2y7RTp3eqiqL61tArmsKjxK2YK+MxZfKBYQzGodRXyIRXmB9qEe9qJhh5NByxFPOC8mp57lv+NgdDZYGcgDG37514mdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlg3Ik6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688B3C4CEF1;
	Fri, 12 Sep 2025 21:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757712781;
	bh=Fa1ZYSxyvToVhEv9NrlVYdvmGvyVBS7zdoogcGQu6K8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qlg3Ik6YJQLRToqhk65gPTvTWAqKzPKLpqlPYg11Yq2+28+n5ZzxnRVnZ7BKTTfVs
	 a6wjOGdVttmVndkHti7ibC9ut03i6qZ1BU72QM8NS+oyrKLmYlgq4YsEjuxyAysWVZ
	 B22Raaf0/Nilxq0hdrzLMZSOeC4YbjnKPvgilKGUudzvZxsSE5a/VF2SEe0cVexRJT
	 J5kVvL4qKRh50sFWtZsd6waWZNNixwntAzMBW9+2lSJ6dmuB5e3nxZM9Dwg21juXhn
	 xBkS42tFwUjK4djCIiGKwlV81GON04CGAXgBHU1Yo6WGQntuL7D8FhBcgdDKpN27nn
	 EAg1n1tYtDieg==
Date: Fri, 12 Sep 2025 14:32:56 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Qunqin Zhao <zhaoqunqin@loongson.cn>, herbert@gondor.apana.org.au,
	jarkko@kernel.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, davem@davemloft.net,
	linux-crypto@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	linux-integrity@vger.kernel.org
Subject: Re: [GIT PULL] Immutable branch between MFD, Char and Crypto due for
 the v6.18 merge window
Message-ID: <20250912213256.GA3062565@ax162>
References: <20250705072045.1067-1-zhaoqunqin@loongson.cn>
 <20250902124205.GL2163762@google.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902124205.GL2163762@google.com>

Hi Lee,

On Tue, Sep 02, 2025 at 01:42:05PM +0100, Lee Jones wrote:
> Enjoy!
> 
> The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:
> 
>   Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-char-crypto-v6.18
> 
> for you to fetch changes up to 74fddd5fbab879a7d039d9fb49af923927a64811:
> 
>   MAINTAINERS: Add entry for Loongson Security Engine drivers (2025-09-02 12:29:57 +0100)
> 
> ----------------------------------------------------------------
> Immutable branch between MFD, Char and Crypto due for the v6.18 merge window
> 
> ----------------------------------------------------------------
> Qunqin Zhao (4):
...
>       tpm: Add a driver for Loongson TPM device

This one needs a fix up due to commit 07d8004d6fb9 ("tpm: add bufsiz
parameter in the .send callback") in 6.17-rc1, as I am seeing the
following error in next-20250912.

  drivers/char/tpm/tpm_loongson.c:48:17: error: initialization of 'int (*)(struct tpm_chip *, u8 *, size_t,  size_t)' {aka 'int (*)(struct tpm_chip *, unsigned char *, long unsigned int,  long unsigned int)'} from incompatible pointer type 'int (*)(struct tpm_chip *, u8 *, size_t)' {aka 'int (*)(struct tpm_chip *, unsigned char *, long unsigned int)'} [-Wincompatible-pointer-types]
     48 |         .send = tpm_loongson_send,
        |                 ^~~~~~~~~~~~~~~~~
  drivers/char/tpm/tpm_loongson.c:48:17: note: (near initialization for 'tpm_loongson_ops.send')
  drivers/char/tpm/tpm_loongson.c:31:12: note: 'tpm_loongson_send' declared here
     31 | static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t count)
        |            ^~~~~~~~~~~~~~~~~

Can you squash it or do you want a separate patch?

Cheers,
Nathan

diff --git a/drivers/char/tpm/tpm_loongson.c b/drivers/char/tpm/tpm_loongson.c
index a4ec23639911..9e50250763d1 100644
--- a/drivers/char/tpm/tpm_loongson.c
+++ b/drivers/char/tpm/tpm_loongson.c
@@ -28,7 +28,7 @@ static int tpm_loongson_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 	return cmd_ret->data_len;
 }
 
-static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t count)
+static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t count)
 {
 	struct loongson_se_engine *tpm_engine = dev_get_drvdata(&chip->dev);
 	struct tpm_loongson_cmd *cmd = tpm_engine->command;

