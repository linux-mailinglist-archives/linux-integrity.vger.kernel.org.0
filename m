Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2CE1FEC5A
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2020 09:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgFRHUK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jun 2020 03:20:10 -0400
Received: from mga06.intel.com ([134.134.136.31]:36224 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbgFRHUG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jun 2020 03:20:06 -0400
IronPort-SDR: ZjK2exdIS5jvympC7Du2/vo3K1pXAoZNO/zvVM0rNIGvh8rv+cUC17tpkeS6e6IYOnv6EneSZo
 sBry6k98meiQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9655"; a="203963885"
X-IronPort-AV: E=Sophos;i="5.73,525,1583222400"; 
   d="scan'208";a="203963885"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 00:20:06 -0700
IronPort-SDR: GOOndaOg0rTI1y/zoM9ik2FFZWaBYobsTN/aX7QIWNaExAcCBhA4jz5ODZs1oAtPHDTimnz/pR
 ct72S+OAfvFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,525,1583222400"; 
   d="scan'208";a="263517625"
Received: from jkalinox-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.49.234])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jun 2020 00:19:56 -0700
Date:   Thu, 18 Jun 2020 10:19:55 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Markus Wamser <Markus.Wamser@mixed-mode.de>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Luke Hinds <lhinds@redhat.com>
Subject: Re: [PATCH v5 1/4] KEYS: trusted: Add generic trusted keys framework
Message-ID: <20200618071955.GE6560@linux.intel.com>
References: <1591107505-6030-1-git-send-email-sumit.garg@linaro.org>
 <1591107505-6030-2-git-send-email-sumit.garg@linaro.org>
 <20200615182457.GB5416@linux.intel.com>
 <CAFA6WYNEnXm5FOGHGAg4XB-+GXD=C+YMh+6t976=pStU0WshAA@mail.gmail.com>
 <20200617231429.GD62794@linux.intel.com>
 <CAFA6WYOdtwnewqY0ASnMf7fyw3s_hQx0+oWJRhT3CpkkkxYpDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYOdtwnewqY0ASnMf7fyw3s_hQx0+oWJRhT3CpkkkxYpDA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 18, 2020 at 12:12:41PM +0530, Sumit Garg wrote:
> On Thu, 18 Jun 2020 at 04:44, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Tue, Jun 16, 2020 at 07:02:37PM +0530, Sumit Garg wrote:
> > > + Luke
> > >
> > > Hi Jarkko,
> > >
> > > Prior to addressing your comments below which seems to show your
> > > preference for compile time selection of trust source (TPM or TEE), I
> > > would just like to hear the reasons for this preference especially if
> > > it makes distro vendor's life difficult [1] to make opinionated
> > > selection which could rather be achieved dynamically based on platform
> > > capability.
> > >
> > > [1] https://lkml.org/lkml/2020/6/3/405
> > >
> > > -Sumit
> >
> > Hmm... I do get the distribution kernel point. OK, lets revert to
> > dynamic then. Thanks for the remark.
> >
> > /Jarkko
> 
> Thanks, will revert to dynamic mode in v6.

Sorry about the extra trouble caused by me.

/Jarkko
