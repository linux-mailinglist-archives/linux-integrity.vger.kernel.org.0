Return-Path: <linux-integrity+bounces-1994-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F4F89743C
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Apr 2024 17:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1D1F285063
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Apr 2024 15:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FC21E871;
	Wed,  3 Apr 2024 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXwlj+pf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46481494D3;
	Wed,  3 Apr 2024 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712158999; cv=none; b=cEmKeoUxi0XXSLu7/XHmpRuvVvi9L8TOhUGnEbux//8gFFV92SaMXTzjc0rhN/PUUh0rzKqV5rtSXqzCsRcZliDouoUTDEeN6GSSAccld8yuMIipE3Rz59S30hJ6W9Z9L+JJD3gB32Sr6w7XXcrMeSZDFa9MbVrFXi4Wc5PGZQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712158999; c=relaxed/simple;
	bh=PtICiElJcVPNWAUIq6pUyg4yR41atjsu+gsz1WbLHB0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=PYI7e5dqvTyo7hZdI0NTolXoFMr+XhNMgywaHEpGXRducF4EWZM1iwvwcvnseT85UlznuqL82ipYZyL9nNIbMfOpvxGfWmZWni+ZtRRN9q+YugT2s3h3RJkiv7KMgny+dL/NyOn2oaJW9IigkcHo266ljztwDwjgx4nN1izJI6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXwlj+pf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205E6C433F1;
	Wed,  3 Apr 2024 15:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712158999;
	bh=PtICiElJcVPNWAUIq6pUyg4yR41atjsu+gsz1WbLHB0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=cXwlj+pfyj+sTGNY92JLZjCwdfYtkvFKEZowPoYQfPtjQDCrFiycYGzbRHe2uaUJy
	 AQLsxfXGsBC8c5BaL75slco/FBXRTwviq/B48A6QN7GbjpQxFEZXFllQuRRDHGCQ9G
	 5yZog5YFlGaDqZgk2AKsH+DQQDmNUXCgIJ7/MdGnY/PKa144C49YDX1bFvk3ZoydsK
	 EZXZgOChosaMKzw2lY4G6dfmeXz6R1PDGu04e27co4d+H51vt62bGmTwUYDEGoq31s
	 5SFZXlZdypeIJUEETz1lEWW+weUZs4ZE6O0Vkt3c2MFZnv/wn2XGBKfXyaKLGzi/GO
	 XOFcpwehfU6hw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Apr 2024 18:43:16 +0300
Message-Id: <D0ALPKFAOB74.1PQT8QI6416G@kernel.org>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v7 12/21] tpm: Add NULL primary creation
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ken Goldman" <kgold@linux.ibm.com>,
 =?utf-8?q?Gabr=C3=ADel_Arth=C3=BAr_P=C3=A9tursson?= <gabriel@system.is>,
 "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>
 <20240213171334.30479-13-James.Bottomley@HansenPartnership.com>
 <05c7d10b23e74269efd720eedbb1773931b0ad46.camel@system.is>
 <D08273C2C8HD.2QT57ZPAWPS9H@kernel.org>
 <ea2a3a9a2bea2f1af5565ed32e9584caee2fbecf.camel@system.is>
 <2fb01074-e7a2-403c-8d46-d2b2323c231e@linux.ibm.com>
In-Reply-To: <2fb01074-e7a2-403c-8d46-d2b2323c231e@linux.ibm.com>

On Tue Apr 2, 2024 at 10:30 PM EEST, Ken Goldman wrote:
> On 3/31/2024 12:52 PM, Gabr=C3=ADel Arth=C3=BAr P=C3=A9tursson wrote:
> > The TPM specifications have a standardized set of templates for the
> > Endorsement Keys, and a recommendation on a template to
> > create/provision the shared SRK.
>
> The original TCG guidance document for an SRK used arrays of zeros for=20
> the unique field.
>
> This was either a holdover from TPM 1.2, where arrays were 20 bytes,
> or a misinterpretation of text that said: NULL.
>
> The reality is that it's a TPM2B, and the size(s) can be zero.
>
> The answer for the EK is different. It has to use the TCG
> standard.  The EK is not a 'guidance document'.

Does anyone follow TCG's provisioning guide? I.e. is it implemented
"in the industry"? I'm just trying to understand the real value of
this document.

BR, Jarkko

