Return-Path: <linux-integrity+bounces-2474-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1335E8C9FEF
	for <lists+linux-integrity@lfdr.de>; Mon, 20 May 2024 17:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1387280D2B
	for <lists+linux-integrity@lfdr.de>; Mon, 20 May 2024 15:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F89137755;
	Mon, 20 May 2024 15:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpJG34v/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F4613774C;
	Mon, 20 May 2024 15:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716219867; cv=none; b=WpR0USPVVzKlGFsmMdixYvomdcMZ0ipP3yAq/DvEZuR/UGfSBWVORPORjRgoXzdYlw6YT23NjBZds4xeFrMGzykMmlk5zEWBstqTZsfGFQ7xnDIjiSnzk9NsU/0AwKxEzGWu8Q0fUKlUdxadytQuOSu57wGX2qkyq6QnBrQAUi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716219867; c=relaxed/simple;
	bh=/L4FskE1HfAHScBbUruTM2tjBuSCUX2t8pOV7GehlYs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=MF3vDxQxzbNxwe+O3Z9973AIXR+QEEHZzmyw+mm/Df8X0g/H7n2qHzWQ/jzC1Haa8fGpOCe1cBTOY/W92QzbAeP/osNpKmRZRC/uRbveu26EQkUIv41YOfvmmgHGCZQtNWejwGQNZ0m6q4JzQskLE7zolbk0HeOsHkAMn2D/ZTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpJG34v/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CC2C2BD10;
	Mon, 20 May 2024 15:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716219867;
	bh=/L4FskE1HfAHScBbUruTM2tjBuSCUX2t8pOV7GehlYs=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=QpJG34v/lOIJWRMRp1RBRrkH8ymaB5o0UPDpba70rf0d/jvmQlr5AoBK4PwxPHniS
	 89NvhOyKftO/PSEHPid9ByD2VGBSs961xR4bmeCjUyrmO6wcORpw+Hw7snZQH7Mj6W
	 FW4inGyvSKXQ3FKftp/NNbco3CNTsfNlMkyh95GZ5GlXi9n0iRRCUK7uk4xbvcloI4
	 lWDMwKwz5RKyaE2z5uKVBP9NZluUXNCOmT5RKyqVaxaYl+nSFoF6tPsMsoOyelBMXi
	 3WLer03ddSQ84LQCw3EzdTRWo3QfG80Tt38qIwqwLjHnbtjyVJc7OGfZRIoqOoin87
	 xFIZsqi6c7oRw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 May 2024 18:44:24 +0300
Message-Id: <D1EL6195XVCO.1T6R5B5AYTQQZ@kernel.org>
Cc: <keyrings@vger.kernel.org>, "Vitor Soares" <ivitro@gmail.com>, "Peter
 Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>, "open list"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Disable TCG_TPM2_HMAC by default
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240518113424.13486-1-jarkko@kernel.org>
 <41466b65a30a351d57869042e9f130cdb68aab5b.camel@HansenPartnership.com>
In-Reply-To: <41466b65a30a351d57869042e9f130cdb68aab5b.camel@HansenPartnership.com>

On Mon May 20, 2024 at 5:50 PM EEST, James Bottomley wrote:
> On Sat, 2024-05-18 at 14:34 +0300, Jarkko Sakkinen wrote:
> > Causes performance drop in initialization so needs to be opt-in.
> > Distributors are capable of opt-in enabling this. Could be also
> > handled by kernel-command line in the future.
> >=20
> > Reported-by: Vitor Soares <ivitro@gmail.com>
> > Closes:
> > https://lore.kernel.org/linux-integrity/bf67346ef623ff3c452c4f968b7d900=
911e250c3.camel@gmail.com/#t
>
> Hey, there's no response on that thread verifying the primary
> generation is the culprit.  Could we at least wait for a reply before
> taking such drastic action based on surmise?
>
> I'd be really surprised if it is primary generation.  If I used an RSA
> primary it would be a problem (My oldest TPM takes a couple of minutes
> to generate one) but the longest I've seen an EC primary take to
> generate is still less than a second.
>
> James

Nothing is going to happen before rc1 is out, it would be earliest rc2.

ECDSA should be always faster than RSA so you're right that it does not
necessarily make much sense, unless there are TPM2 chips with only RSA.

It might make sense to have at least a command-line option to disable
hmac.

BR, Jarkko

