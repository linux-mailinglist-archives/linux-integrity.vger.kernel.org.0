Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D5227B04B
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Sep 2020 16:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgI1Oud (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Sep 2020 10:50:33 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:58902 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726566AbgI1Oud (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Sep 2020 10:50:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3422D8EE17F;
        Mon, 28 Sep 2020 07:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601304633;
        bh=QPMiw+UPWT9wnfFHfp1mNcpfRVz1F0n0BLZsybmitjE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rWF0CuGELib6HaWotbn36ppb/UX6noH44fC+8xxU9Fa3blT9rnpA/NYn83DBEJhSo
         970upOBjkGFDE5NFtazOmPHI2u6XlQvQWjvUdsmLEBHgoR0Fn49/RoSazqg0Mm2aYe
         jLrbsoYxw5YZ5Xqea5ASpmgjgP0ODJd7xut+zi4g=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NT6DxHfBC2e5; Mon, 28 Sep 2020 07:50:33 -0700 (PDT)
Received: from jarvis (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id A93208EE0F5;
        Mon, 28 Sep 2020 07:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601304632;
        bh=QPMiw+UPWT9wnfFHfp1mNcpfRVz1F0n0BLZsybmitjE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AMgZzFbQCbqbbHCDfdm3p+mxZd2i85E6UAVzgORS2UH9jjH/ZoGJKbFfR7ZPD9VA/
         4azg/R4bB0DEAimSR7xN1yMj6yhrsDqp5zPyk4LaWNS5N/eWqcxqDwwzWwVeLiaG6g
         ujY+VTDPFssNbvOru/HRMIJUw/+Kpwv8vmPxGxTk=
Message-ID: <3f369592267e8f502f435584b9220e81263eae2c.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: only export stand alone version of flush context
 command
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org
Date:   Mon, 28 Sep 2020 07:50:31 -0700
In-Reply-To: <20200928112046.GA14051@linux.intel.com>
References: <e63012add04eee75d67d15f55fe4f6b68fb1d6ed.camel@HansenPartnership.com>
         <20200928001138.GE5283@linux.intel.com>
         <4b5a58aedb596937618dd7d8fecda9743371d101.camel@HansenPartnership.com>
         <20200928112046.GA14051@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-09-28 at 14:20 +0300, Jarkko Sakkinen wrote:
> On Sun, Sep 27, 2020 at 06:03:37PM -0700, James Bottomley wrote:
> > On Mon, 2020-09-28 at 03:11 +0300, Jarkko Sakkinen wrote:
> > > On Sun, Sep 27, 2020 at 04:17:40PM -0700, James Bottomley wrote:
[...]
> > > > +EXPORT_SYMBOL_GPL(tpm2_flush_context_cmd);
> > > 
> > > Otherwise fine but please rename the existing function as
> > > __tpm2_flush_context() and exported as tpm2_flush_context().
> > 
> > If I do this it churns the code base more: we have one external
> > consumer and four internal ones, so now each of the internal ones
> > would have to become __tpm_flush_context().  We also have
> > precedence for the xxx_cmd form with tpm2_unseal_cmd,
> > tpm2_load_cmd.
> 
> There are no internals version of aforementioned functions, but in
> the sense of common convention for such that encapsulate a single TPM
> command and nothing more or less, your argument make sense.

By internal, I mean use within the tpm core that doesn't require
get/put ops ... there are four of them.

> But it is somewhat common pattern to prefix internal/unlocked version
> with two underscores. So summarizing this I think that the best names
> would be __tpm2_flush_context_cmd() and tpm2_flush_context_cmd().
> 
> But now that I looked at your patch, I remembered the reason why the
> function in question does not take ops, albeit I'm not fully in the
> page why this was not properly implemented in trusted_tpm2.c.
> 
> The principal idea was that the client, e.g. trusted keys would take
> the ops and execute series of commands and then return ops.
> Otherwise, there is a probel in atomicity, i.e. someone could race
> between unseal and flush.
> 
> int tpm2_unseal_trusted(struct tpm_chip *chip,
> 			struct trusted_key_payload *payload,
> 			struct trusted_key_options *options)
> {
> 	u32 blob_handle;
> 	int rc;
> 
> 	rc = tpm_try_get_ops(chip);
> 	if (rc)
> 		goto out;
> 
> 	rc = tpm2_load_cmd(chip, payload, options, &blob_handle);
> 	if (rc)
> 		goto out;
> 
> 	rc = tpm2_unseal_cmd(chip, payload, options, blob_handle);
> 	tpm2_flush_context(chip, blob_handle);
> 
> out:
> 	tpm_put_ops(chip);
> 	return rc;
> }
> 
> In addition to this fix, I think we should put a note to kdoc of each
> exported function that please grab the ops before using.

Well, um, that's precisely what this function originally did when it
was inside drivers/char/tpm.  You told the guy who did the move into
security/keys/trusted-keys to convert everything to use tpm_send which
encapsulates the get/put operation, which is why we now have the flush
bug.  If you really want it done like this, then I'd recommend moving
everything back to drivers/char/tpm so we don't have to do a global
exposure of a load of tpm internal functions (i.e. move them from
drivers/char/tmp.h to include/linux/tpm.h and do an export on them).

James


