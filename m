Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C21FE60B54
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jul 2019 20:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfGESPv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Jul 2019 14:15:51 -0400
Received: from mga02.intel.com ([134.134.136.20]:19835 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfGESPv (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Jul 2019 14:15:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2019 11:15:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,455,1557212400"; 
   d="scan'208";a="155323175"
Received: from hsolima-mobl1.ger.corp.intel.com ([10.252.48.252])
  by orsmga007.jf.intel.com with ESMTP; 05 Jul 2019 11:15:45 -0700
Message-ID: <c891924bf40af9cf3be724687edc6c24c14c08b2.camel@linux.intel.com>
Subject: Re: [PATCH] tpm: fixes uninitialized allocated banks for IBM vtpm
 driver
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Nayna <nayna@linux.vnet.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Michal Suchanek <msuchanek@suse.de>,
        linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        George Wilson <gcwilson@linux.ibm.com>
Date:   Fri, 05 Jul 2019 21:15:43 +0300
In-Reply-To: <1270cd6ab2ceae1ad01e4b83b75fc4c6fc70027d.camel@linux.intel.com>
References: <1562211121-2188-1-git-send-email-nayna@linux.ibm.com>
         <1998ebcf-1521-778f-2c80-55ad2c855023@linux.ibm.com>
         <164b9c6e-9b6d-324d-9df8-d2f7d1ac8cfc@linux.vnet.ibm.com>
         <1270cd6ab2ceae1ad01e4b83b75fc4c6fc70027d.camel@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-07-05 at 20:50 +0300, Jarkko Sakkinen wrote:
> To summarize this patch fixes one regression and introduces two
> completely new ones...

Anyway, take the time and update it. The principle is right
anyway. I'll merge it once it is in a better shape...

/Jarkko

