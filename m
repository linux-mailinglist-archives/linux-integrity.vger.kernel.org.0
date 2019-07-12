Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F27F5672AA
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Jul 2019 17:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfGLPpO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Jul 2019 11:45:14 -0400
Received: from mga12.intel.com ([192.55.52.136]:33687 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbfGLPpO (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Jul 2019 11:45:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jul 2019 08:45:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,483,1557212400"; 
   d="scan'208";a="171588400"
Received: from yanbeibe-mobl2.ger.corp.intel.com ([10.249.32.118])
  by orsmga006.jf.intel.com with ESMTP; 12 Jul 2019 08:45:09 -0700
Message-ID: <8da29805a867935916a89891772fde77fad09396.camel@linux.intel.com>
Subject: Re: [PATCH v3] tpm: Document UEFI event log quirks
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     tweek@google.com, matthewgarrett@google.com,
        jorhand@linux.microsoft.com, Jonathan Corbet <corbet@lwn.net>,
        Sasha Levin <sashal@kernel.org>
Date:   Fri, 12 Jul 2019 18:45:07 +0300
In-Reply-To: <6c974f53-6dca-33fd-5aca-056ab8b274ed@infradead.org>
References: <20190712124912.23630-1-jarkko.sakkinen@linux.intel.com>
         <6c974f53-6dca-33fd-5aca-056ab8b274ed@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-07-12 at 07:55 -0700, Randy Dunlap wrote:
> +Before calling ExitBootServices() Linux EFI stub copies the event log to
> > +a custom configuration table defined by the stub itself. Unfortanely,
> 
> [again:]                                                    Unfortunately,

Ugh, I'm sorry. Sent an update.

/Jarkko

