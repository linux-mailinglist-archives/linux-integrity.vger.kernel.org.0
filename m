Return-Path: <linux-integrity+bounces-6883-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A71B2B30C03
	for <lists+linux-integrity@lfdr.de>; Fri, 22 Aug 2025 04:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CDEF1D01D56
	for <lists+linux-integrity@lfdr.de>; Fri, 22 Aug 2025 02:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BBA21FF45;
	Fri, 22 Aug 2025 02:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfxRtmsr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868ED393DC6;
	Fri, 22 Aug 2025 02:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755830860; cv=none; b=qfsPYZywm745pLZpB5HtAwwOqNZ8W2pZ8OV1Ln4BGhq8qcWsXB26byEfvGWdW83nQdveG8/iaeQy3lseWTyZYER91XaBVX3MRFpgfXqqtVSVQz36QobHYp0RVC73+LdjnA6kUbzs+0UpJkUf0hmZCMVkA1kBiehH5bpX4gvh/FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755830860; c=relaxed/simple;
	bh=htkTUP/k9mFT8GaqTUJ/IrfGoKxmlR2u+w2ONjwKylM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=muYFdsgylTvU4KLplrrMpilSEL2AtGXyOo5RIIvK//YBP77tlxUELug1vE4PnR7fAGdxs4zlk3JM4DU314E/2kB9xy4psjDSSTNv4s89iFzsF5N5wT5Ab2PhCFdEDyv2G3ifpTXofJ5EpyaW8yNEebOG8rvxYJz4rgiBCrAdcRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfxRtmsr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E5CC4CEEB;
	Fri, 22 Aug 2025 02:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755830860;
	bh=htkTUP/k9mFT8GaqTUJ/IrfGoKxmlR2u+w2ONjwKylM=;
	h=Date:From:To:Subject:From;
	b=SfxRtmsrSL5brtQP65XKt/As3bFmaG7FAEbswLxTG5H/z3zz3Gy24kgQfVDexkCg2
	 LSYnNEy6KvBJXi/0oZC4DCOa2jPAXEl9zYpCd3Qu8RVvK6KxcRqqmcxuzwm5ezV0Em
	 UxkM1j50DpUkOabzfcRavivEVWlVDKL7cPwnRiVGlXiQSXzZQsXvCVDRjzDrrKEVGp
	 BFcIiJjjVbv/9op/sqy5sn5Sk/APYK3OrTQvwmr3QUfNmI3Mcaos8vEE1HM+zYoKY8
	 K/mQHvs8g3qmzFUfGhKukb1JGEFPj2uwLsi79ipgEU5Dcd0QICg2mOgVGDQvPSFuwc
	 P6TPRiUClL5hg==
Date: Fri, 22 Aug 2025 05:47:35 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: tpm2@lists.linux.dev, linux-integrity@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: tpm2-protocol 0.10.0 / tpm2sh 0.10.0
Message-ID: <aKfaR-h6Itc38qfl@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tpm2-protocol and tpm2sh has been split:

- tpm2-protocol is spec complete since the last release, and this the
  first release of gradual improvements. I've contacted TPM-RS project
  and going to participate to their meeting on next Monday. The idea I'm
  selling here is to have a shared project for protocol, which tracks
  the specification, and associated project can then import the source
  code aligned with their own release cycle.

- tpm2sh is my kernel hacking tool that will gain features and
  improvements with no strings attached to anything. I said to Joe
  Richey (Google) that taking, relicensing and further contributing some
  of its more interesting features from its GPL3 code base is not out of
  question (protocol is Apache/MIT). One feature in particular under
  discussion is pretty printer, which probably would make sense also for
  kernel.

"Where's ******* driver!?" you may ask.

Well, I think this needs to be approached like I do in order to get some
day driver that can do more than the pre-existing C driver, and not just
implement a random Rust driver.

This was also my main concern with kernel's Rust code i.e., that any
possible driver would be implemented from infeasible starting position.

tpm2-protocol
=============

Git: https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/tpm2-protocol.git
Cargo: https://crates.io/crates/tpm2-protocol

tag 0.10.0
Tagger: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
Date:   Fri Aug 22 04:45:40 2025 +0300

Release 0.10.0

- chore: refactor into standalone crate
- refactor(tpm2_protocol):  reduce defaults
- refactor(tpm2_protocol): merge TpmuSigScheme and TpmuAsymScheme
- refactor(tpm2_protocol): decouple command building
- fix(tpm2_protocol): trailing data
- refactor(tpm2_protocol): remove MAC definitions
- tests(tpm2_protocol)
- fix(tpm2-protocol): TpmuAttest error code
- tests: migrate dyn trait test to tpm2_protocol
- fix(tpm2_protocol): correct serialization logic
- refactor: InternalError -> Unreachable
- tests(tpm2_protocol): fix compilation errors
- fix(tpm2_protocol): StartAuthSession response
- refactor!(tpm2_protocol): drop tpm_response! and TpmParameters
- fix!(tpm2_protocol): DO NOT export submodules
- refactor(tpm2_protocol): adjust buffer debug output
- fix(tpm2_protocol): TpmRc::base() return code
-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRE6pSOnaBC00OEHEIaerohdGur0gUCaKfLxAAKCRAaerohdGur
0nY/AP9/4HMLP+wY0h5tQSnbzmIajNzzBAoWIA7nA8dIkcQ8RQEAxhK/MrKKT7iQ
j2rEvvKdgWPdHtPhZWzUahuZnW6LIgA=
=RfaI
-----END PGP SIGNATURE-----

tpm2sh
======

tag 0.10.0
Tagger: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
Date:   Fri Aug 22 04:59:10 2025 +0300

Release 0.10.0

- build: Cargo.lock
- chore: refactor into standalone crate
- build: bump version to 0.10.0
- refactor!(tpm2sh): rationalize command-line
- refactor(tpm2sh): improve error messages
- refactor(tpm2sh): consolidate option formatting
- refactor(tpm2sh): helper for transient rollback
- refactor(tpm2_protocol): decouple command building
- fix(tpm2sh): fix error propagation
- feat(tpm2sh): prefix for literal strings
- tests: migrate dyn trait test to tpm2_protocol
- fix(tpm2sh): don't hang convert on idle stdin
- refactor(tpm2sh): simplify error reporting
- fix(tpm2sh): adapt to protocol API changes
- refactor(tpm2sh): simplify error reporting
- fix(tpm2sh): correct RSA public exponent to 65537
- refactor!(tpm2_protocol): drop tpm_response! and TpmParameters
- fix(tpm2sh): don't open device unless required
-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRE6pSOnaBC00OEHEIaerohdGur0gUCaKfO7gAKCRAaerohdGur
0oEhAQDkeOror8uNMVcIIvsQ81FqxHMfh2kFCNg8YO7SeuKXjAD/Q9sOiarXtxm5
kxnhSS7evAC8cEHb8bppNSluP3egmA4=
=IEED
-----END PGP SIGNATURE-----

BR, Jarkko

