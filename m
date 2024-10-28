Return-Path: <linux-integrity+bounces-3927-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DAA9B34C8
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Oct 2024 16:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17DEA1F22BFF
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Oct 2024 15:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637FB1DE3DD;
	Mon, 28 Oct 2024 15:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mitmURvN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337321DE3C7;
	Mon, 28 Oct 2024 15:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730129246; cv=none; b=TBzIRuns4/n9PJ5OarHFBcd3Y5GCwvFzd2fTqZImLT+L+kPgzVPvXJ+OYXVxr6V9wiAzg8KglbLLwJ8SC5c4Pj/qfs4nCYcjkf2rBZL0QLG2rx3A4dbbDk0hHK0rnCbxiITOKUusJ+wgcqehR0Gg5nukURtewjhhLdVEV2MUv0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730129246; c=relaxed/simple;
	bh=Z325oQiglIYd+vK+uL66gzb3t2eRQRD/bh38l5IqgSw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=DoB0P+pnsgYACcU/CEd6mV79pPkqqRty4k5IT//QjUS7vqDBZcFdXHmYzSuY+a8tqwVpPcbeRyJWC0YWYhI9VWBHus0+WqLTLukNCh8qOsPcpfvdhGlvxENHmUM1mHiwFK2KQMfBOwC60Un7Yj0amhx8CEu3uOHrF7RqhE65idE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mitmURvN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6896AC4CEC3;
	Mon, 28 Oct 2024 15:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730129245;
	bh=Z325oQiglIYd+vK+uL66gzb3t2eRQRD/bh38l5IqgSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mitmURvNzdmUJK7jVnTzRuW/dAIKyKoMQMy6pLs5T3FFyK8KF+Hhq0EF7UMPoNM0P
	 C/V238863VEnRHd81yP5BfIxai0XCsYdYbIsArqTW584fhIfBsl9+xQNCSepiWOApO
	 XavqcpF+tbKloK28ZuTXt2nWMTlizSlwB6njh7HiqXi6A67ksl62pnlymSM9NnbA2m
	 dg2/JsrAfQkBm+Ty2o4WZpEkzyITBlM2REklTRlvruOIgqi2QRBHFV0sQV8uCjKj0v
	 yp6PvFws9A1O2KoVcI8Ha2wz++4N7waK35o1OD0omXfs2cO7cC7SXM4ZW4wwO4XPRY
	 k4WyzfipcsnsQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Oct 2024 17:27:21 +0200
Message-Id: <D57JMPA3UYWU.3CJ5XOL06SW7I@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>,
 <linux-integrity@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>
Cc: <linux-kernel@vger.kernel.org>, "David Howells" <dhowells@redhat.com>,
 "Mimi Zohar" <zohar@linux.ibm.com>, "Roberto Sassu"
 <roberto.sassu@huawei.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "Dmitry
 Kasatkin" <dmitry.kasatkin@gmail.com>, "Eric Snowberg"
 <eric.snowberg@oracle.com>, "open list:KEYS-TRUSTED"
 <keyrings@vger.kernel.org>, "open list:SECURITY SUBSYSTEM"
 <linux-security-module@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v8 1/3] tpm: Return tpm2_sessions_init() when null key
 creation fails
X-Mailer: aerc 0.18.2
References: <20241028055007.1708971-1-jarkko@kernel.org>
 <20241028055007.1708971-2-jarkko@kernel.org>
 <04887ab4-3e30-467a-973c-4c004283476e@linux.ibm.com>
In-Reply-To: <04887ab4-3e30-467a-973c-4c004283476e@linux.ibm.com>

On Mon Oct 28, 2024 at 3:00 PM EET, Stefan Berger wrote:
>
>
> On 10/28/24 1:49 AM, Jarkko Sakkinen wrote:
> > Do not continue tpm2_sessions_init() further if the null key pair creat=
ion
> > fails.
> >=20
> > Cc: stable@vger.kernel.org # v6.10+
> > Fixes: d2add27cf2b8 ("tpm: Add NULL primary creation")
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

Thanks, patch are applied to

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/log/=
?h=3Dnext

I will amend these with any further changes (such as tags).

BR, Jarkko

