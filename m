Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 247FDE63C0
	for <lists+linux-integrity@lfdr.de>; Sun, 27 Oct 2019 16:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfJ0Pfp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 27 Oct 2019 11:35:45 -0400
Received: from mga05.intel.com ([192.55.52.43]:51934 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbfJ0Pfp (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 27 Oct 2019 11:35:45 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Oct 2019 08:35:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,236,1569308400"; 
   d="scan'208";a="210719881"
Received: from moconno1-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.81.155])
  by fmsmga001.fm.intel.com with ESMTP; 27 Oct 2019 08:35:42 -0700
Date:   Sun, 27 Oct 2019 17:35:41 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm: Add major_version sysfs file
Message-ID: <20191027153541.GA5222@linux.intel.com>
References: <20191025142847.14931-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025142847.14931-1-jsnitsel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Oct 25, 2019 at 07:28:47AM -0700, Jerry Snitselaar wrote:
> Easily determining what TCG version a tpm device implements
> has been a pain point for userspace for a long time, so
> add a sysfs file to report the tcg version of a tpm device.
> 
> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Cc: Peter Huewe <peterhuewe@gmx.de>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: linux-integrity@vger.kernel.org
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>

Please use version_major (e.g. if there is ever version_minor
they order nicely alphabetically).

/Jarkko
