Return-Path: <linux-integrity+bounces-2710-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EC18D44D8
	for <lists+linux-integrity@lfdr.de>; Thu, 30 May 2024 07:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7D4F1F21E0F
	for <lists+linux-integrity@lfdr.de>; Thu, 30 May 2024 05:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5B4143C59;
	Thu, 30 May 2024 05:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRxhcyJw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9642A143881;
	Thu, 30 May 2024 05:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717047562; cv=none; b=d/YAPVFHsrsTFZCXRpT4iX4uEuR8d5hwFrNl0AB5pHhg35k8YOWsmBYuYE2AABOjenPVPi+tLPHwnuaOuXB1fSnIbv7lJSvOhTgHh2pCEnEV8tfk0j8NzcOEBB7v4aDe/oTDCYASwp7YED2rsIqQV4rN1/G6/kEPF6UXiwReqzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717047562; c=relaxed/simple;
	bh=4wqCGR8PxhrYHDAcLLZG9ohQGaRjJbfGM64BelJNi8U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=mPXPAf0FhQv3nhlt3f92jkTPtqn2o39BsJo9HjFpwaqKSkbBSF9EAac5PS3hw1vICHj0r7mv3M6PJKtcFltSF+94LVAuhPt1JMmllpfDQHnKOI5BRc4Bc4K6K6vnMahBRY74w8xtJXJSBmXkj/sY9UhAALC1/lV9gE05unt0A94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRxhcyJw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23C6C2BBFC;
	Thu, 30 May 2024 05:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717047562;
	bh=4wqCGR8PxhrYHDAcLLZG9ohQGaRjJbfGM64BelJNi8U=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=bRxhcyJw/dRobV6FVR28Pvg2HWPGgj9dao3fh+3Op6Vs8FH7LgRb6kG+s26PQY33H
	 ytjVT4Lnlwhesc2gQhJchrZrkmH3tGRB9jaREbiPOWn5oi57QCZevklURmU0x0Ih83
	 v8CnAXYsqxh3YzZsPHo6aFf1xoWBl1lIBEp1rjn8v1tzEDSo/OdIqp+ULun85Rz9h8
	 ew4TSCPmIAHWmWA3o8ojkQ9Uwl/Tr8qrfybmzVLQZX0gYhuaobcqtpF231FAEjEQ0n
	 Rlil7gNSnxLco462t6inN+j0KwX3dDr245pAIzn585fcKBskBA6/fYusE4lGr6XHBU
	 zLhdKqi6jwN9Q==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 May 2024 08:39:14 +0300
Message-Id: <D1MQK4XPVIUW.2EUDV0050EY5L@kernel.org>
Subject: Re: [PATCH] KEYS: trusted: add MODULE_DESCRIPTION()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jeff Johnson" <quic_jjohnson@quicinc.com>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>
Cc: <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel-janitors@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240529-md-trusted-v1-1-56c9a0ae8e28@quicinc.com>
In-Reply-To: <20240529-md-trusted-v1-1-56c9a0ae8e28@quicinc.com>

On Thu May 30, 2024 at 4:02 AM EEST, Jeff Johnson wrote:
> Fix the 'make W=3D1' warning:
> WARNING: modpost: missing MODULE_DESCRIPTION() in security/keys/trusted-k=
eys/trusted.o

Maybe instead:

"""
KEYS: trusted: Add the missing MODULE_DESCRIPTION()

kbuild reports:

WARNING: modpost: missing MODULE_DESCRIPTION() in security/keys/trusted-key=
s/trusted.o

Add the missing MODULE_DESCRIPTION() macro invocation.
"""

BR, Jarkko

