Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5155FADD52
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Sep 2019 18:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfIIQdt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Sep 2019 12:33:49 -0400
Received: from mga03.intel.com ([134.134.136.65]:11439 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfIIQdt (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Sep 2019 12:33:49 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Sep 2019 09:33:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,486,1559545200"; 
   d="scan'208";a="189074625"
Received: from pstarove-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.38.118])
  by orsmga006.jf.intel.com with ESMTP; 09 Sep 2019 09:33:46 -0700
Date:   Mon, 9 Sep 2019 17:33:45 +0100
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        dhowells@redhat.com, sumit.garg@linaro.org
Subject: Re: KEYS-TRUSTED git
Message-ID: <20190909163345.rmfnazpahzmnibe6@linux.intel.com>
References: <c253ca7292b397f1352d2ee00fce0b011f84abff.camel@linux.intel.com>
 <1567952431.4614.140.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1567952431.4614.140.camel@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Sep 08, 2019 at 10:20:31AM -0400, Mimi Zohar wrote:
> On Sun, 2019-09-08 at 03:10 +0300, Jarkko Sakkinen wrote:
> > It seems that at least vast majority of the trusted keys patches flow
> > through my tree to the mainline. Still, it is undocumented in the
> > MAINTAINERS file.
> > 
> > So, should I just add my TPM tree as the upstream there? Or should I
> > just create a new GIT for trusted keys? My TPM PR goes to Linux ATM.
> > Should my trusted keys PR go to David instead? That would definitely
> > require own tree.
> > 
> > With Sumit's recent work trusted keys is turning more than just being
> > TPM keys so now it is a good time to consider the flow... Sumit, I'm
> > sorry that I haven't added your first series yet. I need to first sync
> > up how we are going to move forward.
> 
> Thanks, Jarkko.  Agreed, trusted keys is becoming more than just TPM
> based keys.  Now would be a good time to set up at least a separate
> branch or GIT repo.
> 
> Are all "trust" methods equivalent?  As new "trust" methods are
> defined, there should be a document describing the trust method, with
> a comparison to the TPM.
> 
> (It would be nice to have some kernel selftests to ensure existing
> methods don't break.)

We could put this (with appropriate mods whatever they are) to
selftests:

https://raw.githubusercontent.com/jsakkine-intel/tpm2-scripts/master/keyctl-smoke.sh

No near adequate but it is starting point...

/Jarkko
