Return-Path: <linux-integrity+bounces-4731-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DFCA294B6
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Feb 2025 16:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41598160982
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Feb 2025 15:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C0615854F;
	Wed,  5 Feb 2025 15:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lVsid3Bh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ATRgSxV/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ERl00dWq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Fb+mnYrB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D9615A842
	for <linux-integrity@vger.kernel.org>; Wed,  5 Feb 2025 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738769376; cv=none; b=IlqvzxVCz9iPckKud6GovcfRqMu4fdUyUKMpD/kGddHUAf4Jf9xgxyv18EXKxaqZfQ08ZRaNIgNfU+mh55gp0js6TqqFRZUouAXBV2Amr4wktdxMmiDXQnGC52AH+FAQanQlW6ubWg/vwIyg1pjf+QsYWhDuGh8PSCXZY0890MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738769376; c=relaxed/simple;
	bh=wquitVplKLLeMKaZsxJTC5coNdZFt/Awh7RSTnMy6cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W285FtHIKOUA2OPYmVQ2aHsX49d4j6evfskrboYEVArZuslaaMAjRlYlqE/oiEIM0evQaNSOEOkkADy/WdPo0b7BMPYEMEfP0IqGCAY+rgWzrfAjEK/HCCvdbX4x6xuatm6EqbdphGYqHXdZ5VfUJ5y/GVg5EZlx0YAJDKuz9eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lVsid3Bh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ATRgSxV/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ERl00dWq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Fb+mnYrB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7F1221F7B5;
	Wed,  5 Feb 2025 15:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738769372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Rt5G/GIOMhKTwQZaxG7eh2rvUVgag/X7GR9TyjO9ME=;
	b=lVsid3Bhp/iKS+XUqDUYq8rVRyzK4qSZVJBIYdR4iOBvrCi4I8R+pPOTS8tWhWPlTmjUL8
	9FIatA9PWGYLiWVm2kQ1E0boLcLMQN7BIkbS+6Sa/P1uQbIlQEyCEYB1VjyRZTjDvZGYt4
	5qX8ynoegLaFMVB5U+jUSmpZ9sfysDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738769372;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Rt5G/GIOMhKTwQZaxG7eh2rvUVgag/X7GR9TyjO9ME=;
	b=ATRgSxV/1Iv0vZQYSWFLrLVzZ6z14xSV5NhtdIRXV4nJLV+4PuDtGTVYQpxsUlArBAzf0j
	b1qtEeqctmg/BEBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738769371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Rt5G/GIOMhKTwQZaxG7eh2rvUVgag/X7GR9TyjO9ME=;
	b=ERl00dWqtrGNJgLQSc35CmHWkzW8va0DSD9r/k8QIzTSUsttx6KaL+OxvRE7hCNTtf4ls5
	dCBqeja7ayGe5lo1pAHZTY/9l2IV9g3t7WmVNSLrmwY5ZFDoeQX+xWieFPmSbYu4TJsH2D
	9eyjAEkxDcT3HmY6eBSLRUqxjhiicr0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738769371;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Rt5G/GIOMhKTwQZaxG7eh2rvUVgag/X7GR9TyjO9ME=;
	b=Fb+mnYrByQuHMyay/S7G3YZiT4ZlktnsoG5II2DB+nJqbGQoYQueAPyZWztD0eKb65+yfX
	b/yso9HJaRbpnYAA==
Date: Wed, 5 Feb 2025 16:29:30 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Jonathan McDowell <noodles@earth.li>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Subject: Re: TPM operation times out (very rarely)
Message-ID: <Z6OD2snFljFw22P2@kitsune.suse.cz>
References: <Z5pRKcZKc3FUzP8Q@earth.li>
 <D7FSS837QLNR.5XOU66J6FBTU@kernel.org>
 <Z5yLYVBn6inIH8cG@kitsune.suse.cz>
 <D7G6P7W7AY65.257WPBC8I3HAF@kernel.org>
 <Z5zJ7R6vDU4h9iDk@kitsune.suse.cz>
 <D7GFCNGDK7S6.1X0KPPHF1TXBO@kernel.org>
 <Z50IKdYe42_n2B0b@kitsune.suse.cz>
 <D7GIBDO5KJMD.118CQO10LJ79Y@kernel.org>
 <Z6Nm7Y8TFF8YG56Z@kitsune.suse.cz>
 <Z6N10NQY75hpX0Ed@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6N10NQY75hpX0Ed@earth.li>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Feb 05, 2025 at 02:29:36PM +0000, Jonathan McDowell wrote:
> On Wed, Feb 05, 2025 at 02:26:05PM +0100, Michal Suchánek wrote:
> > On Fri, Jan 31, 2025 at 09:31:30PM +0200, Jarkko Sakkinen wrote:
> > > On Fri Jan 31, 2025 at 7:28 PM EET, Michal Suchánek wrote:
> > > > On Fri, Jan 31, 2025 at 07:12:06PM +0200, Jarkko Sakkinen wrote:
> > > > > On Fri Jan 31, 2025 at 3:02 PM EET, Michal Suchánek wrote:
> > > > > > It looks like the timeout_b is used exclusively as the ready timeout *),
> > > > > > with various sources of the value depending on chip type.
> > > > > >
> > > > > > Then increasing it should not cause any problem other than the kernel
> > > > > > waiting longer when the TPM chip is really stuck.
> > > > > >
> > > > > > * There is one instance of use of timeout_b for TPM_STS_VALID in
> > > > > > st33zp24_pm_resume.
> > > > > 
> > > > > Possible for you to give a shot for patch and try it out for a while?
> > > > > I'm fine with 2x, or even 4x in this case.
> > > >
> > > > I will see what I can do. It will definitely take a while.
> > > >
> > > > How would you like to multiply it?
> > > >
> > > > At the sime the timeout_b is assigned, or at the time it's used?
> > > >
> > > > Any specific patch that you have in mind?
> > > 
> > > I'll think about this a bit and send a patch with RFC tag. Might take
> > > to late next week.
> > 
> > The ready timeout is not the only one exceeded:
> > 
> > > Jan 29 19:01:55 localhost kernel: tpm tpm0: tpm_tis_send_data: 357: ready: Timed out (2232 of 2000 ms)
> > > Jan 29 19:01:55 localhost kernel: tpm tpm0: tpm_tis_send_data: 357: ready: Took (2232 of 2000 ms)
> > > Jan 30 09:08:20 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: ready: Timed out (2228 of 2000 ms)
> > > Jan 30 09:08:20 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: ready: Took (2228 of 2000 ms)
> > > Jan 30 14:26:16 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Timed out (540 of 200 ms)
> > > Jan 30 14:26:16 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Took (540 of 200 ms)
> > > Jan 30 23:25:13 localhost kernel: tpm tpm0: tpm_tis_send_data: 354: stat: Timed out (2224 of 200 ms)
> > > Jan 30 23:25:13 localhost kernel: tpm tpm0: tpm_tis_send_data: 354: stat: Took (2224 of 200 ms)
> > > Feb 01 05:25:33 localhost kernel: tpm tpm0: tpm_tis_send_data: 357: ready: Timed out (2228 of 2000 ms)
> > > Feb 01 05:25:33 localhost kernel: tpm tpm0: tpm_tis_send_data: 357: ready: Took (2228 of 2000 ms)
> > > Feb 01 07:02:53 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Timed out (556 of 200 ms)
> > > Feb 01 07:02:53 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Took (556 of 200 ms)
> > > Feb 01 09:26:22 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Timed out (540 of 200 ms)
> > > Feb 01 09:26:22 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Took (540 of 200 ms)
> > > Feb 02 02:45:35 localhost kernel: tpm tpm0: tpm_tis_send_data: 379: stat: Timed out (272 of 200 ms)
> > > Feb 02 02:45:35 localhost kernel: tpm tpm0: tpm_tis_send_data: 379: stat: Took (272 of 200 ms)
> > > Feb 02 03:40:04 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Timed out (536 of 200 ms)
> > > Feb 02 03:40:04 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Took (536 of 200 ms)
> > > Feb 02 04:09:50 localhost kernel: tpm tpm0: tpm_tis_send_data: 357: ready: Timed out (2236 of 2000 ms)
> > > Feb 02 04:09:50 localhost kernel: tpm tpm0: tpm_tis_send_data: 357: ready: Took (2236 of 2000 ms)
> > > Feb 02 09:57:41 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Timed out (540 of 200 ms)
> > > Feb 02 09:57:41 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Took (540 of 200 ms)
> > > Feb 02 10:59:00 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Timed out (536 of 200 ms)
> > > Feb 02 10:59:00 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Took (536 of 200 ms)
> > > Feb 03 03:58:09 localhost kernel: tpm tpm0: tpm_tis_send_data: 354: stat: Timed out (540 of 200 ms)
> > > Feb 03 03:58:09 localhost kernel: tpm tpm0: tpm_tis_send_data: 354: stat: Took (540 of 200 ms)
> > 
> > While the ready timeout is quite consistently exceeded by around 230ms
> > so far the stat timeout a few lines lower is less consistent.
> 
> Interesting. TPM2_CC_CONTEXT_LOAD (353) / TPM2_CC_FLUSH_CONTEXT (357) /
> TPM2_CC_CONTEXT_SAVE (354) I kinda expect to maybe take a bit longer,
> but TPM2_CC_GET_RANDOM (379) is a little surprising.

But it only takes extra 72ms, the context functions take about extra
350ms.

> 
> > Failure is observed with another chip type as well:
> > 
> > localhost kernel: tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1B, rev-id
> > 22)
> > 
> > TPM Device
> >         Vendor ID: IFX
> >         Specification Version: 2.0
> >         Firmware Revision: 7.83
> >         Description: TPM 2.0, ManufacturerID: IFX , Firmware Version: 7.83.3358.0
> >         Characteristics:
> >                 Family configurable via firmware update
> >                 Family configurable via OEM proprietary mechanism
> >         OEM-specific Information: 0x00000000
> 
> That looks like an SLB9670, not running the latest firmware (7.85). I
> think that might have the errata I've been trying to work around; my
> current patch in testing (with logging to see how effective it is):

I don't have any result with timeout waiting for the valid state but all
the results with the debug prints are from the newer chip revision.

Thanks

Michal

> 
> commit d8c680ec34e7f42f731e7d64605a670fb7b3b4d1
> Author: Jonathan McDowell <noodles@meta.com>
> Date:   Mon Aug 19 09:22:46 2024 -0700
> 
>     tpm: Workaround failed command reception on Infineon devices
>     
>     Some Infineon devices have a issue where the status register will get
>     stuck with a quick REQUEST_USE / COMMAND_READY sequence. The work around
>     is to retry the command submission. Add appropriate logic to do this in
>     the send path.
>     
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index fdef214b9f6b..561d6801e299 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -464,7 +464,12 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
>  
>  		if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
>  					&priv->int_queue, false) < 0) {
> -			rc = -ETIME;
> +			if (test_bit(TPM_TIS_STATUS_WORKAROUND, &priv->flags)) {
> +				dev_err(&chip->dev, "Timed out waiting for status valid in send, retrying\n");
> +				rc = -EAGAIN;
> +			} else {
> +				rc = -ETIME;
> +			}
>  			goto out_err;
>  		}
>  		status = tpm_tis_status(chip);
> @@ -481,7 +486,13 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
>  
>  	if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
>  				&priv->int_queue, false) < 0) {
> -		rc = -ETIME;
> +
> +		if (test_bit(TPM_TIS_STATUS_WORKAROUND, &priv->flags)) {
> +			dev_err(&chip->dev, "Timed out waiting for status after send, retrying\n");
> +			rc = -EAGAIN;
> +		} else {
> +			rc = -ETIME;
> +		}
>  		goto out_err;
>  	}
>  	status = tpm_tis_status(chip);
> @@ -546,10 +557,13 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
>  		if (rc >= 0)
>  			/* Data transfer done successfully */
>  			break;
> -		else if (rc != -EIO)
> +		else if (rc != -EAGAIN && rc != -EIO)
>  			/* Data transfer failed, not recoverable */
>  			return rc;
>  	}
> +	if (try)
> +		dev_info(&chip->dev,
> +			"Took %d attempts to send command\n", try + 1);
>  
>  	/* go and do it */
>  	rc = tpm_tis_write8(priv, TPM_STS(priv->locality), TPM_STS_GO);
> @@ -563,6 +577,8 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
>  		if (wait_for_tpm_stat
>  		    (chip, TPM_STS_DATA_AVAIL | TPM_STS_VALID, dur,
>  		     &priv->read_queue, false) < 0) {
> +			dev_err(&chip->dev,
> +				"Timed out waiting for command to complete after send\n");
>  			rc = -ETIME;
>  			goto out_err;
>  		}
> @@ -1144,6 +1160,9 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  		priv->timeout_max = TIS_TIMEOUT_MAX_ATML;
>  	}
>  
> +	if (priv->manufacturer_id == TPM_VID_IFX)
> +		set_bit(TPM_TIS_STATUS_WORKAROUND, &priv->flags);
> +
>  	if (is_bsw()) {
>  		priv->ilb_base_addr = ioremap(INTEL_LEGACY_BLK_BASE_ADDR,
>  					ILB_REMAP_SIZE);
> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> index 690ad8e9b731..ce97b58dc005 100644
> --- a/drivers/char/tpm/tpm_tis_core.h
> +++ b/drivers/char/tpm/tpm_tis_core.h
> @@ -89,6 +89,7 @@ enum tpm_tis_flags {
>  	TPM_TIS_INVALID_STATUS		= 1,
>  	TPM_TIS_DEFAULT_CANCELLATION	= 2,
>  	TPM_TIS_IRQ_TESTED		= 3,
> +	TPM_TIS_STATUS_WORKAROUND	= 4,
>  };
>  
>  struct tpm_tis_data {
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 20a40ade8030..6c3125300c00 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -335,6 +335,7 @@ enum tpm2_cc_attrs {
>  #define TPM_VID_WINBOND  0x1050
>  #define TPM_VID_STM      0x104A
>  #define TPM_VID_ATML     0x1114
> +#define TPM_VID_IFX      0x15D1
>  
>  enum tpm_chip_flags {
>  	TPM_CHIP_FLAG_BOOTSTRAPPED		= BIT(0),
> 
> 
> -- 
> Web [  "A true friend knows who you are...but likes you anyway."   ]
> site: https:// [                                          ]      Made by
> www.earth.li/~noodles/  [                      ]         HuggieTag 0.0.24

