Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6B716EBEF
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Feb 2020 18:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbgBYRAT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Feb 2020 12:00:19 -0500
Received: from mga03.intel.com ([134.134.136.65]:52293 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728051AbgBYRAT (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Feb 2020 12:00:19 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 09:00:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,484,1574150400"; 
   d="scan'208";a="438126248"
Received: from gbwalsh-mobl6.ger.corp.intel.com (HELO localhost) ([10.252.26.72])
  by fmsmga006.fm.intel.com with ESMTP; 25 Feb 2020 09:00:16 -0800
Date:   Tue, 25 Feb 2020 19:00:15 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, aik@ozlabs.ru,
        david@gibson.dropbear.id.au, linux-kernel@vger.kernel.org,
        nayna@linux.vnet.ibm.com, gcwilson@linux.ibm.com, jgg@ziepe.ca,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v2 3/4] tpm: Implement tpm2_init to call when
 TPM_OPS_AUTO_STARTUP is not set
Message-ID: <20200225170015.GE15662@linux.intel.com>
References: <20200213202329.898607-1-stefanb@linux.vnet.ibm.com>
 <20200213202329.898607-4-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213202329.898607-4-stefanb@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Feb 13, 2020 at 03:23:28PM -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Implement tpm2_init() that gets the TPM 2 timeouts and command durations
> and command code attributes. This function is to be called in case the
> TPM_OPS_AUTO_STARTUP flag is not set and therefore tpm2_auto_startup()
> is not called.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

The commit makes zero effort trying to explain what the heck tpm_init()
is and when it should be used and why the function name tpm2_init().

/Jarkko
