Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB4878F0E2
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Aug 2023 18:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237704AbjHaQHG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 31 Aug 2023 12:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjHaQHF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 Aug 2023 12:07:05 -0400
X-Greylist: delayed 641 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 31 Aug 2023 09:06:33 PDT
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7FDA1A3
        for <linux-integrity@vger.kernel.org>; Thu, 31 Aug 2023 09:06:33 -0700 (PDT)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 37VFsPnb004307;
        Thu, 31 Aug 2023 10:54:25 -0500
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 37VFsO32004303;
        Thu, 31 Aug 2023 10:54:24 -0500
Date:   Thu, 31 Aug 2023 10:54:24 -0500
From:   "Dr. Greg" <greg@enjellic.com>
To:     Ken Goldman <kgold@linux.ibm.com>
Cc:     Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
        jmorris@namei.org, Paul Moore <paul@paul-moore.com>,
        serge@hallyn.com, code@tyhicks.com, nramas@linux.microsoft.com,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal - unseal
Message-ID: <20230831155423.GA3820@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com> <1ef45099-da24-b73f-b33f-6a299c0b1696@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ef45099-da24-b73f-b33f-6a299c0b1696@linux.ibm.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Thu, 31 Aug 2023 10:54:26 -0500 (CDT)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Aug 30, 2023 at 03:12:39PM -0400, Ken Goldman wrote:

Good morning, I hope the day is going well for everyone.

> On 8/1/2023 3:12 PM, Sush Shringarputale wrote:
> 
> >For remote attestation to work, the service will need to know how to
> > validate the snapshot_aggregate entry in the IMA log.  It will have
> >to read the PCR values present in the template data of
> >snapshot_aggregate event in the latest IMA log, and ensure that the
> >PCR quotes align with the contents of the past UM_snapshot_file(s).
> >This will re-establish the chain of trust needed for the device to
> >pass remote attestation.  This will also maintain the ability of the
> >remote-attestation-service to seal the secrets, if the client-server
> > use TPM unseal mechanism to attest the state of the device.

> I think that seal/unseal to IMA PCRs is futile.  Since boot is
> multi-threaded, the IMA PCR is unpredictable even when valid.

Yes, unbiased observation calls into question the relevancy of the
2000-2002/Palladium model for TPM based integrity attestation, both
from a hardware and software perspective.  In addition to interference
by standard scheduling artifacts, the notion of everything being SMP
makes PCR invariancy a hopeless issue.

In fact, our trust orchestrators demonstrate that the very act of
modeling, ie computing file digests, causes an event ordering that
will be different from subsequent invocations when the digest value is
cached.  A concept that should be of no surprise to anyone fluent in
the writings of Heisenberg... :-)

We discuss this at some length, along with our proposed solution, in
the documentation that we provide with our TSEM LSM:

https://lore.kernel.org/linux-security-module/20230710102319.19716-1-greg@enjellic.com/T/#t

TSEM is a superset of IMA, given that file checksums are just one of
the components in the security state coefficients that our security
modeling is based on, but the issue is the same.

Having an invariant 'security state' value also simplifies the
attestation processw, since the relying party only needs to evaluate a
single signed value in order to verify that the workload has been
consistent with its desired security model.

It is also becoming increasingly apparent that advancing the art of
integrity and trusted systems will become problematic without the
ability to 'namespace' or partition integrity on a workload by
workload basis.  We also introduce support for that with our security
modeling namespaces.

I missed copying the LSM list on my reply, but I discussed some of the
challenges that TDX, and COCO in general, raises to current integrity
infrastructures in the following thread, which should be easily
locatable on the LKML or COCO lists:

tsm: Introduce a shared ABI for attestation reports

Given our experiences, it is difficult to understand how the notion of
'legitimate' confidential computing is going to grow from 7 billion
dollars to 55 billion dollars over the next five years without the
concept of better 'trust orchestration'.

Have a good remainder of the week.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
