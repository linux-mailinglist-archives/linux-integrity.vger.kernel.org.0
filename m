Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 449706213F
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jul 2019 17:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfGHPMm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Jul 2019 11:12:42 -0400
Received: from mga03.intel.com ([134.134.136.65]:17205 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbfGHPMm (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Jul 2019 11:12:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2019 08:12:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,466,1557212400"; 
   d="scan'208";a="159148707"
Received: from jsakkine-mobl1.tm.intel.com ([10.237.50.189])
  by orsmga008.jf.intel.com with ESMTP; 08 Jul 2019 08:12:37 -0700
Message-ID: <d0f07f81542abfd6579379de552e819a4e3c481d.camel@linux.intel.com>
Subject: Re: [PATCH] tpm: fixes uninitialized allocated banks for IBM vtpm
 driver
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Nayna <nayna@linux.vnet.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Sachin Sant <sachinp@linux.vnet.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Michal Suchanek <msuchanek@suse.de>
Date:   Mon, 08 Jul 2019 18:12:39 +0300
In-Reply-To: <bd961ef2-baed-8fc3-7f21-566bbcf9da8b@linux.vnet.ibm.com>
References: <1562211121-2188-1-git-send-email-nayna@linux.ibm.com>
         <1998ebcf-1521-778f-2c80-55ad2c855023@linux.ibm.com>
         <164b9c6e-9b6d-324d-9df8-d2f7d1ac8cfc@linux.vnet.ibm.com>
         <1270cd6ab2ceae1ad01e4b83b75fc4c6fc70027d.camel@linux.intel.com>
         <bd961ef2-baed-8fc3-7f21-566bbcf9da8b@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2019-07-06 at 20:25 -0400, Nayna wrote:
> Thanks Jarkko. I just now posted the v2 version that includes your and
> Stefan's feedbacks.

Looks almost legit :-)

/Jarkko

