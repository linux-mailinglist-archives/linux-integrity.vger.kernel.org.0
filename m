Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C8326DF9C
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Sep 2020 17:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgIQP1y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Sep 2020 11:27:54 -0400
Received: from mga07.intel.com ([134.134.136.100]:32955 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728201AbgIQP1m (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Sep 2020 11:27:42 -0400
X-Greylist: delayed 506 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 11:26:49 EDT
IronPort-SDR: bS6AM3QQG/tKhf/cnA2uk1s3ldrecy1uRqjFReP86ftpG/zd1NC8xrZPMjDNRcAIxNZcoHirPj
 6m3HrS0doFWA==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="223896781"
X-IronPort-AV: E=Sophos;i="5.77,271,1596524400"; 
   d="scan'208";a="223896781"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 08:17:57 -0700
IronPort-SDR: M1lrFAmeVaVSXBuRBfeaTNLOIoXhClx6IDPnptq7howuNaMFn35LK2aO2R+aSHFxInOkwzNc9+
 OFALRNBfQhXQ==
X-IronPort-AV: E=Sophos;i="5.77,271,1596524400"; 
   d="scan'208";a="483785650"
Received: from sdompke-mobl.ger.corp.intel.com (HELO localhost) ([10.249.45.123])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 08:17:54 -0700
Date:   Thu, 17 Sep 2020 18:17:52 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        kernel test robot <lkp@intel.com>,
        linux-integrity@vger.kernel.org, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v11 4/5] security: keys: trusted: use ASN.1 TPM2 key
 format for the blobs
Message-ID: <20200917151752.GA7389@linux.intel.com>
References: <20200912172643.9063-5-James.Bottomley@HansenPartnership.com>
 <202009131413.8dt8QEc8%lkp@intel.com>
 <1600016571.7833.9.camel@HansenPartnership.com>
 <20200915091140.GC3612@linux.intel.com>
 <CAKwvOdnDJKPJ__sVKX2HmLUWyNPo=b0ccLvyBLyWoFfC0EFkiA@mail.gmail.com>
 <20200916162707.GF21026@linux.intel.com>
 <CAKwvOdnM66H2CNwsscgvALsb=gdiV9UDLQuqrKzdbmCr5S1McA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnM66H2CNwsscgvALsb=gdiV9UDLQuqrKzdbmCr5S1McA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Sep 16, 2020 at 11:04:33AM -0700, Nick Desaulniers wrote:
> On Wed, Sep 16, 2020 at 9:27 AM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > The compiler that you use in your example is unfortunately not
> > preincluded to my Ubuntu installation...
> 
> $ sudo apt install gcc-arm-linux-gnueabihf binutils-arm-linux-gnueabihf
> -- 
> Thanks,
> ~Nick Desaulniers

Thanks, installed for the future. A bit more convenient than compile
your own chain :-)

/Jarkko
