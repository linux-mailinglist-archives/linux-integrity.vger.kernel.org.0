Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3D948A59A
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jan 2022 03:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244176AbiAKCZk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Jan 2022 21:25:40 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52568 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244189AbiAKCZk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Jan 2022 21:25:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF53BB817D1;
        Tue, 11 Jan 2022 02:25:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178B9C36AE9;
        Tue, 11 Jan 2022 02:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641867937;
        bh=ESdhOG2HCjGdXGLR4pcZFcvJjNNSlwWBqgytqqaESNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IVW5niqu9Cvz6n0YnEKNeFgWU/d7O98S8yL3jaHVp881qtklszJtQaAD5TDLg9Voy
         CPihYbHFrzbUQTf2U7tlAhD/+ggddf5GVoeqsx5Fqnv7XFoqEBQVfihjAnE6s+d3Cb
         g6HpP0m/fCGDOKDwM4VQBzM2agorPCI28r6at7Hdo7+x9P2TZX5bkJChy2qgHhn/ME
         po4ZpdA+gHfZEqRsPwTt+UNPXBhpY1vas02NlLOWAyMxlixBMcMUwmJSe8IoVPuJLL
         om/s5LRnW0rN5yKCVZOSONXPAMGvkpdTGF9QjdjVnh6c437gbk7iglfDEcKTVV2siJ
         pIMCwZF1QyVOg==
Date:   Tue, 11 Jan 2022 04:25:27 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Nayna <nayna@linux.vnet.ibm.com>
Cc:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, dhowells@redhat.com, zohar@linux.ibm.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v7 1/3] certs: export load_certificate_list() to be used
 outside certs/
Message-ID: <YdzqlzjpDILjumRy@iki.fi>
References: <20220105175410.554444-1-nayna@linux.ibm.com>
 <20220105175410.554444-2-nayna@linux.ibm.com>
 <YdmXlUcsa+xRcwSN@iki.fi>
 <5b00bcbe-9881-b879-2474-33c52315a7a9@linux.vnet.ibm.com>
 <Ydzqgt08hohdnLA2@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ydzqgt08hohdnLA2@iki.fi>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 11, 2022 at 04:25:09AM +0200, Jarkko Sakkinen wrote:
> On Mon, Jan 10, 2022 at 11:12:41AM -0500, Nayna wrote:
> > 
> > On 1/8/22 08:54, Jarkko Sakkinen wrote:
> > > On Wed, Jan 05, 2022 at 12:54:08PM -0500, Nayna Jain wrote:
> > > > load_certificate_list() parses certificates embedded in the kernel
> > > > image to load them onto the keyring.
> > > > 
> > > > Commit "2565ca7f5ec1 (certs: Move load_system_certificate_list to a common
> > > > function)" made load_certificate_list() a common function in the certs/
> > > > directory. Now, export load_certificate_list() outside certs/ to be used
> > > > by load_platform_certificate_list() which is added later in the patchset.
> > > > 
> > > > Reported-by: kernel test robot <lkp@intel.com> (auto build test ERROR)
> > > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > > Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> > > This lacking fixes tag, if it is a bug, or "reported-by" needs to be
> > > completely removed.
> > 
> > When I posted my first version for this patch set, kernel test robot
> > reported the build error -
> > https://lore.kernel.org/linux-integrity/202109110507.ucpEmrwz-lkp@intel.com/
> > 
> > The Reported-by tag is because of this statement in the reported error - "
> > If you fix the issue, kindly add following tag as appropriate Reported-by:
> > kernel test robot <lkp@intel.com>"
> > 
> > Do you still think that the tag is not required ? If so, I am fine to remove
> > it.
> 
> It makes absolutely no sense for anything that is not triggered by the
> mainline code.

I.e. if it is not merged, there is no bug.

/Jarkko
