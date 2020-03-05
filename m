Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C40B117A41B
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Mar 2020 12:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgCELWA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 Mar 2020 06:22:00 -0500
Received: from mga02.intel.com ([134.134.136.20]:22736 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbgCELV7 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Mar 2020 06:21:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 03:21:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,517,1574150400"; 
   d="scan'208";a="234385272"
Received: from unknown (HELO jsakkine-mobl1) ([10.237.50.161])
  by orsmga008.jf.intel.com with ESMTP; 05 Mar 2020 03:21:56 -0800
Message-ID: <a54d6cffe536d568a9fde46f1f32616e89a42d30.camel@linux.intel.com>
Subject: Re: [PATCH v6 3/3] tpm: ibmvtpm: Add support for TPM2
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     aik@ozlabs.ru, david@gibson.dropbear.id.au,
        linux-kernel@vger.kernel.org, nayna@linux.vnet.ibm.com,
        gcwilson@linux.ibm.com, jgg@ziepe.ca,
        Stefan Berger <stefanb@linux.ibm.com>
Date:   Thu, 05 Mar 2020 13:21:56 +0200
In-Reply-To: <20200304132243.179402-4-stefanb@linux.vnet.ibm.com>
References: <20200304132243.179402-1-stefanb@linux.vnet.ibm.com>
         <20200304132243.179402-4-stefanb@linux.vnet.ibm.com>
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
> Support TPM2 in the IBM vTPM driver. The hypervisor tells us what
> version of TPM is connected through the vio_device_id.
> 
> In case a TPM2 device is found, we set the TPM_CHIP_FLAG_TPM2 flag
> and get the command codes attributes table. The driver does
> not need the timeouts and durations, though.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

There is huge bunch of people in the cc-list and these patches
have total zero tested-by's. Why is that?

/Jarkko

