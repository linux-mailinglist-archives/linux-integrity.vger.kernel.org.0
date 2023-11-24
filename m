Return-Path: <linux-integrity+bounces-202-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5359B7F6A38
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Nov 2023 02:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 897EB2817B0
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Nov 2023 01:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC1A646;
	Fri, 24 Nov 2023 01:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G37l3aM7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F31B63E
	for <linux-integrity@vger.kernel.org>; Fri, 24 Nov 2023 01:42:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1749DC433C7;
	Fri, 24 Nov 2023 01:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700790153;
	bh=meA6zEVLAnIoCnnApPSUpa0M4STnpaOaSqjkHxeRhuo=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=G37l3aM7IQU2UiaZFLasyIGu1aioj1geosiBZVr30RUGy9WlaLO2MnZWVPbBu2mu+
	 hQGGvdxhA4iYIBmLcpIxalxIQe0GN18jPPotMDxZObH/kKyPjr5zCvupoBgJNfD/Nd
	 0meFHu0JU4YwyWttSZqkTJH7PU4G/LyKR5gymwy/ZVnN3Q1Bv/2DmBg4ywnx5q58HL
	 3T+wp3BTnjuz4dYlX+yXmRBtSjbb8i9QVx4ONSbwsXsAtCqKs2QOhpD/IagMkFUZmn
	 E8WvirnzX5LNJ3z6dfmVjY+EFQiAR/+Xp3eLxaqtDzSzBnfi6Lq+EtqCboTFqqwojY
	 lI1cnBfiu5PIw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Nov 2023 03:42:29 +0200
Message-Id: <CX6NSGFJVYKC.3KFEPA92N0V53@kernel.org>
Subject: Re: [PATCH] tpm: Start the tpm2 before running a self test.
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Hermin Anggawijaya" <hermin.anggawijaya@alliedtelesis.co.nz>,
 <peterhuewe@gmx.de>, <jgg@ziepe.ca>
Cc: <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20231122065528.1049819-1-hermin.anggawijaya@alliedtelesis.co.nz>
In-Reply-To: <20231122065528.1049819-1-hermin.anggawijaya@alliedtelesis.co.nz>

On Wed Nov 22, 2023 at 8:55 AM EET, Hermin Anggawijaya wrote:
> Before sending a command to attempt the self test, the TPM
> may need to be started, otherwise the self test returns
> TPM2_RC_INITIALIZE value causing a log as follows:
> "tpm tpm0: A TPM error (256) occurred attempting the self test".
>
> Signed-off-by: Hermin Anggawijaya <hermin.anggawijaya@alliedtelesis.co.nz=
>

Firmware does TPM power on.

BR, Jarkko

