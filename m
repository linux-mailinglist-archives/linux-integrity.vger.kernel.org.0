Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3ADEB934
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Oct 2019 22:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbfJaVr6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 31 Oct 2019 17:47:58 -0400
Received: from mga09.intel.com ([134.134.136.24]:50799 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728598AbfJaVr5 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 Oct 2019 17:47:57 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2019 14:47:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,253,1569308400"; 
   d="scan'208";a="204331816"
Received: from epobrien-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.10.103])
  by orsmga006.jf.intel.com with ESMTP; 31 Oct 2019 14:47:48 -0700
Date:   Thu, 31 Oct 2019 23:47:45 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     jens.wiklander@linaro.org, dhowells@redhat.com, corbet@lwn.net,
        jejb@linux.ibm.com, zohar@linux.ibm.com, jmorris@namei.org,
        serge@hallyn.com, casey@schaufler-ca.com,
        ard.biesheuvel@linaro.org, daniel.thompson@linaro.org,
        stuart.yoder@arm.com, janne.karhunen@gmail.com,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tee-dev@lists.linaro.org
Subject: Re: [Patch v3 6/7] doc: keys: Document usage of TEE based Trusted
 Keys
Message-ID: <20191031214745.GG10507@linux.intel.com>
References: <1572530323-14802-1-git-send-email-sumit.garg@linaro.org>
 <1572530323-14802-7-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572530323-14802-7-git-send-email-sumit.garg@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 31, 2019 at 07:28:42PM +0530, Sumit Garg wrote:
> Provide documentation for usage of TEE based Trusted Keys via existing
> user-space "keyctl" utility. Also, document various use-cases.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

This is the most important commit in order for someone who don't deal
that much with ARM TEE to get right. Until this commit is right, I don't
unfortunately have much to say about other commits.

Instead of making disjoint islands, you should edit trusted-encrypted.rst
so that it describes commonalities and differences.

What the document currently describes is the usage model. It could be a
section of its own. In that you should describe first the common
parameters and separetely the backend specific parametrs.

From kernel internals (there could be a section with this name)  the
document describe the key generation e.g. is the hardware used and how
it is used, is there salting with krng and so forth.

/Jarkko
