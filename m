Return-Path: <linux-integrity+bounces-2293-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 757AA8B7D77
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Apr 2024 18:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3122E2868D4
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Apr 2024 16:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF3117B4FF;
	Tue, 30 Apr 2024 16:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oG+CZKZ2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A71173351;
	Tue, 30 Apr 2024 16:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495755; cv=none; b=W3zj2JY3oJ9KfUi7PfnDHbpPKSs2esUiZohiBvqK6fr2FEOaB7e2P46QxqUfhXumBe9fbNTnxfjNgejq2hx+/yfUldEC6qimfHoKthhkVppZaiYSzC9Ac3WRoald3kKLayZ3auaUiMMvKR3VgyHDP2UgTzT9+JkxbWJeZYpxdYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495755; c=relaxed/simple;
	bh=ZBZVt7BmBwPwUahlkifa52TGTUrKSPYIc9y0HzLBWVI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=cq/6TIbRMYbiyE8uJmBzif20p3KYFSx7K3vSpNA2EYfteUoJUBV0nMTcHpY45KJZduSIGUQDMQkk1wNdfQb22Q98s3zWgd7hAbkw5cmeB9GyWlAp0XKsi4TRziAQBrcp+ilg+K2ayEntzbF1FfTsbsN7f8r+Yk4+kHiPGfE+5hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oG+CZKZ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0945DC2BBFC;
	Tue, 30 Apr 2024 16:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714495754;
	bh=ZBZVt7BmBwPwUahlkifa52TGTUrKSPYIc9y0HzLBWVI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=oG+CZKZ2ylKeKyQrmzO8lqortg6mwB+kzFv9mJW08NE9pKexsLQG9zNJOBCeIIgzn
	 b0rcvF6nmadpHQ9+h5i/60xVX+g/S4hWhpK6AzaKLoLM+9JgL1i0KiU7ouN1rZNY2g
	 xs2dvo2VQMAF0N9oVX8PxAQ6/SxSzv51gvJdoej5omYu2M+ABfECPyrgCBLlo3taXS
	 xIBu/tpEbL+pvbzsPa7qK2vLEL7/VGLvOfbnDqqGyxW7whZonm6k/lO/uIsu8jjPpr
	 CBTxXYBqaYx/AyhvQnVL4MWAxZHYg312xU41KaMUgdDwAnUSyrvHDogl4+lS+IAolB
	 Al4OztIPiEG6Q==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Apr 2024 19:49:12 +0300
Message-Id: <D0XM0R58DCE8.29PUSJY1VSMP9@kernel.org>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v8 14/22] tpm: Add HMAC session start and end functions
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
 <20240429202811.13643-15-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20240429202811.13643-15-James.Bottomley@HansenPartnership.com>

On Mon Apr 29, 2024 at 11:28 PM EEST, James Bottomley wrote:
> +	rc =3D tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_START_AUTH_SESS)=
;
> +	if (rc)
> +		goto out;

Have missed this one. The command code name is truncated, which we have
not done. It should be TPM2_CC_START_AUTH_SESSION.

Spotted this while thinking how to test the interposer scenario.

BR, Jarkko

