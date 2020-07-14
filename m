Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6633C21EF51
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jul 2020 13:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgGNLcW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Jul 2020 07:32:22 -0400
Received: from mga04.intel.com ([192.55.52.120]:11815 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbgGNLcW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Jul 2020 07:32:22 -0400
IronPort-SDR: 9SvU/VmHhj1Bhtqb6bFG3qThfdr2LWmauSqfATvJ5ihOPCU5KOfai+mZamhpaPl+zH6Tstg4Dq
 5RpzArccsoUw==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="146352639"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="146352639"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 04:32:21 -0700
IronPort-SDR: mzqaSmRQma0PfCQiiYOh4Iz9toWo5pd5Fl6nhTw+7p9UBRrD/4nnN4lO4DkOmsS8o5j2J9QUdn
 PyMpsuYZMV9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="324517854"
Received: from pipper-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.46.185])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jul 2020 04:32:19 -0700
Date:   Tue, 14 Jul 2020 14:32:18 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Andrey Pronin <apronin@chromium.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH] tpm: avoid accessing cleared ops during shutdown
Message-ID: <20200714113205.GA1461506@linux.intel.com>
References: <20200710002209.6757-1-apronin@chromium.org>
 <20200710114000.GD2614@linux.intel.com>
 <CAP7wa8LfEtEATbENjr18jTXShT+YmrAoDt4k9FK1SLpxVqViog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP7wa8LfEtEATbENjr18jTXShT+YmrAoDt4k9FK1SLpxVqViog@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jul 10, 2020 at 11:25:44AM -0700, Andrey Pronin wrote:
> > Why does not tpm_del_char_device need this?
> 
> "Not" is a typo in the sentence above, right? tpm_del_char_device *does*
> need the fix. When tpm_class_shutdown is called it sets chip->ops to
> NULL. If tpm_del_char_device is called after that, it doesn't check if
> chip->ops is NULL (normal kernel API and char device API calls go
> through tpm_try_get_ops, but tpm_del_char_device doesn't) and proceeds to
> call tpm2_shutdown(), which tries sending the command and dereferences
> chip->ops.

It's a typo, yes. Sorry about that.

tpm_class_shutdown() is essentially tail of tpm_del_char_device().

To clean things up, I'd suggest dropping tpm_del_char_device() and
call tpm_class_shutdown() in tpm_chip_unregisters() along, and open
coding things that prepend it in tpm_del_char_device().

/Jarkko
