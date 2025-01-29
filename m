Return-Path: <linux-integrity+bounces-4668-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBB0A221A5
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Jan 2025 17:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22850167E8C
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Jan 2025 16:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0FB1A2399;
	Wed, 29 Jan 2025 16:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="RPdEJWC1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC9028EB
	for <linux-integrity@vger.kernel.org>; Wed, 29 Jan 2025 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738167691; cv=none; b=UpUGL2oj5hNCxh7lRjM2pRh7aXZLgItNfFyddjCzyr0/Ze2NI2KyBfS1vPb4LWy2HVNqN8JXbYeI9dJc5qKolJxEnZDhsv+VZcQAFoxq06WIiHeC+IICAnTjIuHtGHiyT31UZjDfCSvHPJhktiLKjjcX1Y0F50rm4ioPC9/22+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738167691; c=relaxed/simple;
	bh=cjxQUmeSvkH3+5tOuZ7uIbSZQoA9U+2x277ZCtXNDj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5kGdcbPD1PinQz6ou1IcYkTzN/U9nO5EiGp2wNhkhiK6IuFqznYXJx6kZJtsytDNWUP7EzE/mbHo44U2Z55nyc5x90oZReMlgVxFKc3B5R8dt0N4lq4cTtfi+gJipYPNplrae8qvE6bkvtU52G+GrHP4OlSPPsHU3pbvWKzNok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=RPdEJWC1; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=YRAYy7vFaY0lBiZLro20/OBd/d8o7Uhwu9WO7/xMVv0=; b=RPdEJWC19xSBsPZ0FESma11mUx
	v/lupuTRzOcTsOTBamBburP31WQwkuXja3SlM9LJCJCB+QecUEK+HSm4/aha6ymcjC1J/7BnlYxGL
	do1CtYw6eGXO3/ef9OUMc9xtq9yN5SH8YJePJqRObFGIECq7SLOBIQIdtiTGfL5+Sm8ZSi5ZXCyhJ
	RMNmGlOuWC5BBHJTijvnwLF1xpdFhmsQI1jKEObNZFHIPl++jTcO07vdP3YggKQ9g08HWfhF+1Zqa
	7DUK1NPQF+NaCc/Nh21IZk6ZyT9d2KARiDiUMVB1S/Y3HR0MBKM6kL9y8+qFIedlnZJU9MT80Iiiv
	qH4VpoLQ==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1tdAWf-00DEzk-0Q;
	Wed, 29 Jan 2025 16:02:49 +0000
Date: Wed, 29 Jan 2025 16:02:49 +0000
From: Jonathan McDowell <noodles@earth.li>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: linux-integrity@vger.kernel.org
Subject: Re: TPM operation times out (very rarely)
Message-ID: <Z5pRKcZKc3FUzP8Q@earth.li>
References: <Z5pI07m0Muapyu9w@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z5pI07m0Muapyu9w@kitsune.suse.cz>

On Wed, Jan 29, 2025 at 04:27:15PM +0100, Michal Suchánek wrote:
> there is a problem report that booting a specific type of system about
> 0.1% of the time encrypted volume (using a PCR to release the key) fails
> to unlock because of TPM operation timeout.
> 
> Minimizing the test case failed so far.
> 
> For example, booting into text mode as opposed to graphical desktop
> makes the problem unreproducible.
> 
> The test is done with a frankenkernel that has TPM drivers about on par
> with Linux 6.4 but using actual Linux 6.4 the problem is not
> reproducible, either.
> 
> However, given the problem takes up to a day to reproduce I do not have
> much confidence in the negative results.

So. We see what look like similar timeouts in our fleet, but I haven't
managed to produce a reliable test case that gives me any confidence
about what the cause is.

https://lore.kernel.org/linux-integrity/Zv1810ZfEBEhybmg@earth.li/

for my previous post about this.

> With some instrumentation it was determined that the problem happens
> here:

> static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
> {
> 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> 	int rc, status, burstcnt;
> 	size_t count = 0;
> 	bool itpm = test_bit(TPM_TIS_ITPM_WORKAROUND, &priv->flags);
> 
> 	status = tpm_tis_status(chip);
> 	if ((status & TPM_STS_COMMAND_READY) == 0) {
> 		tpm_tis_ready(chip);
> 		if (wait_for_tpm_stat
> 		    (chip, TPM_STS_COMMAND_READY, chip->timeout_b,
> 		     &priv->int_queue, false) < 0) {
> >>>			rc = -ETIME;
> 			goto out_err;
> 		}
> 	}

> localhost kernel: tpm tpm0: tpm_tis_send_data: 353: ready: Timed out (2236 of 2000 ms)
> localhost kernel: tpm tpm0: tpm_tis_send_data: 353: ready: Took (2236 of 2000 ms)

Can you track down the actual command that's taking the time? Though I
guess that's the previous command rather than the one that hits the
timeout.

> 200ms is a very long time for kernel space yet minor changes to the test
> setup avoid the problem.
> 
> I am wondering if this timeout is insufficient if eg. the previous
> operation can take up to TPM_LONG_LONG or perhaps if some of that time
> should have been consumed by the previous operation but because of
> insufficient locking somewhere the kernel got to waiting on the chip to
> become ready too early.
> 
> Note that these two volume unlocks are done by systemd services, and
> happen in parallel as much as possible.
> 
> The chip type:
> 
> tpm_tis IFX1522:00: 2.0 TPM (device-id 0x1D, rev-id 54)
> 
> Handle 0x0001, DMI type 43, 31 bytes
> TPM Device
>         Vendor ID: IFX
>         Specification Version: 2.0
>         Firmware Revision: 15.22
>         Description: SLB9672
>         Characteristics:
>                 Family configurable via firmware update
>                 Family configurable via platform software support
>         OEM-specific Information: 0x00000000
> 
> Any idea what could be the cause of this problem?

We're using SLB9670 devices, so older than yours, but at least the same
family.

J.

-- 
        The end is nearer.         |  .''`.  Debian GNU/Linux Developer
                                   | : :' :  Happy to accept PGP signed
                                   | `. `'   or encrypted mail - RSA
                                   |   `-    key on the keyservers.

