Return-Path: <linux-integrity+bounces-4050-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4759BFE69
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 07:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EB20283E18
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 06:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DB8194120;
	Thu,  7 Nov 2024 06:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Al8KTCxo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACE416419;
	Thu,  7 Nov 2024 06:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730960651; cv=none; b=XmQLIxuAAbL4/PcwS43sYWbhaq3UO7xMmyanCntkAlpjGd0cOOswQRNS6G2cxAyaL8X/Gt/8LGt4z+i408Lt7sCZZUB4K4VLL+bJ7N/hxd1DfvBO6h4qnEL6jrQFrYolcoWyKR0InDGKtxXsxAK4ldrEhNLcjgom02XGypB2pvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730960651; c=relaxed/simple;
	bh=JCiisxEYbTzX9rH/fwN6Tp3/oMIqUY575iDAgbG1l9s=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=mitcqSI+rmT3T9vDnqUvoHFf4CNLhyCANOMzUrcwPIgajASCpHqJKvew7HQgv2JA3RlRrfl/A9LQ6M291SRB3eYd/NF0o4f1Tqb1fZqkPhjQtM5qFguQULmqfr5Je3IIBRvStYXbuopfS4CS7bBTFD/s5s6N1EQmrNO6IpVdvYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Al8KTCxo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0EF6C4CECC;
	Thu,  7 Nov 2024 06:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730960651;
	bh=JCiisxEYbTzX9rH/fwN6Tp3/oMIqUY575iDAgbG1l9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Al8KTCxoukmyEOId2O0zRcaGFjAWbBs9K4ms9/7QEwL0DLO5fs7U8chUCD9KKVrLO
	 CcDQPgeKX3f//Yh1wxv8qRJzpeRVqayCyGrULaK0JV4oeRpyooHRyzMDZlvAO+K6t1
	 24y5KJfk2xMfQfVETpBPAHK7ajpt4W66gsWuNEDZzO72wYGFwvVkUlU6qDFQHXjspS
	 TYE4lPAQiOpAej5eu7eU1imuLWW5u5Wy8z3XOMo8y2MKkQ2/OBqH+e65k8xQMqzIZM
	 TzfvY5OEgz6ZUJ5skYMxuURfvHIb9PgDcBWD7D/mdKEXH+wcWOOJ58ILMciPBseiti
	 EHpKzEEDOcnfA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Nov 2024 08:24:06 +0200
Message-Id: <D5FQC7G8OUAO.1A449Z8ADEA0E@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Mimi Zohar" <zohar@linux.ibm.com>, <linux-integrity@vger.kernel.org>,
 "Jonathan Corbet" <corbet@lwn.net>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>
Cc: "Roberto Sassu" <roberto.sassu@huawei.com>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Opt-in in disable PCR encryption on TPM2 chips
X-Mailer: aerc 0.18.2
References: <20241107004708.108667-1-jarkko@kernel.org>
 <D5FJ9VCD1JBL.22MQYQHUYJLJ8@kernel.org>
 <b510e556621e3826dd6df043fde817192b9f12ea.camel@linux.ibm.com>
In-Reply-To: <b510e556621e3826dd6df043fde817192b9f12ea.camel@linux.ibm.com>

On Thu Nov 7, 2024 at 4:48 AM EET, Mimi Zohar wrote:
> On Thu, 2024-11-07 at 02:51 +0200, Jarkko Sakkinen wrote:
> > On Thu Nov 7, 2024 at 2:47 AM EET, Jarkko Sakkinen wrote:
> > > From: Mimi Zohar <zohar@linux.ibm.com>
> > >=20
> > > The initial encrypted HMAC session feature added TPM bus encryption t=
o
> > > various in-kernel TPM operations. This can cause performance bottlene=
cks
> > > with IMA, as it heavily utilizes PCR extend operations.
>
> The patch Subject line and problem description aren't quite right.  In th=
e case
> of TPM pcr_extend, the session isn't being encrypted, only HMAC'ed.  Acco=
rding
> to James, it's the HMAC itself that is causing the performance degradatio=
n. I
> would remove the word "encrypted" throughout.

I have to say I disagree with that. Encryption is the feature we get
with HMAC and is more understandable for most. HMAC is implemnetation
detail.


BR, Jarkko

