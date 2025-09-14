Return-Path: <linux-integrity+bounces-7069-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC01B56A8F
	for <lists+linux-integrity@lfdr.de>; Sun, 14 Sep 2025 18:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45DA93B7C4D
	for <lists+linux-integrity@lfdr.de>; Sun, 14 Sep 2025 16:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CBE2C325F;
	Sun, 14 Sep 2025 16:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7XG+AIG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886C5246BC7;
	Sun, 14 Sep 2025 16:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757867017; cv=none; b=CTzTBiA6jYDhYt7L0HPTMV5+XwE1RyybPPYegAs7eQQ10QR7aIM9HlCTm1nQUutJtJYxPsxKFyhMuF5SNN8Vq7tuJntjIGaDSHZTItKgiz1Tsm7D913lDts2lTJ8W1Dgnao5Zv0tg3yNIKayvs4k41VtZ2YWSUrm9QydF9Pa31A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757867017; c=relaxed/simple;
	bh=eugwuiAQg4iT9TF4tqJ3kr6k+Fd677EDG2AdJYmpmFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqWkl9uQnf7qa1J3Qx4qUUs2KUDINP5nOSg0OaLzBh4WvS7bJAB9D/nmA9atRZ1lE18DV0umPdFKIOFTfavGkuEyodrESMAWhtnVq9Hf+k1Pt6il2Ixz+uX9E2WDcIwOntWk12p9ObzcQO1glxuRez5F0sC5gdnIc+82D5H3J0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7XG+AIG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A396C4CEF0;
	Sun, 14 Sep 2025 16:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757867017;
	bh=eugwuiAQg4iT9TF4tqJ3kr6k+Fd677EDG2AdJYmpmFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X7XG+AIGU6zf0zimLol0gH5ttRZqBXNjw+yNbvOqSJ3VvNe8Su68Maw6R0uoEI798
	 FmH45MIELu6c93z5KfvXChQY6MaWkdL2R34AFj5wmz4c4Bek1jz9EgO/be98mccprq
	 +6f5EBPDleTLeB7OtWtEJnug/np0lJrncpPoWcUxq78LWN3MPWiqLIphUvo5dD+E96
	 qNSZ5eoiL35Gc3AASaEcwSkilbliIbYUeubK7qEaie5WaBfFEhTwotkGILxkjEQY9g
	 /RGMMG0NiKNs0fbx74NfnkngYl5wH5fNxrH5ZAA+0yFPMP2ZjchtDoRavaA4ZNhBji
	 39uPxIaz7HLgA==
Date: Sun, 14 Sep 2025 19:23:33 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org, tpm2@lists.linux.dev
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: tpm2key.asn1 parent identification
Message-ID: <aMbsBX2uq6zOixSA@kernel.org>
References: <aMboFXNNX7WZaOaS@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMboFXNNX7WZaOaS@kernel.org>

On Sun, Sep 14, 2025 at 07:08:37PM +0300, Jarkko Sakkinen wrote:
> Hi,
> 
> In practice, while implementing tpm2sh and its self-contained TPM emulator
> called "MockTPM", I've noticed that 'tpm2key.asn1.' has a major bottleneck,
> but luckily it is easy to squash.
> 
> Parent handle should never be persisted, as it defies the existential
> reason of having a file format in the first place.
> 
> To address this issue I just added couple of optional fields to TPMKey:
> 
>   parentName   [6] EXPLICIT OCTET STRING OPTIONAL,
>   parentPubkey [7] EXPLICIT OCTET STRING OPTIONAL
> 
> By persisting this information TPM2_GetCapability + TPM2_ReadPublic can
> be used to acquire an appropriate handle.
> 
> I'd highly recommend to add this quirk to anything that processes this
> ASN.1 format.


Here's a proof of concept:

https://github.com/puavo-org/tpm2sh/commit/18ec3c2169b23523d8866c58fa7b8a89a79bd3d4

BR, Jarkko

