Return-Path: <linux-integrity+bounces-6944-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D47B396FE
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Aug 2025 10:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8333C7AE2D0
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Aug 2025 08:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA422E091C;
	Thu, 28 Aug 2025 08:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJb8ipEP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6D9283C90;
	Thu, 28 Aug 2025 08:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369787; cv=none; b=uSGQDJTiq0dEKTGiB0wot0BdbgSEghF7ltp/FU/QMIOLKCKN1qaUzTBt2Xwo8MnnBeSU3dIByin9EuHCitZ0ifLqNBYB+GmZebAPib+a2pcvKidE2sj+y/jV71t61IsO03wRr5FvTKEZiU7RBoY536/rcYF1lr8QI3x5xXG7578=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369787; c=relaxed/simple;
	bh=1b9KEpONUPclk3sil0nM+e0EgJNpZUYT12fVrFlVNao=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QeDrQLNqytxWUx4XH+Cwz2c4Hex943AArttUhttU/RgA4XL+mzKMmaapBe1mFpfeFaeAsQ5Clu0dC0i/ZtmJ8cZAszhjSYi4FgUFoPEssJOyvwVUjCrJ4vHEC43rPS/jJ9Fkyr5C3SbpgsjupzmskLFjhGXelamW+zYU/rXFhEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJb8ipEP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A41C4CEEB;
	Thu, 28 Aug 2025 08:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756369787;
	bh=1b9KEpONUPclk3sil0nM+e0EgJNpZUYT12fVrFlVNao=;
	h=Date:From:To:Cc:Subject:From;
	b=NJb8ipEP58MO5LIoQxx5NEeGKrxZJHiThpc6mTpMrta0icNggjPBEwnHbklSoDrKZ
	 lxPjDrnl853pLsk5QuyeYsGMlHLiBc8ehbb4yw5wOV5rsH3T7vmn61pHWWUTW7G0uY
	 4ks1fTxWMlLkfWGL+zUCkPSsk6g9I7/iPeeRVFIHSGSZtgmNrhqDc3hWWTDTTrwSPM
	 dOnotwoYhl9hucKunzoyUSMsV3Qnor84QB9eifHIyDrEIU5DrwXvF4jEIox+WddiRh
	 JRlkKewWBGxWmd7g/ubV5rdCVD5PvdPJEa6RpY/iTr8b/ZEyq+aX4Z63svWX3dnGjX
	 nky+TxeRizURA==
Date: Thu, 28 Aug 2025 11:29:43 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: tpm-protocol@lists.linux.dev
Cc: tpm2@lists.linux.dev, linux-integrity@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: tpm2-protocol: mailing list for patches and discussion
Message-ID: <aLATd85uZQGfMfrP@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I have ML now: https://lore.kernel.org/tpm-protocol/

Patches and discussion: tpm-protocol@lists.linux.dev

More information: 
https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/tpm2-protocol.git/tree/README.md

BR, Jarkko

