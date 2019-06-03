Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E64D339BF
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Jun 2019 22:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfFCU3j (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Jun 2019 16:29:39 -0400
Received: from mga01.intel.com ([192.55.52.88]:17580 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbfFCU3j (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Jun 2019 16:29:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 13:29:38 -0700
X-ExtLoop1: 1
Received: from jgaire-mobl.ger.corp.intel.com (HELO localhost) ([10.252.20.169])
  by orsmga008.jf.intel.com with ESMTP; 03 Jun 2019 13:29:34 -0700
Date:   Mon, 3 Jun 2019 23:29:33 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: [PATCH 18/22] docs: security: trusted-encrypted.rst: fix
 code-block tag
Message-ID: <20190603202933.GB4894@linux.intel.com>
References: <cover.1559171394.git.mchehab+samsung@kernel.org>
 <9c8e63bba3c3735573ab107ffd65131db10e1d2e.1559171394.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c8e63bba3c3735573ab107ffd65131db10e1d2e.1559171394.git.mchehab+samsung@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, May 29, 2019 at 08:23:49PM -0300, Mauro Carvalho Chehab wrote:
> The code-block tag is at the wrong place, causing those
> warnings:
> 
>     Documentation/security/keys/trusted-encrypted.rst:112: WARNING: Literal block expected; none found.
>     Documentation/security/keys/trusted-encrypted.rst:121: WARNING: Unexpected indentation.
>     Documentation/security/keys/trusted-encrypted.rst:122: WARNING: Block quote ends without a blank line; unexpected unindent.
>     Documentation/security/keys/trusted-encrypted.rst:123: WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
