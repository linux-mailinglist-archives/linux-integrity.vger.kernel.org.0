Return-Path: <linux-integrity+bounces-4666-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E22A2203D
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Jan 2025 16:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC98E168A96
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Jan 2025 15:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7ABB18C31;
	Wed, 29 Jan 2025 15:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fskA+eUj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bnaJfZll";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ee9WtNUi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MHy5xMaw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9D91DDA3D
	for <linux-integrity@vger.kernel.org>; Wed, 29 Jan 2025 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738164440; cv=none; b=X39jQvaPORAcUJ22L7swpVTRo7WMhrdS6telkEFC5kRTV77YNQp9YWImHKt+3c3aIMGXr5dW1WkXqO7gJddYmX73oPAecbsMaB4wBZCudfVQ01Y+9rgKGJJQfsrpmq+6yYweFhHTK485CTZ5408h1iRDdvuHPkfgs2zC2lz2nOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738164440; c=relaxed/simple;
	bh=aSilwdNMmBSL/nUxaq7Gzsoa2M/I58udGf4ahMfQgrA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OtozUcdbTGQ2aLMB2nKMBTCvzOkCp6iHu0KQzjbyxzxVdxYvDNqutYLaj3dLiegoc/MQClLkyWemxRHMq9Vuv0yE3XKrmV2XTt4Rj32XxXAU/WQ7wuYmreb95Yj8sckgjPfqLsybbXsHzIh8uJzMmYANL3CQmOZYA1WojzinIeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fskA+eUj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bnaJfZll; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ee9WtNUi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MHy5xMaw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E5E9E1F365
	for <linux-integrity@vger.kernel.org>; Wed, 29 Jan 2025 15:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738164437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=0MKn/H5ZT865iZHpW40vFq/ZQWYIAI08Wt7GhCO75bA=;
	b=fskA+eUjXqq0mgoDWHddpV55AhAUH8w1NxC+RE0M7JXqXyBKtRlZU9Z3bb6wpEHowsrJTZ
	ZGOjyf+yeje3KT3+dvLXgM+qKUqovwy29FgLAhvMJSZURWig8Fg66Rrl8z5QFkxblM4yMX
	wYsCPVHIoRIJflgjfXgxUgVBe+xtwJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738164437;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=0MKn/H5ZT865iZHpW40vFq/ZQWYIAI08Wt7GhCO75bA=;
	b=bnaJfZll2InG0hTwwYWW2qMBdZA4nhK23W4rUSLye10tzoXdSIScald0gLdBcmmidBhFBV
	MREkEoPQ+pPFkHBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738164436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=0MKn/H5ZT865iZHpW40vFq/ZQWYIAI08Wt7GhCO75bA=;
	b=ee9WtNUiSzAl5NLmclWoufqbeTEh6cWj8bNL8Yw0UJOk5gDuz0hFiTQBD2Mg086S4dqCCY
	sm2vrMBr4aBAOhrAZ70pfWsNgB2IBrQvmSkoMzCRsdNvcQScGfmYva2sv6tvIPZ0joUYDC
	4Poo93kB25mDN82HrDDG70aQHBAMJoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738164436;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=0MKn/H5ZT865iZHpW40vFq/ZQWYIAI08Wt7GhCO75bA=;
	b=MHy5xMawGgs6XcRJT7J00+xwlpcBanrZhyWTUyfuybOR1g9W6liUFDJLmp3dqoSF40iiJ+
	RshvA7M0DNVzEVAw==
Date: Wed, 29 Jan 2025 16:27:15 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: linux-integrity@vger.kernel.org
Subject: TPM operation times out (very rarely)
Message-ID: <Z5pI07m0Muapyu9w@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Score: -3.74
X-Spamd-Result: default: False [-3.74 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	R_MIXED_CHARSET(0.56)[subject];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Hello,

there is a problem report that booting a specific type of system about
0.1% of the time encrypted volume (using a PCR to release the key) fails
to unlock because of TPM operation timeout.

Minimizing the test case failed so far.

For example, booting into text mode as opposed to graphical desktop
makes the problem unreproducible.

The test is done with a frankenkernel that has TPM drivers about on par
with Linux 6.4 but using actual Linux 6.4 the problem is not
reproducible, either.

However, given the problem takes up to a day to reproduce I do not have
much confidence in the negative results.

With some instrumentation it was determined that the problem happens
here:

/*
 * If interrupts are used (signaled by an irq set in the vendor structure)
 * tpm.c can skip polling for the data to be available as the interrupt is
 * waited for here
 */
static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
{
	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
	int rc, status, burstcnt;
	size_t count = 0;
	bool itpm = test_bit(TPM_TIS_ITPM_WORKAROUND, &priv->flags);

	status = tpm_tis_status(chip);
	if ((status & TPM_STS_COMMAND_READY) == 0) {
		tpm_tis_ready(chip);
		if (wait_for_tpm_stat
		    (chip, TPM_STS_COMMAND_READY, chip->timeout_b,
		     &priv->int_queue, false) < 0) {
>>>			rc = -ETIME;
			goto out_err;
		}
	}

	while (count < len - 1) {
		burstcnt = get_burstcount(chip);
		if (burstcnt < 0) {
			dev_err(&chip->dev, "Unable to read burstcount\n");
			rc = burstcnt;
			goto out_err;
		}
		burstcnt = min_t(int, burstcnt, len - count - 1);
		rc = tpm_tis_write_bytes(priv, TPM_DATA_FIFO(priv->locality),
					 burstcnt, buf + count);
		if (rc < 0)
			goto out_err;

		count += burstcnt;

		if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
					&priv->int_queue, false) < 0) {
			rc = -ETIME;
			goto out_err;
		}
		status = tpm_tis_status(chip);
		if (!itpm && (status & TPM_STS_DATA_EXPECT) == 0) {
			rc = -EIO;
			goto out_err;
		}
	}

	/* write last byte */
	rc = tpm_tis_write8(priv, TPM_DATA_FIFO(priv->locality), buf[count]);
	if (rc < 0)
		goto out_err;

	if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
				&priv->int_queue, false) < 0) {
		rc = -ETIME;
		goto out_err;
	}
	status = tpm_tis_status(chip);
	if (!itpm && (status & TPM_STS_DATA_EXPECT) != 0) {
		rc = -EIO;
		goto out_err;
	}

	rc = tpm_tis_verify_crc(priv, len, buf);
	if (rc < 0) {
		dev_err(&chip->dev, "CRC mismatch for command.\n");
		goto out_err;
	}

	return 0;

out_err:
	tpm_tis_ready(chip);
	return rc;
}

localhost kernel: tpm tpm0: tpm_tis_send_data: 353: ready: Timed out (2236 of 2000 ms)
localhost kernel: tpm tpm0: tpm_tis_send_data: 353: ready: Took (2236 of 2000 ms)

200ms is a very long time for kernel space yet minor changes to the test
setup avoid the problem.

I am wondering if this timeout is insufficient if eg. the previous
operation can take up to TPM_LONG_LONG or perhaps if some of that time
should have been consumed by the previous operation but because of
insufficient locking somewhere the kernel got to waiting on the chip to
become ready too early.

Note that these two volume unlocks are done by systemd services, and
happen in parallel as much as possible.

The chip type:

tpm_tis IFX1522:00: 2.0 TPM (device-id 0x1D, rev-id 54)

Handle 0x0001, DMI type 43, 31 bytes
TPM Device
        Vendor ID: IFX
        Specification Version: 2.0
        Firmware Revision: 15.22
        Description: SLB9672
        Characteristics:
                Family configurable via firmware update
                Family configurable via platform software support
        OEM-specific Information: 0x00000000

Any idea what could be the cause of this problem?

Thanks

Michal

