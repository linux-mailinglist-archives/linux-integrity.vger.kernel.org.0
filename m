Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABD4A4519A
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Jun 2019 03:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbfFNB7d (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jun 2019 21:59:33 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:45002 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfFNB7d (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jun 2019 21:59:33 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 28ACA72CA65;
        Fri, 14 Jun 2019 04:59:31 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 101954A4AE7;
        Fri, 14 Jun 2019 04:59:31 +0300 (MSK)
Date:   Fri, 14 Jun 2019 04:59:30 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 0/5] ima-avm-utils: Convert sign v2 from RSA to
 EVP_PKEY API
Message-ID: <20190614015930.k7uq5n35qxvbxtoa@altlinux.org>
References: <20190614015410.26039-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20190614015410.26039-1-vt@altlinux.org>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

Sorry for the typo in `ima-avm-utils` instead of `ima-evm-utils`. Would
you correct it if you going to apply the patches, or I can resend.

Thanks,

On Fri, Jun 14, 2019 at 04:54:05AM +0300, Vitaly Chikunov wrote:
> Changes since v3:
> - As suggested by Mimi Zohar this is v3 splitted into several patches to
>   simplify review. No code changes.
> 
> Changes since v2:
> - Just rebase over newer commits.
> 
> Changes since v1:
> - More key neutral code in calc_keyid_v1().
> - Fix uninitialized sigsize for EVP_PKEY_sign().
> - Fix memory leaks for openssl types.
> 
> Vitaly Chikunov (5):
>   ima-avm-utils: Make sure sig buffer is always MAX_SIGNATURE_SIZE
>   ima-avm-utils: Change read_pub_key to use EVP_PKEY API
>   ima-avm-utils: Change read_priv_key to use EVP_PKEY API
>   ima-evm-utils: Convert sign v2 from RSA to EVP_PKEY API
>   ima-avm-utils: Remove RSA_ASN1_templates
> 
>  src/evmctl.c    |  29 +++---
>  src/imaevm.h    |   4 +-
>  src/libimaevm.c | 269 ++++++++++++++++++++++++++------------------------------
>  3 files changed, 146 insertions(+), 156 deletions(-)
> 
> -- 
> 2.11.0
