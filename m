Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41CBF62423
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jul 2019 17:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389133AbfGHP1p (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Jul 2019 11:27:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:2353 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389130AbfGHP1p (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Jul 2019 11:27:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2019 08:27:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,466,1557212400"; 
   d="scan'208";a="363835568"
Received: from jsakkine-mobl1.tm.intel.com ([10.237.50.189])
  by fmsmga005.fm.intel.com with ESMTP; 08 Jul 2019 08:27:42 -0700
Message-ID: <47219a790c2c5b5a3ec0a331ece8956f9a82f45b.camel@linux.intel.com>
Subject: Re: [PATCH] tpm: Document UEFI event log quirks
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jordan Hand <jorhand@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     tweek@google.com, matthewgarrett@google.com,
        Jonathan Corbet <corbet@lwn.net>
Date:   Mon, 08 Jul 2019 18:27:45 +0300
In-Reply-To: <33ff21e2-1e27-cc85-0ea3-5127cb2598ba@linux.microsoft.com>
References: <20190703161109.22935-1-jarkko.sakkinen@linux.intel.com>
         <dacf145d-49e0-16e5-5963-415bab1884e1@linux.microsoft.com>
         <fcf497b7aa95cd6915986bc4581f10814c4d5341.camel@linux.intel.com>
         <33ff21e2-1e27-cc85-0ea3-5127cb2598ba@linux.microsoft.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2019-07-07 at 21:10 -0700, Jordan Hand wrote:
> > "Thus, it nees to save the final events table size at the time to the
> > custom configuration table so that the TPM driver can later on skip the
> > events generated during the preboot time."
> > 
> Yes, that sounds more clear to me.
> 
> Thanks,
> Jordan

Awesome, thank you.

/Jarkko

