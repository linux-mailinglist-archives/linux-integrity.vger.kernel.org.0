Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3255FB2128
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Sep 2019 15:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388618AbfIMNex (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Sep 2019 09:34:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:37316 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388524AbfIMNex (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Sep 2019 09:34:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2019 06:34:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="179675437"
Received: from unknown (HELO localhost) ([10.249.39.126])
  by orsmga008.jf.intel.com with ESMTP; 13 Sep 2019 06:34:48 -0700
Date:   Fri, 13 Sep 2019 14:34:46 +0100
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        jejb@linux.ibm.com, dhowells@redhat.com
Subject: Re: KEYS-TRUSTED git
Message-ID: <20190913133446.GF7412@linux.intel.com>
References: <c253ca7292b397f1352d2ee00fce0b011f84abff.camel@linux.intel.com>
 <1567952431.4614.140.camel@linux.ibm.com>
 <CAFA6WYPq8Tq6=jTqnWQf9w9pzdJu8AcX-CFBWPwoVmMaLEJKhg@mail.gmail.com>
 <20190909163643.qxmzpcggi567hmhv@linux.intel.com>
 <CAFA6WYP6enHJBSsgzvTqzFEQwaW3ye2NrdnaxDMRCS1BC8mpsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYP6enHJBSsgzvTqzFEQwaW3ye2NrdnaxDMRCS1BC8mpsw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 10, 2019 at 10:43:27AM +0530, Sumit Garg wrote:
> On Mon, 9 Sep 2019 at 22:06, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Mon, Sep 09, 2019 at 11:57:45AM +0530, Sumit Garg wrote:
> > > For Trusted Execution Environment (TEE) as a new "trust" method, I
> > > have tried to document it here [1]. Please share your thoughts on this
> > > patch [1] in case I missed something. I would be happy to incorporate
> > > your feedback. Also, can you elaborate on "comparison to the TPM",
> > > what specifics parameters are you looking for documentation?
> >
> > I think the right order is actually:
> >
> > 1. Set up the GIT tree.
> > 2. Merge your TEE patches (when they pass the review phase).
> > 3. Come up with the documentation.
> 
> Sounds good to me.

Come to 2nd thoughts. As long as the master has your changes, James
should be fine and James' changes also work as a test bed for your
changes. Decided to postpone.

/Jarkko
