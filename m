Return-Path: <linux-integrity+bounces-6910-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A5DB34E5D
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Aug 2025 23:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05D46164DFD
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Aug 2025 21:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6014F28469C;
	Mon, 25 Aug 2025 21:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImfgHXEy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3637623A9AE;
	Mon, 25 Aug 2025 21:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756158545; cv=none; b=rfUyTqllHzIFxV2A6zqMwqEUcTq+ejS2XA6wAHd5lHLfzbpZG2BTkcZUgavQe6L3jEf/9qbNpPQRjGUfOhW/9W7KE4AZVn8afX9f12tlik18WNBjYB1XnYoNZR8pi1D7vZ6uOzApKEqcTZbYIIsNDLRBriSmpAh9cvPG1dCwwbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756158545; c=relaxed/simple;
	bh=/siDhazI4u0HQA1+2irWPVHhZ3I4DCCOwg45QoNdROc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FHZPmq+l2wdiPbI8C8yf3eCjhIdcZoXJJNp/xMybAm4EdaqrVIDOsMB0S874cWeMZ6RzfGqTfUryMyz553at15uo/Fp4Vl0tO7ZER9waLxZYqeyWFKVFBFF+1dEFPEbsoWHzpYY+Vx+ez+PIfhjmEiFTd+KS6M4PNXYuHMHMqAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImfgHXEy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC33FC4CEED;
	Mon, 25 Aug 2025 21:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756158545;
	bh=/siDhazI4u0HQA1+2irWPVHhZ3I4DCCOwg45QoNdROc=;
	h=Date:From:To:Cc:Subject:From;
	b=ImfgHXEyyqANx9H0ROPFD70G54VBrdVfKlaQE1jgTgYDGS9Kvl0AW2Cvl1mRvxdvc
	 w8ikd6OqEuC2UqtLpt5gpUb55M6J+v3hs+pwaIj/4ekUrCHJa7TkV/bIvT/OwX1xhy
	 9nJaKPV+Hhv467F4A0Xp9yYnqmVtE1fNbbeHBfms19Ca8vkF9gLzRt3k7EaTYuHCOp
	 zzbx4hsnxW9XTJToZVLS3I8xIvoX+LL2qphGbzL4Nw2ucVDCrAAIlAxUaBBWt3lPSU
	 T+eDC/FYmLdJ8IfOCQeOvSfLasR08nJ1vBgl2AjogxbnYfwoxHZpdlgY2tBYE0MKSC
	 32qiMoB/Jujpg==
Date: Tue, 26 Aug 2025 00:49:01 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: tpm2@lists.linux.dev
Cc: linux-integrity@vger.kernel.org
Subject: tpm2-protocol: open for patches
Message-ID: <aKzaTYCI2GO_UPRB@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

The last version that I do "as solo":

https://crates.io/crates/tpm2-protocol/0.10.10

I lifted up the version number in the main branch so that ABI breaks can
be done [1]. Consider all versions up 0.10.10 as the PoC era of this
project. I'm neither to motivated to pick up any stable fixes for 0.10.x.

Versions starting from 0.11 (once it is released) 0.11.x, bug fix
(no feature) branches can be done.

There's one feature in my test program (which I don't recommend to use
for any production, it's still heavily under construction) that I'm
willing to consider for relicensing and further to contribute e.g.,
to TPM-RS or perhaps as its own crate:

https://github.com/puavo-org/tpm2sh/blob/main/src/pretty_printer.rs

[lot's of unimplemented parts but it does not trip on them but instead
 marks them down to the log]

Keep in mind that the constraints in the following sections (taken from
lib.rs) are the existential limits for any possible patch (including
dev dependencies, do that type of stuff at your own personan sandbox
thank you).

## Constraints

* `alloc` is disallowed.
* Dependencies are disallowed.
* Developer dependencies (aka 'dev-dependencies`) are disallowed.
* Panics are disallowed.

## Design Goals

* The crate must compile with GNU make and rustc without any external
  dependencies.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/tpm2-protocol.git/commit/?id=d265c021c9407a93068c49a691a9534b1eff3099

BR, Jarkko

