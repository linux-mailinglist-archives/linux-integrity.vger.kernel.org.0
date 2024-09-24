Return-Path: <linux-integrity+bounces-3685-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D7D984A61
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 19:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7CFAB20975
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 17:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFCC1ABEB5;
	Tue, 24 Sep 2024 17:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZYspZs6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51061DFFB;
	Tue, 24 Sep 2024 17:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727199784; cv=none; b=XgVcc8VS1gX8gDjq2y4/fQF2bxJpO17qTz8gMSO8AYqc3b3cV2udJhBcmV0/CYCNBHmi5RLP0wnO365ML5DDon4WrxTLxocaiVeSRXyzzpDSqXGLiDoPfJ5RAxrvDGO7TWTO4I+iksojRiV3EhlHi9DLNbRhnszJGw33WKUrpYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727199784; c=relaxed/simple;
	bh=1nGRJTp5rdhCgESnVFtv9Qw49hnP87GrI8fkR5U8p2M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=EaYMhhIdGXpon6zYSWBtPZvIxmbVeiKgoEikfDUVcWtgf8115PGZp9ThZrC8Min3DIsBGz5oVNNKuSJRifJbT8GgGEVaymteXU98IjVilF15o+sfqMZhk5LD9Jc4cRtyiGkpwDDvTwU4v2r4RCe1Apsg+z/edm8EL77GblcegCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZYspZs6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7913C4CEC4;
	Tue, 24 Sep 2024 17:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727199784;
	bh=1nGRJTp5rdhCgESnVFtv9Qw49hnP87GrI8fkR5U8p2M=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=UZYspZs6DWDdoeooeGtXDJ6yvbh4Ir9+RVOBl9DmMAX/Rww/1a+4bClZeDiRGXwOU
	 uaPHKuOb0ynmpnC6yXksK9yvfjSlFI+ltFJm3EkXbCPWhcCpkCWRwicc7sjXiBDklR
	 r3qdIOBhxnE32p36ezghcMLu7MXXlgOmLUUxsorPx9eJLJReVIsEHnqkDgUC89uJUG
	 FAJa0siyEt+LxqVMqGDSo0890k0NK/xtsjjaa/8UTYLMaIjUNNsCIcbsEEllIgg5zr
	 v5r85KbJAdeN8Z36fQ8A4rP1rQZ9OAMxEpaUloZW593QxPoztLYdzXaX+9ncbNrWsk
	 GQESeGqJSwt4g==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Sep 2024 20:43:00 +0300
Message-Id: <D4EP817NLQY9.35RSWO8IFXRL0@kernel.org>
Cc: "Linux Crypto Mailing List" <linux-crypto@vger.kernel.org>, "Guangwu
 Zhang" <guazhang@redhat.com>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>, "James
 Bottomley" <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH] hwrng: core - Add WARN_ON for buggy read return values
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Herbert Xu"
 <herbert@gondor.apana.org.au>
X-Mailer: aerc 0.18.2
References: <ZvEFQAWVgWNd9j7e@gondor.apana.org.au>
 <D4DI1M1ELFXK.2COGZN6O5HABD@kernel.org>
 <ZvE0NrOC00ojRe3t@gondor.apana.org.au>
 <D4DQJ34I5FSD.1K618VWEKI7IW@kernel.org>
 <2024092340-renovate-cornflake-4b5e@gregkh>
 <ZvHsh6by3omeYj9d@gondor.apana.org.au>
 <D4EN54C1IK1R.11JD66L931PD8@kernel.org>
In-Reply-To: <D4EN54C1IK1R.11JD66L931PD8@kernel.org>

On Tue Sep 24, 2024 at 7:05 PM EEST, Jarkko Sakkinen wrote:
> On Tue Sep 24, 2024 at 1:32 AM EEST, Herbert Xu wrote:
> > On Mon, Sep 23, 2024 at 04:48:27PM +0200, Greg KH wrote:
> > >
> > > Please see:
> > > 	https://www.kernel.org/doc/html/latest/process/deprecated.html#bug-a=
nd-bug-on
> > > which describes that.  We should make it more explicit that any WARN(=
)
> > > or WARN_ON() calls that can be hit by user interactions somehow, will
> > > end up getting a CVE id when we fix it up to not do so.
> >
> > If the aformentioned WARN_ON hits, then the driver has probabaly
> > already done a buffer overrun so it's a CVE anyway.
>
> We'll see I finally got into testing this. Sorry for latencies, I'm
> switching jobs and unfortunately German Post Office lost my priority
> mail containing contracts (sent them from Finland to Berlin) so have
> been signing, scanning etc. the whole day :-) My last week in the
> current job, and next week is the first in the new job, so this
> week is a bit bumpy.

I get nothing with this:

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index aba024cbe7c5..856a8356d971 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -341,12 +341,15 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, =
size_t max)

                dest_ptr +=3D recd;
                total +=3D recd;
+
+               WARN_ON(num_bytes < recd);
                num_bytes -=3D recd;
        } while (retries-- && total < max);

        tpm_buf_destroy(&buf);
        tpm2_end_auth_session(chip);

+       WARN_ON(total > max);
        return total ? total : -EIO;
 out:
        tpm_buf_destroy(&buf);

[WARN_ON()'s here are only for the temporary diff]

Call stack:

1. tpm2_get_random():
   https://elixir.bootlin.com/linux/v6.11-rc7/source/drivers/char/tpm/tpm2-=
cmd.c#L281
2. tpm_get_random():
   https://elixir.bootlin.com/linux/v6.11-rc7/source/drivers/char/tpm/tpm-i=
nterface.c#L430
3. tpm_hwrng_read():
   https://elixir.bootlin.com/linux/v6.11-rc7/source/drivers/char/tpm/tpm-c=
hip.c#L524

Everything seems to have also appropriate range checks.

Without any traces that would provide more information I don't see
the smoking gun.

BR, Jarkko

