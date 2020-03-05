Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 736D617A417
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Mar 2020 12:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgCELVG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 Mar 2020 06:21:06 -0500
Received: from mga03.intel.com ([134.134.136.65]:13005 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbgCELVG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Mar 2020 06:21:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 03:21:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,517,1574150400"; 
   d="scan'208";a="234385081"
Received: from unknown (HELO jsakkine-mobl1) ([10.237.50.161])
  by orsmga008.jf.intel.com with ESMTP; 05 Mar 2020 03:21:02 -0800
Message-ID: <cb90bbef11d054c95e4f4633a350674f3c4fe0c5.camel@linux.intel.com>
Subject: Re: [PATCH v6 2/3] tpm: ibmvtpm: Wait for buffer to be set before
 proceeding
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     aik@ozlabs.ru, david@gibson.dropbear.id.au,
        linux-kernel@vger.kernel.org, nayna@linux.vnet.ibm.com,
        gcwilson@linux.ibm.com, jgg@ziepe.ca,
        Stefan Berger <stefanb@linux.ibm.com>
Date:   Thu, 05 Mar 2020 13:21:03 +0200
In-Reply-To: <20200304132243.179402-3-stefanb@linux.vnet.ibm.com>
References: <20200304132243.179402-1-stefanb@linux.vnet.ibm.com>
         <20200304132243.179402-3-stefanb@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.35.92-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-03-04 at 08:22 -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Synchronize with the results from the CRQs before continuing with
> the initialization. This avoids trying to send TPM commands while
> the rtce buffer has not been allocated, yet.
> 
> This patch fixes an existing race condition that may occurr if the
> hypervisor does not quickly respond to the VTPM_GET_RTCE_BUFFER_SIZE
> request sent during initialization and therefore the ibmvtpm->rtce_buf
> has not been allocated at the time the first TPM command is sent.
> 
> Fixes: 132f76294744 ("Add new device driver to support IBM vTPM")
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko

