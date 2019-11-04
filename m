Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29B89EEA85
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2019 21:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbfKDUzV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 Nov 2019 15:55:21 -0500
Received: from mga12.intel.com ([192.55.52.136]:64773 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728332AbfKDUzV (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Nov 2019 15:55:21 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 12:55:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,268,1569308400"; 
   d="scan'208";a="195581057"
Received: from rczubala-mobl.ger.corp.intel.com (HELO localhost) ([10.252.7.245])
  by orsmga008.jf.intel.com with ESMTP; 04 Nov 2019 12:55:08 -0800
Date:   Mon, 4 Nov 2019 22:55:06 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>, dhowells@redhat.com,
        Jonathan Corbet <corbet@lwn.net>, jejb@linux.ibm.com,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Stuart Yoder <stuart.yoder@arm.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Subject: Re: [Patch v3 6/7] doc: keys: Document usage of TEE based Trusted
 Keys
Message-ID: <20191104205453.GA29713@linux.intel.com>
References: <1572530323-14802-1-git-send-email-sumit.garg@linaro.org>
 <1572530323-14802-7-git-send-email-sumit.garg@linaro.org>
 <20191031214745.GG10507@linux.intel.com>
 <CAFA6WYMkE928v-v76gGtWmsS0PwRp-OHUtkS0+Ts4V6x0AKBqQ@mail.gmail.com>
 <20191101201957.GA8369@linux.intel.com>
 <CAFA6WYNwSSaZv5OM=q+LCyn0mEdpg7K+W_v2_NBHhtktg1BFXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYNwSSaZv5OM=q+LCyn0mEdpg7K+W_v2_NBHhtktg1BFXw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Nov 04, 2019 at 12:28:47PM +0530, Sumit Garg wrote:
> On Sat, 2 Nov 2019 at 01:50, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Fri, Nov 01, 2019 at 03:04:18PM +0530, Sumit Garg wrote:
> >
> > > Isn't this statement contradicting with your earlier statement
> > > regarding the right order would be to complete TEE patches review
> > > first and then come up with documentation here [2]?
> > >
> > > [1] https://lore.kernel.org/linux-integrity/1568025601.4614.253.camel@linux.ibm.com/
> > > [2] https://lore.kernel.org/linux-integrity/20190909163643.qxmzpcggi567hmhv@linux.intel.com/
> >
> > With the intersecting issues, namely key generation and conflicting
> > keyctl parameters, that was not a well considered statement.
> 
> Okay, let me work on documentation first, but I think resending whole
> patch-set just for documentation review and rework would be an
> overkill. Would minor revisions of this patch only like v3.1, v3.2
> etc. work for you? And later I could send next version of this
> patch-set once we agree on documentation.

Yeah, we could iterate through the documentation patch and once
we are happy with it you can bundle it to your main patch set.

/Jarkko
