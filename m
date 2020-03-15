Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD7E18601C
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Mar 2020 22:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgCOVxH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 15 Mar 2020 17:53:07 -0400
Received: from mga03.intel.com ([134.134.136.65]:55823 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729166AbgCOVxH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 15 Mar 2020 17:53:07 -0400
IronPort-SDR: tLh/jKg4Prg8JnI9DFlXnUE7jWi6TRX8aal4/WuHas6GFpwaL+/u0MiZk1ZalLSroNo71Jcux/
 td3QI4Tj4uYw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2020 14:53:05 -0700
IronPort-SDR: zEI9SkqgvTDcRFtXGlvFYgiWjoxf4mlZf2hoyvpMuskHqMd737tBaZ2OP06xT4S1uxCvuaqrBq
 9ZiUosauTWQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,558,1574150400"; 
   d="scan'208";a="323318734"
Received: from babayass-mobl.ger.corp.intel.com (HELO localhost) ([10.249.90.210])
  by orsmga001.jf.intel.com with ESMTP; 15 Mar 2020 14:52:55 -0700
Date:   Sun, 15 Mar 2020 23:52:53 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Chris von Recklinghausen <crecklin@redhat.com>
Subject: Re: [PATCH v3 3/3] KEYS: Use kvmalloc() to better handle large
 buffer allocation
Message-ID: <20200315215253.GG224162@linux.intel.com>
References: <20200313152102.1707-1-longman@redhat.com>
 <20200313152102.1707-4-longman@redhat.com>
 <20200313164306.GA907@sol.localdomain>
 <8f2f1787-88b0-f86d-991c-34cfd2f9b4aa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f2f1787-88b0-f86d-991c-34cfd2f9b4aa@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Mar 13, 2020 at 01:49:57PM -0400, Waiman Long wrote:
> >>  			if (!tmpbuf || unlikely(ret > tmpbuflen)) {
> >>  				if (unlikely(tmpbuf))
> >> -					kzfree(tmpbuf);
> >> +					__kvzfree(tmpbuf, tmpbuflen);
> > Both kzfree() and __kvzfree() handle a NULL pointer, so there's no need for the
> > NULL check first.
> >
> I would like to keep this one because of the unlikely annotation.

What (measurable) gain does it bring anyway?

/Jarkko
