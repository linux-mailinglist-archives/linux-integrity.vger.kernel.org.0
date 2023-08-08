Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E75E7749EC
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Aug 2023 22:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbjHHUG1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Aug 2023 16:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbjHHUGN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Aug 2023 16:06:13 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D24822F84;
        Tue,  8 Aug 2023 11:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1691519214;
        bh=nf3BaQXxRA33pJp2hKQJ3qUrmelsR3GEg4lBetR0PAA=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=AnuO9/kREwKZFONz5+Ut6FZhZXvoM0vuCQzrlcV00CRLv7xUDw5D5Xqj79fJVyWil
         WbBQcbiR0vDM2X00epRdX8sVuYliMI1juUyshQl3JTeZL5w8M8VNl79U0XVfspxPoN
         lo0GMhX5wE75aYSMIqoq+CxDbUe4EDt8CI/aJU48=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id EA32C1281F11;
        Tue,  8 Aug 2023 14:26:54 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id yoVfUEHA7qBG; Tue,  8 Aug 2023 14:26:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1691519214;
        bh=nf3BaQXxRA33pJp2hKQJ3qUrmelsR3GEg4lBetR0PAA=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=AnuO9/kREwKZFONz5+Ut6FZhZXvoM0vuCQzrlcV00CRLv7xUDw5D5Xqj79fJVyWil
         WbBQcbiR0vDM2X00epRdX8sVuYliMI1juUyshQl3JTeZL5w8M8VNl79U0XVfspxPoN
         lo0GMhX5wE75aYSMIqoq+CxDbUe4EDt8CI/aJU48=
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 381461281B5C;
        Tue,  8 Aug 2023 14:26:53 -0400 (EDT)
Message-ID: <350ecdcbf7796f488807fcd7983414a02dd71be4.camel@HansenPartnership.com>
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        kgold@linux.ibm.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, kexec@lists.infradead.org, jmorris@namei.org,
        Paul Moore <paul@paul-moore.com>, serge@hallyn.com
Cc:     code@tyhicks.com, nramas@linux.microsoft.com,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-security-module@vger.kernel.org
Date:   Tue, 08 Aug 2023 14:26:51 -0400
In-Reply-To: <abe53dde-9a83-81fd-422d-babf4587c545@linux.ibm.com>
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
         <b748230c8ee291288afcf48898507556c3aa7c71.camel@HansenPartnership.com>
         <5d21276a-daac-fc9b-add9-62e7c04bbdcd@linux.ibm.com>
         <8ad131f35c33cf10788344be6c981473971f9c1c.camel@HansenPartnership.com>
         <abe53dde-9a83-81fd-422d-babf4587c545@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2023-08-08 at 09:31 -0400, Stefan Berger wrote:
> 
> 
> On 8/8/23 08:35, James Bottomley wrote:
> > On Mon, 2023-08-07 at 18:49 -0400, Stefan Berger wrote:
> > > 
> > > 
> > > On 8/1/23 17:21, James Bottomley wrote:
> > > > On Tue, 2023-08-01 at 12:12 -0700, Sush Shringarputale wrote:
> > > > [...]
> > > > > Truncating IMA log to reclaim memory is not feasible, since
> > > > > it makes the log go out of sync with the TPM PCR quote making
> > > > > remote attestation fail.
> > > > 
> > > > This assumption isn't entirely true.  It's perfectly possible
> > > > to shard an IMA log using two TPM2_Quote's for the beginning
> > > > and end PCR values to validate the shard.  The IMA log could be
> > > > truncated in the same way (replace the removed part of the log
> > > > with a TPM2_Quote and AK, so the log still validates from the
> > > > beginning quote to the end).
> > > > 
> > > > If you use a TPM2_Quote mechanism to save the log, all you need
> > > > to do is have the kernel generate the quote with an internal
> > > > AK.  You can keep a record of the quote and the AK at the
> > > > beginning of the truncated kernel log.  If the truncated
> > > > entries are saved in a file shard it
> > > 
> > > The truncation seems dangerous to me. Maybe not all the scenarios
> > > with an attestation client (client = reading logs and quoting)
> > > are possible then anymore, such as starting an attestation client
> > > only after truncation but a verifier must have witnessed the
> > > system's PCRs and log state before the truncation occurred.
> > 
> > That's not exactly correct.  Nothing needs to have "witnessed" the
> > starting PCR value because the quote vouches for it (and can vouch
> > for it after the fact).  The only thing you need to verify the
> > quote is the attestation key and the only thing you need to do to
> > trust the attestation key is ensure it was TPM created.  All of
> > that can be verified after the fact as well.  The only thing that
> > can be done to disrupt this is to destroy the TPM (or re-own it).> 
> > Remember the assumption is you *also* have the removed log shard to
> > present.  From that the PCR state of the starting quote can be
> 
> Yes, the whole sequence of old logs needs to be available.

Yes and no.  If the person relying on the logs is happy they've
extracted all the evidentiary value from the log itself then they can
reduce the preceding log shard to simply the PCR values that match the
quote and discard the rest.

>  IF that's the case and the logs can be stitched together seamlessly,
> who then looks at the kernel AK quote and under what circumstances?

For incremental attestation.  Each log shard can be verified using the
base PCR values corresponding to the bottom quote then replayed and the
top quote verified.  This means that logs that aren't needed anymore
can be discarded, which, I recall, was the base reason for this
proposal: reducing IMA memory consumption.  Although all you need to do
is extract the shards from kernel memory to file space and free the
kernel memory.  Since that scheme can keep all logs intact, there's no
reason to further reduce them unless the filesystem is running out of
space.

James

