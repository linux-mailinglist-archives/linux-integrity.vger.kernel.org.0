Return-Path: <linux-integrity+bounces-7560-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BF1C2EDEC
	for <lists+linux-integrity@lfdr.de>; Tue, 04 Nov 2025 02:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93AE188505E
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Nov 2025 01:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92081E3787;
	Tue,  4 Nov 2025 01:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C937CMCF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890BA1C5F13;
	Tue,  4 Nov 2025 01:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762220800; cv=none; b=sHiaITA3JAsEeBlx0ykRlwsY4erG3gRBLHn86M3RypAb0Gsk5S1lVDmMegxBnysjos0b4OCdGYmTCHHQdtRp8o1q+xrHXJ66LNKue3UuwWq5yM3dNlkX1p9g4dMbN1wOds39fOnBjHkaOloYttLmB8kDQ6Tshs/OISepOPY6flY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762220800; c=relaxed/simple;
	bh=dPVBT7JGqP6QWM8M6gGC/TKPc3oU08ulbidUfqz/Bms=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Rx5RqqrAaL1Dwze0ArciEmceAHrT/ipLJ0XSeCPoScjJ9lQ1PuGXO7wfdQ1bU849gAKkqa1uMa+LIK3oQ5N3s+N0HLv7OhcLz59swdP0ibPcm2BdmAQdgTzqoBvACXl7CPCzjtdnt7OBVGr0nyUHux5pY/vx+voAg4wSLjnbahY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C937CMCF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1314C4CEE7;
	Tue,  4 Nov 2025 01:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762220800;
	bh=dPVBT7JGqP6QWM8M6gGC/TKPc3oU08ulbidUfqz/Bms=;
	h=Date:From:To:Cc:Subject:From;
	b=C937CMCFP1T5T53kGi8Agbf5dGry1EhhXyZjIiBG10m1WKfC/MDXhH++lMQ9V2xat
	 sw4KO9r3UWWcaGZ/cQjX0V1a+QQpuP2E31Aa02AxQjhy6NLzwHSQq7N4RB8Zsu6uc2
	 YW40Au8R10knAOPb7R+UaW4H7EFI4gcmPVD8Khxqe/s24G6pWH2ljFvFviey22FNlG
	 rNGGIcOSakMmVQLZ4BGDpEXQZgHAalxFgkP4AiDVo/9e52Aj/hG9bLbOiFJwTypy2r
	 964vsewKmKiOFVmaLU9pUS4IAjXhzY9RLQHT9K9plU3bYn4mf9n4jtSBeO8ENulIzj
	 OxCtbFtWJSZJQ==
Date: Tue, 4 Nov 2025 03:46:36 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: tpm2@lists.linux.dev
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Subject: tpm2h 0.15.0
Message-ID: <aQla8R85uQVTIodS@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tpm2sh 0.15.0 is much more stabilized than previous iterations, and
enhances key management with a proper support for compiling command
lists from policy expressions embedded to the TPM 2.0 ASN.1 key
files:

~ main ≡
❯ tpm2sh create tpm:81000001 --data deadbeef --policy  '(pcr(sha256:16) or pcr(sha256:7)) and secret(tpm:81000001)' keyedhash:sha256 | tpm2sh load
vtpm:80000000

~ main ≡
❯ tpm2sh cache
HANDLE    TYPE       DETAILS
80000000  transient  keyedhash:sha256

~ main ≡
❯ tpm2sh unseal vtpm:80000000
deadbeef


RustCrypto crates have been erased and all software crypto is based
on openssl crate and libssl in order to have a patchable crypto:

❯ ldd target/release/tpm2sh
        linux-vdso.so.1 (0x00007f4eddc64000)
        libssl.so.3 => /lib/x86_64-linux-gnu/libssl.so.3 (0x00007f4edd757000)
        libcrypto.so.3 => /lib/x86_64-linux-gnu/libcrypto.so.3 (0x00007f4edd2d0000)
        libgcc_s.so.1 => /lib/x86_64-linux-gnu/libgcc_s.so.1 (0x00007f4eddc0a000)
        libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007f4edd1f0000)
        libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f4edd00e000)
        /lib64/ld-linux-x86-64.so.2 (0x00007f4eddc66000)

Total size of dependency graph is 129, which is not whole a lot in the
usual Rust metrics and tpm2sh is fine-tuned to compile nicely with rustc
1.7x toolchains. This allows to compile it fluently to e.g., BuildRoot
and Yocto images. E.g., to keep some control and narrow down
dependencies I wrote my own custom PKCS#1, PCKS#8, SEC1 and X.509
parsers using rasn [1].

Converting external keys to TPM keys is super trivial:

~ main ≡
❯ tpm2sh create-primary ecc-nist-p256:sha256
vtpm:80000000

~ main ≡
❯ tpm2sh cache
HANDLE    TYPE       DETAILS
80000000  transient  ecc-nist-p256:sha256

~ main ≡
❯ tpm2sh convert vtpm:80000000 -I private.pem | tpm2sh load
vtpm:80000001

~ main ≡
❯ tpm2sh cache
HANDLE    TYPE       DETAILS
80000000  transient  ecc-nist-p256:sha256
80000001  transient  rsa-2048:sha256

`tpm2-tpmkey` crate reads and writes otherwise the format following the
standard, except it adds an optional `parentPubkey` attribute, which
enable parent auto-discovery from persistent handles and vtpm cache
for the tpm2sh load subcommand.

The custom (and stripped off) X.509 parser allows to trivially download
EC certificates:

~ main ≡
❯ tpm2sh memory
HANDLE    TYPE         DETAILS
01c00002  certificate  rsa-2048:sha256
01c0000a  certificate  ecc-nist-p256:sha256
81000001  persistent   rsa-2048:sha256
81000002  persistent   ecc-nist-p256:sha256

~ main ≡
❯ tpm2sh memory tpm:01c0000a | openssl x509 -text -noout | head -15
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number: 1298017026 (0x4d5e2b02)
        Signature Algorithm: ecdsa-with-SHA256
        Issuer: C = DE, O = Infineon Technologies AG, OU = OPTIGA(TM), CN = Infineon OPTIGA(TM) TPM 2.0 ECC CA 042
        Validity
            Not Before: Sep 16 22:18:38 2020 GMT
            Not After : Sep 16 22:18:38 2035 GMT
        Subject:
        Subject Public Key Info:
            Public Key Algorithm: id-ecPublicKey
                Public-Key: (256 bit)
                pub:
                    04:a5:09:12:cd:a6:0d:79:49:2f:b0:fa:39:bf:cf:

The stack overall has grown into a micro-ecosystem of re-usable components:

1. https://crates.io/crates/tpm2sh
3. https://crates.io/crates/tpm2-tpmkey
2. https://crates.io/crates/tpm2-policy-language
4. https://crates.io/crates/tpm2-crypto
5. https://crates.io/crates/tpm2-protocol

[1] https://github.com/librasn/compiler

BR, Jarkko

