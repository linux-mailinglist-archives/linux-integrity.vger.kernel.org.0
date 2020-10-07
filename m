Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02DB286536
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Oct 2020 18:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbgJGQuF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Oct 2020 12:50:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:1632 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbgJGQuE (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Oct 2020 12:50:04 -0400
IronPort-SDR: JBibSw9JQUkvjf8svBRGePcjX13PgvkVGMyP1SkUQ+FeUb8tcsX/L0q4USOh3rJPhm+7KaKjWb
 cgZqQQ4loD9g==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="144400703"
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; 
   d="scan'208";a="144400703"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 09:50:04 -0700
IronPort-SDR: 0f+EG1A00l6z1hUghZw9f9jpHEWqPaisY8h+zEDQzhrqtzc50Y4k340UIVEDp5Vj9XVHr7y+Cd
 Be2Be8cKTM0w==
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; 
   d="scan'208";a="528047390"
Received: from dumser-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.51.100])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 09:49:54 -0700
Date:   Wed, 7 Oct 2020 19:49:50 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Roberto Sassu <roberto.sassu@polito.it>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ima: Fix sizeof mismatches
Message-ID: <20201007164950.GA3885@linux.intel.com>
References: <20201007110243.19033-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007110243.19033-1-colin.king@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Oct 07, 2020 at 12:02:43PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> An incorrect sizeof is being used, sizeof(*fields) is not correct,
> it should be sizeof(**fields). This is not causing a problem since
> the size of these is the same. Fix this in the kmalloc_array and
> memcpy calls.
> 
> Addresses-Coverity: ("Sizeof not portable (SIZEOF_MISMATCH)")
> Fixes: 1bd7face7439 ("ima: allocate field pointers array on demand in template_desc_init_fields()")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
