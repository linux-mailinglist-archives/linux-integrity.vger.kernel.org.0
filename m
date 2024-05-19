Return-Path: <linux-integrity+bounces-2465-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A166B8C94A7
	for <lists+linux-integrity@lfdr.de>; Sun, 19 May 2024 14:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8FC1F21436
	for <lists+linux-integrity@lfdr.de>; Sun, 19 May 2024 12:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB013D96D;
	Sun, 19 May 2024 12:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pu9fBiY5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B73DF58;
	Sun, 19 May 2024 12:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716122974; cv=none; b=gX9qzsEjBRNm1ck7YaV/ukhcbxGEIHLULsbX0QdYOM8uH3L2Tjdv++qOoHy/MI8u048va3U5ovCOusUqgcxlEM3RMa1Wxb4kfN8kMUuOfBikBAFhRzuAg8Tm/nkMm7A7Jn1V2OYgKrdweLMJno3Ytsp+l4okW00KCkNzielbuCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716122974; c=relaxed/simple;
	bh=5c6KJP9+iCfjzaILwM7txlwQN7YH/0G77q+/VLJR75Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=ugkmX+Ys2K4w041Ps6WtM6LwZfzmU9FUjLDtBQVaCvOPnPaTpTrbTE8BUcB7eE+uErHXwNS5uF/bJILHbuUm9sAJlIMdPgPOK96pjZHxNvdllWyyr3PYaHsXnRZkDlB2m8Stdtk/g9Lfgx+qOlVGUMhLAQTNFAsfCphZmkJFWCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pu9fBiY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CDCDC32781;
	Sun, 19 May 2024 12:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716122973;
	bh=5c6KJP9+iCfjzaILwM7txlwQN7YH/0G77q+/VLJR75Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pu9fBiY5sUYW+kaSaQAsHpOYqf6ezgVhR63MS0OeE3XNnO9jKmp2fM4hhReBGI9m5
	 hV9KzFBgUn+H/+fFMXEqbrSG7MprlfUioOWRjjotk14fYKLJA/p/uKqJFIzc2uVYn/
	 pqE6FJLnApKT+hss/8NGm+JXSxpHrfF98A04/cCeGIOi7qlZ0DdgmbaUEbWaDk75xN
	 ZdrLFVekaKSof67XtRtDzXFPPkr1hVbmIir2F9CU12M4KTIZO/aLjbJWadLvJheoPF
	 wrOTW3vNQ/pwDoPwduqahuG0zI9Q6MriCzcjvwk+lAV0jVNyplCkXiNEvcsT6I2xHQ
	 2XBetNTBAqNMQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 19 May 2024 15:49:28 +0300
Message-Id: <D1DMTJYL7TFC.3J3FM36K06ECD@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Herbert Xu"
 <herbert@gondor.apana.org.au>
Cc: <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <Andreas.Fuchs@infineon.com>, "James Prestwood" <prestwoj@gmail.com>,
 "David Woodhouse" <dwmw2@infradead.org>, "David Howells"
 <dhowells@redhat.com>, "David S. Miller" <davem@davemloft.net>, "Peter
 Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>, "Stefan Berger"
 <stefanb@linux.ibm.com>, "Ard Biesheuvel" <ardb@kernel.org>, "Mario
 Limonciello" <mario.limonciello@amd.com>, "open list:CRYPTO API"
 <linux-crypto@vger.kernel.org>, "open list" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 0/5] Asymmetric TPM2 key type
X-Mailer: aerc 0.17.0
References: <20240519002616.4432-1-jarkko@kernel.org>
In-Reply-To: <20240519002616.4432-1-jarkko@kernel.org>

On Sun May 19, 2024 at 3:25 AM EEST, Jarkko Sakkinen wrote:
> ## Overview
>
> Introduce tpm2_key_rsa implementing asymmetric TPM RSA key.
>
> I submit this first as RFC as I could not execute the keyctl padd in the
> following sequence (returns EBADF):
>
> tpm2_createprimary --hierarchy o -G rsa2048 -c owner.txt
> tpm2_evictcontrol -c owner.txt 0x81000001
> tpm2_getcap handles-persistent
> openssl genrsa -out private.pem 2048
> tpm2_import -C 0x81000001 -G rsa -i private.pem -u key.pub -r key.priv
> tpm2_encodeobject -C 0x81000001 -u key.pub -r key.priv -o key.priv.pem
> openssl asn1parse -inform pem -in key.priv.pem -noout -out key.priv.der
> key_serial=3D`cat key.priv.der | keyctl padd asymmetric tpm @u`

After v2 changes it ends up to -EINVAL and:

OID is "2.23.133.10.1.3" which is not TPMSealedData

which makes total sense. James' old patch set has already TPMLoadableKey
parsing PoC'd so I use that as the reference.

After the sequence above successfully completes keyctl public key ops
are accesible by using $key_serial as the serial.

BR, Jarkko

