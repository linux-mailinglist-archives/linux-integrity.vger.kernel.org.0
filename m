Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D6D50A4DE
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Apr 2022 17:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiDUQBa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 21 Apr 2022 12:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355636AbiDUQB3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Apr 2022 12:01:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3D3473A2;
        Thu, 21 Apr 2022 08:58:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA61561CF6;
        Thu, 21 Apr 2022 15:58:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6E2C385A1;
        Thu, 21 Apr 2022 15:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650556716;
        bh=GBaeQIZyH2zKFDtCu8N9fQUuEoVr4FS7ju0xwsZnrzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UI3OrqenLjCz9NhxoUMlbmYnm5yVaPVFY+RqlynSESYzrKiP/Q+8hatcs/qDGBSQY
         a8HHQigTKd9CiD2fBfHYW0avTy8xdawamdz/qBTUThmqqSEziImsYNowyCmufbihtm
         9J40SdKy3MTybV9lF1o6MHurc0unFu0Ic4fMJADrWYMt4fQKxPN7kTPbwre7VjTyWK
         FBAvzjDa5Kk5fAMszDF8u6rbKmfFrOtICnO5K9Uq71WGsJddI7s6Y9cBILFgrNQPzm
         3qiOVLCNIXddrJ6o30+mXqf+4fNVRflUcxuM2vhzPBKJMDDNdFYXjYDBZdperfKhXl
         weCEyhONXLU1A==
Date:   Thu, 21 Apr 2022 18:57:21 +0300
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
Message-ID: <YmF+4ZZCZxH9OrS+@kernel.org>
References: <20210312171232.2681989-4-mic@digikod.net>
 <20210312171232.2681989-1-mic@digikod.net>
 <648218.1650450548@warthog.procyon.org.uk>
 <YmF0eAh7dYmtLDVx@kernel.org>
 <01ec2ce7-986d-451a-4a36-f627263ef826@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01ec2ce7-986d-451a-4a36-f627263ef826@digikod.net>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Apr 21, 2022 at 05:27:42PM +0200, Mickaël Salaün wrote:
> 
> On 21/04/2022 17:12, Jarkko Sakkinen wrote:
> > On Wed, Apr 20, 2022 at 11:29:08AM +0100, David Howells wrote:
> > > Mickaël Salaün <mic@digikod.net> wrote:
> > > 
> > > > +	/* The following algorithm only works if prefix lengths match. */
> > > > +	BUILD_BUG_ON(sizeof(tbs_prefix) != sizeof(bin_prefix));
> > > > +	prefix_len = sizeof(tbs_prefix) - 1;
> > > > +	for (i = 0; *desc; desc++, i++) {
> > > > +		if (*desc == ':') {
> > > > +			if (tbs_step == prefix_len)
> > > > +				goto found_colon;
> > > > +			if (bin_step == prefix_len)
> > > > +				goto found_colon;
> > > > +			return -EINVAL;
> > > > +		}
> > > > +		if (i >= prefix_len)
> > > > +			return -EINVAL;
> > > > +		if (*desc == tbs_prefix[i])
> > > > +			tbs_step++;
> > > > +		if (*desc == bin_prefix[i])
> > > > +			bin_step++;
> > > > +	}
> > > 
> > > I wonder if:
> > > 
> > > 	static const char tbs_prefix[] = "tbs:";
> > > 	static const char bin_prefix[] = "bin:";
> > > 
> > > 	if (strncmp(desc, tbs_prefix, sizeof(tbs_prefix) - 1) == 0 ||
> > > 	    strncmp(desc, bin_prefix, sizeof(bin_prefix) - 1) == 0)
> > > 		goto found_colon;
> > > 
> > > might be better.
> > > 
> > > David
> > 
> > I think it'd be.
> > 
> > BR, Jarkko
> 
> I'm confused. Didn't you plan to send this patch series before v5.18-rc2?
> It's been a while since I started working on this.

That was my original plan but due to some other things, I've sent
a PR for rc4. I CC'd you to the PR.

BR, Jarkko
