Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAAAD2617C0
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Sep 2020 19:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgIHRl4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Sep 2020 13:41:56 -0400
Received: from mga04.intel.com ([192.55.52.120]:46989 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732070AbgIHRln (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Sep 2020 13:41:43 -0400
IronPort-SDR: TMDaWLdIJfDndnJjF6ejnFWofzaOVqgHmPvYEivS60TQHdumDdA8vAnlUXRHFUyqu8nkEzdghe
 QUcxBrfiMbQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="155591313"
X-IronPort-AV: E=Sophos;i="5.76,406,1592895600"; 
   d="scan'208";a="155591313"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 10:39:41 -0700
IronPort-SDR: EPoAWk7n2D/Sy376R8SBF5lfK6BJ9z/XTBCSLckOXNaffSGsJzo58qtIwvZk8t6Xqdwgbaynhr
 W5WcIyxsJ30w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,406,1592895600"; 
   d="scan'208";a="328570650"
Received: from jfontesg-mobl.ger.corp.intel.com (HELO localhost) ([10.252.39.71])
  by fmsmga004.fm.intel.com with ESMTP; 08 Sep 2020 10:39:40 -0700
Date:   Tue, 8 Sep 2020 20:39:39 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Greg KH <greg@kroah.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        linux-api@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH RESEND v4 1/1] tpm: add sysfs exports for all banks of
 PCR registers
Message-ID: <20200908173939.GA5390@linux.intel.com>
References: <20200906203245.18429-1-James.Bottomley@HansenPartnership.com>
 <20200906203245.18429-2-James.Bottomley@HansenPartnership.com>
 <20200907132121.GA106839@linux.intel.com>
 <20200907173742.GA1023764@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907173742.GA1023764@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 07, 2020 at 07:37:42PM +0200, Greg KH wrote:
> On Mon, Sep 07, 2020 at 04:21:21PM +0300, Jarkko Sakkinen wrote:
> > On Sun, Sep 06, 2020 at 01:32:45PM -0700, James Bottomley wrote:
> > > Create sysfs per hash groups with 24 PCR files in them one group,
> > > named pcr-<hash>, for each agile hash of the TPM.  The files are
> > > plugged in to a PCR read function which is TPM version agnostic, so
> > > this works also for TPM 1.2 but the hash is only sha1 in that case.
> > > 
> > > Note: the macros used to create the hashes emit spurious checkpatch
> > > warnings.  Do not try to "fix" them as checkpatch recommends, otherwise
> > > they'll break.
> > > 
> > > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> > > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > Tested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> > 
> > I'm not sure why this should be in sysfs when event log is in
> > securityfs.
> > 
> > Also, securityfs does not have to follow sysfs requirements,
> > which gives ability to dump all PCRs in a single binary file.
> 
> You can dump all registers in a single binary file in sysfs as well :)

Thanks for confirming this.

I think sysfs makes more sense. In a production system you have a single
TPM, and that's why there is a single global event log coming from the
BIOS. That's why securityfs makes sense for the event log.

However, PCRs themselves are device local, Linux supports multiple TPM
devices, and sometimes for development and testing purposes you might
want to do this.

/Jarkko
