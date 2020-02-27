Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43A001722C2
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Feb 2020 17:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgB0QEI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Feb 2020 11:04:08 -0500
Received: from mga12.intel.com ([192.55.52.136]:60337 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729140AbgB0QEG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Feb 2020 11:04:06 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 08:04:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,492,1574150400"; 
   d="scan'208";a="385199345"
Received: from asliwa-mobl.ger.corp.intel.com (HELO localhost) ([10.252.26.84])
  by orsmga004.jf.intel.com with ESMTP; 27 Feb 2020 08:04:01 -0800
Date:   Thu, 27 Feb 2020 18:04:01 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, aik@ozlabs.ru,
        david@gibson.dropbear.id.au, linux-kernel@vger.kernel.org,
        nayna@linux.vnet.ibm.com, gcwilson@linux.ibm.com, jgg@ziepe.ca,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v3 4/4] tpm: ibmvtpm: Add support for TPM 2
Message-ID: <20200227160401.GC5140@linux.intel.com>
References: <20200227002654.7536-1-stefanb@linux.vnet.ibm.com>
 <20200227002654.7536-5-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227002654.7536-5-stefanb@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Feb 26, 2020 at 07:26:54PM -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Support TPM 2 in the IBM vTPM driver. The hypervisor tells us what
> version of TPM is connected through the vio_device_id.
> 
> In case a TPM 2 is found, we set the TPM_CHIP_FLAG_TPM2 flag.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

The commit message does not have anything on "vtpm20".

/Jarkko
