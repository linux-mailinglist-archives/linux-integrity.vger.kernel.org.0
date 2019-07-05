Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE3B60464
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jul 2019 12:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfGEK0K (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Jul 2019 06:26:10 -0400
Received: from mga02.intel.com ([134.134.136.20]:54147 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbfGEK0K (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Jul 2019 06:26:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2019 03:26:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,454,1557212400"; 
   d="scan'208";a="363564024"
Received: from jsakkine-mobl1.tm.intel.com ([10.237.50.189])
  by fmsmga006.fm.intel.com with ESMTP; 05 Jul 2019 03:26:07 -0700
Message-ID: <fcf497b7aa95cd6915986bc4581f10814c4d5341.camel@linux.intel.com>
Subject: Re: [PATCH] tpm: Document UEFI event log quirks
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jordan Hand <jorhand@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     tweek@google.com, matthewgarrett@google.com,
        Jonathan Corbet <corbet@lwn.net>
Date:   Fri, 05 Jul 2019 13:26:06 +0300
In-Reply-To: <dacf145d-49e0-16e5-5963-415bab1884e1@linux.microsoft.com>
References: <20190703161109.22935-1-jarkko.sakkinen@linux.intel.com>
         <dacf145d-49e0-16e5-5963-415bab1884e1@linux.microsoft.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-07-03 at 10:08 -0700, Jordan Hand wrote:
> > +This introduces another problem: nothing guarantees that it is not
> > +called before the stub gets to run. Thus, it needs to copy the final
> > +events table preboot size to the custom configuration table so that
> > +kernel offset it later on.
> 
> This doesn't really explain what the size will be used for. Matthew's 
> patch description for "tpm: Don't duplicate events from the final event 
> log in the TCG2 log" outlines this well. You could maybe word it 
> differently but I think the information is necessary:
> 
> "We can avoid this problem by looking at the size of the Final Event Log 
> just before we call ExitBootServices() and exporting this to the main 
> kernel. The kernel can then skip over all events that occured before
> ExitBootServices() and only append events that were not also logged to 
> the main log."

Not exactly sure what is missing from my paragraph. The way I see it has
more information as it states what is used at as the vessel for
exportation (the custom configuration table).

Maybe something like:

"Thus, it nees to save the final events table size at the time to the
custom configuration table so that the TPM driver can later on skip the
events generated during the preboot time."

/Jarkko

