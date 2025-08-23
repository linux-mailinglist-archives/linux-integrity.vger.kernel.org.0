Return-Path: <linux-integrity+bounces-6889-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B14B6B32879
	for <lists+linux-integrity@lfdr.de>; Sat, 23 Aug 2025 14:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9922C1BA7DCE
	for <lists+linux-integrity@lfdr.de>; Sat, 23 Aug 2025 12:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1EC23505F;
	Sat, 23 Aug 2025 12:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="db4byxuB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16311A9FB9;
	Sat, 23 Aug 2025 12:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755951168; cv=none; b=Iqg6fDIcRou3JUSlM2eJJS4fi/BOnGKa5jYSDYCtK/vxYkHbUmuOPGobFlsZVkdDXj9FNsemdLWlznWhUBT+Y/Gr0du0ygNVjtnNeRAlclz/6xS8RseXUzOilj6ItCo65ETtkjCadhffU+THENdSZ2kd9AtqTx6a7zJBD9QUFzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755951168; c=relaxed/simple;
	bh=Fkq+c9AfiuylTEUvvtRNDJzU9S5nPCx7rQyjMCCoqkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=T6DBVuYudcfE57k5ex+bLJf0+LzbGMapgrMpA9XdjQJk6e8v3qTezxq4gro4DEhAG4A7G1VA8t8KD1Z49elobUkqdda1CRdy7oPTIb5CxmZ0Dsm+6pchtJkZ+Jp+64+MTmWSKy7jBlh3RwGR0dpjhTUqpSckYvWgiaplS/c0b5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=db4byxuB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33F9C4CEE7;
	Sat, 23 Aug 2025 12:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755951168;
	bh=Fkq+c9AfiuylTEUvvtRNDJzU9S5nPCx7rQyjMCCoqkQ=;
	h=Date:From:To:Cc:Subject:From;
	b=db4byxuBfECi2Tv4p0JGAqRRlCBSE7k/eabsqz1srilroLC1CIURT9QL/4mKVvAqR
	 LSZAbrPhxby5cvpP15yf/c4IrPWfarJkXdCzkqIv+BAPSbjagPox+IzS2ttiCkbUYw
	 P7pG3lcUY4hHpg0mIQSDlKmM27oBsPzvg+El3jrkR0e3fczej9UHi319CZEtz5htVa
	 lo/aahpn4LU3aEiSuFKK0UZ5QzNvsigeZ9pDS8sBJHg8XLTEvjnFPR5QRHvBd4irzZ
	 PdVTr7H44Did2fPy0TPWvil68N8AiBlgs7TbP63mSSdq1Lh6JEVmT06zfqZcjqAWRq
	 L31DMP/ZFSfOA==
Date: Sat, 23 Aug 2025 15:12:44 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: rust-for-linux@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Subject: Using Rust on non-Rust side of kernel
Message-ID: <aKmwPFb4cCk_E-ob@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

As of today can we possibly do this:

1. drivers/char/tpm (C code)
2. drivers/char/tpm/protocol (imported tpm2_protocol)

?

And then build FFI from C to Rust for building commands that we need
today etc.

There's one particular challenge where this could help: early boot code
for D-RTM (i.e., Trenchboot) as given my crate is just a thing in stack
with no deps, it could be linked also to that payload.

This would be much better integration step for TPM2 than having a
separate driver on Rust side. We could start with tpm2-cmd1/cmd2, then
move on to tpm2-space.c i.e. get all structural processing inside Rust.

tpm2_protocol is light on definitions and should not need any kernel
specific Rust shenanigans.

Consider it as value like integer but just a bit more complex internaal
represention but in the end it is just a value on stack.

My goal with tpm2_protocol is to have ACPICA alike model of imports as
the crate is driven by TCG spec updates and it is very likely to be
also used by TPM-RS (also via import style process).

BR, Jarkko


