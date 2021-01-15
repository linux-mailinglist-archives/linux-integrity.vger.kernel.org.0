Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4C52F8344
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Jan 2021 19:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbhAOSFj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 Jan 2021 13:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbhAOSFj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Jan 2021 13:05:39 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFB3C061757;
        Fri, 15 Jan 2021 10:04:59 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 163261280597;
        Fri, 15 Jan 2021 10:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1610733899;
        bh=xsFNGYH7x63tG5K+gNb56wwqh9ltS3YNaZU6HYk6/5g=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=p8hNcQEogeVN6x2qJAQFBn/8jCFn75Wf7CPD++W/GfFTpjAK7TL3ipS60kTmUVnwh
         93n6dXIR0SaqRMS1mp4eCpodS4mYVjrwaCmlN2hAMV79j6NOsGpsEF9bQ3Z1GISxsQ
         eLxbSydbsnzl7v7DgBQqu83lnMQf0uWaS2jQYO90=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xsJMpLRzkiva; Fri, 15 Jan 2021 10:04:59 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::c447])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id A1296128057D;
        Fri, 15 Jan 2021 10:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1610733898;
        bh=xsFNGYH7x63tG5K+gNb56wwqh9ltS3YNaZU6HYk6/5g=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Ie49vnZqGY7OTb3pLocJ0hFIyKLpX9PX/+DCvF7lmMPJt3jGPwztCbEjR7v8upIpG
         EACAgYs4pwVm84PVjec9ON9jwHa1PVJRhz6NCehVxr4XcgLoKJviuHRA1SUXd+3gB3
         wsa/PV6hB94i/JBAby5RHgeKalRdXuEorr2WKgXE=
Message-ID: <17e5f9ca292f5edf51f50cae370c2154a9c69e89.camel@HansenPartnership.com>
Subject: Re: [PATCH v5 1/1] tpm: add sysfs exports for all banks of PCR
 registers
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Greg KH <greg@kroah.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-api@vger.kernel.org
Date:   Fri, 15 Jan 2021 10:04:57 -0800
In-Reply-To: <X/6mM/egPLyXASM9@kroah.com>
References: <20210113015958.6685-1-James.Bottomley@HansenPartnership.com>
         <20210113015958.6685-2-James.Bottomley@HansenPartnership.com>
         <X/6mM/egPLyXASM9@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[separate reply because the asked about part isn't in my patch it's in
existing code]

On Wed, 2021-01-13 at 08:50 +0100, Greg KH wrote:
> On Tue, Jan 12, 2021 at 05:59:58PM -0800, James Bottomley wrote:
[...]
> >  void tpm_sysfs_add_device(struct tpm_chip *chip)
> >  {
> > +	int i;
> > +
> >  	WARN_ON(chip->groups_cnt != 0);
> > +
> 
> How can that WARN_ON happen?

If tpm_sysfs_add_device gets called more than once, say because reuse
of the chip structure that causes it to be initialized again without
properly being torn down.  I think it's a reasonable assert given that
we'll run off the end of the chip->groups array if it isn't true ...
which does really argue it should be a BUG_ON because the machine will
be compromised and likely unrecoverable if it triggers.

James


