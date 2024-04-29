Return-Path: <linux-integrity+bounces-2289-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBCC8B66A3
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Apr 2024 01:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C98C81C20AFB
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2024 23:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A450194C69;
	Mon, 29 Apr 2024 23:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6Hky8m4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0E56CDD3;
	Mon, 29 Apr 2024 23:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714434544; cv=none; b=qXHqLw2//wDqicGXqNXLHC3H+lKsWv075h5cGvNX5Kim1q1z4H81ZAvmeOHq//ZJvmPg3wwZat0NnpqQc/gM6y/2WBEGwUBxb9SHryNKBJCUVEzRimDVhdAXxMIjmsoc1kjHesihWwZbZTONw6VNaFur2pRO+1acpXNX5PJOGPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714434544; c=relaxed/simple;
	bh=xSsQXyOrQ6MPJvJqVpEYKRwWhsrjUFKtBiWlBvmxFRw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=qBZWE5N4HXlaVSbNOe2bkJoXGZQYRjSOQbqea7p6M2E3Lbgxc2R+vubO5eFrjj+Hlrc5OqYlSxiJxso2Xkur2hQLMSTiJ4zv4BC1LFRDYLZkmuOG7BpafYrVTXYEns9ti+z0d0FanDk9NT7vngo1kx6R+LY7PC5xZyMnmnLB0gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6Hky8m4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF92EC113CD;
	Mon, 29 Apr 2024 23:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714434544;
	bh=xSsQXyOrQ6MPJvJqVpEYKRwWhsrjUFKtBiWlBvmxFRw=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=k6Hky8m4yRGlTQul66L3eTiLkyzKpEvK5uKori74b5BEUsfWvw+TYFDpStk9juEdG
	 ejiaCCZcmuv3ZxhLmmy5kNgyKmFA0NTDXq4n8SZavAePCEDYvqAnfG+J+jm4Fy+SKO
	 96MfIhkEQ77xNNLsQJlKUprvIK6XtUMhu2pbrT1wKdajc0Sx33G+e4aNiBaw1vfvgv
	 AFMbcbTHzuUM2e4po+XFLFRROtim686lb99t82XA+5kXCXIR4dWSMBnTJxLK/T99aV
	 pajFt/SOu9PIHFIofxff4ln999wJSWwfWQrsK/V7Y+7rBkdw0/gO7YpBe3JwQKBhHi
	 4/nwTe/sSwoew==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Apr 2024 02:49:00 +0300
Message-Id: <D0X0BN0RI4UG.2T8WRIFTWXE96@kernel.org>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v8 00/22] add integrity and security to TPM2
 transactions
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, <linux-integrity@vger.kernel.org>,
 "Stefan Berger" <stefanb@linux.ibm.com>
X-Mailer: aerc 0.17.0
References: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
 <D0WYH9UDXCZC.3OZ9MSOVTDBE1@kernel.org>
 <D0WYKBCRV1BS.EWPTEY7QUG85@kernel.org>
In-Reply-To: <D0WYKBCRV1BS.EWPTEY7QUG85@kernel.org>

On Tue Apr 30, 2024 at 1:26 AM EEST, Jarkko Sakkinen wrote:
> Right and obviously 3rd option is to send a PR to
> https://gitlab.com/jarkkojs/linux-tpmdd-test.
>
> I.e. patch file goes to patches/qemu (BR2_GLOBAL_PATCH_DIR
> points there).

Stefan, can I do a "zero QEMU changes" negative test for
changing null seed by somehow reseting swtpm? That would
be best possible option (if it is possible).

It does not matter what side-effects it has on swtpm side
as long as the hmac path gets invalidated, as then the
device is rendered as unusable.

BR, Jarkko

