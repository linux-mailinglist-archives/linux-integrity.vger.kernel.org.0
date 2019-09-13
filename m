Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFB5B2113
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Sep 2019 15:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390669AbfIMNcf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Sep 2019 09:32:35 -0400
Received: from mga03.intel.com ([134.134.136.65]:41513 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390444AbfIMNce (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Sep 2019 09:32:34 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2019 06:32:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="176281584"
Received: from unknown (HELO localhost) ([10.249.39.126])
  by orsmga007.jf.intel.com with ESMTP; 13 Sep 2019 06:32:30 -0700
Date:   Fri, 13 Sep 2019 14:32:28 +0100
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     dhowells@redhat.com, linux-integrity@vger.kernel.org,
        jejb@linux.ibm.com, sumit.garg@linaro.org
Subject: Re: KEYS-TRUSTED git
Message-ID: <20190913133228.GE7412@linux.intel.com>
References: <c253ca7292b397f1352d2ee00fce0b011f84abff.camel@linux.intel.com>
 <1567952431.4614.140.camel@linux.ibm.com>
 <20190909165200.npxq3hkft4bddv6v@linux.intel.com>
 <1568049898.4614.349.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1568049898.4614.349.camel@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 09, 2019 at 01:24:58PM -0400, Mimi Zohar wrote:
> On Mon, 2019-09-09 at 17:52 +0100, Jarkko Sakkinen wrote:
> > On Sun, Sep 08, 2019 at 10:20:31AM -0400, Mimi Zohar wrote:
> > > Thanks, Jarkko.  Agreed, trusted keys is becoming more than just TPM
> > > based keys.  Now would be a good time to set up at least a separate
> > > branch or GIT repo.
> > 
> > I created a tree for trusted keys:
> > 
> > http://git.infradead.org/users/jjs/linux-trusted-keys.git
> > 
> > The remaining issue before I send a patch to update MAINTAINERS is whether
> > the flow goes through David to Linus or directly to Linus.
> 
> David?

I think using tpmdd tree makes sense because there is so much
correlation.

/Jarkko
