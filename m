Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEF327A49F
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Sep 2020 01:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgI0Xsv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 27 Sep 2020 19:48:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:48303 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbgI0Xsv (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 27 Sep 2020 19:48:51 -0400
IronPort-SDR: TgzUOOYXGmEjhyWJiyr0LDbZ6Omov1B5VTexBKHxvnsdwZXRWVgEJRGlslDvcJ7Q2PuBlsocuJ
 SYxYBUcHiViQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="162804814"
X-IronPort-AV: E=Sophos;i="5.77,311,1596524400"; 
   d="scan'208";a="162804814"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 16:48:50 -0700
IronPort-SDR: PE2GwxsBDdv7EB9yNJizh1uU5BdSnF4bdJQJNP1BzQXemGQTqpyJ4Xv0jbBrY5tn63pt1p9VHD
 lGmmDTuM0mIw==
X-IronPort-AV: E=Sophos;i="5.77,311,1596524400"; 
   d="scan'208";a="488338133"
Received: from memara-mobl.ger.corp.intel.com (HELO localhost) ([10.252.49.157])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 16:48:49 -0700
Date:   Mon, 28 Sep 2020 02:48:50 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v13 3/5] security: keys: trusted: fix TPM2 authorizations
Message-ID: <20200927234850.GB5283@linux.intel.com>
References: <20200922022809.7105-1-James.Bottomley@HansenPartnership.com>
 <20200922022809.7105-4-James.Bottomley@HansenPartnership.com>
 <20200925072829.GA170658@linux.intel.com>
 <49f167946299ced25cf6ad0db1a53f8b319c3491.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49f167946299ced25cf6ad0db1a53f8b319c3491.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Sep 25, 2020 at 10:39:23AM -0700, James Bottomley wrote:
> On Fri, 2020-09-25 at 10:28 +0300, Jarkko Sakkinen wrote:
> > On Mon, Sep 21, 2020 at 07:28:07PM -0700, James Bottomley wrote:
> [...]
> > > keyctl add trusted kmk "new 32
> > > blobauth=f572d396fae9206628714fb2ce00f72e94f2258fkeyhandle=81000001
> > > " @u
> > > 
> > > after we will accept both the old hex sha1 form as well as a new
> > > directly supplied password:
> > > 
> > > keyctl add trusted kmk "new 32 blobauth=hello keyhandle=81000001"
> > > @u
> > 
> > I'm still getting -EINVAL from both with a Geminilake NUC.
> 
> Since I don't have one of those you're going to have to give me more to
> go on.  I've tested this works in a VM with the ibmtss and on a Rainbow
> Pass with a variety of physical TPMs.  Keyctl returns -EINVAL for an
> annoying number of conditions it shouldn't ... the most frequent of
> which is that the key already exists in the keyring.
> 
> So what's different about the Geminilake NUC?  Either it's a kernel
> problem with the TPM, in which case there should be something in dmesg
> or it's a userspace problem with keyctl, in which case perhaps strace
> might get us further forward.
> 
> James

I'll debug it further sometime next week, just acknowledged the issue.
I'll use bpftrace for the purpose.

In your environment, would be interesting to see what happens if you use
tpm2-root-key to generate the key instead of IBMTSS. It is now available
here:

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/tpm2-scripts.git/

/Jarkko
