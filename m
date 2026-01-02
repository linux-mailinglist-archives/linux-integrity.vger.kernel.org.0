Return-Path: <linux-integrity+bounces-8150-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA8FCEEFC3
	for <lists+linux-integrity@lfdr.de>; Fri, 02 Jan 2026 17:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 53FF630019F1
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Jan 2026 16:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541AF2C0270;
	Fri,  2 Jan 2026 16:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNZ3rrtY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221B22BD597;
	Fri,  2 Jan 2026 16:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767371709; cv=none; b=WEsnbiQtCrBPyVMEnctq/4qjJ4tRtRhlE0s0/Hxtf6819u5q9B+aXkNRT27kFacrxlj8v1K+SIsZ59Z/83Y4FSAgWiCch9eodKU+J2s1itV9dbSYn5RSdz+n1v4NWpiCm+eFqfwReoXLgvYn1babMD1lfOuMi4cfhII1Z9a3NZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767371709; c=relaxed/simple;
	bh=a9QqepiUNZ/479SAWKY7T4z6mKAQrOo4yN4/dDHoKJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zf4ds2woPS6j7RG7LqLwipO4Pq1KJpMd66fcZFR/h+0R0zHyRQoeY1pJRKOP+SlxfVMZI1aPqUkWyUJq23CinRKIi92IjnPs5wFQV2r3rdlUST3KqehB94tOpUo2KNTUO0veesXeGqyolD1gl1+L8y/gVKYqYUpOV20LPr6NBx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNZ3rrtY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66827C116B1;
	Fri,  2 Jan 2026 16:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767371709;
	bh=a9QqepiUNZ/479SAWKY7T4z6mKAQrOo4yN4/dDHoKJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SNZ3rrtYa4/J7lo1DsdBCtv7aJWJuacGbPcvDAJOoyCJ0NO9vf+vIiOLBmxluR81H
	 rC21BQlFctot0SIlIRaIe91TJSeWPlIxm3dyrU1dfgA64+1TPR1svpNpXMCCAKad1e
	 0/JKGwncwqzKEF7XxPO5CLb/VtqLtZxhqIS8u2UB+80QVBP/OCVsDrrQoPpEza4Rqq
	 RrCKaxJxs9hVXaI8w/nigHDWrVl2NQ8n1cW7XZk62M+DNxP6ayNa+CCTZ5vK7cqyQc
	 Zh6FQM/RlAknbhPixlPIWU2kI4LYNVBJ/fLy277Q4f9Kz0obM+MPhPLshxf5P6cMrW
	 b7VbF2TQY+KeA==
Date: Fri, 2 Jan 2026 18:35:04 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v8 05/12] tpm2-sessions: Define TPM2_NAME_MAX_SIZE
Message-ID: <aVfzuIrKkGR5ZpRv@kernel.org>
References: <20251216092147.2326606-1-jarkko@kernel.org>
 <20251216092147.2326606-6-jarkko@kernel.org>
 <aUUbkosWlOjZ48YP@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUUbkosWlOjZ48YP@earth.li>

On Fri, Dec 19, 2025 at 09:32:02AM +0000, Jonathan McDowell wrote:
> On Tue, Dec 16, 2025 at 11:21:39AM +0200, Jarkko Sakkinen wrote:
> > Define TPM2_NAME_MAX_SIZE, which describes the maximum size for hashes
> > encoded as TPMT_HA, which the prime identifier used for persistent and
> > transient keys in TPM2 protocol.
> > 
> > Set its value to 'SHA512_DIGEST_SIZE + 2', as SHA512 has the largest
> > digest size of the algorithms in TCG algorithm repository.
> > 
> > In additionl, rename TPM2_NAME_SIZE as TPM2_NULL_NAME_SIZE in order to
> > avoid any possible confusion.
> 
> One minor capitalisation nit, otherwise:
> 
> Reviewed-by: Jonathan McDowell <noodles@meta.com>
> 
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > v6:
> > - Rewrote the commit message.
> > v2:
> > - Rename TPM2_NAME_SIZE as TPM2_NULL_NAME_SIZE.
> > ---
> > drivers/char/tpm/tpm-sysfs.c     |  2 +-
> > drivers/char/tpm/tpm2-sessions.c |  2 +-
> > include/linux/tpm.h              | 37 +++++++++++++++++++++-----------
> > 3 files changed, 27 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
> > index 94231f052ea7..4a6a27ee295d 100644
> > --- a/drivers/char/tpm/tpm-sysfs.c
> > +++ b/drivers/char/tpm/tpm-sysfs.c
> > @@ -314,7 +314,7 @@ static ssize_t null_name_show(struct device *dev, struct device_attribute *attr,
> > 			      char *buf)
> > {
> > 	struct tpm_chip *chip = to_tpm_chip(dev);
> > -	int size = TPM2_NAME_SIZE;
> > +	int size = TPM2_NULL_NAME_SIZE;
> > 
> > 	bin2hex(buf, chip->null_key_name, size);
> > 	size *= 2;
> > diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
> > index 4149379665c4..525b8622d1c3 100644
> > --- a/drivers/char/tpm/tpm2-sessions.c
> > +++ b/drivers/char/tpm/tpm2-sessions.c
> > @@ -137,7 +137,7 @@ struct tpm2_auth {
> > 	 * we must compute and remember
> > 	 */
> > 	u32 name_h[AUTH_MAX_NAMES];
> > -	u8 name[AUTH_MAX_NAMES][2 + SHA512_DIGEST_SIZE];
> > +	u8 name[AUTH_MAX_NAMES][TPM2_MAX_NAME_SIZE];
> > };
> > 
> > #ifdef CONFIG_TCG_TPM2_HMAC
> > diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> > index 202da079d500..e10f2096eae7 100644
> > --- a/include/linux/tpm.h
> > +++ b/include/linux/tpm.h
> > @@ -27,9 +27,33 @@
> > 
> > #define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
> > 
> > +/*
> > + * SHA-512 is, as of today, the largest digest in the TCG algorithm repository.
> > + */
> > #define TPM2_MAX_DIGEST_SIZE	SHA512_DIGEST_SIZE
> > +
> > +/*
> > + * A TPM name digest i.e., TPMT_HA, is a concatenation of TPM_ALG_ID of the
> > + * name algorithm and hash of TPMT_PUBLIC.
> > + */
> > +#define TPM2_MAX_NAME_SIZE	(TPM2_MAX_DIGEST_SIZE + 2)
> > +
> > +/*
> > + * The maximum number of PCR banks.
> > + */
> > #define TPM2_MAX_PCR_BANKS	8
> > 
> > +/*
> > + * fixed define for the size of a name.  This is actually HASHALG size
> 
> "Fixed define".

Thanks, yeah, I can fix this up :-)

> 
> > + * plus 2, so 32 for SHA256
> > + */
> > +#define TPM2_NULL_NAME_SIZE	34
> > +
> > +/*
> > + * The maximum size for an object context
> > + */
> > +#define TPM2_MAX_CONTEXT_SIZE	4096
> > +
> > struct tpm_chip;
> > struct trusted_key_payload;
> > struct trusted_key_options;
> > @@ -139,17 +163,6 @@ struct tpm_chip_seqops {
> > /* fixed define for the curve we use which is NIST_P256 */
> > #define EC_PT_SZ	32
> > 
> > -/*
> > - * fixed define for the size of a name.  This is actually HASHALG size
> > - * plus 2, so 32 for SHA256
> > - */
> > -#define TPM2_NAME_SIZE	34
> > -
> > -/*
> > - * The maximum size for an object context
> > - */
> > -#define TPM2_MAX_CONTEXT_SIZE 4096
> > -
> > struct tpm_chip {
> > 	struct device dev;
> > 	struct device devs;
> > @@ -211,7 +224,7 @@ struct tpm_chip {
> > 	/* saved context for NULL seed */
> > 	u8 null_key_context[TPM2_MAX_CONTEXT_SIZE];
> > 	 /* name of NULL seed */
> > -	u8 null_key_name[TPM2_NAME_SIZE];
> > +	u8 null_key_name[TPM2_NULL_NAME_SIZE];
> > 	u8 null_ec_key_x[EC_PT_SZ];
> > 	u8 null_ec_key_y[EC_PT_SZ];
> > 	struct tpm2_auth *auth;
> > -- 
> > 2.39.5
> > 
> > 
> 
> J.
> 
> -- 
> Why do I get the feeling I'm going to regret this?
> This .sig brought to you by the letter S and the number 50
> Product of the Republic of HuggieTag

BR, Jarkko

