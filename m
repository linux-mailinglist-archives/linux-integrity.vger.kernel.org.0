Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9652150B356
	for <lists+linux-integrity@lfdr.de>; Fri, 22 Apr 2022 10:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445669AbiDVI6v (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 22 Apr 2022 04:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbiDVI6u (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Apr 2022 04:58:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB20B1FCE6;
        Fri, 22 Apr 2022 01:55:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 689D4B82A8A;
        Fri, 22 Apr 2022 08:55:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B098AC385A0;
        Fri, 22 Apr 2022 08:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650617755;
        bh=746PkcyfxHkBsvPqzkv4e0eW9xAIIox/PAAolGv1faI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F/C0B3YlHxH2gR71d4gqbj7dxt0CM244OakmddasKEq2Mv9fc65mhL5FIEsiKEsWI
         F79OOir9atJloZnWCN3lxmQZd15Ul+ovOcbuyW80U8HOk40Kw/Ui09Va+1c8ZfSwxX
         oKl8xIA5+D4aSVR8AFQEbQxhOedjfth6UopbD2wV9i+5oNfSUcdHRb1Rjh1WH2BE5C
         RGEdmRJmCq4kKD+PBDEyZEKgJEMERdE9YWiAJHIuThVDRdDTgFpEIn5r9KzvP07AgS
         riIbF8EJ9AzqCHbgFnYHeeXJHDzrVo8YxqZiK4aTEYhT5w33YatwPrKQN3aXyW8PD4
         MMVKDf0fHsvPA==
Date:   Fri, 22 Apr 2022 11:54:39 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v7 3/5] certs: Make blacklist_vet_description() more
 strict
Message-ID: <YmJtT/lOmxEwPMDD@kernel.org>
References: <20210312171232.2681989-4-mic@digikod.net>
 <20210312171232.2681989-1-mic@digikod.net>
 <648218.1650450548@warthog.procyon.org.uk>
 <YmF0eAh7dYmtLDVx@kernel.org>
 <01ec2ce7-986d-451a-4a36-f627263ef826@digikod.net>
 <YmF+4ZZCZxH9OrS+@kernel.org>
 <329a078d-29e3-e41e-3118-cd8f3e00b003@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <329a078d-29e3-e41e-3118-cd8f3e00b003@digikod.net>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Apr 21, 2022 at 07:29:10PM +0200, Mickaël Salaün wrote:
> 
> On 21/04/2022 17:57, Jarkko Sakkinen wrote:
> > On Thu, Apr 21, 2022 at 05:27:42PM +0200, Mickaël Salaün wrote:
> > > 
> > > On 21/04/2022 17:12, Jarkko Sakkinen wrote:
> > > > On Wed, Apr 20, 2022 at 11:29:08AM +0100, David Howells wrote:
> > > > > Mickaël Salaün <mic@digikod.net> wrote:
> > > > > 
> > > > > > +	/* The following algorithm only works if prefix lengths match. */
> > > > > > +	BUILD_BUG_ON(sizeof(tbs_prefix) != sizeof(bin_prefix));
> > > > > > +	prefix_len = sizeof(tbs_prefix) - 1;
> > > > > > +	for (i = 0; *desc; desc++, i++) {
> > > > > > +		if (*desc == ':') {
> > > > > > +			if (tbs_step == prefix_len)
> > > > > > +				goto found_colon;
> > > > > > +			if (bin_step == prefix_len)
> > > > > > +				goto found_colon;
> > > > > > +			return -EINVAL;
> > > > > > +		}
> > > > > > +		if (i >= prefix_len)
> > > > > > +			return -EINVAL;
> > > > > > +		if (*desc == tbs_prefix[i])
> > > > > > +			tbs_step++;
> > > > > > +		if (*desc == bin_prefix[i])
> > > > > > +			bin_step++;
> > > > > > +	}
> > > > > 
> > > > > I wonder if:
> > > > > 
> > > > > 	static const char tbs_prefix[] = "tbs:";
> > > > > 	static const char bin_prefix[] = "bin:";
> > > > > 
> > > > > 	if (strncmp(desc, tbs_prefix, sizeof(tbs_prefix) - 1) == 0 ||
> > > > > 	    strncmp(desc, bin_prefix, sizeof(bin_prefix) - 1) == 0)
> > > > > 		goto found_colon;
> > > > > 
> > > > > might be better.
> > > > > 
> > > > > David
> > > > 
> > > > I think it'd be.
> > > > 
> > > > BR, Jarkko
> > > 
> > > I'm confused. Didn't you plan to send this patch series before v5.18-rc2?
> > > It's been a while since I started working on this.
> > 
> > That was my original plan but due to some other things, I've sent
> > a PR for rc4. I CC'd you to the PR.
> 
> OK, I missed it. My micro-optimization isn't worth it, strncmp is much
> simple indeed.

Yeah, anyway, it's fine to submit this as a separate cleanup.

It's anyway working and tested code.

BR, Jarkko
