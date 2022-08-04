Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206BD58958C
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Aug 2022 02:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238885AbiHDA7h (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 3 Aug 2022 20:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238861AbiHDA7g (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Aug 2022 20:59:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440655F9AF;
        Wed,  3 Aug 2022 17:59:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B839861751;
        Thu,  4 Aug 2022 00:59:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98755C433C1;
        Thu,  4 Aug 2022 00:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659574773;
        bh=c0/kYEt5J2FdFJ1FwCq/4THeVhzcRRwZ4/5qZhcI7OE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F4wcugpqGGlPXXs70am0ZjVTUrZiqaKLeXs3OasZWwFdN1LltdJ4eybaDZ6H0ns5y
         v6uB4vaqKembrVC3p0SxJHJlHmqCBe/dU50f7AyBp/tWsTyk1HD4O6CQFuOE86dcid
         G0Nh7kIvy/CPexZ3/IOJF+CQE9+d5L7VFpu9zaqeuuLR8Y/8SKN7+3Fo9SVGrqnfgC
         tWWzGeEToXMW6Vex1z+NbfJubFno50C/TkJscFAhkDFvjh9xBPcOm8a1TjtrsB3vxT
         czEg5uT1k7lwXWapU3btmj1gxrU2X4GutaCBtKlp3z9oqXiIdMQfSijMSZ/jNcKmNg
         yzkbTbJIgOcIA==
Date:   Thu, 4 Aug 2022 03:59:30 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Matthew Garrett <mgarrett@aurora.tech>
Cc:     Evan Green <evgreen@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniil Lunev <dlunev@google.com>, zohar@linux.ibm.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Hao Wu <hao.wu@rubrik.com>, James Morris <jmorris@namei.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Len Brown <len.brown@intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "Serge E. Hallyn" <serge@hallyn.com>, axelj <axelj@axis.com>,
        keyrings@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 00/10] Encrypted Hibernation
Message-ID: <YusZ8gD/LjiAXadR@kernel.org>
References: <20220504232102.469959-1-evgreen@chromium.org>
 <20220506160807.GA1060@bug>
 <CAE=gft6m75T0UC2DBhfFhuSMW6TK7aatD_04sQ18WosgGVsATw@mail.gmail.com>
 <CAJZ5v0gxq=EA_WWUiCR_w8o87iTHDR7OC5wi=GRBaAQS2ofd5w@mail.gmail.com>
 <CAE=gft6V6RLc-d4AOuRUVU2u1jMGghDRSrFqiCqMCLxemui8Pw@mail.gmail.com>
 <CAE=gft5OYAgosqmwNkk=Cwoooeg93Njmnzfz=gwCaLB0Ts+=sw@mail.gmail.com>
 <CAE=gft6sPkhNcz7+fJuDzQo2f8fM_0Wv_OWC9W2LyvXd6M6zeQ@mail.gmail.com>
 <CAHSSk05JEcZfS2tc22F+m76T3vZt-mZ7zUQaGRgSanKaFc5xBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHSSk05JEcZfS2tc22F+m76T3vZt-mZ7zUQaGRgSanKaFc5xBg@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Aug 02, 2022 at 11:36:43AM -0700, Matthew Garrett wrote:
> On Mon, Aug 1, 2022 at 3:33 PM Evan Green <evgreen@chromium.org> wrote:
> 
> > One more bump here, as we'd really love to get encrypted hibernation
> > to a form upstream would accept if at all possible. We were
> > considering landing this in our Chrome OS tree for now, then coming
> > back in a couple months with a "we've been baking this ourselves and
> > it's going so great, oooh yeah". I'm not sure if upstream would find
> > that compelling or not. But in any case, some guidance towards making
> > this more upstream friendly would be well appreciated.
> >
> > One thing I realized in attempting to pick this myself is that the
> > trusted key blob format has moved to ASN.1. So I should really move
> > the creation ticket to the new ASN.1 format (if I can figure out the
> > right OID for that piece), which would allow me to drop a lot of the
> > ugly stuff in tpm2_unpack_blob(). Maybe if I get no other comments
> > I'll work on that and resend.
> 
> I've been revamping my TPM-backed verified hibernation implementation
> based on this work, so I'd definitely be enthusiastic about it being
> mergeable.

BTW, is it tested with QEMU + swtpm?

BR, Jarkko
