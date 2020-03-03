Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2D18178316
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Mar 2020 20:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbgCCTYa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Mar 2020 14:24:30 -0500
Received: from mga06.intel.com ([134.134.136.31]:47542 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728415AbgCCTYa (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Mar 2020 14:24:30 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 11:24:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="229042159"
Received: from fkuchars-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.4.236])
  by orsmga007.jf.intel.com with ESMTP; 03 Mar 2020 11:24:27 -0800
Date:   Tue, 3 Mar 2020 21:24:26 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: Re: [PATCH v6 2/6] oid_registry: Add TCG defined OIDS for TPM keys
Message-ID: <20200303192426.GB5775@linux.intel.com>
References: <20200302122759.5204-1-James.Bottomley@HansenPartnership.com>
 <20200302122759.5204-3-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302122759.5204-3-James.Bottomley@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Mar 02, 2020 at 07:27:55AM -0500, James Bottomley wrote:
> The TCG has defined an OID prefix "2.23.133.10.1" for the various TPM
> key uses.  We've defined three of the available numbers:
> 
> 2.23.133.10.1.3 TPM Loadable key.  This is an asymmetric key (Usually
> 		RSA2048 or Elliptic Curve) which can be imported by a
> 		TPM2_Load() operation.
> 
> 2.23.133.10.1.4 TPM Importable Key.  This is an asymmetric key (Usually
> 		RSA2048 or Elliptic Curve) which can be imported by a
> 		TPM2_Import() operation.
> 
> Both loadable and importable keys are specific to a given TPM, the
> difference is that a loadable key is wrapped with the symmetric
> secret, so must have been created by the TPM itself.  An importable
> key is wrapped with a DH shared secret, and may be created without
> access to the TPM provided you know the public part of the parent key.
> 
> 2.23.133.10.1.5 TPM Sealed Data.  This is a set of data (up to 128
> 		bytes) which is sealed by the TPM.  It usually
> 		represents a symmetric key and must be unsealed before
> 		use.
> 
> The ASN.1 binary key form starts of with this OID as the first element
> of a sequence, giving the binary form a unique recognizable identity
> marker regardless of encoding.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

Didn't I ack already this?

Anyway

Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
