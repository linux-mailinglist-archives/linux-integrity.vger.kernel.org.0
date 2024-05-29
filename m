Return-Path: <linux-integrity+bounces-2695-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 878408D3638
	for <lists+linux-integrity@lfdr.de>; Wed, 29 May 2024 14:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECF78B24937
	for <lists+linux-integrity@lfdr.de>; Wed, 29 May 2024 12:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFEF181305;
	Wed, 29 May 2024 12:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhqUIqsF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEB3180A97;
	Wed, 29 May 2024 12:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716985231; cv=none; b=iGhrBg+udyZLInOQIbXNhY8E2ouZHQ15qfSepkLSoFkfiH1ZiDmLv5gCrjoi1MvgvM6+9JKS1Ef6pnu3HDevyoAUAoZHLK7telGoiLJ8jpR5S7iXsVZoGBdmE3l6LdDABNMQ3EhuJSm44ANRbIkP38mHBlYAjJ2VSznqoLAMbDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716985231; c=relaxed/simple;
	bh=VpHIdGNzMITuTJTo8IHKIYXLIDv6AXCePiPAEtOFDFo=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=uWe2y1AS3vrIWaV3mf0lqb9Ur7v6l+lULXqtcmfx+/TI1QIshBgWIoQI7iSCAGZKPM1X4OhTUokilCT6Mh2+JfQ9z1pjrm3tYDceD3wwrjjmMJpUUz1CJMpE4MV705xRZcVrLFIhHfptwJyu0UxH2SpzPv9iO4hrpxayPgsGAoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhqUIqsF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66876C2BD10;
	Wed, 29 May 2024 12:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716985231;
	bh=VpHIdGNzMITuTJTo8IHKIYXLIDv6AXCePiPAEtOFDFo=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=AhqUIqsFLYOCebwLbUCnjjUx4VRWTD0BnXxREMkocMYUA64uSMLDspnGAE5xJYbTk
	 SKotVExoVXb+3cXSp9SmBqPsJWhEs9sfZ8J/MWbC1fW21KUnPN55O21n7nOtem/RsD
	 eXUaBO6NSuijG9knpgRAZJljAdYrfu1RHxGw8itCCd2HtGX5Y/HanvlZVfgNhI8UOL
	 cICgXQvSVZGJKY/G129/QZkCx1dV1KQOLnPpjw8Jk1r5yaAKa3Zs3HQgiWy/nH6rQG
	 mIQZbx18PK5VazXv6QgRoxNq7E79hjWos1ByswqeC7hmLiGCGgtf8z4QLDjuV3VKvV
	 dbL8l4DMLdfPw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 May 2024 15:20:25 +0300
Message-Id: <D1M4GRF0RL2W.3QHTBXZWNW9RW@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>
Cc: <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <Andreas.Fuchs@infineon.com>, "James Prestwood" <prestwoj@gmail.com>,
 "David Woodhouse" <dwmw2@infradead.org>, "Eric Biggers"
 <ebiggers@kernel.org>, "James Bottomley"
 <James.Bottomley@hansenpartnership.com>, <linux-crypto@vger.kernel.org>,
 "Lennart Poettering" <lennart@poettering.net>, "David S. Miller"
 <davem@davemloft.net>, "open list" <linux-kernel@vger.kernel.org>, "Mimi
 Zohar" <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul
 Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "open list:SECURITY SUBSYSTEM"
 <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v7 2/5] KEYS: trusted: Change -EINVAL to -E2BIG
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240528210823.28798-1-jarkko@kernel.org>
 <20240528210823.28798-3-jarkko@kernel.org>
 <14d0baf4-fa41-4a08-925d-90f028117352@linux.ibm.com>
In-Reply-To: <14d0baf4-fa41-4a08-925d-90f028117352@linux.ibm.com>

On Wed May 29, 2024 at 4:50 AM EEST, Stefan Berger wrote:
>
>
> On 5/28/24 17:08, Jarkko Sakkinen wrote:
> > Report -E2BIG instead of -EINVAL when too large size for the key blob i=
s
> > requested.
> >=20
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

Thank you.

Hmm... I'd like to add even:

Cc: stable@vger.kernel.org # v5.13+
Fixes: f2219745250f ("security: keys: trusted: use ASN.1 TPM2 key format fo=
r the blobs")

It turned out to be useful error message and would be useful also for
stable kernels. So if no decent counter-arguments, I'll just pick it
to my master branch.

BR, Jarkko

