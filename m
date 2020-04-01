Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB4219A75C
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Apr 2020 10:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgDAIey (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Apr 2020 04:34:54 -0400
Received: from mga05.intel.com ([192.55.52.43]:15300 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgDAIex (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Apr 2020 04:34:53 -0400
IronPort-SDR: dpwCN4ZnyE65b98ycXD9yIyuRuQUBS3+frPa4m30GDpWGJUwwUs+FUw6FtWPNow7ihhoCQX3Tp
 f/WuJnvSTBew==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 01:34:52 -0700
IronPort-SDR: RwT7UXzeOcUGqE6tXf86sqPLLmf4F50xYbBKutEuAFVkKcvphl88oRCC8HKIYBSLdBOPEsfiXI
 7wGE+x1ViW3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,331,1580803200"; 
   d="scan'208";a="395879471"
Received: from vikasjox-mobl.amr.corp.intel.com (HELO localhost) ([10.249.39.53])
  by orsmga004.jf.intel.com with ESMTP; 01 Apr 2020 01:34:40 -0700
Date:   Wed, 1 Apr 2020 11:34:38 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Benoit HOUYERE <benoit.houyere@st.com>
Cc:     "amirmizi6@gmail.com" <amirmizi6@gmail.com>,
        "Eyal.Cohen@nuvoton.com" <Eyal.Cohen@nuvoton.com>,
        "oshrialkoby85@gmail.com" <oshrialkoby85@gmail.com>,
        "alexander.steffen@infineon.com" <alexander.steffen@infineon.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "oshri.alkoby@nuvoton.com" <oshri.alkoby@nuvoton.com>,
        "tmaimon77@gmail.com" <tmaimon77@gmail.com>,
        "gcwilson@us.ibm.com" <gcwilson@us.ibm.com>,
        "kgoldman@us.ibm.com" <kgoldman@us.ibm.com>,
        "Dan.Morav@nuvoton.com" <Dan.Morav@nuvoton.com>,
        "oren.tanami@nuvoton.com" <oren.tanami@nuvoton.com>,
        "shmulik.hager@nuvoton.com" <shmulik.hager@nuvoton.com>,
        "amir.mizinski@nuvoton.com" <amir.mizinski@nuvoton.com>,
        Olivier COLLART <olivier.collart@st.com>,
        Yves MAGNAUD <yves.magnaud@st.com>
Subject: Re: [PATCH v4 4/7] tpm: tpm_tis: Fix expected bit handling and send
 all bytes in one shot without last byte in exception
Message-ID: <20200401083438.GC17325@linux.intel.com>
References: <20200331113207.107080-1-amirmizi6@gmail.com>
 <20200331113207.107080-5-amirmizi6@gmail.com>
 <20200331121720.GB9284@linux.intel.com>
 <19c8ae3023404ae9affcb1ce04b7ee4b@SFHDAG3NODE3.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19c8ae3023404ae9affcb1ce04b7ee4b@SFHDAG3NODE3.st.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 31, 2020 at 09:34:28PM +0000, Benoit HOUYERE wrote:
> 
> > On Tue, Mar 31, 2020 at 02:32:04PM +0300, amirmizi6@gmail.com wrote:
> > > From: Amir Mizinski <amirmizi6@gmail.com>
> > > 
> > > Today, actual implementation for send massage is not correct. We check 
> > > and loop only on TPM_STS.stsValid bit and next we single check 
> > > TPM_STS.expect bit value.
> > > TPM_STS.expected bit shall be checked in the same time of 
> > > TPM_STS.stsValid, and should be repeated until timeout_A.
> > > To aquire that, "wait_for_tpm_stat" function is modified to 
> > > "wait_for_tpm_stat_result". this function read regulary status 
> > > register and check bit defined by "mask" to reach value defined in "mask_result"
> > > (that way a bit in mask can be checked if reached 1 or 0).
> > > 
> > > Respectively, to send message as defined in 
> > >  TCG_DesignPrinciples_TPM2p0Driver_vp24_pubrev.pdf, all bytes should be 
> > > sent in one shot instead of sending last byte in exception.
> > > 
> > > This improvment was suggested by Benoit Houyere.
> 
> >Use suggested-by tag.
> 
> >Also if something is not correct, please provide a fixes tag.
> 
> > You are speaking now in theoretical level, which we don't really care that much. Is this causing you real issues? If the answer is yes, please report them. If the > >answer is no, we don't need this.
> 
> > /Jarkko
> 
> I2C TPM specification introduce CRC calculation on TPM command bytes.
> CRC calculation take place from last byte acquired to
> TPM_STS.expected bit reset (=0) .It introduces latency and actual
> incorrect implementation becomes visible now under I2C on the contrary
> before that's all.  The case where TPM keeps TPM_STS.expected bit set
> with TPM_STS.stsValid set after last byte reception is possible and is
> not an issue. It's not theoretical level, it's practical level now.

Thank you, think I got it. This means that it does not need a fixes tag
because it does not break any hardware that it currently supported.

I'd suggest refining the commit message. Not only it is somewhat loosely
writte peace of text but also has typos like "massage".

/Jarkko
