Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8A9CADD5C
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Sep 2019 18:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbfIIQgr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Sep 2019 12:36:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:5883 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728338AbfIIQgr (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Sep 2019 12:36:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Sep 2019 09:36:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,486,1559545200"; 
   d="scan'208";a="189075415"
Received: from pstarove-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.38.118])
  by orsmga006.jf.intel.com with ESMTP; 09 Sep 2019 09:36:44 -0700
Date:   Mon, 9 Sep 2019 17:36:43 +0100
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        jejb@linux.ibm.com, dhowells@redhat.com
Subject: Re: KEYS-TRUSTED git
Message-ID: <20190909163643.qxmzpcggi567hmhv@linux.intel.com>
References: <c253ca7292b397f1352d2ee00fce0b011f84abff.camel@linux.intel.com>
 <1567952431.4614.140.camel@linux.ibm.com>
 <CAFA6WYPq8Tq6=jTqnWQf9w9pzdJu8AcX-CFBWPwoVmMaLEJKhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYPq8Tq6=jTqnWQf9w9pzdJu8AcX-CFBWPwoVmMaLEJKhg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 09, 2019 at 11:57:45AM +0530, Sumit Garg wrote:
> For Trusted Execution Environment (TEE) as a new "trust" method, I
> have tried to document it here [1]. Please share your thoughts on this
> patch [1] in case I missed something. I would be happy to incorporate
> your feedback. Also, can you elaborate on "comparison to the TPM",
> what specifics parameters are you looking for documentation?

I think the right order is actually:

1. Set up the GIT tree.
2. Merge your TEE patches (when they pass the review phase).
3. Come up with the documentation.

/Jarkko
