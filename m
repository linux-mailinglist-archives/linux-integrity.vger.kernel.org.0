Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6191B774D2F
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Aug 2023 23:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjHHVle (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Aug 2023 17:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjHHVle (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Aug 2023 17:41:34 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E6F10C;
        Tue,  8 Aug 2023 14:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1691530892;
        bh=i7hpyEZEZWlj2Ajx+MRSG8JElxaDe4Jh8vwUZ2MfVZ0=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=SEXS9n/2I4Tq6aZIxULzbS1JaJkekArdJRcRy5jh6mLcGadvf64e2TTY13OkPul+L
         hr+OtBlf6ENxwni+EDCEXE7azzEgLfviTTz4S7YkjDkKesRr7KpKiDs1KRpf9DLmdh
         GRPr4TkPPPT0nzIQ16gr8lLhHSCrhoFlruyfgvds=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 65ED712811F6;
        Tue,  8 Aug 2023 17:41:32 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id SUFS-be2u0MT; Tue,  8 Aug 2023 17:41:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1691530892;
        bh=i7hpyEZEZWlj2Ajx+MRSG8JElxaDe4Jh8vwUZ2MfVZ0=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=SEXS9n/2I4Tq6aZIxULzbS1JaJkekArdJRcRy5jh6mLcGadvf64e2TTY13OkPul+L
         hr+OtBlf6ENxwni+EDCEXE7azzEgLfviTTz4S7YkjDkKesRr7KpKiDs1KRpf9DLmdh
         GRPr4TkPPPT0nzIQ16gr8lLhHSCrhoFlruyfgvds=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 9D1051280F38;
        Tue,  8 Aug 2023 17:41:30 -0400 (EDT)
Message-ID: <a522b17a536ea87a6a4c2faf95583ae3b7b74a26.camel@HansenPartnership.com>
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
Date:   Tue, 08 Aug 2023 17:41:28 -0400
In-Reply-To: <04fb2fe5-9ebe-b35f-bdde-6ef22786438f@linux.ibm.com>
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
         <b748230c8ee291288afcf48898507556c3aa7c71.camel@HansenPartnership.com>
         <5d21276a-daac-fc9b-add9-62e7c04bbdcd@linux.ibm.com>
         <8ad131f35c33cf10788344be6c981473971f9c1c.camel@HansenPartnership.com>
         <abe53dde-9a83-81fd-422d-babf4587c545@linux.ibm.com>
         <350ecdcbf7796f488807fcd7983414a02dd71be4.camel@HansenPartnership.com>
         <04fb2fe5-9ebe-b35f-bdde-6ef22786438f@linux.ibm.com>
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

On Tue, 2023-08-08 at 16:09 -0400, Stefan Berger wrote:
> 
> 
> On 8/8/23 14:26, James Bottomley wrote:
> > On Tue, 2023-08-08 at 09:31 -0400, Stefan Berger wrote:
> > > 
> > > 
> > > On 8/8/23 08:35, James Bottomley wrote:
> > > > On Mon, 2023-08-07 at 18:49 -0400, Stefan Berger wrote:
> > > > > 
> > > > > 
> > > > > On 8/1/23 17:21, James Bottomley wrote:
> > > > > > On Tue, 2023-08-01 at 12:12 -0700, Sush Shringarputale
> > > > > > wrote:
> > > > > > [...]
> > > > > > > Truncating IMA log to reclaim memory is not feasible,
> > > > > > > since
> > > > > > > it makes the log go out of sync with the TPM PCR quote
> > > > > > > making
> > > > > > > remote attestation fail.
> > > > > > 
> > > > > > This assumption isn't entirely true.  It's perfectly
> > > > > > possible
> > > > > > to shard an IMA log using two TPM2_Quote's for the
> > > > > > beginning
> > > > > > and end PCR values to validate the shard.  The IMA log
> > > > > > could be
> > > > > > truncated in the same way (replace the removed part of the
> > > > > > log
> > > > > > with a TPM2_Quote and AK, so the log still validates from
> > > > > > the
> > > > > > beginning quote to the end).
> > > > > > 
> > > > > > If you use a TPM2_Quote mechanism to save the log, all you
> > > > > > need
> > > > > > to do is have the kernel generate the quote with an
> > > > > > internal
> > > > > > AK.  You can keep a record of the quote and the AK at the
> > > > > > beginning of the truncated kernel log.  If the truncated
> > > > > > entries are saved in a file shard it
> > > > > 
> > > > > The truncation seems dangerous to me. Maybe not all the
> > > > > scenarios
> > > > > with an attestation client (client = reading logs and
> > > > > quoting)
> > > > > are possible then anymore, such as starting an attestation
> > > > > client
> > > > > only after truncation but a verifier must have witnessed the
> > > > > system's PCRs and log state before the truncation occurred.
> > > > 
> > > > That's not exactly correct.  Nothing needs to have "witnessed"
> > > > the
> > > > starting PCR value because the quote vouches for it (and can
> > > > vouch
> > > > for it after the fact).  The only thing you need to verify the
> > > > quote is the attestation key and the only thing you need to do
> > > > to
> > > > trust the attestation key is ensure it was TPM created.  All of
> > > > that can be verified after the fact as well.  The only thing
> > > > that
> > > > can be done to disrupt this is to destroy the TPM (or re-own
> > > > it).>
> > > > Remember the assumption is you *also* have the removed log
> > > > shard to
> > > > present.  From that the PCR state of the starting quote can be
> > > 
> > > Yes, the whole sequence of old logs needs to be available.
> > 
> > Yes and no.  If the person relying on the logs is happy they've
> > extracted all the evidentiary value from the log itself then they
> > can
> > reduce the preceding log shard to simply the PCR values that match
> > the
> > quote and discard the rest.
> > 
> > >   IF that's the case and the logs can be stitched together
> > > seamlessly, who then looks at the kernel AK quote and under what
> > > circumstances?
> > 
> > For incremental attestation.  Each log shard can be verified using
> > the base PCR values corresponding to the bottom quote then replayed
> > and the
> 
> 
> Somehow you have to tell a verifier to take a snapshot of the current
> state of the PCRs when it replays the logs to be able to truncate the
> log.

No, the verifier is server side.  It would be the agent or the kernel,
client side, which gets the quote and shards the log.  That way the
operation can be done in such a way as to make sure the quote and the
shard point match.  I'd imagine the verifier can provide some sort of
guide as to how big it wants the shards to be and the client complies.

> Whether the state of the PCRs is in the log itself or it's just some
> sort of entry in the log indicating a truncation probably doesn't
> matter for as long as the verifying side keeps state of the PCRs at
> point of truncatiokn.

The idea would be the log shard would be self attesting, that's why
quote at beginning and end (and probably PCR state at beginning), so no
verifier required until someone wants to check the log.

> Also, the verifying side needs to take notice of the trustworthiness
> of the system at the time the log was truncated in case the
> attestation client is restarted and starts out sending the log with
> the first entry.

That's usually what a runtime verification system is actually
verifying, yes.

>  The PCR state shown at the beginning of the truncated log (when
> restarting the attestation client) must then match when the 'notice'
> was taken and that determines its trustworthiness at this point in
> the log.
> 
> That there's a kernel AK signature

A quote is a signature over PCR state signed by an AK, yes.

>  at this point doesn't seem necessary since one presumably can verify
> the log and PCR states at the end with the 'regular' quote.

I don't understand this.  A regular quote is a signature over PCR state
by an AK.  The point about saving the AK in the log for the original is
that if the *kernel* truncates the log and saves it to a file, it needs
to generate both the AK and the quote for the top of the file shard. 
That means the AK/EK binding is unverified, but can be verified by
loading the AK and running the usual tests, which can only be done if
you have the loadable AK, which is why you need it as part of the log
saving proposal.

> Nobody should ever trust a system by starting to look at the
> beginning of a truncated log. You have to have evaluated all the
> entries in the log before and determined whether the system was
> trustworthy. I don't think the kernel AK quote buys much - at least
> not from what I can see.

You have a log shard with PCR state at the beginning and calculated at
the end, both of which you can verify.  How you establish trust in the
starting PCR values of the shard is a policy decision, but the policy
doesn't have to be you see every shard up to boot.  You could take the
word of the system owner on a handoff of responsibility for instance.

James

