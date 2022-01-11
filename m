Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A56448A596
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jan 2022 03:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346579AbiAKCZS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Jan 2022 21:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244176AbiAKCZS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Jan 2022 21:25:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF824C06173F;
        Mon, 10 Jan 2022 18:25:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AE87614AC;
        Tue, 11 Jan 2022 02:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628FDC36AE9;
        Tue, 11 Jan 2022 02:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641867916;
        bh=K49tkFdONj3yjZykDJVHdp4bWsRPoxl2lA77FbuuUHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vx7J5bUAHroXi0zxCZx8ya/YL8KyLIqfZ134GIAsz1NDoYOy5Op8i85P4BHftzN7H
         AF4AnpAZ2W/YTQ86xhb7dbisyP0MviXvpPZn17Qdf77WnslL7MphP/1C6sNY/K/9Me
         w+ukkcK3jCkmM6iDTVLUQGV0VdH7kn22L+mFfc3YkH8wxrTc0gC9PARUgiTvBkDAn1
         x65ynM0dTBSrKI0ypLoVI9WSF7gYVZHmYiq0ayRN4XNMc0E91x48ZD/w5uC2VsIzGw
         AZ/AK9xn9wDO8PeoCKGdkl12T9u2oyASJUCbgyp2BEeqsGVda+wKgIEs+Np8kUoNia
         AykPtmusbBj7Q==
Date:   Tue, 11 Jan 2022 04:25:06 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Nayna <nayna@linux.vnet.ibm.com>
Cc:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, dhowells@redhat.com, zohar@linux.ibm.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v7 1/3] certs: export load_certificate_list() to be used
 outside certs/
Message-ID: <Ydzqgt08hohdnLA2@iki.fi>
References: <20220105175410.554444-1-nayna@linux.ibm.com>
 <20220105175410.554444-2-nayna@linux.ibm.com>
 <YdmXlUcsa+xRcwSN@iki.fi>
 <5b00bcbe-9881-b879-2474-33c52315a7a9@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b00bcbe-9881-b879-2474-33c52315a7a9@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jan 10, 2022 at 11:12:41AM -0500, Nayna wrote:
> 
> On 1/8/22 08:54, Jarkko Sakkinen wrote:
> > On Wed, Jan 05, 2022 at 12:54:08PM -0500, Nayna Jain wrote:
> > > load_certificate_list() parses certificates embedded in the kernel
> > > image to load them onto the keyring.
> > > 
> > > Commit "2565ca7f5ec1 (certs: Move load_system_certificate_list to a common
> > > function)" made load_certificate_list() a common function in the certs/
> > > directory. Now, export load_certificate_list() outside certs/ to be used
> > > by load_platform_certificate_list() which is added later in the patchset.
> > > 
> > > Reported-by: kernel test robot <lkp@intel.com> (auto build test ERROR)
> > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> > This lacking fixes tag, if it is a bug, or "reported-by" needs to be
> > completely removed.
> 
> When I posted my first version for this patch set, kernel test robot
> reported the build error -
> https://lore.kernel.org/linux-integrity/202109110507.ucpEmrwz-lkp@intel.com/
> 
> The Reported-by tag is because of this statement in the reported error - "
> If you fix the issue, kindly add following tag as appropriate Reported-by:
> kernel test robot <lkp@intel.com>"
> 
> Do you still think that the tag is not required ? If so, I am fine to remove
> it.

It makes absolutely no sense for anything that is not triggered by the
mainline code.

/Jarkko
