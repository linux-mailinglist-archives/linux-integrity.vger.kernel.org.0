Return-Path: <linux-integrity+bounces-4669-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A82A222A7
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Jan 2025 18:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DCEA3A7095
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Jan 2025 17:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E36517A5A4;
	Wed, 29 Jan 2025 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="PtlvSngH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A302842A8B
	for <linux-integrity@vger.kernel.org>; Wed, 29 Jan 2025 17:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738170878; cv=none; b=R3zc2p8Z5kmX1SrKBwCYXtq9IwtYATd3OKI8dkWeF1e8e6lClG7BzVgtkeq8Iyi1DCXYYx2c1K0o92Cbr1qs3McwV7cUfKqQ5Inh9G5wZbw4+epv7tWy5yqfIQKvtv7o8sw/jaD7O5sGOO5RiO1nM+OgY4pyK4SD4+ZltXExKMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738170878; c=relaxed/simple;
	bh=L1AV99ey4McXYuiwC0nRLmU2JK0aiYXdPmSbB70y4DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzcJhWuFofWfi6EE3jBzcl8txVz6mHiiaDJHUONTuAESRx90yUKOicIEfHf0yAWI8zB7Zxb1Aet+j2eU8K2SKekGFMRXLE7cKnl8Co06aU2PNuZDRFpEfgTA/Sjwtr0zfQd+oPMDdQgodP3zKQ/csZkWAxIdEthKmeZycaj8RtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=PtlvSngH; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=EK7kRk55g8kHH2gPk1lIlhFu62UvCuxe+n2jSNXIJlw=; b=PtlvSngHAIwl3hJOjffMtlyOAE
	FJUvdrn8uPJYmpxhxKIKecGPkqiMoReESR6AtO3pWu5Jn1p5I3INjRdJImI7/DQ3oEr3v7q5MMlkx
	TA1W0Yv4lCLrsCLrsaaeltpy1Fh3+vCuzboBd/6riwNIW4WpL8FNYzaJStDdTpgxA/TvR/llHwykV
	ITnovsttKCqOb2GodSU9KKVp3FhPnxQks5aT6y9P+1Pa6sptLJj2gCw/HTf2AjwdrbWivhIugiyLG
	uy9LM743jyRZto+JK8azo+eeeMXx2r18cbvMNZou6pm79yNVnjlHrW6Qvb4HrLhlM4Xtz8NAV80gE
	vQVhge8w==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1tdBe6-00DHwv-2r;
	Wed, 29 Jan 2025 17:14:34 +0000
Date: Wed, 29 Jan 2025 17:14:34 +0000
From: Jonathan McDowell <noodles@earth.li>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: linux-integrity@vger.kernel.org
Subject: Re: TPM operation times out (very rarely)
Message-ID: <Z5ph-ntScQo2QgSC@earth.li>
References: <Z5pI07m0Muapyu9w@kitsune.suse.cz>
 <Z5pRKcZKc3FUzP8Q@earth.li>
 <Z5pVUd0jpzmbtc0u@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z5pVUd0jpzmbtc0u@kitsune.suse.cz>

On Wed, Jan 29, 2025 at 05:20:33PM +0100, Michal Suchánek wrote:
> On Wed, Jan 29, 2025 at 04:02:49PM +0000, Jonathan McDowell wrote:
> > On Wed, Jan 29, 2025 at 04:27:15PM +0100, Michal Suchánek wrote:
> > > there is a problem report that booting a specific type of system about
> > > 0.1% of the time encrypted volume (using a PCR to release the key) fails
> > > to unlock because of TPM operation timeout.
> > > 
> > > Minimizing the test case failed so far.
> > > 
> > > For example, booting into text mode as opposed to graphical desktop
> > > makes the problem unreproducible.
> > > 
> > > The test is done with a frankenkernel that has TPM drivers about on par
> > > with Linux 6.4 but using actual Linux 6.4 the problem is not
> > > reproducible, either.
> > > 
> > > However, given the problem takes up to a day to reproduce I do not have
> > > much confidence in the negative results.
> > 
> > So. We see what look like similar timeouts in our fleet, but I haven't
> > managed to produce a reliable test case that gives me any confidence
> > about what the cause is.
> > 
> > https://lore.kernel.org/linux-integrity/Zv1810ZfEBEhybmg@earth.li/
> > 
> > for my previous post about this.
> 
> I see that's basically the same as the test patch I used:
> 
> The time it takes for the TPM to become ready can exceed timeout_b
> 
> Jan 28 07:09:21 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: ready: Timed out (2236 of 2000 ms)
> Jan 28 07:09:21 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: ready: Took (2236 of 2000 ms)

Does it always complete immediately after the retry? Have you tried a
longer value (eg timeout_b * 2) and confirmed that makes the issue go
away?

> ---
>  drivers/char/tpm/tpm_tis_core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index fdef214b9f6b..c7a794a448af 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -432,19 +432,29 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>  static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
>  {
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> +	u32 ordinal = be32_to_cpu(*((__be32 *) (buf + 6)));
>  	int rc, status, burstcnt;
>  	size_t count = 0;
>  	bool itpm = test_bit(TPM_TIS_ITPM_WORKAROUND, &priv->flags);
> +	unsigned long start, timed_out;
>  
>  	status = tpm_tis_status(chip);
>  	if ((status & TPM_STS_COMMAND_READY) == 0) {
>  		tpm_tis_ready(chip);
> +		timed_out = 0; start = jiffies;
> +retry_ready:
>  		if (wait_for_tpm_stat
>  		    (chip, TPM_STS_COMMAND_READY, chip->timeout_b,
>  		     &priv->int_queue, false) < 0) {
> +			if (timed_out++ < 5) {
> +				dev_err(&chip->dev, "%s: %u: ready: Timed out (%u of %u ms)\n", __func__, ordinal, jiffies_to_msecs(jiffies - start), jiffies_to_msecs(chip->timeout_b));
> +				goto retry_ready;
> +			}
>  			rc = -ETIME;
>  			goto out_err;
>  		}
> +		if (timed_out)
> +			dev_err(&chip->dev, "%s: %u: ready: Took (%u of %u ms)\n", __func__, ordinal, jiffies_to_msecs(jiffies - start), jiffies_to_msecs(chip->timeout_b));
>  	}
>  
>  	while (count < len - 1) {
> 
> 
> > 
> > > With some instrumentation it was determined that the problem happens
> > > here:
> > 
> > > static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
> > > {
> > > 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> > > 	int rc, status, burstcnt;
> > > 	size_t count = 0;
> > > 	bool itpm = test_bit(TPM_TIS_ITPM_WORKAROUND, &priv->flags);
> > > 
> > > 	status = tpm_tis_status(chip);
> > > 	if ((status & TPM_STS_COMMAND_READY) == 0) {
> > > 		tpm_tis_ready(chip);
> > > 		if (wait_for_tpm_stat
> > > 		    (chip, TPM_STS_COMMAND_READY, chip->timeout_b,
> > > 		     &priv->int_queue, false) < 0) {
> > > >>>			rc = -ETIME;
> > > 			goto out_err;
> > > 		}
> > > 	}
> > 
> > > localhost kernel: tpm tpm0: tpm_tis_send_data: 353: ready: Timed out (2236 of 2000 ms)
> > > localhost kernel: tpm tpm0: tpm_tis_send_data: 353: ready: Took (2236 of 2000 ms)
> > 
> > Can you track down the actual command that's taking the time? Though I
> > guess that's the previous command rather than the one that hits the
> > timeout.
> 
> Yes, 353 is supposed to be the command but it's likely the previous one
> that is causing the problem.

So TPM2_CC_CONTEXT_LOAD. I'm assuming you're using /dev/tpmrm0, so
that's the start of a fresh "load context, execute command, save
context" cycle. I'd expect the previous command to be the
TPM2_CC_CONTEXT_SAVE from the previous cycle.

> I suppose this could be expanded to use a static variable to also save
> the last command.

J.

-- 
] https://www.earth.li/~noodles/ [] Design a system any fool can use,  [
]  PGP/GPG Key @ the.earth.li    []  and only a fool will want to use  [
] via keyserver, web or email.   []                it.                 [
] RSA: 4096/0x94FA372B2DA8B985   []                                    [

