Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0501AE8D4
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Apr 2020 01:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgDQX4u (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Apr 2020 19:56:50 -0400
Received: from mga12.intel.com ([192.55.52.136]:60765 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbgDQX4V (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Apr 2020 19:56:21 -0400
IronPort-SDR: 9TWtQHfiLQMfgVFssZp9QxAyhD7yImG+Ob11/EqJ1bVITu7wWh/pKXJY0Pb9tIqILBpVklKKMb
 bLr0T/rwRbFA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 16:56:20 -0700
IronPort-SDR: vNzogAsnRVwFrSPcqZfg1Yme60KK5X01STa3ojGfmp/1x3RLoqqUM+FS6KlGNhkgUg0tvz5Oxb
 F+RjmSNIL5tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,395,1580803200"; 
   d="scan'208";a="272581075"
Received: from zhiwang1-mobl5.ger.corp.intel.com (HELO localhost) ([10.252.42.90])
  by orsmga002.jf.intel.com with ESMTP; 17 Apr 2020 16:56:16 -0700
Date:   Sat, 18 Apr 2020 02:56:16 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Janne Karhunen <janne.karhunen@gmail.com>, kgoldman@us.ibm.com,
        "Safford, David (GE Global Research, US)" <david.safford@ge.com>,
        monty.wiseman@ge.com, Daniel Thompson <daniel.thompson@linaro.org>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Subject: Re: [PATCH] doc: trusted-encrypted: updates with TEE as a new trust
 source
Message-ID: <20200417235616.GC85230@linux.intel.com>
References: <1585636165-22481-1-git-send-email-sumit.garg@linaro.org>
 <20200416174617.GI199110@linux.intel.com>
 <CAFA6WYNJuxGToM1R02RsrZ_xK6Rfi1SndY1oVYaAbizMpeGPbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYNJuxGToM1R02RsrZ_xK6Rfi1SndY1oVYaAbizMpeGPbg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Apr 17, 2020 at 10:27:01AM +0530, Sumit Garg wrote:
> On Thu, 16 Apr 2020 at 23:16, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Tue, Mar 31, 2020 at 11:59:25AM +0530, Sumit Garg wrote:
> > > Update documentation for Trusted and Encrypted Keys with TEE as a new
> > > trust source. Following is brief description of updates:
> > >
> > > - Add a section to demostrate a list of supported devices along with
> > >   their security properties/guarantees.
> > > - Add a key generation section.
> > > - Updates for usage section including differences specific to a trust
> > >   source.
> > >
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> >
> > Overally this works for me. Can you bundle this with the code
> > changes. Maybe some details needs to be fine tuned but easier
> > to look into them in the context of rest of the patches.
> >
> 
> Sure, I will send next version of complete patch-set.

Thanks.

I think I just have forgot to process this before. I'm sorry about
that.

/Jarkko
