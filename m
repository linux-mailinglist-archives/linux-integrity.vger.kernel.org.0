Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F4E77776E
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Aug 2023 13:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbjHJLne (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Aug 2023 07:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbjHJLne (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Aug 2023 07:43:34 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2478091;
        Thu, 10 Aug 2023 04:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1691667810;
        bh=nEaH47B5XUG+dGWKW2MTI/k+KrlwMmhRhGED9/yMPoY=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=tsmOTLMDWCdMKJ6jnBtKg+1cNJKoROy+6PYx53l52uIx7ypH4yWcot/RNrW2/22/W
         kWXyo3ntZaMSXaxJ1bBnFtZ6SAHkn8vOvzOpvNZE/LRN4liZO9aOPisqC2NwQ0Kgjd
         E8SnD0iMAk4D9AbCTVq2G4CqWAIMYcCb3QYw6zxc=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 31B151281B19;
        Thu, 10 Aug 2023 07:43:30 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id xfvz0UbcUk3I; Thu, 10 Aug 2023 07:43:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1691667809;
        bh=nEaH47B5XUG+dGWKW2MTI/k+KrlwMmhRhGED9/yMPoY=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=kNVgQPrNN45DM9R91wZjrcClQB6Oo5nadexXVgwIsJy5hlIE8iRPQ6Ja2UEWah7II
         SD8OX0pbv8rvPPHrRK4RokmMRsYsh5UINXvpBXKOfHAUXJlqnD+EsXyb88x8bsNp3A
         Rk2aYnkruY7BKGXKaXeDau1dE/n9X4tJp0GdJLiI=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 605111281A2E;
        Thu, 10 Aug 2023 07:43:28 -0400 (EDT)
Message-ID: <8ccaec30bf85cfbf4415bbafa22646a62e753840.camel@HansenPartnership.com>
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        kgold@linux.ibm.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, kexec@lists.infradead.org, jmorris@namei.org,
        Paul Moore <paul@paul-moore.com>, serge@hallyn.com
Cc:     code@tyhicks.com, nramas@linux.microsoft.com,
        linux-security-module@vger.kernel.org
Date:   Thu, 10 Aug 2023 07:43:25 -0400
In-Reply-To: <5cb03349-7a32-8f74-f2a1-ff3c6247c1ef@linux.microsoft.com>
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
         <b748230c8ee291288afcf48898507556c3aa7c71.camel@HansenPartnership.com>
         <5d21276a-daac-fc9b-add9-62e7c04bbdcd@linux.ibm.com>
         <8ad131f35c33cf10788344be6c981473971f9c1c.camel@HansenPartnership.com>
         <abe53dde-9a83-81fd-422d-babf4587c545@linux.ibm.com>
         <350ecdcbf7796f488807fcd7983414a02dd71be4.camel@HansenPartnership.com>
         <04fb2fe5-9ebe-b35f-bdde-6ef22786438f@linux.ibm.com>
         <a522b17a536ea87a6a4c2faf95583ae3b7b74a26.camel@HansenPartnership.com>
         <5cb03349-7a32-8f74-f2a1-ff3c6247c1ef@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2023-08-09 at 21:43 -0700, Tushar Sugandhi wrote:
> On 8/8/23 14:41, James Bottomley wrote:
> > On Tue, 2023-08-08 at 16:09 -0400, Stefan Berger wrote:
[...]
> > >   at this point doesn't seem necessary since one presumably can
> > > verify the log and PCR states at the end with the 'regular'
> > > quote.
> >  
> > I don't understand this.  A regular quote is a signature over PCR
> > state by an AK.  The point about saving the AK in the log for the
> > original is that if the *kernel* truncates the log and saves it to
> > a file, it needs to generate both the AK and the quote for the top
> > of the file shard. That means the AK/EK binding is unverified, but
> > can be verified by loading the AK and running the usual tests,
> > which can only be done if you have the loadable AK, which is why
> > you need it as part of the log saving proposal.
>  
> I had this question about the usability of AK/EK in this
> context. Although AK/EK + PCR quote is needed to verify the snapshot
> shards / IMA logs are not tampered with, I am still not sure why
> AK/EK needs to be part of the shard/IMA log. The client sending AK/EK
> to attestation service separately would still serve the purpose,
> right?

Well, the EK doesn't need to be part of the log: it's just a permanent
part of the TPM identity.  To verify the log, you need access to the
TPM that was used to create it, so that's the point at which you get
the EK.

An AK is simply a TPM generated signing key (meaning the private part
of the key is secured by the TPM and known to no-one else).  In the
literature a TPM generated signing key doesn't become an Attestation
Key until it's been verified using an EK property (either a certify for
a signing EK or a make/activate credential round trip for the more
usual encryption EK.

So the proposal is for each quote that's used to verify a log shard is
that the TPM simply generate a random signing key and use that to sign
the quote.  You need to save the TPM form of the generated key so it
can be loaded later and the reason for that is you can do the EK
verification at any time after the quote was given by loading the saved
key and running the verification protocol.  In the normal attestation
you do the EK verification of the AK *before* the quote, but there's no
property of the quote that depends on this precedence provided you do
the quote with a TPM generated signing key.

The underlying point is that the usual way an EK verifies an AK
requires a remote observer, which the kernel won't have, so the kernel
must do all its stuff locally (generate key, get quote) and then at
some point later the system can become remote connected and prove to
whatever external entity that the log shard is valid.  So we have to
have all the components necessary for that proof: the log shard, the
quote and the TPM form of the AK.

> For instance, PCR quotes will be signed by AK. So as long as the
> verifier trusts the AK/EK,

Right, but if you're sharding a log, the kernel doesn't know if a
verifier has been in contact yet.  The point of the protocol above is
to make that not matter.  The verifier can contact the system after the
log has been saved and the verification will still work.

>  it can verify the quotes are not tampered with.
> Replaying IMA log/snapshot can produce the PCR quotes which can be
> matched with signed PCR quotes. If they match, then the verifier can
> conclude that the IMA log is not tampered with. So AK doesn't need to
> be part of the log/snapshot.

Only if the system is currently in contact with the verifier and the
verifier has created the AK.  That may not have happened.

> BTW, in this proposal, kernel is truncating the log and passing the
> truncated buffer to UM.  UM client need to save it to the disk
> location of it's choice.

Yes, but I was assuming tampering with or discarding the log file would
be treated in exactly the same way as an in-kernel IMA log tamper.

James

