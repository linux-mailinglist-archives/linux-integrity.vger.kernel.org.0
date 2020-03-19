Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF7D18C021
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Mar 2020 20:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgCSTMQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Mar 2020 15:12:16 -0400
Received: from mga11.intel.com ([192.55.52.93]:41367 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgCSTMQ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Mar 2020 15:12:16 -0400
IronPort-SDR: 31OAq9M4oafQovx7IKaxxoC4y+6+dyHIeM+bQMf9Xdz2MRF7Zm2iD2O1AdLEQtSld3Gmg3oz6t
 Y6xnxLAenSVA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 12:12:15 -0700
IronPort-SDR: c9S+K+uFzLYKF+qGkvWx0r9T16FI1VLY79SrInUDH+R3/bKivLNcKPfb+XmyFg/GeIngRZDAB6
 2KZMZQL3509w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,572,1574150400"; 
   d="scan'208";a="291712096"
Received: from oamor-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.182.181])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Mar 2020 12:12:12 -0700
Date:   Thu, 19 Mar 2020 21:12:11 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     George Wilson <gcwilson@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, Linh Pham <phaml@us.ibm.com>
Subject: Re: [PATCH v2] tpm: ibmvtpm: retry on H_CLOSED in tpm_ibmvtpm_send()
Message-ID: <20200319191211.GA23430@linux.intel.com>
References: <20200317214600.9561-1-gcwilson@linux.ibm.com>
 <20200318204318.GA48352@linux.intel.com>
 <20200318223542.GD20941@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318223542.GD20941@ziepe.ca>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Mar 18, 2020 at 07:35:42PM -0300, Jason Gunthorpe wrote:
> On Wed, Mar 18, 2020 at 10:43:18PM +0200, Jarkko Sakkinen wrote:
> > >  static const char tpm_ibmvtpm_driver_name[] = "tpm_ibmvtpm";
> > >  
> > >  static const struct vio_device_id tpm_ibmvtpm_device_table[] = {
> > > @@ -147,6 +149,7 @@ static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
> > >  {
> > >  	struct ibmvtpm_dev *ibmvtpm = dev_get_drvdata(&chip->dev);
> > >  	int rc, sig;
> > > +	bool retry = true;
> > 
> > Cosmetic: would be nice to have inits when possible in reverse
> > Christmas tree order i.e.
> > 
> > 	struct ibmvtpm_dev *ibmvtpm = dev_get_drvdata(&chip->dev);
> > 	bool retry = true;
> > 	int rc, sig;
> > 
> > It is way more pleasing for the eye when you have to read the source
> > code.
> 
> I thought only netdev insisted on that :O

x86 seems to prefer too and I agree with the idea. But as I said only
that it would be nice.

/Jarkko
