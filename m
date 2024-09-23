Return-Path: <linux-integrity+bounces-3668-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A1097ED3E
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Sep 2024 16:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5FB4B21516
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Sep 2024 14:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D43198E81;
	Mon, 23 Sep 2024 14:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gX022ahG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7AA6EB64;
	Mon, 23 Sep 2024 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727102194; cv=none; b=POC6A4uP2MFEQI5ot22mUM26abg5P22U8rLl3+QS34V0ay5fvG47hixscAO3NZEoCebYSVKkY3I8Ap40MsqVVLw2mqGmpkfOein1EGdLCpAZP2sor2/rObVRNqCMiJK/JItamCviSnfuKkoUZgCmN9ADbQ6wfGl3kTeRyxR7jtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727102194; c=relaxed/simple;
	bh=+BzfP0mGVOC2tMF2QnGOKzwHbkVx2MGDthHAVw+8j/s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=IlF5mE2PZHxETR6jicNR+QXxt/F5NUnRhWes/sI4Iw1DeM8Ax78CWF2BzELAIXVZEndaR/0ikD9cRPcnY2x/E3qSDgmguyM4R0DbgQlGLUXoxePBWeI/8ZHy9D5ctF/XI2VuDMmFMbxik21AM3p+gTr2XvL7KJaj+jm1jSsvFGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gX022ahG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EEB5C4CEC4;
	Mon, 23 Sep 2024 14:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727102193;
	bh=+BzfP0mGVOC2tMF2QnGOKzwHbkVx2MGDthHAVw+8j/s=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=gX022ahGdrTEcpNgV3LbumnSYzBiqOK2YwFuW3pfohCcMQR3rz0eh/AkcINybhAIs
	 hbZx6U96ic1v5FFwH9g/ItZMOaoFOacHFXNstyNYncitIEEP9KUCVn2Y3FCJwkWYm+
	 WtptNklQ8SHgL6LZEMYXKlW1S3lNzW9aRz2KRPNpt9hd0uyf0c/E++iqC21JZhu7Zk
	 vO5HzZCdkFRp0MptGD8gYcyQbfjgz7c/PpBKn1DPWKLasUsgM/FqSoMicsVITIeYaj
	 MpR8/KvGTaPioe4gNZw3ReIGNeLQfV5Dw6PZeSH0sZAhG+7smSYP5+XlIofYUnWICK
	 hf8kIe8gdzdSQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Sep 2024 17:36:29 +0300
Message-Id: <D4DQMOQWYZ4I.3B7OOCVWWRVZA@kernel.org>
Cc: "Linux Crypto Mailing List" <linux-crypto@vger.kernel.org>, "Guangwu
 Zhang" <guazhang@redhat.com>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH] hwrng: core - Add WARN_ON for buggy read return values
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "Greg KH" <gregkh@linuxfoundation.org>
X-Mailer: aerc 0.18.2
References: <ZvEFQAWVgWNd9j7e@gondor.apana.org.au>
 <D4DI1M1ELFXK.2COGZN6O5HABD@kernel.org>
 <ZvE0NrOC00ojRe3t@gondor.apana.org.au>
 <D4DQJ34I5FSD.1K618VWEKI7IW@kernel.org>
In-Reply-To: <D4DQJ34I5FSD.1K618VWEKI7IW@kernel.org>

On Mon Sep 23, 2024 at 5:31 PM EEST, Jarkko Sakkinen wrote:
> Greg, did we have something under Documentation/ that would fully
> address the use of WARN?

... personally I think that even if there was a separate document, this
should be somehow addressed already in SubmittingPatches so that it
can't be possibly missed by anyone.

BR, Jarkko

