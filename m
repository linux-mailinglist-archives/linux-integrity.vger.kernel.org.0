Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C630100B22
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Nov 2019 19:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfKRSH6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 18 Nov 2019 13:07:58 -0500
Received: from mga09.intel.com ([134.134.136.24]:52329 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbfKRSH6 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Nov 2019 13:07:58 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 10:07:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,321,1569308400"; 
   d="scan'208";a="380735807"
Received: from cooperwu-mobl.gar.corp.intel.com (HELO localhost) ([10.252.3.195])
  by orsmga005.jf.intel.com with ESMTP; 18 Nov 2019 10:07:54 -0800
Date:   Mon, 18 Nov 2019 20:07:53 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     David Binderman <dcb314@hotmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-5.4-rc8/drivers/char/tpm/tpm1-cmd.c:735: possible missing
 return value check
Message-ID: <20191118180753.GE5984@linux.intel.com>
References: <DB7PR08MB3801D9F4D5822D36E57282F39C4D0@DB7PR08MB3801.eurprd08.prod.outlook.com>
 <20191118092721.GA154812@kroah.com>
 <DB7PR08MB38017F9C07DA5D40B3133AED9C4D0@DB7PR08MB3801.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB7PR08MB38017F9C07DA5D40B3133AED9C4D0@DB7PR08MB3801.eurprd08.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Nov 18, 2019 at 09:42:01AM +0000, David Binderman wrote:
> Hello there Greg,
> 
> >Great, how about you submit a patch to resolve this?  That way you can
> >get the full credit for finding and resolveing the issue?
> 
> No thanks. I gave up bothering to send in patches when I found
> out my emails cc'ing to the linux kernel mailing list get bounced.
> I am happy for someone else to invent a patch.
> 
> BTW, more of the same here:
> 
> linux-5.4-rc8/drivers/char/tpm/tpm_infineon.c:173:10: style: Variable 'status' is reassigned a value before the old one has been used. [redundantAssignment]
> 
> 
> Regards
> 
> David

I'm fine with adding reported-by from you unless you want to send a fix.

I'll create a fix after 5.5-rc1 is out.

/Jarkko
