Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31FC4E1DFD
	for <lists+linux-integrity@lfdr.de>; Sun, 20 Mar 2022 22:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343740AbiCTVbp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 20 Mar 2022 17:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236574AbiCTVbp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Mar 2022 17:31:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B233819D;
        Sun, 20 Mar 2022 14:30:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEF69B80EFA;
        Sun, 20 Mar 2022 21:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996A3C340E9;
        Sun, 20 Mar 2022 21:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647811818;
        bh=tTXsRvXcOgBE9bkryBEz2qKjZqFOG8apagVn9U/uti0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p3XF6opLAITbuzC6qPWYfipEKm/uQr/7rBFwWLFBwnrqPVlc4t1suLbbQU3nDKoQz
         Vt/UhFCvJs8KCgIq+j9X68rMLv48PO5LS8XUDHxEPCRFoK/q3pqFpKnCmRdzv1TwSY
         rgFf3mCujGbriNThhNRY/4yE8Obdxg4MBzEEQHbzFJ366yxzohQnnQqbhFzxziYfFN
         5jle4eIxmZtag+2HXRCLHQ7D/4b9u1p8Jck87YEYb+cunlYAn1R2HCKkCUN/ftVyLL
         k/gAnAma91++7ccEszyF0PvfCuinT1joWPi7wpyoJf+7xQHOUWeBucleeQyAfhlW7F
         W178jPJ4zAWRg==
Date:   Sun, 20 Mar 2022 23:31:19 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Nayna <nayna@linux.vnet.ibm.com>
Cc:     Nageswara Sastry <rnsastry@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        dhowells@redhat.com, zohar@linux.ibm.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me, Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v11 0/4] integrity: support including firmware
 ".platform" keys at build time
Message-ID: <YjedJxNNv8KifAKd@kernel.org>
References: <20220310214450.676505-1-nayna@linux.ibm.com>
 <4afae87c-2986-6b0e-07be-954dd4937afd@linux.ibm.com>
 <f78d11fefd13bd17748e36621acee9c2f27a77f6.camel@kernel.org>
 <f92ec4d8-47c0-ece5-3c52-caeb8265881c@linux.vnet.ibm.com>
 <YjLlYTs+2ep80zoK@iki.fi>
 <57d7034a-fb5c-444e-a709-4f993459688e@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57d7034a-fb5c-444e-a709-4f993459688e@linux.vnet.ibm.com>
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Mar 18, 2022 at 05:25:07PM -0400, Nayna wrote:
> 
> On 3/17/22 03:38, Jarkko Sakkinen wrote:
> > On Fri, Mar 11, 2022 at 04:03:12PM -0500, Nayna wrote:
> > > On 3/11/22 11:42, Jarkko Sakkinen wrote:
> > > > ".platform" keyring.
> > > > > > Changelog:
> > > > > > v11:
> > > > > > * Added a new patch to conditionally build extract-cert if
> > > > > > PLATFORM_KEYRING is enabled.
> > > > > > 
> > > > > Tested the following four patches with and with out setting
> > > > > CONFIG_INTEGRITY_PLATFORM_KEYS
> > > > > 
> > > > > Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
> > > > OK, I added it:
> > > > 
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
> > > Thanks Jarkko. Masahiro Yamada would prefer to revert the original commit
> > > 340a02535ee785c64c62a9c45706597a0139e972 i.e. move extract-cert back to the
> > > scripts/ directory.
> > > 
> > > I am just posting v12 which includes Masahiro feedback. Nageswara has
> > > already tested v12 version as well.
> > > 
> > > I am fine either way 1.) Adding v11 and then separately handling of
> > > reverting of the commit or 2.) Adding v12 version which includes the revert.
> > > I leave the decision on you as to which one to upstream.
> > > 
> > > Thanks & Regards,
> > > 
> > >      - Nayna
> > > 
> > I already sent PR for v5.18. Too many late changes to include this, which
> > means that v12 is the way to go.
> 
> Assuming v12 looks good, could you please queue it now ?
> 
> Thanks & Regards,
> 
>     - Nayna
> 

Unfortunately, I've already sent my v5.18 PR over a week ago. I can put it
to my queue but I think it is lacking some of the tested by tags, doesn't
it?

BR, Jarkko
