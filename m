Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BC54E5293
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Mar 2022 13:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239202AbiCWM5U (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Mar 2022 08:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbiCWM5U (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Mar 2022 08:57:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961627C795
        for <linux-integrity@vger.kernel.org>; Wed, 23 Mar 2022 05:55:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4290B1F37F;
        Wed, 23 Mar 2022 12:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648040149;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4Tey47sun5Fwc+RLPFpnZbktVRKnjI17SZzwyHGHCLI=;
        b=YV2a3tmH1bs0nG9F86ILBdHlHAmBjn7oBbNGK4vZQHkx/29CYR5SPgr25fOk/Kjzcs6+hu
        PqyctvenDd1Mzya0pcde6i1CqOzL9DDdeVDKH0jZMFhYhL1iXcXzbW2dUs27c2TMsKowb3
        fCABZoCsZUnMxnZ486iBREZWkPUTkJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648040149;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4Tey47sun5Fwc+RLPFpnZbktVRKnjI17SZzwyHGHCLI=;
        b=2jCrqTwKrJYU72OvwAvf2VKMbMizznJA+uQH2UeHBDaCZy+ugoonaccBfkQ68wjmxhhQrG
        2OiKXqEy/UAN2dBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 17C8D12FC5;
        Wed, 23 Mar 2022 12:55:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dNx6A9UYO2LAGQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 23 Mar 2022 12:55:49 +0000
Date:   Wed, 23 Mar 2022 13:55:47 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        "Bruno E. O. Meneguele" <bmeneg@redhat.com>
Subject: Re: [PATCH 1/1] ci: Remove CentOS 8
Message-ID: <YjsY01DZe0X67rUx@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220215074958.6942-1-pvorel@suse.cz>
 <401a1ee927a68a7c0811f21f4e75b6f01956e59c.camel@linux.ibm.com>
 <Yjoj6VZzLtOydw0f@pevik>
 <8c8dc78ab91d41c5755b5e1ae13a3054816d8072.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c8dc78ab91d41c5755b5e1ae13a3054816d8072.camel@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> Hi Petr,

> > > Removing "centos:latest" works, but is there another option?  Perhaps
> > > defining a different repo - "REPO=quay.io/centos/"?
> > This fix would be for Travis, which I'm not able to fix, but not for GitHub
> > Actions :(. I'm not aware how to specify alternative repository for it.

> FYI, "centos:stream9" results in crypto deprecated warnings and results
> in /dev/null errors.  Instead of removing the "centos:latest" entry in
> travis, I'll replace it with "centos:stream8" for now.

> The "centos:stream9" -devel rpm packages are in the CRB repo.  I
> manually set the CRB repo to enabled using sed.  Is there a better way
> of enabling CRB?

> Do you prefer to limit this patch to just removing the "centos:latest"
> entry in ci.yml and reposting it, or should I trim it?
I'll check if centos:stream8 works on GitHub Actions.

Kind regards,
Petr

> thanks,

> Mimi

