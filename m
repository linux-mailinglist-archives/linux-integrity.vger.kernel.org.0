Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824E9277FFE
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Sep 2020 07:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgIYFnT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Sep 2020 01:43:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:63311 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbgIYFnS (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Sep 2020 01:43:18 -0400
IronPort-SDR: 596ihZ6WvUD0getK0hMzORkCv99ZI34ONHhOfgcUeRpcxtiWGLwEw9axZLY0znpzHYvJ3c8O4L
 kCx2tv1aQxvw==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="140863320"
X-IronPort-AV: E=Sophos;i="5.77,300,1596524400"; 
   d="scan'208";a="140863320"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 22:43:18 -0700
IronPort-SDR: fd4ITIhTxcQZZfnwoepJLdugVs8r1WtFhOoLToH1S5iY96G0wBOocQXZXY11Ztf63VOZq7kx8f
 zpi90Z27C95w==
X-IronPort-AV: E=Sophos;i="5.77,300,1596524400"; 
   d="scan'208";a="487319116"
Received: from erybin-mobl.ccr.corp.intel.com (HELO localhost) ([10.249.47.248])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 22:43:15 -0700
Date:   Fri, 25 Sep 2020 08:43:13 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Ross Philipson <ross.philipson@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH 05/13] x86: Add early TPM1.2/TPM2.0 interface support for
 Secure Launch
Message-ID: <20200925054313.GB165011@linux.intel.com>
References: <1600959521-24158-1-git-send-email-ross.philipson@oracle.com>
 <1600959521-24158-6-git-send-email-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600959521-24158-6-git-send-email-ross.philipson@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Sep 24, 2020 at 10:58:33AM -0400, Ross Philipson wrote:
> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
> 
> This commit introduces an abstraction for TPM1.2 and TPM2.0 devices
> above the TPM hardware interface.
> 
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>

This is way, way too PoC. I wonder why there is no RFC tag.

Please also read section 2 of

https://www.kernel.org/doc/html/v5.8/process/submitting-patches.html

You should leverage existing TPM code in a way or another. Refine it so
that it scales for your purpose and then compile it into your thing
(just include the necesary C-files with relative paths).

How it is now is never going to fly.

/Jarkko
