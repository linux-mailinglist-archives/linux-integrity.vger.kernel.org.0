Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF9EC439FF
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Jun 2019 17:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733080AbfFMPRx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jun 2019 11:17:53 -0400
Received: from mga09.intel.com ([134.134.136.24]:4680 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732175AbfFMPRv (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jun 2019 11:17:51 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2019 08:17:50 -0700
X-ExtLoop1: 1
Received: from bbouchn-mobl.ger.corp.intel.com (HELO localhost) ([10.252.35.22])
  by orsmga004.jf.intel.com with ESMTP; 13 Jun 2019 08:17:47 -0700
Date:   Thu, 13 Jun 2019 18:17:46 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, jens.wiklander@linaro.org,
        corbet@lwn.net, dhowells@redhat.com, jejb@linux.ibm.com,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        ard.biesheuvel@linaro.org, daniel.thompson@linaro.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tee-dev@lists.linaro.org
Subject: Re: [RFC 1/7] tee: optee: allow kernel pages to register as shm
Message-ID: <20190613151746.GD18488@linux.intel.com>
References: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
 <1560421833-27414-2-git-send-email-sumit.garg@linaro.org>
 <20190613151257.GA18488@linux.intel.com>
 <20190613151714.GC18488@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613151714.GC18488@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 13, 2019 at 06:17:14PM +0300, Jarkko Sakkinen wrote:
> On Thu, Jun 13, 2019 at 06:12:57PM +0300, Jarkko Sakkinen wrote:
> > On Thu, Jun 13, 2019 at 04:00:27PM +0530, Sumit Garg wrote:
> > > Kernel pages are marked as normal type memory only so allow kernel pages
> > > to be registered as shared memory with OP-TEE.
> > > 
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > 
> > Just out of pure interest why this was not allowed before?
> 
> Please spare me and ignore that one :-) Obviouslly because it
> was not used.
> 
> Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Actually,

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
