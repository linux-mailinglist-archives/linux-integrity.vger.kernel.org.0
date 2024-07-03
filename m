Return-Path: <linux-integrity+bounces-2976-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F47924CF3
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2024 03:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFEDF2830BE
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2024 01:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47160621;
	Wed,  3 Jul 2024 01:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1zwOFf7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116A633EC;
	Wed,  3 Jul 2024 01:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719968564; cv=none; b=ryiQSyWYHWkx5S6d+svAk5KzmXgLA4WDDLHmPwwMBCkdWXb6YbD3d+7qiWMfSFcVF62a2tT17CDakxEYuLjvMh1eniTd7PN7rRf5EsQf82z2ClwaoO9c+1SPPypdWNaW0NJacoA5GQr3X9muqHjSFA9ctsrgIOvXhwnvK7l/mKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719968564; c=relaxed/simple;
	bh=c/gXnwPNnzdukWWfkJ7Qka//R0UAcsn4I6dRkZtRk9s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=RCv72qjfLhWRGWDiNz205UGT9Gcg6lb2AYgDYyA+/J5jfBc3HYCGGc4jBpudSxyEFmJe6Ih3yUcLqJBpDRtBlyvkU40DFVcrqXPPwtPS7GDayAQ53bJfJ0QdQ7Vfu8N9X7JPH8Y59d4wN3ddHJNBT6cx6JBOhuoe0hrKAC5j0GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1zwOFf7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0E5C116B1;
	Wed,  3 Jul 2024 01:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719968563;
	bh=c/gXnwPNnzdukWWfkJ7Qka//R0UAcsn4I6dRkZtRk9s=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=O1zwOFf7Ltz0cFmSiUion3KhOFixneddMP+X/wXDfV0QbMxxKt1HalypBWgvfM+EC
	 QnWqvaR+ARnsyqbaQXiJaiEqWdSePlc3JH3YA1CEDv7NeK/Pu0H8tolFFT9FERL+vb
	 l+VFObZGMuGaJ1/EHrT212ih2iAb/ruBVZfEsbGyIs0RGsQyGfGGD6H/HFI2jHV1V2
	 f43bXSoLRpOpmHgbxljowRkKusU3Hxbu8n4DrAUhn1WIdyi+wj5eiqP5eRm5W0i6go
	 VM5/WWiKoyYn9TtoV26ecz5MvpNgtGHT5y81WDkCC4Z6pUEI3MVRLpKU/19GRzL1Q5
	 cylN6wdAnzijg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jul 2024 04:02:38 +0300
Message-Id: <D2FHYVV7GNCV.3G1XOEUI3LZFB@kernel.org>
Cc: <stable@vger.kernel.org>, "Stefan Berger" <stefanb@linux.ibm.com>,
 "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, <linux-kernel@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] tpm: Limit TCG_TPM2_HMAC to known good drivers
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240703003033.19057-1-jarkko@kernel.org>
In-Reply-To: <20240703003033.19057-1-jarkko@kernel.org>

On Wed Jul 3, 2024 at 3:30 AM EEST, Jarkko Sakkinen wrote:
> +	depends on TCG_CRB || TCG_TIS_CORE

Needs to be "depends on !TCG_IBMVTPM":

https://lore.kernel.org/linux-integrity/D2FHWYEXITS4.1GNXEB8V6KJM7@kernel.o=
rg/

BR, Jarkko

