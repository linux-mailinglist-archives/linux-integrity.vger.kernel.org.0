Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2F9A8010C
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Aug 2019 21:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405982AbfHBTgF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Aug 2019 15:36:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:31126 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403792AbfHBTgF (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Aug 2019 15:36:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2019 12:36:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,339,1559545200"; 
   d="scan'208";a="201763794"
Received: from psathya-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.36.242])
  by fmsmga002.fm.intel.com with ESMTP; 02 Aug 2019 12:36:01 -0700
Date:   Fri, 2 Aug 2019 22:36:00 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E . O . Meneguele" <bmeneg@redhat.com>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: Exposing the tpm 2.0 PCRs? (renamed subject)
Message-ID: <20190802193600.prsjeyuagojnxk72@linux.intel.com>
References: <1563830080-31069-1-git-send-email-zohar@linux.ibm.com>
 <20190723071545.GA26973@x230>
 <1563894876.14396.120.camel@linux.ibm.com>
 <20190724072420.GA21901@dell5510>
 <1563976601.4245.32.camel@linux.ibm.com>
 <20190801173454.4zjrndyxkn2mokzo@linux.intel.com>
 <CACdnJuuL=fHp8uiaUf+Z8Pgaj7pm5J5LmKaFsVpU=_rgj_UDGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACdnJuuL=fHp8uiaUf+Z8Pgaj7pm5J5LmKaFsVpU=_rgj_UDGA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Aug 01, 2019 at 12:58:44PM -0700, Matthew Garrett wrote:
> On Thu, Aug 1, 2019 at 10:35 AM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> > What is meant by TPM 2.0 PCRs support?
> 
> You can read TPM 1.2 PCR values directly through sysfs. There's no
> equivalent mechanism for obtaining the TPM 2 PCR banks - you have to
> talk to the TPM yourself.

OK, when I did the TPM 2.0 support originally the conclusion was then
that since you can easily get what you need through /dev/tpm0, we don't
need such sysfs file.

That does mean that it cannot be added if there are legit reasons to
do so...

/Jarkko
