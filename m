Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525891FD9EA
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2020 01:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgFQXqq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jun 2020 19:46:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:33740 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbgFQXqq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jun 2020 19:46:46 -0400
IronPort-SDR: e5eRefAmeSExC2GEp4F8tnGGUpYJmquK+SwpDNq3QHBOVaQOAQc0sUi4eC1RCUcaUTn4jdq8JX
 T0Pp0ug1Tttg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 16:46:45 -0700
IronPort-SDR: SHvwl7zGWfmeRDzUZEqzqBht0T+4qGwFkbFpq9cgLQEWOLtFO4pj1TZmZtZ1YXWxNzUziBmCQZ
 2msYTaFfhEkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,524,1583222400"; 
   d="scan'208";a="262737630"
Received: from kleeve-mobl.ger.corp.intel.com (HELO localhost) ([10.252.50.166])
  by orsmga007.jf.intel.com with ESMTP; 17 Jun 2020 16:46:42 -0700
Date:   Thu, 18 Jun 2020 02:46:41 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v10 5/8] security: keys: trusted: Make sealed key
 properly interoperable
Message-ID: <20200617234641.GL62794@linux.intel.com>
References: <20200616160229.8018-1-James.Bottomley@HansenPartnership.com>
 <20200616160229.8018-6-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616160229.8018-6-James.Bottomley@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 16, 2020 at 09:02:26AM -0700, James Bottomley wrote:
> The current implementation appends a migratable flag to the end of a
> key, meaning the format isn't exactly interoperable because the using
> party needs to know to strip this extra byte.  However, all other
> consumers of TPM sealed blobs expect the unseal to return exactly the
> key.  Since TPM2 keys have a key property flag that corresponds to
> migratable, use that flag instead and make the actual key the only
> sealed quantity.  This is secure because the key properties are bound
> to a hash in the private part, so if they're altered the key won't
> load.
> 
> Backwards compatibility is implemented by detecting whether we're
> loading a new format key or not and correctly setting migratable from
> the last byte of old format keys.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
