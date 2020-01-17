Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29EAB141493
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Jan 2020 00:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbgAQXAO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Jan 2020 18:00:14 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:37404 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729195AbgAQXAO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Jan 2020 18:00:14 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id BFD388EE2DB;
        Fri, 17 Jan 2020 15:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1579302013;
        bh=vxO5AoZxT0ZUcTqYj7pHbYPzZ59Zv+AGnM+WpPZP9HA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jlbwAjXtKFc/s5uBARfiToJ1j5equSrJNXxovCSbax6dDY3zDa6HWYrkhEAOCPp5+
         ThMuifbr2nKz6Se3nRrqW5S2ZjBg+Wkq8gFpn41H1YhItl+enUUf2DDmadYYK50shv
         fetqCvxVkEeoznjnGisMeo7DuwYt5t4IsOUa6xVI=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xYMUKwQe4wBK; Fri, 17 Jan 2020 15:00:13 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 18E818EE181;
        Fri, 17 Jan 2020 15:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1579302013;
        bh=vxO5AoZxT0ZUcTqYj7pHbYPzZ59Zv+AGnM+WpPZP9HA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jlbwAjXtKFc/s5uBARfiToJ1j5equSrJNXxovCSbax6dDY3zDa6HWYrkhEAOCPp5+
         ThMuifbr2nKz6Se3nRrqW5S2ZjBg+Wkq8gFpn41H1YhItl+enUUf2DDmadYYK50shv
         fetqCvxVkEeoznjnGisMeo7DuwYt5t4IsOUa6xVI=
Message-ID: <1579302011.13499.9.camel@HansenPartnership.com>
Subject: Re: ima pcr question
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org
Date:   Fri, 17 Jan 2020 15:00:11 -0800
In-Reply-To: <20200117222920.2d42m3ahxznl64em@cantor>
References: <20200114000602.h5k5rr2k6zl3dlts@cantor>
         <1578964659.5796.7.camel@linux.ibm.com>
         <20200117222920.2d42m3ahxznl64em@cantor>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-01-17 at 15:29 -0700, Jerry Snitselaar wrote:
> On Mon Jan 13 20, Mimi Zohar wrote:
> > On Mon, 2020-01-13 at 17:06 -0700, Jerry Snitselaar wrote:
> > > We had a report of messages from ima saying "Error communicating
> > > with
> > > TPM".  Looking into it a bit, it looks like with some Dell
> > > systems
> > > (possibly others as well) in the bios they can set the hash
> > > algorithm
> > > being used. In this case with that set to sha256 the messages
> > > appear. Flipping the system to using sha1 makes them disappear.
> > > Looking at the ima code, ima_calc_boot_aggregate_tfm hard codes
> > > using
> > > sha1. Should that be changed to use whatever the default is in
> > > the
> > > config, or possibly find out from the tpm what algorithm is being
> > > used?
> > 
> > The ima-ng template contains two digests.  The first digest is the
> > value being extended into the TPM, while the second digest is
> > either
> > the boot aggregate or file data hash.  It sounds like the problem
> > is
> > with the first digest.  Changing the boot-aggregate to use sha256
> > might be a good idea, but probably won't fix the problem.
> > 
> > Mimi
> > 
> 
> The error message is coming from ima_pcrread, and the tpm_digest that
> gets passed
> by ima_calc_boot_aggregate_tfm to ima_pcrread is declared:
> 
> 	struct tpm_digest d = { .alg_id = TPM_ALG_SHA1, .digest = {0}
> };
> 
> According to Dell their default BIOS setting is to use sha256. What
> they see with that
> setting is:
> 
> [ 5.475036] ima: Error Communicating to TPM chip
> [ 5.475083] tsc: Refined TSC clocksource calibration: 3311.999 MHz
> [ 5.475092] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:
> 0x2fbd936b72f, max_idle_ns: 440795283163 ns
> [ 5.475118] ima: Error Communicating to TPM chip
> [ 5.475165] ima: Error Communicating to TPM chip
> [ 5.475235] clocksource: Switched to clocksource tsc
> [ 5.475266] ima: Error Communicating to TPM chip
> [ 5.475311] ima: Error Communicating to TPM chip
> [ 5.475341] ima: Error Communicating to TPM chip
> [ 5.475371] ima: Error Communicating to TPM chip
> [ 5.475402] ima: Error Communicating to TPM chip
> [ 5.489049] ima: No architecture policies found

The implication seems to be that on a DELL setting the bios default to
sha256 turns off the TPM's sha1 pcr banks ... is that the case?

tssgetcapability -cap 5

should confirm or deny this.

James

