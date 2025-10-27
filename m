Return-Path: <linux-integrity+bounces-7527-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AA0C0C8A8
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Oct 2025 10:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0FD1188A051
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Oct 2025 09:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4882FB62A;
	Mon, 27 Oct 2025 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8u0dDAf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34762FB61C;
	Mon, 27 Oct 2025 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761555411; cv=none; b=cuCo+cJJnYiWLiuhgy9U0mma3RwkMozi+25vI9F97nq45LDhR+UlhwISaNrH1VbASQez+5bpkCY8Okey6vAVPvy74+DHhsJwIFjypUAmqmuO60zIiAexTK9YBWY4BwiZ8bHXFhg5Ffzmzoz0uI2q+ZcHfxfswjLmunVf1qtL1AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761555411; c=relaxed/simple;
	bh=N/9THp7GdKUCjPyADE7u2Z+Ew7uOk9w1UcHFECnPIXw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M30EoqVG+u/DRTOZ9PqpKP+r8rEwghzDJdmpbW/fkqr2SghLPn96Uiu70yi+FWOecA3/0DF4kf/zU3N6RVv2xXses7PRlWZHsIBIxE3ZKGPmPSPhOy2x+oPfTs/6UMhliwhLsOlmZujubOHSwOAn+0Mi3inEJiINAQZvXQ+qkpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8u0dDAf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E91C4CEFB;
	Mon, 27 Oct 2025 08:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761555411;
	bh=N/9THp7GdKUCjPyADE7u2Z+Ew7uOk9w1UcHFECnPIXw=;
	h=Date:From:To:Cc:Subject:From;
	b=t8u0dDAf5ovP/NmbVY/QIvvUWP0k1ymWg3BDYnbkQyyLc53olS1XEWf15n+LUYTqy
	 8a5kVr/8Igvf8TKT6jJdVWUFy+WqZna+HywxlN5SC5b3j9ptLIQ9HK75rEl4VCVoNf
	 1xCP52wNN1Z03Lbj7YBqpPJxM/3AmS3ExZQLa7LiVHPQKGXiydLL+8fmjxwNx6RYCn
	 JnxvolyHv2/jI411yR0mAq2Jv3KuF3iU3KIyz4t/YsBlUQywpeOr3LgWtxkXchWqIM
	 cMSHJ4nUyjsaXCmdLvcHhspOZUPaXTF/w1dBvkIjrj2AMow8ejEFRje+wPTmsgesMu
	 BHmtbTWl2ZVAg==
Date: Mon, 27 Oct 2025 10:56:47 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: tpm2@lists.linux.dev
Cc: linux-integrity@vger.kernel.org
Subject: tpm2sh 0.12.3
Message-ID: <aP8zzzYVxes1g-vS@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tpm2sh 0.12.3 loads and processes multi-level ancestor chains correctly,
policy expressions have now a more stable custom-built implemented
parser:

https://crates.io/crates/tpm2sh

The functionality is still mostly focused on key management and TPMKey
ASN.1 generation from various internal and external sources, making
it a tool with kernel testing focus.

I've added optional parentPubkey field to the original TPMKey ASN.1
because that allows "tpm2sh load" to be ergonomic as it can traverse
persistent and cached keys and discover parent, instead of requiring
explicit '--parent' argument.

This transcript demonstrates well the added ergonomics:

~ main ≡
❯ tpm2sh create-primary ecc-nist-p256:sha256
vtpm:80000000

~ main ≡
❯ set DIGEST (tpm2sh policy --mode software 'pcr(sha256:7) or pcr(sha256:15)')

~ main ≡
❯ tpm2sh create -P vtpm:80000000 --data deadbeef --policy $DIGEST keyedhash:sha256 | tpm2sh load
vtpm:80000001

~ main ≡
❯ tpm2sh policy --mode session 'pcr(sha256:7) or pcr(sha256:15)'
vtpm:03000000

~ main ≡
❯ tpm2sh unseal -A vtpm:03000000 vtpm:80000001
deadbeef

~ main ≡
❯ openssl genrsa -out private.pem 2048

~ main ≡
❯ tpm2sh convert -P vtpm:80000000 -I private.pem | tpm2sh load
vtpm:80000002

Without the extra field, also load commands would need to have 
"-P vtpm:80000000".

BR, Jarkko

