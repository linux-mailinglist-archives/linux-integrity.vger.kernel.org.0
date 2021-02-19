Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE3231FED7
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Feb 2021 19:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhBSSfo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Feb 2021 13:35:44 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:36958 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229515AbhBSSfm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Feb 2021 13:35:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 67A6812807D2;
        Fri, 19 Feb 2021 10:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1613759701;
        bh=Rpg3IuQneyI5VDNOWrjCeA2Yh5yooomudgd/tqrny0g=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=WBWXTzZSaAuc/StXw8IEdLNEYQYycFiroS5wx52oioCDcOAukBTKIVI6A/0vCcxZH
         S+lNzb37nZyMW1MH8I8ALsiLKZYq6jcsWz/qmI8iJ2gu7+Lfyw0EzpO/k8RR2sQTn7
         rcPD2gYS0kvLtDlkmWnXknO22ABKjCoryNG6WzXU=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 77owJ4ut1cIB; Fri, 19 Feb 2021 10:35:01 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::c447])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E24711280792;
        Fri, 19 Feb 2021 10:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1613759701;
        bh=Rpg3IuQneyI5VDNOWrjCeA2Yh5yooomudgd/tqrny0g=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=WBWXTzZSaAuc/StXw8IEdLNEYQYycFiroS5wx52oioCDcOAukBTKIVI6A/0vCcxZH
         S+lNzb37nZyMW1MH8I8ALsiLKZYq6jcsWz/qmI8iJ2gu7+Lfyw0EzpO/k8RR2sQTn7
         rcPD2gYS0kvLtDlkmWnXknO22ABKjCoryNG6WzXU=
Message-ID: <17a8229bf8ebc87ad02429643aeee78d803f34f2.camel@HansenPartnership.com>
Subject: Re: [PATCH v15 0/5] TPM 2.0 trusted key rework
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Date:   Fri, 19 Feb 2021 10:35:00 -0800
In-Reply-To: <YDACehLCy4f2sDzo@kernel.org>
References: <20210127190617.17564-1-James.Bottomley@HansenPartnership.com>
         <YDACehLCy4f2sDzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-02-19 at 20:24 +0200, Jarkko Sakkinen wrote:
> On Wed, Jan 27, 2021 at 11:06:12AM -0800, James Bottomley wrote:
> > v15: fix 0day sign issue and add reviews and testeds
> > 
> > General cover letter minus policy bit:
> > 
> > This patch updates the trusted key code to export keys in the ASN.1
> > format used by current TPM key tools (openssl_tpm2_engine and
> > openconnect).  The current code will try to load keys containing
> > policy, but being unable to formulate the policy commands necessary
> > to
> > load them, the unseal will always fail unless the policy is
> > executed
> > in user space and a pre-formed policy session passed in.
> > 
> > The key format is designed to be compatible with our two openssl
> > engine implementations as well as with the format used by
> > openconnect.
> > I've added seal/unseal to my engine so I can use it for
> > interoperability testing and I'll later use this for sealed
> > symmetric
> > keys via engine:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/jejb/openssl_tpm2_engine.git/
> > 
> > James
> > 
> > ---
> > 
> > James Bottomley (5):
> >   lib: add ASN.1 encoder
> >   oid_registry: Add TCG defined OIDS for TPM keys
> >   security: keys: trusted: fix TPM2 authorizations
> >   security: keys: trusted: use ASN.1 TPM2 key format for the blobs
> >   security: keys: trusted: Make sealed key properly interoperable
> 
> This is online again in the master branch. 
> 
> I've mangled the commits as follows:
> 
> 1. Fixed my emails to jarkko@kernel.org.
> 2. Adjusted the Makefile, i.e. separate lines for each entry.
> 3. Fixed the checkpatch issues.
> 
> I guess we could potentially re-consider this to rc2 pull? With all
> the mangling required, did not make sense to include this to the
> first pull.

The way I usually do this in SCSI, because stuff always happens
immediately before the merge window that causes some pull material to
be held over, is an early push, which you've done followed by a late
push on the Friday before the merge window closes of the rest of the
stuff.  This is an example from the last but one merge window:

https://lore.kernel.org/linux-scsi/fdee2336d2a7eada3749e07c3cc6ea682f8200b3.camel@HansenPartnership.com/
https://lore.kernel.org/linux-scsi/4affd2a9c347e5f1231485483bf852737ea08151.camel@HansenPartnership.com/

Linus seems to be happy with this pattern as long as it's well
explained.

James


