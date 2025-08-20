Return-Path: <linux-integrity+bounces-6880-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 362EBB2D092
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Aug 2025 02:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA6D41B6769F
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Aug 2025 00:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165424C9F;
	Wed, 20 Aug 2025 00:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDcRuxwG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1E44A1E;
	Wed, 20 Aug 2025 00:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755648795; cv=none; b=qRyVKIdq59lo0eRjGEW73nCfCDp2EjV463a68b3qf9JUKunYpNm5B8/6mmGy0FL+TZETZO3RNOBKYblFOMYGZv1EdIS1vUwhErqlebQNyP6juRQQzUIPD8eo5wUpLLRe+Rxvuum4fTN/AjeUpKG/BSH/3o2RKi9yuAIN2UxGDI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755648795; c=relaxed/simple;
	bh=gy5IplXc0FL96Ro3IuiifdRSkX7mIGM+aCqIxPwusL0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XrObL9tfY8hraFLipn8M66Rfsmd2Cf5StmKfxypfYaims2pQfOt5vbzlyi6MXNFNLipo1Bnkltgs3YFkCVlkm3/QtYaQSDPJ7wGZHPMTT9QacwvDLpInpjUdZLTiqbhFAXu4USfDVX8Ql9FWK1AuN7gZFlrBD84ohxD9mpcUn6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDcRuxwG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219FDC4CEF1;
	Wed, 20 Aug 2025 00:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755648794;
	bh=gy5IplXc0FL96Ro3IuiifdRSkX7mIGM+aCqIxPwusL0=;
	h=Date:From:To:Subject:From;
	b=XDcRuxwGHqSj3D5V/kZDqFdRPgGU2IcxLRMia/pub7NEm+BEoknWc4bRqu5EUkH6R
	 OfajYIR8xQ+Md6Jbd9wMp7LrvbM+fG/mI3KYXYhuwpnpr2oH25P5GAvAP+aG53U4FU
	 f2mYclR8HIr9pd1KQoiGEK3px/I9BQz4l+uVz4ABcHIejEoG3cm08ATJvYLLZBi5/V
	 mX+3pTBadgkNR8fY4XTwwL4QkBVnspN4N34L8uwOYDiwOP+YPnnlOnftQZTRlIbPcf
	 iA24uMthtLxEOqb/jzr7k3ZFT30/BvfNE8Qaw/wjfObZo+91A5os4BEqJ/4TL65RF3
	 1q6ILR0m8DBbw==
Date: Wed, 20 Aug 2025 03:13:11 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: tpm2@lists.linux.dev, linux-integrity@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: tpm2_protocol / tpm2sh 0.9.0
Message-ID: <aKUTF6lu5JetDJxX@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi

0.9.0 is the first "feature complete" version of tpm2_protocol except
couple of minor glitches.

Errata:

    1. SetCapability due this remark below table 137 in the Structures
       specification:
    
       "The TPMU_SET_CAPABILITIES Structure may be defined by a TCG Registry."
    
    2. No TPM_CC_MAC defined as its code conflicts with TPM_CC_HMAC reasoned
       with the most illogical reasoning ever in the end of section 5.2 of
       Structures specification:
    
       "A TPM can implement either TPM2_HMAC()/TPM2_HMAC_Start() or
       TPM2_MAC()/TPM2_MAC_Start() but not both, as they have the same command
       code and there is no way to distinguish them. A TPM that supports
       TPM2_MAC()/TPM2_MAC_Start() will support any code that was written to
       use TPM2_HMAC()/TPM2_HMAC_Start(), but a TPM that supports
       TPM2_HMAC()/TPM2_HMAC_Start() will not support a MAC based on symmetric
       block ciphers."
    
       I.e. reasoning that tells no reasons for overriding a CC, which here
       is the problem, not the "xor relationship" between these commands.
       Neither all other commands work on all TPMs but still they don't
       share the same magic cookie.

I started this project originally in 2024 then I got quickly stuck.
After one year of processing how to do it the result is no_std, zero
dependency crate, which does not require memory allocator. It can
empower both chips, clients, emulators and operating systems. Even tho
most of the code was written in three weeks (11K of 12K for both
protocol and client) the ideas have been developing for a long time.

Next steps are of course slimming up and tightening the implementation
as there must be extra fat scattered here and there, and fix the bugs.
Response handling has a few scoped rough edges that I will look into
first. I think also (and have experience on the topic further to
back it up) that this after maturizing is the solution also for
Linux kernel.

Unlike other TPM2 tools and alike tpm2sh is not designed for human
readable output but instead a programming interface for bash and
similar (e.g. it could be used to enhance tools like 'pass') but
I've developed a human solution i.e. "print-stack" command so it
is the demo for this release:

❯ sudo ./target/debug/tpm2sh create-primary --alg rsa:2048:sha256 | sudo ./target/debug/tpm2sh pcr-read "sha256:0" | sudo ./target/debug/tpm2sh print-stack

⠦ Waiting for TPM...
⠏ ✔ TPM operation complete.                                                                                      Type: pcr-values
  Update Counter: 86
  Bank (sha256):
    PCR 0: b9a5bf5fc2ffbca9b75f75567c84d1f660d4a77d1413f7a4b15de162cd27e6f0
Type: context
  Context:
    Sequence: 0x8b
    Saved Handle: 0x80000000
    Hierarchy: TPM_RH_OWNER

Now it's time to a short break (ignored other life to get this
vomitted out) ... :-)

BR, Jarkko



