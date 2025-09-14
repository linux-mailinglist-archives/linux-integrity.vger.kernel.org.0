Return-Path: <linux-integrity+bounces-7068-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DADB56A71
	for <lists+linux-integrity@lfdr.de>; Sun, 14 Sep 2025 18:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 671E34202C8
	for <lists+linux-integrity@lfdr.de>; Sun, 14 Sep 2025 16:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483E027A47F;
	Sun, 14 Sep 2025 16:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DG8gEyfe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1441E521E;
	Sun, 14 Sep 2025 16:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757866121; cv=none; b=KEPTsrp/koPiIFzY+hgYOtKoLfSsZYqvitzvCvDljY+o7Qf8pdHa6bBdMQFPbMKhbJyC9als4hZW7m7dnpW/p2vY9rWeV5BjjUKrf5xvbt0H7Taml5t0X2h+x6U3UNVTU9Hjg0sbBZy3IerqRtWCF+pLhut9FtA8Y1+67OLJIp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757866121; c=relaxed/simple;
	bh=XpNC9fJ7EvkH67rEbG64m+CQX2AKvZwoADlQzm795Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IzXcumBsSZaIdEmxQ21QjOO8rZgDQZc7KwDoAfc50iTZ34BcliEwp0mz7lM3dM0lknTKBRkGIbrF6x0I2IY8JVxDsQpk74EvrHHlbmX+4MQfkrWQWl/wiUHmpkhWj9uG6LUwRVEC5ugR4bBSy0sZEaRpVzEguU79bHqeoZTLJyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DG8gEyfe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B95C4CEF0;
	Sun, 14 Sep 2025 16:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757866120;
	bh=XpNC9fJ7EvkH67rEbG64m+CQX2AKvZwoADlQzm795Hg=;
	h=Date:From:To:Cc:Subject:From;
	b=DG8gEyfeRQ93R2pT2CaNoXpZGgy0F5PUw1TbLm+wJq7vUceZ6l5HxBjHAXlYAAU6N
	 dllGHzv2AxvrPTUMVyMGr0dUtpJdaeOOXGEOUp67c36qtEuXZynxXSF13gGS0s1Ihy
	 87DUVTAOAr/5SbcWQaZsYzi7LMiszE/6pKCXSL8s0U6tNm3jeYDcJV37MNHxnQWS2B
	 KlDR5o/fkkFzD1k+B8cKwaFWsF9g17UNfzVJIaCN6SFz2NQrOGCdf3fr8lnZhTgMfK
	 driZNVFO3EySKqVGgdwj6bZIsZcs4sdAUQEVMBHZDocwEgc4pnBy2D4d3ygnYcLKF4
	 HBgOQnbCy9dHQ==
Date: Sun, 14 Sep 2025 19:08:37 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org, tpm2@lists.linux.dev
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: tpm2key.asn1 parent identification
Message-ID: <aMboFXNNX7WZaOaS@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

In practice, while implementing tpm2sh and its self-contained TPM emulator
called "MockTPM", I've noticed that 'tpm2key.asn1.' has a major bottleneck,
but luckily it is easy to squash.

Parent handle should never be persisted, as it defies the existential
reason of having a file format in the first place.

To address this issue I just added couple of optional fields to TPMKey:

  parentName   [6] EXPLICIT OCTET STRING OPTIONAL,
  parentPubkey [7] EXPLICIT OCTET STRING OPTIONAL

By persisting this information TPM2_GetCapability + TPM2_ReadPublic can
be used to acquire an appropriate handle.

I'd highly recommend to add this quirk to anything that processes this
ASN.1 format.

BR, Jarkko

