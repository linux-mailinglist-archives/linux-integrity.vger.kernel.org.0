Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E7D1FD9E3
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2020 01:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgFQXmy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jun 2020 19:42:54 -0400
Received: from mga05.intel.com ([192.55.52.43]:58731 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726815AbgFQXmy (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jun 2020 19:42:54 -0400
IronPort-SDR: 40BbbhTC9ZFiAxo0u0lED5fgXNJmj0Z9qVqx5E3hMIylhGqR8cMoq42aXfCe4blVNdoMbJCRBN
 WqX5aITfbdUA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 16:42:54 -0700
IronPort-SDR: 6sGu3yiFjKqcz0j+xSqs6koyeBhLR4E8c6qCcb9tOy9/zCTtj2iIzKtNXO5tf9yD/xeGbh28tK
 LXQbNQiNt/Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,524,1583222400"; 
   d="scan'208";a="317670668"
Received: from kleeve-mobl.ger.corp.intel.com (HELO localhost) ([10.252.50.166])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Jun 2020 16:42:51 -0700
Date:   Thu, 18 Jun 2020 02:42:50 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v10 7/8] security: keys: trusted: add ability to specify
 arbitrary policy
Message-ID: <20200617234250.GJ62794@linux.intel.com>
References: <20200616160229.8018-1-James.Bottomley@HansenPartnership.com>
 <20200616160229.8018-8-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616160229.8018-8-James.Bottomley@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 16, 2020 at 09:02:28AM -0700, James Bottomley wrote:
> This patch adds a policy= argument to key creation.  The policy is the
> standard tss policymaker format and each separate policy line must
> have a newline after it.

Never heard of policymaker before and did not find TCG spec for it.

/Jarkko
