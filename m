Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDD36ADD82
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Sep 2019 18:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbfIIQwE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Sep 2019 12:52:04 -0400
Received: from mga18.intel.com ([134.134.136.126]:44802 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727080AbfIIQwE (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Sep 2019 12:52:04 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Sep 2019 09:52:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,486,1559545200"; 
   d="scan'208";a="209025587"
Received: from pstarove-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.38.118])
  by fmsmga004.fm.intel.com with ESMTP; 09 Sep 2019 09:52:01 -0700
Date:   Mon, 9 Sep 2019 17:52:00 +0100
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com
Cc:     linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        sumit.garg@linaro.org
Subject: Re: KEYS-TRUSTED git
Message-ID: <20190909165200.npxq3hkft4bddv6v@linux.intel.com>
References: <c253ca7292b397f1352d2ee00fce0b011f84abff.camel@linux.intel.com>
 <1567952431.4614.140.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1567952431.4614.140.camel@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Sep 08, 2019 at 10:20:31AM -0400, Mimi Zohar wrote:
> Thanks, Jarkko.  Agreed, trusted keys is becoming more than just TPM
> based keys.  Now would be a good time to set up at least a separate
> branch or GIT repo.

I created a tree for trusted keys:

http://git.infradead.org/users/jjs/linux-trusted-keys.git

The remaining issue before I send a patch to update MAINTAINERS is whether
the flow goes through David to Linus or directly to Linus.

/Jarkko
