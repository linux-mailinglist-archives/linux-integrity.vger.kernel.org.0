Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 482201667C1
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2020 20:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgBTT7M (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 Feb 2020 14:59:12 -0500
Received: from mga06.intel.com ([134.134.136.31]:16233 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728556AbgBTT7M (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 Feb 2020 14:59:12 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 11:59:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,465,1574150400"; 
   d="scan'208";a="349230613"
Received: from moriol-mobl.ger.corp.intel.com (HELO localhost) ([10.252.25.78])
  by fmsmga001.fm.intel.com with ESMTP; 20 Feb 2020 11:59:08 -0800
Date:   Thu, 20 Feb 2020 21:59:06 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, aik@ozlabs.ru,
        david@gibson.dropbear.id.au, linux-kernel@vger.kernel.org,
        nayna@linux.vnet.ibm.com, gcwilson@linux.ibm.com, jgg@ziepe.ca
Subject: Re: [PATCH v2 0/4] Enable vTPM 2.0 for the IBM vTPM driver
Message-ID: <20200220195906.GB23349@linux.intel.com>
References: <20200213202329.898607-1-stefanb@linux.vnet.ibm.com>
 <f76ce5e5-0552-bc2c-4548-ae9552d4e3ba@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f76ce5e5-0552-bc2c-4548-ae9552d4e3ba@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Feb 19, 2020 at 02:23:29PM -0500, Stefan Berger wrote:
> On 2/13/20 3:23 PM, Stefan Berger wrote:
> > From: Stefan Berger <stefanb@linux.ibm.com>
> > 
> > QEMU 5.0 will support the PAPR vTPM device model for TPM 1.2 and TPM 2.0.
> > This series of patches enables vTPM 2.0 support for the IBM vTPM driver.
> 
> 
> If there are no more comments to this series, maybe Jarkko can queue it?

Do not recall seeing this series before. Probably have missed it.
I'll look into it next week.

/Jarkkko
